Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0C504C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiDRFHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDRFHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:07:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F313EA5;
        Sun, 17 Apr 2022 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650258277; x=1681794277;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZMG6fm2lkB7RZ8Q28HhGEgjCp9U5LmWS+t5nYwhSo0c=;
  b=otGsnRQLOF13q1K4xmrT50sxMV6lW5U8bMQCswjLQQ42dk8eqXQ3/OJI
   f7m39L8JVGYZ1QMFwOYVjbTyvXpmhqe1oOovvgk3opvvYgoYqEvtTzE6i
   L4oL6qk7KJjlYpw6EQsNSrTsET/iah5Z2BxQa+xEy1ie6XXFcyuYDAv1J
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Apr 2022 22:04:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 22:04:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 17 Apr 2022 22:04:34 -0700
Received: from [10.216.41.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 17 Apr
 2022 22:04:29 -0700
Subject: Re: [PATCH V10 4/9] mfd: pm8008: Add reset-gpios
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
 <1649939418-19861-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n50HR6w-v3ub8HR_K2PsqqTTrVAaQa0pZ7QjY39WmkDyQQ@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <010bd223-94a0-fe8c-d1ab-39153bb68a7d@quicinc.com>
Date:   Mon, 18 Apr 2022 10:34:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50HR6w-v3ub8HR_K2PsqqTTrVAaQa0pZ7QjY39WmkDyQQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2022 5:40 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-04-14 05:30:13)
>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>> index c472d7f..97a72da 100644
>> --- a/drivers/mfd/qcom-pm8008.c
>> +++ b/drivers/mfd/qcom-pm8008.c
>> @@ -239,6 +241,13 @@ static int pm8008_probe(struct i2c_client *client)
>>                          dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
>>          }
>>
>> +       chip->reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_HIGH);
>> +       if (IS_ERR(chip->reset_gpio)) {
>> +               dev_err(chip->dev, "failed to acquire reset gpio\n");
> The API looks to print debug messages. This print doesn't look required.


Okay.


>> +               return PTR_ERR(chip->reset_gpio);
>> +       }
>> +       gpiod_set_value(chip->reset_gpio, 1);
> Does this do anything? Does this work just as well?
>
> 	reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_LOW);
> 	if (IS_ERR(reset_gpio))
> 		return PTR_ERR(reset_gpio);
>
> Note that there's no point to store the reset gpio in the structure if
> it won't be used outside of probe.


Okay, I'll use a local variable.


> This should work fine? I used
> GPIOD_OUT_LOW to indicate that the reset should be returned to this
> function deasserted, i.e. taking the PMIC out of reset.


I'll try this out.


