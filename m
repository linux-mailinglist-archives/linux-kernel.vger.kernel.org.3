Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02014B1B97
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbiBKBre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:47:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiBKBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:47:31 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3AD5F99;
        Thu, 10 Feb 2022 17:47:31 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:36220)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIL22-000byL-FN; Thu, 10 Feb 2022 18:47:30 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:51922 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIL20-00FHr4-Vy; Thu, 10 Feb 2022 18:47:30 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220210025321.787113-1-keescook@chromium.org>
        <871r0a8u29.fsf@email.froward.int.ebiederm.org>
        <202202101033.9C04563D9@keescook>
        <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
        <202202101137.B48D02138@keescook>
        <87k0e249tt.fsf@email.froward.int.ebiederm.org>
        <202202101710.668EDCDC@keescook>
Date:   Thu, 10 Feb 2022 19:47:00 -0600
In-Reply-To: <202202101710.668EDCDC@keescook> (Kees Cook's message of "Thu, 10
        Feb 2022 17:26:27 -0800")
Message-ID: <875ypm41kb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nIL20-00FHr4-Vy;;;mid=<875ypm41kb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/nqHJ51IsUdPOo+T0IvmYOwyxWQ2BNMiM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 798 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 14 (1.7%), b_tie_ro: 12 (1.5%), parse: 2.5 (0.3%),
         extract_message_metadata: 28 (3.5%), get_uri_detail_list: 9 (1.1%),
        tests_pri_-1000: 23 (2.8%), tests_pri_-950: 1.82 (0.2%),
        tests_pri_-900: 1.45 (0.2%), tests_pri_-90: 116 (14.5%), check_bayes:
        112 (14.0%), b_tokenize: 20 (2.5%), b_tok_get_all: 16 (1.9%),
        b_comp_prob: 5 (0.7%), b_tok_touch_all: 63 (7.9%), b_finish: 1.37
        (0.2%), tests_pri_0: 596 (74.6%), check_dkim_signature: 1.16 (0.1%),
        check_dkim_adsp: 4.0 (0.5%), poll_dns_idle: 1.19 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Feb 10, 2022 at 04:48:30PM -0600, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Thu, Feb 10, 2022 at 12:58:07PM -0600, Eric W. Biederman wrote:
>> >> Kees Cook <keescook@chromium.org> writes:
>> >> 
>> >> > On Thu, Feb 10, 2022 at 12:17:50PM -0600, Eric W. Biederman wrote:
>> >> >> Kees Cook <keescook@chromium.org> writes:
>> >> >> 
>> >> >> > Hi,
>> >> >> >
>> >> >> > This fixes the signal refactoring to actually kill unkillable processes
>> >> >> > when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
>> >> >> > report and Eric for the fix! I've also tweaked seccomp internal a bit to
>> >> >> > fail more safely. This was a partial seccomp bypass, in the sense that
>> >> >> > SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
>> >> >> > aspects of the filters. (i.e. the syscall was still blocked, etc.)
>> >> >> 
>> >> >> Any luck on figuring out how to suppress the extra event?
>> >> >
>> >> > I haven't found a good single indicator of a process being in an "I am dying"
>> >> > state, and even if I did, it seems every architecture's exit path would
>> >> > need to add a new test.
>> >> 
>> >> The "I am dying" state for a task is fatal_signal_pending, at least
>> >> before get_signal is reached, for a process there is SIGNAL_GROUP_EXIT.
>> >> Something I am busily cleaning up and making more reliable at the
>> >> moment.
>> >
>> > The state I need to catch is "I am dying and this syscall was
>> > interrupted". fatal_signal_pending() is kind of only the first half
>> > (though it doesn't cover fatal SIGSYS?)
>> >
>> > For example, if a process hits a BUG() in the middle of running a
>> > syscall, that syscall isn't expected to "exit" from the perspective of
>> > userspace. This is similarly true for seccomp's fatal SIGSYS.
>> >
>> >> What is the event that is happening?  Is it
>> >> tracehook_report_syscall_exit or something else?
>> >
>> > Yes, but in more completely, it's these three, which are called in
>> > various fashions from architecture syscall exit code:
>> >
>> > 	audit_syscall_exit()		(audit)
>> > 	trace_sys_exit()		(see "TRACE_EVENT_FN(sys_exit,")
>> > 	tracehook_report_syscall_exit()	(ptrace)
>> >
>> >> From the bits I have seen it seems like something else.
>> >
>> > But yes, the place Robert and I both noticed it was with ptrace from
>> > tracehook_report_syscall_exit(), which is rather poorly named. :)
>> 
>> Speaking of patches I am just about to send out.
>> 
>> > Looking at the results, audit_syscall_exit() and trace_sys_exit() need
>> > to be skipped too, since they would each be reporting potential nonsense.
>> >
>> >> > The best approach seems to be clearing the TIF_*WORK* bits, but that's
>> >> > still a bit arch-specific. And I'm not sure which layer would do that.
>> >> > At what point have we decided the process will not continue? More
>> >> > than seccomp was calling do_exit() in the middle of a syscall, but those
>> >> > appear to have all been either SIGKILL or SIGSEGV?
>> >> 
>> >> This is where I get confused what TIF_WORK bits matter?
>> >
>> > This is where I wish all the architectures were using the common syscall
>> > code. The old do_exit() path would completely skip _everything_ in the
>> > exit path, so it was like never calling anything after the syscall
>> > dispatch table. The only userspace visible things in there are triggered
>> > from having TIF_WORK... flags (but again, it's kind of a per-arch mess).
>> >
>> > Skipping the entire exit path makes a fair bit of sense. For example,
>> > rseq_syscall() is redundant (forcing SIGSEGV).
>> >
>> > Regardless, at least the three places above need to be skipped.
>> >
>> > But just testing fatal_signal_pending() seems wrong: a normal syscall
>> > could be finishing just fine, it just happens to have a fatal signal
>> > ready to be processed.
>> 
>> Yes.  It is really just the HANDLER_EXIT case where this is interesting.
>
> Right.
>
>> 
>> >
>> > Here's the ordering after a syscall on x86 from do_syscall_64():
>> >
>> > do_syscall_x64()
>> > 	sys_call_table[...](regs)
>> > syscall_exit_to_user_mode()
>> > 	__syscall_exit_to_user_mode_work()
>> > 		syscall_exit_to_user_mode_prepare()
>> > 			syscall_exit_work()
>> > 				arch_syscall_exit_tracehook()
>> > 					tracehook_report_syscall_exit()
>> > 	exit_to_user_mode_prepare()
>> > 		exit_to_user_mode_loop()
>> > 			handle_signal_work()
>> > 				arch_do_signal_or_restart()
>> > 					get_signal()
>> > 						do_group_exit()
>> >
>> > Here's arm64 from el0_svc():
>> >
>> > do_el0_svc()
>> > 	el0_svc_common()
>> > 		invoke_syscall()
>> > 			syscall_table[...](regs)
>> > 		syscall_trace_exit()
>> > 			tracehook_report_syscall()
>> > 				tracehook_report_syscall_exit()
>> > exit_to_user_mode()
>> > 	prepare_exit_to_user_mode()
>> > 		do_notify_resume()
>> > 			do_signal()
>> > 				get_signal()
>> > 					do_group_exit()
>> >
>> > In the past, any do_exit() would short circuit everything after the
>> > syscall table. Now, we do all the exit work before starting the return
>> > to user mode which is what processes the signals. So I guess there's
>> > more precisely a difference between "visible to userspace" and "return
>> > to userspace".
>> 
>> Yes.  I see that now.  I had not had an occasion to look at the order
>> all of these were called in before and my mental model was wrong.
>
> Yeah, I didn't even have a model of this all the way. I'd really only
> understood the ptrace side of it.
>
>> It makes a certain kind of sense that the per syscall work happens
>> before we do additional things like process signals.  It simply
>> had not realized that was happening in that order until now.
>> 
>> 
>> > (an aside: where to PF_IO_WORKER threads die?)
>> 
>> They are calling do_exit explicitly.
>
> Ah-ha, thanks.
>
>> 
>> >> I expect if anything else mattered we would need to change it to
>> >> HANDLER_EXIT.
>> >> 
>> >> I made a mistake conflating to cases and I want to make certain I
>> >> successfully separate those two cases at the end of the day.
>> >
>> > For skipping the exit work, I'm not sure it matters, since all the
>> > signal stuff is "too late"...
>> 
>> The conflation lead me to believe that we could simply and safely cause
>> seccomp to use normal signal delivery to kill the process.  The first
>> part of the conflation I sorted out by introducing HANDLER_EXIT.  The
>> user visible part of the change I am not yet certain what to do with.
>> 
>> My gut reaction is does it matter?  Can you escape the seccomp filter
>> with a stop?  Does it break userspace?
>
> After fixing UNKILLABLE vs IMMUTABLE, I'm not aware of anything else
> misbehaving. The new nonsense exit event, though, is bound to be at
> least confusing to humans. ("Why did this syscall not change any of its
> registers?", etc.)
>
>> I realize the outcome of that question is that it does matter so we
>> probably need to find a way to supress that situation for HANDLER_EXIT.
>> Both force_exit_sig and force_sig_seccomp appear to be using dumpable
>> signals which makes the problem doubly tricky.
>> 
>> The first tricky bit is fatal_signal_pending isn't set because a
>> coredump is possible, so something else is needed to detect this
>> condition.
>> 
>> The second part is what to do when we detect the condition.
>> 
>> The only solution I can think of quickly is to modify
>> force_sig_info_to_task clear TIF_SYSCALL_WORK on the architectures where
>> that is used and to clear SYSCALL_WORK_EXIT on x86 and s390, and to do
>> whatever the architecture appropriate thing is on the other
>> architectures.
>
> The common accessors for the bits are set_syscall_work()/clear_syscall_work()
> but I don't see anything to operate on an entire mask. Maybe it needs to
> grow something like reset_syscall_work()?

Oh.  I hadn't realized SYSCALL_WORK_EXIT and TIF_SYSCALL_WORK were
masks.  Yes it looks like a simple addition of reset_syscall_work()
and calling it from force_sig_info when HANDLER_EXIT will hide these
events.

When you say the events are corrupted did you mean they return wrong data
to userspace or simply that the events should not fire?

I am trying to figure out if there is a case to be made that it was a
bug that these events were missing.

Eric
