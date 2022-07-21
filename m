Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9409557C7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiGUJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGUJpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:45:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2141408C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:45:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u14so1194591lju.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rATgYaRc06yup3B9vQoeZCRxplvBjG7cGBY1+cZOcR0=;
        b=lQtaZPe4+cFvvzkekGvWGs1/h1VvwEnVqlZbeIzGv47QEApdtNWinAkHczWThbeHan
         y4WnW9ZrUXUfBtR8qo8nI7Ozu6RrqpmV4x/3IeBD3MHphexBmhZ7/pbDs6cWBB9oheQ7
         S8iLgkk9jKb1hQDQ2j+3N+X2gA+D8dNgr4pmct7Yl83DCkhuZTSCjJElFZLt4azjUr4w
         IlWV7OM/sK5olfXpXp8iWIIUkSdia7JwcOrMPlLHksQ+lxRkJ1x+XJ0CYMSxfj7T0LEb
         wx4V309mo09SWsr5yDhbNFYjIzNp6Nxeb9F9ChPy5Mj1XvUgFs3sCPEdDHyWcq4Li8+w
         MK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rATgYaRc06yup3B9vQoeZCRxplvBjG7cGBY1+cZOcR0=;
        b=zaw/Jpe55HAhvD8tS7KQcKc9n+R/XTyGX7Ku8Rldudxx++gFKlulAJD/i04aBnK875
         8Cq0y7XfSrf7AQptPgPHF/FYE0hqGxn1woi+l3s6MlRrGTs2JAZXqSCp9G43PIxKn86c
         J+Oa2EZACJQ7f0UjkuOg3SpyQt3RYlEkeVPFNyMOa4zDyhS97DlcpKh4juxyZiYfvTxY
         nxiUso3TXJ8r2FxI0mKmVi+KKMbuTz7pzPJSiGxtOy2MjktWrKkO6a7v28036hUsl1Ve
         FueRwsT8rp6idh7DhvxtvgZxig4/q5VSgsvzwUkhQ6WfCTPT3VSZLHCVsmMfmkTfRHHh
         5Cfg==
X-Gm-Message-State: AJIora+iQTxobL0TVnx6Fyfyywdur/u3x0NoKu+MomL5O2vnSnOPYs7m
        eLTjTTdJuLOJeE/Mr/Sc5m09Pj6c9O0DQXLdgZAeEg==
X-Google-Smtp-Source: AGRyM1sB1eQ5rWzg3axoBKsTIsw/olo2zDoZljUFFhOhipu0awj1+20YmiCgzI410ZaVmMyLHQpqpg40o4F+tQWhxGU=
X-Received: by 2002:a05:651c:12cb:b0:25b:fa3f:c3f with SMTP id
 11-20020a05651c12cb00b0025bfa3f0c3fmr19485233lje.364.1658396747462; Thu, 21
 Jul 2022 02:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220719054729.2224766-1-apatel@ventanamicro.com>
 <20220719054729.2224766-3-apatel@ventanamicro.com> <315d9850-e660-f71e-2321-b0684f7df950@sholland.org>
In-Reply-To: <315d9850-e660-f71e-2321-b0684f7df950@sholland.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 21 Jul 2022 15:15:33 +0530
Message-ID: <CAK9=C2UZ_o+DJ3s0Q5ET43CYhfu8A4TTfosor1wyUdPO2mjn_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP
 based on DT property
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:12 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Hi Anup,
>
> On 7/19/22 12:47 AM, Anup Patel wrote:
> > We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only when
> > riscv,timer-always-on DT property is not present for the corresponding
> > CPU.
>
> The timer maintaining its context (and continuing to count) during non-retentive
> CPU suspend is not sufficient to drop CLOCK_EVT_FEAT_C3STOP.
>
> Another requirement is that the timer interrupt is generated and routed outside
> the CPU's power/reset domain, to whatever hardware is responsible for turning
> the CPU back on. It does not matter if the timer interrupt fires, if that
> interrupt cannot wake up the CPU.
>
> So something closer to "riscv,timer-can-wake-cpu" would be a more accurate
> property name for how you are using it.

I agree with your suggestion. Let's make this DT property name aligned with
what it is doing.

>
> And even then, that ability is a property of the SBI implementation, not just
> the hardware. In the motivating example for the flag (Allwinner D1), the CLINT
> cannot wake the CPU from reset, but the SoC contains other MMIO timers that can.
> So the capability of the SBI timer extension depends on which timer hardware the
> SBI implementation chooses to use. So I am not sure that the property belongs in
> the CPU node.
>
> Maybe it makes sense to report this capability via a function in the SBI timer
> extension?

Well, the timer interrupt not firing in non-retentive suspend is an attribute of
underlying platform and not of the SBI implementation (firmware/hypervisor)
hence should be described in DT or ACPI.

Also, the timer interrupt not firing in non-retentive suspend is also possible
with RISC-V Sstc extension (i.e stimecmp CSRs) so the proposed DT
property will be useful for platforms with Sstc extension as well.

Regards,
Anup

>
> Regards,
> Samuel
>
> > This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> > based on RISC-V platform capabilities rather than having it set for
> > all RISC-V platforms.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/clocksource/timer-riscv.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index 593d5a957b69..3015324f2b59 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
> >  static unsigned int riscv_clock_event_irq;
> >  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
> >       .name                   = "riscv_timer_clockevent",
> > -     .features               = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> > +     .features               = CLOCK_EVT_FEAT_ONESHOT,
> >       .rating                 = 100,
> >       .set_next_event         = riscv_clock_next_event,
> >  };
> > @@ -65,9 +65,13 @@ static struct clocksource riscv_clocksource = {
> >  static int riscv_timer_starting_cpu(unsigned int cpu)
> >  {
> >       struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
> > +     struct device_node *np = of_get_cpu_node(cpu, NULL);
> >
> >       ce->cpumask = cpumask_of(cpu);
> >       ce->irq = riscv_clock_event_irq;
> > +     if (!of_property_read_bool(np, "riscv,timer-always-on"))
> > +             ce->features |= CLOCK_EVT_FEAT_C3STOP;
> > +     of_node_put(np);
> >       clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
> >
> >       enable_percpu_irq(riscv_clock_event_irq,
> >
>
