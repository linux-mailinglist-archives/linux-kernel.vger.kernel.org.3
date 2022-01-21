Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89EF4962C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiAUQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:27:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:16516 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbiAUQ1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642782434; x=1674318434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vDuE8cqCW35QLJGTolUKf/UtD4Dd5SuIQhcEDPlzQS8=;
  b=b/F0mh65V9s9WorhdW2SHuKOWWgjrpO1oMvPDYWW1GvRfmtzfI8iX/6O
   AtKF8GL6WGKPpUogatx0t0fTcUomT1aCk6i6U0Y9aDvOLEKfhlfOGtg33
   UIu4RrfAojfSyTNypph7gSyiCvcIfhCVxJIa6G4L6lgzWOKT1cos0HRJw
   KT0xVa+FlJxpbIY9E9zqCMH/0LOei/SSVUsu/FV38pOC5bE0Oi1HBwZc0
   Us7QPZpCrZ16uesOMt9N7wR57GqxotQ6qnCKNurx9iLh1UpgKfvAAiDrw
   IEJs1TkEYZmNaQ6f6/Mdsb5er3cIwZiL45Xz2cPWUcLvSbij09JLnM7VJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244511866"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="244511866"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 08:27:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="765749887"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 08:27:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nAwjd-00D0Ik-Du;
        Fri, 21 Jan 2022 18:25:57 +0200
Date:   Fri, 21 Jan 2022 18:25:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
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
Subject: Re: [PATCH v5 3/3] mmc: mediatek: add support for SDIO eint IRQ
Message-ID: <YerelftLTFS3HRWx@smile.fi.intel.com>
References: <20220121071942.11601-1-axe.yang@mediatek.com>
 <20220121071942.11601-4-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121071942.11601-4-axe.yang@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:19:42PM +0800, Axe Yang wrote:
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
>                 ...
>                 pinctrl-2 = <&mmc2_pins_eint>;
>                 pinctrl-3 = <&mmc2_pins_dat1>;
>                 ...
>                 cap-sdio-async-irq;
>                 ...
>         };

