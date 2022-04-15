Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34459502ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347114AbiDOSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346923AbiDOSso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:48:44 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF5E66616;
        Fri, 15 Apr 2022 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650048377; x=1681584377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6AihOBayjwF4Y0LfejNPmko6lmJpTqxnq7TwMwhNVPw=;
  b=WkskxvY49E2wmEUsfkd+w8rpaBFHhIkC6tP+Y/MdOskAz3MwkU6igLsQ
   /Q9bY9SLufm97u4bq5mjUWeNZA8+dSs/vTq/OcFMKSn9zMGnXkDooO2Yb
   SU/H6uDEPao27+IaWVpzz24Z0cxm7eqi425c71kObJQUNUpoP92k3uTKz
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Apr 2022 11:46:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 11:46:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Apr 2022 11:46:14 -0700
Received: from [10.110.117.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Apr
 2022 11:46:13 -0700
Message-ID: <773e7150-e7e8-e8f5-f25f-c61fcb3ac457@quicinc.com>
Date:   Fri, 15 Apr 2022 11:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 3/5] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <dmitry.torokhov@gmail.com>, <corbet@lwn.net>, <sre@kernel.org>,
        <robh+dt@kernel.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <swboyd@chromium.org>, <skakit@codeaurora.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20220411200506.22891-1-quic_amelende@quicinc.com>
 <20220411200506.22891-4-quic_amelende@quicinc.com>
 <d9afa206-7f57-81bb-8c69-5928dccd41b5@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <d9afa206-7f57-81bb-8c69-5928dccd41b5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2022 2:18 PM, Dmitry Baryshkov wrote:
> On 11/04/2022 23:05, Anjelique Melendez wrote:
>> Currently, PON address is read from the "reg" property. For PON GEN3,
>> which starts with PMK8350, the "reg" property will have both the PON
>> HLOS and PON PBS addesses defined. Add support so that all PON
>> generations can be configured.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>   drivers/input/misc/pm8941-pwrkey.c | 31 +++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>> index e0240db12d4f..43106e4cfd23 100644
>> --- a/drivers/input/misc/pm8941-pwrkey.c
>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/log2.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_address.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/reboot.h>
>> @@ -44,6 +45,7 @@ struct pm8941_data {
>>       unsigned int    status_bit;
>>       bool        supports_ps_hold_poff_config;
>>       bool        supports_debounce_config;
>> +    bool        has_pon_pbs;
>>       const char    *name;
>>       const char    *phys;
>>   };
>> @@ -52,6 +54,7 @@ struct pm8941_pwrkey {
>>       struct device *dev;
>>       int irq;
>>       u32 baseaddr;
>> +    u32 pon_pbs_baseaddr;
>>       struct regmap *regmap;
>>       struct input_dev *input;
>>   @@ -167,6 +170,8 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>       struct pm8941_pwrkey *pwrkey;
>>       bool pull_up;
>>       struct device *parent;
>> +    struct device_node *regmap_node;
>> +    const __be32 *addr;
>>       u32 req_delay;
>>       int error;
>>   @@ -188,8 +193,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>       pwrkey->data = of_device_get_match_data(&pdev->dev);
>>         parent = pdev->dev.parent;
>> +    regmap_node = pdev->dev.of_node;
>>       pwrkey->regmap = dev_get_regmap(parent, NULL);
>>       if (!pwrkey->regmap) {
>> +        regmap_node = parent->of_node;
>>           /*
>>            * We failed to get regmap for parent. Let's see if we are
>>            * a child of pon node and read regmap and reg from its
>> @@ -200,15 +207,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>               dev_err(&pdev->dev, "failed to locate regmap\n");
>>               return -ENODEV;
>>           }
>> +    }
>>   -        error = of_property_read_u32(parent->of_node,
>> -                         "reg", &pwrkey->baseaddr);
>> -    } else {
>> -        error = of_property_read_u32(pdev->dev.of_node, "reg",
>> -                         &pwrkey->baseaddr);
>> +    addr = of_get_address(regmap_node, 0, NULL, NULL);
>> +    if (!addr) {
>> +        dev_err(&pdev->dev, "reg property missing\n");
>> +        return -EINVAL;
>> +    }
>> +    pwrkey->baseaddr = be32_to_cpup(addr);
>> +
>> +    if (pwrkey->data->has_pon_pbs) {
>> +        /* PON_PBS base address is optional */
>> +        addr = of_get_address(regmap_node, 1, NULL, NULL);
>> +        if (addr)
>> +            pwrkey->pon_pbs_baseaddr = be32_to_cpup(addr);
>>       }
>> -    if (error)
>> -        return error;
>>         pwrkey->irq = platform_get_irq(pdev, 0);
>>       if (pwrkey->irq < 0)
>> @@ -316,6 +329,7 @@ static const struct pm8941_data pwrkey_data = {
>>       .phys = "pm8941_pwrkey/input0",
>>       .supports_ps_hold_poff_config = true,
>>       .supports_debounce_config = true,
>> +    .has_pon_pbs = false,
>>   };
>>     static const struct pm8941_data resin_data = {
>> @@ -325,6 +339,7 @@ static const struct pm8941_data resin_data = {
>>       .phys = "pm8941_resin/input0",
>>       .supports_ps_hold_poff_config = true,
>>       .supports_debounce_config = true,
>> +    .has_pon_pbs = false,
> 
> No need to declare that a field is false. Just skip this completely.
ACK. Will get rid in next version.
> 
>>   };
>>     static const struct pm8941_data pon_gen3_pwrkey_data = {
>> @@ -333,6 +348,7 @@ static const struct pm8941_data pon_gen3_pwrkey_data = {
>>       .phys = "pmic_pwrkey/input0",
>>       .supports_ps_hold_poff_config = false,
>>       .supports_debounce_config = false,
>> +    .has_pon_pbs = true,
>>   };
>>     static const struct pm8941_data pon_gen3_resin_data = {
>> @@ -341,6 +357,7 @@ static const struct pm8941_data pon_gen3_resin_data = {
>>       .phys = "pmic_resin/input0",
>>       .supports_ps_hold_poff_config = false,
>>       .supports_debounce_config = false,
>> +    .has_pon_pbs = true,
>>   };
>>     static const struct of_device_id pm8941_pwr_key_id_table[] = {
> 
> 
