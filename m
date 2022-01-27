Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3449E980
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiA0R5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:65458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244949AbiA0Rzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306140; x=1674842140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hafndCqd1tn+/XA563qswaQWce691LD6SXk8i5RzkWQ=;
  b=YOLWhpUVyja22Gr5Jyns1uDWa8dLdxKrrcSALJKUFwniQMBW7a4Bb9Oj
   gguGZpQAGE64Kv3QkctAqxtkKse0YmcFpUbNUwI4Mm4KgTRmk+TMxzD1t
   xdhgJswKLA++MNvhcW7h6uX46tecPa5ccQ7TuAHdqwiK0rQ4AXCkxJzah
   bkHl7e89xPr8fqb1uWQSaBj9FOferMngEsSh/pOvZX15BFKORDP2Kxp2O
   U5+s1ADFg6nu3Q/KPmxo408bG4I+xzifIrMahjhNgI+9HxHOIHArd+BLA
   EjYPeeEOTzZC6AD0RfiLZAJmVSXydvo1h9NVmO+NhspTDgyYCpdG3Qfxw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899143"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899143"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796200"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 40/44] memremap_pages: Add pgmap_protection_flag_invalid()
Date:   Thu, 27 Jan 2022 09:55:01 -0800
Message-Id: <20220127175505.851391-41-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some systems may be using pmem in ways that are known to be incompatible
with the PKS implementation.  One such example is the use of kmap() to
create 'global' mappings.

Rather than only reporting the invalid access on fault, provide a call
to flag those uses immediately.  This allows for a much better splat for
debugging to occur.

This is also nice because even if no invalid access' actually occurs,
the invalid mapping can be fixed with kmap_local_page() rather than
having to look for a different solution.

Define pgmap_protection_flag_invalid() and have it follow the policy set
by pks_fault_mode.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split this from the fault mode patch
---
 include/linux/mm.h | 23 +++++++++++++++++++++++
 mm/memremap.c      |  9 +++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e900df563437..3c0aa686b5bd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1162,6 +1162,7 @@ static inline bool devmap_protected(struct page *page)
 	return false;
 }
 
+void __pgmap_protection_flag_invalid(struct dev_pagemap *pgmap);
 void __pgmap_mk_readwrite(struct dev_pagemap *pgmap);
 void __pgmap_mk_noaccess(struct dev_pagemap *pgmap);
 
@@ -1178,6 +1179,27 @@ static inline bool pgmap_check_pgmap_prot(struct page *page)
 	return true;
 }
 
+/*
+ * pgmap_protection_flag_invalid - Check and flag an invalid use of a pgmap
+ *                                 protected page
+ *
+ * There are code paths which are known to not be compatible with pgmap
+ * protections.  pgmap_protection_flag_invalid() is provided as a 'relief
+ * valve' to be used in those functions which are known to be incompatible.
+ *
+ * Thus an invalid use case can be flaged with more precise data rather than
+ * just flagging a fault.  Like the fault handler code this abandons the use of
+ * the PKS key and optionally allows the calling code path to continue based on
+ * the configuration of the memremap.pks_fault_mode command line
+ * (and/or sysfs) option.
+ */
+static inline void pgmap_protection_flag_invalid(struct page *page)
+{
+	if (!pgmap_check_pgmap_prot(page))
+		return;
+	__pgmap_protection_flag_invalid(page->pgmap);
+}
+
 static inline void pgmap_mk_readwrite(struct page *page)
 {
 	if (!pgmap_check_pgmap_prot(page))
@@ -1200,6 +1222,7 @@ bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
 
 static inline void __pgmap_mk_readwrite(struct dev_pagemap *pgmap) { }
 static inline void __pgmap_mk_noaccess(struct dev_pagemap *pgmap) { }
+static inline void pgmap_protection_flag_invalid(struct page *page) { }
 static inline void pgmap_mk_readwrite(struct page *page) { }
 static inline void pgmap_mk_noaccess(struct page *page) { }
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 783b1cd4bb42..fd4b9b83b770 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -150,6 +150,15 @@ static const struct kernel_param_ops param_ops_pks_fault_modes = {
 	__param_check(name, p, pks_fault_modes)
 module_param(pks_fault_mode, pks_fault_modes, 0644);
 
+void __pgmap_protection_flag_invalid(struct dev_pagemap *pgmap)
+{
+	if (pks_fault_mode == PKS_MODE_STRICT)
+		return;
+
+	WARN_ONCE(1, "Invalid page map use");
+}
+EXPORT_SYMBOL_GPL(__pgmap_protection_flag_invalid);
+
 bool pgmap_pks_fault_callback(struct pt_regs *regs, unsigned long address,
 			      bool write)
 {
-- 
2.31.1

