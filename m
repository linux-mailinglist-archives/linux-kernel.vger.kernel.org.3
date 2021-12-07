Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1746BD5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbhLGOUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:20:07 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:45995 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhLGOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:20:06 -0500
Received: by mail-ua1-f43.google.com with SMTP id ay21so26771577uab.12;
        Tue, 07 Dec 2021 06:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3eDX+gpnEq1669Ts/beSqCBQNSVYxfxcA34YiglXSA=;
        b=fIxpYezftDitCY4ftfMvO20uom4m7QIIIq1LJMDFjJrfqYFOqJrIHVs8R/yDSjpx/R
         Vm+z5zJ+mhKQkIF2HL36uFSrYr5+JEcD6d6CLmOhWxQ0equ+dZfo1DwDO1BsjS8l3xCY
         5uQO5K7FAnb7Pj2JncKL8C25drCxFna0sfsXv+oHFjfdFBZnJiP3uqwodDbLUJVFAKLs
         MCl9CONE7Btg0kZ4yTEV5amPR8aAa1rr2n0tlp8flXyKokPdQbZAwxVcDchg1XSv0YJK
         2R4MKFxvCHsq3bX6CT2Y+QGPeuoQ+gKhzby69QzkL2cKXFc4qymUXi3XxJZd8TUrEfn+
         slhg==
X-Gm-Message-State: AOAM530cBeJOcwl6cAVwcKQP/S4urZw3dBhou7IpWU887uF9039+UEhg
        wav13SvOMTQ++tUpxu0OHY/LEo497TDC+A==
X-Google-Smtp-Source: ABdhPJyZUVlsTZIGqNBrz7I1oMrd6LrKXp9FVAVh88pSfGzVLgZ8WgOKOFgghaSzpCYvbHGFN4lTbg==
X-Received: by 2002:ab0:72c8:: with SMTP id g8mr50666400uap.86.1638886595229;
        Tue, 07 Dec 2021 06:16:35 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id u11sm6175306vkl.53.2021.12.07.06.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:16:34 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id j14so26730715uan.10;
        Tue, 07 Dec 2021 06:16:34 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr44607890vsf.38.1638886594465;
 Tue, 07 Dec 2021 06:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXkmJ8qxk48AaiC=o0x4manGrL2-J3W0v8GkTaoFoAXuw@mail.gmail.com> <Ya9rSz4KJTwiy830@errol.ini.cmu.edu>
In-Reply-To: <Ya9rSz4KJTwiy830@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Dec 2021 15:16:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQryaYmbaakx3oFHMcuN4==ScPJBmxzbp+ewVqiqnbDQ@mail.gmail.com>
Message-ID: <CAMuHMdWQryaYmbaakx3oFHMcuN4==ScPJBmxzbp+ewVqiqnbDQ@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 3:10 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Mon, Dec 06, 2021 at 01:24:49PM +0100, Geert Uytterhoeven wrote:
> > On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > > LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> > > that targets FPGAs. LiteSDCard is a small footprint, configurable
> > > SDCard core commonly used in LiteX designs.
> > >
> > > The driver was first written in May 2020 and has been maintained
> > > cooperatively by the LiteX community. Thanks to all contributors!
> > >
> > > Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> > > Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> > > Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> > > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

> > > +       host->clock = 0;
> > > +       cpu = of_get_next_cpu_node(NULL);
> > > +       ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);
> > > +       of_node_put(cpu);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
> > > +               goto err_free_host;
> > > +       }
> >
> > This looks fragile.
> > Shouldn't the clock be obtained from a clock property in the mmc
> > device node, pointing to a clock provider?
> > How does the real clock tree look like?
>
> In a full LiteX SoC, the main sys_clock is used for cpu, buses, and as a
> input source for peripherals such as LiteSDCard (which then further
> subdivides it to obtain a 12.5--50.0 MHz sd_clock.
>
> But since we're considering supporting LiteSDCard as an independent IP
> block, the "source clock" frequency should indeed be specified as a DT
> property in the MMC device node. (I'll have to add that to the list of
> updates for litex_json2dts_linux.py as well, once we settle on what it
> will look like -- I'll try to make the change and corresponding update
> to the devicetree bindings doc for v3).
>
> LMK what you think.

Ideally there should be a "clocks" property with a phandle pointing to a
clock controller node (compatible with "litex,clk").

How does drivers/tty/serial/liteuart.c handle this? Oh, it doesn't ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
