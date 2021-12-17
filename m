Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941374796C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhLQWBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:01:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:26492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhLQWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778508; x=1671314508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uaN1ppSyx00sbK+6ZvuNPJeDvV+BViDU9aY3XKLPb00=;
  b=Q+/l72Q9SCvBqxBn5IbdJhsnY/9wrlD79ITObOhoG48Ht7VAfttNhiVB
   PyWGOK2vs1F4hYpUj/VZWdhUOaokEB6q1BHyAH9yG0hCxrlf+f7nv2Ujq
   Y8n/Fi9DJDUL0aRbBkNa9B0PeX0OIbTSULXLw7kxCu9xeoVS+Y3yTbmqh
   w5LjMQkUcXJyichDTiw7C5lzzUwEno/Zz2cVp5WAhZwm3kindl99N1+Gk
   KAVD3lpfBhnzNNfOwTvS/BCsfL7RneqP/HR5ltOBb8LfCOEQy4zNEiUvI
   edz+fuTM0JbZKHG5z5NgNHzMjHd0R6vnaQ8RDIvQVSk+Dw5qRlTE1ClBC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381589"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928090"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:48 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 04/11] kernel/fork: Initialize mm's PASID
Date:   Fri, 17 Dec 2021 22:01:29 +0000
Message-Id: <20211217220136.2762116-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new mm doesn't have a PASID yet when it's created. Initialize
the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob)

 include/linux/sched/mm.h | 10 ++++++++++
 kernel/fork.c            | 10 ++--------
 mm/init-mm.c             |  4 ++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aca874d33fe6..394c4359c4e1 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/ioasid.h>
 
 /*
  * Routines for handling mm_structs
@@ -407,4 +408,13 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 }
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid = INVALID_IOASID;
+}
+#else
+static inline void mm_pasid_init(struct mm_struct *mm) {}
+#endif
+
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index b33c52021d4e..4e799c9b13bb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -96,6 +96,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/sched/mm.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1018,13 +1019,6 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 #endif
 }
 
-static void mm_init_pasid(struct mm_struct *mm)
-{
-#ifdef CONFIG_IOMMU_SVA
-	mm->pasid = INIT_PASID;
-#endif
-}
-
 static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
@@ -1053,7 +1047,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
-	mm_init_pasid(mm);
+	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b4a6f38fb51d..fbe7844d0912 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -10,6 +10,7 @@
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
+#include <linux/ioasid.h>
 #include <asm/mmu.h>
 
 #ifndef INIT_MM_CONTEXT
@@ -38,6 +39,9 @@ struct mm_struct init_mm = {
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
+#ifdef CONFIG_IOMMU_SVA
+	.pasid		= INVALID_IOASID,
+#endif
 	INIT_MM_CONTEXT(init_mm)
 };
 
-- 
2.34.1

