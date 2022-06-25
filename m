Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD29955ABC2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiFYRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiFYRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:36:47 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088DB13E82
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:36:46 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:48900)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o59i7-008oav-Jn; Sat, 25 Jun 2022 11:36:43 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57564 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o59i6-009zRy-7y; Sat, 25 Jun 2022 11:36:43 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20220622140853.31383-1-pmladek@suse.com>
        <YraWWl+Go17uPOgR@mtj.duckdns.org>
        <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
Date:   Sat, 25 Jun 2022 12:36:35 -0500
In-Reply-To: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 25 Jun 2022 10:01:35 -0700")
Message-ID: <874k0863x8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o59i6-009zRy-7y;;;mid=<874k0863x8.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18f03oggKp7wqSO3b0XGSmkTVdHMPE33Qc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 832 ms - load_scoreonly_sql: 0.21 (0.0%),
        signal_user_changed: 14 (1.7%), b_tie_ro: 11 (1.4%), parse: 2.4 (0.3%),
         extract_message_metadata: 25 (3.0%), get_uri_detail_list: 6 (0.7%),
        tests_pri_-1000: 21 (2.6%), tests_pri_-950: 1.77 (0.2%),
        tests_pri_-900: 1.34 (0.2%), tests_pri_-90: 272 (32.7%), check_bayes:
        269 (32.4%), b_tokenize: 14 (1.6%), b_tok_get_all: 12 (1.4%),
        b_comp_prob: 4.3 (0.5%), b_tok_touch_all: 234 (28.1%), b_finish: 1.49
        (0.2%), tests_pri_0: 473 (56.9%), check_dkim_signature: 1.18 (0.1%),
        check_dkim_adsp: 4.4 (0.5%), poll_dns_idle: 0.78 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 12 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: re. Spurious wakeup on a newly created kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 24, 2022 at 10:00 PM Tejun Heo <tj@kernel.org> wrote:
>>
>> So, Petr debugged a NULL deref in workqueue code to a spurious wakeup
>> on a newly created kthread.
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
>
> There is no _truly_ spurious wakeup. You were always woken up for a
> reason, it's just that there are more reasons than the entirely
> obvious ones.
>
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
>
> Stop this "add random code" thing.
>
> If you cannot be woken up before X happens, then you should:
>
>  - don't go to sleep before X happens
>
>  - don't add yourself to any wait-queues before X happens
>
>  - don't expose your process to others before X happens
>
> The solution is *not* to add some completion with random "wait for
> this before waking".
>
> I think the problem here is much more fundamental: you expect a new
> thread to not wake up until you've told it to.
>
> We do have that infrastructure in the kernel: when  you create a new
> thread, you can do various setup, and the thread won't actually run
> until you do "wake_up_new_task()" on it.
>
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
>
> If you want to do thread setup *bnefore* the kernel is running, it
> needs to be done before that wake_up_new_task().
>
> That's very possible. Look at what create_io_thread() does, for
> example: it never calls wake_up_new_process() at all, and leaves that
> to the caller, which has done the extra setup.
>
> Or the kernel_clone_args could have a "init" function that gets called
> before doing the wake_up_new_task() is done. Or a number of other
> solutions.
>
> But no, we're not randomly adding some new completion because people
> were confused and thought they were waking things up when it was
> already awake from before.

Ugh.  The use of kthread_bind_mask is buggy and kthread_bind_mask and
kthread_bind look buggy by definition.  As far as I know the kind of
games that involve wait_task_inactive are only safe in special stop
states which TASK_UNINTERRUPTIBLE is not.

I don't know if we have any current code in the kernel that does this
but I have seen code proposed that for suspend/resume that would wake up
everything not in a special stop state, and have every kernel task
figure out if it should be sleeping or not after such a resume.

This implies that kthread_park needs to be used for this logic to work
at all.  So the only legitimate user of the __kthread_bind and
__kthread_bind_mask appears to be kthread_unpark.



Let me suggest someone create a new variant of kthread_create that takes
all of the parameters the workqueue code wants to set.

Hopefully that will be enough that we can use it to remove the handful
of buggy cases that call kthread_bind_mask and kthread_bind.

Eric

