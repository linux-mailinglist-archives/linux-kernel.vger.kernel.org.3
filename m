Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9F4468366
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384342AbhLDIsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 03:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354761AbhLDIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 03:48:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155BEC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 00:45:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710E160AE4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 08:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5F5C341C5
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638607523;
        bh=ootFt2XPS5y2Q9hPMbXe0aAjBh64rPkdG0eY3FUEcjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BydKqd2F0DHkR4OmxjlA81eRsFFGS9/Rz6rVkBp5IwS5EDauk8K6/0nOHspETpmAg
         wziwckyYtrW1lzC7Hrpb1mrJe/EzP4OATduElYIVsrwEsmoP0RqBjIQ3FrMZxlppR7
         t6OyAMHOzXZyIr4AEaYklvnc9gAHDfn48+/fw7DUKpV6vLN7Z9XAOhk25AKz9grN/L
         321pBRVPUNEwyveXxdm9/M23pOMeB0lT0BrOCFr3fjjvF3Dl5uRRislPEwomwRDd/R
         7xVOxOWdyBEee7wOSk9574qI6D2WVCNk5Ek6IpGf3/6e/ptSD4m+lemCcbL76abMSj
         glcehVPzBNJ8w==
Received: by mail-oi1-f172.google.com with SMTP id bk14so10714028oib.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 00:45:23 -0800 (PST)
X-Gm-Message-State: AOAM53301FsV9lAYW+sFGdoobJewBlV6u7A15X5wUxBfe31MMtAFBnjC
        NX1EmbN9H38WdaykYFMS5+R4Rm4GXN8EWNQE7dg=
X-Google-Smtp-Source: ABdhPJyQDdDnp/YR0EXe1jOAGLUO0OHHU0hOnxkTTijaKSUXPgGCfq0o7e9D4E6gxlU+CQfR/j2AvktERXS/WE/5q7U=
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr14242217oic.174.1638607523000;
 Sat, 04 Dec 2021 00:45:23 -0800 (PST)
MIME-Version: 1.0
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
 <163477772593.264901.7405996794526239017.stgit@devnote2> <CAK8P3a3jCGWjauD0+k5C-VpLDQ8WkcCHs5UpoAb-x_yHU0eEkw@mail.gmail.com>
In-Reply-To: <CAK8P3a3jCGWjauD0+k5C-VpLDQ8WkcCHs5UpoAb-x_yHU0eEkw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 4 Dec 2021 09:45:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3ZQ__trDo4PDfBmJsNoiqBkNB2CLK5pTFARTEYzDOzw@mail.gmail.com>
Message-ID: <CAMj1kXF3ZQ__trDo4PDfBmJsNoiqBkNB2CLK5pTFARTEYzDOzw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 at 21:38, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 21, 2021 at 2:55 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Currently kretprobe on ARM just fills r0-r11 of pt_regs, but
> > that is not enough for the stacktrace. Moreover, from the user
> > kretprobe handler, stacktrace needs a frame pointer on the
> > __kretprobe_trampoline.
> >
> > This adds a frame pointer on __kretprobe_trampoline for both gcc
> > and clang case. Those have different frame pointer so we need
> > different but similar stack on pt_regs.
> >
> > Gcc makes the frame pointer (fp) to point the 'pc' address of
> > the {fp, ip (=sp), lr, pc}, this means {r11, r13, r14, r15}.
> > Thus if we save the r11 (fp) on pt_regs->r12, we can make this
> > set on the end of pt_regs.
> >
> > On the other hand, Clang makes the frame pointer to point the
> > 'fp' address of {fp, lr} on stack. Since the next to the
> > pt_regs->lr is pt_regs->sp, I reused the pair of pt_regs->fp
> > and pt_regs->ip.
> > So this stores the 'lr' on pt_regs->ip and make the fp to point
> > pt_regs->fp.
> >
> > For both cases, saves __kretprobe_trampoline address to
> > pt_regs->lr, so that the stack tracer can identify this frame
> > pointer has been made by the __kretprobe_trampoline.
> >
> > Note that if the CONFIG_FRAME_POINTER is not set, this keeps
> > fp as is.
> >
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> This causes a regression that I see in randconfig builds with gcc-11:
>
> /tmp/ccovvQNw.s: Assembler messages:
> /tmp/ccovvQNw.s:32: Error: invalid literal constant: pool needs to be closer
> make[5]: *** [/git/arm-soc/scripts/Makefile.build:288:
> arch/arm/probes/kprobes/core.o] Error 1
>
> I have two randconfigs that reproduce it locally, here is a .config
> [1] and assembly
> output[2] for reference. I have not done any further analysis, but
> maybe you have
> an idea.

Does this help?

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 9090c3a74dcc..88999ed2cfc4 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -408,6 +408,7 @@ void __naked __kprobes __kretprobe_trampoline(void)
 #else
                "mov    pc, lr                  \n\t"
 #endif
+               ".ltorg                         \n\t"
                : : : "memory");
 }
