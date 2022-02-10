Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A714B1731
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbiBJUnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:43:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbiBJUnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:43:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EED2715
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:43:16 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i6so10472512pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QlvpL06sSF538LwYXzYPCEIIij9apYwUXPaSBgy/9L0=;
        b=HT+TLJD/EocDW7PdqJkMwM6KeonTIMmCzqT5cV2G7W1TvmGmlUMXNXQ8elgP2JN+Ts
         o3pIBzFs0o7FDSvhkC5a3V37HeSm0jQYkcg8uV5821CZtjwj1f75nWtW+8wBbhpFAqSS
         BDHOii0srQFAmuDld2vduewR2zX4yq7QgFug4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QlvpL06sSF538LwYXzYPCEIIij9apYwUXPaSBgy/9L0=;
        b=mcgGpgX9TltyrtgS3POrSGk1YtO6CekjLWGm1JyHjmRo7LX00frKBy1vLgfw3n6Bcr
         bAjaPi6mLTN4OyUqMWjpEJ1dk2NIMh6WBOQgbEKgmnE4Vm9V1vzAG4J+rOy4s0lRrS2V
         5ZgXa86OHJc2SNsyHn3RTq8qnzSMzGYH9d792T6ujiRjTX04hABo0IFDTOzgNe/wjMTy
         o4dtT8bN/OCiistQqHErvggb1jG9rhcUJk/MU/Ju4vxz5EIvS6eb10N6l0wB7uu8ZxLU
         L9oVZvNzAUz6Z6T2Qgj6Uxr0PE32gclHCpBKvpO5IqLDOSTHUo7rnF/BnvKkCOq3biyo
         X5LQ==
X-Gm-Message-State: AOAM533Ch2b5qhtz431FlFHfH2OGEC+FCEutlJhVRSoXgxwR3Ll9o0JV
        Jj5kY7v1bTR5uGFLE73oesrcmwZ2fkgWsg==
X-Google-Smtp-Source: ABdhPJwSuZPbt1ficHCguvBEV/XL4lrVschzgKBudbAzZZJSOW+OX62N8me3ZM2iWdPzHxv9JBo1wg==
X-Received: by 2002:a05:6a00:1514:: with SMTP id q20mr9364920pfu.74.1644525795421;
        Thu, 10 Feb 2022 12:43:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f5sm23902040pfc.0.2022.02.10.12.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 12:43:15 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:43:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Robert =?utf-8?B?xZp3acSZY2tp?= <robert@swiecki.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Message-ID: <202202101137.B48D02138@keescook>
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org>
 <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmnu5z28.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:58:07PM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Feb 10, 2022 at 12:17:50PM -0600, Eric W. Biederman wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >> 
> >> > Hi,
> >> >
> >> > This fixes the signal refactoring to actually kill unkillable processes
> >> > when receiving a fatal SIGSYS from seccomp. Thanks to Robert for the
> >> > report and Eric for the fix! I've also tweaked seccomp internal a bit to
> >> > fail more safely. This was a partial seccomp bypass, in the sense that
> >> > SECCOMP_RET_KILL_* didn't kill the process, but it didn't bypass other
> >> > aspects of the filters. (i.e. the syscall was still blocked, etc.)
> >> 
> >> Any luck on figuring out how to suppress the extra event?
> >
> > I haven't found a good single indicator of a process being in an "I am dying"
> > state, and even if I did, it seems every architecture's exit path would
> > need to add a new test.
> 
> The "I am dying" state for a task is fatal_signal_pending, at least
> before get_signal is reached, for a process there is SIGNAL_GROUP_EXIT.
> Something I am busily cleaning up and making more reliable at the
> moment.

The state I need to catch is "I am dying and this syscall was
interrupted". fatal_signal_pending() is kind of only the first half
(though it doesn't cover fatal SIGSYS?)

For example, if a process hits a BUG() in the middle of running a
syscall, that syscall isn't expected to "exit" from the perspective of
userspace. This is similarly true for seccomp's fatal SIGSYS.

> What is the event that is happening?  Is it
> tracehook_report_syscall_exit or something else?

Yes, but in more completely, it's these three, which are called in
various fashions from architecture syscall exit code:

	audit_syscall_exit()		(audit)
	trace_sys_exit()		(see "TRACE_EVENT_FN(sys_exit,")
	tracehook_report_syscall_exit()	(ptrace)

> From the bits I have seen it seems like something else.

But yes, the place Robert and I both noticed it was with ptrace from
tracehook_report_syscall_exit(), which is rather poorly named. :)

Looking at the results, audit_syscall_exit() and trace_sys_exit() need
to be skipped too, since they would each be reporting potential nonsense.

> > The best approach seems to be clearing the TIF_*WORK* bits, but that's
> > still a bit arch-specific. And I'm not sure which layer would do that.
> > At what point have we decided the process will not continue? More
> > than seccomp was calling do_exit() in the middle of a syscall, but those
> > appear to have all been either SIGKILL or SIGSEGV?
> 
> This is where I get confused what TIF_WORK bits matter?

This is where I wish all the architectures were using the common syscall
code. The old do_exit() path would completely skip _everything_ in the
exit path, so it was like never calling anything after the syscall
dispatch table. The only userspace visible things in there are triggered
from having TIF_WORK... flags (but again, it's kind of a per-arch mess).

Skipping the entire exit path makes a fair bit of sense. For example,
rseq_syscall() is redundant (forcing SIGSEGV).

Regardless, at least the three places above need to be skipped.

But just testing fatal_signal_pending() seems wrong: a normal syscall
could be finishing just fine, it just happens to have a fatal signal
ready to be processed.

Here's the ordering after a syscall on x86 from do_syscall_64():

do_syscall_x64()
	sys_call_table[...](regs)
syscall_exit_to_user_mode()
	__syscall_exit_to_user_mode_work()
		syscall_exit_to_user_mode_prepare()
			syscall_exit_work()
				arch_syscall_exit_tracehook()
					tracehook_report_syscall_exit()
	exit_to_user_mode_prepare()
		exit_to_user_mode_loop()
			handle_signal_work()
				arch_do_signal_or_restart()
					get_signal()
						do_group_exit()

Here's arm64 from el0_svc():

do_el0_svc()
	el0_svc_common()
		invoke_syscall()
			syscall_table[...](regs)
		syscall_trace_exit()
			tracehook_report_syscall()
				tracehook_report_syscall_exit()
exit_to_user_mode()
	prepare_exit_to_user_mode()
		do_notify_resume()
			do_signal()
				get_signal()
					do_group_exit()

In the past, any do_exit() would short circuit everything after the
syscall table. Now, we do all the exit work before starting the return
to user mode which is what processes the signals. So I guess there's
more precisely a difference between "visible to userspace" and "return
to userspace".

(an aside: where to PF_IO_WORKER threads die?)

> I expect if anything else mattered we would need to change it to
> HANDLER_EXIT.
> 
> I made a mistake conflating to cases and I want to make certain I
> successfully separate those two cases at the end of the day.

For skipping the exit work, I'm not sure it matters, since all the
signal stuff is "too late"...

-- 
Kees Cook
