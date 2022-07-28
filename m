Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8258472D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiG1Upc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiG1UpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC84E60F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w205so2897492pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ycW0mhERWN+p0KVMgOpcoUTig1KmOvE2fu+KZQruV5Q=;
        b=enzG2ODUUsfYcRd6l9GSOTO9h/lNV8Ef4uIhHU6yji7Llr1yXRk3yu8Jvp3eGFtyvk
         GuacXnsG0xrlW8P8MKMl3E3zGDpphKxKDGWUicOyhyzhjvNKOJ5O/+6eGpDxn0PicZ1V
         TRa/lGa/fMEZsrkrEAVncXaTZo1oYW9zat+vY1xOm2f+7x+0Oxd/wuCtuHT+++nhi5fN
         P3aqzJfa/8dpzuEeqaT1QfwnZSq1teXtWEgL6iLWtf1zsU83oj0jmVJPCWHBGvdXSPiz
         oUzYdURjUrByQA5sleCoOy4v8itR0JknzX0G/p8AaYur1CAJ5lz1Jzn1s2MjJIRXXode
         FoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ycW0mhERWN+p0KVMgOpcoUTig1KmOvE2fu+KZQruV5Q=;
        b=zMcDmiinDih1XZ9ZvyC4QutovYG1FMgX7sj2pZqFXd5H18R3lAcvhYsu8zd0YlSRsJ
         ng0NWprxjoveeJD1eT8gd7cOY6YNm3wZjY//+Nsp6+WKRG+JJUUX2bUs4HK1o8Uhh5aR
         ThuqYWmxdnQT/a9qvmdNTnBju8aiVQjFPSlJ7jbvaB/z367ZFdpqpoqrqZSCQsfP4oOA
         sdpgCpQbiKoUPknVgjH9etAhD9706YvckN6JVru+IndV6pTKX81DKNRxz+k01TGsXGQM
         CgZmxq/fNrMd+tz4LGT9rJJhNirE2IQC7C2d7g0PQ+Bn5oVHaffQs7y1TTyct3+iVJR9
         XyAA==
X-Gm-Message-State: AJIora9SINgIXQA1bzNUd5pHXFlZXtP3A8jQfqUw4NndUTCN9mLMTVXV
        Yb1bdyADIQ8+LEcglfnuzAU=
X-Google-Smtp-Source: AGRyM1tYmO8wnuamcnLViWW3Uo2TdiQiGqhQMiU8SvJkvB0urbOMvzbIUQjzsRT1aMImvlLKOkCoyQ==
X-Received: by 2002:a63:b50b:0:b0:412:b42c:6940 with SMTP id y11-20020a63b50b000000b00412b42c6940mr406365pge.460.1659041120407;
        Thu, 28 Jul 2022 13:45:20 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:19 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 1/7] mm: remove the per-task RSS counter cache
Date:   Fri, 29 Jul 2022 04:45:05 +0800
Message-Id: <20220728204511.56348-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220728204511.56348-1-ryncsn@gmail.com>
References: <20220728204511.56348-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

The RSS counter cached as introduced in
commit 34e55232e59f ("mm: avoid false sharing of mm_counter") to ease
the contention of the RSS counters of a mm_struct.

There are several problems with this, and the 64 events threshold
might not be an optimal value. It makes the RSS value inaccurate,
in the worst case, RSS value is not accounted until 64 pages are
allocated. With common tools like `top`, there could be hundreds of
MBs of error of the RSS value being reported by kernel.

And since 4 counters share the same event threshold, in the worst case,
each counter will do a global sync every 16 events, which still raises
some contention.

Remove this cache for now, and prepare for a different approach.

Some helper macros are kept since they will come in handy later.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 Documentation/filesystems/proc.rst |  7 -----
 fs/exec.c                          |  2 --
 include/linux/mm.h                 | 20 +-----------
 include/linux/mm_types_task.h      |  9 ------
 include/linux/sched.h              |  3 --
 kernel/exit.c                      |  5 ---
 kernel/fork.c                      |  4 ---
 kernel/kthread.c                   |  1 -
 mm/madvise.c                       |  7 ++---
 mm/memory.c                        | 49 ------------------------------
 10 files changed, 3 insertions(+), 104 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..04a0a18da262 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -224,13 +224,6 @@ memory usage. Its seven fields are explained in Table 1-3.  The stat file
 contains detailed information about the process itself.  Its fields are
 explained in Table 1-4.
 
-(for SMP CONFIG users)
-
-For making accounting scalable, RSS related information are handled in an
-asynchronous manner and the value may not be very precise. To see a precise
-snapshot of a moment, you can see /proc/<pid>/smaps file and scan page table.
-It's slow but very precise.
-
 .. table:: Table 1-2: Contents of the status files (as of 4.19)
 
  ==========================  ===================================================
diff --git a/fs/exec.c b/fs/exec.c
index 778123259e42..3c787ca8c68e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -988,8 +988,6 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk = current;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
-	if (old_mm)
-		sync_mm_rss(old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
 	if (ret)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf3d0d673f6b..6346f7e77dc7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1998,17 +1998,7 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	long val = atomic_long_read(&mm->rss_stat.count[member]);
-
-#ifdef SPLIT_RSS_COUNTING
-	/*
-	 * counter is updated in asynchronous manner and may go to minus.
-	 * But it's never be expected number for users.
-	 */
-	if (val < 0)
-		val = 0;
-#endif
-	return (unsigned long)val;
+	return atomic_long_read(&mm->rss_stat.count[member]);
 }
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member, long count);
@@ -2094,14 +2084,6 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
 		*maxrss = hiwater_rss;
 }
 
