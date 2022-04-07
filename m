Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD8B4F7E51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiDGLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiDGLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:47:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761E19BFCF;
        Thu,  7 Apr 2022 04:45:33 -0700 (PDT)
X-UUID: f925ff513b514b858a4d2b519ed5e261-20220407
X-UUID: f925ff513b514b858a4d2b519ed5e261-20220407
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1992575714; Thu, 07 Apr 2022 19:45:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 7 Apr 2022 19:45:26 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 19:45:26 +0800
Message-ID: <00ec02e752e06c0f8f7c217058bf811f7ce0f4b4.camel@mediatek.com>
Subject: Re: [PATCH 2/3] devfreq: mediatek: add mt8183 cci devfreq driver
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Thu, 7 Apr 2022 19:45:26 +0800
In-Reply-To: <7fbc8167-1a0a-889c-e747-94703f3c8f1c@samsung.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
         <CGME20220307122645epcas1p1c2d964e26084b9c1ec928e1a199f315d@epcas1p1.samsung.com>
         <20220307122513.11822-3-jia-wei.chang@mediatek.com>
         <7fbc8167-1a0a-889c-e747-94703f3c8f1c@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-07 at 12:20 +0900, Chanwoo Choi wrote:
> Hi,
> 
> It seems that this patch depends on patches[1] of devfreq-testing
> branch.
> [1] 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing__;!!CTRNKA9wMg0ARbw!zpzMoFhloy2fpTawf8kkY5nwKerht5CKCnKTwwmSHYBN2vN5WfVMOcGn5TDb8SPTQTSaHA$
>  
> 
> I'll send the updated patches[1]. And I add the my comment below.
> 

Yes, I will add your patches as my dependency.

> 
> On 3/7/22 9:25 PM, Tim Chang wrote:
> > This adds a devfreq driver for the Cache Coherent Interconnect
> > (CCI) of
> > the Mediatek MT8183.
> > 
> > On mt8183 the cci is supplied by the same regulator as the little
> > cores.
> > The driver is notified when the regulator voltage changes (driven
> > by
> > cpufreq) and adjusts the cci frequency to the maximum possible
> > value.
> > 
> > Add need_voltage_tracking variable to platforma data. if true, it
> > indicates soc is required to realize the voltage tracking between
> > voltage of sram and voltage of cci by software approach. otherwise,
> > the
> > voltage tracking is realized by hardware appraoch.
> > 
> > Add the notifier to cci so that it could react after svs driver
> > changes
> > opp table of cci.
> > 
> > Signed-off-by: Jia-Wei Chang <
> > jia-wei.chang@mediatek.corp-partner.google.com>
> > ---
> >  drivers/devfreq/Kconfig           |  11 +-
> >  drivers/devfreq/Makefile          |   2 +-
> >  drivers/devfreq/mtk-cci-devfreq.c | 471
> > ++++++++++++++++++++++++++++++
> >  3 files changed, 482 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> > 
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 1ec36ae93f31..a6be3c6b5691 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -110,7 +110,7 @@ config ARM_IMX8M_DDRC_DEVFREQ
> >  
> >  config ARM_MT8183_CCI_DEVFREQ
> >  	tristate "MT8183 CCI DEVFREQ Driver"
> > -	depends on ARM_MEDIATEK_CPUFREQ
> > +	depends on OF && ARM_MEDIATEK_CPUFREQ
> >  	help
> 
> ARM_MT8183_CCI_DEVFREQ is not existed on mainline kernel.
> You need to rework this patch on the latest kernel (either devfreq-
> next
> or linux-next.git).

Sure, I will rebase my patch onto linux-next.

> 
> >  		This adds a devfreq driver for Cache Coherent
> > Interconnect
> >  		of Mediatek MT8183, which is shared the same regulator
> > @@ -130,6 +130,15 @@ config ARM_TEGRA_DEVFREQ
> >  	  It reads ACTMON counters of memory controllers and adjusts
> > the
> >  	  operating frequencies and voltages with OPP support.
> >  
> > +config ARM_MEDIATEK_CCI_DEVFREQ
> > +	tristate "MEDIATEK CCI DEVFREQ Driver"
> > +	depends on OF && ARM_MEDIATEK_CPUFREQ
> > +	help
> > +	  This adds a devfreq driver for Mediatek Cache Coherent
> > Interconnect
> > +	  which is shared the same regulator with cpu cluster. It can
> > track
> > +	  buck voltage and update a proper CCI frequency. Use
> > notification
> > +	  to get regulator status.
> > +
> >  config ARM_RK3399_DMC_DEVFREQ
> >  	tristate "ARM RK3399 DMC DEVFREQ Driver"
> >  	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index 991ef7740759..0493516a16f2 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -11,7 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=
> > governor_passive.o
> >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> >  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
> >  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> > -obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o
> > +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o
> 
> As I commented, mt8183-cci-devfreq.c is not existed on latest kernel.

