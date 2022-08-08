Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D1258C42F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbiHHHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiHHHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:36:50 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE1120BC;
        Mon,  8 Aug 2022 00:36:44 -0700 (PDT)
Received: from [10.88.19.200] (10.88.19.200) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.6; Mon, 8 Aug 2022
 15:36:39 +0800
Message-ID: <0431a041-17b8-39d5-ed03-3036d556ec05@amlogic.com>
Date:   Mon, 8 Aug 2022 15:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v4 1/4] perf/amlogic: Add support for Amlogic meson G12
 SoC DDR PMU driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
 <3597d068-2c44-9450-4a0c-4704f3639a37@linaro.org>
 <4119d339-0570-2132-3e9f-19ec45ef6e8d@amlogic.com>
 <eb153484-6216-c4bd-deb2-c25e177b2d59@linaro.org>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <eb153484-6216-c4bd-deb2-c25e177b2d59@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.88.19.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/8 13:42, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 05/08/2022 11:55, Jiucheng Xu wrote:
>>>> +static int __init g12_ddr_pmu_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct ddr_pmu *pmu;
>>>> +
>>>> +	if (of_device_is_compatible(pdev->dev.of_node,
>>>> +				    "amlogic,g12a-ddr-pmu")) {
>>>> +		format_attr_nna.attr.mode = 0;
>>>> +		format_attr_gdc.attr.mode = 0;
>>>> +		format_attr_arm1.attr.mode = 0;
>>>> +		format_attr_mipi_isp.attr.mode = 0;
>>> No. That's not correct patter. You must use variant specific driver data.
>> Do you mean use of_device_id.data? Could your please give me an
>>
>> example code in kernel source?
> 90% of Linux kernel drivers?
>
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,g12a-ddr-pmu",
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,g12b-ddr-pmu",
>>>> +	},
>>>> +	{
>>>> +		.compatible = "amlogic,sm1-ddr-pmu",
>>> Why four different entries for the same devices without driver data?
>>> This is confusing.
>> Do you mean use a common compatible and different driver data?
> What I meant is that current version this is useless and confusing.
> Different devices have different compatibles with different driver data.
> Same devices have just the same compatible (so same driver data). You
> mixed two different approaches.

Does the driver data must be necessary? Although G12A, G12B and SM1 are 
different devices,

but they have the same control interface. The only difference is that 
G12B has

4 extra modules be supported than G12A.

>
>>>> +	},
>>>> +	{}
>>>> +};
>>>> +
>>>> +static struct platform_driver g12_ddr_pmu_driver = {
>>>> +	.driver = {
>>>> +		.name = "amlogic,ddr-pmu",
>>>> +		.of_match_table = meson_ddr_pmu_dt_match,
>>>> +	},
>>>> +	.remove = __exit_p(g12_ddr_pmu_remove),
>>> You made the driver non-hotpluggable - why?
>>> In the same time it is still unbindable, whis is a bit confusing. If you
>>> can unbind it, you should be able to hot-unplug it.
>> Sorry, I couldn't know why the driver is non-hotpluggable. Could you
>> tell the detail?
> You used module_platform_driver_probe, so the one with documentation:
>   /* non-hotpluggable platform devices may use this so that probe() and
>
>    * its support may live in __init sections, conserving runtime memory.
>
>    */

Okay, module_platform_driver_probe（) was suggested by Robin Murphy 
<robin.murphy@arm.com>,

but you gave the reason. module_platform_driver() is okay?