-#if defined(SPLIT_RSS_COUNTING)
-void sync_mm_rss(struct mm_struct *mm);
-#else
-static inline void sync_mm_rss(struct mm_struct *mm)
-{
-}
-#endif
-
 #ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
 static inline int pte_special(pte_t pte)
 {
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..a00327c663db 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -48,15 +48,6 @@ enum {
 	NR_MM_COUNTERS
 };
 
-#if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
-#define SPLIT_RSS_COUNTING
-/* per-thread cached information, */
-struct task_rss_stat {
-	int events;	/* for synchronization threshold */
-	int count[NR_MM_COUNTERS];
-};
-#endif /* USE_SPLIT_PTE_PTLOCKS */
-
 struct mm_rss_stat {
 	atomic_long_t count[NR_MM_COUNTERS];
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..11d3e1a95302 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -861,9 +861,6 @@ struct task_struct {
 	/* Per-thread vma caching: */
 	struct vmacache			vmacache;
 
-#ifdef SPLIT_RSS_COUNTING
-	struct task_rss_stat		rss_stat;
-#endif
 	int				exit_state;
 	int				exit_code;
 	int				exit_signal;
diff --git a/kernel/exit.c b/kernel/exit.c
index 64c938ce36fe..8c55cda5136f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -482,7 +482,6 @@ static void exit_mm(void)
 	exit_mm_release(current, mm);
 	if (!mm)
 		return;
-	sync_mm_rss(mm);
 	mmap_read_lock(mm);
 	mmgrab(mm);
 	BUG_ON(mm != current->active_mm);
@@ -749,10 +748,6 @@ void __noreturn do_exit(long code)
 
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
-
-	/* sync mm's RSS info before statistics gathering */
-	if (tsk->mm)
-		sync_mm_rss(tsk->mm);
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..c090ebd55063 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2145,10 +2145,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->io_uring = NULL;
 #endif
 
-#if defined(SPLIT_RSS_COUNTING)
-	memset(&p->rss_stat, 0, sizeof(p->rss_stat));
-#endif
-
 	p->default_timer_slack_ns = current->timer_slack_ns;
 
 #ifdef CONFIG_PSI
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3c677918d8f2..6bfbab4e2103 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1463,7 +1463,6 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	 * clearing tsk->mm.
 	 */
 	smp_mb__after_spinlock();
-	sync_mm_rss(mm);
 	local_irq_disable();
 	tsk->mm = NULL;
 	membarrier_update_current_mm(NULL);
diff --git a/mm/madvise.c b/mm/madvise.c
index 0316bbc6441b..48cb9e5f92d2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -711,12 +711,9 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		mark_page_lazyfree(page);
 	}
 out:
-	if (nr_swap) {
-		if (current->mm == mm)
-			sync_mm_rss(mm);
-
+	if (nr_swap)
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
-	}
+
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	cond_resched();
diff --git a/mm/memory.c b/mm/memory.c
index 4cf7d4b6c950..6bf7826e666b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -176,53 +176,9 @@ void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
 	trace_rss_stat(mm, member, count);
 }
 
-#if defined(SPLIT_RSS_COUNTING)
-
-void sync_mm_rss(struct mm_struct *mm)
-{
-	int i;
-
-	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		if (current->rss_stat.count[i]) {
-			add_mm_counter(mm, i, current->rss_stat.count[i]);
-			current->rss_stat.count[i] = 0;
-		}
-	}
-	current->rss_stat.events = 0;
-}
-
-static void add_mm_counter_fast(struct mm_struct *mm, int member, int val)
-{
-	struct task_struct *task = current;
-
-	if (likely(task->mm == mm))
-		task->rss_stat.count[member] += val;
-	else
-		add_mm_counter(mm, member, val);
-}
-#define inc_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, 1)
-#define dec_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, -1)
-
-/* sync counter once per 64 page faults */
-#define TASK_RSS_EVENTS_THRESH	(64)
-static void check_sync_rss_stat(struct task_struct *task)
-{
-	if (unlikely(task != current))
-		return;
-	if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
-		sync_mm_rss(task->mm);
-}
-#else /* SPLIT_RSS_COUNTING */
-
 #define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
 #define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
 
-static void check_sync_rss_stat(struct task_struct *task)
-{
-}
-
-#endif /* SPLIT_RSS_COUNTING */
-
 /*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
@@ -502,8 +458,6 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 {
 	int i;
 
-	if (current->mm == mm)
-		sync_mm_rss(mm);
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		if (rss[i])
 			add_mm_counter(mm, i, rss[i]);
@@ -5120,9 +5074,6 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	count_vm_event(PGFAULT);
 	count_memcg_event_mm(vma->vm_mm, PGFAULT);
 
-	/* do counter updates before entering really critical section. */
-	check_sync_rss_stat(current);
-
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
-- 
2.35.2

