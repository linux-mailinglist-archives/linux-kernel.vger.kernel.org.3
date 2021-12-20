Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8CA47A78F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhLTKFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:05:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLTKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:05:39 -0500
Date:   Mon, 20 Dec 2021 11:05:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639994737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eb4FlXy5iNBTsYxMb6HKNk2awrPzuqjLQBf44LyIGYI=;
        b=KCVR/kX4O48pNJ9g5bDGGNvupM9+voewbhLhngVZOMgyj6XbtGV+BN0PdhEXBl3kiRsrRo
        wfhu8k+WZUQ6U4qugn9I2zxjpIKsro8XSphbroBTPY30LzQRBN11Q4JHOYSyG9C2jVSP9e
        txPAo2ExiyYCHkTKxINyGQt5TYvKCKgkb02Zyq2kiB0ZI8vAOcPeImeZsLh7t8HHpbfBM4
        JhSs8pHlFTVIvsti6n2bBUxW1M3lWBQDjoa1jcji1JWE+6iQh+1aFjaN4/QRK3C24BjQdg
        Up0KOkEazoSPmyyhXMXh7uH3Lj+eKAZCZ6pFWL9BbRGvTOpean1QRzuOAEUCXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639994737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eb4FlXy5iNBTsYxMb6HKNk2awrPzuqjLQBf44LyIGYI=;
        b=Pq6d57tihbT1nHZysmj5FVz84TEDFd6zd+iFGDcbzWcMtgrJpSNmmiXTOEQD1C5mAdCHZ9
        SO/eSs9jy2hkwjAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] blktrace: switch trace spinlock to a raw spinlock
Message-ID: <YcBVcOkWumdpjtvI@linutronix.de>
References: <20211217141656.8720-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211217141656.8720-1-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-17 11:16:56 [-0300], Wander Lairson Costa wrote:

Assuming neither Steven nor Jens object,

> TRACE_EVENT disables preemption before calling the callback. Because of
> that blktrace triggers the following bug under PREEMPT_RT:

The tracepoint is invoked with disabled preemption.

>  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 119, name: kworker/u2:2
>  5 locks held by kworker/u2:2/119:
>   #0: ffff8c2e4a88f538 ((wq_completion)xfs-cil/dm-0){+.+.}-{0:0}, at: process_one_work+0x200/0x450
>   #1: ffffab3840ac7e68 ((work_completion)(&cil->xc_push_work)){+.+.}-{0:0}, at: process_one_work+0x200/0x450
>   #2: ffff8c2e4a887128 (&cil->xc_ctx_lock){++++}-{3:3}, at: xlog_cil_push_work+0xb7/0x670 [xfs]
>   #3: ffffffffa6a63780 (rcu_read_lock){....}-{1:2}, at: blk_add_trace_bio+0x0/0x1f0
>   #4: ffffffffa6610620 (running_trace_lock){+.+.}-{2:2}, at: __blk_add_trace+0x3ef/0x480
>  Preemption disabled at:
>  [<ffffffffa4d35c05>] migrate_enable+0x45/0x140
>  CPU: 0 PID: 119 Comm: kworker/u2:2 Kdump: loaded Not tainted 5.14.0-25.rt21.25.light.el9.x86_64+debug #1
>  Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>  Workqueue: xfs-cil/dm-0 xlog_cil_push_work [xfs]
>  Call Trace:
>   ? migrate_enable+0x45/0x140
>   dump_stack_lvl+0x57/0x7d
>   ___might_sleep.cold+0xe3/0xf7
>   rt_spin_lock+0x3a/0xd0
>   ? __blk_add_trace+0x3ef/0x480
>   __blk_add_trace+0x3ef/0x480
>   blk_add_trace_bio+0x18d/0x1f0
>   trace_block_bio_queue+0xb5/0x150
>   submit_bio_checks+0x1f0/0x520
>   ? sched_clock_cpu+0xb/0x100
>   submit_bio_noacct+0x30/0x1d0
>   ? bio_associate_blkg+0x66/0x190
>   xlog_cil_push_work+0x1b6/0x670 [xfs]
>   ? register_lock_class+0x43/0x4f0
>   ? xfs_swap_extents+0x5f0/0x5f0 [xfs]
>   process_one_work+0x275/0x450
>   ? process_one_work+0x200/0x450
>   worker_thread+0x55/0x3c0
>   ? process_one_work+0x450/0x450
>   kthread+0x188/0x1a0
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30

The above fills 90% of my screen with _no_ additional information. What
about:

   The running_trace_lock protects running_trace_list and is acquired
   within the tracepoint which implies disabled preemption. The spinlock_t
   typed lock can not be acquired with disabled preemption on PREEMPT_RT
   because it becomes a sleeping lock.
   The runtime of the tracepoint depends on the number of entries in
   running_trace_list and has no limit. The blk-tracer is considered debug
   code and higher latencies here are okay.
   
   Make running_trace_lock a raw_spinlock_t

> To avoid this bug, we switch the trace lock to a raw spinlock.

Basically I want to give rationale _why_ changing a lock to
raw_spinlock_t _here_ is okay. I want to avoid that people slap a
s/spinlock_t/raw_spinlock_t/ each time they see warning of this kind.

> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Sebastian