Yes, it will be fixed after rebasing onto linux-next.

> 
> >  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
> >  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
> >  
> > diff --git a/drivers/devfreq/mtk-cci-devfreq.c
> > b/drivers/devfreq/mtk-cci-devfreq.c
> > new file mode 100644
> > index 000000000000..986f34689f5c
> > --- /dev/null
> > +++ b/drivers/devfreq/mtk-cci-devfreq.c
> > @@ -0,0 +1,471 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022 MediaTek Inc.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/devfreq.h>
> > +#include <linux/minmax.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +struct mtk_ccifreq_platform_data;
> 
> Instead of unneeded declaration,
> just define 'strcut mmk_ccifreq_platform_data' at here.

Yes, I will remove this forward declaration.

> 
> > +
> > +struct mtk_ccifreq_drv {
> > +	struct device *cci_dev;
> > +	struct devfreq *devfreq;
> > +	struct regulator *proc_reg;
> > +	struct regulator *sram_reg;
> > +	struct clk *cci_clk;
> > +	struct clk *inter_clk;
> > +	int inter_voltage;
> > +	int old_voltage;
> > +	unsigned long old_freq;
> > +	struct mutex lock;  /* avoid notify and policy race condition
> > */
> > +	struct notifier_block opp_nb;
> > +	const struct mtk_ccifreq_platform_data *soc_data;
> > +};
> > +
> > +struct mtk_ccifreq_platform_data {
> > +	int min_volt_shift;
> > +	int max_volt_shift;
> > +	int proc_max_volt;
> > +	int sram_min_volt;
> > +	int sram_max_volt;
> > +	bool need_voltage_tracking;
> > +};
> 
> As I commented, move it before struct mtk_ccifreq_drv.

Yes, I will update it in the next version.

