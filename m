Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF560505B95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiDRPpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbiDRPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:44:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96271366A7;
        Mon, 18 Apr 2022 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650294615; x=1681830615;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sJSB7VpfTLv5eEKb58HwUIJiXvdsh69J91lsv1iTNtQ=;
  b=TK2GZ387T5KGQwrI8tCtNHXYwKD8ONhyt5AewdPCKnV2Gcsp4d4Et24I
   ciwssp+vvD5J+oGJ5TgNHSq96hpgjGnVReNoAR/G6midhs6tB5TUrIQ5J
   Fm6eh+//SnfsYlFLR0AJOQ+6uZfohH6fm0VuKgEFt76PatZ027fvmAh7K
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 08:10:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:09:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 08:09:56 -0700
Received: from [10.216.11.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 08:09:51 -0700
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH V10 6/9] mfd: pm8008: Add mfd_cell struct to register LDOs
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
 <1649939418-19861-7-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n51oHKdoLi9vgUN1qZv9UU3ipY8aNEtze=maTF8bT4NqpQ@mail.gmail.com>
Message-ID: <d17bf538-2682-dcb2-0cb2-47e9a657f8dc@quicinc.com>
Date:   Mon, 18 Apr 2022 20:39:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51oHKdoLi9vgUN1qZv9UU3ipY8aNEtze=maTF8bT4NqpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2022 5:53 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-04-14 05:30:15)
>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>> index ca5240d..ab4ba55 100644
>> --- a/drivers/mfd/qcom-pm8008.c
>> +++ b/drivers/mfd/qcom-pm8008.c
>> @@ -282,6 +287,14 @@ static int pm8008_probe(struct i2c_client *client)
>>          }
>>          gpiod_set_value(chip->reset_gpio, 1);
>>
>> +       rc = devm_mfd_add_devices(&chip->clients[PM8008_REGULATORS_SID]->dev,
>> +                       0, pm8008_regulator_devs, ARRAY_SIZE(pm8008_regulator_devs),
>> +                       NULL, 0, NULL);
>> +       if (rc) {
>> +               dev_err(chip->dev, "Failed to add regulators: %d\n", rc);
>> +               return rc;
>> +       }
>> +
>>          return devm_of_platform_populate(chip->dev);
> Can we just use devm_of_platform_populate()? Then have a compatible =
> "qcom,pm8008-regulators" that binds with the regulator platform driver
> and searches for the named regmap for the second i2c client.


On earlier versions we had a separate compatible for regulator driver, I 
had to drop it as per Mark's suggestions here [1], [2].


If Mark is OK with adding a separate compatible, I can add it back.


[1] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com/#24618011

[2] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com/#24692220


