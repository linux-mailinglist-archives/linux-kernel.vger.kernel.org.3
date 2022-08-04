Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0115758998F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiHDI5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiHDI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:57:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452097654
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:57:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p8-20020a05600c05c800b003a50311d75cso1669085wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uekebcstHSHtJd5UCZfJYaVUKNeNuhLkzJiPAGReMv4=;
        b=oDvy13GNft8LQBxvDtcEmsu9QgXP2SsYFzXkE0Q/WS8IEZeBaLVM7nJkZsUnP/LG0t
         mv9htJfV8DO6QHMVKo50XdWOWl8+KmZOrB8ieS10A7r0lk91T6KopAo9dwxijbljsifO
         MzFP5glBth/EZxfoBh7oBuA6vAV2PfDg3H6bJolbPtuhYjgL9/DghAnfDXpCQ9lOHbIn
         XcO3eMbGYC8cIVz0XMrsynIHdxt0dExGIQZscrRHU/xNyUr06KKbCI6K5pjMIj87equq
         GJY9PFhKSv0md8JFzVyzYerkFsWS5sbHlPYmd42FySerKaSkGO5bdX9jCFR3RPbZEF+R
         wJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uekebcstHSHtJd5UCZfJYaVUKNeNuhLkzJiPAGReMv4=;
        b=O/mq0I0PGBPqJUIT9JMixSPWxLasssFjA2lfvkbfrz+q8VKnZkB1NDEbowi7xcoYpz
         hUDVdRFAE3M89L1rEYyLXyiVItMmyttjdhMA2QTJVupXaRpNHAXa4Ba7uRxLPm1mYASA
         7/lxWd2Wfr22f8Bhd3U+BlO9cjHNgRjQM0NtADFIM5X9kU7PdDtzXEBD/6uaXnJe4wiI
         X1kKekbHd4/nH00KQ5kP6IG5Gcba+TtUdQR7T6B7zMyR+cwDB/mKT8Zbtl1hn3KlfjOg
         bG2VECVL0jM1AHYjWnXMSSEET6n1xEBoIGZ6wTU9pEiVRv35YUsLmuLURSGR8rnkOO4w
         hbeQ==
X-Gm-Message-State: ACgBeo3QeUv1AHnzjhR5j4AxQWGopalWJIfFSqPIgZSxJsnkN++56dl3
        H4c6fEOflH8eHBTb/OlwUumuaRKLQ5F9x0LGbnG1IYZTOiM=
X-Google-Smtp-Source: AA6agR5DIh7htry/bLOX8Wws6LthXH1c+cdgm3ftpXuQBKFtKFbfiimT/EfosiReli2M0GXR5nGB1l4/rcZzKJe4RM4=
X-Received: by 2002:a05:600c:3847:b0:3a3:5333:8bcd with SMTP id
 s7-20020a05600c384700b003a353338bcdmr694089wmr.36.1659603432561; Thu, 04 Aug
 2022 01:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com>
