Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B264550FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiFTF2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTF2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:28:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8C65E0;
        Sun, 19 Jun 2022 22:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655702914; x=1687238914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T7T+kDGwEa3D8uh0wfPSGFas0nzg7PYcxffUQVD9kqs=;
  b=sZD2VYHHsatuNQ3uhSSFxiKvXmfyy0j9tFUjzy+Tpiyt3UDvhmjCZDVG
   ghT7ZJiCtMdi9tvDVK4YXcYB917gd40J8e0S2AQ1NuwXI9qZAYjnBG9sh
   Tkynh31jHtYNAcixACWHicY+TixdsQNIIrjp624hgNcLyAXFaJrfQLSSF
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Jun 2022 22:28:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 22:28:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 19 Jun 2022 22:28:32 -0700
Received: from [10.50.53.124] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 19 Jun
 2022 22:28:28 -0700
Message-ID: <eccbb030-97f7-3a6c-958e-05adcdca6210@quicinc.com>
Date:   Mon, 20 Jun 2022 10:58:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655200111-18357-7-git-send-email-quic_c_skakit@quicinc.com>
 <YquZRcuRCrdF+Q1z@google.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <YquZRcuRCrdF+Q1z@google.com>
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


On 6/17/2022 2:27 AM, Lee Jones wrote:
> On Tue, 14 Jun 2022, Satya Priya wrote:
>
>> Use i2c_new_dummy_device() to register pm8008-regulator
>> client present at a different address space, instead of
>> defining a separate DT node. This avoids calling the probe
>> twice for the same chip, once for each client pm8008-infra
>> and pm8008-regulator.
>>
>> As a part of this define pm8008_regmap_init() to do regmap
>> init for both the clients and define pm8008_get_regmap() to
>> pass the regmap to the regulator driver.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>> Changes in V15:
>>   - None.
>>
>> Changes in V14:
>>   - None.
>>
>> Changes in V13:
>>   - None.
>>
>>   drivers/mfd/qcom-pm8008.c       | 34 ++++++++++++++++++++++++++++++++--
>>   include/linux/mfd/qcom_pm8008.h |  9 +++++++++
>>   2 files changed, 41 insertions(+), 2 deletions(-)
>>   create mode 100644 include/linux/mfd/qcom_pm8008.h
>>
>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>> index 569ffd50..55e2a8e 100644
>> --- a/drivers/mfd/qcom-pm8008.c
>> +++ b/drivers/mfd/qcom-pm8008.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/irq.h>
>>   #include <linux/irqdomain.h>
>> +#include <linux/mfd/qcom_pm8008.h>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_platform.h>
>> @@ -57,6 +58,7 @@ enum {
>>   
>>   struct pm8008_data {
>>   	struct device *dev;
>> +	struct regmap *regulators_regmap;
>>   	int irq;
>>   	struct regmap_irq_chip_data *irq_data;
>>   };
>> @@ -150,6 +152,12 @@ static struct regmap_config qcom_mfd_regmap_cfg = {
>>   	.max_register	= 0xFFFF,
>>   };
>>   
>> +struct regmap *pm8008_get_regmap(const struct pm8008_data *chip)
>> +{
>> +	return chip->regulators_regmap;
>> +}
>> +EXPORT_SYMBOL_GPL(pm8008_get_regmap);
> Seems like abstraction for the sake of abstraction.
>
> Why not do the dereference inside the regulator driver?


To derefer this in the regulator driver, we need to have the pm8008_data 
struct definition in the qcom_pm8008 header file.

I think it doesn't look great to have only that structure in header and 
all other structs and enum in the mfd driver.


>>   static int pm8008_init(struct regmap *regmap)
>>   {
>>   	int rc;
>> @@ -217,11 +225,25 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>>   	return 0;
>>   }
>>   
>> +static struct regmap *pm8008_regmap_init(struct i2c_client *client,
>> +							struct pm8008_data *chip)
>> +{
>> +	struct regmap *regmap;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
>> +	if (!regmap)
>> +		return NULL;
>> +
>> +	i2c_set_clientdata(client, chip);
>> +	return regmap;
>> +}
> This function seems superfluous.
>
> It's only called once and it contains a single call.


No, It is being called twice. To avoid repetitive code, I've added this 
subroutine.


> Just pop the call directly into probe.
>
>>   static int pm8008_probe(struct i2c_client *client)
>>   {
>>   	int rc;
>>   	struct pm8008_data *chip;
>>   	struct gpio_desc *reset_gpio;
>> +	struct i2c_client *regulators_client;
>>   	struct regmap *regmap;
>>   
>>   	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>> @@ -229,11 +251,19 @@ static int pm8008_probe(struct i2c_client *client)
>>   		return -ENOMEM;
>>   
>>   	chip->dev = &client->dev;
>> -	regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
>> +	regmap = pm8008_regmap_init(client, chip);
>>   	if (!regmap)
>>   		return -ENODEV;
>>   
>> -	i2c_set_clientdata(client, chip);
>> +	regulators_client = i2c_new_dummy_device(client->adapter, client->addr + 1);
>> +	if (IS_ERR(regulators_client)) {
>> +		dev_err(&client->dev, "can't attach client\n");
>> +		return PTR_ERR(regulators_client);
>> +	}
>> +
>> +	chip->regulators_regmap = pm8008_regmap_init(regulators_client, chip);
>> +	if (!chip->regulators_regmap)
>> +		return -ENODEV;
>>   
>>   	reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_LOW);
>>   	if (IS_ERR(reset_gpio))
>> diff --git a/include/linux/mfd/qcom_pm8008.h b/include/linux/mfd/qcom_pm8008.h
>> new file mode 100644
>> index 0000000..3814bff
>> --- /dev/null
>> +++ b/include/linux/mfd/qcom_pm8008.h
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +// Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> +#ifndef __QCOM_PM8008_H__
>> +#define __QCOM_PM8008_H__
>> +
>> +struct pm8008_data;
>> +struct regmap *pm8008_get_regmap(const struct pm8008_data *chip);
>> +
>> +#endif
