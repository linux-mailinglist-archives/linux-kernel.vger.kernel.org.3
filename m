Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B851F6CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 10:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiEIIMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbiEIIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:01:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A0654A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:57:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i17so13105258pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MP93zwoFXuw+LP7WdbcddfDNr4qcBI2Jrn8geSmg3E=;
        b=ZS+ZlXG0eKGISQ23r/PF0sD2EQL71q3hQ3lOfjnRwT47BR6BIzwUaQfioB0EOTObst
         pOcN3WEYIazJ/5EToSONTCTgl365aNjWvd1HgkIX5FF1AdZiuaNvPsVzjiSI2RfSfIAK
         D3/BN7engjR2P33F422SdY1RVbPkj83vWXW81rPojSrkmez1Cg+2+oR2T3pU0S2ueGMD
         J/clJDlC426moA8vakFntErVmDIQcxA7K8SWMPRalHtw+8eWbqc/7jt8057UOJ7VAKG3
         r/2ncxbGFXIAFjI4TYNA1GBdXQr4+a6ucBaOdHucbW5lJ60ersNPqW6KkwystTWArwAk
         /+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MP93zwoFXuw+LP7WdbcddfDNr4qcBI2Jrn8geSmg3E=;
        b=IhdbNjt6/AtJvGNCFe4wajXn3mrMhJ/RlsuZyS2K5bwwQAbX3LHeM+4+D2YvB7Lt8I
         9c24Axh0wM/RF0ZXFeDoNOnrEOJaphYsQL7mfFOJW9GmTv7phN0fjLDXAHGcK9j0O77e
         ayliBkCM0BnnRRu9fZhb9VbcueAwYr+P4VXE1Wu4saNyJbO6RqZN+UTI8EKqngipfDcU
         3gYqC+CTA2GOfOL4mA1ohJ02lVTAYeQ3NHOTKg+4CIhblcNvBkNhf8VuciisQ5v5a6RK
         xoPZ6BWZ2VYKy9feul4SxkfYc/k0WUYnQ8YA3T+7C4haHfqDp/NEXrv7XiBeWIz9yayz
         2YGw==
X-Gm-Message-State: AOAM530n+7R/025DY1uh5SMzj44ypic5LqRktCLKIK0K/ENDwT/NFd5Y
        HXLqZ4v7DPzqj478T2KoA7Gy6mh+DXhq+/Ai/Q6G8Q==
X-Google-Smtp-Source: ABdhPJwIen8TL2kNKrpQqTsU335RMGkhOlsyoreRw8mv2+pBD2rcURkPAbzgQhss4qSysTueiAs5AiOCNIRmmTaSeiI=
X-Received: by 2002:a17:902:9f96:b0:15d:1ee7:4231 with SMTP id
 g22-20020a1709029f9600b0015d1ee74231mr14825817plq.131.1652082933184; Mon, 09
 May 2022 00:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220413065458.88541-1-sumit.garg@linaro.org> <20220413065458.88541-2-sumit.garg@linaro.org>
 <20220506160649.ojwc4rqpyhxqyrdo@maple.lan>
In-Reply-To: <20220506160649.ojwc4rqpyhxqyrdo@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 9 May 2022 13:25:21 +0530
Message-ID: <CAFA6WYOCz2uFU81YTA+GpWhq3k=bfjBKJhKST1VjnjW2GTVq3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: entry: Skip single stepping interrupt handlers
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Daniel,

On Fri, 6 May 2022 at 21:36, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Wed, Apr 13, 2022 at 12:24:57PM +0530, Sumit Garg wrote:
> > Current implementation allows single stepping into interrupt handlers
> > for interrupts that were received during single stepping. But interrupt
> > handlers aren't something that the user expect to debug. Moreover single
> > stepping interrupt handlers is risky as it may sometimes leads to
> > unbalanced locking when we resume from single-step debug.
>
> Why does single stepping interrupt handlers cause unbalanced locking
> (with the current code)?
>

I have to dig deeper to completely answer this question but this is
based on observation from following warning splats seen while single
stepping interrupt handlers:

