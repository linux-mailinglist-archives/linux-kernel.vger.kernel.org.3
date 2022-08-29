Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7325A41FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiH2Enr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2Enp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:43:45 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EAD4055A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:43:34 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3378303138bso167777717b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Futttwn9zMBHEcnJ92xnZayzubYJ8abufQNgWkI8XL8=;
        b=0c4/Gwh6P+ewGDHjeN7CKC/e3WqV0xR4+oiUAJs9snTy4zYPfeQI6XGUGL2MEeLJDv
         P3IZPbBZadZX6zKl0c2HiwbJbQxYre9WIhTJhS3bhfvZh7YkcQHs3ETAs0JF7Qx/r03E
         7kuA2QMO2jPAtHlMYixqXt4f6QTKEqWLxNqUTprrZmaZC+wzPc1ejC0/Y4+zmy+J8cev
         PYW58rpTSdHfdZCWR2QfNWvdm9AjjLYCPJghY8AI9GeXw6gjxtzfa6wO23UxIRCXt5fs
         ADQ8iPnK6RcH8MOhmc7TUEqV8MOzoZdIrKkO2umW9LnKdBr/Nr/UxO2qYz+R7TGDp885
         KAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Futttwn9zMBHEcnJ92xnZayzubYJ8abufQNgWkI8XL8=;
        b=IQ1b6bncFozzqPgm2Fblqi6S4KBeKzuGkpdS66vUStgFin4GXlUBhBuGf1onhEloa5
         k0DOe2GA/yVFloIoawbTvucInHlINLFDVjai2JLSPPDQYXTRKdmgqWzYBIP4jHrz+xHB
         pOYeoWkpKNsfLyey7t+q/VmaxHbevqcrau4mUFbGKz4J/Irj1/O2EbAuy1bWk7uNqHAA
         ty67wgeFSPjSJcFSS7XBg0Hb8We864OTYTvoEEmbCM5LxsnZO+vISsm1kyHC26GpqehX
         Ni5jcPcTn8en1kwdRmwdzvizeQ/XwwfCVbHIu0nCcauvDqHB9i2lxiupSMeVeXFIVFzy
         BpwA==
X-Gm-Message-State: ACgBeo1DY9iQZ4pcTodvjJdKLS4df4mL0ru1ggF7hdu81hj699l2qXec
        PIsDZoiejVPLzn9pV5Z9pOwOiQ4uWlJemvBbAyZcYg==
X-Google-Smtp-Source: AA6agR4y9Ejk7iQKufbJy82bBQmRG6SNQX1gdkZizGFRaPVhX0RuMqexR97KJGd5Qs5W8HOzcsLxCfW9+rU96ZEU2rA=
X-Received: by 2002:a0d:cad1:0:b0:335:8273:e9fd with SMTP id
 m200-20020a0dcad1000000b003358273e9fdmr8758289ywd.154.1661748213475; Sun, 28
 Aug 2022 21:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220820065446.389788-1-apatel@ventanamicro.com>
 <20220820065446.389788-5-apatel@ventanamicro.com> <8f4ae429-0f12-2096-c07b-fe43b3abb4fe@microchip.com>
 <69e58f4dc2b74415a32a97998e862479@kernel.org>
In-Reply-To: <69e58f4dc2b74415a32a97998e862479@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Aug 2022 10:13:21 +0530
Message-ID: <CAAhSdy13G2fjtVMQCMHf0vJff9i1q1Gg_WKQ942Qr9bmQ0NeBg@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] RISC-V: Treat IPIs as normal Linux IRQs
To:     Marc Zyngier <maz@kernel.org>
Cc:     Conor.Dooley@microchip.com, apatel@ventanamicro.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        daniel.lezcano@linaro.org, atishp@atishpatra.org,
        Alistair.Francis@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:27 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-08-26 19:48, Conor.Dooley@microchip.com wrote:
> > On 20/08/2022 07:54, Anup Patel wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the content is safe
> >>
> >> Currently, the RISC-V kernel provides arch specific hooks (i.e.
> >> struct riscv_ipi_ops) to register IPI handling methods. The stats
> >> gathering of IPIs is also arch specific in the RISC-V kernel.
> >>
> >> Other architectures (such as ARM, ARM64, and MIPS) have moved away
> >> from custom arch specific IPI handling methods. Currently, these
> >> architectures have Linux irqchip drivers providing a range of Linux
> >> IRQ numbers to be used as IPIs and IPI triggering is done using
> >> generic IPI APIs. This approach allows architectures to treat IPIs
> >> as normal Linux IRQs and IPI stats gathering is done by the generic
> >> Linux IRQ subsystem.
> >>
> >> We extend the RISC-V IPI handling as-per above approach so that arch
> >> specific IPI handling methods (struct riscv_ipi_ops) can be removed
> >> and the IPI handling is done through the Linux IRQ subsystem.
> >>
> >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
> >> +void riscv_ipi_set_virq_range(int virq, int nr)
> >> +{
> >> +       int i, err;
> >>
> >> -               if (ops & (1 << IPI_IRQ_WORK)) {
> >> -                       stats[IPI_IRQ_WORK]++;
> >> -                       irq_work_run();
> >> -               }
> >> +       if (WARN_ON(ipi_virq_base))
> >> +               return;
> >>
> >> -#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> >> -               if (ops & (1 << IPI_TIMER)) {
> >> -                       stats[IPI_TIMER]++;
> >> -                       tick_receive_broadcast();
> >> -               }
> >> -#endif
> >> -               BUG_ON((ops >> IPI_MAX) != 0);
> >> +       WARN_ON(nr < IPI_MAX);
> >> +       nr_ipi = min(nr, IPI_MAX);
> >> +       ipi_virq_base = virq;
> >> +
> >> +       /* Request IPIs */
> >> +       for (i = 0; i < nr_ipi; i++) {
> >> +               err = request_percpu_irq(ipi_virq_base + i,
> >> handle_IPI,
> >> +                                        "IPI", &ipi_virq_base);
> >
> > FWIW, ?sparse? does not like this:
> > arch/riscv/kernel/smp.c:163:50: warning: incorrect type in argument 4
> > (different address spaces)
> > arch/riscv/kernel/smp.c:163:50:    expected void [noderef] __percpu
> > *percpu_dev_id
> > arch/riscv/kernel/smp.c:163:50:    got int *
>
> Huh, well spotted. This will totally give the wrong sort of
> result, as this is used as a percpu variable from the irq
> core code.
>
> The arm64 code passes instead a pointer to the CPU number, which
> is not very useful, but at least not completely wrong.
>
> I'm sure the RISC-V code has some sort of semi-useful data to
> stuff in there instead of this.

Unlike arm64, we don't have any percpu data in arch/riscv/kernel/smp.c
which can be passed here.

For now, I will just add dummy percpu data to make sparse happy.

I hope this is okay ?

Regards,
Anup

>
>          M.
> --
> Jazz is not dead. It just smells funny...