>
>
>>>> +};
>>>> +
>>>> +module_platform_driver_probe(g12_ddr_pmu_driver, g12_ddr_pmu_probe);
>>>> +MODULE_AUTHOR("Jiucheng Xu");
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_DESCRIPTION("Amlogic G12 series SoC DDR PMU");
>>>> diff --git a/include/soc/amlogic/meson_ddr_pmu.h b/include/soc/amlogic/meson_ddr_pmu.h
>>>> new file mode 100644
>>>> index 000000000000..882efe3c2f58
>>>> --- /dev/null
>>>> +++ b/include/soc/amlogic/meson_ddr_pmu.h
>>>> @@ -0,0 +1,76 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#ifndef __MESON_DDR_PMU_H__
>>>> +#define __MESON_DDR_PMU_H__
>>>> +
>>>> +#define MAX_CHANNEL_NUM		8
>>>> +
>>>> +enum {
>>>> +	ALL_CHAN_COUNTER_ID,
>>>> +	CHAN1_COUNTER_ID,
>>>> +	CHAN2_COUNTER_ID,
>>>> +	CHAN3_COUNTER_ID,
>>>> +	CHAN4_COUNTER_ID,
>>>> +	CHAN5_COUNTER_ID,
>>>> +	CHAN6_COUNTER_ID,
>>>> +	CHAN7_COUNTER_ID,
>>>> +	CHAN8_COUNTER_ID,
>>>> +	COUNTER_MAX_ID,
>>>> +};
>>>> +
>>>> +struct dmc_hw_info;
>>>> +
>>>> +struct dmc_counter {
>>>> +	u64 all_cnt;	/* The count of all requests come in/out ddr controller */
>>>> +	union {
>>>> +		u64 all_req;
>>>> +		struct {
>>>> +			u64 all_idle_cnt;
>>>> +			u64 all_16bit_cnt;
>>>> +		};
>>>> +	};
>>>> +	u64 channel_cnt[MAX_CHANNEL_NUM]; /* To save a DMC bandwidth-monitor channel counter */
>>>> +};
>>>> +
>>>> +struct dmc_pmu_hw_ops {
>>>> +	void (*enable)(struct dmc_hw_info *info);
>>>> +	void (*disable)(struct dmc_hw_info *info);
>>>> +	/* Bind an axi line to a bandwidth-monitor channel */
>>>> +	void (*config_axi_id)(struct dmc_hw_info *info, int axi_id, int chann);
>>>> +	int (*irq_handler)(struct dmc_hw_info *info,
>>>> +			   struct dmc_counter *counter);
>>>> +	void (*get_counters)(struct dmc_hw_info *info,
>>>> +			     struct dmc_counter *counter);
>>>> +};
>>>> +
>>>> +struct dmc_hw_info {
>>>> +	struct dmc_pmu_hw_ops *ops;
>>>> +	void __iomem *ddr_reg[4];
>>>> +	unsigned long timer_value;	/* Timer value in TIMER register */
>>>> +	void __iomem *pll_reg;
>>>> +	int irq_num;			/* irq vector number */
>>>> +	int dmc_nr;			/* The number of dmc controller */
>>>> +	int chann_nr;			/* The number of dmc bandwidth monitor channels */
>>>> +	int id;				/* The number of supported channels */
>>>> +	struct attribute **fmt_attr;
>>>> +};
>>>> +
>>>> +struct ddr_pmu {
>>>> +	struct pmu pmu;
>>>> +	struct dmc_hw_info info;
>>>> +	struct dmc_counter counters;	/* save counters from hw */
>>>> +	bool pmu_enabled;
>>>> +	struct device *dev;
>>>> +	char *name;
>>>> +	struct hlist_node node;
>>>> +	enum cpuhp_state cpuhp_state;
>>>> +	int cpu;			/* for cpu hotplug */
>>>> +};
>>> Linux-wide headers should not include your private data structures.
>>> Entier header looks unused - should be made private.
>> Do you mean the header should be in driver dir, or the structures should
>> be within .c file?
> This or that, up to you. Definitely not in include/linux/.

I see other PMU drivers' header are in include/soc/xxx/. I just follow them.

meson G12 series SoC DDR PMU driver is the first PMU driver got upstream,

and other series will be got upstream in the future. So I think the 
structures are public.

Does this make sense?

>
>
> Best regards,
> Krzysztof
>
-- 
Thanks,
Jiucheng

