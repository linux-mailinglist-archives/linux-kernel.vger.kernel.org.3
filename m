Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FA8543248
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbiFHON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbiFHON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:13:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07B39BB2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:13:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m25so19580896lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HU08/x38cJzl3RWDz0YbudrpwkOiqXjB9x6EgAug6c=;
        b=C1GzNijfksY7wJ7e1wxXZBQxdzNRR6jkfmpvzn6tw2ptJbXSS1293NsbuQsMkyR4t8
         tByqc5BcvG6KR9ECuMEXffl1u+wJpIPusfY2FtVCHpv3BnZcbyk9xANhA4hFzA6ly0j/
         tAMA0g4hK7YJ5OnxpSwOP17AC466xGmXg0O/j6NnxeGZfzuLTs5NiZr2FqjzVJk5oEht
         KGk6aojuhToSTnRhmLS3lbndpxslUwSC75pe+fvApFJwHE9RWC/XD4LK98M2r5CM06lF
         zb2XbE8NLIkh+5mlZaM9LMPJKZlPLnGxjbS07ZdH5CdsB5Cj2Ui4lu/hFzBpViAAAZZT
         m5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HU08/x38cJzl3RWDz0YbudrpwkOiqXjB9x6EgAug6c=;
        b=Gq2xPqpvqOl5xJqzsNd4Gd7aYkIK3qssYb2iRWy2mNxyrirSXTnA6/LnJItKkagSHv
         1e9nWR19f51eWENQHnHe/Ait7zjCQvwB+Rht1gjFr+YNFIlXdlBdzTyBwkgAVhTbjuJs
         ygzr42/Gdb3Ze89hyu8DuCk5DGMnLNe1liLa2h9Fas7kvh9dYYTnB583LUft6+DH2H4K
         vLwtA+LnfVEojWhQGmB1Nd6DPwZDIgRUnXZpygPpwIsi5Q6AbvMJUn9pVwxoLx4euUDZ
         GHNdJuG1ibOsvYZmsJYXWQM64lFVrXEWhz9dTrpjEwhLIY65jIwMsIZwS1tyqjABOmls
         2oDA==
X-Gm-Message-State: AOAM532bIh6IxaR1nNS/4exM/PVwe6/vAPDiWatQ2DAQV8IKqPxJ1Pd3
        auI6aeyfXLeVCJunWA83Tz+vNgJWaiitk/M0NIH+fA==
X-Google-Smtp-Source: ABdhPJyKzKcS6yXBOP3fYRGJtECdXIxMI8hvyGqf8/RD+uO+Q1kK7qhntqWEY63aI3J4zjJ80cqwlb3xhU1Hx2RdsyM=
X-Received: by 2002:a2e:818c:0:b0:255:a6c5:4304 with SMTP id
 e12-20020a2e818c000000b00255a6c54304mr5852124ljg.367.1654697632159; Wed, 08
 Jun 2022 07:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220525015140.384-1-axe.yang@mediatek.com> <20220525015140.384-4-axe.yang@mediatek.com>
