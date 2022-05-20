Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D552ED70
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbiETNqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349828AbiETNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:46:41 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558035F25E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:46:37 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id s2xbnumuaJXxRs2xbnj41y; Fri, 20 May 2022 15:46:34 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 20 May 2022 15:46:34 +0200
X-ME-IP: 86.243.180.246
Message-ID: <3844186b-aba7-d5e2-dbd1-813a624cf210@wanadoo.fr>
Date:   Fri, 20 May 2022 15:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
Content-Language: fr
To:     johnson.wang@mediatek.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        cw00.choi@samsung.com, devicetree@vger.kernel.org,
        jia-wei.chang@mediatek.com, khilman@kernel.org, krzk+dt@kernel.org,
        kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org
References: <20220520131956.31150-1-johnson.wang@mediatek.com>
 <20220520131956.31150-3-johnson.wang@mediatek.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220520131956.31150-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Should there be a v6, below a few nitpicks.

just my 2c.

CJ

Le 20/05/2022 à 15:19, Johnson Wang a écrit :
> We introduce a devfreq driver for the MediaTek Cache Coherent Interconnect
> (CCI) used by some MediaTek SoCs.
> 
> In this driver, we use the passive devfreq driver to get target frequencies
> and adjust voltages accordingly. In MT8183 and MT8186, the MediaTek CCI
> is supplied by the same regulators with the little core CPUs.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Johnson Wang <johnson.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> This patch depends on "devfreq-testing"[1].
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
> ---
>   drivers/devfreq/Kconfig           |  10 +
>   drivers/devfreq/Makefile          |   1 +
>   drivers/devfreq/mtk-cci-devfreq.c | 447 ++++++++++++++++++++++++++++++
>   3 files changed, 458 insertions(+)
>   create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 87eb2b837e68..9754d8b31621 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
>   	  It reads ACTMON counters of memory controllers and adjusts the
>   	  operating frequencies and voltages with OPP support.
>   
> +config ARM_MEDIATEK_CCI_DEVFREQ
> +	tristate "MEDIATEK CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ || COMPILE_TEST
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
> index 000000000000..2eaff24fb487
> --- /dev/null
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -0,0 +1,447 @@
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
> +	struct device *dev;
> +	struct devfreq *devfreq;
> +	struct regulator *proc_reg;
> +	struct regulator *sram_reg;
> +	struct clk *cci_clk;
> +	struct clk *inter_clk;
> +	int inter_voltage;
> +	unsigned long pre_freq;
> +	/* Avoid race condition for regulators between notify and policy */
> +	struct mutex reg_lock;
> +	struct notifier_block opp_nb;
> +	const struct mtk_ccifreq_platform_data *soc_data;
> +	int vtrack_max;
> +};
> +
> +static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_drv *drv, int new_voltage)
> +{
> +	const struct mtk_ccifreq_platform_data *soc_data = drv->soc_data;
> +	struct device *dev = drv->dev;
> +	int pre_voltage, pre_vsram, new_vsram, vsram, voltage, ret;
> +	int retry_max = drv->vtrack_max;
> +
> +	if (!drv->sram_reg) {
> +		ret = regulator_set_voltage(drv->proc_reg, new_voltage,
> +					    drv->soc_data->proc_max_volt);
> +		return ret;
> +	}
> +
> +	pre_voltage = regulator_get_voltage(drv->proc_reg);
> +	if (pre_voltage < 0) {
> +		dev_err(dev, "invalid vproc value: %d\n", pre_voltage);
> +		return pre_voltage;
> +	}
> +
> +	pre_vsram = regulator_get_voltage(drv->sram_reg);
> +	if (pre_vsram < 0) {
> +		dev_err(dev, "invalid vsram value: %d\n", pre_vsram);
> +		return pre_vsram;
> +	}
> +
> +	new_vsram = clamp(new_voltage + soc_data->min_volt_shift,
> +			  soc_data->sram_min_volt, soc_data->sram_max_volt);
> +
> +	do {
> +		if (pre_voltage <= new_voltage) {
> +			vsram = clamp(pre_voltage + soc_data->max_volt_shift,
> +				      soc_data->sram_min_volt, new_vsram);
> +			ret = regulator_set_voltage(drv->sram_reg, vsram,
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
> +			ret = regulator_set_voltage(drv->proc_reg, voltage,
> +						    soc_data->proc_max_volt);
> +			if (ret) {
> +				regulator_set_voltage(drv->sram_reg, pre_vsram,
> +						      soc_data->sram_max_volt);
> +				return ret;
> +			}
> +		} else if (pre_voltage > new_voltage) {
> +			voltage = max(new_voltage,
> +				      pre_vsram - soc_data->max_volt_shift);
> +			ret = regulator_set_voltage(drv->proc_reg, voltage,
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
> +			ret = regulator_set_voltage(drv->sram_reg, vsram,
> +						    soc_data->sram_max_volt);
> +			if (ret) {
> +				regulator_set_voltage(drv->proc_reg, pre_voltage,
> +						      soc_data->proc_max_volt);
> +				return ret;
> +			}
> +		}
> +
> +		pre_voltage = voltage;
> +		pre_vsram = vsram;
> +
> +		if (--retry_max < 0) {
> +			dev_err(dev,
> +				"over loop count, failed to set voltage\n");
> +			return -EINVAL;
> +		}
> +	} while (voltage != new_voltage || vsram != new_vsram);
> +
> +	return ret;

'return 0;' would be more explicit. (it looks like 'ret' is always 0 if 
we arrive here)


> +}
> +
> +static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
> +			      u32 flags)
> +{
> +	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
> +	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
> +	struct dev_pm_opp *opp;
> +	unsigned long opp_rate;
> +	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
> +
> +	if (!drv)
> +		return -EINVAL;
> +
> +	if (drv->pre_freq == *freq)
> +		return 0;
> +
> +	inter_voltage = drv->inter_voltage;
> +
> +	opp_rate = *freq;
> +	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "failed to find opp for freq: %ld\n", opp_rate);
> +		return PTR_ERR(opp);
> +	}
> +
> +	mutex_lock(&drv->reg_lock);
> +
> +	voltage = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	pre_voltage = regulator_get_voltage(drv->proc_reg);
> +	if (pre_voltage < 0) {
> +		dev_err(dev, "invalid vproc value: %d\n", pre_voltage);
> +		ret = pre_voltage;
> +		goto out_unlock;
> +	}
> +
> +	/* scale up: set voltage first then freq. */
> +	target_voltage = max(inter_voltage, voltage);
> +	if (pre_voltage <= target_voltage) {
> +		ret = mtk_ccifreq_set_voltage(drv, target_voltage);
> +		if (ret) {
> +			dev_err(dev, "failed to scale up voltage\n");
> +			goto out_restore_voltage;
> +		}
> +	}
> +
> +	/* switch the cci clock to intermediate clock source. */
> +	ret = clk_set_parent(drv->cci_clk, drv->inter_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to re-parent cci clock\n");
> +		goto out_restore_voltage;
> +	}
> +
> +	/* set the original clock to target rate. */
> +	ret = clk_set_rate(cci_pll, *freq);
> +	if (ret) {
> +		dev_err(dev, "failed to set cci pll rate: %d\n", ret);
> +		clk_set_parent(drv->cci_clk, cci_pll);
> +		goto out_restore_voltage;
> +	}
> +
> +	/* switch the cci clock back to the original clock source. */
> +	ret = clk_set_parent(drv->cci_clk, cci_pll);
> +	if (ret) {
> +		dev_err(dev, "failed to re-parent cci clock\n");
> +		mtk_ccifreq_set_voltage(drv, inter_voltage);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * If the new voltage is lower than the intermediate voltage or the
> +	 * original voltage, scale down to the new voltage.
> +	 */
> +	if (voltage < inter_voltage || voltage < pre_voltage) {
> +		ret = mtk_ccifreq_set_voltage(drv, voltage);
> +		if (ret) {
> +			dev_err(dev, "failed to scale down voltage\n");
> +			goto out_unlock;
> +		}
> +	}
> +
> +	drv->pre_freq = *freq;
> +	mutex_unlock(&drv->reg_lock);
> +
> +	return 0;
> +
> +out_restore_voltage:
> +	mtk_ccifreq_set_voltage(drv, pre_voltage);
> +
> +out_unlock:
> +	mutex_unlock(&drv->reg_lock);
> +	return ret;
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
> +		mutex_lock(&drv->reg_lock);
> +		/* current opp item is changed */
> +		if (freq == drv->pre_freq) {
> +			volt = dev_pm_opp_get_voltage(opp);
> +			mtk_ccifreq_set_voltage(drv, volt);
> +		}
> +		mutex_unlock(&drv->reg_lock);
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
> +	struct device *dev = &pdev->dev;
> +	struct mtk_ccifreq_drv *drv;
> +	struct devfreq_passive_data *passive_data;
> +	struct dev_pm_opp *opp;
> +	unsigned long rate, opp_volt;
> +	int ret;
> +
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->dev = dev;
> +	drv->soc_data = (const struct mtk_ccifreq_platform_data *)
> +				of_device_get_match_data(&pdev->dev);
> +	mutex_init(&drv->reg_lock);
> +	platform_set_drvdata(pdev, drv);
> +
> +	drv->cci_clk = devm_clk_get(dev, "cci");
> +	if (IS_ERR(drv->cci_clk)) {
> +		ret = PTR_ERR(drv->cci_clk);
> +		return dev_err_probe(dev, ret,
> +				     "failed to get cci clk: %d\n", ret);
> +	}
> +
> +	drv->inter_clk = devm_clk_get(dev, "intermediate");
> +	if (IS_ERR(drv->inter_clk)) {
> +		ret = PTR_ERR(drv->inter_clk);
> +		dev_err_probe(dev, ret,
> +			      "failed to get intermediate clk: %d\n", ret);
> +		goto out_free_resources;

Could be a direct return, nothing to undo in the error handling path.

> +	}
> +
> +	drv->proc_reg = devm_regulator_get_optional(dev, "proc");
> +	if (IS_ERR(drv->proc_reg)) {
> +		ret = PTR_ERR(drv->proc_reg);
> +		dev_err_probe(dev, ret,
> +			      "failed to get proc regulator: %d\n", ret);
> +		goto out_free_resources;

Could be a direct return, nothing to undo in the error handling path.

> +	}
> +
> +	ret = regulator_enable(drv->proc_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to enable proc regulator\n");
> +		goto out_free_resources;

Could be a direct return, nothing to undo in the error handling path.

> +	}
> +
> +	drv->sram_reg = devm_regulator_get_optional(dev, "sram");
> +	if (IS_ERR(drv->sram_reg))
> +		drv->sram_reg = NULL;
> +	else {
> +		ret = regulator_enable(drv->sram_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to enable sram regulator\n");
> +			goto out_free_resources;
> +		}
> +	}
> +
> +	/*
> +	 * We assume min voltage is 0 and tracking target voltage using
> +	 * min_volt_shift for each iteration.
> +	 * The retry_max is 3 times of expected iteration count.
> +	 */
> +	drv->vtrack_max = 3 * DIV_ROUND_UP(max(drv->soc_data->sram_max_volt,
> +					       drv->soc_data->proc_max_volt),
> +					   drv->soc_data->min_volt_shift);
> +
> +	ret = clk_prepare_enable(drv->cci_clk);
> +	if (ret)
> +		goto out_free_resources;
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to add opp table: %d\n", ret);
> +		goto out_disable_cci_clk;
> +	}
> +
> +	rate = clk_get_rate(drv->inter_clk);
> +	opp = dev_pm_opp_find_freq_ceil(dev, &rate);
> +	if (IS_ERR(opp)) {
> +		ret = PTR_ERR(opp);
> +		dev_err(dev, "failed to get intermediate opp: %d\n", ret);
> +		goto out_remove_opp_table;
> +	}
> +	drv->inter_voltage = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	rate = U32_MAX;
> +	opp = dev_pm_opp_find_freq_floor(drv->dev, &rate);
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "failed to get opp\n");
> +		ret = PTR_ERR(opp);
> +		goto out_remove_opp_table;
> +	}
> +
> +	opp_volt = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +	ret = mtk_ccifreq_set_voltage(drv, opp_volt);
> +	if (ret) {
> +		dev_err(dev, "failed to scale to highest voltage %lu in proc_reg\n",
> +			opp_volt);
> +		goto out_remove_opp_table;
> +	}
> +
> +	passive_data = devm_kzalloc(dev, sizeof(struct devfreq_passive_data),
> +				    GFP_KERNEL);

