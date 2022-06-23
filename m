Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F355573AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiFWHOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFWHOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:14:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCD45AC0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:14:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7E4E11FD3C;
        Thu, 23 Jun 2022 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655968491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+CbS4AOdpWOz+kf3TVVLCBqn2qsWRurCRSP8doycYQ=;
        b=rcRZg/ryR9tOv29qIqlcQlfK5S1ckxZWfgp/qe7pm0wskN35Ki0sKmWcqhWrEzQ0wHPqoX
        TmD/btAEPGDrd6joMggQN5kdLyonVq3dQ6174LZCfCvhBBybqjOC4HLcWI+kEG8OIgzVp5
        wNoYhLPgGmB6vWoybhtZ3VpYD9BbxnU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A1782C142;
        Thu, 23 Jun 2022 07:14:51 +0000 (UTC)
Date:   Thu, 23 Jun 2022 09:14:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Make create_worker() safe against spurious
 wakeups
Message-ID: <YrQS6tiSIOyK2Gi9@dhcp22.suse.cz>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YrQPfBYBZ3wM7GjR@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrQPfBYBZ3wM7GjR@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-06-22 09:00:12, Petr Mladek wrote:
> On Wed 2022-06-22 16:08:53, Petr Mladek wrote:
> > A system crashed with the following BUG() report:
> > 
> >   [115147.050484] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   [115147.050488] #PF: supervisor write access in kernel mode
> >   [115147.050489] #PF: error_code(0x0002) - not-present page
> >   [115147.050490] PGD 0 P4D 0
> >   [115147.050494] Oops: 0002 [#1] PREEMPT_RT SMP NOPTI
> >   [115147.050498] CPU: 1 PID: 16213 Comm: kthreadd Kdump: loaded Tainted: G           O   X    5.3.18-2-rt #1 SLE15-SP2 (unreleased)
> >   [115147.050510] RIP: 0010:_raw_spin_lock_irq+0x14/0x30
> >   [115147.050513] Code: 89 c6 e8 5f 7a 9b ff 66 90 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 fa 65 ff 05 fb 53 6c 55 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 01 c3 89 c6 e8 2e 7a 9b ff 66 90 c3 90 90 90 90 90
> >   [115147.050514] RSP: 0018:ffffb0f68822fed8 EFLAGS: 00010046
> >   [115147.050515] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >   [115147.050516] RDX: 0000000000000001 RSI: 0000000000000002 RDI: 0000000000000000
> >   [115147.050517] RBP: ffff9ca73af40a40 R08: 0000000000000001 R09: 0000000000027340
> >   [115147.050519] R10: ffffb0f68822fe70 R11: 00000000000000a9 R12: ffffb0f688067dc0
> >   [115147.050520] R13: ffff9ca77e9a8000 R14: ffff9ca7634ca780 R15: ffff9ca7634ca780
> >   [115147.050521] FS:  0000000000000000(0000) GS:ffff9ca77fb00000(0000) knlGS:0000000000000000
> >   [115147.050523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [115147.050524] CR2: 00000000000000b8 CR3: 000000004472e000 CR4: 00000000003406e0
> >   [115147.050524] Call Trace:
> >   [115147.050533]  worker_thread+0xb4/0x3c0
> >   [115147.050538]  ? process_one_work+0x4a0/0x4a0
> >   [115147.050540]  kthread+0x152/0x170
> >   [115147.050542]  ? kthread_park+0xa0/0xa0
> >   [115147.050544]  ret_from_fork+0x35/0x40
> > 
> > Further debugging shown that the worker thread was woken
> > before worker_attach_to_pool() finished in create_worker().
> > 
> > Any kthread is supposed to stay in TASK_UNINTERRUPTIBLE sleep
> > until it is explicitly woken. But a spurious wakeup might
> > break this expectation.
> > 
> > As a result, worker_thread() might read worker->pool before
> > it was set in worker create_worker() by worker_attach_to_pool().
> > Also manage_workers() might want to create yet another worker
> > before worker->pool->nr_workers is updated. It is a kind off
> > a chicken & egg problem.
> > 
> > Synchronize these operations using a completion API.
> > 
> > Note that worker->pool might be then read without wq_pool_attach_mutex.
> > Normal worker always belongs to the same pool.
> > 
> > Also note that rescuer_thread() does not need this because all
> > needed values are set before the kthreads is created. It is
> > connected with a particular workqueue. It is attached to different
> > pools when needed.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/workqueue.c          | 13 ++++++++++++-
> >  kernel/workqueue_internal.h |  1 +
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 1ea50f6be843..9586b0797145 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -2378,10 +2380,19 @@ static void set_pf_worker(bool val)
> >  static int worker_thread(void *__worker)
> >  {
> >  	struct worker *worker = __worker;
> > -	struct worker_pool *pool = worker->pool;
> > +	struct worker_pool *pool;
> >  
> >  	/* tell the scheduler that this is a workqueue worker */
> >  	set_pf_worker(true);
> > +
> > +	/*
> > +	 * Wait until the worker is ready to get started. It must be attached
> > +	 * to a pool first. This is needed because of spurious wakeups.
> > +	 */
> > +	while (wait_for_completion_interruptible(&worker->ready_to_start))
> 
> I have realized that this is wrong. I used _interruptible() variant
> because we do not know how long it would need to sleep. And long
> sleeping in TASK_UNINTERRUPTIBLE might trigger hung task warning.
> 
> But kthread_bind_mask() requires that the kthread will be in
> TASK_UNINTERRUPTIBLE state.
> 
> Note that even the freshly created kthread is sleeping in
> TASK_UNTERRUPTIBLE, see kthread() in kernel/kthread.c. But
> it does not trigger the hung task warning because there is
> a special check for this case, see check_hung_task():
> 
> 	/*
> 	 * When a freshly created task is scheduled once, changes its state to
> 	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
> 	 * musn't be checked.
> 	 */
> 	if (unlikely(!switch_count))
> 		return;
> 
> The following seems to work well:
> 
> 	while (!wait_for_completion_timeout(&worker->ready_to_start, 5 * HZ))
> 		;

This is really ugly and I do not really see why this is needed. Should
there be such an overloaded system that create_worker cannot finish the
initialization before khungtask triggers then we should be notified. I
do not see how papering this over would be helpful.

That being said, I really thing that this should be plain
wait_for_completion()

With that changed, feel free to add
Reviewed-by: Michal Hocko <mhocko@suse.com>

and thanks helping to debug this and prepare the fix. I was not really
aware of the spurious wake up scenario. Btw. it would be great to
describe that in a more detail as well for future reference.

Thanks!
-- 
Michal Hocko
SUSE Labs
