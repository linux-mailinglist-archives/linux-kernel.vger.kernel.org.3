Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B84D0A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiCGVwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiCGVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:52:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87F75C0C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:51:34 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1B3693F223
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646689892;
        bh=55rGq4RRQntsKF7Gaz2fEg+LyD9jEk8E3iamP44xTAs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=T+VDLqD1D5K5ZyYLXWKVE54VAxrrNaISQ73VPFcECUTPIzpHax1A8wUNoUYjoXYFN
         t3UR+vy1XTYoKg2x9ieTET4JPI9d3TMx1HAsLzmeoN70DBexfWivNdWi7p6Wq3i5Mx
         APlbvi8mot1L//nmM1M/KC4o54BxXwbvWtO+04h28HK7pYslT1h5ZoKdezdChaBy0v
         y2sjdaDXGsoL660/JA4Np20hSRTUgFLv/oGbM1dSEsZOmzI+C5TusxTQzQvnVLYRaq
         5hewhvd6L7bBjT8LiDNutl8adA9VfvXRZKnNGfEGX/YcADKE74n2UUxVQCOzPSpLUm
         sEAYfbB+M/yig==
Received: by mail-ej1-f71.google.com with SMTP id y5-20020a1709060a8500b006da9258a34cso5850336ejf.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 13:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=55rGq4RRQntsKF7Gaz2fEg+LyD9jEk8E3iamP44xTAs=;
        b=ox5VveHwVffl6zXpl4ZbWNcuIzsVxPtttG4CMwhPCcGdsataJunczIaeqPrJgBwEnV
         VYWzZ7frODxlY7SpKgXsnl25M+aTWQrYI1O03psG7TnsbSmvwO8G8ElmGRZzBZUnPLqk
         0bPKFCxeB8OCMpQ2l1I+PNQdldMPCGpMr0pJ95WaZ+sKrKze0F893JaswwmDOX4x515T
         YSHFTtaHhBFiC93d6iYYQg9ZHshHH3PUf7erqPSnW2sg2ztBEA3Qpjt7K8XaWEc01zkL
         XItSGfWLVhfSX8o5/j2IstLX5WRmmusxFJBLRX3aD1OUinmqjXGz2Yo6VWT2hQcPSyXA
         c2eQ==
X-Gm-Message-State: AOAM532MABahUsPi3iRa8/b1+s22KZcJqhlPmVEwZufXskqCoQjWqefu
        aNuX5XTKkK+eBwmdhDmaAH6IisMX1HyUBQfmp4EoNDPTC81/leBsquxOpBGXdaWvlLYjb1bIkAu
        L8MuizVBSjr5cl9fIwDN5r5Jefk5Jfu1BP6ES4g9DsQ==
X-Received: by 2002:a17:907:7d8e:b0:6d7:12a2:a962 with SMTP id oz14-20020a1709077d8e00b006d712a2a962mr10652614ejc.565.1646689891675;
        Mon, 07 Mar 2022 13:51:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfA9D903kgpsYUprTf4p4+DjfJqSTtlQr31oFz49HnWuA5lu5TGN6IjR7OgdZx6Wu6aw7UKA==
X-Received: by 2002:a17:907:7d8e:b0:6d7:12a2:a962 with SMTP id oz14-20020a1709077d8e00b006d712a2a962mr10652602ejc.565.1646689891400;
        Mon, 07 Mar 2022 13:51:31 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm5197701ejc.99.2022.03.07.13.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 13:51:29 -0800 (PST)
Message-ID: <8ee350be-b3a6-ce39-03bf-95d51fb8ff1b@canonical.com>
Date:   Mon, 7 Mar 2022 22:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] devfreq: mediatek: add mt8183 cci devfreq driver
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
 <20220307122513.11822-3-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122513.11822-3-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 13:25, Tim Chang wrote:
