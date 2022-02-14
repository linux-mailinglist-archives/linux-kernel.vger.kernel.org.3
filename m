Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF04B4DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbiBNLQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:16:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350694AbiBNLPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:15:50 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03496C1FE;
        Mon, 14 Feb 2022 02:45:48 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id 4so5162217uaf.0;
        Mon, 14 Feb 2022 02:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpsKiepJz/NjXSBpI+epGj0sOrly3NjEOR9KULzKccQ=;
        b=bE5DmghwEdFI+7Y7rHMw2XGuNaY5jJtASWRRJ/zwK3nGXgIHodO0GZEd+gU/jSpr2i
         +3ULrZQXfi4gs6bSodxmPfOvtWToxTr27f/7q9dmxvmmTdIPo4vNTEOGoLvaH9kz4jZe
         fsdOXo9fmeB078oiU5Pt/FQZgfpIN81tdbi96JKLJD60sahfByHkfznBD9JY5bS8szem
         HynGVT0OqH83yzp84jvxvpMLiLlOlJQvwh1CYm1JB3zXN5W2BCfY89B9HHQuE+0umdqo
         m6JN/qnfm07wAOUkeZ9Zryj6v8mEHcAB+HdHxlHVAiB2uoYGPjP+SaDN4Vm1G9o/qHqA
         TngA==
X-Gm-Message-State: AOAM533WxwE6PHRT5C7ItEIHCgN641mWkS/q6RtlNGYoyOTeVJDuOHAB
        quUAgJxDzdSldAz54eG5BL4G9niyafMZlQ==
X-Google-Smtp-Source: ABdhPJzPHngeLFoB4phNLjn73R4ONFF5aDIHpjpxsEGDZqwGf5TJmsPxWC9P8nsJL0m9WvWPR/aRUg==
X-Received: by 2002:ab0:7183:: with SMTP id l3mr238501uao.80.1644835547819;
        Mon, 14 Feb 2022 02:45:47 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id v13sm1758493vsr.10.2022.02.14.02.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:45:47 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id e26so1915004vso.3;
        Mon, 14 Feb 2022 02:45:47 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr1050592vsb.5.1644835547102;
 Mon, 14 Feb 2022 02:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20220208183511.2925304-1-jjhiblot@traphandler.com> <20220208183511.2925304-7-jjhiblot@traphandler.com>
In-Reply-To: <20220208183511.2925304-7-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 11:45:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCT-qwhN53mRnAUox2pqw+Y5-7Gw5EbC+-HCF054kkgQ@mail.gmail.com>
Message-ID: <CAMuHMdUCT-qwhN53mRnAUox2pqw+Y5-7Gw5EbC+-HCF054kkgQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] clk: renesas: r9a06g032: Disable the watchdog
 reset sources when halting
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

CC watchdog people, who only received some patches.

On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> The watchdog reset sources must be disabled when the system is halted.
> Otherwise the watchdogs will trigger a reset if they have been armed.
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks for your patch!

[inserting changelog]

| Changes v1 -> v2:
| * Modified the clock driver to not enable the watchdog reset sources.
|   On other renesas platforms, those bits are by the bootloader. The
|   watchdog reset sources are still disabled when the platform is halted
|   to prevent a watchdog reset.

I still have my doubts about this part. So on halt, you override the
policy configured by the boot loader, which means the watchdog is no
longer triggered on halt.

From a system perspective, the system can be in five states:
  1. Running,
  2. Crashed/lock-ed up,
  3. Halt,
  4. Reboot,
  5. Poweroff.

Now, from a policy perspective, what is the difference between a
system that crashes or locks up, and a system that halts?
I.e. should the system reboot on halt, or not?

I think halting a system where the watchdog has been activated makes
no sense, and the user either wants to explicitly reboot the system, or
power it off, but never halt it.  So I think this patch is not needed.

Watchdog people: what is your opinion?
Thanks!

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -129,6 +129,11 @@ enum { K_GATE = 0, K_FFC, K_DIV, K_BITSEL, K_DUALGATE };
>
>  #define R9A06G032_CLOCK_COUNT          (R9A06G032_UART_GROUP_34567 + 1)
>
> +#define R9A06G032_SYSCTRL_REG_RSTEN            0x120
> +#define WDA7RST1       BIT(2)
> +#define WDA7RST0       BIT(1)
> +#define MRESET         BIT(0)
> +
>  static const struct r9a06g032_clkdesc r9a06g032_clocks[] = {
>         D_ROOT(CLKOUT, "clkout", 25, 1),
>         D_ROOT(CLK_PLL_USB, "clk_pll_usb", 12, 10),
> @@ -893,6 +898,19 @@ static void r9a06g032_clocks_del_clk_provider(void *data)
>         of_clk_del_provider(data);
>  }
>
> +static void r9a06g032_reset_sources(struct r9a06g032_priv *clocks,
> +                       uint32_t mask, uint32_t value)
> +{
> +       uint32_t rsten;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&clocks->lock, flags);
> +       rsten = readl(clocks->reg);
> +       rsten = (rsten & ~mask) | (value & mask);
> +       writel(rsten, clocks->reg + R9A06G032_SYSCTRL_REG_RSTEN);
> +       spin_unlock_irqrestore(&clocks->lock, flags);
> +}
> +
>  static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -910,6 +928,8 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>         if (!clocks || !clks)
>                 return -ENOMEM;
>
> +       platform_set_drvdata(pdev, clocks);
> +
>         spin_lock_init(&clocks->lock);
>
>         clocks->data.clks = clks;
> @@ -963,9 +983,18 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>         if (error)
>                 return error;
>
> +
>         return r9a06g032_add_clk_domain(dev);
>  }
>
> +static void r9a06g032_clocks_shutdown(struct platform_device *pdev)
> +{
> +       struct r9a06g032_priv *clocks = platform_get_drvdata(pdev);
> +
> +       /* Disable the watchdog reset sources */
> +       r9a06g032_reset_sources(clocks, WDA7RST0 | WDA7RST1, 0);
> +}
> +
>  static const struct of_device_id r9a06g032_match[] = {
>         { .compatible = "renesas,r9a06g032-sysctrl" },
>         { }
> @@ -976,6 +1005,7 @@ static struct platform_driver r9a06g032_clock_driver = {
>                 .name   = "renesas,r9a06g032-sysctrl",
>                 .of_match_table = r9a06g032_match,
>         },
> +       .shutdown = r9a06g032_clocks_shutdown,
>  };
>
>  static int __init r9a06g032_clocks_init(void)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
