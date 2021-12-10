Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3696C46FC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhLJIIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:08:53 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:34609 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbhLJIIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:08:46 -0500
Received: by mail-ua1-f48.google.com with SMTP id n6so15430719uak.1;
        Fri, 10 Dec 2021 00:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH7F0fp9zVLNg9SdmOvmxUJFloiowP2ZLoTAulUsaCc=;
        b=mXTDJr9ixpENOoy9vLzSRW1/MhZvNe1CvUIm8XeaYZoZMqTiQRFPmM+PnDarg6s77g
         tI6X4/VH+2RSmyXJUa1LcECED/YTK5uiOpLoJauERZ+8b5iGQY0j05H9TyFAxKFmMvQ4
         mUy0n44tynIXc+8peLx+aSsoWEIiEPHT3eOmZx6HjOs66p6rmN2XRp07Qi33N9ERfe16
         6fHpiLQcR5C0c2hy3GYoiJ9RMvwdpKArRX4sNJJNxB7LdFeTwcuktrKIl6fIiDYspQnk
         adcsqyOQd7InoKh9nJLgoqcpUgBDjuSIAzhbCP2uuWV6nTMLEaQYUlEImRHQx4HMyPtc
         2ZRg==
X-Gm-Message-State: AOAM530uIuZPlzdLXExWfYwIUyNQZhyFUT4Vp/fDOVaFGOYVboVToQdV
        yjUb70fY7MZYxW155ZciFt9Kt1YEmVdqtg==
X-Google-Smtp-Source: ABdhPJzkU8tWw60iYC/ZSI/3in5dTBZf1EHrwGNsaK1zgDv0mtMNZVM/ZAVUrGMMh38nSFQgu5C4Rg==
X-Received: by 2002:a05:6102:5594:: with SMTP id dc20mr13605221vsb.75.1639123510978;
        Fri, 10 Dec 2021 00:05:10 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id f188sm1432322vsc.16.2021.12.10.00.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 00:05:10 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id q21so5478677vkn.2;
        Fri, 10 Dec 2021 00:05:09 -0800 (PST)
X-Received: by 2002:a05:6122:104f:: with SMTP id z15mr17065717vkn.39.1639123509480;
 Fri, 10 Dec 2021 00:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXh6YfRdGi8gYc4hJuTwogme6+Esn9Mf1vr9MFO=f8mAg@mail.gmail.com>
 <YbESHK06Tpw3typS@errol.ini.cmu.edu> <CAMuHMdV6fttX6Jn06WJacNh+1pLz1RfYf82B2fB1D+=Kb9FmMA@mail.gmail.com>
 <YbJt3NLU9KPO+ERu@errol.ini.cmu.edu>
