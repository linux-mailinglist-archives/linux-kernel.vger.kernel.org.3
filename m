Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240584F9482
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiDHLyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiDHLxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:53:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C92FF6FE;
        Fri,  8 Apr 2022 04:51:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9D3E51F46F37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649418706;
        bh=KtaScPcryeGL4YO+TROmabwM6wlLQsjfQXBw+PYHmfc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QCegWv3XIxeXvrTldnlY815OlT5zriWKUeupvOczZb1bDGA3cpKvuqkuTS8PBeS74
         3/wC92JYMgDLC46HjGwXvzpyLXcRiawkzcSQj7DFSy0OIqXTJ1OFYoaKodebVU7pKr
         UlVrSLQmKtGqzrqFhSfa3yOjImEuJF9iQt4ZrcxQj6pDU+WVglD9csBHVf5zLUWCTp
         4TC24h8lLZZj9RyaH2UIhtKvVQnY4IUVALFiDE2zZqx7AjGvZGdWAARZAcO5HgTpNi
         R9OcU0fCktBrpG/UD05xAkVKX/6DM9ccgnpOItqm3ftIrXpX0G3UL/3+VsuE5UJXbn
         AHi3nCn/kVkkg==
Message-ID: <7dde78c6-efc6-cc67-19ac-28f8640c2c8c@collabora.com>
Date:   Fri, 8 Apr 2022 13:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
 <20220408052150.22536-3-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220408052150.22536-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 07:21, Johnson Wang ha scritto:
> We introduce a devfreq driver for the MediaTek Cache Coherent Interconnect
> (CCI) used by some MediaTek SoCs.
> 
> In this driver, we use the passive devfreq driver to get target frequencies
> and adjust voltages accordingly. In MT8183 and MT8186, the MediaTek CCI
> is supplied by the same regulators with the little core CPUs.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
> This patch depends on "devfreq-testing"[1].
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
> ---
>   drivers/devfreq/Kconfig           |  10 +
>   drivers/devfreq/Makefile          |   1 +
>   drivers/devfreq/mtk-cci-devfreq.c | 479 ++++++++++++++++++++++++++++++
>   3 files changed, 490 insertions(+)
>   create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 87eb2b837e68..d985597f343f 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
>   	  It reads ACTMON counters of memory controllers and adjusts the
>   	  operating frequencies and voltages with OPP support.
>   
> +config ARM_MEDIATEK_CCI_DEVFREQ
> +	tristate "MEDIATEK CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ
> +	select DEVFREQ_GOV_PASSIVE
> +	help
> +	  This adds a devfreq driver for MediaTek Cache Coherent Interconnect
> +	  which is shared the same regulators with the cpu cluster. It can track
> +	  buck voltages and update a proper CCI frequency. Use the notification
> +	  to get the regulator status.
> +
>   config ARM_RK3399_DMC_DEVFREQ
>   	tristate "ARM RK3399 DMC DEVFREQ Driver"
>   	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 0b6be92a25d9..bf40d04928d0 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>   obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>   obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o
>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>   obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)	+= sun8i-a33-mbus.o
>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> new file mode 100644
> index 000000000000..53a28e2c88bd
> --- /dev/null
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -0,0 +1,479 @@
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
> +struct mtk_ccifreq_platform_data {
> +	int min_volt_shift;
> +	int max_volt_shift;
> +	int proc_max_volt;
> +	int sram_min_volt;
> +	int sram_max_volt;
> +};
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
> +	bool need_voltage_tracking;
> +	/* Avoid race condition for regulators between notify and policy */
> +	struct mutex reg_lock;
> +	struct notifier_block opp_nb;
> +	const struct mtk_ccifreq_platform_data *soc_data;
> +};
> +
> +static int mtk_ccifreq_voltage_tracking(struct mtk_ccifreq_drv *drv,
> +					int new_voltage)
> +{
> +	const struct mtk_ccifreq_platform_data *soc_data = drv->soc_data;
> +	struct device *dev = drv->cci_dev;
> +	struct regulator *proc_reg = drv->proc_reg;
> +	struct regulator *sram_reg = drv->sram_reg;
> +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> +
> +	old_voltage = regulator_get_voltage(proc_reg);
> +	if (old_voltage < 0) {
> +		dev_err(dev, "invalid vproc value: %d\n", old_voltage);
> +		return old_voltage;
> +	}
> +
> +	old_vsram = regulator_get_voltage(sram_reg);
> +	if (old_vsram < 0) {
> +		dev_err(dev, "invalid vsram value: %d\n", old_vsram);
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
> +				      old_vsram - soc_data->max_volt_shift);
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

Hello Johnson,

are you extremely sure that there will *always* be a way out of this while loop?

For safety purposes, I would set an iteration limit in order to avoid getting
an infinite loop here.
Probably, something like twice or thrice the expected number of iterations will
also be fine.

P.S.: Krzysztof's review also contains exactly all the rest of what I would
       also say here (thanks!).

Regards,
Angelo
