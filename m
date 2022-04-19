Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EB0506425
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348750AbiDSGH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiDSGHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:07:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D592DA8D;
        Mon, 18 Apr 2022 23:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650348282; x=1681884282;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QNj4Qn4ezbBX3zFQ3A72Of9ZJf1vQLPoSRnUt1x+JnU=;
  b=nPI6jT6YX6MSGuowSFxjCso2q7KajeawQs+3DcRjGUp2pZf5xwTDKaXu
   LTddZYl5SLicBcv3Pjtgb6+uj8tsqbUjMy2JuRITUUqes+/2maODmCEBh
   uAfwdLP1UQKFYPhc8g8qJUAP+JKMhS51QPAWLEwy3RCXr0LLxcRHszx5N
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Apr 2022 23:04:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 23:04:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 23:04:40 -0700
Received: from [10.216.28.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 23:04:36 -0700
Subject: Re: [PATCH V10 5/9] mfd: pm8008: Use i2c_new_dummy_device() API
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-6-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n531GVMuuR6HM2ezjOPJCg7S-rD3eaEKWzrYsnM-jwQHKw@mail.gmail.com>
 <9d8543e1-4aa8-f430-322a-83d110586152@quicinc.com>
 <CAE-0n51Bs=87+LpDFHBJXqM7VwR4nBtBkG5iasnCKKw4CRdRZg@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <2514f361-fdce-0b4d-0af7-24b3f16e2add@quicinc.com>
Date:   Tue, 19 Apr 2022 11:34:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51Bs=87+LpDFHBJXqM7VwR4nBtBkG5iasnCKKw4CRdRZg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/2022 12:53 AM, Stephen Boyd wrote:
> Quoting Satya Priya Kakitapalli (Temp) (2022-04-18 08:08:33)
>> On 4/15/2022 5:51 AM, Stephen Boyd wrote:
>>> Quoting Satya Priya (2022-04-14 05:30:14)
>>>> Use i2c_new_dummy_device() to register clients along with
>>>> the main mfd device.
>>> Why?
>>
>> As discussed on V9 of this series, I've done these changes.
>>
>> By using this API we can register other clients at different address
>> space without having separate DT node.
>>
>> This avoids calling the probe twice for the same chip, once for each
>> address space 0x8 and 0x9. I'll add this description in commit text.
>>
> Perfect, thanks.
>
>>>> @@ -221,19 +236,38 @@ static int pm8008_probe_irq_peripherals(struct pm8008_data *chip,
>>>>
>>>>    static int pm8008_probe(struct i2c_client *client)
>>>>    {
>>>> -       int rc;
>>>> +       int rc, i;
>>>>           struct pm8008_data *chip;
>>>> +       struct device_node *node = client->dev.of_node;
>>>>
>>>>           chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>>>>           if (!chip)
>>>>                   return -ENOMEM;
>>>>
>>>>           chip->dev = &client->dev;
>>>> -       chip->regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg);
>>>> -       if (!chip->regmap)
>>>> -               return -ENODEV;
>>>>
>>>> -       i2c_set_clientdata(client, chip);
>>>> +       for (i = 0; i < PM8008_NUM_CLIENTS; i++) {
>>> This is 2. Why do we have a loop? Just register the i2c client for
>>> pm8008_infra first and then make a dummy for the second address without
>>> the loop and the indentation. Are there going to be more i2c clients?
>>
>> There wont be more than 2 clients, I can remove the loop, but then we
>> will have repetitive code.. something like below
> Repetitive code can be refactored into a subroutine.
>
>>        chip->dev = &client->dev;
>>        i2c_set_clientdata(client, chip);
>>
>>        regmap = devm_regmap_init_i2c(client, &qcom_mfd_regmap_cfg[0]);
>>        if (!regmap)
>>            return -ENODEV;
>>
>>
>>        pm8008_client = i2c_new_dummy_device(client->adapter,
>>                                client->addr + 1);
>>        if (IS_ERR(pm8008_client)) {
>>            dev_err(&pm8008_client->dev, "can't attach client\n");
>>            return PTR_ERR(pm8008_client);
>>        }
>>        pm8008_client->dev.of_node = of_node_get(client->dev.of_node);
>>        i2c_set_clientdata(pm8008_client, chip);
>>
>>        regulators_regmap = devm_regmap_init_i2c(pm8008_client,
>> &qcom_mfd_regmap_cfg[1]);
>>        if (!regmap)
>>            return -ENODEV;
>>
>>>> diff --git a/include/linux/mfd/qcom_pm8008.h b/include/linux/mfd/qcom_pm8008.h
>>>> new file mode 100644
>>>> index 0000000..bc64f01
>>>> --- /dev/null
>>>> +++ b/include/linux/mfd/qcom_pm8008.h
>>>> @@ -0,0 +1,13 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#ifndef __QCOM_PM8008_H__
>>>> +#define __QCOM_PM8008_H__
>>>> +
>>>> +#define PM8008_INFRA_SID       0
>>>> +#define PM8008_REGULATORS_SID  1
>>>> +
>>>> +#define PM8008_NUM_CLIENTS     2
>>>> +
>>>> +struct pm8008_data;
>>>> +struct regmap *pm8008_get_regmap(struct pm8008_data *chip, u8 sid);
>>> Could this be avoided if the regulator driver used
>>> dev_get_regmap(&pdev->dev.parent, "regulator") to find the regmap named
>>> "regulator" of the parent device, i.e. pm8008-infra.
>> I gave it a try, it didn't work. I could not get the regmap for
>> regulators using pm8008-infra i.e., 0x8 device pointer.
> Did it not work because the regmap config for the regulator config
> didn't have a name?


No I specified the name "regulators" in the regmap_config struct for 
regulator config.


