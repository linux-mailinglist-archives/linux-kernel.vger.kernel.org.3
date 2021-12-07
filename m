Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42F46C6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhLGVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLGVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:33:58 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E038C061574;
        Tue,  7 Dec 2021 13:30:27 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a24so601193qvb.5;
        Tue, 07 Dec 2021 13:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1IIAz09JDyX4/iq8SzmPb8VQdcf32xZWSPgq4leGxpQ=;
        b=nnzlfUwM9c+qv3amXYwxTqiTH4PrIiXjFKvL6rYsgNOo7szWPv50RSTPBI2XB1RCvY
         gsdlzTvc1jbdQbehEw1mYdVKhWss3xF3av/TIVA91Y9fEqGAGX0liRFw0mFNyi3SVqnf
         +Z30QzmIovAggggqnkxFDVNyOpcdT1sRqbEfvV9WQc/U2RkkuQxZpC/p1g8UCp2aSxFF
         LrvDXB3DM9MJryxW1sjdSIgSOs+NTxmvzIgnP/H0P6FZwQXAC/00j0HXMe64nL04netX
         NIRum7rBbzAPuQoerIBOstYRiQUp7rlvpNvtp9Z1ewM4cYkpD9vjMRmUE4QfRieCeQex
         iE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1IIAz09JDyX4/iq8SzmPb8VQdcf32xZWSPgq4leGxpQ=;
        b=nxTiNdwGZnCvBJgqyarNB2WC5YyU4EzHTW//vOfRZtEzT+8gcvUoe+wHQzC44dNAKx
         NA7vlxE6UAOfl0JxDdYXscskhFZ2t24wGY+yqLLldAeU2u8iTDFeQqi73bVG29+CBFIM
         tEO/cASUCaEHf/2Ef/5dsnXXSv93UJfS1D1bP4YW8viaNKSNUsPEFJt/ewhr9hqfCOc5
         bspNGMpN9zuUjkJKY7pLD8eZqoydZmaLMKpG2rDgnepKsLbuzeL3WOQjjj0QYOX5P8/h
         1wIKDpDFaTDsmoVL+FPnYCDF0QN11Ar8ag7gjHENyRETaRnJA0OfICqfcyYQF38Z/dAA
         SZMg==
X-Gm-Message-State: AOAM530fYpELVFkr5fRyeREtW1lDOxt+qTUNzCZYCzhfUpaXi4yjCuKJ
        sfkWGIqUE0atuvsuEMDx52Q=
X-Google-Smtp-Source: ABdhPJyai9WcFbjHyukVP4BFgo1ifRMxvpfnjRZ+tFtZgjXQQU/RKioO7JCSTaqiuy2FuPiOhcSb6A==
X-Received: by 2002:a05:6214:234a:: with SMTP id hu10mr2366260qvb.55.1638912626322;
        Tue, 07 Dec 2021 13:30:26 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id c7sm582078qtc.32.2021.12.07.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:30:25 -0800 (PST)
Date:   Tue, 7 Dec 2021 16:30:23 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Ya/SbwzYUD3gwwOL@errol.ini.cmu.edu>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXkmJ8qxk48AaiC=o0x4manGrL2-J3W0v8GkTaoFoAXuw@mail.gmail.com>
 <Ya9rSz4KJTwiy830@errol.ini.cmu.edu>
 <CAMuHMdWQryaYmbaakx3oFHMcuN4==ScPJBmxzbp+ewVqiqnbDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWQryaYmbaakx3oFHMcuN4==ScPJBmxzbp+ewVqiqnbDQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I think I figured out a solution, see below:

On Tue, Dec 07, 2021 at 03:16:22PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 7, 2021 at 3:10 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > On Mon, Dec 06, 2021 at 01:24:49PM +0100, Geert Uytterhoeven wrote:
> > > On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > > SDCard core commonly used in LiteX designs.
> > > >
> > > > The driver was first written in May 2020 and has been maintained
> > > > cooperatively by the LiteX community. Thanks to all contributors!
> > > >
> > > > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > > > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> 
> > > > +       host->clock = 0;
> > > > +       cpu = of_get_next_cpu_node(NULL);
> > > > +       ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);
> > > > +       of_node_put(cpu);
> > > > +       if (ret) {
> > > > +               dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
> > > > +               goto err_free_host;
> > > > +       }
> > >
> > > This looks fragile.
> > > Shouldn't the clock be obtained from a clock property in the mmc
> > > device node, pointing to a clock provider?
> > > How does the real clock tree look like?
> >
> > In a full LiteX SoC, the main sys_clock is used for cpu, buses, and as a
> > input source for peripherals such as LiteSDCard (which then further
> > subdivides it to obtain a 12.5--50.0 MHz sd_clock.
> >
> > But since we're considering supporting LiteSDCard as an independent IP
> > block, the "source clock" frequency should indeed be specified as a DT
> > property in the MMC device node. (I'll have to add that to the list of
> > updates for litex_json2dts_linux.py as well, once we settle on what it
> > will look like -- I'll try to make the change and corresponding update
> > to the devicetree bindings doc for v3).
> >
> > LMK what you think.
> 
> Ideally there should be a "clocks" property with a phandle pointing to a
> clock controller node (compatible with "litex,clk").
> 
> How does drivers/tty/serial/liteuart.c handle this? Oh, it doesn't ;-)

Assuming LiteX's `litex_json2dts_linux.py` is modified to include:

        ...
        clocks {
                sys_clk: litex_sys_clk {
                        #clock-cells = <0>;
                        compatible = "fixed-clock";
                        clock-frequency = <50000000>;
                };
        };
        ...

in the generated .dts (where `clock-frequency` is whatever the sys_clk
happens to be for that particular SoC gateware), we can then write the
mmc node like so:

	soc {
		...
                mmc0: mmc@12005000 {
                        compatible = "litex,mmc";
                        reg = <0x12005000 0x100>,
                                <0x12003800 0x100>,
                                <0x12003000 0x100>,
                                <0x12004800 0x100>,
                                <0x12004000 0x100>;
                        reg-names = "phy", "core", "reader", "writer", "irq";
                        clocks = <&sys_clk>;
                        interrupt-parent = <&L1>;
                        interrupts = <4>;
                };
		...
        };

The LiteSDCard clock initialization can then look like this:

	...
        /* initialize clock source */
        clk = devm_clk_get(&pdev->dev, NULL);
        if (IS_ERR(clk)) {
                ret = PTR_ERR(clk);
                dev_err(&pdev->dev, "can't get clock: %d\n", ret);
                goto err;
        }
        host->freq = clk_get_rate(clk); /* source (sys_clock) frequency */
        host->clock = 0;		/* calculated sdclock frequency */
	...

As discussed before, I'll post a `litex_json2dts_linux.py` patch once
we've settled on a mutually agreeable solution, but I think this might
be it. If you agree, I'll also update the DT binding document to
require `clocks` as part of the mmc node.

I tested this in my v3 candidate, and it seems to be working OK.

LMK what you think, and/or if you have any suggestions for additional
improvements.

Thanks again,
--Gabriel
