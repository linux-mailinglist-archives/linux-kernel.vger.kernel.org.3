Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FF34695A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbhLFM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:28:35 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:44652 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243054AbhLFM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:28:31 -0500
Received: by mail-ua1-f53.google.com with SMTP id p2so19064732uad.11;
        Mon, 06 Dec 2021 04:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pgLWD4rU3sbBIUNHmWzCgR9e6k+oT6xFT9MN28bnto=;
        b=1Zuv1i5du31tjgd0ZJyxWv3sHJ5fPQS8hbqV58KO1VnSHEKzYlOZW8P/cNb/Q18dIE
         J29wMjg8W0XfK+q9e8MDMQLmfGFNwyBDkpnojwckF3dYr9ncDBWmL7uZ67cl7Gmd21A3
         jc1VXZb/penBKq4O6Hod/pWlzEepX8kLy1zbeQ/gUcch4qob1CQSK7A6GleE8Yj9PrsI
         Yqq7bbqIDMJNC1QP8CzD0vKe87/rGlyBJbiVCXlNdQ+SLxa5qwVpkn8H+k0sgp2AtqUs
         kYL2bCVSup3fLDlUFP8O4npkg0UVO+LsyJjuSgJaepcE21NTbHZeFSb8t+yXlJ/CCWY9
         5W7A==
X-Gm-Message-State: AOAM531+97+WHtuF8lCCJRV9xL8QMN1c4h6yQ8KlvULcjbqoPaOyBgnG
        yuLyCB9PTtILae8PiTVRF7ckEjXY6pEWBw==
X-Google-Smtp-Source: ABdhPJwoqFGcOkuQcX/pcvHiF8ydvpeA89sya2f5HnXY5SNJ6nxXV6O8WO8TYLpyDuRxDk5pciyp2Q==
X-Received: by 2002:a05:6102:3053:: with SMTP id w19mr31242273vsa.60.1638793501684;
        Mon, 06 Dec 2021 04:25:01 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id g28sm3992429vkl.16.2021.12.06.04.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 04:25:00 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id s1so6618187vks.9;
        Mon, 06 Dec 2021 04:25:00 -0800 (PST)
X-Received: by 2002:a1f:9f04:: with SMTP id i4mr39914732vke.33.1638793500250;
 Mon, 06 Dec 2021 04:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20211204204121.2367127-1-gsomlo@gmail.com> <20211204204121.2367127-4-gsomlo@gmail.com>
In-Reply-To: <20211204204121.2367127-4-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 13:24:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXkmJ8qxk48AaiC=o0x4manGrL2-J3W0v8GkTaoFoAXuw@mail.gmail.com>
Message-ID: <CAMuHMdXkmJ8qxk48AaiC=o0x4manGrL2-J3W0v8GkTaoFoAXuw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Sat, Dec 4, 2021 at 9:41 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> LiteX (https://github.com/enjoy-digital/litex) is a SoC framework
> that targets FPGAs. LiteSDCard is a small footprint, configurable
> SDCard core commonly used in LiteX designs.
>
> The driver was first written in May 2020 and has been maintained
> cooperatively by the LiteX community. Thanks to all contributors!
>
> Co-developed-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Signed-off-by: Kamil Rakoczy <krakoczy@antmicro.com>
> Co-developed-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Signed-off-by: Maciej Dudek <mdudek@internships.antmicro.com>
> Co-developed-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

> --- /dev/null
> +++ b/drivers/mmc/host/litex_mmc.c

> +static void
> +litex_set_clk(struct litex_mmc_host *host, unsigned int clk_freq)
> +{
> +       u32 div = clk_freq ? host->freq / clk_freq : 256;
> +
> +       div = roundup_pow_of_two(div);
> +       div = min_t(u32, max_t(u32, div, 2), 256);
> +       dev_info(&host->dev->dev, "sdclk_freq=%d: set to %d via div=%d\n",
> +                clk_freq, host->freq / div, div);
> +       litex_write16(host->sdphy + LITEX_PHY_CLOCKERDIV, div);
> +}
> +
> +static void
> +litex_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct litex_mmc_host *host = mmc_priv(mmc);
> +
> +       /* NOTE: Ignore any ios->bus_width updates; they occur right after
> +        * the mmc core sends its own acmd6 bus-width change notification,
> +        * which is redundant since we snoop on the command flow and inject
> +        * an early acmd6 before the first data transfer command is sent!
> +        */
> +
> +       /* update sdcard clock */
> +       if (ios->clock != host->clock) {
> +               litex_set_clk(host, ios->clock);
> +               host->clock = ios->clock;

It might be better to move the assignment to host->clock into the callee,
to avoid it becoming out-of-sync when a second caller is introduced.

> +       }
> +}

> +static int
> +litex_mmc_probe(struct platform_device *pdev)
> +{
> +       struct litex_mmc_host *host;
> +       struct mmc_host *mmc;
> +       struct device_node *cpu;
> +       int ret;
> +
> +       mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), &pdev->dev);
> +       /* NOTE: defaults to max_[req,seg]_size=PAGE_SIZE, max_blk_size=512,
> +        * and max_blk_count accordingly set to 8;
> +        * If for some reason we need to modify max_blk_count, we must also
> +        * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
> +        */
> +       if (!mmc)
> +               return -ENOMEM;
> +
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->dev = pdev;
> +
> +       host->clock = 0;
> +       cpu = of_get_next_cpu_node(NULL);
> +       ret = of_property_read_u32(cpu, "clock-frequency", &host->freq);
> +       of_node_put(cpu);
> +       if (ret) {
> +               dev_err(&pdev->dev, "No \"clock-frequency\" property in DT\n");
> +               goto err_free_host;
> +       }

This looks fragile.
Shouldn't the clock be obtained from a clock property in the mmc
device node, pointing to a clock provider?
How does the real clock tree look like?


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
