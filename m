Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B8D49EB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbiA0Tvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:51:50 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:15824 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiA0Tvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643313109; x=1674849109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M4KyLIl9S5rtOUuVugAvQTnfhRh0E8GptPgBaQ0zctA=;
  b=NVe5CGcjoSjikDzmTWiTHJINAf2UOPoQGvtVbLwcUI4SazVGOzTlP21/
   AdWtgreaVZ5w7k1F2rHUUi14P3ewlYtGt4dSW/MDN0LL1UxAsVja4sy3q
   K73nZb+++inW6KkevTROP2aJosHyCSBXVU0lnqCZKy8QQXZdnU6NxGRER
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Jan 2022 11:51:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 11:51:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 11:51:48 -0800
Received: from [10.110.26.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 27 Jan
 2022 11:51:46 -0800
Message-ID: <c280e1d3-15c5-29fa-c218-78bcd2427e09@quicinc.com>
Date:   Thu, 27 Jan 2022 11:51:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] input: misc: pm8941-pwrkey: avoid potential null
 pointer dereference
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <collinsd@codeaurora.org>, <skakit@codeaurora.org>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <20220120204132.17875-4-quic_amelende@quicinc.com> <YenpwnE3WrIEAOlm@ripper>
 <e2015c19-b73b-39a7-ba73-708b2c4552c7@quicinc.com>
 <CAE-0n50+1OU2yt2gihHHCEn-cE-CZuqa_U9W=xWCuYeCQdzExw@mail.gmail.com>
 <Ye8nmnQ3F4QcTIJs@ripper>
 <CAE-0n51bYEkvxu8z2gc_KUv0u+J2Esg0_3AiQRLyTaouNoa78g@mail.gmail.com>
 <YfBDVQeEsLv6Yj9g@ripper>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <YfBDVQeEsLv6Yj9g@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2022 10:37 AM, Bjorn Andersson wrote:
> On Mon 24 Jan 17:55 PST 2022, Stephen Boyd wrote:
>
>> Quoting Bjorn Andersson (2022-01-24 14:26:34)
>>> On Thu 20 Jan 20:18 PST 2022, Stephen Boyd wrote:
>>>
>>>> Quoting Anjelique Melendez (2022-01-20 16:25:26)
>>>>> On 1/20/2022 3:01 PM, Bjorn Andersson wrote:
>>>>>> On Thu 20 Jan 12:41 PST 2022, Anjelique Melendez wrote:
>>>>>>
>>>>>>> From: David Collins <collinsd@codeaurora.org>
>>>>>>>
>>>>>>> Add a null check for the pwrkey->data pointer after it is assigned
>>>>>>> in pm8941_pwrkey_probe().  This avoids a potential null pointer
>>>>>>> dereference when pwrkey->data->has_pon_pbs is accessed later in
>>>>>>> the probe function.
>>>>>>>
>>>>>>> Change-Id: I589c4851e544d79a1863fd110b32a0b45ac03caf
>>>>>>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>>>>>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>>>>>> ---
>>>>>>>  drivers/input/misc/pm8941-pwrkey.c | 4 ++++
>>>>>>>  1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>>>>>>> index 0ce00736e695..ac08ed025802 100644
>>>>>>> --- a/drivers/input/misc/pm8941-pwrkey.c
>>>>>>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>>>>>>> @@ -263,6 +263,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>>>>>>
>>>>>>>      pwrkey->dev = &pdev->dev;
>>>>>>>      pwrkey->data = of_device_get_match_data(&pdev->dev);
>>>>>>> +    if (!pwrkey->data) {
>>>>>> The only way this can happen is if you add a new compatible and forget
>>>>>> to specify data and when that happens you will get a print in the log
>>>>>> somewhere, which once you realize that you don't have your pwrkey you
>>>>>> might be able to find among all the other prints.
>>>>>>
>>>>>> If you instead don't NULL check this pointer you will get a large splat
>>>>>> in the log, with callstack and all, immediately hinting you that
>>>>>> pwrkey->data is NULL.
>>>>>>
>>>>>>
>>>>>> In other words, there's already a print, a much larger print and I don't
>>>>>> think there's value in handling this mistake gracefully.
>>>>>>
>>>>>> Regards,
>>>>>> Bjorn
>>>>>
>>>>> We would like to the null pointer check in place to avoid static analysis
>>>>>
>>>>> warnings that can be easily fixed.
>>>>>
>>>> Many drivers check that their device_get_match_data() returns a valid
>>>> pointer. I'd like to see that API used in addition to checking the
>>>> return value for NULL so that we can keep the static analysis tools
>>>> happy. Yes it's an impossible case assuming the driver writer didn't
>>>> mess up but it shuts SA up and we don't really have a better solution
>>>> to tell tools that device_get_match_data() can't return NULL.
>>> I'm not saying that device_get_match_data() can't return NULL,
>> Indeed, I wasn't implying that you were saying that.
>>
>>> I'm
>>> saying that in the very specific cases that it would return NULL it's
>>> useful to have a kernel panic - as that's a much faster way to figure
>>> out that something is wrong.
>> I see it as more annoying, but maybe that's my workflow? When my kernel
>> oopses I have to go back to a recovery kernel, which takes me a few more
>> seconds to "repair" my device. If the driver only failed to probe then
>> I'd probably be able to boot far enough to get networking and more
>> easily replace my kernel with a working device. And I'd have userspace
>> access so I could poke around and figure out why the driver failed to
>> probe. Now obviously a big stacktrace would be helpful to know that it's
>> the power key driver that's busted, but it's not like we're calling some
>> internal API here. We're trying to probe a driver and if that oopses
>> because the driver writer failed at their job then it's bad on them for
>> writing a bad patch but also annoying for the integrator who has to deal
>> with the mess they created. I'd rather have a half working system here
>> vs. a totally broken one.
> Forgot about your recovery cycle, on most of my boards I just load a new
> kernel every boot, so there's no cost of recovering from a panic, it
> might even save me some time if it crashes completely before userspace
> starts consuming cycles.
>
> My only concern is that this "sets" a quite fuzzy precedence. I don't
> want us to just fix SA warnings all over the place, but I don't want it
> to be inconvenient to work on the kernel...
>
> Regards,
> Bjorn

I will drop this patch for now so that further discussion can be had. Can send as a separate patch
later.
