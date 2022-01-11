Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05C48ACF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiAKLsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:48:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:30856 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238808AbiAKLsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641901697; x=1673437697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuYmIBkvpvdVhi31jq6e1BbQrmM5iNvrfA4jT6YwXCQ=;
  b=jrzfnn7slkGjU3IZc+yl1eDpJb1vSzK/E/rWfTg64SHgo5NlQAw1lhTC
   cCNZETBetfrhEsEJeNW8QJHECi72N1XB1NsJDntH1iYbQb1wOdnDTjtNr
   /JktnfVQpYtRw16bbVxwWynlOzx4oh1l0wQOkHPcDj/0aIffPARbjc0tA
   iTNiUTarEj1vf6QyoL7TTlKe02O0/rXLwBCvUZOF7FgrIDb196F9bn7f1
   Dl3iwRvIr5Mqt8KWai7dWzhlOnCXFXS2Zh7NPQ72QE7K8NnNrMHUKeOxJ
   3WFcMa5W1gUtspUT/VjjvKYt+dui5XLUIwtDXvubzqAnfDN+mQ8YKTJYl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="304205011"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="304205011"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:48:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="490353874"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 03:48:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7Fc0-009D0g-4e;
        Tue, 11 Jan 2022 13:46:48 +0200
Date:   Tue, 11 Jan 2022 13:46:47 +0200
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] mmc: mediatek: add support for SDIO eint irq
Message-ID: <Yd1uJ+dX2CTEJfYY@smile.fi.intel.com>
References: <20220111014046.5864-1-axe.yang@mediatek.com>
 <20220111014046.5864-4-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111014046.5864-4-axe.yang@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 09:40:46AM +0800, Axe Yang wrote:
> Add support for eint irq when MSDC is used as an SDIO host. This

IRQ

> feature requires SDIO device support async irq function. With this

IRQ

> feature,SDIO host can be awakened by SDIO card in suspend state,

feature, SDIO

> without additional pin.
> 
> MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> resume, switch GPIO function back to DAT1 mode then turn on clock.
> 
> Some device tree property should be added or modified in msdc node

MSDC

> to support SDIO eint irq. Pinctrls named state_dat1 and state_eint

IRQ

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

...

> - * Copyright (c) 2014-2015 MediaTek Inc.
> + * Copyright (c) 2014-2022 MediaTek Inc.

Shouldn't it be rather like

 * Copyright (c) 2014-2015,2022 MediaTek Inc.

?

...

> +static irqreturn_t msdc_sdio_eint_irq(int irq, void *dev_id)
> +{
> +	unsigned long flags;
> +	struct msdc_host *host = (struct msdc_host *)dev_id;

No casting is needed.

> +	struct mmc_host *mmc = mmc_from_priv(host);

Perhaps reversed xmas tree order

	struct msdc_host *host = dev_id;
	struct mmc_host *mmc = mmc_from_priv(host);
	unsigned long flags;

?

But hey, why do you need flags?

> +	spin_lock_irqsave(&host->lock, flags);
> +	if (likely(host->sdio_irq_cnt > 0)) {
> +		disable_irq_nosync(host->eint_irq);
> +		disable_irq_wake(host->eint_irq);
> +		host->sdio_irq_cnt--;
> +	}
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	sdio_signal_irq(mmc);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int msdc_request_dat1_eint_irq(struct msdc_host *host)
> +{
> +	struct gpio_desc *desc;
> +	int irq, ret;
> +
> +	desc = devm_gpiod_get(host->dev, "eint", GPIOD_IN);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);
> +
> +	ret = gpiod_to_irq(desc);
> +	if (ret < 0)
> +		return ret;
> +
> +	irq = ret;
> +	ret = devm_request_threaded_irq(host->dev, irq, NULL, msdc_sdio_eint_irq,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					"sdio-eint", host);

> +

Redundant blank line.

> +	if (!ret)
> +		host->eint_irq = irq;
> +
> +	return ret;

I guess I have already commented on this, i.e. use standard pattern

	if (ret)
		return ret;

	...
	return 0;

> +}

...

> +		host->pins_eint = pinctrl_lookup_state(host->pinctrl, "state_eint");
> +		if (IS_ERR(host->pins_eint)) {

> +			dev_dbg(&pdev->dev, "Cannot find pinctrl eint!\n");

In debug mode of pin control this will bring a duplicate message.

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


-- 
With Best Regards,
Andy Shevchenko


