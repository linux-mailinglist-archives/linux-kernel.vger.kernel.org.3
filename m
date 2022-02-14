Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD14B5568
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiBNPz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:55:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiBNPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:55:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59AF49275
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:55:14 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j15so8584440lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNRqOaFV7X2t6LXguaBdf+enzjwGv/oik8U+YHadlGI=;
        b=e5zixySMmRTWDoy83vKhDTVdwMxmR4bPfpFs/rsgLzNkt305Iyqw12G6WObKeTXM+H
         reZD2FGjZJaU4knBBUb38c0WzXT/orXdmGxK1u03KRNw5E2KT3Q3fu4sYrzSZZv6S1w5
         lnGkTYWHtWGps5sUjX+fVQsekeGfM5vlrTgnmwKRjxFz5wFeXaTLd5aOnfEb+f0m/hZa
         cBABjaVqB7Exti9JHrhcSSeloPupX8ev/sebtyz+zbEk/1lMnTh6TKkuBmrpLcb0dCt+
         3dw8k4Jwd4V+vPgpNoX+uKnuxYR27vfZNzf3C+hHV9ARWNXYkZMOX2y6bvG2X4ePameb
         3k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNRqOaFV7X2t6LXguaBdf+enzjwGv/oik8U+YHadlGI=;
        b=RqA/kGHpz2lZ8qtOoSUZJliV8hUG5Q48esMjeinlMoTUFTzFc3NcpbboPR7BYzrNbn
         VhjlbIaDooics+3JLnr6kevdgZ8HXwomxECY1d21rmivE3nbA/aClPgUpLBv/lPA46lH
         81RBEUw7kUD1CMNV4QDjFNteyN3yocraUU0g6XlccYGD0m3zRcdnJxyDZ13NMGOF6sS6
         FUwnXQW9Iksq+9Vc/V5uxccRCF8wHX8eHU02nL4TmPC8T0a0Cx8v/sw4C3QgmIsaor8b
         4hQyLcOOjDtlpvKj/xEaoh/NbKWZ1gyl/kJsk07dEEbjNznmzYZvAhTfAdQZGBK9FrEA
         1cTg==
X-Gm-Message-State: AOAM530eCFLDgo8aoQ2/fmJwvVHmwhzw5513w+al3QFsjZK/eoVRdENT
        Uh4BydAWecNsmw89xNPGI7q5Be/nvNizZF1REcYrSA==
X-Google-Smtp-Source: ABdhPJwl5SfUgEThhcOgbNZT+C3OdwOFkMIhUqrsDs8ZRVfAnHl2esIkiKhlTBxYvWs+np4NRIs6q1qn4xCGjwt9wKs=
X-Received: by 2002:ac2:5a0b:: with SMTP id q11mr215506lfn.358.1644854113170;
 Mon, 14 Feb 2022 07:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20220121071942.11601-1-axe.yang@mediatek.com> <20220121071942.11601-4-axe.yang@mediatek.com>
