Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8846EBDF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbhLIPl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:29 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:28455 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234825AbhLIPkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1639064235; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: References: Cc: To: From: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=7Vhp/M67sIpxiDLqX0cLn8+k0NHzSM3MbQILb9c/h2c=; b=aLEI1WXwLDImwxWNYJOCQJNweSBaUZ4EEMjc0i2ruHzwsySduKH/a1uvSFFdM+bAPf7ImpJS
 q9JtyljRC8wB/cYIxELl2tGHWYs58uZRMCJpiHLlbp6LxFKwWhixkqF6ssC8INYW8iI4TBY5
 z7DqrKGgPs5TPdtniLzWFFWd7DU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61b222a9642caac318a8aa26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Dec 2021 15:37:13
 GMT
Sender: quic_rjendra=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E38EBC43616; Thu,  9 Dec 2021 15:37:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.1.101] (unknown [49.207.224.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFC79C4360C;
        Thu,  9 Dec 2021 15:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AFC79C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
Message-ID: <7b8f359f-de8d-4ace-d28d-8242683e1f8c@quicinc.com>
Date:   Thu, 9 Dec 2021 21:07:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/3] soc: qcom: rpmhpd: Remove mx/cx relationship on
 sc7280
Content-Language: en-US
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org, mka@chromium.org
References: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
 <1638871712-18636-3-git-send-email-quic_rjendra@quicinc.com>
 <YbEYyGHqaHGeRXsV@builder.lan>
 <7e9f6cbe-17c9-53ff-95a8-2f2bbdeb1d23@quicinc.com>
In-Reply-To: <7e9f6cbe-17c9-53ff-95a8-2f2bbdeb1d23@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/2021 12:29 PM, Rajendra Nayak wrote:
> 
> On 12/9/2021 2:12 AM, Bjorn Andersson wrote:
>> On Tue 07 Dec 04:08 CST 2021, Rajendra Nayak wrote:
>>
>>> While the requirement to specify the active + sleep and active-only MX
>>> power-domains as the parents of the corresponding CX power domains is
>>> applicable for most SoCs, we have some like the sc7280 where this
>>> dependency is not applicable.
>>> Define new rpmhpd structs for cx and cx_ao without the mx as
>>> parent and use them for sc7280.
>>>
>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/rpmhpd.c | 18 ++++++++++++++++--
>>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>>> index c71481d..4599efe 100644
>>> --- a/drivers/soc/qcom/rpmhpd.c
>>> +++ b/drivers/soc/qcom/rpmhpd.c
>>> @@ -120,6 +120,20 @@ static struct rpmhpd cx_ao = {
>>>       .res_name = "cx.lvl",
>>>   };
>>> +static struct rpmhpd cx_ao_no_parent;
>>> +static struct rpmhpd cx_no_parent = {
>>
>> There are multiple variations of how each of these can be parented, but
>> only one way they can be without a parent. So how about we turn this the
>> other way around?
>>
>> I.e. let's name this one "cx" and the existing one "cx_w_mx_parent".
>>
>>
>> This will be particularly useful when you look at mmcx, which on
>> 8150/8180 has mx as parent and on 8450 has cx as parent.

I noticed mmcx on 8150/8180 does not have mx as parent, nevertheless
I went ahead and moved to the _w_<parent-name>_parent suffix because
it made sense if we did run into a situation like this in the future.

>>
>>
>> PS. Unfortunately I had merged 8450 since you wrote this series, I tried
>> to just fix it up as I applied your patch, but noticed 8450_cx and
>> 8450_mmcx and wanted to get your opinion on this first.
> 
> I agree that sounds like a reasonable thing to do, I hadn't looked at 8450
> so did not notice it, I will rebase my patches on top and repost.
> 
>>
>> Regards,
>> Bjorn
>>
>>> +    .pd = { .name = "cx", },
>>> +    .peer = &cx_ao_no_parent,
>>> +    .res_name = "cx.lvl",
>>> +};
>>> +
>>> +static struct rpmhpd cx_ao_no_parent = {
>>> +    .pd = { .name = "cx_ao", },
>>> +    .active_only = true,
>>> +    .peer = &cx_no_parent,
>>> +    .res_name = "cx.lvl",
>>> +};
>>> +
>>>   static struct rpmhpd mmcx_ao;
>>>   static struct rpmhpd mmcx = {
>>>       .pd = { .name = "mmcx", },
>>> @@ -273,8 +287,8 @@ static const struct rpmhpd_desc sc7180_desc = {
>>>   /* SC7280 RPMH powerdomains */
>>>   static struct rpmhpd *sc7280_rpmhpds[] = {
>>> -    [SC7280_CX] = &cx,
>>> -    [SC7280_CX_AO] = &cx_ao,
>>> +    [SC7280_CX] = &cx_no_parent,
>>> +    [SC7280_CX_AO] = &cx_ao_no_parent,
>>>       [SC7280_EBI] = &ebi,
>>>       [SC7280_GFX] = &gfx,
>>>       [SC7280_MX] = &mx,
>>> -- 
>>> 2.7.4
>>>
