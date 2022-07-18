Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE6578224
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiGRMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiGRMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:22:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA524F20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:22:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d12so18955543lfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDQWVnebHfg0c4wrC26BhJlTXOIzpXwxLZ6MmaHHQaQ=;
        b=ZfXlyZECFhaTE1MFyFsP82gV8sZfyLMkWniwhgsrLrkyrYdDBuxPhlvU0v9QLBs0Xb
         TALJiaM0I8pTJUChg9+daQ/h6ZWuIoZr/NdiOTCSHi3JWxcDU+bCi6cTsRK5UUaYmCyy
         YlldGSpT9y6zl9eQtnFh4ndEPqjjgnHvyWBLeXBA70DzmL23iBzr3z+2V8PwrFjub0ke
         54CACWyjti0RY8o8FVNw3sUnM9oe+AtwgwuzyS8LMpAnBzkshDyOJA56lQ1SkqE574MX
         BTyiZxLIx+PmbuAlC2BWxYuIlE5Rv7raFLmx95+2hR+pGwR306UNmC/u6PPRHtGGA6Q5
         nNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDQWVnebHfg0c4wrC26BhJlTXOIzpXwxLZ6MmaHHQaQ=;
        b=rxg6NnNXtXJV9IdePGzJs+EwBk0CoLcQg65F1g1j55nlSuvQ5pK/aEr0473A47DJSI
         l/ch8mgBdGwbSguiL8/T+9aj8hjFFqtyAvsFpCnV0BzQr6laulzX2Yr7zSrijuYpS+rC
         FoLn/Is24vHzEw+kVZVboH9oA04gfuB8BpK1L+XDEw24ufIyn8hhX5qpgfahkIKm3zq5
         pY6nb+oUj/W3D/a0Wo3UT/UWuW5oY00IajaYvkBnCL6veh/BhZipjKhOG0haMj8Hsp4J
         B6TZS5mJ8bMyhqSmbbwOGq7aVPr/I/HkMtEFMLSQxvpC9D4foLVCR1Vr5k9/DAfQ7t14
         s/Dw==
X-Gm-Message-State: AJIora/MlfrzyQI4d1BqVsNlMRjGSSGhPKyPr7vZrtXfX0FIBx0azFs7
        JpUIJFn1N+kabWI0bWU02fdYMVEqj2MZcmEGkola/Q==
X-Google-Smtp-Source: AGRyM1uN/QdzliJ/x2BXEyudDZRn4ZiuQav9WWV3CkFBV87cU3ElLClfj9ORvYC9gRYUyhBkBRXrZMs4Ll/xu45k/8Q=
X-Received: by 2002:a05:6512:aca:b0:48a:1a70:d0d8 with SMTP id
 n10-20020a0565120aca00b0048a1a70d0d8mr11268659lfu.167.1658146933633; Mon, 18
 Jul 2022 05:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220623090445.1401-1-axe.yang@mediatek.com> <20220623090445.1401-4-axe.yang@mediatek.com>
In-Reply-To: <20220623090445.1401-4-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 14:21:37 +0200
Message-ID: <CAPDyKFr0gy1sNb=U3j1ErSZm+jcAcvg_jwNmodEs7ip4_LjNZg@mail.gmail.com>
Subject: Re: [PATCH v13 3/3] mmc: mediatek: add support for SDIO eint wakup IRQ
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 at 11:05, Axe Yang <axe.yang@mediatek.com> wrote:
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
>
> Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

My apologies for the delay in reviewing this.

> ---
>  drivers/mmc/host/mtk-sd.c | 84 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..f907b96cfd87 100644
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
> @@ -1520,17 +1523,46 @@ static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
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
> +                       /*
> +                        * In dev_pm_set_dedicated_wake_irq_reverse(), eint pin will be set to
> +                        * GPIO mode. We need to restore it to SDIO DAT1 mode after that.
> +                        * Since the current pinstate is pins_uhs, to ensure pinctrl select take
> +                        * affect successfully, we change the pinstate to pins_eint firstly.
> +                        */
> +                       pinctrl_select_state(host->pinctrl, host->pins_eint);

