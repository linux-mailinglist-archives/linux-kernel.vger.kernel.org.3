Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4958C77D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbiHHLYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbiHHLYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:24:40 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579DDF70
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:24:39 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id d126so4173365vsd.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dysuPV5CQXbSugEYz8f2s3Gi2b71i7Fc2IQ6is/6Qgg=;
        b=aQJP2vIDtiP3KQSy+VjQbxpmSBOSc40evFworfFPveYME9ChOJ0RMr0LntVgRVn3RS
         anLl8QE34fv/7udH1zMX1+pWJv8Jf4k8EGokCZNcSLcpqFIq3KtdiONSopKs3niA7i7I
         7TQIWMK0Ri5HKGL2ICKTbC2iYA+lEJug0R96S7vQS5din8jSxbkL1yQrLNKeCt9U5DL5
         XOD1dvKXzQw12njgL5c+43dBjQumC7fF1Xr4godtQOANYv6JpdktRr8yJNnzkp8ctANO
         Dx8mf65ZA0sSWE16WvHkUJ/WeSFNPulLnDBOHtMFHFCxbR4fWN4HvVGD9h2vfO1gHDp8
         QWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dysuPV5CQXbSugEYz8f2s3Gi2b71i7Fc2IQ6is/6Qgg=;
        b=fMSgGAAAeiDNKrJ4GJaXN7dcUt7U0utNO3FqdqSnspPV4XHVjji9LVc4MLszZfsBV0
         eSL5WFbz8wVJ4CgGSOcuyqRyKA7lTxHO6UQsIXqqiW+D5SAs5eVufSQ8vUa6TIFjJICV
         A5QY2LStmlbct2kvT+2tTSm81Q2I0er6EDfcBovZ7i3HdeOvU/IHcJYkZSwUhiK1rrJy
         aJ1yUj+jsnqQRe0BG0tUJfb4kVwveKleGLtZpaO63TiNYRe+40SaXPqvCRNJ9ejfpie2
         G1aon16JDYUoc0iBWscMEXvPCfK7ShrgwiQiPKsSkjbovL6lety4kTmROVpeKSRxBoyy
         zAeQ==
X-Gm-Message-State: ACgBeo1sJNze7bCeuDz904QgOBou+ppHZ6232TR0wPIu5uFfKSBwQydB
        PPOlIGhTDkmSREa2UMriFwVbU554xR+cRxO08uw=
X-Google-Smtp-Source: AA6agR7SaDRmTIriIvTkNO/kbwJErNvPup8vM7xAQb4GD+KUzgR0AruZYso0fi8ibnk6Sryhzh5lF1hkgF6OgTDyWKs=
X-Received: by 2002:a67:d595:0:b0:388:4392:e067 with SMTP id
 m21-20020a67d595000000b003884392e067mr7742420vsj.78.1659957878664; Mon, 08
 Aug 2022 04:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220808085319.3350111-1-chenhuacai@loongson.cn>
 <87edxrvymh.wl-maz@kernel.org> <CAAhV-H43WQhdnn-QjEAu4gPVt9u7b5hfBXHM6jH2Tt08cBY0eg@mail.gmail.com>
 <87bksvvvcl.wl-maz@kernel.org>
In-Reply-To: <87bksvvvcl.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 8 Aug 2022 19:24:27 +0800
Message-ID: <CAAhV-H4h=go2A88R1NCC_on66Nzbzyvm5223XBP4=nRSWeaJhA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Select downstream irqchip drivers for LoongArch CPU
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Mon, Aug 8, 2022 at 7:16 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 08 Aug 2022 12:06:23 +0100,
> Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Marc,
> >
> > On Mon, Aug 8, 2022 at 6:05 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Mon, 08 Aug 2022 09:53:19 +0100,
> > > Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > LoongArch irqchips have a fixed hierarchy which currently can't be
> > > > described by ACPI tables, so upstream irqchip drivers call downstream
> > > > irqchip drivers' initialization directly. As a result, the top level
> > > > (CPU-level) irqchip driver should explicitly select downstream drivers
> > > > to avoid build errors.
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  drivers/irqchip/Kconfig | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > > > index 66b9fa408bf2..2549daa859d6 100644
> > > > --- a/drivers/irqchip/Kconfig
> > > > +++ b/drivers/irqchip/Kconfig
> > > > @@ -561,6 +561,11 @@ config IRQ_LOONGARCH_CPU
> > > >       select GENERIC_IRQ_CHIP
> > > >       select IRQ_DOMAIN
> > > >       select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> > > > +     select LOONGSON_LIOINTC
> > > > +     select LOONGSON_EIOINTC
> > > > +     select LOONGSON_PCH_PIC
> > > > +     select LOONGSON_PCH_MSI
> > > > +     select LOONGSON_PCH_LPC
> > >
> > > This triggers tons of pretty bad compilation and configuration issues,
> > > as PCI still isn't selectable, even in Linus' tree (see below). I'm
> > > guessing you still have local patches that hide this issue.
> > >
> > > Please test your patches on an upstream tree in the future.
> > I'm very sorry for that. I think this patch should be delayed after
> > 5.20-rc1, then PCI code will have been merged.
>
> Sure, I'm fine with that. However, I have seen the PCI pull request
> going in without any mention of the LoongArch support. Is it going via
> another tree?
PCI drivers have merged, and PCI enablement will go via loongarch
tree. Once I wanted to send PR to Linus today, but Steven said that
the loongarch-next branch breaks some build so I should fix that
first.

Huacai
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
