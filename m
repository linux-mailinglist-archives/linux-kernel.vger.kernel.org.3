Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF049E97D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245323AbiA0R4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:65504 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244769AbiA0Rzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306133; x=1674842133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OakK5azFAZtRgEn1SDscsdM2loliiFcrxNWheUTy0fE=;
  b=f7sM8AlOPADn4RQw2g7vqXZowDO2IoWn3erMqYmwEtNTOlXEBS4xYm2X
   m8vHjGfY0A8eefwVAzKhpHqh7nApzXmL0W7D5Hpr+xWBakrwqt69VMhzI
   7FxGvIqDtsOMTqmpxE2j1MQiardWlmGsXQv1o9+3H5oC7GTRYoZgafb8r
   /txNCd5MDmn/NQGtaKGSXRDTaBGGs8AnRPiDXAUXSWX2GqPoEMVY6tcWq
   pW8dm/6TlkP9qMcBwr0vou9TbSy+Wdn8hUoeo0vdu6s2T6n3lanFdujoC
   9qwlU8pC4iXAtx/dHspz66hQjrkQiqwaWYV28oBcLhqBNtCcmtPMTWc24
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899138"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796189"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 38/44] memremap_pages: Define pgmap_mk_{readwrite|noaccess}() calls
Date:   Thu, 27 Jan 2022 09:54:59 -0800
Message-Id: <20220127175505.851391-39-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Users will need a way to flag valid access to pages which have been
protected with PGMAP protections.  Provide this by defining pgmap_mk_*()
accessor functions.

pgmap_mk_{readwrite|noaccess}() take a struct page for convenience.
They determine if the page is protected by dev_pagemap protections.  If
so, they perform the requested operation.

In addition, the lower level __pgmap_* functions are exported.  They
take the dev_pagemap object directly for internal users who have
knowledge of the of the dev_pagemap.

All changes in the protections must be through the above calls.  They
abstract the protection implementation (currently the PKS api) from the
upper layer users.

Furthermore, the calls are nestable by the use of a per task reference
count.  This ensures that the first call to re-enable protection does
not 'break' the last access of the device memory.

Access to device memory during exceptions (#PF) is expected only from
user faults.  Therefore there is no need to maintain the reference count
when entering or exiting exceptions.  However, reference counting will
occur during the exception.  Recall that protection is automatically
enabled during exceptions by the PKS core.[1]

NOTE: It is not anticipated that any code paths will directly nest these
calls.  For this reason multiple reviewers, including Dan and Thomas,
asked why this reference counting was needed at this level rather than
in a higher level call such as kmap_{atomic,local_page}().  The reason
is that pgmap_mk_readwrite() could nest with regards to other callers of
pgmap_mk_*() such as kmap_{atomic,local_page}().  Therefore push this
reference counting to the lower level and just ensure that these calls
are nestable.

[1] https://lore.kernel.org/lkml/20210401225833.566238-9-ira.weiny@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split these functions into their own patch.
		This helps to clarify the commit message and usage.
---
 include/linux/mm.h    | 34 ++++++++++++++++++++++++++++++++++
 include/linux/sched.h |  7 +++++++
 init/init_task.c      |  3 +++
 mm/memremap.c         | 14 ++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6e4a2758e3d3..60044de77c54 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1162,10 +1162,44 @@ static inline bool devmap_protected(struct page *page)
 	return false;
 }
 
+void __pgmap_mk_readwrite(struct dev_pagemap *pgmap);
+void __pgmap_mk_noaccess(struct dev_pagemap *pgmap);
+
+static inline bool pgmap_check_pgmap_prot(struct page *page)
+{
+	if (!devmap_protected(page))
+		return false;
+
+	/*
+	 * There is no known use case to change permissions in an irq for pgmap
+	 * pages
+	 */
+	lockdep_assert_in_irq();
+	return true;
+}
+
+static inline void pgmap_mk_readwrite(struct page *page)
+{
+	if (!pgmap_check_pgmap_prot(page))
+		return;
+	__pgmap_mk_readwrite(page->pgmap);
+}
+static inline void pgmap_mk_noaccess(struct page *page)
+{
+	if (!pgmap_check_pgmap_prot(page))
+		return;
+	__pgmap_mk_noaccess(page->pgmap);
+}
+
 bool pgmap_protection_available(void);
 
 #else
 
+static inline void __pgmap_mk_readwrite(struct dev_pagemap *pgmap) { }
+static inline void __pgmap_mk_noaccess(struct dev_pagemap *pgmap) { }
+static inline void pgmap_mk_readwrite(struct page *page) { }
+static inline void pgmap_mk_noaccess(struct page *page) { }
+
 static inline bool pgmap_protection_available(void)
 {
 	return false;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..5020ed7e67b7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1492,6 +1492,13 @@ struct task_struct {
 	struct callback_head		l1d_flush_kill;
 #endif
 
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+	/*
+	 * NOTE: pgmap_prot_count is modified within a single thread of
+	 * execution.  So it does not need to be atomic_t.
+	 */
+	u32                             pgmap_prot_count;
+#endif
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..948b32cf8139 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -209,6 +209,9 @@ struct task_struct init_task
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+	.pgmap_prot_count = 0,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/mm/memremap.c b/mm/memremap.c
index d3e6f328a711..b75c4f778c59 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -96,6 +96,20 @@ static void devmap_protection_disable(void)
 	static_branch_dec(&dev_pgmap_protection_static_key);
 }
 
+void __pgmap_mk_readwrite(struct dev_pagemap *pgmap)
+{
+	if (!current->pgmap_prot_count++)
+		pks_mk_readwrite(PKS_KEY_PGMAP_PROTECTION);
+}
+EXPORT_SYMBOL_GPL(__pgmap_mk_readwrite);
+
+void __pgmap_mk_noaccess(struct dev_pagemap *pgmap)
+{
+	if (!--current->pgmap_prot_count)
+		pks_mk_noaccess(PKS_KEY_PGMAP_PROTECTION);
+}
+EXPORT_SYMBOL_GPL(__pgmap_mk_noaccess);
+
 bool pgmap_protection_available(void)
 {
 	return pks_available();
-- 
2.31.1

