Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF6570318
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiGKMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiGKMoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017C3C8DE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:44:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l124so4655423pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+gJs7VqVfK3BDvcgbxJ4+3h2qQW9iOJlXrEnDEYLpc=;
        b=Ia8bUiFWa4gOdKjqqGrm6PAlh7m1OBtZkF0pzB+IbQVMhcpUarK4W12KoTpnyk/JCT
         HafKVveYDyFmL6jIW5uNBaRfYRj6rCNn0ID1qzDkAomv4Nv+qHaDdVtGIm+ZFNZf8ENh
         guJ/ga9phkyVE9MGHi1+nrDfJS6RgAhZnKmIutaKkmolEoWztbsw29uuZGm6el9LQYRE
         hUiyKUMq46cC5KQQ7qu2UW/ZiczhGh/FBJML6rXPefqnC3SzQdeDnwNg2fKXfTwBftRH
         JvQ/i4PhSaGqDZkTryhuVUJ1i3BQyi6xrLKuZ1IMLP4qfJSNinXIwk64pIqtWHfs3ssx
         kibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+gJs7VqVfK3BDvcgbxJ4+3h2qQW9iOJlXrEnDEYLpc=;
        b=1VgxPkQV5rZqouHxfCEXUdd58Au7tY5kn6acF+8tcPw5fgF2TVZoxE5QjTKudzIQwV
         O/fKM3OXSckXoVce7P1tKYVminTNkMJP+i2+FNa0yy6nMOGjTmmtCx3jEZwMNL9Q9CoK
         +J0zG6w0OS+mUtvyF83V63W06jv9UMhFA0nHByTh5PiNvtzI65eXr6sC8GfovpVd6piv
         hybcd1T+eTCxf9uD2o9JuL6CNyEOahS1NeyCbZCXdVuXLpgpK0iEDX8gf0fPb71Bwy1a
         s0T2nAGiOxMrzylF3Ab8ZxAnMSHTXTVLYUZaFP5zjylK7A9kSr0YwzOjUCn7E8gTYKcd
         o4og==
X-Gm-Message-State: AJIora9uTdU+kKkwoKlK+aYRUASInwLeslaSwZRV2tdBEWpEhjiCPRyN
        ZAKcYpL5POflH17h9FNQ31gBMPkIuM1RlEFmag/IjA==
X-Google-Smtp-Source: AGRyM1ud07aLumP5FfPBITa5JTwbhHQ7uDbVBi2bmNc9DKckpyy2ISAlTUsz+KFSdKEAM9ezaWWxYibArBUH1NLF14A=
X-Received: by 2002:a63:4b03:0:b0:40d:9515:2863 with SMTP id
 y3-20020a634b03000000b0040d95152863mr14996796pga.341.1657543450577; Mon, 11
 Jul 2022 05:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220511060521.465744-1-sumit.garg@linaro.org> <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
