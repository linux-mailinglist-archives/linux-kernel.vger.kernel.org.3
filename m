Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9158D4A62AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbiBARjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiBARjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:39:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD8C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:39:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f10so8919331lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2RtINAvBUuXt8OeZLlVMDRjvDhcox8XDes9rrA+3K8=;
        b=dCJUNWSYmdCY6qUBbV49KkqHnIgkeQYnI+Onv7D6M+TYCeMkzLBexSzIKu5Qo9gl+6
         7Vte/YeOQWcfmJ4a/P5me3jj4mJVhf7Cf8KPpWj79irG3+taWy02XumZK5Kr6D1r6NvL
         exOj+vMIY5FGwxCYRpoUK5PN09RA1z0XysamEAJ5k/2e7aYLna+yuyUOhXIZvH2Eid7s
         ChEjRCrnhftOkO1flW+gkoGzLtpXZ3rytxJMsJUGaO6rnek56+KSOLEeoO+C7g9xa53N
         tTQLVBl2xWWjh0cxliYoaf1jqMhBENlCFvIS4NUEoXsTvUMeUOwFVtUiTFRLQaO3zaHK
         cIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2RtINAvBUuXt8OeZLlVMDRjvDhcox8XDes9rrA+3K8=;
        b=h7VxlAiUY1RsYTfArbGMGk+GEaW0/+ZSeliYIJNe6QxNmZiB1EyVk4XrVKKbAkYbke
         ubbPi3ap5OsNT0ZdOfqKoHZdU3gC1I2XXRKIhNMXDHIJnQcryMAztks370gyK5I+MvW+
         GZqP+0QocoSmAI1oPdnfz5jyBmkIGCIAlYI1OaNbi20QT8iW4SLGRzWOXZYtlZoWnewF
         g2kk8MCpgPjFLWZSQSriMgv/LwpzRcfCk5g7SOSPXa4+l3jJOqcJwVK7smGFQMHnQrlZ
         Ic4pKEPCp22hsj7GrvrcMYi0hBCtdbUhgk/KsMWf2cDy6CxEtZOxYDvfiErXo3crgCs/
         /V/A==
X-Gm-Message-State: AOAM530Jb/+z/pKoYT968RYvDxmtsoeOwqO1bhw+HVYp+l52AEEjL7Yq
        jakB0nUW1xqMHslIDydvWLoieo2gVxi0DRXDSDD9jg==
X-Google-Smtp-Source: ABdhPJyKs0ioog20ySTqtbWS0kS4ORnisTdRLx8YD3s3aVHdNkHyRc4vm0dHqTsB6MUsQo9GFYFUJP34QAqp649ESOc=
X-Received: by 2002:a05:6512:441:: with SMTP id y1mr19590455lfk.315.1643737148846;
 Tue, 01 Feb 2022 09:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20220127005555.2766254-1-jannh@google.com> <20220201003025.yb2wpmw4dprmsdww@treble>
In-Reply-To: <20220201003025.yb2wpmw4dprmsdww@treble>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Feb 2022 18:38:42 +0100
Message-ID: <CAG48ez19qy0s2gnSWEtoF-C57uumdBb8gfoe41-JjqBcJ-5KvQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/dumpstack: Fix unwind failure due to off-by-one-frame
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 1:30 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Jan 27, 2022 at 01:55:55AM +0100, Jann Horn wrote:
> > (emphasis on the "RFC", not the "PATCH"...)
> >
> > I've hit a bug where __dump_stack() ends up printing a stack trace that
> > consists purely of guesses (all printed frames start with "? ").
> >
> > Debugging the issue, I found that show_trace_log_lvl() is looking at a
> > stack that looks like this:
> >
> >     function             stored value    pointer in show_trace_log_lvl()
> >     ====================================================================
> >             show_stack   saved RIP
> >             show_stack   saved RBP       <-- stack
> >     show_trace_log_lvl   saved RIP       <-- unwind_get_return_address_ptr(...)
> >     show_trace_log_lvl   ...
> >     show_trace_log_lvl   ...
> >
> > show_trace_log_lvl() then iterates up the stack with its `stack`
> > variable; but because `unwind_get_return_address_ptr(&state)` is below the
> > starting point, the two never compile equal, and so `reliable` is never
> > set to 1.
>
> Thanks for reporting!  If I understand correctly, this only happens
> when show_stack() has an 8-byte stack size.

