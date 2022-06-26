Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49C255AE1C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiFZB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 21:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiFZB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 21:58:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE7BE31
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:58:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 9so5867602pgd.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MzaHy7CH67twv+n83XoCxJz/5x47URWouUOlx3uldKw=;
        b=TswylHpkps2dFlqv2itbDCaTYhordG8kGRlDu+4QBjjY1CgEnFp433YOE4TSnp5vJ4
         a4ZiOliA20PV3J1/QTjoJeYIFTOEWq1+142l260oK3Kix1rYVQ3b5I3Z0MJxthMqroi6
         gIpQ/de8AtNYBLstZLjiJCUYSDQv00/9hjekM9kZat4GK34rOSKRq+SNAmF/9Xr3hyGY
         vR4k/0uELZkDVJKMa/geO6Ijkhg13ECVxVSE3eItAMNJNQCt5jRqGT1eW7K4Wn4lFlsm
         bJI73KsScl1Zq9BjAxrjchY5+i4Od3vZebJruFpycRjqumcw8k3a3jH40OD+9FkhnN3H
         3L9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MzaHy7CH67twv+n83XoCxJz/5x47URWouUOlx3uldKw=;
        b=yy+YJh44FmpjeUAHAGAwFMo0JfuSwlnXOcJIzAISBXdiDs/zwQ+TbLRQCyowSIJj4E
         Tlu/k5LnwI5F+ITcYf8+//xjHzGaFFlVE9AyubSHW+ESt0tYSASWBaA6Wx9tj9Dq24Xa
         iCmEFOzvMd9tmJ3w2B8pGfbUgPJYnjjkrnTYEqL/oDZhZ6+bvysO7P4LzzDCbdhCxvTJ
         sfWCdUvAMR0WCwD2/f+Scw9LArRvp+g7YawnX2qN1rJgjLA709HDreue//3hRKPqKQSu
         NWEjGTffAMZSjiyMmym9o/zZpPtpvqs0qfWR2GFH3OPk0EVEGzyAzstcwFWWvGGD5ClC
         rLBw==
X-Gm-Message-State: AJIora8cs6iDWr4DbSU9CnUEe9iXlleoJbPfyDKFv7LvNI/K5J8mJjP/
        D78HdMAlC3rZ/Xv1e1Wkw5A=
X-Google-Smtp-Source: AGRyM1s77IRUBMZc/PRBcp5omRP5G22B0kd73OqnRlsE5FRA+ulvPJPHIAHlyKJdQ3YzWFVrjr1RGA==
X-Received: by 2002:a05:6a00:3498:b0:525:448a:de0 with SMTP id cp24-20020a056a00349800b00525448a0de0mr7210218pfb.85.1656208687625;
        Sat, 25 Jun 2022 18:58:07 -0700 (PDT)
Received: from localhost ([182.211.131.157])
        by smtp.gmail.com with ESMTPSA id w5-20020a623005000000b005251f0985bdsm4379383pfw.179.2022.06.25.18.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 18:58:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 26 Jun 2022 10:58:04 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <Yre9LO2nj+Hbr67V@mtj.duckdns.org>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jun 25, 2022 at 10:01:35AM -0700, Linus Torvalds wrote:
> On Fri, Jun 24, 2022 at 10:00 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > So, Petr debugged a NULL deref in workqueue code to a spurious wakeup
> > on a newly created kthread.
> 
> What? No. That patch can't be right for several reasons.
> 
> What we call "spurious wakeups" exist, but they are about wakeups that
> happen from being on a _previous_ wait-queue, and having already been
> removed from it.
> 
> They aren't "really" spurious, they are just asynchronous enough (and
> thus unexpected) that you basically should never have a "sleep on
> wait-queue" without then looping and re-testing the condition.

Can you elaborate on this a bit? At least for the standard
wait_event-ish wait blocks, the waiter always does finish_wait()
before leavig a wait. finish_wait() does lockless check on
wq_entry->entry and may or may not grab wq_head->lock. When it does,
it's fully synchronized against the waker. Even when it doesn't, while
the lack of memory ordering on the finish_wait() side may let things
slide a bit, I can't see how it can slide after the set_current_state
in the next wait block.

I'm probably missing sometihng. Is it about bespoke wait mechanisms?
Can you give a concrete example of an async wakeup scenario?

> There is no _truly_ spurious wakeup. You were always woken up for a
> reason, it's just that there are more reasons than the entirely
> obvious ones.

So, the deferred wakeups from earlier waits are one. Can you give some
other examples? This is something which has always bothered me and I
couldn't find explanations which aren't hand-wavy on my own. It'd be
really great to have clarity.

> For example, the reason that quoted patch cannot be right is that this
> code pattern:
> 
>   while (wait_for_completion_interruptible(&worker->ready_to_start))
>     ;
> 
> is not valid kernel code. EVER. There is absolutely no way that can be correct.
>
> Either that code can take a signal, or it cannot. If it can take a
> signal, it had better react to said signal. If it cannot, it must not
> use an interruptble sleep - since now that loop turned into a
> kernel-side busy-loop.
> 
> So NAK on this kind of crazy "I don't know what happened, so I'll just
> add *more* bugs to the code" voodoo programming.
>
> And no, we don't "fix" that by then adding a timeout.

Yeah, I should've been more explicit on this. Michal already pointed
out that it doesn't make sense to loop over interruptible timed sleeps
and it should use one plain uninterruptible sleep, so this part isn't
in question.

...
> I think the problem here is much more fundamental: you expect a new
> thread to not wake up until you've told it to.
> 
> We do have that infrastructure in the kernel: when  you create a new
> thread, you can do various setup, and the thread won't actually run
> until you do "wake_up_new_task()" on it.

That's because that's the only thing which ignores TASK_NEW, right?

> However, that's not how kernel_thread() (or kernel_clone()) works.
> Those will call wake_up_new_task(p) for you, and as such a new kernel
> thread will immediately start running.
> 
> So I think the expectations here are entirely wrong.  I think
> create_worker() is fundamentally buggy, in how it does that
> 
>         /* start the newly created worker */
>         ..
>         wake_up_process(worker->task);
> 
> because that wake_up_process() is already much too late. The process
> got woken up already, because it was created by create_kthread() ->
> kernel_thread() -> kernel_clone, which does that wake_up_new_task()
> and it starts running.

A couple things still aren't clear for me.

* If there are no true spurious wakeups, where did the racing wakeup
  come from? The task just got created w/ TASK_NEW and woken up once
  with wake_up_new_task(). It hasn't been on any wait queue or
  advertised itself to anything.

* If there are spurious wakeups, why is kthread() scheduling after
  signaling creation completion in the first place? As I wrote before,
  all it would do is masking these bugs. If we can't gurantee that the
  kthread will stay blocked, shouldn't we just remove the
  schedule_preempt_disabled() call in kthread()?

Thanks.

-- 
tejun