In-Reply-To: <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 11 Jul 2022 18:13:59 +0530
Message-ID: <CAFA6WYPmFqCXk24J71tNO=5bJHgJRAOPFr7cGq8YYLR+MWBoPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>, Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Sat, 2 Jul 2022 at 03:44, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, May 10, 2022 at 11:05 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > This patch-set reworks pending fixes from Wei's series [1] to make
> > single-step debugging via kgdb/kdb on arm64 work as expected. There was
> > a prior discussion on ML [2] regarding if we should keep the interrupts
> > enabled during single-stepping. So patch #1 follows suggestion from Will
> > [3] to not disable interrupts during single stepping but rather skip
> > single stepping within interrupt handler.
> >
> > [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> > [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> > [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
> >
> > Changes in v3:
> > - Reword commit descriptions as per Daniel's suggestions.
> >
> > Changes in v2:
> > - Replace patch #1 to rather follow Will's suggestion.
> >
> > Sumit Garg (2):
> >   arm64: entry: Skip single stepping into interrupt handlers
> >   arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
> >
> >  arch/arm64/include/asm/debug-monitors.h |  1 +
> >  arch/arm64/kernel/debug-monitors.c      |  5 +++++
> >  arch/arm64/kernel/entry-common.c        | 18 +++++++++++++++++-
> >  arch/arm64/kernel/kgdb.c                |  2 ++
> >  4 files changed, 25 insertions(+), 1 deletion(-)
>
> Sorry it took so long for me to respond. I kept dreaming that I'd find
> the time to really dig deep into this to understand it fully and I'm
> finally giving up on it.

No worries and apologies on my part as well as I had to find some time
to reproduce the issue that you have reported below.

> I'm going to hope that Will and/or Catalin
> knows this area of the code well and can give it a good review. If not
> then I'll strive harder to make the time...
>
> In any case, I poked around with this a bunch and it definitely
> improved the stepping behavior a whole lot. I still got one case where
> gdb hit an assertion while I was stepping, but I could believe that
> was a problem with gdb? I couldn't reproduce it. Thus I can at least
> give:
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>

Thanks for the testing.

> I'll also note that I _think_ I remember that with Wei's series that
> the gdb function "call" started working. I tried that here and it
> didn't seem so happy. To keep things simple, I created a dummy
> function in my kernel that looked like:
>
> void doug_test(void)
> {
>   pr_info("testing, 1 2 3\n");
> }
>
> I broke into the debugger by echoing "g" to /proc/sysrq-trigger and
> then tried "call doug_test()". I guess my printout actually printed
> but it wasn't so happy after that. Seems like it somehow ended up
> returning to a bogus address after the call which then caused a crash.
>

I am able to reproduce this issue on my setup as well. But it doesn't
seem to be a regression caused by this patch-set over Wei's series. As
I could reproduce this issue with v1 [1] patch-set as well which was
just a forward port of pending patches from Wei's series to the latest
upstream.

Maybe it's a different regression caused by other changes? BTW, do you
remember the kernel version you tested with Wei's series applied?

[1] https://lore.kernel.org/linux-arm-kernel/20220411093819.1012583-1-sumit.garg@linaro.org/T/

-Sumit

>   testing, 1 2 3
>   BUG: sleeping function called from invalid context at
> arch/arm64/mm/fault.c:593
>   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 3393, name: bash
>   preempt_count: 0, expected: 0
>   RCU nest depth: 1, expected: 0
>   CPU: 6 PID: 3393 Comm: bash Not tainted 5.19.0-rc4+ #3
> dbec0bdb8582e447bccdcf2e70d7fe04477b1aac
>   Hardware name: Google Herobrine (rev1+) (DT)
>   Call trace:
>    dump_backtrace+0xf0/0x110
>    show_stack+0x24/0x70
>    dump_stack_lvl+0x64/0x7c
>    dump_stack+0x18/0x38
>    __might_resched+0x144/0x154
>    __might_sleep+0x54/0x84
>    do_page_fault+0x1d4/0x42c
>    do_mem_abort+0x4c/0xb0
>    el1_abort+0x3c/0x5c
>    el1h_64_sync_handler+0x4c/0xc4
>    el1h_64_sync+0x64/0x68
>    0xffffffc008000000
>    __handle_sysrq+0x15c/0x184
>    write_sysrq_trigger+0x94/0x128
>    proc_reg_write+0xbc/0xec
>    vfs_write+0xf0/0x2c8
>    ksys_write+0x84/0xf0
>    __arm64_sys_write+0x28/0x34
>    invoke_syscall+0x4c/0x120
>    el0_svc_common+0x94/0xfc
>    do_el0_svc+0x38/0xc0
>    el0_svc+0x2c/0x7c
>    el0t_64_sync_handler+0x48/0x114
>    el0t_64_sync+0x18c/0x190
>   Unable to handle kernel execute from non-executable memory at
> virtual address ffffffc008000000
>   Mem abort info:
>     ESR = 0x000000008600000f
>     EC = 0x21: IABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x0f: level 3 permission fault
>   swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000082863000
>   [ffffffc008000000] pgd=100000027ffff003, p4d=100000027ffff003,
> pud=100000027ffff003, pmd=100000027fffe003, pte=00680001001c3703
>   Internal error: Oops: 8600000f [#1] PREEMPT SMP
>
> I'm not sure if that's a sign that something is missing with your patch or not.
>
> -Doug