In-Reply-To: <20220525015140.384-4-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Jun 2022 16:13:15 +0200
Message-ID: <CAPDyKFqq64L3_Mco2aEbu6mC_W98pPpwk4kd1F1um0pHVR5oOw@mail.gmail.com>
Subject: Re: [RESEND v12 3/3] mmc: mediatek: add support for SDIO eint wakup IRQ
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yong Mao <yong.mao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 at 03:51, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Add support for eint IRQ when MSDC is used as an SDIO host. This
> feature requires SDIO device support async IRQ function. With this
> feature, SDIO host can be awakened by SDIO card in suspend state,
> without additional pin.
>
> MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> resume, switch GPIO function back to DAT1 mode then turn on clock.
>
> Some device tree property should be added or modified in MSDC node
> to support SDIO eint IRQ. Pinctrls "state_eint" is mandatory. Since
> this feature depends on asynchronous interrupts, "wakeup-source",
> "keep-power-in-suspend" and "cap-sdio-irq" flags are necessary, and
> the interrupts list should be extended(the interrupt named with
> sdio_wakeup):
>         &mmcX {
>                 ...
>                 interrupt-names = "msdc", "sdio_wakeup";
>                 interrupts-extended = <...>,
>                                       <&pio xxx IRQ_TYPE_LEVEL_LOW>;
>                 ...
>                 pinctrl-names = "default", "state_uhs", "state_eint";
>                 ...
>                 pinctrl-2 = <&mmc2_pins_eint>;
>                 ...
>                 cap-sdio-irq;
>                 keep-power-in-suspend;
>                 wakeup-source;
>                 ...
>         };
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 80 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 74 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..2d5b23616df6 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2014-2015 MediaTek Inc.
> + * Copyright (c) 2014-2015, 2022 MediaTek Inc.
>   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
>   */
>
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -440,8 +441,10 @@ struct msdc_host {
>         struct pinctrl *pinctrl;
>         struct pinctrl_state *pins_default;
>         struct pinctrl_state *pins_uhs;
> +       struct pinctrl_state *pins_eint;
>         struct delayed_work req_timeout;
>         int irq;                /* host interrupt */
> +       int eint_irq;           /* interrupt from sdio device for waking up system */
>         struct reset_control *reset;
>
>         struct clk *src_clk;    /* msdc source clock */
> @@ -1520,17 +1523,41 @@ static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
>
>  static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  {
> -       unsigned long flags;
>         struct msdc_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +       int ret;
>
>         spin_lock_irqsave(&host->lock, flags);
>         __msdc_enable_sdio_irq(host, enb);
>         spin_unlock_irqrestore(&host->lock, flags);
>
> -       if (enb)
> -               pm_runtime_get_noresume(host->dev);
> -       else
> -               pm_runtime_put_noidle(host->dev);
> +       if (mmc_card_enable_async_irq(mmc->card) && host->pins_eint) {
> +               if (enb) {
> +                       pinctrl_select_state(host->pinctrl, host->pins_eint);

This looks a bit odd to me. The pins are not supposed to be configured
for wakeirq at this point, right?

As I understand it, the pin state for wakeirq should be set from the
->runtime_suspend() callback, no?

> +                       ret = dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
> +
> +                       if (ret) {
> +                               dev_err(host->dev, "Failed to register SDIO wakeup irq!\n");
> +                               host->pins_eint = NULL;
> +                               pm_runtime_get_noresume(host->dev);
> +                       } else {
> +                               dev_info(host->dev, "SDIO eint irq: %d!\n", host->eint_irq);

If you want to log a message, please use a dev_dbg for this instead.

> +                               device_init_wakeup(host->dev, true);

To me, it looks like this is better called from ->probe(), once.

> +                       }
> +
> +                       pinctrl_select_state(host->pinctrl, host->pins_uhs);

Assuming that we can drop the earlier call to pinctrl_select_state()
to set "host->pins_eint", this call can be dropped too.

> +               } else {
> +                       dev_pm_clear_wake_irq(host->dev);
> +               }
> +       } else {
> +               if (enb) {
> +                       /* Ensure host->pins_eint is NULL */
> +                       host->pins_eint = NULL;
> +                       pm_runtime_get_noresume(host->dev);
> +               } else {
> +                       pm_runtime_put_noidle(host->dev);
> +               }
> +       }
>  }
>
>  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
> @@ -2631,6 +2658,19 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 goto host_free;
>         }
>
> +       /* Support for SDIO eint irq ? */
> +       if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps & MMC_PM_KEEP_POWER)) {
> +               host->eint_irq = platform_get_irq_byname(pdev, "sdio_wakeup");
> +               if (host->eint_irq > 0) {
> +                       host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
> +                       if (IS_ERR(host->pins_eint)) {
> +                               dev_err_probe(&pdev->dev, PTR_ERR(host->pins_eint),
> +                                             "Cannot find pinctrl eint!\n");

We can probably use dev_err() instead of dev_err_probe() as
pinctrl_lookup_state() should never return -EPROBE_DEFER, I think.

> +                               host->pins_eint = NULL;
> +                       }
> +               }
> +       }
> +
>         msdc_of_property_parse(pdev, host);
>
>         host->dev = &pdev->dev;
> @@ -2845,6 +2885,12 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>         struct msdc_host *host = mmc_priv(mmc);
>
>         msdc_save_reg(host);
> +
> +       if (sdio_irq_claimed(mmc) && host->pins_eint) {
> +               disable_irq(host->irq);
> +               pinctrl_select_state(host->pinctrl, host->pins_eint);
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);

__msdc_enable_sdio_irq() also calls "sdr_clr_bits(host->base +
MSDC_INTEN, MSDC_INTEN_SDIOIRQ);"

Perhaps we should call __msdc_enable_sdio_irq() here instead? To be consistent.

> +       }
>         msdc_gate_clock(host);
>         return 0;
>  }
> @@ -2860,12 +2906,19 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>                 return ret;
>
>         msdc_restore_reg(host);
> +
> +       if (sdio_irq_claimed(mmc) && host->pins_eint) {

msdc_restore_reg() already calls __msdc_enable_sdio_irq(), but based
only upon whether sdio_irq_claimed() returns true.

It looks like we should align the code in
msdc_runtime_resume|suspend(). Perhaps sdio_irq_claimed() should
indicate in both cases that __msdc_enable_sdio_irq() needs to be
called, while "host->pins_eint" means that we have also additional
wakeup configurations (pins and irqs) to handle.

> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               pinctrl_select_state(host->pinctrl, host->pins_uhs);
> +               enable_irq(host->irq);
> +       }
>         return 0;
>  }
>
>  static int __maybe_unused msdc_suspend(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
> +       struct msdc_host *host = mmc_priv(mmc);
>         int ret;
>
>         if (mmc->caps2 & MMC_CAP2_CQE) {
> @@ -2874,11 +2927,26 @@ static int __maybe_unused msdc_suspend(struct device *dev)
>                         return ret;
>         }
>
> +       if (sdio_irq_claimed(mmc) && host->pins_eint) {
> +               pm_runtime_put_sync_suspend(dev);
> +
> +               return 0;
> +       }
> +

I assume the point with the above is to trigger rpm_suspend() to be
called for the device, so that the wakeirq can be enabled, correctly?

However, this isn't the correct way to do it (for various reasons I
can explain, if you want). Instead I think there are two options going
forward:
1. Deal with the wakeirq from the system suspend/resume callbacks,
locally in the driver.
2. Extend pm_runtime_force_suspend|resume() to let it deal with the
wakeirq for us. Similar to what rpm_suspend|resume() do.

I am inclined to try with option 2) first, as this would prevent the
boilerplate code that otherwise gets introduced by option 1). To help
out, I have prepared a patch that I am about to send, I will keep you
posted.

>         return pm_runtime_force_suspend(dev);
>  }
>
>  static int __maybe_unused msdc_resume(struct device *dev)
>  {
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       if (sdio_irq_claimed(mmc) && host->pins_eint) {
> +               pm_runtime_get_sync(dev);

Similar comments apply to this as for msdc_suspend().

> +
> +               return 0;
> +       }
> +
>         return pm_runtime_force_resume(dev);
>  }
>

Kind regards
Uffe
