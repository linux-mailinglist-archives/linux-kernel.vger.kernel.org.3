Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF44D503C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244983AbiCJRYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245099AbiCJRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A65199D44
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932918; x=1678468918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fO8qnSqN2HcxbaiLonyOKnvoJCiJMAh2Vw5V5V62u6c=;
  b=K0epuU9ukSmTltgkeVcj3ZGopTTzLk3rD4TtYA2qUal/Uh339TOqoaLR
   8C0qXDe7E7Uv0yrYwaiOQl8MUnkH5nM1QW6IHHr2Om85iBsDMVTlCpcRD
   Rc8+IwbMHMS4Ipy6WBTk9YiXoO9AGu5n5DPx8blW3TxSdpRF0oDccVE9p
   b6uqoWHfrHGRkNHqI9HPx1h4Z5cKd8Ty004VCjbRLK7I7Es+VsBIfY10q
   PYfmDlhN960GkFQc2y7osAt4+F5q7WPvmdpZLfJbtPQH/1irn//pVvcYO
   ryHTnB5qeqH2qHaVyNcpTSg6HmxlmPbtRJffetJuYE9q6WrlOtQJw3QKA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318536659"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="318536659"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="578874854"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:57 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 42/45] kmap: Make kmap work for devmap protected pages
Date:   Thu, 10 Mar 2022 09:20:16 -0800
Message-Id: <20220310172019.850939-43-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Today, kmap_{local_page,atomic}() handle granting access to HIGHMEM
pages without the caller needing to know if the page is HIGHMEM, or not.
Use that existing infrastructure to grant access to PGMAP (PKS)
protected pages.

kmap_{local_page,atomic}() are both thread local mappings so they work
well with the thread specific protections available within PKS.

On the other hand, the kmap() call is not changed.  kmap() allows for a
mapping to be shared with other threads, while PKS protections operate
on a thread local basis.  For this reason, and the desire to move away
from mappings like this, kmap() is left unsupported.

This behavior is safe because neither of the 2 current DAX-capable
filesystems (ext4 and xfs) perform such global mappings.  And known
device drivers that would handle devmap pages are not using kmap().  Any
future filesystems that gain DAX support, or device drivers wanting to
support devmap protected pages will need to use kmap_local_page().

Note: HIGHMEM support is mutually exclusive with PGMAP protection.  The
rationale is mainly to reduce complexity, but also because direct-map
exposure is already mitigated by default on HIGHMEM systems because
by definition HIGHMEM systems do not have large capacities of memory
in the direct map.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	From Dan Williams
		Update commit message
			Clarify why kmap is not 'compatible' with PKS
			Explain the HIGHMEM system exclusion more
	Remove pgmap_protection_flag_invalid() from kmap
	s/pks_mk*/pks_set*/

Changes for V8
	Reword commit message
---
 include/linux/highmem-internal.h | 4 ++++
 mm/Kconfig                       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 0a0b2b09b1b8..71605cf6044b 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -174,6 +174,7 @@ static inline void kunmap(struct page *page)
 
 static inline void *kmap_local_page(struct page *page)
 {
+	pgmap_set_readwrite(page);
 	return page_address(page);
 }
 
@@ -197,6 +198,7 @@ static inline void __kunmap_local(void *addr)
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
+	pgmap_set_noaccess(kmap_to_page(addr));
 }
 
 static inline void *kmap_atomic(struct page *page)
@@ -206,6 +208,7 @@ static inline void *kmap_atomic(struct page *page)
 	else
 		preempt_disable();
 	pagefault_disable();
+	pgmap_set_readwrite(page);
 	return page_address(page);
 }
 
@@ -224,6 +227,7 @@ static inline void __kunmap_atomic(void *addr)
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
+	pgmap_set_noaccess(kmap_to_page(addr));
 	pagefault_enable();
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_enable();
diff --git a/mm/Kconfig b/mm/Kconfig
index ba8a557dcf81..4e33ff11b7a9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -779,6 +779,7 @@ config ZONE_DEVICE
 config DEVMAP_ACCESS_PROTECTION
 	bool "Access protection for memremap_pages()"
 	depends on NVDIMM_PFN
+	depends on !HIGHMEM
 	depends on ARCH_HAS_SUPERVISOR_PKEYS
 	select ARCH_ENABLE_PKS_CONSUMER
 	default n
-- 
2.35.1

