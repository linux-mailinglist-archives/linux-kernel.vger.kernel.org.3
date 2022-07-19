Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24125797BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiGSKdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGSKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:33:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADB3F33F;
        Tue, 19 Jul 2022 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658226808; x=1689762808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f/0xc08dCedpF2dw33QFgx9iLdNwRCTxv/WES9sDyDM=;
  b=PLposR463HOIjjKnWHX1QfVopeog/wMkMZXN9Nll6hWS9ejhMLBYe+av
   uu0z8EP2giX74ZBinOiWoeosI75aVIZ59+f4/rZIe1AtNuvmAoiRGPMmg
   WfMEJxs+LOetXW5SoYcd9ljBEiMWJ13SY2BIOAEbtF3uCgzP4AecsHyHv
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 19 Jul 2022 03:33:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 03:33:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Jul 2022 03:33:27 -0700
Received: from [10.216.50.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Jul
 2022 03:33:23 -0700
Message-ID: <7d1106b0-178c-7167-34d5-330bb2763c3e@quicinc.com>
Date:   Tue, 19 Jul 2022 16:03:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] firmware: qcom: scm: Add wait-queue handling logic
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David Heidelberg" <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
 <1656359076-13018-6-git-send-email-quic_gurus@quicinc.com>
 <ec04538b-93e2-fa93-4043-c489a0f228e8@quicinc.com>
 <ad5e875d-e5d7-3b6f-4915-98ba08df8c5d@quicinc.com>
 <20220714005735.GA22183@quicinc.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220714005735.GA22183@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2022 6:27 AM, Guru Das Srinagesh wrote:
> On Jul 01 2022 16:51, Rajendra Nayak wrote:
>>
>>
>> On 7/1/2022 4:32 PM, Rajendra Nayak wrote:
>>>
>>>
>>> On 6/28/2022 1:14 AM, Guru Das Srinagesh wrote:
>>>> Add logic to handle QCOM_SCM_WAITQ_SLEEP or QCOM_SCM_WAITQ_WAKE return
>>>> codes.
>>>>
>>>> Scenario 1: Requests made by 2 different VMs:
>>>>
>>>>     VM_1                     VM_2                            Firmware
>>>>       │                        │                                 │
>>>>       │                        │                                 │
>>>>       │                        │                                 │
>>>>       │                        │                                 │
>>>>       │      REQUEST_1         │                                 │
>>>>       ├────────────────────────┼─────────────────────────────────┤
>>>>       │                        │                                 │
>>>>       │                        │                              ┌──┼──┐
>>>>       │                        │                              │  │  │
>>>>       │                        │     REQUEST_2                │  │  │
>>>>       │                        ├──────────────────────────────┼──┤  │
>>>>       │                        │                              │  │  │Resource
>>>>       │                        │                              │  │  │is busy
>>>>       │                        │       {WQ_SLEEP}             │  │  │
>>>>       │                        │◄─────────────────────────────┼──┤  │
>>>>       │                        │  wq_ctx, smc_call_ctx        │  │  │
>>>>       │                        │                              └──┼──┘
>>>>       │   REQUEST_1 COMPLETE   │                                 │
>>>>       │◄───────────────────────┼─────────────────────────────────┤
>>>>       │                        │                                 │
>>>>       │                        │         IRQ                     │
>>>>       │                        │◄─-------------------------------│
>>>>       │                        │                                 │
>>>>       │                        │      get_wq_ctx()               │
>>>>       │                        ├────────────────────────────────►│
>>>>       │                        │                                 │
>>>>       │                        │                                 │
>>>>       │                        │◄────────────────────────────────┤
>>>>       │                        │   wq_ctx, flags, and            │
>>>>       │                        │        more_pending             │
>>>>       │                        │                                 │
>>>>       │                        │                                 │
>>>>       │                        │ wq_resume(smc_call_ctx)         │
>>>>       │                        ├────────────────────────────────►│
>>>>       │                        │                                 │
>>>>       │                        │                                 │
>>>>       │                        │      REQUEST_2 COMPLETE         │
>>>>       │                        │◄────────────────────────────────┤
>>>>       │                        │                                 │
>>>>       │                        │                                 │
>>>>
>>>> Scenario 2: Two Requests coming in from same VM:
>>>>
>>>>     VM_1                                                     Firmware
>>>>       │                                                          │
>>>>       │                                                          │
>>>>       │                                                          │
>>>>       │                                                          │
>>>>       │      REQUEST_1                                           │
>>>>       ├──────────────────────────────────────────────────────────┤
>>>>       │                                                          │
>>>>       │                                                     ┌────┼───┐
>>>>       │                                                     │    │   │
>>>>       │                                                     │    │   │
>>>>       │                                                     │    │   │
>>>>       │      REQUEST_2                                      │    │   │
>>>>       ├─────────────────────────────────────────────────────┼───►│   │
>>>>       │                                                     │    │   │Resource
>>>>       │                                                     │    │   │is busy
>>>>       │      {WQ_SLEEP}                                     │    │   │
>>>>       │◄────────────────────────────────────────────────────┼────┤   │
>>>>       │      wq_ctx, req2_smc_call_ctx                      │    │   │
>>>>       │                                                     │    │   │
>>>>       │                                                     └────┼───┘
>>>>       │                                                          │
>>>>       │      {WQ_WAKE}                                           │
>>>>       │◄─────────────────────────────────────────────────────────┤
>>>>       │      wq_ctx, req1_smc_call_ctx, flags                    │
>>>
>>>
>>> This is perhaps the same thing I asked on the previous patch,
>>> I am guessing {WQ_WAKE} is returned in respone to REQUEST_1?
>>> How do you know in this case if REQUEST_1 was a success or failure?
>>>
>>
>> Ok looking at this some more, I think what we are saying is that the FW returns
>> {WQ_WAKE} to REQUEST_1, we then call wq_wake_ack and the return of
>> *that* will tell if REQUEST_1 was success or failure?
>> Did I get it right?
> 
> Yes, that is correct. I should have added an explanatory note in the commit
> message to this effect:
> 
> 
>       │      {WQ_WAKE}                         <-- Return value  │
>       │◄─────────────────────────────────────────────────────────┤
>       │      wq_ctx, req1_smc_call_ctx, flags  <-- Its payload   │
> 
> What this means is that the WQ_WAKE is sent by the FW to VM1 (direction of
> arrow is from right to left) and that the additional data packed as payload
> indicate that it is meant for REQUEST_1 (`req1_smc_call_ctx`).
> 
> Hopefully this will help understand the diagram better.

Ok thanks for the explanation, I actually had a few more comments down in that
patch which you did not answer, can you clarify them too?

>> +        } else if ((long)res->a0 < 0) {
>> +            /* Error, simply return to caller */
>> +            break;

if my understanding above is correct, shouldn't we do a
>> +            if (wq)
>> +                scm_waitq_flag_handler(wq, flags);
in the error case also?

Also why no just scm_waitq_flag_handler(wq, flags); before fill_wq_wake_ack_args(smc, smc_call_ctx);?

> 
> Thank you.
> 
> Guru Das.
