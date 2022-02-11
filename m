Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682EE4B1B39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbiBKB0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:26:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346826AbiBKB03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:26:29 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D05F63
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:26:28 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t36so2631858pfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oVgG8kJKF3TGNg1bEgFU5YNfmzImWlJ4/uy7G/TCCiU=;
        b=I8vja9AnhdHr+kaWE55JFnEmQ7Tsd5rtU8bYY0vPhMIBtGl6qNnW2DLPC5dup4oO9j
         b3ebYn5vPcXJQ8d1LJM5Z3MheJeD+qmx+t1MBTYN5jwTkCWmPbeWUppRHBrMPSVTZeDr
         lr+ZHkXhhJNxhc2I2bRYMmgC+JogYPvULtW+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oVgG8kJKF3TGNg1bEgFU5YNfmzImWlJ4/uy7G/TCCiU=;
        b=HwRWEdR8WWB/BpXuOP9K/J1aj/U+PiLdMbJqx/snDFp+DCNge2vNX2SOKglnwgl/A/
         qw6Dl26Zi665LmvcX9cT8CTA24bPF4tTP2HdDxYUDd8KnmwvkdU/Ru/kSYOfjoeoz71R
         JLNzBfuyFCxKtx4LEXvQNkIGLSmmayJkQ7+/o+gqraTU4v2Xl2VMsQFUBnfg2I3h/IVT
         IQviqnANmDFVBICav+NP0ht4K+b4VzrofGqR/fkuALkGlop3qVcigglKTQqDBYnLTn8F
         m+v6Hm3LoooiFU0fF7ttEB4dcM5WZDnvPWse16IROEWIo+1f/fDPl2fKkfI7sHJYJoZ6
         xVIQ==
X-Gm-Message-State: AOAM532tvpGZBRbmfdbWogcGPMd6N3B7fu5VP6cBiSlFA3iimCGTQ2o/
        D8FWm671A7QNq9WpBEugfWVA+w==
X-Google-Smtp-Source: ABdhPJw/LCc8CzPGzA2Ym4ePLqc1xkdK4depRZeOCX6qIaGOCx2Cx+thaiHw2eOkNpP30r5XdlNE1g==
X-Received: by 2002:aa7:8241:: with SMTP id e1mr10283611pfn.86.1644542788302;
        Thu, 10 Feb 2022 17:26:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4sm25200781pfu.90.2022.02.10.17.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 17:26:28 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:26:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <202202101710.668EDCDC@keescook>
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org>
 <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
 <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0e249tt.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 04:48:30PM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Feb 10, 2022 at 12:58:07PM -0600, Eric W. Biederman wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >> 
