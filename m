Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256155B772
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiF0FIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 01:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiF0FIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:08:41 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15332DC3;
        Sun, 26 Jun 2022 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656306520; x=1687842520;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Sw1KTVkqveRatJqsRHyJilac0Q0XsQzusp80Ox1oQaI=;
  b=sd2xV2r1xorymCN3iZIofzEcR4hET98eF6qGtvt1bBGQuvq7P8yFAzpn
   B5Dq6BqOtrKX0nk+h23sjV9rhvABoitkVeNMdwI0TOSfIm40UfGBBOYh2
   mZGnk5ixZIy1tZpU6+XuHivnZx5kccKOCbiOxBrgEQ3tXontXhPc1Ds0V
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jun 2022 22:07:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 22:07:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 26 Jun 2022 22:07:39 -0700
Received: from [10.50.51.171] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 26 Jun
 2022 22:07:34 -0700
Message-ID: <503f1a8b-eadb-d3a6-6e24-d60437f778b6@quicinc.com>
Date:   Mon, 27 Jun 2022 10:37:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Content-Language: en-US
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
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
 <eccbb030-97f7-3a6c-958e-05adcdca6210@quicinc.com>
 <YrAt6dq6ty9p8d05@google.com>
 <a11732d6-a9b1-7ead-e89a-564a57a7192b@quicinc.com>
In-Reply-To: <a11732d6-a9b1-7ead-e89a-564a57a7192b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Lee,


On 6/20/2022 4:37 PM, Satya Priya Kakitapalli (Temp) wrote:
>
> On 6/20/2022 1:50 PM, Lee Jones wrote:
>> On Mon, 20 Jun 2022, Satya Priya Kakitapalli (Temp) wrote:
>>
>>> On 6/17/2022 2:27 AM, Lee Jones wrote:
>>>> On Tue, 14 Jun 2022, Satya Priya wrote:
>>>>
>>>>> Use i2c_new_dummy_device() to register pm8008-regulator
>>>>> client present at a different address space, instead of
>>>>> defining a separate DT node. This avoids calling the probe
>>>>> twice for the same chip, once for each client pm8008-infra
>>>>> and pm8008-regulator.
>>>>>
>>>>> As a part of this define pm8008_regmap_init() to do regmap
>>>>> init for both the clients and define pm8008_get_regmap() to
>>>>> pass the regmap to the regulator driver.
>>>>>
>>>>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>>>>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>>>> ---
>>>>> Changes in V15:
>>>>>    - None.
>>>>>
>>>>> Changes in V14:
>>>>>    - None.
>>>>>
>>>>> Changes in V13:
>>>>>    - None.
>>>>>
>>>>>    drivers/mfd/qcom-pm8008.c       | 34 
>>>>> ++++++++++++++++++++++++++++++++--
>>>>>    include/linux/mfd/qcom_pm8008.h |  9 +++++++++
>>>>>    2 files changed, 41 insertions(+), 2 deletions(-)
>>>>>    create mode 100644 include/linux/mfd/qcom_pm8008.h
>>>>>
>>>>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>>>>> index 569ffd50..55e2a8e 100644
>>>>> --- a/drivers/mfd/qcom-pm8008.c
>>>>> +++ b/drivers/mfd/qcom-pm8008.c
>>>>> @@ -9,6 +9,7 @@
>>>>>    #include <linux/interrupt.h>
>>>>>    #include <linux/irq.h>
>>>>>    #include <linux/irqdomain.h>
>>>>> +#include <linux/mfd/qcom_pm8008.h>
>>>>>    #include <linux/module.h>
>>>>>    #include <linux/of_device.h>
>>>>>    #include <linux/of_platform.h>
>>>>> @@ -57,6 +58,7 @@ enum {
>>>>>    struct pm8008_data {
>>>>>        struct device *dev;
>>>>> +    struct regmap *regulators_regmap;
>>>>>        int irq;
>>>>>        struct regmap_irq_chip_data *irq_data;
>>>>>    };
>>>>> @@ -150,6 +152,12 @@ static struct regmap_config 
>>>>> qcom_mfd_regmap_cfg = {
>>>>>        .max_register    = 0xFFFF,
>>>>>    };
>>>>> +struct regmap *pm8008_get_regmap(const struct pm8008_data *chip)
>>>>> +{
>>>>> +    return chip->regulators_regmap;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(pm8008_get_regmap);
>>>> Seems like abstraction for the sake of abstraction.
>>>>
>>>> Why not do the dereference inside the regulator driver?
>>> To derefer this in the regulator driver, we need to have the 
>>> pm8008_data
>>> struct definition in the qcom_pm8008 header file.
>>>
>>> I think it doesn't look great to have only that structure in header 
>>> and all
>>> other structs and enum in the mfd driver.
>> Then why pass 'pm8008_data' at all?
>
>
> There is one more option, instead of passing the pm8008_data, we could 
> pass the pdev->dev.parent and get the pm8008 chip data directly in the 
> pm8008_get_regmap() like below
>
>
> struct regmap *pm8008_get_regmap(const struct device *dev)
>  {
>      const struct pm8008_data *chip = dev_get_drvdata(dev);
>
>      return chip->regulators_regmap;
> }
> EXPORT_SYMBOL_GPL(pm8008_get_regmap);
>
>
> By doing this we can avoid having declaration of pm8008_data also in 
> the header. Please let me know if this looks good.
>

Could you please confirm on this?


>> What's preventing you from passing 'regmap'?
>
>
> I didn't get what you meant here, could you please elaborate a bit?
>
>
