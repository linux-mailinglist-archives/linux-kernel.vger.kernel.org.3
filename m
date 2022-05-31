Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4135390AA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbiEaMZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbiEaMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:25:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980EC8FFB4;
        Tue, 31 May 2022 05:25:32 -0700 (PDT)
X-UUID: 677773f18cee47b9a534dfaefdb15a0d-20220531
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4f2e94e7-7d11-4f8b-9093-0dbca211270a,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:2e746614-f88c-475e-badf-d9ee54230b8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 677773f18cee47b9a534dfaefdb15a0d-20220531
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1830817681; Tue, 31 May 2022 20:25:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 31 May 2022 20:25:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 May 2022 20:25:21 +0800
Message-ID: <31eca4ae2ec103e95bf3faf70d8810dc972db344.camel@mediatek.com>
Subject: Re: [PATCH v6 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>
CC:     <khilman@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 31 May 2022 20:25:22 +0800
In-Reply-To: <e4d3ab91-9c53-79a0-76f8-098e6b846441@collabora.com>
References: <20220527110036.8810-1-johnson.wang@mediatek.com>
         <20220527110036.8810-3-johnson.wang@mediatek.com>
         <e4d3ab91-9c53-79a0-76f8-098e6b846441@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-30 at 14:16 +0200, AngeloGioacchino Del Regno wrote:
> Il 27/05/22 13:00, Johnson Wang ha scritto:
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
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> > This patch depends on "devfreq-testing"[1].
> > [1]
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing__;!!CTRNKA9wMg0ARbw!2ldxtrMmK2WJP8_r1DcJRm0XQOSZQJfbI5DlNDPEfz84Ble0R7pSP7PbYLreNgVGRyFfDQ$
> >  
> > ---
> >   drivers/devfreq/Kconfig           |  10 +
> >   drivers/devfreq/Makefile          |   1 +
> >   drivers/devfreq/mtk-cci-devfreq.c | 441
> > ++++++++++++++++++++++++++++++
> >   3 files changed, 452 insertions(+)
> >   create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> > 
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 87eb2b837e68..9754d8b31621 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
> >   	  It reads ACTMON counters of memory controllers and adjusts
> > the
> >   	  operating frequencies and voltages with OPP support.
> >   
> > +config ARM_MEDIATEK_CCI_DEVFREQ
> > +	tristate "MEDIATEK CCI DEVFREQ Driver"
> > +	depends on ARM_MEDIATEK_CPUFREQ || COMPILE_TEST
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
> > index 000000000000..df42da35b312
> > --- /dev/null
> > +++ b/drivers/devfreq/mtk-cci-devfreq.c
> > @@ -0,0 +1,441 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022 MediaTek Inc.
> > + */
> > +
> 
> ..snip..
> 
> > +};
> > +
> > +static int mtk_ccifreq_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mtk_ccifreq_drv *drv;
> > +	struct devfreq_passive_data *passive_data;
> > +	struct dev_pm_opp *opp;
> > +	unsigned long rate, opp_volt;
> > +	int ret;
> > +
> > +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> > +	if (!drv)
> > +		return -ENOMEM;
> > +
> > +	drv->dev = dev;
> > +	drv->soc_data = (const struct mtk_ccifreq_platform_data *)
> > +				of_device_get_match_data(&pdev->dev);
> > +	mutex_init(&drv->reg_lock);
> > +	platform_set_drvdata(pdev, drv);
> > +
> > +	drv->cci_clk = devm_clk_get(dev, "cci");
> > +	if (IS_ERR(drv->cci_clk)) {
> > +		ret = PTR_ERR(drv->cci_clk);
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to get cci clk: %d\n",
> > ret);
> > +	}
> > +
> > +	drv->inter_clk = devm_clk_get(dev, "intermediate");
> > +	if (IS_ERR(drv->inter_clk)) {
> > +		ret = PTR_ERR(drv->inter_clk);
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to get intermediate clk:
> > %d\n", ret);
> > +	}
> > +
> > +	drv->proc_reg = devm_regulator_get_optional(dev, "proc");
> 
> In the devicetree binding for this driver, the "proc" regulator is
> *not* optional,
> but here you're using devm_regulator_get_optional.
> 
> If this is not optional, you should use devm_regulator_get() instead.
> 

Hi Angelo,

This is similiar case to mediatek-cpufreq.c [1].

Regulator framework has three variants of APIs for getting regulator
handler.
We do NOT choose regulator_get_exclusive() because cpufreq and cci
share with the same power rail.
We choose regulator_get_optional() so that we can handle error if it
returns ERR_PTR(-ENODEV) rather than a dummy handler from
regulator_get().

Please inform me if I get it wrong.
That's what I understand and you can refer to [2].

Thanks.

[1]: 20220408045908.21671-4-rex-bc.chen@mediatek.com
[2]: 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1327385.html

> > +	if (IS_ERR(drv->proc_reg)) {
> > +		ret = PTR_ERR(drv->proc_reg);
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to get proc regulator:
> > %d\n", ret);
> 
> There's no need to print ret... dev_err_probe() takes care of that
> for you already:
> in this case, you're printing the value of ret twice.
> 
> > +	}
> > +
> > +	ret = regulator_enable(drv->proc_reg);
> 
> If you move this call after the devm_regulator_get_optional() call
> for the sram
> vreg, you will be able to use dev_err_probe for the latter as well.
> 
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable proc regulator\n");
> 
> Why aren't you using dev_err_probe here, like you've done for the
> other instances?
> 
> > +		return ret;
> > +	}
> > +
> > +	drv->sram_reg = devm_regulator_get_optional(dev, "sram");
> > +	if (IS_ERR(drv->sram_reg))
> > +		drv->sram_reg = NULL;
> 
> When you use regulator_get_optional() (including the devm_ variant of
> it), you
> shall return an error, if there's any... that's what the _optional()
> is for.
> 
> if (IS_ERR(drv->sram_reg))
> 	return dev_err_probe(dev, PTR_ERR(drv->proc_reg),
> 			     "failed to get sram regulator");
> 
> > +	else {
> > +		ret = regulator_enable(drv->sram_reg);
> > +		if (ret) {
> > +			dev_err(dev, "failed to enable sram
> > regulator\n");
> > +			goto out_free_resources;
> > +		}
> > +	}
> > +
> 
> Regards,
> Angelo
> 
> 

