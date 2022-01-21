Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD94F49574F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378378AbiAUAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:25:29 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59998 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230379AbiAUAZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642724728; x=1674260728;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t2YxuKttgVah2lM2twk9tkIYIwUdg0peTdAk1kq1K4o=;
  b=gZotGw2bSPosillhuBEaEcoyjj0cUTwMwUoIw8aI1PwnGwMwwHqrzcB6
   65ZF2Yg3El4qSUnEVq4wF8le1QSBpnFHjGY7yS5id+p56EMd9eMUlz3sj
   b9yUb6iI2VmYwidowH3p/YNGQHL2FSBnUYqvwUPOD4tNcPpdDRWtdOd+O
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jan 2022 16:25:28 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 16:25:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 16:25:27 -0800
Received: from [10.110.112.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 20 Jan
 2022 16:25:27 -0800
Message-ID: <e2015c19-b73b-39a7-ba73-708b2c4552c7@quicinc.com>
Date:   Thu, 20 Jan 2022 16:25:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] input: misc: pm8941-pwrkey: avoid potential null
 pointer dereference
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <collinsd@codeaurora.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <20220120204132.17875-4-quic_amelende@quicinc.com> <YenpwnE3WrIEAOlm@ripper>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <YenpwnE3WrIEAOlm@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/20/2022 3:01 PM, Bjorn Andersson wrote:
> On Thu 20 Jan 12:41 PST 2022, Anjelique Melendez wrote:
>
>> From: David Collins <collinsd@codeaurora.org>
>>
>> Add a null check for the pwrkey->data pointer after it is assigned
>> in pm8941_pwrkey_probe().  This avoids a potential null pointer
>> dereference when pwrkey->data->has_pon_pbs is accessed later in
>> the probe function.
>>
>> Change-Id: I589c4851e544d79a1863fd110b32a0b45ac03caf
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  drivers/input/misc/pm8941-pwrkey.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>> index 0ce00736e695..ac08ed025802 100644
>> --- a/drivers/input/misc/pm8941-pwrkey.c
>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>> @@ -263,6 +263,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>  
>>  	pwrkey->dev = &pdev->dev;
>>  	pwrkey->data = of_device_get_match_data(&pdev->dev);
>> +	if (!pwrkey->data) {
> The only way this can happen is if you add a new compatible and forget
> to specify data and when that happens you will get a print in the log
> somewhere, which once you realize that you don't have your pwrkey you
> might be able to find among all the other prints.
>
> If you instead don't NULL check this pointer you will get a large splat
> in the log, with callstack and all, immediately hinting you that
> pwrkey->data is NULL.
>
>
> In other words, there's already a print, a much larger print and I don't
> think there's value in handling this mistake gracefully.
>
> Regards,
> Bjorn


We would like to the null pointer check in place to avoid static analysis

warnings that can be easily fixed.


>
>> +		dev_err(&pdev->dev, "match data not found\n");
>> +		return -ENODEV;
>> +	}
>>  
>>  	parent = pdev->dev.parent;
>>  	regmap_node = pdev->dev.of_node;
>> -- 
>> 2.34.1
>>