> This adds a devfreq driver for the Cache Coherent Interconnect (CCI) of
> the Mediatek MT8183.
> 
> On mt8183 the cci is supplied by the same regulator as the little cores.
> The driver is notified when the regulator voltage changes (driven by
> cpufreq) and adjusts the cci frequency to the maximum possible value.
> 
> Add need_voltage_tracking variable to platforma data. if true, it
> indicates soc is required to realize the voltage tracking between
> voltage of sram and voltage of cci by software approach. otherwise, the
> voltage tracking is realized by hardware appraoch.
> 
> Add the notifier to cci so that it could react after svs driver changes
> opp table of cci.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
> ---
>  drivers/devfreq/Kconfig           |  11 +-
>  drivers/devfreq/Makefile          |   2 +-
>  drivers/devfreq/mtk-cci-devfreq.c | 471 ++++++++++++++++++++++++++++++
>  3 files changed, 482 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 1ec36ae93f31..a6be3c6b5691 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -110,7 +110,7 @@ config ARM_IMX8M_DDRC_DEVFREQ
>  
>  config ARM_MT8183_CCI_DEVFREQ
>  	tristate "MT8183 CCI DEVFREQ Driver"
> -	depends on ARM_MEDIATEK_CPUFREQ
> +	depends on OF && ARM_MEDIATEK_CPUFREQ

Why do you need that dependency? Isn't your arch already OF-only?

>  	help
>  		This adds a devfreq driver for Cache Coherent Interconnect
>  		of Mediatek MT8183, which is shared the same regulator
> @@ -130,6 +130,15 @@ config ARM_TEGRA_DEVFREQ
>  	  It reads ACTMON counters of memory controllers and adjusts the
>  	  operating frequencies and voltages with OPP support.
>  
> +config ARM_MEDIATEK_CCI_DEVFREQ
> +	tristate "MEDIATEK CCI DEVFREQ Driver"
> +	depends on OF && ARM_MEDIATEK_CPUFREQ
> +	help
> +	  This adds a devfreq driver for Mediatek Cache Coherent Interconnect
> +	  which is shared the same regulator with cpu cluster. It can track
> +	  buck voltage and update a proper CCI frequency. Use notification
> +	  to get regulator status.
> +
>  config ARM_RK3399_DMC_DEVFREQ
>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>  	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 991ef7740759..0493516a16f2 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> -obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
> +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o

How is this related? You say in commit subject and description that you
add a devfreq driver. But here you remove some other file...

>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> new file mode 100644
> index 000000000000..986f34689f5c
> --- /dev/null
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -0,0 +1,471 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/regulator/consumer.h>
> +
> +struct mtk_ccifreq_platform_data;

Move struct mtk_ccifreq_platform_data definition here. No need for
forward declaration.

