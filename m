Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246BF50761E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355897AbiDSRLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343836AbiDSRKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F50C1164
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388037; x=1681924037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzuyO7S2Ekg+g7XHoS8vhO/ifVxDTWKb+avzh6c7FFM=;
  b=ZodC3dqXByJS8k+TtY/lFmPAvcDm5mikucM1js787jV/Bwa+4Awuf1Bu
   h6etn0JQrmtXqhumXNFyLrn0y47IjMcSvSvLohOXyXHsy/mFAOLgeHAEm
   oHH04r9je2qB96zN49qfldrTLyuF5Ob5tnzb827SqAPjLz3rdd7zP3Wok
   odA+bA10NDAJyi7qh4zEJFKDfbLhNxe8eE/Hx3tICsmBj8cP29/MGMm4U
   P65GTXIZcXSOj722jW2g9cRqebxlruA50WF8IpDKGRatf0jCZQzfAuFLk
   KLpSn1tUCFXepLkSEYPXpd7/o28QfjbRtP31mNGw0fozEMQTGePaQEOwF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324261496"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="324261496"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530498895"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:16 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 31/44] memremap_pages: Define pgmap_set_{readwrite|noaccess}() calls
Date:   Tue, 19 Apr 2022 10:06:36 -0700
Message-Id: <20220419170649.1022246-32-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

A thread that wants to access memory protected by PGMAP protections must
first enable access, and then disable access when it is done.

Introduce pgmap_set_{readwrite|noaccess}() for this purpose.  The two
calls are destined to be used by the kmap API and take a struct page for
convenience.  They determine if the page is protected and, if so,
perform the requested operation.

Toggling between Read/Write and No Access was chosen as it fits well
with the accessibility of a kmap'ed page.  Discussions did occur
regarding making a finer grained mapping for Read Only but that is
something which can be added at a later date.

In addition, two lower level functions are exported.  They take the
dev_pagemap object directly for internal consumers who have knowledge of
the of the dev_pagemap.

All changes in the protections must be through the above calls.  They
abstract the protection implementation (currently the PKS API) from
upper layer consumers.

The calls are made nestable by the use of a per task reference count.
This ensures that the first call to re-enable protection does not
'break' the last access of the device memory.  Expansion of the task
struct is unavoidable due to the desire to maintain kmap_local_page() as
non-atomic and migratable.  The only other idea to track a reference
count was in a per-cpu variable.  However, doing so would make
kmap_local_page() equivalent to kmap_atomic() which is undesirable.

Access to device memory during exceptions (#PF) is expected only from
user faults.  Therefore there is no need to maintain the reference count
during exceptions.

NOTE: It is not anticipated that any code path will directly nest these
calls.  For this reason multiple reviewers, including Dan and Thomas,
asked why this reference counting was needed at this level rather than
in a higher level call such as kmap_local_page().  The reason is that
pgmap_set_readwrite() can nest with kmap_{atomic,local_page}().
Therefore this reference counting is pushed to the lower level to ensure
that any combination of calls is nestable.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V10
	Move code from mm.h to memremap.h
		Upstream separated memremap.h functionality from mm.h
		dc90f0846df4 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")

Changes for V9
	From Dan Williams
		Update the commit message with details on why the thread
			struct needs to be expanded.
	Following on Dave Hansens suggestion for pks_mk
		s/pgmap_mk_*/pgmap_set_*/

Changes for V8
	Split these functions into their own patch.
		This helps to clarify the commit message and usage.
---
 include/linux/memremap.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/sched.h    |  7 +++++++
 init/init_task.c         |  3 +++
 mm/memremap.c            | 14 ++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 6325f00096ec..1012c6c4c664 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -240,8 +240,43 @@ static inline bool devmap_protected(struct page *page)
 	return false;
 }
 
+void __pgmap_set_readwrite(struct dev_pagemap *pgmap);
+void __pgmap_set_noaccess(struct dev_pagemap *pgmap);
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
+static inline void pgmap_set_readwrite(struct page *page)
+{
+	if (!pgmap_check_pgmap_prot(page))
+		return;
+	__pgmap_set_readwrite(page->pgmap);
+}
+
+static inline void pgmap_set_noaccess(struct page *page)
+{
+	if (!pgmap_check_pgmap_prot(page))
+		return;
+	__pgmap_set_noaccess(page->pgmap);
+}
+
 #else
 
+static inline void __pgmap_set_readwrite(struct dev_pagemap *pgmap) { }
+static inline void __pgmap_set_noaccess(struct dev_pagemap *pgmap) { }
+static inline void pgmap_set_readwrite(struct page *page) { }
+static inline void pgmap_set_noaccess(struct page *page) { }
+
 static inline bool pgmap_protection_available(void)
 {
 	return false;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d5e3c00b74e1..7da0d2a0ac74 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1498,6 +1498,13 @@ struct task_struct {
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
index 215ab9c51917..491bb49255ae 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -94,6 +94,20 @@ static void devmap_protection_disable(void)
 	static_branch_dec(&dev_pgmap_protection_static_key);
 }
 
+void __pgmap_set_readwrite(struct dev_pagemap *pgmap)
+{
+	if (!current->pgmap_prot_count++)
+		pks_set_readwrite(PKS_KEY_PGMAP_PROTECTION);
+}
+EXPORT_SYMBOL_GPL(__pgmap_set_readwrite);
+
+void __pgmap_set_noaccess(struct dev_pagemap *pgmap)
+{
+	if (!--current->pgmap_prot_count)
+		pks_set_noaccess(PKS_KEY_PGMAP_PROTECTION);
+}
+EXPORT_SYMBOL_GPL(__pgmap_set_noaccess);
+
 #else /* !CONFIG_DEVMAP_ACCESS_PROTECTION */
 
 static void devmap_protection_enable(void) { }
-- 
2.35.1

