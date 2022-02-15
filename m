Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A6D4B69D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiBOKzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:55:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiBOKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179FD76D5;
        Tue, 15 Feb 2022 02:54:33 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CtiqOjmcSE5w3uoz5XtZZ0sT7IhhUmcMpf2HZeZbHY=;
        b=ceH5SeWM2oDowLqSMzEXUnMy13U8HXx4UaC/AXLXjnqiENucar9+ocs6x00e2isOYK3W7i
        RPoTppXKoq9Uf4u/O1YoEe29UbKN4/UGG6+gbsSCJyaK/6SkQsRAU/UoTa50WFokhsGVI4
        uU/XPrBIFwJkaD3QkzzVw2vvgfmQfGFbDBfWgfg/tuodEgEyuu0R7+o+GJxaKDuBTOfdyV
        Cw1Jhbx3S/Ib6T2udSry2f/jYBWzT8rLC1S41vpGfbFsh6m1xxgmh1ikpvKfgQHFjqE9EL
        iM++Qe32ugOcC/me+6pTGC/OMgmPlzx9epYO45fkp+93EakXMz16VsPXmf0HWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CtiqOjmcSE5w3uoz5XtZZ0sT7IhhUmcMpf2HZeZbHY=;
        b=rT2+hEz+6dTRn6shBHLm8eLHocoOCgYXaVeZ3iwDzk4C3bMwMj4Pmp9GPJ1OxlihPWEfh+
        +A3NjR17NDD85FDQ==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] kernel/fork: Initialize mm's PASID
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-5-fenghua.yu@intel.com>
References: <20220207230254.3342514-5-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492247138.16921.3316731042536397446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     a6cbd44093ef305b02ad5f80ed54abf0148a696c
Gitweb:        https://git.kernel.org/tip/a6cbd44093ef305b02ad5f80ed54abf0148a696c
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:47 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 14 Feb 2022 19:51:47 +01:00

kernel/fork: Initialize mm's PASID

A new mm doesn't have a PASID yet when it's created. Initialize
the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).

INIT_PASID (0) is reserved for kernel legacy DMA PASID. It cannot be
allocated to a user process. Initializing the process's PASID to 0 may
cause confusion that's why the process uses the reserved kernel legacy
DMA PASID. Initializing the PASID to INVALID_IOASID (-1) explicitly
tells the process doesn't have a valid PASID yet.

Even though the only user of mm_pasid_init() is in fork.c, define it in
<linux/sched/mm.h> as the first of three mm/pasid life cycle functions
(init/set/drop) to keep these all together.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220207230254.3342514-5-fenghua.yu@intel.com
---
 include/linux/sched/mm.h | 10 ++++++++++
 kernel/fork.c            | 10 ++--------
 mm/init-mm.c             |  4 ++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aa5f09c..c74d1ed 100644
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
index 6ee7551..deacd2c 100644
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
index b4a6f38..fbe7844 100644
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
 
