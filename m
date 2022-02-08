Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA2B4AD3EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350760AbiBHItJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349583AbiBHIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:48:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF198C03FEC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:48:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e3so15397948wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkVxK/LOYz0/eo5az4a2zVWUd5m6LEvFlEjayukrMYk=;
        b=op64XUdgnstjz6QFJUzFkyQ4kvy0o35NYrSG8sjVko8AfwvJWsZX2akrlJ6y8EGQ2e
         wWBJdZQ/tesItUNAXQhq6UMZSjC+HOYBqpC3eKF79QrR3n3MC2iNq/7IvhOYj1Z2uea1
         tY5r5lV/2stL6vROHTELIfSmTXJHuMo+yDi910j2fFQlFc6qmbBoVmiykoU6jJ875/5d
         Z3UsB7FqwI31PKTcHz0xY00UJZoba83/zojhH3ni1KDI1L4I+Lf7wFi2CQr7KBKRatqG
         jqtcWLHmjx2+4Ad1YDmXlJYYJfWbMdIAIvgOj0tTEdyGg1Z07YptGVS00Fw2xCi4CIW+
         JFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkVxK/LOYz0/eo5az4a2zVWUd5m6LEvFlEjayukrMYk=;
        b=v5F5GuHQUJoXsXhNJmpIAsMZw0rDTFbibRnAxjhIhkDo3uGWBFFfHDE+FTrjaerzxN
         KahJYETwl4txRsI5vqw+QUfSWy43r4+p8+4alS1LBOsBfyI2IZaJv66h/dlKpC/RGYdt
         dl08EoPGlgxAbCck0CT3/DYTCSokoLi860WtCssYB2uSfrmW8nDuEqq+TwYLSAzKA9hd
         rCHoZc9jq+KBRUzqyU56tGPELPwhZteyVlkCNer70jMeSPOZVpv9i9qmnhzkGG0lrIlz
         tkIDyiEoQ++SC8I7KQnwqCuYG2se4NrCMxAapFPDHLFmWwfk7x1imAEQI3c5XcW9JkaU
         wQ1g==
X-Gm-Message-State: AOAM5307X39luOVxyTJqMW1M8sbmwtjvz3DyIALbVODtgGW7LJ/DZ/m/
        JYsxJNRjylIWcAMBxGZzmbTYLENT3smHS6fSF6PhLA==
X-Google-Smtp-Source: ABdhPJyosXWO+NAe1q63zMby8CE8NyRp3HJT3OqC3u+vUMEXQNCw+EOmmQ/CtbilJrSHEq/padGN1KsmnCaA7OOnan0=
X-Received: by 2002:a05:6000:1e0a:: with SMTP id bj10mr2564533wrb.313.1644310130417;
 Tue, 08 Feb 2022 00:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com>
 <20220126114452.692512-9-apatel@ventanamicro.com> <CAJF2gTRLcqQ8ZjKwWNmARtaraVW7dD5Hp5=iv+4kHYENvB2gWg@mail.gmail.com>
In-Reply-To: <CAJF2gTRLcqQ8ZjKwWNmARtaraVW7dD5Hp5=iv+4kHYENvB2gWg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Feb 2022 14:18:37 +0530
Message-ID: <CAAhSdy00Yi10M0ECm+aUmbeviaXnm-bV9yLkwJKMSXQ2_7geCw@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for
 QEMU virt machine
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 11:56 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Jan 26, 2022 at 7:51 PM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > From: Anup Patel <anup.patel@wdc.com>
> >
> > We enable RISC-V SBI CPU Idle driver for QEMU virt machine to test
> > SBI HSM Supend on QEMU.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig.socs           | 3 +++
> >  arch/riscv/configs/defconfig      | 1 +
> >  arch/riscv/configs/rv32_defconfig | 1 +
> >  3 files changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 6ec44a22278a..f4097a815201 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -36,6 +36,9 @@ config SOC_VIRT
> >         select GOLDFISH
> >         select RTC_DRV_GOLDFISH if RTC_CLASS
> >         select SIFIVE_PLIC
> > +       select PM_GENERIC_DOMAINS if PM
> > +       select PM_GENERIC_DOMAINS_OF if PM && OF
> > +       select RISCV_SBI_CPUIDLE if CPU_IDLE
> >         help
> >           This enables support for QEMU Virt Machine.
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index a5e0482a4969..b8c882b70b02 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_VIRT=y
> >  CONFIG_SMP=y
> >  CONFIG_HOTPLUG_CPU=y
> > +CONFIG_PM=y
> >  CONFIG_CPU_IDLE=y
> >  CONFIG_VIRTUALIZATION=y
> >  CONFIG_KVM=m
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> rv32_defconfig would be removed. I think you could delete this part.
> https://lore.kernel.org/linux-riscv/20220201150545.1512822-9-guoren@kernel.org/T/#u
>
> I would Cc you in the patch, and you could track the progress.

I am not sure in which order Palmer will merge these patches so I
will let him take care of the conflicts in rv32_defconfig.

Regards,
Anup

>
> > index d1b87db54d68..6f9a7c89bff9 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
> >  CONFIG_ARCH_RV32I=y
> >  CONFIG_SMP=y
> >  CONFIG_HOTPLUG_CPU=y
> > +CONFIG_PM=y
> >  CONFIG_CPU_IDLE=y
> >  CONFIG_VIRTUALIZATION=y
> >  CONFIG_KVM=m
> > --
> > 2.25.1
> >
> >
> > --
> > kvm-riscv mailing list
> > kvm-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kvm-riscv
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