sizeof(*passive_data) could maybe save 1 LoC.

> +	if (!passive_data) {
> +		ret = -ENOMEM;
> +		goto out_remove_opp_table;
> +	}
> +
> +	passive_data->parent_type = CPUFREQ_PARENT_DEV;
> +	drv->devfreq = devm_devfreq_add_device(dev, &mtk_ccifreq_profile,
> +					       DEVFREQ_GOV_PASSIVE,
> +					       passive_data);
> +	if (IS_ERR(drv->devfreq)) {
> +		ret = -EPROBE_DEFER;
> +		dev_err(dev, "failed to add devfreq device: %ld\n",
> +			PTR_ERR(drv->devfreq));
> +		goto out_remove_opp_table;
> +	}
> +
> +	drv->opp_nb.notifier_call = mtk_ccifreq_opp_notifier;
> +	ret = dev_pm_opp_register_notifier(dev, &drv->opp_nb);
> +	if (ret) {
> +		dev_err(dev, "failed to register opp notifier: %d\n", ret);
> +		goto out_remove_devfreq_device;
> +	}
> +	return 0;
> +
> +out_remove_devfreq_device:
> +	devm_devfreq_remove_device(dev, drv->devfreq);

Why is this needed? Should'nt devm_devfreq_add_device() already do it?
It is also not in the remove function.

