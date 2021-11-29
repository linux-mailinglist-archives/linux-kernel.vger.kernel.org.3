Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED44620A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353296AbhK2Tjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbhK2Thm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:37:42 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241E5C061746;
        Mon, 29 Nov 2021 07:53:23 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id m6so35455305oim.2;
        Mon, 29 Nov 2021 07:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wTOygh+0IsyH0qrmJyNeFfxY+htXI1jpneAU8FF9FOs=;
        b=L693j74MxYBP4Aod5/b+4pYBkglwlM14q5nlN7j3Jr86pFqQ+u3IBQFr619APJyDdH
         jiYAf/af4ptjFF/owb0oyVZDNvLm4tt3YQkdJ+oIc5EOyF7DEtb86gJH9C2FmfauHUB9
         /Y68mVKZw/E6UiVXq64qJM6hDX5IOswrpc+EnVTGy/Q5dSvjgEiWfqwXKrMiEsBA/g9G
         AXCgWz1mu/Dgs9oP2yOTXaC8El2yMvt0iHJsVIYB69HfRRhLBIZNCPc+Ro5JMcrkmCzI
         MxVgbcZRzPmXQCWT6HqVEdPPG30Xmpfg23AL0JdbeDokwispzlPxE5iRp++jThuacSMs
         dixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wTOygh+0IsyH0qrmJyNeFfxY+htXI1jpneAU8FF9FOs=;
        b=3N0cuW7oNOL3EY3v6MgBWNf1rLiteR9afGM3bzAe8ftpi7qqOEIZdMZGe+h3RQ+EeY
         yylO5JfwOjzb0YIVqhz3W9qAHIZfE9ah+bTxjNpJKxQxxwmvaKzwbbZ0Kf47V33kSEpJ
         z6Mqb37AsSZ02GEq6jKIX6DgHHkvjBR2KBM+fCF3SG7B7Ae9KcYv844kY45Uzh9bhbP7
         Ep/o/aqyzqxO2UMHqdF1Y954sbWlyVW2was/F8AmZ2nWWBNRxNxRgBblOUmAdbkkA+jy
         Op9GbIXUP7d5s4nQY8Cets+HzhwNlPtM8bqWnXDuP6OSieAeHzAOCBwnCm8Yj8nEQxxG
         eBJA==
X-Gm-Message-State: AOAM533WvSjrZU0s8j1Ntn6y1FPAmdj0IRF1O2c93tokpjSGs4c98056
        7765Wz1HHMfCcNw3tU0EcYc=
X-Google-Smtp-Source: ABdhPJzgHpqvWtAVCwqamg7dqhN+hD7Mt7mP+SN6WQJ1hT/JAZXfIaftIdqMypINH5ou85GolEXKcA==
X-Received: by 2002:a05:6808:a03:: with SMTP id n3mr40226384oij.125.1638201202344;
        Mon, 29 Nov 2021 07:53:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb8sm3063060oib.9.2021.11.29.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:53:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Nov 2021 07:53:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 7/9] watchdog: max77620: add support for the max77714
 variant
Message-ID: <20211129155320.GA2761477@roeck-us.net>
References: <20211120155707.4019487-1-luca@lucaceresoli.net>
 <20211120155707.4019487-8-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120155707.4019487-8-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 04:57:05PM +0100, Luca Ceresoli wrote:
