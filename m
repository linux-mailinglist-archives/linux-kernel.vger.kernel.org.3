Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C999255C2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiF0MGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiF0MGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:06:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF111468
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:04:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BCAE1FDA0;
        Mon, 27 Jun 2022 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656331445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IknD+S/Ug98rdUWi3kX5IaMecoyMVDRuNUY4RiPkYJ8=;
        b=KT6jK2oSaruv2td+ar4LCoLADmz+XlR4XIPPouBlmDHNm5MenzMvirj6dosmqzTKQKTJXN
        MOnDNu8w2JZJcC4/5SoU3rlH7jzCeDoYzZD4Gc6z1Ms5rzdrtJOCwQgf2cznGfTJb17XWc
        ysYCeX3YDd4t/+iB5sv/eYlzdfCqTvw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 554B62C143;
        Mon, 27 Jun 2022 12:04:05 +0000 (UTC)
Date:   Mon, 27 Jun 2022 14:04:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrmcsnHLjadryMSx@dhcp22.suse.cz>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <Yre9LO2nj+Hbr67V@mtj.duckdns.org>
 <CAHk-=wjmWUSdK7-LLjpUrH_TX78emb3ajxZ1ueT2HU0_FVJQfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmWUSdK7-LLjpUrH_TX78emb3ajxZ1ueT2HU0_FVJQfA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 25-06-22 19:53:34, Linus Torvalds wrote:
> On Sat, Jun 25, 2022 at 6:58 PM Tejun Heo <tj@kernel.org> wrote:
[...]
> > * If there are no true spurious wakeups, where did the racing wakeup
> >   come from? The task just got created w/ TASK_NEW and woken up once
> >   with wake_up_new_task(). It hasn't been on any wait queue or
> >   advertised itself to anything.
> 
> I don't think it was ever a spurious wakeup at all.
> 
> The create_worker() code does:
> 
>         worker->task = kthread_create_on_node(..
>         ..
>         worker_attach_to_pool(worker, pool);
>         ..
>         wake_up_process(worker->task);
> 
> and thinks that the wake_up_process() happens after the worker_attach_to_pool().
> 
> But I don't see that at all.
> 
> The reality seems to be that the wake_up_process() is a complete
> no-op, because the task was already woken up by
> kthread_create_on_node().

Just for the record.
the newly created thread is not running our thread function at this
stage. It is rather subtle and took me some time to decypher but
kthread_create_on_node will create and wake up kernel thread running
kthread() function:
[...]
        /*
         * Thread is going to call schedule(), do not preempt it,
         * or the creator may spend more time in wait_task_inactive().
         */
        preempt_disable();
        complete(done);
        schedule_preempt_disabled();
        preempt_enable();

        ret = -EINTR;
        if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
                cgroup_kthread_ready();
                __kthread_parkme(self);
                ret = threadfn(data);
        }

so the newly created thread will go into sleep before calling the
threadfn (worker_thread here). Somebody must have woken it up other than
create_worker. I couldn't have found out who that was (see my other
email with some notes from the crash dump).

I do agree that a simple schedule without checking for a condition is
dubious, fragile and wrong. If anything wait_for_completion would be less
confusing and targetted waiting.

Petr has added that completion into worker_thread to address this
specific case and a better fix would be to address all callers because
who knows how many of those are similarly broken.

I also do agree that this whole scheme is rather convoluted and having
an init() callback to be executed before threadfn would be much more
easier to follow.
-- 
Michal Hocko
SUSE Labs
