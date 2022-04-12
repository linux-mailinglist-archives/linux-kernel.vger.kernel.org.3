Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F44FD3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383258AbiDLJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389913AbiDLJYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:24:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791842459E;
        Tue, 12 Apr 2022 01:39:44 -0700 (PDT)
X-UUID: 88867b4216d24856b6005e31d2c9c5d0-20220412
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6c7e3c15-4e3f-4ddf-9ac6-026e158614b3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:6c7e3c15-4e3f-4ddf-9ac6-026e158614b3,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:bd8f1d78-0afa-4dca-bdec-ca54c998425a,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 88867b4216d24856b6005e31d2c9c5d0-20220412
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1283748203; Tue, 12 Apr 2022 16:39:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 12 Apr 2022 16:39:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Apr 2022 16:39:36 +0800
Message-ID: <d900f8181bddb20a56231310d46b9427c40e77b8.camel@mediatek.com>
Subject: Re: [PATCH v2 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>
CC:     <khilman@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 12 Apr 2022 16:39:36 +0800
In-Reply-To: <76d58182-2f56-32b2-42e9-2ecbdd09ba3d@linaro.org>
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
         <20220408052150.22536-3-johnson.wang@mediatek.com>
         <76d58182-2f56-32b2-42e9-2ecbdd09ba3d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
On Fri, 2022-04-08 at 10:21 +0200, Krzysztof Kozlowski wrote:
> On 08/04/2022 07:21, Johnson Wang wrote:
> > We introduce a devfreq driver for the MediaTek Cache Coherent
> > Interconnect
> > (CCI) used by some MediaTek SoCs.
> > 
> 
> (...)
> 
> > index 87eb2b837e68..d985597f343f 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
> >  	  It reads ACTMON counters of memory controllers and adjusts
> > the
> >  	  operating frequencies and voltages with OPP support.
> >  
> > +config ARM_MEDIATEK_CCI_DEVFREQ
> > +	tristate "MEDIATEK CCI DEVFREQ Driver"
> > +	depends on ARM_MEDIATEK_CPUFREQ
> > > COMPILE_TEST? And check if it test compiles.

Thank you for your review.
I will add COMPILE_TEST and see if this driver is compiled with it.

> 
> (...)
> 
> > +
> > +static int mtk_ccifreq_remove(struct platform_device *pdev)
> > +{
> > +	struct device *cci_dev = &pdev->dev;
> 
> s/cci_dev/dev/
> Everywhere.
> 

Sure, I will modify it in the next version.

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
> 
> You use of_match_ptr() so is it possible to build it without OF? If
> so,
> then mtk_ccifreq_machines needs maybe_unused.
> 

No, this driver must be built with OF due to our CPU arch.
Should I add some dependencies in Kconfig to ensure OF is enabled?

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
> 
> Why not module_platform_driver()?

I will try to use module_platform_driver() and update it in the next
version.

> 
> > +
> > +MODULE_DESCRIPTION("MediaTek CCI devfreq driver");
> > +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");
> > +MODULE_LICENSE("GPL v2");
> 
> 
> Best regards,
> Krzysztof

BRs,
Johnson Wang

