Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773E24F17D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378386AbiDDPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378351AbiDDPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:03:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BAD2F389
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:01:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h11so13290915ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZiA0zBfLxxxvQSlb38DMe1kSSD1nLqyi7xLhEo99Kis=;
        b=JyBeMJgPaaQShB9HNudhRidGx/R/LDk0gJn5JFOf1F7tlOBtDt47I6r+R5Uer37g//
         DypV1fJnpnpRl5GpsklEMgrWaWySqiZQIQXGl2XcY2PbYjELx4VIiBWDtO/xxiqJtV24
         Ki4VFBodRC2q25KBMqMhO5AVcNB4aSvbUj7aUWMJbhPN4Hi8Vs40gKoAh+yEXIKuQLhg
         edPUkWwVEJbc6i4eAaYHXrij0chNvJacx061ta4UPzck0lIgFcLBQphCGFCmjh69fuhy
         ZC1qMW/9hvyTfTrs3jxcEDv5eP4FGIg6iWcjuevEhudHU+p8y0FZpxKXTqe0gBmvlf1y
         FPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiA0zBfLxxxvQSlb38DMe1kSSD1nLqyi7xLhEo99Kis=;
        b=UAIp8VNVPRq7LeeCLeLeASo302yYHngF9rxidjChDibZpL1XPFAyuJfbD6PBZvqQY2
         35gag1D6TI93AwRGse5DtpEo/OXHxh8GKOXTmQXnVILpctNb4QrQn1EwcmjYujkeTTom
         ZATvDABwn6jMy1I7E72cg/lGl5R8gSBFWdtT+tTwfqtJ2xI3CWdisNEy1t+J3tgVp29A
         zXF5QHb/yMqCc5sY17NFwTa34zuPVhtsBh2pSEVz5MlC1JU0jCv3vZuM+uG9FWsy71Yf
         uaAUZhs0KTc130A/tSScZMUikef0YM1EXV8vlCg9qP2n8LQ/KBTz4oDXNJGgF5+AkxgA
         8HNg==
X-Gm-Message-State: AOAM533Nezr6EhrZwNyKJelDQ1S2qaphagFQsFJGZ1MXeLVzoYmuqnsZ
        g+3rYlrqGGNvny8JdFS+JRNisd8oiuZcXvLdjWl8XQ==
X-Google-Smtp-Source: ABdhPJxBECeS5QZMqXbgWQzpO9xjn6HpuFdr/k/NlU1PezAnoCnjXriu5l62+TOMWVx4aR8EI2jsysvOdXs1aWwXomQ=
X-Received: by 2002:a2e:3615:0:b0:24a:fc28:f0b3 with SMTP id
 d21-20020a2e3615000000b0024afc28f0b3mr15623lja.4.1649084509320; Mon, 04 Apr
 2022 08:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220329032913.8750-1-axe.yang@mediatek.com> <20220329032913.8750-4-axe.yang@mediatek.com>