LGTM, so FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


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
>  	struct pinctrl *pinctrl;
>  	struct pinctrl_state *pins_default;
>  	struct pinctrl_state *pins_uhs;
> +	struct pinctrl_state *pins_eint;
> +	struct pinctrl_state *pins_dat1;
>  	struct delayed_work req_timeout;
>  	int irq;		/* host interrupt */
> +	int eint_irq;		/* device interrupt */
> +	int sdio_irq_cnt;	/* irq enable cnt */
>  	struct reset_control *reset;
>  
>  	struct clk *src_clk;	/* msdc source clock */
> @@ -465,6 +470,7 @@ struct msdc_host {
>  	bool hs400_tuning;	/* hs400 mode online tuning */
>  	bool internal_cd;	/* Use internal card-detect logic */
>  	bool cqhci;		/* support eMMC hw cmdq */
> +	bool sdio_eint_ready;	/* Ready to support SDIO eint interrupt */
>  	struct msdc_save_para save_para; /* used when gate HCLK */
>  	struct msdc_tune_para def_tune_para; /* default tune setting */
>  	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
> @@ -1527,10 +1533,12 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  	__msdc_enable_sdio_irq(host, enb);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	if (enb)
> -		pm_runtime_get_noresume(host->dev);
> -	else
> -		pm_runtime_put_noidle(host->dev);
> +	if (mmc->card && !mmc->card->cccr.enable_async_irq) {
> +		if (enb)
> +			pm_runtime_get_noresume(host->dev);
> +		else
> +			pm_runtime_put_noidle(host->dev);
> +	}
>  }
>  
>  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
> @@ -2461,6 +2469,48 @@ static const struct mmc_host_ops mt_msdc_ops = {
>  	.hw_reset = msdc_hw_reset,
>  };
>  
> +static irqreturn_t msdc_sdio_eint_irq(int irq, void *dev_id)
> +{
> +	struct msdc_host *host = dev_id;
> +	struct mmc_host *mmc = mmc_from_priv(host);
> +
> +	spin_lock(&host->lock);
> +	if (likely(host->sdio_irq_cnt > 0)) {
> +		disable_irq_nosync(host->eint_irq);
> +		disable_irq_wake(host->eint_irq);
> +		host->sdio_irq_cnt--;
> +	}
> +	spin_unlock(&host->lock);
> +
> +	sdio_signal_irq(mmc);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int msdc_request_dat1_eint_irq(struct msdc_host *host)
> +{
> +	struct gpio_desc *desc;
> +	int irq, ret;
> +
> +	desc = devm_gpiod_get(host->dev, "eint", GPIOD_IN);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);
> +
> +	irq = gpiod_to_irq(desc);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(host->dev, irq, NULL, msdc_sdio_eint_irq,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					"sdio-eint", host);
> +	if (ret)
> +		return ret;
> +
> +	host->eint_irq = irq;
> +
> +	return 0;
> +}
> +
>  static const struct cqhci_host_ops msdc_cmdq_ops = {
>  	.enable         = msdc_cqe_enable,
>  	.disable        = msdc_cqe_disable,
> @@ -2631,6 +2681,23 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		goto host_free;
>  	}
>  
> +	if (!(mmc->caps2 & MMC_CAP2_NO_SDIO) && (mmc->caps2 & MMC_CAP2_SDIO_ASYNC_IRQ)) {
> +		/* Support for SDIO eint irq */
> +		host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
> +		if (IS_ERR(host->pins_eint)) {
> +			dev_dbg(&pdev->dev, "Cannot find pinctrl eint!\n");
> +		} else {
> +			host->pins_dat1 = pinctrl_lookup_state(host->pinctrl, "state_dat1");
> +			if (IS_ERR(host->pins_dat1)) {
> +				ret = dev_err_probe(&pdev->dev, PTR_ERR(host->pins_dat1),
> +						    "Cannot find pinctrl dat1!\n");
> +				goto host_free;
> +			}
> +
> +			host->sdio_eint_ready = true;
> +		}
> +	}
> +
>  	msdc_of_property_parse(pdev, host);
>  
>  	host->dev = &pdev->dev;
> @@ -2722,6 +2789,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto release;
>  
> +	if (host->sdio_eint_ready) {
> +		ret = msdc_request_dat1_eint_irq(host);
> +		if (ret) {
> +			dev_err(host->dev, "Failed to register data1 eint irq!\n");
> +			goto release;
> +		}
> +
> +		pinctrl_select_state(host->pinctrl, host->pins_dat1);
> +	}
> +
>  	pm_runtime_set_active(host->dev);
>  	pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
>  	pm_runtime_use_autosuspend(host->dev);
> @@ -2843,8 +2920,22 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>  {
>  	struct mmc_host *mmc = dev_get_drvdata(dev);
>  	struct msdc_host *host = mmc_priv(mmc);
> +	unsigned long flags;
>  
>  	msdc_save_reg(host);
> +
> +	if (host->sdio_eint_ready) {
> +		disable_irq(host->irq);
> +		pinctrl_select_state(host->pinctrl, host->pins_eint);
> +		spin_lock_irqsave(&host->lock, flags);
> +		if (host->sdio_irq_cnt == 0) {
> +			enable_irq(host->eint_irq);
> +			enable_irq_wake(host->eint_irq);
> +			host->sdio_irq_cnt++;
> +		}
> +		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +		spin_unlock_irqrestore(&host->lock, flags);
> +	}
>  	msdc_gate_clock(host);
>  	return 0;
>  }
> @@ -2853,6 +2944,7 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>  {
>  	struct mmc_host *mmc = dev_get_drvdata(dev);
>  	struct msdc_host *host = mmc_priv(mmc);
> +	unsigned long flags;
>  	int ret;
>  
>  	ret = msdc_ungate_clock(host);
> @@ -2860,10 +2952,25 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>  		return ret;
>  
>  	msdc_restore_reg(host);
> +
> +	if (host->sdio_eint_ready) {
> +		spin_lock_irqsave(&host->lock, flags);
> +		if (host->sdio_irq_cnt > 0) {
> +			disable_irq_nosync(host->eint_irq);
> +			disable_irq_wake(host->eint_irq);
> +			host->sdio_irq_cnt--;
> +			sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +		} else {
> +			sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +		}
> +		spin_unlock_irqrestore(&host->lock, flags);
> +		pinctrl_select_state(host->pinctrl, host->pins_uhs);
> +		enable_irq(host->irq);
> +	}
>  	return 0;
>  }
>  
> -static int __maybe_unused msdc_suspend(struct device *dev)
> +static int __maybe_unused msdc_suspend_noirq(struct device *dev)
>  {
>  	struct mmc_host *mmc = dev_get_drvdata(dev);
>  	int ret;
> @@ -2877,13 +2984,13 @@ static int __maybe_unused msdc_suspend(struct device *dev)
>  	return pm_runtime_force_suspend(dev);
>  }
>  
> -static int __maybe_unused msdc_resume(struct device *dev)
> +static int __maybe_unused msdc_resume_noirq(struct device *dev)
>  {
>  	return pm_runtime_force_resume(dev);
>  }
>  
>  static const struct dev_pm_ops msdc_dev_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(msdc_suspend_noirq, msdc_resume_noirq)
>  	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
>  };
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