> 
> > +
> > +static int mtk_ccifreq_voltage_tracking(struct mtk_ccifreq_drv
> > *drv, int new_voltage)
> > +{
> > +	const struct mtk_ccifreq_platform_data *soc_data = drv-
> > >soc_data;
> > +	struct regulator *proc_reg = drv->proc_reg;
> > +	struct regulator *sram_reg = drv->sram_reg;
> > +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> > +
> > +	old_voltage = regulator_get_voltage(proc_reg);
> > +	if (old_voltage < 0) {
> > +		pr_err("%s: invalid vproc value: %d\n", __func__,
> > old_voltage);
> 
> Use dev_err instead of pr_err and don't use '__func__'.

Yes, I will fix it in the next version.

> 
> > +		return old_voltage;
> > +	}
> > +
> > +	old_vsram = regulator_get_voltage(sram_reg);
> > +	if (old_vsram < 0) {
> > +		pr_err("%s: invalid vsram value: %d\n", __func__,
> > old_vsram);
> 
> ditto.

Yes, I will fix it in the next version.

> 
> > +		return old_vsram;
> > +	}
> > +
> > +	new_vsram = clamp(new_voltage + soc_data->min_volt_shift,
> > +			  soc_data->sram_min_volt, soc_data-
> > >sram_max_volt);
> > +
> > +	do {
> > +		if (old_voltage <= new_voltage) {
> > +			vsram = clamp(old_voltage + soc_data-
> > >max_volt_shift,
> > +				      soc_data->sram_min_volt,
> > new_vsram);
> > +			ret = regulator_set_voltage(sram_reg, vsram,
> > +						    soc_data-
> > >sram_max_volt);
> > +			if (ret)
> > +				return ret;
> > +
> > +			if (vsram == soc_data->sram_max_volt ||
> > +			    new_vsram == soc_data->sram_min_volt)
> > +				voltage = new_voltage;
> > +			else
> > +				voltage = vsram - soc_data-
> > >min_volt_shift;
> > +
> > +			ret = regulator_set_voltage(proc_reg, voltage,
> > +						    soc_data-
> > >proc_max_volt);
> > +			if (ret) {
> > +				regulator_set_voltage(sram_reg,
> > old_vsram,
> > +						      soc_data-
> > >sram_max_volt);
> > +				return ret;
> > +			}
> > +		} else if (old_voltage > new_voltage) {
> > +			voltage = max(new_voltage,
> > +				    old_vsram - soc_data-
> > >max_volt_shift);
> > +			ret = regulator_set_voltage(proc_reg, voltage,
> > +						    soc_data-
> > >proc_max_volt);
> > +			if (ret)
> > +				return ret;
> > +
> > +			if (voltage == new_voltage)
> > +				vsram = new_vsram;
> > +			else
> > +				vsram = max(new_vsram,
> > +					    voltage + soc_data-
> > >min_volt_shift);
> > +
> > +			ret = regulator_set_voltage(sram_reg, vsram,
> > +						    soc_data-
> > >sram_max_volt);
> > +			if (ret) {
> > +				regulator_set_voltage(proc_reg,
> > old_voltage,
> > +						      soc_data-
> > >proc_max_volt);
> > +				return ret;
> > +			}
> > +		}
> > +
> > +		old_voltage = voltage;
> > +		old_vsram = vsram;
> > +	} while (voltage != new_voltage || vsram != new_vsram);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_drv *drv,
> > int voltage)
> > +{
> > +	int ret;
> > +
> > +	if (drv->soc_data->need_voltage_tracking)
> > +		ret = mtk_ccifreq_voltage_tracking(drv, voltage);
> > +	else
> > +		ret = regulator_set_voltage(drv->proc_reg, voltage,
> > +					    drv->soc_data-
> > >proc_max_volt);
> > +
> > +	if (!ret)
> > +		drv->old_voltage = voltage;
> > +
> > +	return ret;
> > +}
> > +
> > +static int mtk_ccifreq_target(struct device *dev, unsigned long
> > *freq,
> > +			      u32 flags)
> > +{
> 
> I recommend that you handle the error case by using 'goto' statement
> instead of handling them in each error case. You can refer the 
> other devfreq device driver for handling error case with goto.

Sure, I will refactor it with 'goto' statement in the next version.

> 
> > +	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
> > +	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
> > +	struct dev_pm_opp *opp;
> > +	unsigned long opp_rate;
> > +	int voltage, old_voltage, inter_voltage, target_voltage, ret;
> > +
> > +	if (!drv)
> > +		return -EINVAL;
> > +
> > +	if (drv->old_freq == *freq)
> > +		return 0;
> > +
> > +	inter_voltage = drv->inter_voltage;
> > +
> > +	opp_rate = *freq;
> > +	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
> > +	if (IS_ERR(opp)) {
> > +		pr_err("cci: failed to find opp for freq: %ld\n",
> > opp_rate);
> 
> ditto.

Ok, I will use 'goto' to handle error.

> 
> > +		return PTR_ERR(opp);
> > +	}
> > +	voltage = dev_pm_opp_get_voltage(opp);
> > +	dev_pm_opp_put(opp);
> > +
> > +	old_voltage = drv->old_voltage;
> > +	if (old_voltage == 0)
> > +		old_voltage = regulator_get_voltage(drv->proc_reg);
> > +	if (old_voltage < 0) {
> > +		pr_err("cci: invalid vproc value: %d\n", old_voltage);
> 
> ditto. Use dev_err instead of pr_err.

Ok, I will use dev_err instread.

> 
> > +		return old_voltage;
> > +	}
> > +
> > +	mutex_lock(&drv->lock);
> > +
> > +	/* scale up: set voltage first then freq. */
> > +	target_voltage = max(inter_voltage, voltage);
> > +	if (old_voltage <= target_voltage) {
> > +		ret = mtk_ccifreq_set_voltage(drv, target_voltage);
> > +		if (ret) {
> > +			pr_err("cci: failed to scale up voltage\n");
> 
> ditto.

Ok, I will use dev_err instread.

> 
> > +			mtk_ccifreq_set_voltage(drv, old_voltage);
> > +			mutex_unlock(&drv->lock);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	/* switch the cci clock to intermediate clock source. */
> > +	ret = clk_set_parent(drv->cci_clk, drv->inter_clk);
> > +	if (ret) {
> > +		pr_err("cci: failed to re-parent cci clock\n");
> 
> ditto.

Ok, I will use dev_err instread.

> 
> > +		mtk_ccifreq_set_voltage(drv, old_voltage);
> > +		WARN_ON(1);
> 
> I think that it is not necessary. Please remove it.

Yes, I will remove it.

> 
> > +		mutex_unlock(&drv->lock);
> > +		return ret;
> > +	}
> > +
> > +	/* set the original clock to target rate. */
> > +	ret = clk_set_rate(cci_pll, *freq);
> > +	if (ret) {
> > +		pr_err("cci: failed to set cci pll rate: %d\n", ret);
> 
> ditto.

Ok, I will use dev_err instread.

> 
> > +		clk_set_parent(drv->cci_clk, cci_pll);
> > +		mtk_ccifreq_set_voltage(drv, old_voltage);
> > +		mutex_unlock(&drv->lock);
> > +		return ret;
> > +	}
> > +
> > +	/* switch the cci clock back to the original clock source. */
> > +	ret = clk_set_parent(drv->cci_clk, cci_pll);
> > +	if (ret) {
> > +		pr_err("cci: failed to re-parent cci clock\n");
> 
> ditto.

Ok, I will use dev_err instread.

> 
> > +		mtk_ccifreq_set_voltage(drv, inter_voltage);
> > +		WARN_ON(1);
> 
> ditto.

Ok, I will remove it.

> 
> > +		mutex_unlock(&drv->lock);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * If the new voltage is lower than the intermediate voltage or
> > the
> > +	 * original voltage, scale down to the new voltage.
> > +	 */
> > +	if (voltage < inter_voltage || voltage < old_voltage) {
> > +		ret = mtk_ccifreq_set_voltage(drv, voltage);
> > +		if (ret) {
> > +			pr_err("cci: failed to scale down voltage\n");
> 
> ditto.

Ok, I will use dev_err instread.

> 
> > +			WARN_ON(1);
> 
> ditto.

Ok, I will remove it.

> 
> > +			mutex_unlock(&drv->lock);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	drv->old_freq = *freq;
> > +	mutex_unlock(&drv->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_ccifreq_opp_notifier(struct notifier_block *nb,
> > +				    unsigned long event, void *data)
> > +{
> > +	struct dev_pm_opp *opp = data;
> > +	struct mtk_ccifreq_drv *drv;
> > +	unsigned long freq, volt;
> > +
> > +	drv = container_of(nb, struct mtk_ccifreq_drv, opp_nb);
> > +
> > +	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> > +		freq = dev_pm_opp_get_freq(opp);
> > +
> > +		mutex_lock(&drv->lock);
> > +		/* current opp item is changed */
> > +		if (freq == drv->old_freq) {
> > +			volt = dev_pm_opp_get_voltage(opp);
> > +			mtk_ccifreq_set_voltage(drv, volt);
> > +		}
> > +		mutex_unlock(&drv->lock);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct devfreq_dev_profile mtk_ccifreq_profile = {
> > +	.target = mtk_ccifreq_target,
> > +};
> > +
> > +static int mtk_ccifreq_probe(struct platform_device *pdev)
> > +{
> > +	struct device *cci_dev = &pdev->dev;
> > +	struct mtk_ccifreq_drv *drv;
> > +	struct devfreq_passive_data *passive_data;
> > +	struct dev_pm_opp *opp;
> > +	unsigned long rate, opp_volt;
> > +	int ret;
> > +
> > +	drv = devm_kzalloc(cci_dev, sizeof(*drv), GFP_KERNEL);
> > +	if (!drv)
> > +		return -ENOMEM;
> > +
> > +	drv->cci_dev = cci_dev;
> > +	drv->soc_data = (const struct mtk_ccifreq_platform_data *)
> > +				of_device_get_match_data(&pdev->dev);
> > +	mutex_init(&drv->lock);
> > +	platform_set_drvdata(pdev, drv);
> > +
> > +	drv->cci_clk = devm_clk_get(cci_dev, "cci");
> > +	if (IS_ERR(drv->cci_clk)) {
> > +		ret = PTR_ERR(drv->cci_clk);
> > +		return dev_err_probe(cci_dev, ret,
> > +				     "cci: failed to get cci clk:
> > %d\n",
> > +				     ret);
> > +	}
> > +
> > +	drv->inter_clk = devm_clk_get(cci_dev, "intermediate");
> > +	if (IS_ERR(drv->inter_clk)) {
> > +		ret = PTR_ERR(drv->inter_clk);
> > +		return dev_err_probe(cci_dev, ret,
> > +				     "cci: failed to get intermediate
> > clk: %d\n",
> > +				     ret);
> > +	}
> > +
> > +	if (drv->soc_data->need_voltage_tracking) {
> > +		drv->sram_reg = regulator_get_optional(cci_dev,
> > "sram");
> > +		if (IS_ERR_OR_NULL(drv->sram_reg)) {
> > +			ret = PTR_ERR(drv->sram_reg);
> > +			return dev_err_probe(cci_dev, ret,
> > +					     "cci: failed to get sram
> > regulator: %d\n",
> > +					     ret);
> > +		}
> > +
> > +		ret = regulator_enable(drv->sram_reg);
> > +		if (ret) {
> > +			dev_warn(cci_dev,
> > +				 "cci: failed to enable sram
> > regulator\n");
> 
> If you want to break the probe sequence, better to use 'dev_err'
> instead of 'dev_warn' if there is no any reason to use dev_warn.
> 

Ok, I will use dev_err.

> 
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	drv->proc_reg = devm_regulator_get_optional(cci_dev, "proc");
> > +	if (IS_ERR(drv->proc_reg)) {
> > +		ret = PTR_ERR(drv->proc_reg);
> > +		dev_err_probe(cci_dev, ret,
> > +			      "cci: failed to get proc regulator:
> > %d\n",
> > +			      ret);
> > +		goto out_disable_sram_reg;
> > +	}
> > +
> > +	ret = regulator_enable(drv->proc_reg);
> > +	if (ret) {
> > +		dev_warn(cci_dev, "cci: failed to enable proc
> > regulator\n");
> 
> ditto. Use dev_err.

Ok, I will replace all dev_warn with dev_err in the patch.

> 
> > +		goto out_disable_sram_reg;
> > +	}
> > +
> > +	ret = clk_prepare_enable(drv->cci_clk);
> > +	if (ret)
> > +		goto out_disable_proc_reg;
> > +
> > +	ret = clk_prepare_enable(drv->inter_clk);
> > +	if (ret)
> > +		goto out_disable_cci_clk;
> > +
> > +	ret = dev_pm_opp_of_add_table(cci_dev);
> > +	if (ret) {
> > +		dev_warn(cci_dev, "cci: failed to add opp table: %d\n",
> > ret);
> > +		goto out_disable_inter_clk;
> > +	}
> > +
> > +	rate = clk_get_rate(drv->inter_clk);
> > +	opp = dev_pm_opp_find_freq_ceil(cci_dev, &rate);
> > +	if (IS_ERR(opp)) {
> > +		ret = PTR_ERR(opp);
> > +		dev_err(cci_dev, "cci: failed to get intermediate opp:
> > %d\n",
> > +			ret);
> > +		goto out_remove_opp_table;
> > +	}
> > +	drv->inter_voltage = dev_pm_opp_get_voltage(opp);
> > +	dev_pm_opp_put(opp);
> > +
> > +	rate = U32_MAX;
> > +	opp = dev_pm_opp_find_freq_floor(drv->cci_dev, &rate);
> > +	if (IS_ERR(opp)) {
> > +		pr_err("failed to get opp\n");
> > +		ret = PTR_ERR(opp);
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	opp_volt = dev_pm_opp_get_voltage(opp);
> > +	dev_pm_opp_put(opp);
> > +	ret = mtk_ccifreq_set_voltage(drv, opp_volt);
> > +	if (ret) {
> > +		pr_err("failed to scale to highest voltage %lu in
> > proc_reg\n",
> > +		       opp_volt);
> 
> Use dev_err.

Ok, I will use dev_err instread.

> 
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	passive_data = devm_kzalloc(cci_dev, sizeof(struct
> > devfreq_passive_data), GFP_KERNEL);
> > +	if (!passive_data) {
> > +		ret = -ENOMEM;
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	passive_data->parent_type = CPUFREQ_PARENT_DEV;
> 
> It seems that depend on patchset[1]. I'll send the updated patch 
> within one week.
> [1] 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing__;!!CTRNKA9wMg0ARbw!zpzMoFhloy2fpTawf8kkY5nwKerht5CKCnKTwwmSHYBN2vN5WfVMOcGn5TDb8SPTQTSaHA$
>  

Should I send my patch after yours? Or the order makes no difference?

> 
> > +	drv->devfreq = devm_devfreq_add_device(cci_dev,
> > +					       &mtk_ccifreq_profile,
> > +					       DEVFREQ_GOV_PASSIVE,
> > +					       passive_data);
> > +	if (IS_ERR(drv->devfreq)) {
> > +		ret = -EPROBE_DEFER;
> > +		dev_err(cci_dev, "cci: failed to add devfreq device:
> > %d\n",
> > +			PTR_ERR(drv->devfreq));
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	drv->opp_nb.notifier_call = mtk_ccifreq_opp_notifier;
> > +	ret = dev_pm_opp_register_notifier(cci_dev, &drv->opp_nb);
> > +	if (ret) {
> > +		dev_warn(cci_dev, "cci: failed to register opp
> > notifier: %d\n",
> > +			 ret);
> > +		goto out_remove_devfreq_device;
> > +	}
> > +
> > +	return 0;
> > +
> > +out_remove_devfreq_device:
> > +	devm_devfreq_remove_device(cci_dev, drv->devfreq);
> > +
> > +out_remove_opp_table:
> > +	dev_pm_opp_of_remove_table(cci_dev);
> > +
> > +out_disable_inter_clk:
> > +	clk_disable_unprepare(drv->inter_clk);
> > +
> > +out_disable_cci_clk:
> > +	clk_disable_unprepare(drv->cci_clk);
> > +
> > +out_disable_proc_reg:
> > +	regulator_disable(drv->proc_reg);
> > +
> > +out_disable_sram_reg:
> > +	if (drv->soc_data->need_voltage_tracking)
> > +		regulator_disable(drv->sram_reg);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mtk_ccifreq_remove(struct platform_device *pdev)
> > +{
> > +	struct device *cci_dev = &pdev->dev;
> > +	struct mtk_ccifreq_drv *drv;
> > +
> > +	drv = platform_get_drvdata(pdev);
> > +
> > +	dev_pm_opp_unregister_notifier(cci_dev, &drv->opp_nb);
> > +	dev_pm_opp_of_remove_table(cci_dev);
> > +	regulator_disable(drv->proc_reg);
> > +	if (!IS_ERR(drv->sram_reg))
> > +		regulator_disable(drv->sram_reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtk_ccifreq_platform_data mtk_platform_data =
> > {
> > +	.min_volt_shift = 0,
> > +	.max_volt_shift = 0,
> > +	.proc_max_volt = 1150000,
> > +	.sram_min_volt = 0,
> > +	.sram_max_volt = 0,
> > +	.need_voltage_tracking = false,
> > +};
> > +
> > +static const struct of_device_id mtk_ccifreq_machines[] = {
> > +	{ .compatible = "mediatek,mt8183-cci", .data =
> > &mtk_platform_data },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_ccifreq_machines);
> > +
> > +static struct platform_driver mtk_ccifreq_platdrv = {
> > +	.probe	= mtk_ccifreq_probe,
> > +	.remove	= mtk_ccifreq_remove,
> > +	.driver = {
> > +		.name = "mtk-ccifreq",
> > +		.of_match_table = of_match_ptr(mtk_ccifreq_machines),
> > +	},
> > +};
> > +
> > +static int __init mtk_ccifreq_platdrv_init(void)
> > +{
> > +	return platform_driver_register(&mtk_ccifreq_platdrv);
> > +}
> > +module_init(mtk_ccifreq_platdrv_init)
> > +
> > +static void __exit mtk_ccifreq_platdrv_exit(void)
> > +{
> > +	platform_driver_unregister(&mtk_ccifreq_platdrv);
> > +}
> > +module_exit(mtk_ccifreq_platdrv_exit)
> > +
> > +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> > +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
> 