I am sorry, but I don't understand what goes on here. Why do you need
to change the pinctrl setting to "pins_eint" here?

The bellow call to dev_pm_set_dedicated_wake_irq_reverse() doesn't
change the pinctrl setting as the comment suggests above.

dev_pm_set_dedicated_wake_irq_reverse() will register the wakeirq, but
more importantly, it should also leave the wakeirq disabled, right?

> +                       ret = dev_pm_set_dedicated_wake_irq_reverse(host->dev, host->eint_irq);
> +
> +                       if (ret) {
> +                               dev_err(host->dev, "Failed to register SDIO wakeup irq!\n");
> +                               host->pins_eint = NULL;
> +                               pm_runtime_get_noresume(host->dev);
> +                       } else {
> +                               dev_dbg(host->dev, "SDIO eint irq: %d!\n", host->eint_irq);
> +                       }
> +
> +                       pinctrl_select_state(host->pinctrl, host->pins_uhs);

According to my comment above, I also don't understand why you need
this. Why can't you just leave the pinctrl in the "pins_uhs" state?

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
> @@ -2631,6 +2663,20 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 goto host_free;
>         }
>
> +       /* Support for SDIO eint irq ? */
> +       if ((mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ) && (mmc->pm_caps & MMC_PM_KEEP_POWER)) {
> +               host->eint_irq = platform_get_irq_byname(pdev, "sdio_wakeup");
> +               if (host->eint_irq > 0) {
> +                       host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
> +                       if (IS_ERR(host->pins_eint)) {
> +                               dev_err(&pdev->dev, "Cannot find pinctrl eint!\n");
> +                               host->pins_eint = NULL;
> +                       } else {
> +                               device_init_wakeup(&pdev->dev, true);
> +                       }
> +               }
> +       }
> +
>         msdc_of_property_parse(pdev, host);
>
>         host->dev = &pdev->dev;
> @@ -2845,6 +2891,13 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>         struct msdc_host *host = mmc_priv(mmc);
>
>         msdc_save_reg(host);
> +
> +       if (host->pins_eint) {
> +               disable_irq(host->irq);
> +               pinctrl_select_state(host->pinctrl, host->pins_eint);
> +               if (sdio_irq_claimed(mmc))
> +                       __msdc_enable_sdio_irq(host, 0);
> +       }

This above code isn't entirely correct. Just because you have
"pins_eint", doesn't mean that you have a wakeirq being registered, as
that also depends on whether there is an SDIO irq claimed.

So, I think this should rather be:

if (sdio_irq_claimed(mmc)) {
    if (host->pins_eint) {
        disable_irq(host->irq);
        pinctrl_select_state(host->pinctrl, host->pins_eint);
    }

    __msdc_enable_sdio_irq(host, 0);
}

>         msdc_gate_clock(host);
>         return 0;
>  }
> @@ -2860,12 +2913,18 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>                 return ret;
>
>         msdc_restore_reg(host);
> +
> +       if (host->pins_eint) {

Similar comment as above. You need to check sdio_irq_claimed() here too.

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
> @@ -2874,11 +2933,24 @@ static int __maybe_unused msdc_suspend(struct device *dev)
>                         return ret;
>         }
>
> +       /*
> +        * Bump up runtime PM usage counter otherwise dev->power.needs_force_resume will
> +        * not be marked as 1, pm_runtime_force_resume() will go out directly.
> +        */
> +       if (host->pins_eint)

This works, but can be improved by checking sdio_irq_claimed() too.

> +               pm_runtime_get_noresume(dev);
> +
>         return pm_runtime_force_suspend(dev);
>  }
>
>  static int __maybe_unused msdc_resume(struct device *dev)
>  {
> +       struct mmc_host *mmc = dev_get_drvdata(dev);
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       if (host->pins_eint)
> +               pm_runtime_put_noidle(dev);

Ditto.

> +
>         return pm_runtime_force_resume(dev);
>  }
>

Kind regards
Uffe
