Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6ED46E443
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhLIIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:35:38 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:40890 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhLIIfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:35:36 -0500
Received: by mail-ua1-f52.google.com with SMTP id y5so9320791ual.7;
        Thu, 09 Dec 2021 00:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20DGLvWObAYzP6IPMGk3JRlyueFT8HhxOF7N0eTqzKE=;
        b=pOvb/P9iLWkdgc54RZoJTMtIlxa4UXUJlFd1q/jFTw0irup8VmKjgN1a2V30MYCUVv
         1qXVSujFOA5lAIslG/aWrKi19RWEjDqPKZZlhrjUMKxPpwDLzVOrQ6wzTUbMvHg/BzwP
         6OCqxFgrlaYGMObkiJrRjJMiZ/AF1ahu4Bi+/sjac303qgFRtYnx9Nz93vp+r1PvX7tT
         k/1NGisle3k8XVXJDXymYMWnMBNU7lSv+cqnVixvTJILoBIqnLL3TSI5U/B+dD1/+bPY
         hUKmltJnGUJkky+Id2Vd7tWLQFmHcuL+xxAqQyjZ7y4HgqwP4V2gGYnJD3ZIcnkZ4NPu
         Y5NQ==
X-Gm-Message-State: AOAM5332dMcwT0NQ/44sCIkk3djXqC63/MdP9t2cWkYehmAGHcHYKlpy
        pZVFObZ5sco94wtaBSmhC31znSioaCQVGw==
X-Google-Smtp-Source: ABdhPJyjirEh/J0pZiPBHcYax/UdU0k/+LCwIVn/BH1o9f9aJx0mLHUPjSiOsy9RJ5nMACsgEoZvOA==
X-Received: by 2002:a67:e90d:: with SMTP id c13mr5791508vso.12.1639038721986;
        Thu, 09 Dec 2021 00:32:01 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id f26sm3380674vkl.51.2021.12.09.00.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 00:32:01 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id i6so9325160uae.6;
        Thu, 09 Dec 2021 00:32:01 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr5561941vsj.77.1639038721148;
 Thu, 09 Dec 2021 00:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXh6YfRdGi8gYc4hJuTwogme6+Esn9Mf1vr9MFO=f8mAg@mail.gmail.com> <YbESHK06Tpw3typS@errol.ini.cmu.edu>
In-Reply-To: <YbESHK06Tpw3typS@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Dec 2021 09:31:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6fttX6Jn06WJacNh+1pLz1RfYf82B2fB1D+=Kb9FmMA@mail.gmail.com>
Message-ID: <CAMuHMdV6fttX6Jn06WJacNh+1pLz1RfYf82B2fB1D+=Kb9FmMA@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 9:14 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> I did *some* of this for v3, but since figured out how to use `pahole` :)

Right, pahole.

> On Mon, Dec 06, 2021 at 11:07:56AM +0100, Geert Uytterhoeven wrote:
> > > +struct litex_mmc_host {
> > > +       struct mmc_host *mmc;
> > > +       struct platform_device *dev;
> > > +
> > > +       void __iomem *sdphy;
> > > +       void __iomem *sdcore;
> > > +       void __iomem *sdreader;
> > > +       void __iomem *sdwriter;
> > > +       void __iomem *sdirq;
> > > +
> > > +       u32 resp[4];
> > > +       u16 rca;
> > > +
> > > +       void *buffer;
> > > +       size_t buf_size;
> > > +       dma_addr_t dma;
> > > +
> > > +       unsigned int freq;
> > > +       unsigned int clock;
> > > +       bool is_bus_width_set;
> > > +       bool app_cmd;
> > > +
> > > +       int irq;
> > > +       struct completion cmd_done;
> >
> > You may want to reorder the members to avoid implicit gaps
> > (i.e. structs first, followed by integral types in decreasing size).
>
> So, for v4, I'll have it looking like this, which `pahole` says is
> optimally packed:
>
> struct litex_mmc_host {
>         struct mmc_host *          mmc;                  /*     0     8 */
>         struct platform_device *   dev;                  /*     8     8 */
>         void *                     sdphy;                /*    16     8 */
>         void *                     sdcore;               /*    24     8 */
>         void *                     sdreader;             /*    32     8 */
>         void *                     sdwriter;             /*    40     8 */
>         void *                     sdirq;                /*    48     8 */
>         void *                     buffer;               /*    56     8 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         size_t                     buf_size;             /*    64     8 */

size_t is 32-bit on RV32, so you may want to move it below cmd_done.

>         dma_addr_t                 dma;                  /*    72     8 */
>         struct completion          cmd_done;             /*    80    32 */
>         int                        irq;                  /*   112     4 */
>         unsigned int               ref_clk;              /*   116     4 */
>         unsigned int               sd_clk;               /*   120     4 */
>         u32                        resp[4];              /*   124    16 */
>         /* --- cacheline 2 boundary (128 bytes) was 12 bytes ago --- */
>         u16                        rca;                  /*   140     2 */
>         bool                       is_bus_width_set;     /*   142     1 */
>         bool                       app_cmd;              /*   143     1 */
>
>         /* size: 144, cachelines: 3, members: 18 */
>         /* last cacheline: 16 bytes */
> };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
