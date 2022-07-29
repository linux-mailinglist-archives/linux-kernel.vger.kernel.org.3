Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41E5584AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiG2FFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiG2FFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:05:13 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C541145
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:05:11 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:53520)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHIBR-005Cnt-OT; Thu, 28 Jul 2022 23:05:09 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53696 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHIBQ-00D4at-CA; Thu, 28 Jul 2022 23:05:09 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
References: <20220713175305.1327649-1-tycho@tycho.pizza>
        <20220720150328.GA30749@mail.hallyn.com>
        <YthsgqAZYnwHZLn+@tycho.pizza> <20220721015459.GA4297@mail.hallyn.com>
        <YuFdUj5X4qckC/6g@tycho.pizza> <20220727175538.GC18822@redhat.com>
        <YuGBXnqb5rPwAlYk@tycho.pizza> <20220727191949.GD18822@redhat.com>
        <YuGUyayVWDB7R89i@tycho.pizza> <20220728091220.GA11207@redhat.com>
        <YuL9uc8WfiYlb2Hw@tycho.pizza>
Date:   Fri, 29 Jul 2022 00:04:17 -0500
In-Reply-To: <YuL9uc8WfiYlb2Hw@tycho.pizza> (Tycho Andersen's message of "Thu,
        28 Jul 2022 15:20:57 -0600")
Message-ID: <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oHIBQ-00D4at-CA;;;mid=<87pmhofr1q.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+xY1DQDwcgSlpnOL04/GOdO24m7Mn2rX8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 770 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (1.7%), b_tie_ro: 11 (1.4%), parse: 1.61
        (0.2%), extract_message_metadata: 19 (2.5%), get_uri_detail_list: 4.4
        (0.6%), tests_pri_-1000: 18 (2.3%), tests_pri_-950: 1.68 (0.2%),
        tests_pri_-900: 1.28 (0.2%), tests_pri_-90: 173 (22.5%), check_bayes:
        168 (21.9%), b_tokenize: 12 (1.6%), b_tok_get_all: 13 (1.7%),
        b_comp_prob: 4.2 (0.5%), b_tok_touch_all: 134 (17.4%), b_finish: 1.31
        (0.2%), tests_pri_0: 527 (68.4%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 3.4 (0.4%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> On Thu, Jul 28, 2022 at 11:12:20AM +0200, Oleg Nesterov wrote:
>> This is clear, but it seems you do not understand me. Let me try again
>> to explain and please correct me if I am wrong.
>> 
>> To simplify, lets suppose we have a single-thread task T which simply
>> does
>> 	__set_current_state(TASK_KILLABLE);
>> 	schedule();
>> 
>> in the do_exit() paths after exit_signals() which sets PF_EXITING. Btw,
>> note that it even documents that this thread is not "visible" for the
>> group-wide signals, see below.
>> 
>> Now, suppose that this task is running and you send SIGKILL. T will
>> dequeue SIGKILL from T->penging and call do_exit(). However, it won't
>> remove SIGKILL from T->signal.shared_pending(), and this means that
>> signal_pending(T) is still true.
>> 
>> Now. If we add a PF_EXITING or sigismember(shared_pending, SIGKILL) check
>> into __fatal_signal_pending(), then yes, T won't block in schedule(),
>> schedule()->signal_pending_state() will return true.
>> 
>> But what if T exits on its own? It will block in schedule() forever.
>> schedule()->signal_pending_state() will not even check __fatal_signal_pending(),
>> signal_pending() == F.
>> 
>> Now if you send SIGKILL to this task, SIGKILL won't wake it up or even
>> set TIF_SIGPENDING, complete_signal() will do nothing.
>> 
>> See?
>> 
>> I agree, we should probably cleanup this logic and define how exactly
>> the exiting task should react to signals (not only fatal signals). But
>> your patch certainly doesn't look good to me and it is not enough.
>> May be we can change get_signal() to not remove SIGKILL from t->pending
>> for the start... not sure, this needs another discussion.
>
> Thank you for this! Between that and Eric's line about:
>
>> Frankly that there are some left over SIGKILL bits in the pending mask
>> is a misfeature, and it is definitely not something you should count on.
>
> I think I finally maybe understand the objections.
>
> Is it fair to say that a task with PF_EXITING should never wait? I'm
> wondering if a solution would be to patch the wait code to look for
> PF_EXITING, in addition to checking the signal state.

That will at a minimum change zap_pid_ns_processes to busy wait
instead of sleeping while it waits for children to die.

So we would need to survey the waits that can happen when closing file
descriptors and any other place on the exit path to see how much impact
a such a change would do.


It might be possible to allow an extra SIGKILL to terminate such waits.
We do something like that for coredumps.  But that is incredibly subtle
and a pain to maintain so I want to avoid that if we can.


>> Finally. if fuse_flush() wants __fatal_signal_pending() == T when the
>> caller exits, perhaps it can do it itself? Something like
>> 
>> 	if (current->flags & PF_EXITING) {
>> 		spin_lock_irq(siglock);
>> 		set_thread_flag(TIF_SIGPENDING);
>> 		sigaddset(&current->pending.signal, SIGKILL);
>> 		spin_unlock_irq(siglock);
>> 	}
>> 
>> Sure, this is ugly as hell. But perhaps this can serve as a workaround?
>
> or even just
>
>     if (current->flags & PF_EXITING)
>         return;
>
> since we don't have anyone to send the result of the flush to anyway.
> If we don't end up converging on a fix here, I'll just send that
> patch. Thanks for the suggestion.

If that was limited to the case you care about that would be reasonable.

That will have an effect on any time a process that opens files on a
fuse filesystem exits and depends upon the exit path to close it's file
descriptors to the fuse filesystem.


I do see a plausible solution along those lines.

In fuse_flush instead of using fuse_simple_request call an equivalent
function that when PF_EXITING is true skips calling request_wait_answer.
Or perhaps when PF_EXITING is set uses schedule_work to call the
request_wait_answer.

That will allow everything to work as it does today.  It will optimize
the fuse when file descriptors are called on the exit path.  It will
avoid the hang by removing an indefinite wait on userspace.

This should even generalize into the vfs.  I looked and nfs also looks
like it has the potential to optimize out the wait for the result of the
flush.  A correctly implemented flush method looks to flush any
write-back data when the file is closed and to return any errors from
that flush to the caller of close.  For .flush called from the exit path
aka exit_files aka close_files there is no way to place to return an
error status to, so there is no need to wait for the flush to complete.

That said solve I think it makes sense to solve the problem for fuse
first, and the we can figure out support for other filesystems.

Eric