In-Reply-To: <20220622140853.31383-1-pmladek@suse.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 4 Aug 2022 16:57:01 +0800
Message-ID: <CAJhGHyDHVFto=UNrVQ5bjc11yGCnNmLKAkPPimtwF-Qa+1g==Q@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Make create_worker() safe against spurious wakeups
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:10 PM Petr Mladek <pmladek@suse.com> wrote:
>
> A system crashed with the following BUG() report:
>
>   [115147.050484] BUG: kernel NULL pointer dereference, address: 0000000000000000
>   [115147.050488] #PF: supervisor write access in kernel mode
>   [115147.050489] #PF: error_code(0x0002) - not-present page
>   [115147.050490] PGD 0 P4D 0
>   [115147.050494] Oops: 0002 [#1] PREEMPT_RT SMP NOPTI
>   [115147.050498] CPU: 1 PID: 16213 Comm: kthreadd Kdump: loaded Tainted: G           O   X    5.3.18-2-rt #1 SLE15-SP2 (unreleased)
>   [115147.050510] RIP: 0010:_raw_spin_lock_irq+0x14/0x30
>   [115147.050513] Code: 89 c6 e8 5f 7a 9b ff 66 90 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 fa 65 ff 05 fb 53 6c 55 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 01 c3 89 c6 e8 2e 7a 9b ff 66 90 c3 90 90 90 90 90
>   [115147.050514] RSP: 0018:ffffb0f68822fed8 EFLAGS: 00010046
>   [115147.050515] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>   [115147.050516] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000000
>   [115147.050517] RBP: ffff9ca73af40a40 R08: 0000000000000001 R09: 0000000000027340
>   [115147.050519] R10: ffffb0f68822fe70 R11: 00000000000000a9 R12: ffffb0f688067dc0
>   [115147.050520] R13: ffff9ca77e9a8000 R14: ffff9ca7634ca780 R15: ffff9ca7634ca780
>   [115147.050521] FS:  0000000000000000(0000) GS:ffff9ca77fb00000(0000) knlGS:0000000000000000
>   [115147.050523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [115147.050524] CR2: 00000000000000b8 CR3: 000000004472e000 CR4: 00000000003406e0
>   [115147.050524] Call Trace:
>   [115147.050533]  worker_thread+0xb4/0x3c0
>   [115147.050538]  ? process_one_work+0x4a0/0x4a0
>   [115147.050540]  kthread+0x152/0x170
>   [115147.050542]  ? kthread_park+0xa0/0xa0
>   [115147.050544]  ret_from_fork+0x35/0x40
>
> Further debugging shown that the worker thread was woken
> before worker_attach_to_pool() finished in create_worker().
>
> Any kthread is supposed to stay in TASK_UNINTERRUPTIBLE sleep
> until it is explicitly woken. But a spurious wakeup might
> break this expectation.
>
> As a result, worker_thread() might read worker->pool before
> it was set in worker create_worker() by worker_attach_to_pool().
> Also manage_workers() might want to create yet another worker
> before worker->pool->nr_workers is updated. It is a kind off
> a chicken & egg problem.
>
> Synchronize these operations using a completion API.
>
> Note that worker->pool might be then read without wq_pool_attach_mutex.
> Normal worker always belongs to the same pool.
>
> Also note that rescuer_thread() does not need this because all
> needed values are set before the kthreads is created. It is
> connected with a particular workqueue. It is attached to different
> pools when needed.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/workqueue.c          | 13 ++++++++++++-
>  kernel/workqueue_internal.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1ea50f6be843..9586b0797145 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1939,6 +1939,7 @@ static struct worker *create_worker(struct worker_pool *pool)
>                 goto fail;
>
>         worker->id = id;
> +       init_completion(&worker->ready_to_start);
>
>         if (pool->cpu >= 0)
>                 snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
> @@ -1961,6 +1962,7 @@ static struct worker *create_worker(struct worker_pool *pool)
>         raw_spin_lock_irq(&pool->lock);
>         worker->pool->nr_workers++;
>         worker_enter_idle(worker);
> +       complete(&worker->ready_to_start);
>         wake_up_process(worker->task);
>         raw_spin_unlock_irq(&pool->lock);
>
> @@ -2378,10 +2380,19 @@ static void set_pf_worker(bool val)
>  static int worker_thread(void *__worker)
>  {
>         struct worker *worker = __worker;
> -       struct worker_pool *pool = worker->pool;
> +       struct worker_pool *pool;
>
>         /* tell the scheduler that this is a workqueue worker */
>         set_pf_worker(true);
> +
> +       /*
> +        * Wait until the worker is ready to get started. It must be attached
> +        * to a pool first. This is needed because of spurious wakeups.
> +        */
> +       while (wait_for_completion_interruptible(&worker->ready_to_start))
> +               ;

There might be some wakeups from wake_up_worker() since it is in
the idle list.  These wakeups will be "spurious wakeups" in the view
of the completion subsystem.

> +       pool = worker->pool;
> +
>  woke_up:
>         raw_spin_lock_irq(&pool->lock);
>
> diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
> index e00b1204a8e9..ffca2783c8bf 100644
> --- a/kernel/workqueue_internal.h
> +++ b/kernel/workqueue_internal.h
> @@ -41,6 +41,7 @@ struct worker {
>                                                 /* L: for rescuers */
>         struct list_head        node;           /* A: anchored at pool->workers */
>                                                 /* A: runs through worker->node */
> +       struct completion       ready_to_start; /* None: handle spurious wakeup */
>
>         unsigned long           last_active;    /* L: last active timestamp */
>         unsigned int            flags;          /* X: flags */
> --
> 2.35.3
>
