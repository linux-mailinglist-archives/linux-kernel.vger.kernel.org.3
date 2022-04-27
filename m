Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E051198A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiD0Nv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiD0NvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:51:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C652B1A;
        Wed, 27 Apr 2022 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651067294; x=1682603294;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3VKraWGq9JKDghUpz/S876MR6EjNBCyS7OXTjzs1g+o=;
  b=Lhbs97ijHiYYJZXdsp1lKAlVe5VZ6BFM4RUT0D7fhuXUsPOhgJPaf1sX
   XvAR3nJY02uq+mhSLgZh2zULehXe5C3raRjyZsRm3s7hnttGcdEmo5+VV
   IFZ9Jj9G6JSd4qbdtjLr0IoJxIIM4Rx8irHhcEfZFhQeLVy6kMMNd5Z6e
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 06:48:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:48:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 06:48:13 -0700
Received: from [10.216.55.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 06:48:11 -0700
Subject: Re: [PATCH V10 4/9] mfd: pm8008: Add reset-gpios
To:     Stephen Boyd <swboyd@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n50HR6w-v3ub8HR_K2PsqqTTrVAaQa0pZ7QjY39WmkDyQQ@mail.gmail.com>
 <010bd223-94a0-fe8c-d1ab-39153bb68a7d@quicinc.com>
 <a4cbdb4c-dbba-75ee-202a-6b429c0eb390@quicinc.com>
 <104b529b-946d-f171-5a82-6052aef2dbbb@quicinc.com>
 <CAE-0n532pgMKBFmK2etwCjMydKqD276X-veqqsne=WgE-sUegA@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <42655ad8-7eae-b629-69f8-e8e401bb7170@quicinc.com>
Date:   Wed, 27 Apr 2022 19:18:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n532pgMKBFmK2etwCjMydKqD276X-veqqsne=WgE-sUegA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/27/2022 12:00 PM, Stephen Boyd wrote:
> Quoting Satya Priya Kakitapalli (Temp) (2022-04-26 23:03:08)
>> On 4/27/2022 10:58 AM, Satya Priya Kakitapalli (Temp) wrote:
>>> On 4/18/2022 10:34 AM, Satya Priya Kakitapalli (Temp) wrote:
>>>> On 4/15/2022 5:40 AM, Stephen Boyd wrote:
>>>>> Quoting Satya Priya (2022-04-14 05:30:13)
>>>>>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>>>>>> index c472d7f..97a72da 100644
>>>>>> --- a/drivers/mfd/qcom-pm8008.c
>>>>>> +++ b/drivers/mfd/qcom-pm8008.c
>>>>>> +               return PTR_ERR(chip->reset_gpio);
>>>>>> +       }
>>>>>> +       gpiod_set_value(chip->reset_gpio, 1);
>>>>> Does this do anything? Does this work just as well?
>>>>>
>>>>>      reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_LOW);
>>>>>      if (IS_ERR(reset_gpio))
>>>>>          return PTR_ERR(reset_gpio);
>>>>>
>>> This is not working as expected. We need to add
>>> "gpiod_set_value(chip->reset_gpio, 1);"  to actually toggle the line.
>>>
>> I checked again and it is working after using GPIOD_OUT_HIGH instead of LOW.
>>
>> reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_HIGH);
>>       if (IS_ERR(reset_gpio))
>>           return PTR_ERR(reset_gpio);
>>
> What do you have in DT for the 'reset-gpios' property? GPIOD_OUT_HIGH
> means the reset line is asserted, which presumably you don't want to be
> the case because you typically deassert a reset to "take it out of
> reset". Using GPIOD_OUT_HIGH probably works because DT has the wrong
> GPIO flag, i.e.  GPIO_ACTIVE_HIGH, for an active low reset, or vice
> versa.


Yeah, I had GPIOD_OUT_HIGH in DT, now I changed and it is working fine 
with GPIOD_OUT_LOW.