In-Reply-To: <20220121071942.11601-4-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Feb 2022 16:54:37 +0100
Message-ID: <CAPDyKFqTcAd5kDAzrLDxFTismXDJdKOHLD1hEH369CyRLLo=mw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: mediatek: add support for SDIO eint IRQ
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
        Yong Mao <yong.mao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 at 08:19, Axe Yang <axe.yang@mediatek.com> wrote:
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
> to support SDIO eint IRQ. Pinctrls named state_dat1 and state_eint
> are mandatory. And cap-sdio-async-irq flag is necessary since this
> feature depends on asynchronous interrupt:
>         &mmcX {
>                 ...
>                 pinctrl-names = "default", "state_uhs", "state_eint",
>                                 "state_dat1";

Looks like you need to update the DT docs too to describe these new
things, right?

>                 ...
>                 pinctrl-2 = <&mmc2_pins_eint>;
>                 pinctrl-3 = <&mmc2_pins_dat1>;
>                 ...
>                 cap-sdio-async-irq;
>                 ...
>         };
>
> Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 123 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 65037e1d7723..f8e38228d810 100644
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
> @@ -9,6 +9,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/iopoll.h>
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
> @@ -440,8 +441,12 @@ struct msdc_host {
>         struct pinctrl *pinctrl;
>         struct pinctrl_state *pins_default;
>         struct pinctrl_state *pins_uhs;
> +       struct pinctrl_state *pins_eint;
> +       struct pinctrl_state *pins_dat1;
>         struct delayed_work req_timeout;
>         int irq;                /* host interrupt */
> +       int eint_irq;           /* device interrupt */
> +       int sdio_irq_cnt;       /* irq enable cnt */
>         struct reset_control *reset;
>
>         struct clk *src_clk;    /* msdc source clock */
> @@ -465,6 +470,7 @@ struct msdc_host {
>         bool hs400_tuning;      /* hs400 mode online tuning */
>         bool internal_cd;       /* Use internal card-detect logic */
>         bool cqhci;             /* support eMMC hw cmdq */
> +       bool sdio_eint_ready;   /* Ready to support SDIO eint interrupt */
>         struct msdc_save_para save_para; /* used when gate HCLK */
>         struct msdc_tune_para def_tune_para; /* default tune setting */
>         struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
> @@ -1527,10 +1533,12 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>         __msdc_enable_sdio_irq(host, enb);
>         spin_unlock_irqrestore(&host->lock, flags);
>
> -       if (enb)
> -               pm_runtime_get_noresume(host->dev);
> -       else
> -               pm_runtime_put_noidle(host->dev);
> +       if (mmc->card && !mmc->card->cccr.enable_async_irq) {
> +               if (enb)
> +                       pm_runtime_get_noresume(host->dev);
> +               else
> +                       pm_runtime_put_noidle(host->dev);
> +       }
>  }
>
>  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
> @@ -2461,6 +2469,48 @@ static const struct mmc_host_ops mt_msdc_ops = {
>         .hw_reset = msdc_hw_reset,
>  };
>
> +static irqreturn_t msdc_sdio_eint_irq(int irq, void *dev_id)
> +{
> +       struct msdc_host *host = dev_id;
> +       struct mmc_host *mmc = mmc_from_priv(host);
> +
> +       spin_lock(&host->lock);
> +       if (likely(host->sdio_irq_cnt > 0)) {
> +               disable_irq_nosync(host->eint_irq);
> +               disable_irq_wake(host->eint_irq);
> +               host->sdio_irq_cnt--;
> +       }
> +       spin_unlock(&host->lock);
> +
> +       sdio_signal_irq(mmc);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int msdc_request_dat1_eint_irq(struct msdc_host *host)
> +{
> +       struct gpio_desc *desc;
> +       int irq, ret;
> +
> +       desc = devm_gpiod_get(host->dev, "eint", GPIOD_IN);
> +       if (IS_ERR(desc))
> +               return PTR_ERR(desc);
> +
> +       irq = gpiod_to_irq(desc);
> +       if (irq < 0)
> +               return irq;
> +
> +       ret = devm_request_threaded_irq(host->dev, irq, NULL, msdc_sdio_eint_irq,
> +                                       IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +                                       "sdio-eint", host);

Again, I think you need to update the DT doc to describe these new
IRQ/GPIO things.

> +       if (ret)
> +               return ret;
> +
> +       host->eint_irq = irq;
> +
> +       return 0;
> +}
> +
>  static const struct cqhci_host_ops msdc_cmdq_ops = {
>         .enable         = msdc_cqe_enable,
>         .disable        = msdc_cqe_disable,
> @@ -2631,6 +2681,23 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 goto host_free;
>         }
>
> +       if (!(mmc->caps2 & MMC_CAP2_NO_SDIO) && (mmc->caps2 & MMC_CAP2_SDIO_ASYNC_IRQ)) {
> +               /* Support for SDIO eint irq */
> +               host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
> +               if (IS_ERR(host->pins_eint)) {
> +                       dev_dbg(&pdev->dev, "Cannot find pinctrl eint!\n");
> +               } else {
> +                       host->pins_dat1 = pinctrl_lookup_state(host->pinctrl, "state_dat1");
> +                       if (IS_ERR(host->pins_dat1)) {
> +                               ret = dev_err_probe(&pdev->dev, PTR_ERR(host->pins_dat1),
> +                                                   "Cannot find pinctrl dat1!\n");
> +                               goto host_free;
> +                       }
> +
> +                       host->sdio_eint_ready = true;
> +               }
> +       }
> +
>         msdc_of_property_parse(pdev, host);
>
>         host->dev = &pdev->dev;
> @@ -2722,6 +2789,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 goto release;
>
> +       if (host->sdio_eint_ready) {
> +               ret = msdc_request_dat1_eint_irq(host);
> +               if (ret) {
> +                       dev_err(host->dev, "Failed to register data1 eint irq!\n");
> +                       goto release;
> +               }
> +
> +               pinctrl_select_state(host->pinctrl, host->pins_dat1);
> +       }
> +
>         pm_runtime_set_active(host->dev);
>         pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
>         pm_runtime_use_autosuspend(host->dev);
> @@ -2843,8 +2920,22 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
> +       unsigned long flags;
>
>         msdc_save_reg(host);
> +
> +       if (host->sdio_eint_ready) {
> +               disable_irq(host->irq);
> +               pinctrl_select_state(host->pinctrl, host->pins_eint);
> +               spin_lock_irqsave(&host->lock, flags);
> +               if (host->sdio_irq_cnt == 0) {
> +                       enable_irq(host->eint_irq);
> +                       enable_irq_wake(host->eint_irq);
> +                       host->sdio_irq_cnt++;
> +               }
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +       }
>         msdc_gate_clock(host);
>         return 0;
>  }
> @@ -2853,6 +2944,7 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
> +       unsigned long flags;
>         int ret;
>
>         ret = msdc_ungate_clock(host);
> @@ -2860,10 +2952,25 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>                 return ret;
>
>         msdc_restore_reg(host);
> +
> +       if (host->sdio_eint_ready) {
> +               spin_lock_irqsave(&host->lock, flags);
> +               if (host->sdio_irq_cnt > 0) {
> +                       disable_irq_nosync(host->eint_irq);
> +                       disable_irq_wake(host->eint_irq);
> +                       host->sdio_irq_cnt--;
> +                       sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               } else {
> +                       sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +               }
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               pinctrl_select_state(host->pinctrl, host->pins_uhs);
> +               enable_irq(host->irq);
> +       }
>         return 0;
>  }
>
> -static int __maybe_unused msdc_suspend(struct device *dev)
> +static int __maybe_unused msdc_suspend_noirq(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         int ret;
> @@ -2877,13 +2984,13 @@ static int __maybe_unused msdc_suspend(struct device *dev)
>         return pm_runtime_force_suspend(dev);
>  }
>
> -static int __maybe_unused msdc_resume(struct device *dev)
> +static int __maybe_unused msdc_resume_noirq(struct device *dev)
>  {
>         return pm_runtime_force_resume(dev);
>  }
>
>  static const struct dev_pm_ops msdc_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(msdc_suspend_noirq, msdc_resume_noirq)
>         SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
>  };
>

Overall the approach makes perfect sense to me!

However, I think the code can be simplified and made more robust by
using the wakeirq interface instead. Please have a look at
dev_pm_set_dedicated_wake_irq() and friends. Using them, will let the
runtime PM core deal with disabling/enabling the IRQ, rather than
having to do that manually by the driver, for example.

If you want to get inspired by an existing implementation, please have
a look at the sdhci-omap driver.

Kind regards
Uffe
