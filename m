Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F15B1D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIHMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIHMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:37:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C379A6E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:37:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z23so19755367ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=o5O/OUn4ND6Nkl8BKpExq+lYQmh2k3ZSbRAegZyWLfE=;
        b=U0ea1MgmbtJg7EPMaAeokRg8E1yUEKF09EyIPjzHOpIwSmlc2QYXJIkjNknB2N8JR7
         7LKVhCmJ/riLU03xoWDcBxzH80HF/DQpUYBfcV5hPNRjX2cP3e/CL+A23/LnIS+jS8Jp
         cKSrj4NxS6tnNRQGq3Y+ubf4pleeCOUeU8W+qPcZilTWirlGUbQr1gL0R3h8S9AeBOLc
         ajntXlubMYfVHRAsDp4wkJNlgmp+W3t8HoPc0ukhJNadp6LEIippdkv/pqNknu7vZoAZ
         OPuZ2jW9DcJHQUJKHPVd7Yto6XPKCIBMSyFuV9XTjkWhBt6hmYVvVQHUBYpIGy3CxZJ4
         xvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o5O/OUn4ND6Nkl8BKpExq+lYQmh2k3ZSbRAegZyWLfE=;
        b=EuHAVdoWxeiXyzZozny0d+/luQX9wKr93TGqdxJJVXTDcMzy2fDhPzs5c1IIaPSS+f
         Kl0bTJqQb0U0KQ/K3tYqDGKHGeOcmsQgb2ftPvxm929NeYtxAPhuYudhlAEioZanTvxx
         STYCIFAE/4E0j44scQrQLMI6Zwh3Cxts+7QXcmmh+H6ieimRvPo/zcLWexLfDEj0cu1Q
         K3wcbAbeyCpVgjGHjOUnTHaV0QGUAxQXsk7ReCDMFzv2e7UluNpU26Y8UTO0v5CD7Dcb
         cdCuQ+QaZkmSVfoPmDhS5uFPw6gRlw7VgUhDwIYo47zRZDkczTERl0wjO8drmDg3PQ2u
         +9ow==
X-Gm-Message-State: ACgBeo26Pge4IK/pzzJgDkuchvefERnlBQttMVT5ykslfcdLX9RxtSZC
        yYusc1OJ8argp7Uhf7/9U8DgJCBrPmzgUanu7KKe5w==
X-Google-Smtp-Source: AA6agR6BUDP+a7mQbQzTOVRDYC9UhafLHjiWSikXczQSEEdRl0tk3qrNLsIRRtmqmO1R3AGXhBe+GAwGRoGoEk9RgZ8=
X-Received: by 2002:a05:651c:b2c:b0:261:d82f:75b8 with SMTP id
 b44-20020a05651c0b2c00b00261d82f75b8mr2307820ljr.266.1662640650496; Thu, 08
 Sep 2022 05:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220903161309.32848-1-apatel@ventanamicro.com>
 <20220903161309.32848-2-apatel@ventanamicro.com> <87czc6uupf.wl-maz@kernel.org>
In-Reply-To: <87czc6uupf.wl-maz@kernel.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 8 Sep 2022 18:07:18 +0530
Message-ID: <CAK9=C2XMgRAwu4ALhcRkJJnsCdms6rR7DqG3Nz7ZJa9cX+RP8Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bin Meng <bmeng.cn@gmail.com>
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

On Thu, Sep 8, 2022 at 2:08 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 03 Sep 2022 17:13:03 +0100,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
> > S-mode but read-only for M-mode so we clear this bit only when using
> > SBI IPI operations.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  arch/riscv/kernel/sbi.c | 8 +++++++-
> >  arch/riscv/kernel/smp.c | 2 --
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 775d3322b422..fc614650a2e3 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -643,8 +643,14 @@ static void sbi_send_cpumask_ipi(const struct cpumask *target)
> >       sbi_send_ipi(target);
> >  }
> >
> > +static void sbi_ipi_clear(void)
> > +{
> > +     csr_clear(CSR_IP, IE_SIE);
> > +}
> > +
> >  static const struct riscv_ipi_ops sbi_ipi_ops = {
> > -     .ipi_inject = sbi_send_cpumask_ipi
> > +     .ipi_inject = sbi_send_cpumask_ipi,
> > +     .ipi_clear = sbi_ipi_clear
> >  };
> >
> >  void __init sbi_init(void)
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index 760a64518c58..c56d67f53ea9 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -83,8 +83,6 @@ void riscv_clear_ipi(void)
> >  {
> >       if (ipi_ops && ipi_ops->ipi_clear)
> >               ipi_ops->ipi_clear();
> > -
> > -     csr_clear(CSR_IP, IE_SIE);
> >  }
> >  EXPORT_SYMBOL_GPL(riscv_clear_ipi);
>
> This really begs the question: why on Earth are these things exported
> to *modules*? I cannot see a good reason why they should be...

I agree, the riscv_clear_ipi() should not be exported but the PATCH4
("RISC-V: Treat IPIs as normal Linux IRQs") of this series removes
this function.

Regards,
Anup

>
>         M>
>
> --
> Without deviation from the norm, progress is not possible.
