Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8296494139
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357189AbiASTtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:49:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:53816 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357177AbiASTtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642621755; x=1674157755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b6hbTfgj+fQHgPfsGt8652Hu8ggXWoxy8VkobZmzJEg=;
  b=dsy5U2dUovrqfl4CM1xvNc0RjXh1sRSM8O4gVQLK4Nh//v6Wm/OxY+Qh
   4AA3n6bpO47bEovtTE781fae2/uKfUtZNhrMeAZ+q+Kd0OvK9b5hgKfr1
   LWTGJ5oRN5bnNKxR53kJxNDK4EflRHYhraRpvZgpUJTTHHTfU0UxwOqKj
   azGQnr39XNTHNcZxQxjJ09XtFCxpR/5FiuvZl7V4G44m9ZrJK+JA9TMvn
   VSJS+4EVnEa5nZpJ3OqX+lootQBdB4EIydPL6HXA2c4LEDu9jeyFOZYjT
   adUFWXhjWNWi8ItQ+fA19SsxrmQ+wqHz+WW7T1vmtqKEBsOdkDgeYZEAV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232540618"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="232540618"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:49:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="622642667"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:49:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nAGw0-00CEvS-JK;
        Wed, 19 Jan 2022 21:47:56 +0200
Date:   Wed, 19 Jan 2022 21:47:56 +0200
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
Subject: Re: [PATCH v4 3/3] mmc: mediatek: add support for SDIO eint IRQ
Message-ID: <Yehq7L36yfJ8D/j2@smile.fi.intel.com>
References: <20220119103212.13158-1-axe.yang@mediatek.com>
 <20220119103212.13158-4-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119103212.13158-4-axe.yang@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:32:12PM +0800, Axe Yang wrote:
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
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

The submitters SoB must be last among all SoB tags. Please, read Submitting
Patches document carefully.

> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Who is they, why their SoB appeared here?

...

>  /*
> - * Copyright (c) 2014-2015 MediaTek Inc.
> + * Copyright (c) 2022 MediaTek Inc.

This doesn't feel right. Why did you remove old years?

>   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
>   */

...

> +	desc = devm_gpiod_get(host->dev, "eint", GPIOD_IN);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);

> +	ret = gpiod_to_irq(desc);
> +	if (ret < 0)
> +		return ret;
> +
> +	irq = ret;

Since both of them are local variables and there is no specific use of the
returned value, I believe it's fine just to

	irq = gpiod_to_irq(desc);
	...

Hmm... I was wondering if you can use fwnode_irq_get_byname().
Ah, it's not (yet) in upstream.

...

>  static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>  {
> +	unsigned long flags;

Can you keep reversed xmas tree order?

>  	struct mmc_host *mmc = dev_get_drvdata(dev);
>  	struct msdc_host *host = mmc_priv(mmc);

(it means to add new variable here)

>  	return 0;
>  }

...

>  static int __maybe_unused msdc_runtime_resume(struct device *dev)
>  {
> +	unsigned long flags;

Ditto.

>  	struct mmc_host *mmc = dev_get_drvdata(dev);
>  	struct msdc_host *host = mmc_priv(mmc);
>  	int ret;

>  	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