CJ

> +
> +out_remove_opp_table:
> +	dev_pm_opp_of_remove_table(dev);
> +
> +out_disable_cci_clk:
> +	clk_disable_unprepare(drv->cci_clk);
> +
> +out_free_resources:
> +	if (regulator_is_enabled(drv->proc_reg))
> +		regulator_disable(drv->proc_reg);
> +	if (drv->sram_reg && regulator_is_enabled(drv->sram_reg))
> +		regulator_disable(drv->sram_reg);
> +
> +	return ret;
> +}
> +
> +static int mtk_ccifreq_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_ccifreq_drv *drv;
> +
> +	drv = platform_get_drvdata(pdev);
> +
> +	dev_pm_opp_unregister_notifier(dev, &drv->opp_nb);
> +	dev_pm_opp_of_remove_table(dev);
> +	clk_disable_unprepare(drv->cci_clk);
> +	regulator_disable(drv->proc_reg);
> +	if (drv->sram_reg)
> +		regulator_disable(drv->sram_reg);
> +
> +	return 0;
> +}
> +
> +static const struct mtk_ccifreq_platform_data mt8183_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 200000,
> +	.proc_max_volt = 1150000,
> +};
> +
> +static const struct mtk_ccifreq_platform_data mt8186_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 250000,
> +	.proc_max_volt = 1118750,
> +	.sram_min_volt = 850000,
> +	.sram_max_volt = 1118750,
> +};
> +
> +static const struct of_device_id mtk_ccifreq_machines[] = {
> +	{ .compatible = "mediatek,mt8183-cci", .data = &mt8183_platform_data },
> +	{ .compatible = "mediatek,mt8186-cci", .data = &mt8186_platform_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_ccifreq_machines);
> +
> +static struct platform_driver mtk_ccifreq_platdrv = {
> +	.probe	= mtk_ccifreq_probe,
> +	.remove	= mtk_ccifreq_remove,
> +	.driver = {
> +		.name = "mtk-ccifreq",
> +		.of_match_table = mtk_ccifreq_machines,
> +	},
> +};
> +module_platform_driver(mtk_ccifreq_platdrv);
> +
> +MODULE_DESCRIPTION("MediaTek CCI devfreq driver");
> +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");

