Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8493B49E989
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiA0R6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:58:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:19418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244940AbiA0R4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306160; x=1674842160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h0ELtLaLvU8d5+IR+z+6tOFYz1WyWnwDtWsLq4wETwc=;
  b=UCaenWA+v6F3cRkgIaOLC83zozXc9GYTcNqeiy3IqeKTX2PfqbWmqtXY
   VghJyNmu4xpcN5wmB+6N0N18/kePRIwXFumDIF+zVFs7ILT7hUb2TlwHL
   Sc/K5iLmFwMOz85kL0gqaWi3vuUPKT0MwxjwW7JVovPdsU4y8mHrb33PP
   MzMqPtFnyESDlmvdu7choSs7lsfOqiTI0aWuFZFtxEF8601fAqPJcz17c
   0BF/xnElGfDp0VLSrOGsQPf/vjJrmobe++auVYxnfpCQ+vL7wFYx5tu/C
   alDMuNunr79HXNkn2BxTL9V36LpRi6MODtoJ6HOkG52ys4xTlDVtgVqfb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302451"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302451"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796169"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 33/44] memremap_pages: Introduce pgmap_protection_available()
Date:   Thu, 27 Jan 2022 09:54:54 -0800
Message-Id: <20220127175505.851391-34-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Users will need to specify that they want their dev_pagemap pages
protected by specifying a flag in (struct dev_pagemap)->flags.  However,
it is more efficient to know if that protection is available prior to
requesting it and failing the mapping.

Define pgmap_protection_available() for users to check if protection is
available to be used.  The name of pgmap_protection_available() was
specifically chosen to isolate the implementation of the protection from
higher level users.  However, the current implementation simply calls
pks_available() to determine if it can support protection.

It was considered to have users specify the flag and check if the
dev_pagemap object returned was protected or not.  But this was
considered less efficient than a direct check beforehand.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split this out to it's own patch.
	s/pgmap_protection_enabled/pgmap_protection_available
---
 include/linux/mm.h | 13 +++++++++++++
 mm/memremap.c      | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..2ae99bee6e82 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1143,6 +1143,19 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+
+bool pgmap_protection_available(void);
+
+#else
+
+static inline bool pgmap_protection_available(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
+
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
diff --git a/mm/memremap.c b/mm/memremap.c
index 6aa5f0c2d11f..c13b3b8a0048 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -6,6 +6,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
 #include <linux/pfn_t.h>
+#include <linux/pkeys.h>
 #include <linux/swap.h>
 #include <linux/mmzone.h>
 #include <linux/swapops.h>
@@ -63,6 +64,16 @@ static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
 }
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+
+bool pgmap_protection_available(void)
+{
+	return pks_available();
+}
+EXPORT_SYMBOL_GPL(pgmap_protection_available);
+
+#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
+
 static void pgmap_array_delete(struct range *range)
 {
 	xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
-- 
2.31.1

