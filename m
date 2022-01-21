Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74C49573C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378352AbiAUAPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:15:53 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:12590 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232090AbiAUAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642724152; x=1674260152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dKsHQvAjT19aw8U+G6+KD+0SJ25835Y+mwf/wTZtNaE=;
  b=JbD3rrCdB1IPXuqBxrgpvA65ObjI6bOyIp5SYsZgDxx53B6lZRfqEFce
   b7RZxxJvAhBlzTOFDhbNI2eO8ixJOT7u8dMn1E2HMbBFq2w1wXHAPkfhQ
   Vv5TwGl0jsreYJk4RBEQAYzv2AoGnYizoA9rtNTWXE8JsRUhq+DCkvrUh
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jan 2022 16:15:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 16:15:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 16:15:51 -0800
Received: from [10.110.112.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 20 Jan
 2022 16:15:50 -0800
Message-ID: <1192afb0-43b8-527e-4a43-6635413e4cc4@quicinc.com>
Date:   Thu, 20 Jan 2022 16:15:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] input: misc: pm8941-pwrkey: avoid potential null
 pointer dereference
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <20220120204132.17875-4-quic_amelende@quicinc.com>
 <88e7a6c5-c94e-0b65-173d-5f21109e216e@quicinc.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <88e7a6c5-c94e-0b65-173d-5f21109e216e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/20/2022 2:18 PM, Trilok Soni wrote:
> On 1/20/2022 12:41 PM, Anjelique Melendez wrote:
>> From: David Collins <collinsd@codeaurora.org>
>>
>> Add a null check for the pwrkey->data pointer after it is assigned
>> in pm8941_pwrkey_probe().  This avoids a potential null pointer
>> dereference when pwrkey->data->has_pon_pbs is accessed later in
>> the probe function.
>>
>> Change-Id: I589c4851e544d79a1863fd110b32a0b45ac03caf
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>   drivers/input/misc/pm8941-pwrkey.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>> index 0ce00736e695..ac08ed025802 100644
>> --- a/drivers/input/misc/pm8941-pwrkey.c
>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>> @@ -263,6 +263,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>         pwrkey->dev = &pdev->dev;
>>       pwrkey->data = of_device_get_match_data(&pdev->dev);
>> +    if (!pwrkey->data) {
>> +        dev_err(&pdev->dev, "match data not found\n");
>> +        return -ENODEV;
>> +    }
>>   
>
> I don't understand why this patch is 3rd in the series. Isn't it independent from the debounce time? If not, then why it is not fixed as part of the patch which adds this debounce time support?
>
> ---Trilok Soni
You are correct that this patch is independent from debounce time. In the following version I will move this patch up to be the first patch!