In-Reply-To: <20220329032913.8750-4-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Apr 2022 17:01:12 +0200
Message-ID: <CAPDyKFrSWm4HKGLQhm164kYRB4psdzo+9btu67Demz7Xr1MS_w@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mmc: mediatek: add support for SDIO eint wakup IRQ
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 at 05:29, Axe Yang <axe.yang@mediatek.com> wrote:
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
> the interrupts list should be extended:
>         &mmcX {
>                 ...
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
>
> Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 94 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 86 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 65037e1d7723..2905d7134243 100644
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
> @@ -440,8 +441,11 @@ struct msdc_host {
>         struct pinctrl *pinctrl;
>         struct pinctrl_state *pins_default;
>         struct pinctrl_state *pins_uhs;
> +       struct pinctrl_state *pins_eint;
>         struct delayed_work req_timeout;
>         int irq;                /* host interrupt */
> +       int eint_irq;           /* interrupt from sdio device for waking up system */
> +       int sdio_wake_irq_depth;
>         struct reset_control *reset;
>
>         struct clk *src_clk;    /* msdc source clock */
> @@ -465,6 +469,7 @@ struct msdc_host {
>         bool hs400_tuning;      /* hs400 mode online tuning */
>         bool internal_cd;       /* Use internal card-detect logic */
>         bool cqhci;             /* support eMMC hw cmdq */
> +       bool sdio_eint_ready;   /* Ready to support SDIO eint interrupt */
>         struct msdc_save_para save_para; /* used when gate HCLK */
>         struct msdc_tune_para def_tune_para; /* default tune setting */
>         struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
> @@ -1527,10 +1532,12 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>         __msdc_enable_sdio_irq(host, enb);
>         spin_unlock_irqrestore(&host->lock, flags);
>
> -       if (enb)
> -               pm_runtime_get_noresume(host->dev);
> -       else
> -               pm_runtime_put_noidle(host->dev);
> +       if (mmc->card && !mmc_card_enable_async_irq(mmc->card)) {

It might not be obvious, but in fact mmc->card always exists in this
case, hence there is no need to check the pointer before using it.

> +               if (enb)
> +                       pm_runtime_get_noresume(host->dev);
> +               else
> +                       pm_runtime_put_noidle(host->dev);
> +       }
>  }
>
>  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
> @@ -2631,6 +2638,18 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 goto host_free;
>         }
>
> +       /* Support for SDIO eint irq ? */
> +       if (mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
> +               host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
> +               if (IS_ERR(host->pins_eint)) {
> +                       ret = dev_err_probe(&pdev->dev, PTR_ERR(host->pins_eint),
> +                                           "Cannot find pinctrl eint!\n");
> +                       goto host_free;
> +               }
> +
> +               host->sdio_eint_ready = true;

Rather than using a separate variable, couldn't we just check "if
(host->pins_eint)" to know whether wakeup settings shall be managed?

> +       }
> +
>         msdc_of_property_parse(pdev, host);
>
>         host->dev = &pdev->dev;
> @@ -2722,6 +2741,21 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 goto release;
>
> +       if (host->sdio_eint_ready) {
> +               host->eint_irq = irq_of_parse_and_map(host->dev->of_node, 1);
> +               ret = host->eint_irq ? dev_pm_set_dedicated_wake_irq(host->dev, host->eint_irq) :
> +                     -ENODEV;

I think it would make better sense to call
dev_pm_set_dedicated_wake_irq() from msdc_enable_sdio_irq(). In this
way, you can still support SDIO irqs, even if there are no GPIO irq
for available for re-routing.

In other words, if the GPIO irq is available, then that's the best
option and we should use that - otherwise we need to keep preventing
runtime-suspend by bumping the runtime PM usage count.

> +
> +               if (ret) {
> +                       dev_err(host->dev, "Failed to register data1 eint irq!\n");
> +                       goto release;
> +               }
> +
> +               dev_pm_disable_wake_irq(host->dev);
> +               pinctrl_select_state(host->pinctrl, host->pins_uhs);
> +       }
> +
> +       device_init_wakeup(host->dev, true);

I think this better belongs under the condition of whether
MMC_PM_WAKE_SDIO_IRQ and MMC_PM_KEEP_POWER caps are set.

>         pm_runtime_set_active(host->dev);
>         pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
>         pm_runtime_use_autosuspend(host->dev);
> @@ -2734,6 +2768,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         return 0;
>  end:
>         pm_runtime_disable(host->dev);
> +       dev_pm_clear_wake_irq(host->dev);
>  release:
>         platform_set_drvdata(pdev, NULL);
>         msdc_deinit_hw(host);
> @@ -2845,6 +2880,16 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>         struct msdc_host *host = mmc_priv(mmc);
>
>         msdc_save_reg(host);
> +
> +       if (host->sdio_eint_ready) {

The core provides a helper function, sdio_irq_claimed(), that can be
used to know whether there is an SDIO irq registered. It looks like
that certainly can be useful here.

> +               disable_irq(host->irq);
> +               pinctrl_select_state(host->pinctrl, host->pins_eint);
> +               if (host->sdio_wake_irq_depth == 0) {
> +                       dev_pm_enable_wake_irq(dev);

This should be managed from the runtime PM core. See rpm_suspend().

Or perhaps there is a reason that doesn't work for you?

> +                       host->sdio_wake_irq_depth++;

Again, sdio_irq_claimed() is probably better to use.

> +               }
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       }
>         msdc_gate_clock(host);
>         return 0;
>  }
> @@ -2860,12 +2905,25 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>                 return ret;
>
>         msdc_restore_reg(host);
> +
> +       if (host->sdio_eint_ready) {
> +               if (host->sdio_wake_irq_depth > 0) {
> +                       dev_pm_disable_wake_irq(dev);
> +                       host->sdio_wake_irq_depth--;
> +                       sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               } else {
> +                       sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +               }
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
> +       struct msdc_host *host = mmc_priv(mmc);
>         int ret;
>
>         if (mmc->caps2 & MMC_CAP2_CQE) {
> @@ -2874,16 +2932,36 @@ static int __maybe_unused msdc_suspend(struct device *dev)
>                         return ret;
>         }
>
> +       if (host->sdio_eint_ready)
> +               enable_irq_wake(host->eint_irq);

The PM core should manage this for us through dpm_suspend_noirq(), I
think. We just need to make sure that the runtime PM status of the
device has been set to RPM_SUSPENDED before dpm_suspend_noirq()  gets
called. Have a look at dpm_suspend_noirq() ->
device_wakeup_arm_wake_irqs() -> dev_pm_arm_wake_irq().

In other words (and unless I am missing something), if we continue to
call pm_runtime_force_suspend() from a ->suspend() callback this
should work just fine.

> +
>         return pm_runtime_force_suspend(dev);
>  }
>
> -static int __maybe_unused msdc_resume(struct device *dev)
> +static int __maybe_unused msdc_resume_noirq(struct device *dev)
>  {
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       if (host->sdio_eint_ready) {
> +               disable_irq_wake(host->eint_irq);
> +
> +               /*
> +                * In noirq resume stage, msdc_runtime_resume()
> +                * won't be called, so disalbe wake irq here
> +                * to block dedicated wake irq handler callback.
> +                */
> +               if (likely(host->sdio_wake_irq_depth > 0)) {
> +                       dev_pm_disable_wake_irq(dev);
> +                       host->sdio_wake_irq_depth--;
> +               }

Similar comment as from the system suspend case. I don't think we need
to move to the noirq phase.

Or maybe I am missing something here?

> +       }
> +
>         return pm_runtime_force_resume(dev);
>  }
>
>  static const struct dev_pm_ops msdc_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(msdc_suspend_noirq, msdc_resume_noirq)
>         SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
>  };
>
> --
> 2.25.1
>

Kind regards
Uffe