In-Reply-To: <YbJt3NLU9KPO+ERu@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Dec 2021 09:04:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJx6Ahw6ASOn0bvg0gm6CBs2KnEsThJ8RSgdrHXqSVJA@mail.gmail.com>
Message-ID: <CAMuHMdWJx6Ahw6ASOn0bvg0gm6CBs2KnEsThJ8RSgdrHXqSVJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Thu, Dec 9, 2021 at 9:58 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Thu, Dec 09, 2021 at 09:31:49AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 8, 2021 at 9:14 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > I did *some* of this for v3, but since figured out how to use `pahole` :)
> >
> > Right, pahole.
> >
> > > On Mon, Dec 06, 2021 at 11:07:56AM +0100, Geert Uytterhoeven wrote:
> > > > > +struct litex_mmc_host {
> > > > > +       struct mmc_host *mmc;
> > > > > +       struct platform_device *dev;
> > > > > +
> > > > > +       void __iomem *sdphy;
> > > > > +       void __iomem *sdcore;
> > > > > +       void __iomem *sdreader;
> > > > > +       void __iomem *sdwriter;
> > > > > +       void __iomem *sdirq;
> > > > > +
> > > > > +       u32 resp[4];
> > > > > +       u16 rca;
> > > > > +
> > > > > +       void *buffer;
> > > > > +       size_t buf_size;
> > > > > +       dma_addr_t dma;
> > > > > +
> > > > > +       unsigned int freq;
> > > > > +       unsigned int clock;
> > > > > +       bool is_bus_width_set;
> > > > > +       bool app_cmd;
> > > > > +
> > > > > +       int irq;
> > > > > +       struct completion cmd_done;
> > > >
> > > > You may want to reorder the members to avoid implicit gaps
> > > > (i.e. structs first, followed by integral types in decreasing size).
> > >
> > > So, for v4, I'll have it looking like this, which `pahole` says is
> > > optimally packed:
> > >
> > > struct litex_mmc_host {
> > >         struct mmc_host *          mmc;                  /*     0     8 */
> > >         struct platform_device *   dev;                  /*     8     8 */
> > >         void *                     sdphy;                /*    16     8 */
> > >         void *                     sdcore;               /*    24     8 */
> > >         void *                     sdreader;             /*    32     8 */
> > >         void *                     sdwriter;             /*    40     8 */
> > >         void *                     sdirq;                /*    48     8 */
> > >         void *                     buffer;               /*    56     8 */
> > >         /* --- cacheline 1 boundary (64 bytes) --- */
> > >         size_t                     buf_size;             /*    64     8 */
> >
> > size_t is 32-bit on RV32, so you may want to move it below cmd_done.
> >
> > >         dma_addr_t                 dma;                  /*    72     8 */
> > >         struct completion          cmd_done;             /*    80    32 */
> > >         int                        irq;                  /*   112     4 */
> > >         unsigned int               ref_clk;              /*   116     4 */
> > >         unsigned int               sd_clk;               /*   120     4 */
> > >         u32                        resp[4];              /*   124    16 */
> > >         /* --- cacheline 2 boundary (128 bytes) was 12 bytes ago --- */
> > >         u16                        rca;                  /*   140     2 */
> > >         bool                       is_bus_width_set;     /*   142     1 */
> > >         bool                       app_cmd;              /*   143     1 */
> > >
> > >         /* size: 144, cachelines: 3, members: 18 */
> > >         /* last cacheline: 16 bytes */
> > > };
>
> After a bit of a fight, I managed to wrestle `pahole` to display useful
> information for 32-bit (rv32imac) builds:
>
> struct litex_mmc_host {
>         struct mmc_host *          mmc;                  /*     0     4 */
>         struct platform_device *   dev;                  /*     4     4 */
>         void *                     sdphy;                /*     8     4 */
>         void *                     sdcore;               /*    12     4 */
>         void *                     sdreader;             /*    16     4 */
>         void *                     sdwriter;             /*    20     4 */
>         void *                     sdirq;                /*    24     4 */
>         void *                     buffer;               /*    28     4 */
>         size_t                     buf_size;             /*    32     4 */
>         dma_addr_t                 dma;                  /*    36     4 */
>         struct completion          cmd_done;             /*    40    16 */
>         int                        irq;                  /*    56     4 */
>         unsigned int               ref_clk;              /*    60     4 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         unsigned int               sd_clk;               /*    64     4 */
>         u32                        resp[4];              /*    68    16 */
>         u16                        rca;                  /*    84     2 */
>         bool                       is_bus_width_set;     /*    86     1 */
>         bool                       app_cmd;              /*    87     1 */
>
>         /* size: 88, cachelines: 2, members: 18 */
>         /* last cacheline: 24 bytes */
> };
>
> Looks like even with `size_t buf_size` where it is right now, there
> still are no holes. I like it where it is, as it's related to the

Right, dma_addr_t is 32-bit, too. I'm just too used to LPAE on ARM ;-)

> field immediately preceding it (`buffer`). I'd rather not move it,
> particularly since we're not actually eliminating any additional
> holes.

Thanks, LGTM.

> What do you think (i.e., is there a configuration where there's still
> a chance we may run into trouble)?

ICONFIG_PHYS_ADDR_T_64BIT=y/CONFIG_ARCH_DMA_ADDR_T_64BIT=y
on 32-bit, but that doesn't seem to be supported under arch/risc/ yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
