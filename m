Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519644B630B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiBOFrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiBOFrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:47:01 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D365CD;
        Mon, 14 Feb 2022 21:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644904011; x=1676440011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TvWJh4A1T8qWGMCRPKV1Y35pywluGs/GcJiS0D0Av0Y=;
  b=D7elmkzKXrY9w47o1aM5TiH6CccQaRYLiI9PTflvnJeWEzraduqO8bVB
   GSMEkr06BqyA7iPc4ccx96UjK3g+bJ7NF3pvCb44G9SUgGfgmjLsGy670
   Mw0qXjAHTqnXmgQJu9/G82IkIY15NYc34QkKBXkTIRM7P+hz4J7MNi5Bh
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 21:46:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 21:46:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 21:46:49 -0800
Received: from [10.216.16.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 21:46:46 -0800
Message-ID: <75bcb661-dff2-61e5-3b31-65c4e5aeabb2@quicinc.com>
Date:   Tue, 15 Feb 2022 11:16:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 7/8] clk: qcom: Add SDX65 APCS clock controller support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <1644822247-27884-1-git-send-email-quic_rohiagar@quicinc.com>
 <20220214084839.GG3494@thinkpad>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20220214084839.GG3494@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/2022 2:18 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 14, 2022 at 12:34:07PM +0530, Rohit Agarwal wrote:
>> Add a driver for the SDX65 APCS clock controller. It is part of the APCS
>> hardware block, which among other things implements also a combined mux
>> and half integer divider functionality. The APCS clock controller has 3
>> parent clocks:
>>
>> 1. Board XO
>> 2. Fixed rate GPLL0
>> 3. A7 PLL
>>
>> This is required for enabling CPU frequency scaling on SDX65-based
>> platforms.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> I assume that the SDX65 is alomst a replica of SDX55. So why can't we use
> "qcom-sdx55-acps-clk"?
Yes. I will update the patch accordingly. Thanks
>
> Thanks,
> Mani
>
>> ---
>>   drivers/clk/qcom/Kconfig      |   9 +++
>>   drivers/clk/qcom/Makefile     |   1 +
>>   drivers/clk/qcom/apcs-sdx65.c | 130 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 140 insertions(+)
>>   create mode 100644 drivers/clk/qcom/apcs-sdx65.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 1904ba1..49e89f8 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -63,6 +63,15 @@ config QCOM_CLK_APCS_SDX55
>>   	  Say Y if you want to support CPU frequency scaling on devices
>>   	  such as SDX55.
>>   
>> +config QCOM_CLK_APCS_SDX65
>> +        tristate "SDX65 APCS Clock Controller"
>> +        depends on QCOM_APCS_IPC || COMPILE_TEST
>> +        help
>> +          Support for the APCS Clock Controller on SDX65 platform. The
>> +          APCS is managing the mux and divider which feeds the CPUs.
>> +          Say Y if you want to support CPU frequency scaling on devices
>> +          such as SDX65.
>> +
>>   config QCOM_CLK_RPM
>>   	tristate "RPM based Clock Controller"
>>   	depends on MFD_QCOM_RPM
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 3d855c1..f914f31 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_QCOM_A7PLL) += a7-pll.o
>>   obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
>>   obj-$(CONFIG_QCOM_CLK_APCC_MSM8996) += clk-cpu-8996.o
>>   obj-$(CONFIG_QCOM_CLK_APCS_SDX55) += apcs-sdx55.o
>> +obj-$(CONFIG_QCOM_CLK_APCS_SDX65) += apcs-sdx65.o
>>   obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
>>   obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
>>   obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
>> diff --git a/drivers/clk/qcom/apcs-sdx65.c b/drivers/clk/qcom/apcs-sdx65.c
>> new file mode 100644
>> index 0000000..c0cc16a
>> --- /dev/null
>> +++ b/drivers/clk/qcom/apcs-sdx65.c
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/cpu.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +
>> +#include "clk-regmap.h"
>> +#include "clk-regmap-mux-div.h"
>> +
>> +static const u32 apcs_mux_clk_parent_map[] = { 0, 1, 5 };
>> +
>> +static const struct clk_parent_data pdata[] = {
>> +	{ .fw_name = "ref" },
>> +	{ .fw_name = "aux" },
>> +	{ .fw_name = "pll" },
>> +};
>> +
>> +static int a7cc_notifier_cb(struct notifier_block *nb, unsigned long event,
>> +				void *data)
>> +{
>> +	int ret = 0;
>> +	struct clk_regmap_mux_div *md = container_of(nb,
>> +						struct clk_regmap_mux_div,
>> +						clk_nb);
>> +	if (event == PRE_RATE_CHANGE)
>> +		ret = mux_div_set_src_div(md, 1, 2);
>> +
>> +	return notifier_from_errno(ret);
>> +}
>> +
>> +static int qcom_apcs_sdx65_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device *parent = dev->parent;
>> +	struct device *cpu_dev;
>> +	struct clk_regmap_mux_div *a7cc;
>> +	struct regmap *regmap;
>> +	struct clk_init_data init = { };
>> +	int ret;
>> +
>> +	regmap = dev_get_regmap(parent, NULL);
>> +	if (!regmap) {
>> +		dev_err(dev, "Failed to get parent regmap\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	a7cc = devm_kzalloc(dev, sizeof(*a7cc), GFP_KERNEL);
>> +	if (!a7cc)
>> +		return -ENOMEM;
>> +
>> +	init.name = "a7mux";
>> +	init.parent_data = pdata;
>> +	init.num_parents = ARRAY_SIZE(pdata);
>> +	init.ops = &clk_regmap_mux_div_ops;
>> +
>> +	a7cc->clkr.hw.init = &init;
>> +	a7cc->clkr.regmap = regmap;
>> +	a7cc->reg_offset = 0x8;
>> +	a7cc->hid_width = 5;
>> +	a7cc->hid_shift = 0;
>> +	a7cc->src_width = 3;
>> +	a7cc->src_shift = 8;
>> +	a7cc->parent_map = apcs_mux_clk_parent_map;
>> +
>> +	a7cc->pclk = devm_clk_get(parent, "pll");
>> +	if (IS_ERR(a7cc->pclk))
>> +		return dev_err_probe(dev, PTR_ERR(a7cc->pclk),
>> +					 "Failed to get PLL clk\n");
>> +
>> +	a7cc->clk_nb.notifier_call = a7cc_notifier_cb;
>> +	ret = clk_notifier_register(a7cc->pclk, &a7cc->clk_nb);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +					 "Failed to register clock notifier\n");
>> +
>> +	ret = devm_clk_register_regmap(dev, &a7cc->clkr);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Failed to register regmap clock\n");
>> +		goto err;
>> +	}
>> +
>> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
>> +					&a7cc->clkr.hw);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Failed to add clock provider\n");
>> +		goto err;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, a7cc);
>> +
>> +	cpu_dev = get_cpu_device(0);
>> +	dev_pm_domain_attach(cpu_dev, true);
>> +
>> +	return 0;
>> +
>> +err:
>> +	clk_notifier_unregister(a7cc->pclk, &a7cc->clk_nb);
>> +	return ret;
>> +}
>> +
>> +static int qcom_apcs_sdx65_clk_remove(struct platform_device *pdev)
>> +{
>> +	struct device *cpu_dev = get_cpu_device(0);
>> +	struct clk_regmap_mux_div *a7cc = platform_get_drvdata(pdev);
>> +
>> +	clk_notifier_unregister(a7cc->pclk, &a7cc->clk_nb);
>> +	dev_pm_domain_detach(cpu_dev, true);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver qcom_apcs_sdx65_clk_driver = {
>> +	.probe = qcom_apcs_sdx65_clk_probe,
>> +	.remove = qcom_apcs_sdx65_clk_remove,
>> +	.driver = {
>> +		.name = "qcom-sdx65-acps-clk",
>> +	},
>> +};
>> +module_platform_driver(qcom_apcs_sdx65_clk_driver);
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Qualcomm SDX65 APCS Clock driver");
>> -- 
>> 2.7.4
>>