[  300.328300] WARNING: bad unlock balance detected!
[  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
[  300.329058] -------------------------------------
[  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
[  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
[  300.330029] but there are no more locks to release!
[  300.330265]
[  300.330265] other info that might help us debug this:
[  300.330668] 4 locks held by sh/173:
[  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0}, at:
vfs_write+0x98/0x204
[  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2}, at:
kgdb_cpu_enter+0x5b4/0x820
[  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2}, at:
kgdb_cpu_enter+0xe0/0x820
[  300.332717]  #3: ffffd57c973bc2a8 (dbg_master_lock){....}-{2:2},
at: kgdb_cpu_enter+0x1ec/0x820

>
> > Fix broken single-step implementation via skipping single-step over
> > interrupt handlers. The methodology is when we receive an interrupt from
> > EL1, check if we are single stepping (pstate.SS). If yes then we save
> > MDSCR_EL1.SS and clear the register bit if it was set. Then unmask only
> > D and leave I set. On return from the interrupt, set D and restore
> > MDSCR_EL1.SS. Along with this skip reschedule if we were stepping.
>
> Does this description really explains the motivation here.
>
> Isn't the goal to meet the user's expectation that when they step then
> the system will stop at PC+4 relative the instruction they are stepping
> (or PC+I for a branch that gets taken)?
>

Yeah this matches my understanding as well.

> To be clear, I've no objections to leaving interrupt handling enabled
> when single stepping (AFAIK it is similar to what x86 does) but I think
> this patch description will be difficult for future adventurers to
> comprehend.
>

Okay, so does the below patch description sound apt?

"
    Current implementation allows single stepping into interrupt handlers
    for interrupts that were received during single stepping. But interrupt
    handlers aren't something that the user expect to debug. Moreover single
    stepping interrupt handlers is risky as it may sometimes leads to
    unbalanced locking when we resume from single-step debug:

    [  300.328300] WARNING: bad unlock balance detected!
    [  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
    [  300.329058] -------------------------------------
    [  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
    [  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
    [  300.330029] but there are no more locks to release!
    [  300.330265]
    [  300.330265] other info that might help us debug this:
    [  300.330668] 4 locks held by sh/173:
    [  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0},
at: vfs_write+0x98/0x204
    [  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2},
at: kgdb_cpu_enter+0x5b4/0x820
    [  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2},
at: kgdb_cpu_enter+0xe0/0x820
    [  300.332717]  #3: ffffd57c973bc2a8
(dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x1ec/0x820

    The common user's expectation while single stepping is that when they
    step then the system will stop at PC+4 or PC+I for a branch that gets
    taken relative to the instruction they are stepping. So, fix broken single
    step implementation via skipping single stepping interrupt handlers.

    The methodology is when we receive an interrupt from EL1, check if we
    are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
    clear the register bit if it was set. Then unmask only D and leave I set. On
    return from the interrupt, set D and restore MDSCR_EL1.SS. Along with this
    skip reschedule if we were stepping.
"

-Sumit

>
> Daniel.
>
>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/kernel/entry-common.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > index 878c65aa7206..dd2d3af615de 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -458,19 +458,35 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
> >       do_interrupt_handler(regs, handler);
> >       irq_exit_rcu();
> >
> > -     arm64_preempt_schedule_irq();
> > +     /* Don't reschedule in case we are single stepping */
> > +     if (!(regs->pstate & DBG_SPSR_SS))
> > +             arm64_preempt_schedule_irq();
> >
> >       exit_to_kernel_mode(regs);
> >  }
> > +
> >  static void noinstr el1_interrupt(struct pt_regs *regs,
> >                                 void (*handler)(struct pt_regs *))
> >  {
> > +     unsigned long reg;
> > +
> > +     /* Disable single stepping within interrupt handler */
> > +     if (regs->pstate & DBG_SPSR_SS) {
> > +             reg = read_sysreg(mdscr_el1);
> > +             write_sysreg(reg & ~DBG_MDSCR_SS, mdscr_el1);
> > +     }
> > +
> >       write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> >
> >       if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> >               __el1_pnmi(regs, handler);
> >       else
> >               __el1_irq(regs, handler);
> > +
> > +     if (regs->pstate & DBG_SPSR_SS) {
> > +             write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
> > +             write_sysreg(reg, mdscr_el1);
> > +     }
> >  }
> >
> >  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> > --
> > 2.25.1
