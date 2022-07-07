Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96A556A5A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiGGOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiGGOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:39:20 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759FF2F3BF;
        Thu,  7 Jul 2022 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=wvNkANiSexAoN2cm67vLnTE25j5/JmIiqiUZ1CJD9Xg=; b=Qa
        d/GxnMkevIE0tOULnkmo4Z6YoyPSzGGAYUjDGiL9Jlttn3RnLmiY27/9NYnTOj69d+Cq2AVgobmoS
        ZUse83A82Vkp2vJ4UO4a+m0ozB+N2wXW9KIbd1Phu+BnLn90sYKEydjZO9M4+GPox7vdJxCG+VvnV
        0mBDZ+5fgO8ZvzPTqgy5zGgvmEgjz9Kn+a2Ean5rkvQLvsfLfJNAPRX2lMB9M96T5TRXeWZbU/Bvr
        Fgh/Nm895kZEMw9QQ8X68IDXB5s8He0o1BOUjafdLMpXLSUpfKpQkDxl+mxKEjm9qaJJW+6XUOle5
        5rlQWF+VtEjbNb8SXhKwRBoHxX6sgAVA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1o9Ser-0000MM-DM;
        Thu, 07 Jul 2022 15:39:10 +0100
From:   John Keeping <john@metanate.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, John Keeping <john@metanate.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/core: Always flush pending blk_plug
Date:   Thu,  7 Jul 2022 15:39:02 +0100
Message-Id: <20220707143902.529938-1-john@metanate.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPT_RT, it is possible to hit a deadlock between two
normal priority tasks (SCHED_OTHER, nice level zero):

	INFO: task kworker/u8:0:8 blocked for more than 491 seconds.
	      Not tainted 5.15.49-rt46 #1
	"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	task:kworker/u8:0    state:D stack:    0 pid:    8 ppid:     2 flags:0x00000000
	Workqueue: writeback wb_workfn (flush-7:0)
	[<c08a3a10>] (__schedule) from [<c08a3d84>] (schedule+0xdc/0x134)
	[<c08a3d84>] (schedule) from [<c08a65a0>] (rt_mutex_slowlock_block.constprop.0+0xb8/0x174)
	[<c08a65a0>] (rt_mutex_slowlock_block.constprop.0) from [<c08a6708>]
	+(rt_mutex_slowlock.constprop.0+0xac/0x174)
	[<c08a6708>] (rt_mutex_slowlock.constprop.0) from [<c0374d60>] (fat_write_inode+0x34/0x54)
	[<c0374d60>] (fat_write_inode) from [<c0297304>] (__writeback_single_inode+0x354/0x3ec)
	[<c0297304>] (__writeback_single_inode) from [<c0297998>] (writeback_sb_inodes+0x250/0x45c)
	[<c0297998>] (writeback_sb_inodes) from [<c0297c20>] (__writeback_inodes_wb+0x7c/0xb8)
	[<c0297c20>] (__writeback_inodes_wb) from [<c0297f24>] (wb_writeback+0x2c8/0x2e4)
	[<c0297f24>] (wb_writeback) from [<c0298c40>] (wb_workfn+0x1a4/0x3e4)
	[<c0298c40>] (wb_workfn) from [<c0138ab8>] (process_one_work+0x1fc/0x32c)
	[<c0138ab8>] (process_one_work) from [<c0139120>] (worker_thread+0x22c/0x2d8)
	[<c0139120>] (worker_thread) from [<c013e6e0>] (kthread+0x16c/0x178)
	[<c013e6e0>] (kthread) from [<c01000fc>] (ret_from_fork+0x14/0x38)
	Exception stack(0xc10e3fb0 to 0xc10e3ff8)
	3fa0:                                     00000000 00000000 00000000 00000000
	3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
	3fe0: 00000000 00000000 00000000 00000000 00000013 00000000

	INFO: task tar:2083 blocked for more than 491 seconds.
	      Not tainted 5.15.49-rt46 #1
	"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	task:tar             state:D stack:    0 pid: 2083 ppid:  2082 flags:0x00000000
	[<c08a3a10>] (__schedule) from [<c08a3d84>] (schedule+0xdc/0x134)
	[<c08a3d84>] (schedule) from [<c08a41b0>] (io_schedule+0x14/0x24)
	[<c08a41b0>] (io_schedule) from [<c08a455c>] (bit_wait_io+0xc/0x30)
	[<c08a455c>] (bit_wait_io) from [<c08a441c>] (__wait_on_bit_lock+0x54/0xa8)
	[<c08a441c>] (__wait_on_bit_lock) from [<c08a44f4>] (out_of_line_wait_on_bit_lock+0x84/0xb0)
	[<c08a44f4>] (out_of_line_wait_on_bit_lock) from [<c0371fb0>] (fat_mirror_bhs+0xa0/0x144)
	[<c0371fb0>] (fat_mirror_bhs) from [<c0372a68>] (fat_alloc_clusters+0x138/0x2a4)
	[<c0372a68>] (fat_alloc_clusters) from [<c0370b14>] (fat_alloc_new_dir+0x34/0x250)
	[<c0370b14>] (fat_alloc_new_dir) from [<c03787c0>] (vfat_mkdir+0x58/0x148)
	[<c03787c0>] (vfat_mkdir) from [<c0277b60>] (vfs_mkdir+0x68/0x98)
	[<c0277b60>] (vfs_mkdir) from [<c027b484>] (do_mkdirat+0xb0/0xec)
	[<c027b484>] (do_mkdirat) from [<c0100060>] (ret_fast_syscall+0x0/0x1c)
	Exception stack(0xc2e1bfa8 to 0xc2e1bff0)
	bfa0:                   01ee42f0 01ee4208 01ee42f0 000041ed 00000000 00004000
	bfc0: 01ee42f0 01ee4208 00000000 00000027 01ee4302 00000004 000dcb00 01ee4190
	bfe0: 000dc368 bed11924 0006d4b0 b6ebddfc

