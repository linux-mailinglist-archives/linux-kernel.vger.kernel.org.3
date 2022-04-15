Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5511F502A87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353768AbiDOMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiDOMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:49:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4BBC90DF;
        Fri, 15 Apr 2022 05:46:57 -0700 (PDT)
X-UUID: 6f24afeb89f54a3695d39614541aa7ed-20220415
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:bd7f9eb7-58ce-41ae-9d7d-f5e65d1025e3,OB:0,LO
        B:10,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:53
X-CID-INFO: VERSION:1.1.4,REQID:bd7f9eb7-58ce-41ae-9d7d-f5e65d1025e3,OB:0,LOB:
        10,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:53
X-CID-META: VersionHash:faefae9,CLOUDID:93dbe2ef-da02-41b4-b6df-58f4ccd36682,C
        OID:706a576dedef,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 6f24afeb89f54a3695d39614541aa7ed-20220415
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 517416927; Fri, 15 Apr 2022 20:46:54 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 Apr 2022 20:46:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Apr
 2022 20:46:53 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 20:46:53 +0800
Message-ID: <6bce3e554dc0c5585dfbbd18a54f51567bbcacca.camel@mediatek.com>
Subject: Re: [PATCH v2 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>, <cw00.choi@samsung.com>,
        <krzk+dt@kernel.org>, <robh+dt@kernel.org>,
        <kyungmin.park@samsung.com>
CC:     <khilman@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 15 Apr 2022 20:46:53 +0800
In-Reply-To: <bd1c9dcc-987a-8214-1a1a-095053dd7242@gmail.com>
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
         <20220408052150.22536-3-johnson.wang@mediatek.com>
         <bd1c9dcc-987a-8214-1a1a-095053dd7242@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Thu, 2022-04-14 at 06:43 +0900, Chanwoo Choi wrote:
> Hi Johnson,
> 
> On 22. 4. 8. 14:21, Johnson Wang wrote:
> > We introduce a devfreq driver for the MediaTek Cache Coherent
> > Interconnect
> > (CCI) used by some MediaTek SoCs.
> > 
> > In this driver, we use the passive devfreq driver to get target
> > frequencies
> > and adjust voltages accordingly. In MT8183 and MT8186, the MediaTek
> > CCI
> > is supplied by the same regulators with the little core CPUs.
> > 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> > This patch depends on "devfreq-testing"[1].
> > [1]
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing__;!!CTRNKA9wMg0ARbw!zTRf894peuWDE_-MUuTihqu6mp5fA1rmQ3R8UK5a_bgILjAleHCI9z9QAk55ohfaw880$
> >  
> > ---
> >   drivers/devfreq/Kconfig           |  10 +
> >   drivers/devfreq/Makefile          |   1 +
> >   drivers/devfreq/mtk-cci-devfreq.c | 479
> > ++++++++++++++++++++++++++++++
> >   3 files changed, 490 insertions(+)
> >   create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> > 
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 87eb2b837e68..d985597f343f 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
> >   	  It reads ACTMON counters of memory controllers and adjusts
> > the
> >   	  operating frequencies and voltages with OPP support.
> >   
> > +config ARM_MEDIATEK_CCI_DEVFREQ
> > +	tristate "MEDIATEK CCI DEVFREQ Driver"
> > +	depends on ARM_MEDIATEK_CPUFREQ
> > +	select DEVFREQ_GOV_PASSIVE
> > +	help
> > +	  This adds a devfreq driver for MediaTek Cache Coherent
> > Interconnect
> > +	  which is shared the same regulators with the cpu cluster. It
> > can track
> > +	  buck voltages and update a proper CCI frequency. Use the
> > notification
> > +	  to get the regulator status.
> > +
> >   config ARM_RK3399_DMC_DEVFREQ
> >   	tristate "ARM RK3399 DMC DEVFREQ Driver"
> >   	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index 0b6be92a25d9..bf40d04928d0 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=
> > governor_passive.o
> >   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> >   obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
> >   obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> > +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o
> >   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
> >   obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)	+= sun8i-a33-mbus.o
> >   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
> > diff --git a/drivers/devfreq/mtk-cci-devfreq.c
> > b/drivers/devfreq/mtk-cci-devfreq.c
> > new file mode 100644
> > index 000000000000..53a28e2c88bd
> > --- /dev/null
> > +++ b/drivers/devfreq/mtk-cci-devfreq.c
> > @@ -0,0 +1,479 @@
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
> > +struct mtk_ccifreq_platform_data {
> > +	int min_volt_shift;
> > +	int max_volt_shift;
> > +	int proc_max_volt;
> > +	int sram_min_volt;
> > +	int sram_max_volt;
> > +};
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
> > +	bool need_voltage_tracking;
> > +	/* Avoid race condition for regulators between notify and
> > policy */
> > +	struct mutex reg_lock;
> > +	struct notifier_block opp_nb;
> > +	const struct mtk_ccifreq_platform_data *soc_data;
> > +};
> > +
> > +static int mtk_ccifreq_voltage_tracking(struct mtk_ccifreq_drv
> > *drv,
> > +					int new_voltage)
> > +{
> 
> mtk_ccifreq_voltage_tracking() function is only used in 
> mtk_ccifreq_set_voltage and mtk_ccifreq_set_voltage function doesn't 
> contain the long codes. I recommend that move 
> mtk_ccifreq_voltage_tracking code into mtk_ccifreq_set_voltage.

Thanks for your review.
I will try to modify it in the next version.

> > +	const struct mtk_ccifreq_platform_data *soc_data = drv-
> > >soc_data;
> > +	struct device *dev = drv->cci_dev;
> > +	struct regulator *proc_reg = drv->proc_reg;
> > +	struct regulator *sram_reg = drv->sram_reg;
> > +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> > +
> > +	old_voltage = regulator_get_voltage(proc_reg);
> > +	if (old_voltage < 0) {
> > +		dev_err(dev, "invalid vproc value: %d\n", old_voltage);
> > +		return old_voltage;
> > +	}
> > +
> > +	old_vsram = regulator_get_voltage(sram_reg);
> > +	if (old_vsram < 0) {
> > +		dev_err(dev, "invalid vsram value: %d\n", old_vsram);
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
> > +				      old_vsram - soc_data-
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
> 
> It is dangerous if regulator h/w have  the issue, it might be never 
> finished. Need to check the maximum loop or do other way for
> preventing 
> the inifinite loop.

I will add an iteration limit to avoid the infinite loop.
Thanks for reminding me.

> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_drv *drv,
> > int voltage)
> > +{
> > +	int ret;
> > +
> > +	if (drv->need_voltage_tracking)
> 
> You can change this code as following without
> 'need_voltage_tracking' 
> variable. It is more simple.
> 
> 	if (drv->sram_reg)

I will follow your suggestion here in the next version.

> 
> 
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
> > +		dev_err(dev, "failed to find opp for freq: %ld\n",
> > opp_rate);
> > +		return PTR_ERR(opp);
> > +	}
> > +	voltage = dev_pm_opp_get_voltage(opp);
> > +	dev_pm_opp_put(opp);
> > +
> > +	old_voltage = drv->old_voltage;
> > +	if (old_voltage == 0)
> > +		old_voltage = regulator_get_voltage(drv->proc_reg);
> > +	if (old_voltage < 0) {
> > +		dev_err(dev, "invalid vproc value: %d\n", old_voltage);
> > +		return old_voltage;
> > +	}
> 
> It should be checked on target? I think that you get the voltage on 
> pr obe only once and then handle the old_voltage value in 
> mtk_ccifreq_set_voltage when voltage is changed.
> 

Yes, we actually did some experiments on target.

> > +
> > +	mutex_lock(&drv->reg_lock);
> > +
> > +	/* scale up: set voltage first then freq. */
> > +	target_voltage = max(inter_voltage, voltage);
> > +	if (old_voltage <= target_voltage) {
> 
> you can use drv->old_voltage without 'old_voltage' local variable
> if you do as my comment above.

We keep original voltage before adjusting the voltage. If there are
some errors while switching clock, we can restore the voltage.
That's why we use 'old_voltage' local variable here.
 
> 
> > +		ret = mtk_ccifreq_set_voltage(drv, target_voltage);
> > +		if (ret) {
> > +			dev_err(dev, "failed to scale up voltage\n");
> > +			goto out_restore_voltage;
> > +		}
> > +	}
> > +
> > +	/* switch the cci clock to intermediate clock source. */
> > +	ret = clk_set_parent(drv->cci_clk, drv->inter_clk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to re-parent cci clock\n");
> > +		goto out_restore_voltage;
> > +	}
> > +
> > +	/* set the original clock to target rate. */
> > +	ret = clk_set_rate(cci_pll, *freq);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set cci pll rate: %d\n", ret);
> > +		clk_set_parent(drv->cci_clk, cci_pll);
> > +		goto out_restore_voltage;
> > +	}
> > +
> > +	/* switch the cci clock back to the original clock source. */
> > +	ret = clk_set_parent(drv->cci_clk, cci_pll);
> > +	if (ret) {
> > +		dev_err(dev, "failed to re-parent cci clock\n");
> > +		mtk_ccifreq_set_voltage(drv, inter_voltage);
> > +		goto out_unlock;
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
> > +			dev_err(dev, "failed to scale down voltage\n");
> > +			goto out_unlock;
> > +		}
> > +	}
> > +
> > +	drv->old_freq = *freq;
> > +	mutex_unlock(&drv->reg_lock);
> > +
> > +	return 0;
> > +
> > +out_restore_voltage:
> > +	mtk_ccifreq_set_voltage(drv, old_voltage);
> > +
> > +out_unlock:
> > +	mutex_unlock(&drv->reg_lock);
> > +	return ret;
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
> > +		mutex_lock(&drv->reg_lock);
> > +		/* current opp item is changed */
> > +		if (freq == drv->old_freq) {
> > +			volt = dev_pm_opp_get_voltage(opp);
> > +			mtk_ccifreq_set_voltage(drv, volt);
> 
> I have a question. Is it no problem? Change the voltage
> without any clock change? If voltage is lower than required voltage 
> level from the specific clock, I think it might be hung.
> 

This OPP notification is only sent from our SVS driver to adjust the
voltage at the same frequency for power-saving purpose.

Our chip design basically knows the margin of the voltage at every
frequencies and promises that the adjustment of voltage here will never
causes system crash.

> > +		}
> > +		mutex_unlock(&drv->reg_lock); > +	}
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
> > +	mutex_init(&drv->reg_lock);
> > +	platform_set_drvdata(pdev, drv);
> > +
> > +	drv->cci_clk = devm_clk_get(cci_dev, "cci");
> > +	if (IS_ERR(drv->cci_clk)) {
> > +		ret = PTR_ERR(drv->cci_clk);
> > +		return dev_err_probe(cci_dev, ret,
> > +				     "failed to get cci clk: %d\n",
> > ret);
> > +	}
> > +
> > +	drv->inter_clk = devm_clk_get(cci_dev, "intermediate");
> > +	if (IS_ERR(drv->inter_clk)) {
> > +		ret = PTR_ERR(drv->inter_clk);
> > +		dev_err_probe(cci_dev, ret,
> > +			      "failed to get intermediate clk: %d\n",
> > ret);
> > +		goto out_free_resources;
> > +	}
> > +
> > +	drv->proc_reg = devm_regulator_get_optional(cci_dev, "proc");
> 
> nitpick. How about using 'cci' name instead of 'proc'?
> Actually, it is difficult to understand the meaning of 'proc' name.

