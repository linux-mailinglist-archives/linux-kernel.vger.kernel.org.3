Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2621149E97B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244829AbiA0R4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:65467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244790AbiA0Rzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306132; x=1674842132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=puOiWo8xjIdHJixtihA0/Z9lYqbmqzZHdIoTKArXNfE=;
  b=UT/GE7drUvW6Aw8/Gh2LYeYSxv07oAUE6I6jktmoNlCWRbDo698MoagF
   5wJ75W71XxoMGIZJx2Y2JUJD0KK74eBb6wooUG/ncjmZEDXgr7io4cOEd
   9QHA01wB5OVuO6FnxcKMAdIgjdT8WFpP8soGj6LZ/qUcukziIpCa6PLCy
   vkKkOPk5Dh2JfiH/wyy4ll5NvK2CZB7ucWVkCiG3G8zE7/utHZU1vMAGz
   ZFT9ZgQFIbwjiLaVUcepCqOVJrr1FNy2Mp7mEhi5Q2J25z8ZZT251bcFN
   6klyHR76l1q6CYvDMSUwyOlKUsa9hGB9IJole4mgHo7xf3mPABUxsGY2f
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899131"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796173"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 34/44] memremap_pages: Introduce a PGMAP_PROTECTION flag
Date:   Thu, 27 Jan 2022 09:54:55 -0800
Message-Id: <20220127175505.851391-35-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some systems which have enabled DEVMAP_ACCESS_PROTECTION may not have
PMEM installed.  Or the PMEM may not be mapped into the direct map.

Also users other than PMEM of memremap_pages() will not want these pages
protected.

Define a new PGMAP flag, PGMAP_PROTECTION.  This can be passed in
(struct dev_pagemap)->flags when calling memremap_pages() to request
that the pages be protected.  Then use the flag to enable a static key.
The static key is used to optimize the protection away if no callers are
currently using protections.

Specifying this flag on a system which can't support protections will
fail.  Users are expected to check if protections are supported via
pgmap_protection_available() prior to asking for them.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split this out into it's own patch
---
 include/linux/memremap.h |  1 +
 mm/memremap.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1fafcc38acba..84402f73712c 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -80,6 +80,7 @@ struct dev_pagemap_ops {
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
+#define PGMAP_PROTECTION	(1 << 1)
 
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
diff --git a/mm/memremap.c b/mm/memremap.c
index c13b3b8a0048..a74d985a1908 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -66,12 +66,39 @@ static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
 
 #ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
 
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
 bool pgmap_protection_available(void)
 {
 	return pks_available();
 }
 EXPORT_SYMBOL_GPL(pgmap_protection_available);
 
+#else /* !CONFIG_DEVMAP_ACCESS_PROTECTION */
+
+static void devmap_protection_enable(void) { }
+static void devmap_protection_disable(void) { }
+
 #endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
 
 static void pgmap_array_delete(struct range *range)
@@ -173,6 +200,9 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 	devmap_managed_enable_put(pgmap);
+
+	if (pgmap->flags & PGMAP_PROTECTION)
+		devmap_protection_disable();
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -319,6 +349,12 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
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
2.31.1