Here the kworker is waiting on msdos_sb_info::s_lock which is held by
tar which is in turn waiting for a buffer which is locked waiting to be
flushed, but this operation is plugged in the kworker.

The lock is a normal struct mutex, so tsk_is_pi_blocked() will always
return false on !RT and thus the behaviour changes for RT.

It seems that the intent here is to skip blk_flush_plug() in the case
where a non-preemptible lock (such as a spinlock) has been converted to
a rtmutex on RT, which is the case covered by the SM_RTLOCK_WAIT
schedule flag.  But sched_submit_work() is only called from schedule()
which is never called in this scenario, so the check can simply be
deleted.

Looking at the history of the -rt patchset, in fact this change was
present from v5.9.1-rt20 until being dropped in v5.13-rt1 as it was part
of a larger patch [1] most of which was replaced by commit b4bfa3fcfe3b
("sched/core: Rework the __schedule() preempt argument").

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0022-locking-rtmutex-Use-custom-scheduling-function-for-s.patch?h=linux-5.10.y-rt-patches

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Keeping <john@metanate.com>
---
 include/linux/sched/rt.h | 8 --------
 kernel/sched/core.c      | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index e5af028c08b4..994c25640e15 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -39,20 +39,12 @@ static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *p)
 }
 extern void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task);
 extern void rt_mutex_adjust_pi(struct task_struct *p);
-static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
-{
-	return tsk->pi_blocked_on != NULL;
-}
 #else
 static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
 {
 	return NULL;
 }
 # define rt_mutex_adjust_pi(p)		do { } while (0)
-static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
-{
-	return false;
-}
 #endif
 
 extern void normalize_rt_tasks(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d4660a1915b..e4974fe003b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6578,9 +6578,6 @@ static inline void sched_submit_work(struct task_struct *tsk)
 			io_wq_worker_sleeping(tsk);
 	}
 
-	if (tsk_is_pi_blocked(tsk))
-		return;
-
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
-- 
2.37.0

