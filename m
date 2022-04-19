Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68BE50762B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356092AbiDSRMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355583AbiDSRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F715F5B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388033; x=1681924033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSg1SSR8/uHeBlXU/TSHBEVrfJclqHVfsxA9NRaiIU8=;
  b=SIwhqX2sfCv5mNWsMVa2M4/fwflup2jIUjVP8idQPfP8D4Nve6ELsBk7
   uw9+S4l+b2/SI4gYxAS+uObZ10ebqEC6HZthSsn8y030veiHgLOqfbABk
   CPe2wzsVtk96J/N+Shu9YH9gHmzp0VcP++N7/qMlHOgBfwcPeG928eyik
   IUxUVLGHFMATDbGzZmCJMfLruBJRXwmVupB1/sTevCSkQx31dH4g4vqNj
   i/c8aYDHlX7xq1RtjRtIc8gXcmmh+Ize8SYtMf1R4lZ0qGc1tu6uNTQph
   E2aevjIsm6umQ5+skMJxouuvXgC95YPG/uNIJ92Ta4ngH26KEfmpTyIDw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350267618"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="350267618"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="727145550"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:12 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 27/44] memremap_pages: Introduce a PGMAP_PROTECTION flag
Date:   Tue, 19 Apr 2022 10:06:32 -0700
Message-Id: <20220419170649.1022246-28-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The persistent memory (PMEM) driver uses the memremap_pages facility to
provide 'struct page' metadata (vmemmap) for PMEM.  Given that PMEM
capacity maybe orders of magnitude higher capacity than System RAM it
presents a large vulnerability surface to stray writes.  Unlike stray
writes to System RAM, which may result in a crash or other undesirable
behavior, stray writes to PMEM additionally are more likely to result in
permanent data loss. Reboot is not a remediation for PMEM corruption
like it is for System RAM.

Given that PMEM access from the kernel is limited to a constrained set
of locations (PMEM driver, Filesystem-DAX, and direct-I/O to a DAX
page), it is amenable to supervisor pkey protection.

Some systems which have configured DEVMAP_ACCESS_PROTECTION may not have
PMEM installed.  Or the PMEM may not be mapped into the direct map.  In
addition, some callers of memremap_pages() will not want the mapped
pages protected.

Define a new PGMAP flag to distinguish page maps which are protected.
Use this flag to enable runtime protection support.  A static key is
used to optimize the runtime support.

Specifying this flag on a system which can't support protections will
fail.  Callers are expected to check if protections are supported via
pgmap_protection_available().  It was considered to have callers specify
the flag and check if the dev_pagemap object returned was protected or
not.  But this was considered less efficient than a direct check
beforehand.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Clean up commit message

Changes for V8
	Split this out into it's own patch
---
 include/linux/memremap.h |  1 +
 mm/memremap.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 7980d0db8617..02c415b1b278 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -83,6 +83,7 @@ struct dev_pagemap_ops {
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
+#define PGMAP_PROTECTION	(1 << 1)
 
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
diff --git a/mm/memremap.c b/mm/memremap.c
index af0223605e69..4dfb3025cee3 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -62,6 +62,37 @@ static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
 }
 #endif /* CONFIG_FS_DAX */
 
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+
+/*
+ * Note; all devices which have asked for protections share the same key.  The
+ * key may, or may not, have been provided by the core.  If not, protection
+ * will be disabled.  The key acquisition is attempted when the first ZONE
+ * DEVICE requests it and freed when all zones have been unmapped.
+ *
+ * Also this must be EXPORT_SYMBOL rather than EXPORT_SYMBOL_GPL because it is
+ * intended to be used in the kmap API.
+ */
+DEFINE_STATIC_KEY_FALSE(dev_pgmap_protection_static_key);
+EXPORT_SYMBOL(dev_pgmap_protection_static_key);
+
+static void devmap_protection_enable(void)
+{
+	static_branch_inc(&dev_pgmap_protection_static_key);
+}
+
+static void devmap_protection_disable(void)
+{
+	static_branch_dec(&dev_pgmap_protection_static_key);
+}
+
+#else /* !CONFIG_DEVMAP_ACCESS_PROTECTION */
+
+static void devmap_protection_enable(void) { }
+static void devmap_protection_disable(void) { }
+
+#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
+
 static void pgmap_array_delete(struct range *range)
 {
 	xa_store_range(&pgmap_array, PHYS_PFN(range->start), PHYS_PFN(range->end),
@@ -148,6 +179,9 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 	devmap_managed_enable_put(pgmap);
+
+	if (pgmap->flags & PGMAP_PROTECTION)
+		devmap_protection_disable();
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -295,6 +329,12 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
 		return ERR_PTR(-EINVAL);
 
+	if (pgmap->flags & PGMAP_PROTECTION) {
+		if (!pgmap_protection_available())
+			return ERR_PTR(-EINVAL);
+		devmap_protection_enable();
+	}
+
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
-- 
2.35.1

