Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48450762D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356065AbiDSRMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355636AbiDSRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9121B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388039; x=1681924039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5sapg/ecq+xu8Oubfcjw4YPepAu8QZrx7Lb+rmPQxjM=;
  b=JPqlf9jqlpc9DFuWyF9l+X+b7YtxyeDonYLSrLMmdccnOGZLyr5jXafg
   SjZRHJDBFhxpQwvdBKg6isxujK9YP4uZNAK9EQmWsGwJxi4Ze8owtG7Ap
   AaaiuNAD0idKXa/b2T8Q3G985SIyXI5GdTlVef4VnwOY/D3wHNe71na+c
   x/MLWm7e7khHet7WoHMbnFC8CBTqpaGMcm+4sRI8JQgl+NpPYC9Q+rVVH
   HSoD9EUy2q13lFYQY/VmMHVXdtbT6czTwL367RPE0P6n9Juf2rXqA3SB6
   FnrFDdtUu2Nb8LmX/Fe3UKcH5ZJ1a8p4jyop9KLraguFh39mmR0bqMchi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991916"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991916"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="529397323"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:18 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 33/44] kmap: Make kmap work for devmap protected pages
Date:   Tue, 19 Apr 2022 10:06:38 -0700
Message-Id: <20220419170649.1022246-34-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Changes for V10
	Include memremap.h because of upstream rework

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
 include/linux/highmem-internal.h | 6 ++++++
 mm/Kconfig                       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index a77be5630209..32ed07c2994b 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -151,6 +151,8 @@ static inline void totalhigh_pages_add(long count)
 
 #else /* CONFIG_HIGHMEM */
 
+#include <linux/memremap.h>
+
 static inline struct page *kmap_to_page(void *addr)
 {
 	return virt_to_page(addr);
@@ -174,6 +176,7 @@ static inline void kunmap(struct page *page)
 
 static inline void *kmap_local_page(struct page *page)
 {
+	pgmap_set_readwrite(page);
 	return page_address(page);
 }
 
@@ -197,6 +200,7 @@ static inline void __kunmap_local(void *addr)
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
+	pgmap_set_noaccess(kmap_to_page(addr));
 }
 
 static inline void *kmap_atomic(struct page *page)
@@ -206,6 +210,7 @@ static inline void *kmap_atomic(struct page *page)
 	else
 		preempt_disable();
 	pagefault_disable();
+	pgmap_set_readwrite(page);
 	return page_address(page);
 }
 
@@ -224,6 +229,7 @@ static inline void __kunmap_atomic(void *addr)
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
+	pgmap_set_noaccess(kmap_to_page(addr));
 	pagefault_enable();
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_enable();
diff --git a/mm/Kconfig b/mm/Kconfig
index fe1752e6e76c..616baee3f62d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -800,6 +800,7 @@ config ZONE_DEVICE
 config DEVMAP_ACCESS_PROTECTION
 	bool "Access protection for memremap_pages()"
 	depends on NVDIMM_PFN
+	depends on !HIGHMEM
 	depends on ARCH_HAS_SUPERVISOR_PKEYS
 	select ARCH_ENABLE_PKS_CONSUMER
 	default n
-- 
2.35.1