> +
> +struct mtk_ccifreq_drv {
> +	struct device *cci_dev;
> +	struct devfreq *devfreq;
> +	struct regulator *proc_reg;
> +	struct regulator *sram_reg;
> +	struct clk *cci_clk;
> +	struct clk *inter_clk;
> +	int inter_voltage;
> +	int old_voltage;
> +	unsigned long old_freq;
> +	struct mutex lock;  /* avoid notify and policy race condition */
> +	struct notifier_block opp_nb;
> +	const struct mtk_ccifreq_platform_data *soc_data;
> +};
> +
> +struct mtk_ccifreq_platform_data {
> +	int min_volt_shift;
> +	int max_volt_shift;
> +	int proc_max_volt;
> +	int sram_min_volt;
> +	int sram_max_volt;
> +	bool need_voltage_tracking;
> +};
> +
> +static int mtk_ccifreq_voltage_tracking(struct mtk_ccifreq_drv *drv, int new_voltage)
> +{
> +	const struct mtk_ccifreq_platform_data *soc_data = drv->soc_data;
> +	struct regulator *proc_reg = drv->proc_reg;
> +	struct regulator *sram_reg = drv->sram_reg;
> +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> +
> +	old_voltage = regulator_get_voltage(proc_reg);
> +	if (old_voltage < 0) {
> +		pr_err("%s: invalid vproc value: %d\n", __func__, old_voltage);
> +		return old_voltage;
> +	}
> +
> +	old_vsram = regulator_get_voltage(sram_reg);
> +	if (old_vsram < 0) {
> +		pr_err("%s: invalid vsram value: %d\n", __func__, old_vsram);
> +		return old_vsram;
> +	}
> +
> +	new_vsram = clamp(new_voltage + soc_data->min_volt_shift,
> +			  soc_data->sram_min_volt, soc_data->sram_max_volt);
> +
> +	do {
> +		if (old_voltage <= new_voltage) {
> +			vsram = clamp(old_voltage + soc_data->max_volt_shift,
> +				      soc_data->sram_min_volt, new_vsram);
> +			ret = regulator_set_voltage(sram_reg, vsram,
> +						    soc_data->sram_max_volt);
> +			if (ret)
> +				return ret;
> +
> +			if (vsram == soc_data->sram_max_volt ||
> +			    new_vsram == soc_data->sram_min_volt)
> +				voltage = new_voltage;
> +			else
> +				voltage = vsram - soc_data->min_volt_shift;
> +
> +			ret = regulator_set_voltage(proc_reg, voltage,
> +						    soc_data->proc_max_volt);
> +			if (ret) {
> +				regulator_set_voltage(sram_reg, old_vsram,
> +						      soc_data->sram_max_volt);
> +				return ret;
> +			}
> +		} else if (old_voltage > new_voltage) {
> +			voltage = max(new_voltage,
> +				    old_vsram - soc_data->max_volt_shift);
> +			ret = regulator_set_voltage(proc_reg, voltage,
> +						    soc_data->proc_max_volt);
> +			if (ret)
> +				return ret;
> +
> +			if (voltage == new_voltage)
> +				vsram = new_vsram;
> +			else
> +				vsram = max(new_vsram,
> +					    voltage + soc_data->min_volt_shift);
> +
> +			ret = regulator_set_voltage(sram_reg, vsram,
> +						    soc_data->sram_max_volt);
> +			if (ret) {
> +				regulator_set_voltage(proc_reg, old_voltage,
> +						      soc_data->proc_max_volt);
> +				return ret;
> +			}
> +		}
> +
> +		old_voltage = voltage;
> +		old_vsram = vsram;
> +	} while (voltage != new_voltage || vsram != new_vsram);
> +
> +	return 0;
> +}
> +
> +static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_drv *drv, int voltage)
> +{
> +	int ret;
> +
> +	if (drv->soc_data->need_voltage_tracking)
> +		ret = mtk_ccifreq_voltage_tracking(drv, voltage);
> +	else
> +		ret = regulator_set_voltage(drv->proc_reg, voltage,
> +					    drv->soc_data->proc_max_volt);
> +
> +	if (!ret)
> +		drv->old_voltage = voltage;
> +
> +	return ret;
> +}
> +
> +static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
> +			      u32 flags)
> +{
> +	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
> +	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
> +	struct dev_pm_opp *opp;
> +	unsigned long opp_rate;
> +	int voltage, old_voltage, inter_voltage, target_voltage, ret;
> +
> +	if (!drv)
> +		return -EINVAL;
> +
> +	if (drv->old_freq == *freq)
> +		return 0;
> +
> +	inter_voltage = drv->inter_voltage;
> +
> +	opp_rate = *freq;
> +	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
> +	if (IS_ERR(opp)) {
> +		pr_err("cci: failed to find opp for freq: %ld\n", opp_rate);

dev_err() everywhere.

> +		return PTR_ERR(opp);
> +	}
> +	voltage = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	old_voltage = drv->old_voltage;
> +	if (old_voltage == 0)
> +		old_voltage = regulator_get_voltage(drv->proc_reg);
> +	if (old_voltage < 0) {
> +		pr_err("cci: invalid vproc value: %d\n", old_voltage);
> +		return old_voltage;
> +	}
> +
> +	mutex_lock(&drv->lock);
> +
> +	/* scale up: set voltage first then freq. */
> +	target_voltage = max(inter_voltage, voltage);
> +	if (old_voltage <= target_voltage) {
> +		ret = mtk_ccifreq_set_voltage(drv, target_voltage);
> +		if (ret) {
> +			pr_err("cci: failed to scale up voltage\n");
> +			mtk_ccifreq_set_voltage(drv, old_voltage);
> +			mutex_unlock(&drv->lock);
> +			return ret;
> +		}
> +	}
> +
> +	/* switch the cci clock to intermediate clock source. */
> +	ret = clk_set_parent(drv->cci_clk, drv->inter_clk);
> +	if (ret) {
> +		pr_err("cci: failed to re-parent cci clock\n");
> +		mtk_ccifreq_set_voltage(drv, old_voltage);
> +		WARN_ON(1);

Debug code... please clean up your driver.

> +		mutex_unlock(&drv->lock);
> +		return ret;
> +	}
> +
> +	/* set the original clock to target rate. */
> +	ret = clk_set_rate(cci_pll, *freq);
> +	if (ret) {
> +		pr_err("cci: failed to set cci pll rate: %d\n", ret);
> +		clk_set_parent(drv->cci_clk, cci_pll);
> +		mtk_ccifreq_set_voltage(drv, old_voltage);
> +		mutex_unlock(&drv->lock);
> +		return ret;
> +	}
> +
> +	/* switch the cci clock back to the original clock source. */
> +	ret = clk_set_parent(drv->cci_clk, cci_pll);
> +	if (ret) {
> +		pr_err("cci: failed to re-parent cci clock\n");
> +		mtk_ccifreq_set_voltage(drv, inter_voltage);
> +		WARN_ON(1);
> +		mutex_unlock(&drv->lock);

Use goto to error handling pattern.

> +		return ret;
> +	}
> +
> +	/*
> +	 * If the new voltage is lower than the intermediate voltage or the
> +	 * original voltage, scale down to the new voltage.
> +	 */
> +	if (voltage < inter_voltage || voltage < old_voltage) {
> +		ret = mtk_ccifreq_set_voltage(drv, voltage);
> +		if (ret) {
> +			pr_err("cci: failed to scale down voltage\n");
> +			WARN_ON(1);
> +			mutex_unlock(&drv->lock);
> +			return ret;
> +		}
> +	}
> +
> +	drv->old_freq = *freq;
> +	mutex_unlock(&drv->lock);
> +
> +	return 0;
> +}
> +
> +static int mtk_ccifreq_opp_notifier(struct notifier_block *nb,
> +				    unsigned long event, void *data)
> +{
> +	struct dev_pm_opp *opp = data;
> +	struct mtk_ccifreq_drv *drv;
> +	unsigned long freq, volt;
> +
> +	drv = container_of(nb, struct mtk_ccifreq_drv, opp_nb);
> +
> +	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> +		freq = dev_pm_opp_get_freq(opp);
> +
> +		mutex_lock(&drv->lock);
> +		/* current opp item is changed */
> +		if (freq == drv->old_freq) {
> +			volt = dev_pm_opp_get_voltage(opp);
> +			mtk_ccifreq_set_voltage(drv, volt);
> +		}
> +		mutex_unlock(&drv->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile mtk_ccifreq_profile = {
> +	.target = mtk_ccifreq_target,
> +};
> +
> +static int mtk_ccifreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct mtk_ccifreq_drv *drv;
> +	struct devfreq_passive_data *passive_data;
> +	struct dev_pm_opp *opp;
> +	unsigned long rate, opp_volt;
> +	int ret;
> +
> +	drv = devm_kzalloc(cci_dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->cci_dev = cci_dev;
> +	drv->soc_data = (const struct mtk_ccifreq_platform_data *)
> +				of_device_get_match_data(&pdev->dev);
> +	mutex_init(&drv->lock);
> +	platform_set_drvdata(pdev, drv);
> +
> +	drv->cci_clk = devm_clk_get(cci_dev, "cci");
> +	if (IS_ERR(drv->cci_clk)) {
> +		ret = PTR_ERR(drv->cci_clk);
> +		return dev_err_probe(cci_dev, ret,
> +				     "cci: failed to get cci clk: %d\n",
> +				     ret);
> +	}
> +
> +	drv->inter_clk = devm_clk_get(cci_dev, "intermediate");
> +	if (IS_ERR(drv->inter_clk)) {
> +		ret = PTR_ERR(drv->inter_clk);
> +		return dev_err_probe(cci_dev, ret,
> +				     "cci: failed to get intermediate clk: %d\n",
> +				     ret);
> +	}
> +
> +	if (drv->soc_data->need_voltage_tracking) {
> +		drv->sram_reg = regulator_get_optional(cci_dev, "sram");
> +		if (IS_ERR_OR_NULL(drv->sram_reg)) {

NULL pointer cannot be returned.

Best regards,
Krzysztof
