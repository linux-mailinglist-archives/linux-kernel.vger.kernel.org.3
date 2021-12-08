Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421DE46D02C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhLHJjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:39:12 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:34353 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLHJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:39:10 -0500
Received: by mail-ua1-f42.google.com with SMTP id n6so3647451uak.1;
        Wed, 08 Dec 2021 01:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvTD69XJxS18ehgvPHba0VP69gYvcD1gn33TndAh+h4=;
        b=omBOX9bBtopmUScdkT/uMJSDpkJ20z6XmMZc/cuvW2Q7g8FwlYYj571wVe741f6L2D
         jU8/yaOgj2wxhBndLLzpuNXJbwIfoaOXFNuMB92IpCiB2OOxA1KOlp/4UYxKrtt2TPvN
         0Few9DRvRmdvUqPnVvE1H+8tyVB4kNP9hr65S2iXQdlbRfVzwbgQ8pj07XnMx3V4FlMG
         jpCYvj+cP9f6HPERRemhbuFvLNAG2EpnjDs/In0MTqhvhyiUo5DEquxDIC1h9B8WwVIj
         mGmo6FWNRsHHuyaBHORAe5jXsLf8i3rQq6KGEQkw7iCdPYGapSPWDlc6vMWZlQLn3/BX
         +9NQ==
X-Gm-Message-State: AOAM533GveE1YmlK1Xis8KdyS/kd00oHHN9tczJMk2LqWoN10suPjPW5
        LikmjAClxnI9BABSdYwnTivZtZSPE0+U9w==
X-Google-Smtp-Source: ABdhPJxgHe/XB3CzJK5Q++jXvfeFpRK1f83XicK5Pg7Vi6MiuKUnHRTBYq/PSbWJXjc/EJcveIoBcA==
X-Received: by 2002:a67:d994:: with SMTP id u20mr51380410vsj.12.1638956138397;
        Wed, 08 Dec 2021 01:35:38 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id e13sm1432029vkd.21.2021.12.08.01.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 01:35:37 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a14so3713943uak.0;
        Wed, 08 Dec 2021 01:35:37 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr53071891vsj.77.1638956137319;
 Wed, 08 Dec 2021 01:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXkmJ8qxk48AaiC=o0x4manGrL2-J3W0v8GkTaoFoAXuw@mail.gmail.com>
 <Ya9rSz4KJTwiy830@errol.ini.cmu.edu> <CAMuHMdWQryaYmbaakx3oFHMcuN4==ScPJBmxzbp+ewVqiqnbDQ@mail.gmail.com>
 <Ya/SbwzYUD3gwwOL@errol.ini.cmu.edu>
In-Reply-To: <Ya/SbwzYUD3gwwOL@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Dec 2021 10:35:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXm=FNJ7-4emwDPdd3cpCneXL3EiGGzZNqt0DCQOS+pag@mail.gmail.com>
Message-ID: <CAMuHMdXm=FNJ7-4emwDPdd3cpCneXL3EiGGzZNqt0DCQOS+pag@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 10:30 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Tue, Dec 07, 2021 at 03:16:22PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Dec 7, 2021 at 3:10 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > On Mon, Dec 06, 2021 at 01:24:49PM +0100, Geert Uytterhoeven wrote:
> > > > On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > > > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > > > SDCard core commonly used in LiteX designs.
> > > > >
> > > > > The driver was first written in May 2020 and has been maintained
> > > > > cooperatively by the LiteX community. Thanks to all contributors!
> > > > >
> > > > > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > > > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > > > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > > > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > > > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > > > > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> >
> > > > > +       host->clock = 0;
> > > > > +       cpu = of_get_next_cpu_node(NULL);
> > > > > +       ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);
> > > > > +       of_node_put(cpu);
> > > > > +       if (ret) {
> > > > > +               dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
> > > > > +               goto err_free_host;
> > > > > +       }
> > > >
> > > > This looks fragile.
> > > > Shouldn't the clock be obtained from a clock property in the mmc
> > > > device node, pointing to a clock provider?
> > > > How does the real clock tree look like?
> > >
> > > In a full LiteX SoC, the main sys_clock is used for cpu, buses, and as a
> > > input source for peripherals such as LiteSDCard (which then further
> > > subdivides it to obtain a 12.5--50.0 MHz sd_clock.
> > >
> > > But since we're considering supporting LiteSDCard as an independent IP
> > > block, the "source clock" frequency should indeed be specified as a DT
> > > property in the MMC device node. (I'll have to add that to the list of
> > > updates for litex_json2dts_linux.py as well, once we settle on what it
> > > will look like -- I'll try to make the change and corresponding update
> > > to the devicetree bindings doc for v3).
> > >
> > > LMK what you think.
> >
> > Ideally there should be a "clocks" property with a phandle pointing to a
> > clock controller node (compatible with "litex,clk").
> >
> > How does drivers/tty/serial/liteuart.c handle this? Oh, it doesn't ;-)
>
> Assuming LiteX's `litex_json2dts_linux.py` is modified to include:
>
>         ...
>         clocks {
>                 sys_clk: litex_sys_clk {
>                         #clock-cells = <0>;
>                         compatible = "fixed-clock";
>                         clock-frequency = <50000000>;
>                 };
>         };
>         ...
>
> in the generated .dts (where `clock-frequency` is whatever the sys_clk
> happens to be for that particular SoC gateware), we can then write the
> mmc node like so:
>
>         soc {
>                 ...
>                 mmc0: mmc@12005000 {
>                         compatible = "litex,mmc";
>                         reg = <0x12005000 0x100>,
>                                 <0x12003800 0x100>,
>                                 <0x12003000 0x100>,
>                                 <0x12004800 0x100>,
>                                 <0x12004000 0x100>;
>                         reg-names = "phy", "core", "reader", "writer", "irq";
>                         clocks = <&sys_clk>;
>                         interrupt-parent = <&L1>;
>                         interrupts = <4>;
>                 };
>                 ...
>         };

LGTM.

> The LiteSDCard clock initialization can then look like this:
>
>         ...
>         /* initialize clock source */
>         clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(clk)) {
>                 ret = PTR_ERR(clk);
>                 dev_err(&pdev->dev, "can't get clock: %d\n", ret);

Please use

    ret = dev_err_probe(&pdev->dev, PTR_ERR(clk), "can't get clock\n");

to avoid printing the error in case of probe deferral.

>                 goto err;
>         }
>         host->freq = clk_get_rate(clk); /* source (sys_clock) frequency */
>         host->clock = 0;                /* calculated sdclock frequency */
>         ...
>
> As discussed before, I'll post a `litex_json2dts_linux.py` patch once
> we've settled on a mutually agreeable solution, but I think this might
> be it. If you agree, I'll also update the DT binding document to
> require `clocks` as part of the mmc node.
>
> I tested this in my v3 candidate, and it seems to be working OK.
>
> LMK what you think, and/or if you have any suggestions for additional
> improvements.

Nice, that's a good solution, until the full clock tree is exposed in
the DTS. Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
