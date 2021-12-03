Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC43467EE0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383107AbhLCUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:40:59 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:41191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353752AbhLCUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:40:58 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBDvU-1miqWI2Lj4-00Ckh7 for <linux-kernel@vger.kernel.org>; Fri, 03 Dec
 2021 21:37:32 +0100
Received: by mail-wm1-f45.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso3091347wmr.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:37:32 -0800 (PST)
X-Gm-Message-State: AOAM532MojgN58+wO6GcnXKRo6k91ja1IO3XP2OWpOwX83//JWLy7M7z
        IXzLNx4j6+OcLu79fF+yD2sIhdtnJiRPjdnUc+I=
X-Google-Smtp-Source: ABdhPJyyu/mNPIx+gaH9S7TpV6aDPad02G1UIpJnk69+ESFtOrvhAtsJJyy7AdaD1IGK4L5nggu0NbTZZHWfTzeqgh8=
X-Received: by 2002:a7b:c007:: with SMTP id c7mr17806298wmb.82.1638563852156;
 Fri, 03 Dec 2021 12:37:32 -0800 (PST)
MIME-Version: 1.0
References: <163477765570.264901.3851692300287671122.stgit@devnote2> <163477772593.264901.7405996794526239017.stgit@devnote2>
In-Reply-To: <163477772593.264901.7405996794526239017.stgit@devnote2>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Dec 2021 21:37:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3jCGWjauD0+k5C-VpLDQ8WkcCHs5UpoAb-x_yHU0eEkw@mail.gmail.com>
Message-ID: <CAK8P3a3jCGWjauD0+k5C-VpLDQ8WkcCHs5UpoAb-x_yHU0eEkw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jF9W6wnDt1LL13Wea5zauC/TGUQZ/H/rRNbIFWFUTcnpX1W298V
 AZzD8KrMQO6a+wYv0QtZOep9Y3bEoHVmewKQ/DjC3eqFFfgEz8F0zIALYb0P3uIn+leySli
 z8KkbqVVXakb3QtwpBf3OSIOO7kbbmCgkJ06cdDkFfQGVQHChTm904ZYSMY/1qIoZK3h1OJ
 iqIug+kqOGNfvjntKbUOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KL+MnRO1W48=:pDkG8W+9R90xaLWZEb4IM4
 I0gequyx7CfQOcYnambgytHg3p03ZwO7pVqgV4nJ5iPsCP6y+VnkLWZDifAwLc1ST3V8ZFtQi
 KmxCwbKgae9sPrV4cfmJUtq7JcuQGIEZZ7xHVpgndmVgCdkHGsgwO4C72AsABOskqczEtWAf+
 G5i5qkNH7bbrDMliJTdj72d1iRFYQZI9LUYqaKLkaO1UAiN2B3xHwnUsUmp41ulmEjicSbo0N
 gZdFezaSjA84IpR/eR1DqXT8mHnV5PC8wqb/E2SK6gBUyOQqziX7jRVOL1jx/OHsAHbsYED7J
 oj+FILhi+rYm3CDWxPuLSSiELDRMCskwlyyUbFbkdgA33CTgt1FWkDETffkE3vHYkEDEGLjEE
 PiEOnCPmB2fqRrHUy9EG8a/cVYxL6gVKHkGPv5XTnULOKARnsxKeop5ncTL+/F4VDjdC42bAP
 xlERUW60cE9cqiXBXQuSbCTJi0wYcuWU3PvuRX2L1O4fZgVndAlxBlRobCt8aj/BbXcWL/5tm
 0yfys7tjx4QmfzAxGMwRK8kBeK9ZeX6ybYAVh0h/iEygVCIAL5UgYHesep5d9fsUtzWvprf5K
 7DZNZQG+uj/nYEV0kkpQ8hbR4NxOC6J53N8KAIk9rnyB+vOOi66Cp7nZFAEPN/eAZLOnPeQwA
 2Kse1EzawwVmXtZ8gFMHxDPVnTFu1uWFtkVfC9aRTUf7/zTI/tYwSJD5Jr3d7zXNSIvypcLF7
 zxiWaXgpdXht8tTdPOitcptDKqjSAu2ShYGqVFKK45JrQWa2FdLNJeI/z99mEzSdgEjl82XT9
 v8/YYRcgv8kKGkAlVXKU2yZc3Fr2phTJrxHl+jJD8wq1kj3CoU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 2:55 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Currently kretprobe on ARM just fills r0-r11 of pt_regs, but
> that is not enough for the stacktrace. Moreover, from the user
> kretprobe handler, stacktrace needs a frame pointer on the
> __kretprobe_trampoline.
>
> This adds a frame pointer on __kretprobe_trampoline for both gcc
> and clang case. Those have different frame pointer so we need
> different but similar stack on pt_regs.
>
> Gcc makes the frame pointer (fp) to point the 'pc' address of
> the {fp, ip (=sp), lr, pc}, this means {r11, r13, r14, r15}.
> Thus if we save the r11 (fp) on pt_regs->r12, we can make this
> set on the end of pt_regs.
>
> On the other hand, Clang makes the frame pointer to point the
> 'fp' address of {fp, lr} on stack. Since the next to the
> pt_regs->lr is pt_regs->sp, I reused the pair of pt_regs->fp
> and pt_regs->ip.
> So this stores the 'lr' on pt_regs->ip and make the fp to point
> pt_regs->fp.
>
> For both cases, saves __kretprobe_trampoline address to
> pt_regs->lr, so that the stack tracer can identify this frame
> pointer has been made by the __kretprobe_trampoline.
>
> Note that if the CONFIG_FRAME_POINTER is not set, this keeps
> fp as is.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

This causes a regression that I see in randconfig builds with gcc-11:

/tmp/ccovvQNw.s: Assembler messages:
/tmp/ccovvQNw.s:32: Error: invalid literal constant: pool needs to be closer
make[5]: *** [/git/arm-soc/scripts/Makefile.build:288:
arch/arm/probes/kprobes/core.o] Error 1

I have two randconfigs that reproduce it locally, here is a .config
[1] and assembly
output[2] for reference. I have not done any further analysis, but
maybe you have
an idea.

        Arnd

[1] https://pastebin.com/y4rkH8qX
[2] https://pastebin.com/9mEVU8Rd