'proc' is processor in short.
This regulator is shared with cpufreq driver, not specific to CCI.
In my opinion, CCI driver shouldn't rename it unless cpufreq driver
changes it first. 

> 
> > +	if (IS_ERR(drv->proc_reg)) {
> > +		ret = PTR_ERR(drv->proc_reg);
> > +		dev_err_probe(cci_dev, ret,
> > +			      "failed to get proc regulator: %d\n",
> > ret);
> > +		goto out_free_resources;
> > +	}
> > +
> > +	ret = regulator_enable(drv->proc_reg);
> > +	if (ret) {
> > +		dev_err(cci_dev, "failed to enable proc regulator\n");
> > +		goto out_free_resources;
> > +	}
> > +
> > +	drv->sram_reg = regulator_get_optional(cci_dev, "sram");
> > +	if (IS_ERR(drv->sram_reg))
> > +		drv->sram_reg = NULL;
> > +	else {
> > +		ret = regulator_enable(drv->sram_reg);
> > +		if (ret) {
> > +			dev_err(cci_dev, "failed to enable sram
> > regulator\n");
> > +			goto out_free_resources;
> > +		}
> > +	}
> > +
> > +	ret = clk_prepare_enable(drv->cci_clk);
> > +	if (ret)
> > +		goto out_free_resources;
> > +
> > +	ret = clk_prepare_enable(drv->inter_clk);
> > +	if (ret)
> > +		goto out_disable_cci_clk;
> > +
> > +	drv->need_voltage_tracking = (drv->sram_reg != NULL);
> 
> As I commented in mtk_ccifreq_set_voltage, you don't need to use 
> 'need_voltage_tracking". Instead just use 'drv->sram_reg direclty.

I will modify it in the next version.

> 
> > +
> > +	ret = dev_pm_opp_of_add_table(cci_dev);
> > +	if (ret) {
> > +		dev_err(cci_dev, "failed to add opp table: %d\n", ret);
> > +		goto out_disable_inter_clk;
> > +	}
> > +
> > +	rate = clk_get_rate(drv->inter_clk);
> > +	opp = dev_pm_opp_find_freq_ceil(cci_dev, &rate);
> > +	if (IS_ERR(opp)) {
> > +		ret = PTR_ERR(opp);
> > +		dev_err(cci_dev, "failed to get intermediate opp:
> > %d\n", ret);
> > +		goto out_remove_opp_table;
> > +	}
> > +	drv->inter_voltage = dev_pm_opp_get_voltage(opp);
> > +	dev_pm_opp_put(opp);
> > +
> > +	rate = U32_MAX;
> > +	opp = dev_pm_opp_find_freq_floor(drv->cci_dev, &rate);
> > +	if (IS_ERR(opp)) {
> > +		dev_err(cci_dev, "failed to get opp\n");
> > +		ret = PTR_ERR(opp);
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	opp_volt = dev_pm_opp_get_voltage(opp);
> > +	dev_pm_opp_put(opp);
> > +	ret = mtk_ccifreq_set_voltage(drv, opp_volt);
> > +	if (ret) {
> > +		dev_err(cci_dev, "failed to scale to highest voltage
> > %lu in proc_reg\n",
> > +			opp_volt);
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	passive_data = devm_kzalloc(cci_dev,
> > +				    sizeof(struct
> > devfreq_passive_data),
> > +				    GFP_KERNEL);
> > +	if (!passive_data) {
> > +		ret = -ENOMEM;
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	passive_data->parent_type = CPUFREQ_PARENT_DEV;
> > +	drv->devfreq = devm_devfreq_add_device(cci_dev,
> > +					       &mtk_ccifreq_profile,
> > +					       DEVFREQ_GOV_PASSIVE,
> > +					       passive_data);
> > +	if (IS_ERR(drv->devfreq)) {
> > +		ret = -EPROBE_DEFER;
> > +		dev_err(cci_dev, "failed to add devfreq device: %d\n",
> > +			PTR_ERR(drv->devfreq));
> > +		goto out_remove_opp_table;
> > +	}
> > +
> > +	drv->opp_nb.notifier_call = mtk_ccifreq_opp_notifier;
> > +	ret = dev_pm_opp_register_notifier(cci_dev, &drv->opp_nb);
> > +	if (ret) {
> > +		dev_err(cci_dev, "failed to register opp notifier:
> > %d\n", ret);
> > +		goto out_remove_devfreq_device;
> > +	}
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
> > +out_free_resources:
> > +	if (regulator_is_enabled(drv->proc_reg))
> > +		regulator_disable(drv->proc_reg);
> > +	if (drv->sram_reg && regulator_is_enabled(drv->sram_reg))
> > +		regulator_disable(drv->sram_reg);
> > +
> > +	if (!IS_ERR(drv->proc_reg))
> > +		regulator_put(drv->proc_reg);
> > +	if (!IS_ERR(drv->sram_reg))
> > +		regulator_put(drv->sram_reg);
> > +	if (!IS_ERR(drv->cci_clk))
> > +		clk_put(drv->cci_clk);
> > +	if (!IS_ERR(drv->inter_clk))
> > +		clk_put(drv->inter_clk);
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
> > +	clk_disable_unprepare(drv->inter_clk);
> > +	clk_disable_unprepare(drv->cci_clk);
> > +	regulator_disable(drv->proc_reg);
> > +	if (!IS_ERR(drv->sram_reg))
> 
> Better to use the following code.
> 	if (drv->sram_reg)

I will modify it in the next version.

> 
> > +		regulator_disable(drv->sram_reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtk_ccifreq_platform_data mt8183_platform_data
> > = {
> > +	.min_volt_shift = 100000,
> > +	.max_volt_shift = 200000,
> > +	.proc_max_volt = 1150000,
> > +	.sram_min_volt = 0,
> > +	.sram_max_volt = 1150000,
> > +};
> > +
> > +static const struct mtk_ccifreq_platform_data mt8186_platform_data
> > = {
> > +	.min_volt_shift = 100000,
> > +	.max_volt_shift = 250000,
> > +	.proc_max_volt = 1118750,
> > +	.sram_min_volt = 850000,
> > +	.sram_max_volt = 1118750,
> > +};
> > +
> > +static const struct of_device_id mtk_ccifreq_machines[] = {
> > +	{ .compatible = "mediatek,mt8183-cci", .data =
> > &mt8183_platform_data },
> > +	{ .compatible = "mediatek,mt8186-cci", .data =
> > &mt8186_platform_data },
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
> > +MODULE_DESCRIPTION("MediaTek CCI devfreq driver");
> > +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> 
> 

BRs,
Johnson Wang

