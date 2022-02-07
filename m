Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD94ACD5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbiBHBDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbiBGXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABCEC061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275008; x=1675811008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=905JQ3YZKvuZYu7D1FVJXac593yX75ihm3basE87bLk=;
  b=RxPGZAVnlTuKDuKMWh4piYMqWy32Ri5PMwox5lQcXvVApO1qKBb1M62d
   Uf0K3DJlwc5OxdXiUmD9ZhvLie75BiKMN74lWEe8Nfmv9XFb1eb0pgFhA
   vRTYAlBWKjkR91uMNwMZXI5PeoxxsMGpt7ACpb8ioX1abINi/JBBeMaVc
   Muq99MJnkwsgo0AgR44fJZDpAqr9kpsXuoA1ZKQY0XWA4RlEqAcIeQXKx
   Xs8HoR2kXpZsLTUUfZLLilnLAJDxZzqAKq0gK+JDNIV1/dsx4O+V2tN8E
   jvVFahVyNMay5g4bHiRdo8iZhAhE2wN7e9tZgJ/s5cKXxricvACCFMK6b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475012"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324041"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:03 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
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
Subject: [PATCH v4 04/11] kernel/fork: Initialize mm's PASID
Date:   Mon,  7 Feb 2022 15:02:47 -0800
Message-Id: <20220207230254.3342514-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new mm doesn't have a PASID yet when it's created. Initialize
the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).

INIT_PASID (0) is reserved for kernel legacy DMA PASID. It cannot be
allocated to a user process. Initializing the process's PASID to 0 may
cause confusion that why the process uses the reserved kernel legacy DMA
PASID. Initializing the PASID to INVALID_IOASID (-1) explicitly
tells the process doesn't have a valid PASID yet.

Even though the only user of mm_pasid_init() is in fork.c, define it
in <linux/sched/mm.h> as the first of three mm/pasid life cycle
functions (init/set/drop) to keep these all together.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v4:
- Update the commit message to explain why init pasid to -1 and why
  define mm_pasid_init() (Thomas)

v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob)

 include/linux/sched/mm.h | 10 ++++++++++
 kernel/fork.c            | 10 ++--------
 mm/init-mm.c             |  4 ++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aa5f09ca5bcf..c74d1edbac2f 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/ioasid.h>
 
 /*
  * Routines for handling mm_structs
@@ -433,4 +434,13 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
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
index 6ee7551d3bd2..deacd2c17a7f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/sched/mm.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -1019,13 +1020,6 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
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
@@ -1054,7 +1048,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
2.35.1