> The MAX77714 is a MFD chip whose watchdog has the same programming
> procedures as the MAX77620 watchdog, but most register offsets and bit
> masks are different, as well as some features.
> 
> Support the MAX77714 watchdog by adding a variant description table holding
> the differences.
> 
> All the features implemented by this driver are available on the MAX77714
> except for the lack of a WDTOFFC bit. Instead of using a "HAS_*" flag we
> handle this by holding in the cnfg_glbl2_cfg_bits struct field the bits
> (i.e. the features) to enable in the CNFG_GLBL2 register. These bits differ
> among the two models. This implementation allows to avoid any conditional
> code, keeping the execution flow unchanged.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
> 
> This patch is new in v4. It replaces v3 patch 7 ("watchdog: max77714: add
> driver for the watchdog in the MAX77714 PMIC") by adding MAX77714 wdog
> support to the existing MAX77620 wdog driver instead of adding a new
> driver. Suggested by Guenter Roeck and Krzysztof Kozlowski.
> ---
>  drivers/watchdog/Kconfig        |  2 +-
>  drivers/watchdog/max77620_wdt.c | 96 +++++++++++++++++++++++++--------
>  2 files changed, 75 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index a6d97f30325a..f920ad271dde 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -677,7 +677,7 @@ config MAX63XX_WATCHDOG
>  
>  config MAX77620_WATCHDOG
>  	tristate "Maxim Max77620 Watchdog Timer"
> -	depends on MFD_MAX77620 || COMPILE_TEST
> +	depends on MFD_MAX77620 || MFD_MAX77714 || COMPILE_TEST
>  	select WATCHDOG_CORE
>  	help
>  	  This is the driver for the Max77620 watchdog timer.
> diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
> index be6a53c30002..06b48295fab6 100644
> --- a/drivers/watchdog/max77620_wdt.c
> +++ b/drivers/watchdog/max77620_wdt.c
> @@ -3,8 +3,10 @@
>   * Maxim MAX77620 Watchdog Driver
>   *
>   * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
> + * Copyright (C) 2021 Luca Ceresoli
>   *
>   * Author: Laxman Dewangan <ldewangan@nvidia.com>
> + * Author: Luca Ceresoli <luca@lucaceresoli.net>
>   */
>  
>  #include <linux/err.h>
> @@ -13,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/mfd/max77620.h>
> +#include <linux/mfd/max77714.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -20,17 +23,66 @@
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
> +/**
> + * struct max77620_variant - Data specific to a chip variant
> + * @wdt_info:            watchdog descriptor
> + * @reg_onoff_cnfg2:     ONOFF_CNFG2 register offset
> + * @reg_cnfg_glbl2:      CNFG_GLBL2 register offset
> + * @reg_cnfg_glbl3:      CNFG_GLBL3 register offset
> + * @wdtc_mask:           WDTC bit mask in CNFG_GLBL3 (=bits to update to ping the watchdog)
> + * @bit_wd_rst_wk:       WD_RST_WK bit offset within ONOFF_CNFG2
> + * @cnfg_glbl2_cfg_bits: configuration bits to enable in CNFG_GLBL2 register
> + */
> +struct max77620_variant {
> +	const struct watchdog_info wdt_info;
> +	u8 reg_onoff_cnfg2;
> +	u8 reg_cnfg_glbl2;
> +	u8 reg_cnfg_glbl3;
> +	u8 wdtc_mask;
> +	u8 bit_wd_rst_wk;
> +	u8 cnfg_glbl2_cfg_bits;
> +};
> +
>  struct max77620_wdt {
>  	struct device			*dev;
>  	struct regmap			*rmap;
> +	const struct max77620_variant	*drv_data;
>  	struct watchdog_device		wdt_dev;
>  };
>  
> +static const struct max77620_variant max77620_wdt_data = {
> +	.wdt_info = {
> +		.identity = "max77620-watchdog",
> +		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	},

That does not have to be, and should not be, part of device specific data,
just because of the identity string. Either keep the current identity string,
mark max77620_wdt_info as __ro_after_init and overwrite the identity string
there during probe, or add the structure to max77620_wdt and fill it out there.

Guenter

> +	.reg_onoff_cnfg2     = MAX77620_REG_ONOFFCNFG2,
> +	.reg_cnfg_glbl2      = MAX77620_REG_CNFGGLBL2,
> +	.reg_cnfg_glbl3      = MAX77620_REG_CNFGGLBL3,
> +	.wdtc_mask           = MAX77620_WDTC_MASK,
> +	.bit_wd_rst_wk       = MAX77620_ONOFFCNFG2_WD_RST_WK,
> +	/* Set WDT clear in OFF and sleep mode */
> +	.cnfg_glbl2_cfg_bits = MAX77620_WDTSLPC | MAX77620_WDTOFFC,
> +};
> +
> +static const struct max77620_variant max77714_wdt_data = {
> +	.wdt_info = {
> +		.identity = "max77714-watchdog",
> +		.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	},
> +	.reg_onoff_cnfg2     = MAX77714_CNFG2_ONOFF,
> +	.reg_cnfg_glbl2      = MAX77714_CNFG_GLBL2,
> +	.reg_cnfg_glbl3      = MAX77714_CNFG_GLBL3,
> +	.wdtc_mask           = MAX77714_WDTC,
> +	.bit_wd_rst_wk       = MAX77714_WD_RST_WK,
> +	/* Set WDT clear in sleep mode (there is no WDTOFFC on MAX77714) */
> +	.cnfg_glbl2_cfg_bits = MAX77714_WDTSLPC,
> +};
> +
>  static int max77620_wdt_start(struct watchdog_device *wdt_dev)
>  {
>  	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
>  
> -	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +	return regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
>  				  MAX77620_WDTEN, MAX77620_WDTEN);
>  }
>  
> @@ -38,7 +90,7 @@ static int max77620_wdt_stop(struct watchdog_device *wdt_dev)
>  {
>  	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
>  
> -	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +	return regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
>  				  MAX77620_WDTEN, 0);
>  }
>  
> @@ -46,8 +98,8 @@ static int max77620_wdt_ping(struct watchdog_device *wdt_dev)
>  {
>  	struct max77620_wdt *wdt = watchdog_get_drvdata(wdt_dev);
>  
> -	return regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
> -				  MAX77620_WDTC_MASK, 0x1);
> +	return regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl3,
> +				  wdt->drv_data->wdtc_mask, 0x1);
>  }
>  
>  static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
> @@ -80,12 +132,12 @@ static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  		break;
>  	}
>  
> -	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL3,
> -				 MAX77620_WDTC_MASK, 0x1);
> +	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl3,
> +				 wdt->drv_data->wdtc_mask, 0x1);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> +	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
>  				 MAX77620_TWD_MASK, regval);
>  	if (ret < 0)
>  		return ret;
> @@ -95,11 +147,6 @@ static int max77620_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  	return 0;
>  }
>  
> -static const struct watchdog_info max77620_wdt_info = {
> -	.identity = "max77620-watchdog",
> -	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> -};
> -
>  static const struct watchdog_ops max77620_wdt_ops = {
>  	.start		= max77620_wdt_start,
>  	.stop		= max77620_wdt_stop,
> @@ -109,6 +156,7 @@ static const struct watchdog_ops max77620_wdt_ops = {
>  
>  static int max77620_wdt_probe(struct platform_device *pdev)
>  {
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
>  	struct device *dev = &pdev->dev;
>  	struct max77620_wdt *wdt;
>  	struct watchdog_device *wdt_dev;
> @@ -120,6 +168,8 @@ static int max77620_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	wdt->dev = dev;
> +	wdt->drv_data = (const struct max77620_variant *) id->driver_data;
> +
>  	wdt->rmap = dev_get_regmap(dev->parent, NULL);
>  	if (!wdt->rmap) {
>  		dev_err(wdt->dev, "Failed to get parent regmap\n");
> @@ -127,7 +177,7 @@ static int max77620_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	wdt_dev = &wdt->wdt_dev;
> -	wdt_dev->info = &max77620_wdt_info;
> +	wdt_dev->info = &wdt->drv_data->wdt_info;
>  	wdt_dev->ops = &max77620_wdt_ops;
>  	wdt_dev->min_timeout = 2;
>  	wdt_dev->max_timeout = 128;
> @@ -136,25 +186,25 @@ static int max77620_wdt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, wdt);
>  
>  	/* Enable WD_RST_WK - WDT expire results in a restart */
> -	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_ONOFFCNFG2,
> -				 MAX77620_ONOFFCNFG2_WD_RST_WK,
> -				 MAX77620_ONOFFCNFG2_WD_RST_WK);
> +	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_onoff_cnfg2,
> +				 wdt->drv_data->bit_wd_rst_wk,
> +				 wdt->drv_data->bit_wd_rst_wk);
>  	if (ret < 0) {
>  		dev_err(wdt->dev, "Failed to set WD_RST_WK: %d\n", ret);
>  		return ret;
>  	}
>  
> -	/* Set WDT clear in OFF and sleep mode */
> -	ret = regmap_update_bits(wdt->rmap, MAX77620_REG_CNFGGLBL2,
> -				 MAX77620_WDTOFFC | MAX77620_WDTSLPC,
> -				 MAX77620_WDTOFFC | MAX77620_WDTSLPC);
> +	/* Set the "auto WDT clear" bits available on the chip */
> +	ret = regmap_update_bits(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2,
> +				 wdt->drv_data->cnfg_glbl2_cfg_bits,
> +				 wdt->drv_data->cnfg_glbl2_cfg_bits);
>  	if (ret < 0) {
>  		dev_err(wdt->dev, "Failed to set WDT OFF mode: %d\n", ret);
>  		return ret;
>  	}
>  
>  	/* Check if WDT running and if yes then set flags properly */
> -	ret = regmap_read(wdt->rmap, MAX77620_REG_CNFGGLBL2, &regval);
> +	ret = regmap_read(wdt->rmap, wdt->drv_data->reg_cnfg_glbl2, &regval);
>  	if (ret < 0) {
>  		dev_err(wdt->dev, "Failed to read WDT CFG register: %d\n", ret);
>  		return ret;
> @@ -186,7 +236,8 @@ static int max77620_wdt_probe(struct platform_device *pdev)
>  }
>  
>  static const struct platform_device_id max77620_wdt_devtype[] = {
> -	{ .name = "max77620-watchdog", },
> +	{ "max77620-watchdog", (kernel_ulong_t)&max77620_wdt_data },
> +	{ "max77714-watchdog", (kernel_ulong_t)&max77714_wdt_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, max77620_wdt_devtype);
> @@ -208,4 +259,5 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>  	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
>  MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
>  MODULE_LICENSE("GPL v2");
