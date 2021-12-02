Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A39465EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbhLBHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:52:30 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:56928 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbhLBHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:52:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638431345; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: References: Cc: To: From: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=zLxVuX4pO0rLW0CkC6lfDmYMroBh+awrZTxZe7U5iJ0=; b=gDHR8ZmI6Lornidal2gUeTDfdxqcobFO9VheyCWUJbKleBlzYa+xtChyYOxcbqtX45C3cx10
 xttEvv27K4VK0JBiU3fiCS6SSfZnfd2Mq94s0HXJjRhSkzglMyhfZrto8lQG5vtzy3+Qs5P9
 5vpAznkb8QxwMY+7Z+LqECDTIYI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61a87a6f135a8a9d0edc23ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Dec 2021 07:49:03
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D451CC43616; Thu,  2 Dec 2021 07:49:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.131.117.203] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30C7FC4338F;
        Thu,  2 Dec 2021 07:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 30C7FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <546ccd27-57c9-5e6c-f0fb-f6de0db73fdd@codeaurora.org>
Date:   Thu, 2 Dec 2021 13:18:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] soc: qcom: rpmhpd: Make mx as a parent of cx only for
 sdm845
Content-Language: en-US
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org
References: <1637040382-22987-1-git-send-email-rnayak@codeaurora.org>
 <1637040382-22987-2-git-send-email-rnayak@codeaurora.org>
 <YZcXvw0KExXvPwSV@builder.lan>
 <da24c062-6531-1b53-3112-210a88e1451e@codeaurora.org>
In-Reply-To: <da24c062-6531-1b53-3112-210a88e1451e@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/2021 12:45 PM, Rajendra Nayak wrote:
> 
> On 11/19/2021 8:49 AM, Bjorn Andersson wrote:
>> On Mon 15 Nov 23:26 CST 2021, Rajendra Nayak wrote:
>>
>>> The requirement to specify the active + sleep and active-only MX power
>>> domains as the parents of the corresponding CX power domains is applicable
>>> only on the sdm845 SoC. With the same struct definition reused for all the
>>> SoCs this condition was wrongly applied to all those SoCs as well, which
>>> isn't needed. Define new sdm845 specific structures to manage this
>>> dependency and remove the parent assignements from the common structure.
>>>
>>
>> Looking at the downstream sm8150 dts I see that both cx and mmcx
>> specifies mx as parent "supply".
>>
>> Is this not needed or should we instead name these resources
>> "cx_with_mx_parent" and have sm8150 opt in as well?
> 
> Right, looks like these are needed, after talking to some more folks
> I was told RPMh does not really enforce any dependencies on any of the
> SoCs, so my earlier statement was wrong that this was managed by RPMh.
> Some SoCs just have some digital domain requirements which need these
> dependencies to be managed (not all SoCs) and when we end up with such
> a situation its almost always expected to be managed by the RPMh masters
> (APPS running hlos in this case)
> This is not just across cx/mx but others as well like mmcx/mxc/gfx etc.
> 
> Unfortunately I could not find this very well documented at an SoC level,
> so perhaps the best way to go about is to look at downstream dependencies
> and try to match them upstream :/
> I will respin this to add the 8150 dependencies back (and if I see any more
> for the others)

Looking through this more in downstream files, I see atleast the mx being a
parent of cx is needed on pretty much all upstream supported SoCs, except the
sc7280. There seem to be more complex dependencies that downstream models
across other rails, mainly for 8150/8250/8350 and the most recent 8450
but looks like we have been able to live without those upstream so I plan
to leave them for now and just re-post this with an additional cx_with_mx_parent
and a cx to distinguish between these 2 cases.

> 
>>
>> Regards,
>> Bjorn
>>
>>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>>> ---
>>>   drivers/soc/qcom/rpmhpd.c | 22 ++++++++++++++++++----
>>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>>> index c71481d..12d8ce9 100644
>>> --- a/drivers/soc/qcom/rpmhpd.c
>>> +++ b/drivers/soc/qcom/rpmhpd.c
>>> @@ -108,7 +108,6 @@ static struct rpmhpd cx_ao;
>>>   static struct rpmhpd cx = {
>>>       .pd = { .name = "cx", },
>>>       .peer = &cx_ao,
>>> -    .parent = &mx.pd,
>>>       .res_name = "cx.lvl",
>>>   };
>>> @@ -116,7 +115,6 @@ static struct rpmhpd cx_ao = {
>>>       .pd = { .name = "cx_ao", },
>>>       .active_only = true,
>>>       .peer = &cx,
>>> -    .parent = &mx_ao.pd,
>>>       .res_name = "cx.lvl",
>>>   };
>>> @@ -149,12 +147,28 @@ static struct rpmhpd mxc_ao = {
>>>   };
>>>   /* SDM845 RPMH powerdomains */
>>> +static struct rpmhpd sdm845_cx_ao;
>>> +static struct rpmhpd sdm845_cx = {
>>> +    .pd = { .name = "cx", },
>>> +    .peer = &sdm845_cx_ao,
>>> +    .parent = &mx.pd,
>>> +    .res_name = "cx.lvl",
>>> +};
>>> +
>>> +static struct rpmhpd sdm845_cx_ao = {
>>> +    .pd = { .name = "cx_ao", },
>>> +    .active_only = true,
>>> +    .peer = &sdm845_cx,
>>> +    .parent = &mx_ao.pd,
>>> +    .res_name = "cx.lvl",
>>> +};
>>> +
>>>   static struct rpmhpd *sdm845_rpmhpds[] = {
>>>       [SDM845_EBI] = &ebi,
>>>       [SDM845_MX] = &mx,
>>>       [SDM845_MX_AO] = &mx_ao,
>>> -    [SDM845_CX] = &cx,
>>> -    [SDM845_CX_AO] = &cx_ao,
>>> +    [SDM845_CX] = &sdm845_cx,
>>> +    [SDM845_CX_AO] = &sdm845_cx_ao,
>>>       [SDM845_LMX] = &lmx,
>>>       [SDM845_LCX] = &lcx,
>>>       [SDM845_GFX] = &gfx,
>>> -- 
>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>>> of Code Aurora Forum, hosted by The Linux Foundation
>>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
