Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D24649E983
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiA0R5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:65462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244955AbiA0Rzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306141; x=1674842141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ikBmsVH9URVUPs2BMCiled8q5lxWUT7V1EgXuZO4LQk=;
  b=LciAOr7xX54kw2XFuLEspXwXgh/hHhkro2OPN2dwqbj8tsgn2re3bIkR
   fv3LVPUZDDlkI4PobHXWRHARTRfxf49kG7I4DmUuU/3STEaKfH+6Ek/D/
   gMeLaB+RzCkRlZmGpTlal16iC2ds8EJ0FiMgFIKNFsp53phsUeQTE6N5i
   mZXjggKgHZIbCaMkZpEq5CahV2/kYFvf0DLRpeDLo7VhRzodDNleGFm4K
   lR6CruPF6r/1tUCtIPLoz4Kk3C9I92c34wPTFUPWDCTQ7jO1GCslJX9nQ
   2BMBE68lYyXmAkFd/lfgSuRs9NYr/iKzU18+btpK4t5kev5oMtf3wg6WJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899145"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796204"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 41/44] kmap: Ensure kmap works for devmap pages
Date:   Thu, 27 Jan 2022 09:55:02 -0800
Message-Id: <20220127175505.851391-42-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Users of devmap pages should not have to know that the pages they are
operating on are special.

Co-opt the kmap_{local_page,atomic}() to mediate access to PKS protected
pages via the devmap facility.  kmap_{local_page,atomic}() are both
thread local mappings so they work well with the thread specific
protections available.

kmap(), on the other hand, allows for global mappings to be established,
Which is incompatible with the underlying PKS facility.  For this reason
kmap() is not supported.  Rather than leave the kmap mappings to fault
at random times when users may access them, call
pgmap_protection_flag_invalid() to show kmap() users the call stack of
where mapping was created.  This allows better debugging.

This behavior is safe because neither of the 2 current DAX-capable
filesystems (ext4 and xfs) perform such global mappings.  And known
device drivers that would handle devmap pages are not using kmap().  Any
future filesystems that gain DAX support, or device drivers wanting to
support devmap protected pages will need to use kmap_local_page().

Direct-map exposure is already mitigated by default on HIGHMEM systems
because by definition HIGHMEM systems do not have large capacities of
memory in the direct map.  And using kmap in those systems actually
creates a separate mapping.  Therefore, to reduce complexity HIGHMEM
systems are not supported.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Reword commit message
---
 include/linux/highmem-internal.h | 5 +++++
 mm/Kconfig                       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 0a0b2b09b1b8..1a006558734c 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -159,6 +159,7 @@ static inline struct page *kmap_to_page(void *addr)
 static inline void *kmap(struct page *page)
 {
 	might_sleep();
+	pgmap_protection_flag_invalid(page);
 	return page_address(page);
 }
 
@@ -174,6 +175,7 @@ static inline void kunmap(struct page *page)
 
 static inline void *kmap_local_page(struct page *page)
 {
+	pgmap_mk_readwrite(page);
 	return page_address(page);
 }
 
@@ -197,6 +199,7 @@ static inline void __kunmap_local(void *addr)
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
+	pgmap_mk_noaccess(kmap_to_page(addr));
 }
 
 static inline void *kmap_atomic(struct page *page)
@@ -206,6 +209,7 @@ static inline void *kmap_atomic(struct page *page)
 	else
 		preempt_disable();
 	pagefault_disable();
+	pgmap_mk_readwrite(page);
 	return page_address(page);
 }
 
@@ -224,6 +228,7 @@ static inline void __kunmap_atomic(void *addr)
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
+	pgmap_mk_noaccess(kmap_to_page(addr));
 	pagefault_enable();
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_enable();
diff --git a/mm/Kconfig b/mm/Kconfig
index 67e0264acf7d..d537679448ae 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -779,6 +779,7 @@ config ZONE_DEVICE
 config DEVMAP_ACCESS_PROTECTION
 	bool "Access protection for memremap_pages()"
 	depends on NVDIMM_PFN
+	depends on !HIGHMEM
 	depends on ARCH_HAS_SUPERVISOR_PKEYS
 	select ARCH_ENABLE_SUPERVISOR_PKEYS
 	default y
-- 
2.31.1

