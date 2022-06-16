Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8332854D91C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358583AbiFPEI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358594AbiFPEIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:08:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B756F89
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:08:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e4so187018ljl.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FBtM5WGvRPEJgUOnS34Z7iJV8/9Y1vR0E19ucVmPQ3M=;
        b=UB5nurzzD04+1pIxtILOfGgDih/srzcyloZ3DgfyURK9qjOpEN4yB7ygzzJsCJIYz4
         /9T8Dd7i6FhH0metYuL+PPPaLXSvH3uf3Lq4yg/bq8B48fbIGmKGY8FLHIcfetgwaUU3
         maWdLV3k//aT8HQ1mibec9XRkbQ98lC1vGgtFWKd3QohAUKrAUE5CCUt/3/kGnqfWUER
         Ls4wSnwxMpY4u8ATWlNXbjoE1kOBuIR9ec168TogcrHc8/dgRGoWL8AtV8fKDb96XKsn
         PI1Am6C6fbvpOTzFisUwJdnoB5YUVT82M3dW3chW28hpG12Yv/TiGToCYPBxfw+LF1jt
         aulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FBtM5WGvRPEJgUOnS34Z7iJV8/9Y1vR0E19ucVmPQ3M=;
        b=1h+xHv0VY0OVaMkjw6bp+N4KUidxLoekio4OU/GhcEfGhHsuH4F/lxojaxwG2IJItt
         8IT88GBtiz7avbgET5+AAg/5Ko/XDbfX51Md0swKgnjpn2ZvRdaM4aTZPSYG2fKC+Wcn
         GozlWtM1ZzhxmEBtTvDnDBkOWOeWYouGODZD82zvtOCeqVCqeULA58uTgnImgX4/bRzR
         UBw7X7yZt1cmzX/quwIDgn0MmojX7f0v1FN47XIcj4gxMhuqeT4Dolt9DxH2x7bwNBSG
         lvR/I3BwfQndTlPNP2jMwFDlNeHatGpbOIpHmD+Ge5tyhMyczPHRvhWwXKm1LYYEUgrO
         TyHg==
X-Gm-Message-State: AJIora+cfQpmjDfb+YiNhbUOe65YNG4vOItCm0kl883AsWTHIorssDvm
        kBBx2GV6wzAoMApOb+VNAaKeaZLmJ+EXFCUqzuk=
X-Google-Smtp-Source: AGRyM1vS/6FI6l5qeqNasa6II+pXlJKkXHvfh+y66TNlxmt10he+2WKAzkzOy89IJmXIaMtfYPV0ih8No1pkyWiYfCc=
X-Received: by 2002:a05:651c:506:b0:255:bc1f:80b5 with SMTP id
 o6-20020a05651c050600b00255bc1f80b5mr1530074ljp.391.1655352513179; Wed, 15
 Jun 2022 21:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220430085344.3127346-1-chenhuacai@loongson.cn>
 <87v8uk6kfa.wl-maz@kernel.org> <f9bafd6c-0819-9046-e0dd-11e2dd98da38@flygoat.com>
 <87a6am3v0y.wl-maz@kernel.org>
In-Reply-To: <87a6am3v0y.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 16 Jun 2022 12:08:22 +0800
Message-ID: <CAAhV-H7EtD2mVGCg3772M5S56Y-hB5gxtfosbp55kMAbB3vkcw@mail.gmail.com>
Subject: Re: [PATCH V11 00/10] irqchip: Add LoongArch-related irqchip drivers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 9, 2022 at 8:01 PM Marc Zyngier <maz@kernel.org> wrote:
>
> + Jianmin Lv
>
> On Fri, 20 May 2022 16:04:28 +0100,
> Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2022/5/5 16:58, Marc Zyngier =E5=86=99=E9=81=93:
> > >> LoongArch use ACPI, but ACPI tables cannot describe the hierarchy of
> > >> irqchips, so we initilize the irqchip subsystem in this way (from ar=
ch
> > >> code):
> > >>
> > >>    cpu_domain =3D loongarch_cpu_irq_init();
> > >>    liointc_domain =3D liointc_acpi_init(cpu_domain, acpi_liointc);
> > >>    eiointc_domain =3D eiointc_acpi_init(cpu_domain, acpi_eiointc);
> > >>    pch_pic_domain =3D pch_pic_acpi_init(eiointc_domain, acpi_pchpic)=
;
> > >>    pch_msi_domain =3D pch_msi_acpi_init(eiointc_domain, acpi_pchmsi)=
;
> > > I said no to this in the past, and I'm going to reiterate: this is
> > > *not* acceptable. This obviously doesn't scale and isn't manageable i=
n
> > > the long run. Hardcoding the topology and the probing order in the
> > > kernel code has repeatedly proved to be a disaster, and yet you refus=
e
> > > to take any input from past experience. This is pretty worrying.
> > Just my two cents here.
> >
> > Those drivers have such a topology just because this was my design to
> > handle irqchip differences between RS780E and LS7A for MIPS-era Loongso=
n.
> >
> > TBH, for LoongArch-era Loongson, they should be handled by the same dri=
ver,
> > cuz the topology behind them just looks like GIC PPI SPI and MSI for
> > Arm GIC.
> >
> > PCH PIC and eiointc in combination relays interrupts from
> > peripherals just like SPI.  liointc is doing the PPI job. They are
> > not separated modules in hardware, they are interlocked.
>
> That was my impression too, but I keep getting pushback on that. I
> wouldn't mind leaving the existing drivers for MIPS only and get new
> ones for Loongson if that made things clearer.
>
> > The system should be treated as a whole, pretty much like how we see
> > Arm's GIC. The topology will last forever for every ACPI enabled
> > LoongArch PC.
> >
> > I see no reason they should be described separately. Adding complicitie=
s to
> > ACPI bindings brings no benefit. Changing ACPI binding which is already=
 in
> > final draft stage can only leave us with chaos.
>
> OK. So how do we move forward? You seem to have a good grasp on how
> this should be structured, so can you work with Jianmin Lv to make
> some progress on this?
Thank you for helping us to move this forward, and I have some
considerations below:
1, Jianmin Lv and I have both made some effort on the irqchip driver
design, but Jianmin more or less lacks some community experience, so
he has made some mistakes as most new-comers. I think he will improve
in the future.
2, And then, maybe we can temporarily ignore those new-comers'
mistakes and focus on the key problem. I think the key problem is that
our irqchip topology is fixed in hardware (not re-organizable, which
can nearly be treated as a whole, as Jiaxun described before), and the
ACPI spec is frozen in late 2021.
3, To solve the key problem, Jianmin and I propose two different
designs. My solution is in V11 and previous versions: initialize the
root irqchip in the arch code, and return the root domain, then the
downstream irqchip takes the root domain as its parent to initialize
itself, and so on. While Jianmin's design is in RFC versions: the arch
code only calls irqchip_init() which causes it to initialize the root
irqchip, and the root irqchip driver explicitly calls its downstream
irqchips' initialization. I think this is the main difference between
them.
4, There is coupling between arch and driver in my solution, and there
is coupling between one driver and some other drivers in Jianmin's
solution. Both of the two solutions are not perfect (or we can even
say they are ugly). Which one do you think is a little better?


Huacai

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