> >> > On Thu, Feb 10, 2022 at 12:17:50PM -0600, Eric W. Biederman wrote:
> >> >> Kees Cook <keescook@chromium.org> writes:
> >> >> 
> >> >> > Hi,
> >> >> >
> >> >> > This fixes the signal refactoring to actually kill unkillable processes
> >> >> > when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
> >> >> > report and Eric for the fix! I've also tweaked seccomp internal a bit to
> >> >> > fail more safely. This was a partial seccomp bypass, in the sense that
> >> >> > SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
> >> >> > aspects of the filters. (i.e. the syscall was still blocked, etc.)
> >> >> 
> >> >> Any luck on figuring out how to suppress the extra event?
> >> >
> >> > I haven't found a good single indicator of a process being in an "I am dying"
> >> > state, and even if I did, it seems every architecture's exit path would
> >> > need to add a new test.
> >> 
> >> The "I am dying" state for a task is fatal_signal_pending, at least
> >> before get_signal is reached, for a process there is SIGNAL_GROUP_EXIT.
> >> Something I am busily cleaning up and making more reliable at the
> >> moment.
> >
> > The state I need to catch is "I am dying and this syscall was
> > interrupted". fatal_signal_pending() is kind of only the first half
> > (though it doesn't cover fatal SIGSYS?)
> >
> > For example, if a process hits a BUG() in the middle of running a
> > syscall, that syscall isn't expected to "exit" from the perspective of
> > userspace. This is similarly true for seccomp's fatal SIGSYS.
> >
> >> What is the event that is happening?  Is it
> >> tracehook_report_syscall_exit or something else?
> >
> > Yes, but in more completely, it's these three, which are called in
> > various fashions from architecture syscall exit code:
> >
> > 	audit_syscall_exit()		(audit)
> > 	trace_sys_exit()		(see "TRACE_EVENT_FN(sys_exit,")
> > 	tracehook_report_syscall_exit()	(ptrace)
> >
> >> From the bits I have seen it seems like something else.
> >
> > But yes, the place Robert and I both noticed it was with ptrace from
> > tracehook_report_syscall_exit(), which is rather poorly named. :)
> 
> Speaking of patches I am just about to send out.
> 
> > Looking at the results, audit_syscall_exit() and trace_sys_exit() need
> > to be skipped too, since they would each be reporting potential nonsense.
> >
> >> > The best approach seems to be clearing the TIF_*WORK* bits, but that's
> >> > still a bit arch-specific. And I'm not sure which layer would do that.
> >> > At what point have we decided the process will not continue? More
> >> > than seccomp was calling do_exit() in the middle of a syscall, but those
> >> > appear to have all been either SIGKILL or SIGSEGV?
> >> 
> >> This is where I get confused what TIF_WORK bits matter?
> >
> > This is where I wish all the architectures were using the common syscall
> > code. The old do_exit() path would completely skip _everything_ in the
> > exit path, so it was like never calling anything after the syscall
> > dispatch table. The only userspace visible things in there are triggered
> > from having TIF_WORK... flags (but again, it's kind of a per-arch mess).
> >
> > Skipping the entire exit path makes a fair bit of sense. For example,
> > rseq_syscall() is redundant (forcing SIGSEGV).
> >
> > Regardless, at least the three places above need to be skipped.
> >
> > But just testing fatal_signal_pending() seems wrong: a normal syscall
> > could be finishing just fine, it just happens to have a fatal signal
> > ready to be processed.
> 
> Yes.  It is really just the HANDLER_EXIT case where this is interesting.

Right.

> 
> >
> > Here's the ordering after a syscall on x86 from do_syscall_64():
> >
> > do_syscall_x64()
> > 	sys_call_table[...](regs)
> > syscall_exit_to_user_mode()
> > 	__syscall_exit_to_user_mode_work()
> > 		syscall_exit_to_user_mode_prepare()
> > 			syscall_exit_work()
> > 				arch_syscall_exit_tracehook()
> > 					tracehook_report_syscall_exit()
> > 	exit_to_user_mode_prepare()
> > 		exit_to_user_mode_loop()
> > 			handle_signal_work()
> > 				arch_do_signal_or_restart()
> > 					get_signal()
> > 						do_group_exit()
> >
> > Here's arm64 from el0_svc():
> >
> > do_el0_svc()
> > 	el0_svc_common()
> > 		invoke_syscall()
> > 			syscall_table[...](regs)
> > 		syscall_trace_exit()
> > 			tracehook_report_syscall()
> > 				tracehook_report_syscall_exit()
> > exit_to_user_mode()
> > 	prepare_exit_to_user_mode()
> > 		do_notify_resume()
> > 			do_signal()
> > 				get_signal()
> > 					do_group_exit()
> >
> > In the past, any do_exit() would short circuit everything after the
> > syscall table. Now, we do all the exit work before starting the return
> > to user mode which is what processes the signals. So I guess there's
> > more precisely a difference between "visible to userspace" and "return
> > to userspace".
> 
> Yes.  I see that now.  I had not had an occasion to look at the order
> all of these were called in before and my mental model was wrong.

Yeah, I didn't even have a model of this all the way. I'd really only
understood the ptrace side of it.

> It makes a certain kind of sense that the per syscall work happens
> before we do additional things like process signals.  It simply
> had not realized that was happening in that order until now.
> 
> 
> > (an aside: where to PF_IO_WORKER threads die?)
> 
> They are calling do_exit explicitly.

Ah-ha, thanks.

> 
> >> I expect if anything else mattered we would need to change it to
> >> HANDLER_EXIT.
> >> 
> >> I made a mistake conflating to cases and I want to make certain I
> >> successfully separate those two cases at the end of the day.
> >
> > For skipping the exit work, I'm not sure it matters, since all the
> > signal stuff is "too late"...
> 
> The conflation lead me to believe that we could simply and safely cause
> seccomp to use normal signal delivery to kill the process.  The first
> part of the conflation I sorted out by introducing HANDLER_EXIT.  The
> user visible part of the change I am not yet certain what to do with.
> 
> My gut reaction is does it matter?  Can you escape the seccomp filter
> with a stop?  Does it break userspace?

After fixing UNKILLABLE vs IMMUTABLE, I'm not aware of anything else
misbehaving. The new nonsense exit event, though, is bound to be at
least confusing to humans. ("Why did this syscall not change any of its
registers?", etc.)

> I realize the outcome of that question is that it does matter so we
> probably need to find a way to supress that situation for HANDLER_EXIT.
> Both force_exit_sig and force_sig_seccomp appear to be using dumpable
> signals which makes the problem doubly tricky.
> 
> The first tricky bit is fatal_signal_pending isn't set because a
> coredump is possible, so something else is needed to detect this
> condition.
> 
> The second part is what to do when we detect the condition.
> 
> The only solution I can think of quickly is to modify
> force_sig_info_to_task clear TIF_SYSCALL_WORK on the architectures where
> that is used and to clear SYSCALL_WORK_EXIT on x86 and s390, and to do
> whatever the architecture appropriate thing is on the other
> architectures.

The common accessors for the bits are set_syscall_work()/clear_syscall_work()
but I don't see anything to operate on an entire mask. Maybe it needs to
grow something like reset_syscall_work()?

-Kees

> 
> It might be easier once I have cleaned some more code up but as long as
> we can limit the logic to force_sig_info_to_task for the HANDLER_EXIT
> case I don't see any advantage in the cleanups I have planned for this
> case.  This may be incentive to make the architecture code more uniform
> in this area.
> 
> Anyway I am off to finish fixing some other bugs.
> 
> Eric
> 
> 

-- 
Kees Cook
