Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE43749CA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiAZNSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:18:06 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:38651 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiAZNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:18:05 -0500
Received: by mail-ej1-f50.google.com with SMTP id k25so38732177ejp.5;
        Wed, 26 Jan 2022 05:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5a56Q3xrktFSBfArPwuTW7EIlQ6o8Gi3WpON/C2HkWU=;
        b=H2x1iz1Mz4cFSMr82Wab2jr6QJZcNvxSKr6jFFXEg+r+2HjcyjMERinDyhLmqLUim2
         UN5eQ9zWzg5nCfu6rwUj1cB4K6+/vpQ3cMfkr2WXsAIsj+qJEfslyzu0+uW5pRgGv+RH
         9MzjrT+cE/Nwt/5rIORID1DXdaTlV6yccrhH4SKKx01lwqW6h4h4BiJbprCdM5hppwum
         n/iEUakMGfOsDK8p9SuVm9jWpHAVTLT2rbghrwqr2NZrCUdU/5NLw2eowBu7AcBd6u6N
         2SMqjR6sZ7985J5Av+qx0lnaG1bHE4B+Yz8rGAbOTKcSTb4eADUGuWXOqcCf+IZ02A4i
         5bZQ==
X-Gm-Message-State: AOAM531vnVjvTEHhu2erodDcC3CvgQpziwPIIibEza4tdn8nqzGlXC8R
        kWKDyVI8fk/vigdfcoBPgbA=
X-Google-Smtp-Source: ABdhPJyUdWRKUQgcEPFQ5pgnLjvWK0FJCel3yrZqr4kf1I+V6Cg6MEsyD7T9PmGE474WOkgKFf+VVQ==
X-Received: by 2002:a17:907:6093:: with SMTP id ht19mr7751043ejc.741.1643203084115;
        Wed, 26 Jan 2022 05:18:04 -0800 (PST)
Received: from [192.168.0.60] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id v10sm9810908edx.36.2022.01.26.05.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:18:03 -0800 (PST)
Message-ID: <2c65c342-5c04-bcf4-fd75-5c11d26f0b33@kernel.org>
Date:   Wed, 26 Jan 2022 14:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] pwm: Add clock based PWM output driver
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        sean.anderson@seco.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220126125849.75572-1-nikita@trvn.ru>
 <20220126125849.75572-3-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220126125849.75572-3-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 13:58, Nikita Travkin wrote:
> Some systems have clocks exposed to external devices. If the clock
> controller supports duty-cycle configuration, such clocks can be used as
> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> similar way and an "opposite" driver already exists (clk-pwm). Add a
> driver that would enable pwm devices to be used via clk subsystem.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
> 
> Changes in v2:
>  - Address Uwe's review comments:
>    - Round set clk rate up
>    - Add a description with limitations of the driver
>    - Disable and unprepare clock before removing pwmchip
> Changes in v3:
>  - Use 64bit version of div round up
>  - Address Uwe's review comments:
>    - Reword the limitations to avoid incorrect claims
>    - Move the clk_enabled flag assignment
>    - Drop unnecessary statements
> ---
>  drivers/pwm/Kconfig   |  10 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-clk.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/pwm/pwm-clk.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..daa2491a4054 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
>  	  To compile this driver as a module, choose M Here: the module
>  	  will be called pwm-brcmstb.c.
>  
> +config PWM_CLK
> +	tristate "Clock based PWM support"
> +	depends on HAVE_CLK || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for outputs that can be
> +	  muxed to clocks.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-clk.
> +
>  config PWM_CLPS711X
>  	tristate "CLPS711X PWM support"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..4a860103c470 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
>  obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
> +obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
> new file mode 100644
> index 000000000000..b3bfa12a0e73
> --- /dev/null
> +++ b/drivers/pwm/pwm-clk.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock based PWM controller
> + *
> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
> + *
> + * This is an "adapter" driver that allows PWM consumers to use
> + * system clocks with duty cycle control as PWM outputs.
> + *
> + * Limitations:
> + * - Glitches are possible when new pwm state is applied.
> + * - Due to the fact that exact behavior depends on the underlying
> + *   clock driver, various limitations are possible.
> + * - Period depends on the clock and, in general, not guaranteed.
> + * - Underlying clock may not be able to give 0% or 100% duty cycle
> + *   (constant off or on), exact behavior will depend on the clock.
> + * - When the PWM is disabled, the clock will be disabled as well,
> + *   line state will depend on the clock.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/pwm.h>
> +
> +struct pwm_clk_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	bool clk_enabled;
> +};
> +
> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
> +
> +static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct pwm_clk_chip *chip = to_pwm_clk_chip(pwm_chip);
> +	int ret;
> +	u32 rate;
> +	u64 period = state->period;
> +	u64 duty_cycle = state->duty_cycle;
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled) {
> +			clk_disable(chip->clk);
> +			chip->clk_enabled = false;
> +		}
> +		return 0;
> +	} else if (!pwm->state.enabled) {
> +		ret = clk_enable(chip->clk);
> +		if (ret)
> +			return ret;
> +		chip->clk_enabled = true;
> +	}
> +
> +	rate = DIV64_U64_ROUND_UP(NSEC_PER_SEC, period);
> +	ret = clk_set_rate(chip->clk, rate);
> +	if (ret)
> +		return ret;
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		duty_cycle = period - duty_cycle;
> +
> +	return clk_set_duty_cycle(chip->clk, duty_cycle, period);
> +}
> +
> +static const struct pwm_ops pwm_clk_ops = {
> +	.apply = pwm_clk_apply,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int pwm_clk_probe(struct platform_device *pdev)
> +{
> +	struct pwm_clk_chip *chip;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(chip->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk),
> +				     "Failed to get clock\n");
> +
> +	chip->chip.dev = &pdev->dev;
> +	chip->chip.ops = &pwm_clk_ops;
> +	chip->chip.npwm = 1;
> +
> +	ret = clk_prepare(chip->clk);
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
> +
> +	ret = pwmchip_add(&chip->chip);
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
> +

What is the point of probing the driver if pwmchip_add() fails? This
should be rather fatal error.

The same with clock. If preparing clock fails, there is little point in
enabling/disabling it later.

Best regards,
Krzysztof
