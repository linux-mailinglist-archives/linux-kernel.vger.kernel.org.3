Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53804B22DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348823AbiBKKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:12:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348813AbiBKKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:12:46 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D1192;
        Fri, 11 Feb 2022 02:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644574365; x=1676110365;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UXk5xgeQ8ec7mH4xeCgAgi+Mh3XuQttyFuGdgXBTyBY=;
  b=OmbULxYJnsslG5dJWx8nYR+fjdkTO5A4tGWzUns1x9oJSVyfzRhcb5ZZ
   RJWq4hopz9JC4mV85rm2bQgk4UxsD0KqOFI+V9orLyNXxWvTM1KHot5Jm
   rzfcZi1JcITeUlge28vLuamAFMvHabn8zkbZskQ8WPUSIiy7OlJdu2uAr
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 02:12:45 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:12:45 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 02:12:39 -0800
Subject: Re: [PATCH V5 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-4-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52B4heY5fcbz71JPOqvMVvmqsXO94V+Z0qTTw_XXextJw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <bd5636b0-b975-1084-f285-87e458249b1a@quicinc.com>
Date:   Fri, 11 Feb 2022 15:42:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52B4heY5fcbz71JPOqvMVvmqsXO94V+Z0qTTw_XXextJw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 2/10/2022 7:02 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-02-08 06:52:17)
>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>> index c472d7f..e8569cc 100644
>> --- a/drivers/mfd/qcom-pm8008.c
>> +++ b/drivers/mfd/qcom-pm8008.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/irq.h>
>>   #include <linux/irqdomain.h>
>> +#include <linux/mfd/core.h>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_platform.h>
>> @@ -27,6 +28,37 @@
>>   #define INT_EN_CLR_OFFSET              0x16
>>   #define INT_LATCHED_STS_OFFSET         0x18
>>
>> +static const struct mfd_cell pm8008_regulator_devs[] = {
> Is there some way to not allocate this structure statically forever?


I think No.

I found that some of the drivers are just using one cell with .name to 
match with regulator driver and then probing regulators using a loop. 
I'll do that too.

static const struct mfd_cell pm8008_regulator_devs[] = {
         {
                 .name = "qcom,pm8008-regulators",
         },
  };

>> +       {
>> +               .name = "qcom,pm8008-regulators",
>> +               .id = 0,
>> +       },
>> +       {
>> +               .name = "qcom,pm8008-regulators",
>> +               .id = 1,
>> +       },
>> +       {
>> +               .name = "qcom,pm8008-regulators",
>> +               .id = 2,
>> +       },
>> +       {
>> +               .name = "qcom,pm8008-regulators",
>> +               .id = 3,
>> +       },
>> +       {
>> +               .name = "qcom,pm8008-regulators",
>> +               .id = 4,
>> +       },
>> +       {
>> +               .name = "qcom,pm8008-regulators",
>> +               .id = 5,
>> +       },
>> +       {
>> +               .name = "qcom,pm8008-regulators",
>> +               .id = 6,
>> +       },
>> +};
>> +
>>   enum {
>>          PM8008_MISC,
>>          pm8008_temp_alarm,
>> @@ -35,6 +67,17 @@ enum {
>>          PM8008_NUM_PERIPHS,
>>   };
>>
>> +enum {
>> +       PM8008_INFRA,
>> +       PM8008_REGULATORS,
>> +};
>> +
>> +static const struct of_device_id pm8008_match[] = {
>> +       { .compatible = "qcom,pm8008", .data = (void *)PM8008_INFRA},
>> +       { .compatible = "qcom,pm8008-regulators", .data = (void *)PM8008_REGULATORS},
>> +       { },
> Nitpick: Drop , on {} so nothing can come after without causing compile
> error.


Okay.


>> +};
>> +
>>   #define PM8008_PERIPH_0_BASE   0x900
>>   #define PM8008_PERIPH_1_BASE   0x2400
>>   #define PM8008_PERIPH_2_BASE   0xC000
>> @@ -221,6 +264,7 @@ static int pm8008_probe(struct i2c_client *client)
>>   {
>>          int rc;
>>          struct pm8008_data *chip;
>> +       const struct of_device_id *id;
>>
>>          chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>>          if (!chip)
>> @@ -239,14 +283,19 @@ static int pm8008_probe(struct i2c_client *client)
>>                          dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
>>          }
>>
>> +       id = of_match_node(pm8008_match, chip->dev->of_node);
> Use device_get_match_data()? And then use (uintptr_t) casts to check for
> the enum? Using device_get_match_data() allows us to avoid moving the
> pm8008_match table.


Okay.


>> +       if (id->data == (void *)PM8008_REGULATORS) {
> 	enum <your_name_here> dev_type = device_get_match_data(dev);
>
> 	if (dev_type == PM8008_REGULATORS)
>
>> +               rc = mfd_add_devices(chip->dev, 0, pm8008_regulator_devs,
> Why not devm_mfd_add_devices()?


Okay.


>> +                               ARRAY_SIZE(pm8008_regulator_devs), NULL, 0, NULL);
>> +               if (rc) {
>> +                       dev_err(chip->dev, "Failed to add children: %d\n", rc);
>> +                       return rc;
>> +               }
>> +       }
>> +
>>          return devm_of_platform_populate(chip->dev);
>>   }
>>
>> -static const struct of_device_id pm8008_match[] = {
>> -       { .compatible = "qcom,pm8008", },
>> -       { },
>> -};
> This should have a MODULE_DEVICE_TABLE(of, pm8008_match) here.


Okay.


>> -
>>   static struct i2c_driver pm8008_mfd_driver = {
>>          .driver = {
>>                  .name = "pm8008",
