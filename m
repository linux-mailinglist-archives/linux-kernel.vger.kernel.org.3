Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2947ECAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351802AbhLXHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbhLXHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:32:03 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD73C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 23:32:03 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id c10so4442023vkn.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 23:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54wBWlecbyFX0540obB29Es7wMh4mwDYvkXju67rlO0=;
        b=KcMVl5PRI+s7huz/yN3ODhY1+EHiLE4xE/pqnsN7r2XIcW7nkhbFNGBs0oucmOlJ+F
         Rza1ef8DNVWzZyAMSbtUfc9OEMe2LT6XlDsGhQ1WQiK2q/ZK2uSxlAyy+AgKcD7iTqh1
         U43sN+sPRIuohCIwXMDanTU3AnoL9emSgPNQ+di6UXp4gSB4+LNNxYfQy62sslCqHUAa
         ggx7Uay498MY31XGpoS+20ZgSok7jsAQ8XFNZ0fkjh1lpGNloE0HAbY1vkN/TGmVmA2r
         h0i7Kez6Sywk1nOiR4lYJSFfi3wTrEMFkxjq3N7UBvDnjeKUQgTZ701wrWB/rb8TXAvh
         Fofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54wBWlecbyFX0540obB29Es7wMh4mwDYvkXju67rlO0=;
        b=DEim98CZbht2dWcL3vaaWnxyRYFi5EeP1XhS8QAyhuAljCDY0no2L2fglvzqWa8CDR
         l+oQx2ZhCvPmTrWiIXT3HH7B+xZM7Fz2PSBRw68+9MZDYRyK0IU8vlbaOrfyLSgm3nPb
         cC4Kohpl6EaaFMnzM+sjw7rupcbKmtMdMebC5cWYK2CX1sZCToxrxcndV8e+B7tYjYSn
         RLV/3nPntiqfWAhwUmIc5tVOE218rtBN0PAcTLJ16Qv2PYJ+puP82Zm7O2pblSbBRg6I
         src/tVI2+owi5ZRs75O9h7GdsUAdEtRPaEDR2oYINwdump3rvTKWRCOOmHfVCDtI7H0U
         8rHg==
X-Gm-Message-State: AOAM531ZPpbzNBg4QVTeGBEpiG9CB+ORyDhGCrFsYeozTJ41F4wulOlz
        b+JL977pXmGQWwa1j30nESVXzxGK6ywmD8veNUfiap8LMME=
X-Google-Smtp-Source: ABdhPJwYzK/b8XOtyojPID1Qm658L1Kd+Uhue9uEtBp9WRCocxmdZEOpH0WyTWoKQLx4tSuTN1P83FikS9RPjEiAz5M=
X-Received: by 2002:a05:6122:1684:: with SMTP id 4mr1850286vkl.17.1640331122065;
 Thu, 23 Dec 2021 23:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20211216125157.631992-1-chenhuacai@loongson.cn>
 <20211216125356.632067-1-chenhuacai@loongson.cn> <20211216125356.632067-2-chenhuacai@loongson.cn>
 <87pmpwwpw5.wl-maz@kernel.org> <CAAhV-H75SwqWiRjey_9MiRQtY-_Wjm7Tppx31XM8EfLDb_YUhQ@mail.gmail.com>
 <87czlrwk2k.wl-maz@kernel.org>
In-Reply-To: <87czlrwk2k.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 24 Dec 2021 15:31:53 +0800
Message-ID: <CAAhV-H6VFaRtiyhgq-vDQPUbiAtf9L1M6ZNyeApTu11O9JCXnw@mail.gmail.com>
Subject: Re: [PATCH V8 02/10] irqchip/loongson-pch-pic: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Mon, Dec 20, 2021 at 8:13 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 17 Dec 2021 04:45:24 +0000,
> Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Marc,
> >
> > On Thu, Dec 16, 2021 at 11:06 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 16 Dec 2021 12:53:48 +0000,
> > > Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > We are preparing to add new Loongson (based on LoongArch, not compatible
> > > > with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
> > > > as its boot protocol, so add ACPI init support.
> > > >
> > > > PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
> > > > Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
> > > > please refer Documentation/loongarch/irq-chip-model.rst.
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/irqchip/irq-loongson-pch-pic.c | 108 ++++++++++++++++++-------
> > > >  1 file changed, 81 insertions(+), 27 deletions(-)
> > >
> > > [...]
> > >
> > > >
> > > > +#ifdef CONFIG_ACPI
> > > > +
> > > > +struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
> > > > +                                     struct acpi_madt_bio_pic *acpi_pchpic)
> > >
> > > Who is calling this? This works the opposite way from what the arm64
> > > irqchips are doing. Why? I have the ugly feeling that this is called
> > > from the arch code, bypassing the existing infrastructure...
> > Yes, this is called from the arch code and a bit ugly, but I can't
> > find a better way to do this.
> >
> > Is the "existing infrastructure" declare the irqchip init function
> > with  IRQCHIP_ACPI_DECLARE and the arch code only need to call
> > irqchip_init()? Then we have a problem: our irqchips have a 4 level
> > hierachy and the parent should be initialized before its children. In
> > FDT world this is not a problem, because of_irq_init() will sort
> > irqchip drivers to ensure the right order. But in ACPI world,
> > acpi_probe_device_table just call init functions in the linking order.
> > If we want to control the order, it seems we can only sort the drivers
> > in drivers/irq/Makefile. But I don't think this is a good idea...
> >
> > If there are better solutions, please let me know. Thanks.
>
> We have the exact same thing on the arm64 side, and we don't need of
> this to be arch specific:
>
> - The MADT table describes the root interrupt controller, and it is
>   probed via IRQCHIP_ACPI_DECLARE().
>
> - Each children controller is declared in ACPI as a *device*, and is
>   both an interrupt producer and an interrupt consumer. Normal probe
>   deferral rules apply. See irq-mbigen.c for an example of how this is
>   done.
Thank you for your suggestions, I have tried but failed. It seems
there are some differences between irq-mbigen.c and our irqchips.
Because our irqchips are mandatory while mbigen is optional. If we
declare our irqchips as devices, they are initialized in the initcall
phase, which is too late for pci devices.

Huacai

>
> With that, you can remove all the probing order management from your
> arch code and let the standard Linux driver model take over.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