Yes, I think so. (Well, 16 bytes if you count the saved RIP at the top
as part of the frame.)

I just realized that this probably happened to me because I was
compiling with -fno-optimize-sibling-calls (to make stack traces more
readable, because sibling call optimization effectively makes stack
frames randomly disappear, which I find very frustrating).

> > Poking around a bit, I see two issues.
> >
> > The first issue is that __unwind_start() tries to figure out whether
> > `first_frame` is inside the current frame before even having looked up
> > the ORC entry that determines where the current frame ends.
> > That can't work and results in being off-by-one-frame in some cases no
> > matter how we twist the comparison between `state->sp` and `first_frame`.
>
> > The second issue is that show_trace_log_lvl() asks __unwind_start() to
> > stop when it finds the frame containing `stack`, but then tries
> > comparing `unwind_get_return_address_ptr(&state)` (which has to be below
> > `stack`, since it is part of the lower frame) with `stack`.
> > That can't work if __unwind_start() is working properly - we'll have to
> > unwind up another frame.
> >
> > This patch is an attempt to fix that, but I guess there might still be
> > issues with it in the interaction with show_regs_if_on_stack() in
> > show_trace_log_lvl(), or something like that?
> >
> > Another option might be to rework even more how ORC stack walking works,
> > and always compute the location of the next frame in __unwind_start()
> > and unwind_next(), such that it becomes possible to query for the top
> > of the current frame?
> >
> > Or a completely different approach, do more special-casing of different
> > unwinding scenarios in __unwind_start(), such that unwinding a remote
> > task doesn't go through the skip-ahead loop, and unwinding the current
> > task from a starting point is always guaranteed to skip the given frame
> > and stop at the following one? Or something along those lines?
> >
> > That would also make it more obviously correct what happens if a
> > function specifies its own frame as the starting point wrt to changes to
> > that frame's contents before the call to unwind_next()... now that I'm
> > typing this out, I think that might be the best option?
>
> If I understand correctly, this last proposal is what the current
> __unwind_start() code already attempts to do (but obviously fails in the
> above off-by-one case).  It tries to start at the first frame it finds
> *beyond* the given 'first_frame' pointer, rather than the frame
> including it.  That makes the logic simpler, since you don't have to
> find the size of the frame.

Ahh, okay. I missed that those were the intended semantics...


> So I think this bug could be fixed by reverting commit f1d9a2abff66
> ("x86/unwind/orc: Don't skip the first frame for inactive tasks").
>
> Can you confirm?

Yes.

When compiling with "gcc (Debian 11.2.0-13) 11.2.0" and
"-fno-optimize-sibling-calls", "echo l > /proc/sysrq-trigger" prints
an all-guesses trace for the current CPU:

[   99.465299][  T598] sysrq: Show backtrace of all active CPUs
[   99.466130][  T598] NMI backtrace for cpu 0
[   99.466533][  T598] CPU: 0 PID: 598 Comm: bash Not tainted
5.17.0-rc1-00082-g81c3649a14a2-dirty #944
[   99.467602][  T598] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   99.468511][  T598] Call Trace:
[   99.468927][  T598]  <TASK>
[   99.469268][  T598]  ? dump_stack_lvl+0x45/0x59
[   99.469807][  T598]  ? dump_stack+0xc/0xd
[   99.470284][  T598]  ? nmi_cpu_backtrace.cold+0xa4/0xa9
[   99.470760][  T598]  ? lapic_can_unplug_cpu+0x80/0x80
[   99.471330][  T598]  ? nmi_trigger_cpumask_backtrace+0x10e/0x140
[   99.471889][  T598]  ? arch_trigger_cpumask_backtrace+0x15/0x20
[   99.472427][  T598]  ? sysrq_handle_showallcpus+0x13/0x20
[   99.472970][  T598]  ? __handle_sysrq.cold+0x11c/0x37b
[   99.473450][  T598]  ? write_sysrq_trigger+0x3f/0x50
[   99.473963][  T598]  ? proc_reg_write+0x1b3/0x270
[   99.474408][  T598]  ? vfs_write+0x1c7/0x920
[   99.474920][  T598]  ? ksys_write+0xf9/0x1d0
[   99.475507][  T598]  ? __ia32_sys_read+0xb0/0xb0
[   99.476467][  T598]  ? lock_is_held_type+0xd7/0x130
[   99.477071][  T598]  ? syscall_enter_from_user_mode+0x1d/0x50
[   99.477708][  T598]  ? __x64_sys_write+0x6e/0xb0
[   99.478216][  T598]  ? syscall_enter_from_user_mode+0x1d/0x50
[   99.479137][  T598]  ? do_syscall_64+0x43/0x90
[   99.479576][  T598]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[   99.480172][  T598]  </TASK>
[   99.480649][  T598] Sending NMI from CPU 0 to CPUs 1-3:

With f1d9a2abff66 reverted:

[   92.114861][  T598] sysrq: Show backtrace of all active CPUs
[   92.115989][  T598] NMI backtrace for cpu 2
[   92.116448][  T598] CPU: 2 PID: 598 Comm: bash Not tainted
5.17.0-rc1-00083-gc0df0cbee2c5-dirty #945
[   92.117493][  T598] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   92.118290][  T598] Call Trace:
[   92.118598][  T598]  <TASK>
[   92.118860][  T598]  dump_stack_lvl+0x45/0x59
[   92.119363][  T598]  dump_stack+0xc/0xd
[   92.119727][  T598]  nmi_cpu_backtrace.cold+0xa4/0xa9
[   92.120183][  T598]  ? lapic_can_unplug_cpu+0x80/0x80
[   92.120655][  T598]  nmi_trigger_cpumask_backtrace+0x10e/0x140
[   92.121328][  T598]  arch_trigger_cpumask_backtrace+0x15/0x20
[   92.121856][  T598]  sysrq_handle_showallcpus+0x13/0x20
[   92.122467][  T598]  __handle_sysrq.cold+0x11c/0x37b
[   92.122924][  T598]  write_sysrq_trigger+0x3f/0x50
[   92.123357][  T598]  proc_reg_write+0x1b3/0x270
[   92.123773][  T598]  vfs_write+0x1c7/0x920
[   92.124151][  T598]  ksys_write+0xf9/0x1d0
[   92.124523][  T598]  ? __ia32_sys_read+0xb0/0xb0
[   92.124998][  T598]  ? lock_is_held_type+0xd7/0x130
[   92.125512][  T598]  ? syscall_enter_from_user_mode+0x1d/0x50
[   92.127120][  T598]  __x64_sys_write+0x6e/0xb0
[   92.127537][  T598]  ? syscall_enter_from_user_mode+0x1d/0x50
[   92.128051][  T598]  do_syscall_64+0x43/0x90
[   92.128444][  T598]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   92.129046][  T598] RIP: 0033:0x7d8d29a7b504
[   92.129442][  T598] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb
b3 0f 1f 80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55
48 89 f5 53
[   92.131109][  T598] RSP: 002b:00007ffd74467c58 EFLAGS: 00000246
ORIG_RAX: 0000000000000001
[   92.131913][  T598] RAX: ffffffffffffffda RBX: 0000000000000002
RCX: 00007d8d29a7b504
[   92.132682][  T598] RDX: 0000000000000002 RSI: 00007d8d2a6dcfb0
RDI: 0000000000000001
[   92.133460][  T598] RBP: 00007d8d2a6dcfb0 R08: 000000000000000a
R09: 00007d8d29b4cca0
[   92.134219][  T598] R10: 000000000000000a R11: 0000000000000246
R12: 00007d8d29b4d760
[   92.134904][  T598] R13: 0000000000000002 R14: 00007d8d29b48760
R15: 0000000000000002
[   92.135591][  T598]  </TASK>
[   92.135961][  T598] Sending NMI from CPU 2 to CPUs 0-1,3:
