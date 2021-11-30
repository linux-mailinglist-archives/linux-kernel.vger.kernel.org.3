Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A4546295E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhK3BAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbhK3BAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:00:39 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:57:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x10so23945931ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fPX6fEDokMAHa0Xq8dB5PRCHm3p4md63oJN/gUh8Fc=;
        b=bR48epEnyOF5GPGqM8bkfVg/PJKA0144qHTXMo/VnKg4NCRNMwKE7gUAZ1aQzugq43
         +5/RzOeKohlOFNmfp49B1QjBhrpyNqHhfb8lrvcu1kn6gke6m6Re1aiI/YwQfVhwC7wL
         j9fMWv6M3qtyURb6TkS1s7psU+CirPMSBmE1rlAb1ydD9kLLPfu6jqtMqR3a2r/Puwbv
         mpYUjJlm6KFKdQqKFDAwgJbLxCVVQU6o15EA3ml1dPPLrbrbDpJ45LdeSFzeCkqfMHVv
         ETYa1jNhwWyBDXPYrSJ9eT2/xTVdjTLm4ukExmLhXZ3fOt4SRoZz9jYVG16LFCuaRGHo
         LXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fPX6fEDokMAHa0Xq8dB5PRCHm3p4md63oJN/gUh8Fc=;
        b=bKW/Hovcy7G9NFbwPVkjiNFxARROQGnKBgW+qmL6uyJOU1a1sw9XfVNtvbmu4Khraj
         0fB97TbE9NwTKh65R7tFcA8AeV0MGcasvG25/IUZpI+CTqzXVEB/PViTrw8nO25S36Wk
         mq7v3USYSUtzJq40idnfROjLvWYsuGU5DD7vgCGvvV22Rfsr5qmLNhYCioDZW7BQqzs4
         4Nj4dr/PYjIWn5v99ReM8EpGyyMIDvcB3KzV/0qk72dbJjcTqVwcAons2XK8M2EB8oRr
         xdk8md3sLirijyIyCkAEUZ4eBEOL30dSZY14hsRMFt+2m9v58P0CXjvYJaDEzpCka7S5
         nH2g==
X-Gm-Message-State: AOAM530Bz/mZWl/iC/MqHNz8MDMY+Br/sHSPYn8P4GE+FFyI7EouNb8B
        5tq9qm0JNzD4KFezGb+RdH+kcoysoYBE6Hmo4jveYpRgnVc=
X-Google-Smtp-Source: ABdhPJx8VvcQGvHhKDT/IquJvyTs2niIV5Cq0Lu+A/ndipu17g6Zdh4+YwRcOBjh0wigabZUziSSKRYSeXO7jSfCVIM=
X-Received: by 2002:a5d:8e07:: with SMTP id e7mr61561164iod.148.1638233841166;
 Mon, 29 Nov 2021 16:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20211130000612.591368-1-frederic@kernel.org> <20211130000612.591368-3-frederic@kernel.org>
In-Reply-To: <20211130000612.591368-3-frederic@kernel.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 30 Nov 2021 08:57:09 +0800
Message-ID: <CAJhGHyDp+NN_QuaChU-_vdpR+aRj_OOZTMto6kWfOeJ2cNWFUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] workqueue: Fix unbind_workers() VS
 wq_worker_sleeping() race
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 8:06 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> At CPU-hotplug time, unbind_workers() may preempt a worker while it is
> going to sleep. In that case the following scenario can happen:
>
>     unbind_workers()                     wq_worker_sleeping()
>     --------------                      -------------------
>                                       if (worker->flags & WORKER_NOT_RUNNING)
>                                           return;
>                                       //PREEMPTED by unbind_workers
>     worker->flags |= WORKER_UNBOUND;
>     [...]
>     atomic_set(&pool->nr_running, 0);
>     //resume to worker
>                                        atomic_dec_and_test(&pool->nr_running);
>
> After unbind_worker() resets pool->nr_running, the value is expected to
> remain 0 until the pool ever gets rebound in case cpu_up() is called on
> the target CPU in the future. But here the race leaves pool->nr_running
> with a value of -1, triggering the following warning when the worker goes
> idle:
>
>         WARNING: CPU: 3 PID: 34 at kernel/workqueue.c:1823 worker_enter_idle+0x95/0xc0
>         Modules linked in:
>         CPU: 3 PID: 34 Comm: kworker/3:0 Not tainted 5.16.0-rc1+ #34
>         Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>         Workqueue:  0x0 (rcu_par_gp)
>         RIP: 0010:worker_enter_idle+0x95/0xc0
>         Code: 04 85 f8 ff ff ff 39 c1 7f 09 48 8b 43 50 48 85 c0 74 1b 83 e2 04 75 99 8b 43 34 39 43 30 75 91 8b 83 00 03 00 00 85 c0 74 87 <0f> 0b 5b c3 48 8b 35 70 f1 37 01 48 8d 7b 48 48 81 c6 e0 93  0
>         RSP: 0000:ffff9b7680277ed0 EFLAGS: 00010086
>         RAX: 00000000ffffffff RBX: ffff93465eae9c00 RCX: 0000000000000000
>         RDX: 0000000000000000 RSI: ffff9346418a0000 RDI: ffff934641057140
>         RBP: ffff934641057170 R08: 0000000000000001 R09: ffff9346418a0080
>         R10: ffff9b768027fdf0 R11: 0000000000002400 R12: ffff93465eae9c20
>         R13: ffff93465eae9c20 R14: ffff93465eae9c70 R15: ffff934641057140
>         FS:  0000000000000000(0000) GS:ffff93465eac0000(0000) knlGS:0000000000000000
>         CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>         CR2: 0000000000000000 CR3: 000000001cc0c000 CR4: 00000000000006e0
>         DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>         DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>         Call Trace:
>           <TASK>
>           worker_thread+0x89/0x3d0
>           ? process_one_work+0x400/0x400
>           kthread+0x162/0x190
>           ? set_kthread_struct+0x40/0x40
>           ret_from_fork+0x22/0x30
>           </TASK>
>
> Also due to this incorrect "nr_running == -1", all sorts of hazards can
> happen, starting with queued works being ignored because no workers are
> awaken at insert_work() time.
>
> Fix this with checking again the worker flags while pool->lock is locked.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>


Fixes: b945efcdd07d ("sched: Remove pointless preemption disable in
sched_submit_work()")
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

It was my fault for not reviewing b945efcdd07d carefully enough.

> ---
>  kernel/workqueue.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 5094573e8b45..5557d19ea81c 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -912,6 +912,16 @@ void wq_worker_sleeping(struct task_struct *task)
>         worker->sleeping = 1;
>         raw_spin_lock_irq(&pool->lock);
>
> +       /*
> +        * Recheck in case unbind_workers() preempted us. We don't
> +        * want to decrement nr_running after the worker is unbound
> +        * and nr_running has been reset.
> +        */
> +       if (worker->flags & WORKER_NOT_RUNNING) {
> +               raw_spin_unlock_irq(&pool->lock);
> +               return;
> +       }
> +
>         /*
>          * The counterpart of the following dec_and_test, implied mb,
>          * worklist not empty test sequence is in insert_work().
> --
> 2.25.1
>
