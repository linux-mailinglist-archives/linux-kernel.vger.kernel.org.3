Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4E573C25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGMRpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiGMRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:45:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5B2CDCC;
        Wed, 13 Jul 2022 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657734316; x=1689270316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OSmfHB+bOHfPpf36dcqHWxEa0qHSKOxtsJseDaw6+jw=;
  b=k+XmMUF0Q4vzjyH0jyLYibeWB/P6ACjoBCVg85Tjb44sQ8nkTUUWKWBD
   awfltYbxhnMAh54VfbxH7DY/HaGuuPfp3ObhRVt+NO2eTJwwtl3Kqdx5H
   HGEtvPlapkYHbFRprGCgkfiKKZi5OyT4ojGTQhLG6s6E0nAksSejTp2UY
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Jul 2022 10:45:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:45:16 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 10:45:15 -0700
Received: from [10.110.36.60] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 10:45:14 -0700
Message-ID: <59631540-ee6a-41f3-d460-4808162d06c9@quicinc.com>
Date:   Wed, 13 Jul 2022 10:45:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20220708185007.21743-1-quic_wcheng@quicinc.com>
 <20220708185007.21743-5-quic_wcheng@quicinc.com>
 <06498069-db45-202b-eba6-47bfa6948143@synopsys.com>
 <8029f6bb-4704-0495-00d2-ee78ee684eb3@quicinc.com>
 <889ba0fc-4a8c-cb89-ba7c-90119a58b997@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <889ba0fc-4a8c-cb89-ba7c-90119a58b997@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 7/12/2022 6:42 PM, Thinh Nguyen wrote:
> On 7/12/2022, Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 7/8/2022 6:58 PM, Thinh Nguyen wrote:
>>> On 7/8/2022, Wesley Cheng wrote:
>>>> If soft disconnect is in progress, allow the endxfer command to be
>>>> sent,
>>>> without this, there is an issue where the stop active transfer call
>>>> (during pullup disable) wouldn't actually issue the endxfer command,
>>>> while clearing the DEP flag.
>>>>
>>>> In addition, if the DWC3_EP_DELAY_STOP flag was set before soft
>>>> disconnect
>>>> started (i.e. from the dequeue path), ensure that when the EP0
>>>> transaction
>>>> completes during soft disconnect, to issue the endxfer with the force
>>>> parameter set, as it does not expect a command complete event.
>>>>
>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>> ---
>>>>     drivers/usb/dwc3/ep0.c    | 3 +--
>>>>     drivers/usb/dwc3/gadget.c | 5 ++++-
>>>>     2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>> index 506ef717fdc0..5851b0e9db0a 100644
>>>> --- a/drivers/usb/dwc3/ep0.c
>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>> @@ -290,8 +290,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>>>             if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
>>>>                 continue;
>>>>     -        dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
>>>> -        dwc3_stop_active_transfer(dwc3_ep, true, true);
>>>> +        dwc3_stop_active_transfer(dwc3_ep, true, dwc->connected);
>>>>         }
>>>>     }
>>>>     diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index bd40608b19df..fba2797ad9ae 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -3696,8 +3696,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep
>>>> *dep, bool force,
>>>>         if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
>>>>             return;
>>>>     +    if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
>>>> +        return;
>>>> +
>>>>         if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
>>>> -        (dep->flags & DWC3_EP_DELAY_STOP) ||
>>>>             (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>>>>             return;
>>>>     @@ -3744,6 +3746,7 @@ void dwc3_stop_active_transfer(struct
>>>> dwc3_ep *dep, bool force,
>>>>         __dwc3_stop_active_transfer(dep, force, interrupt);
>>>>         spin_lock(&dwc->lock);
>>>>     +    dep->flags &= ~DWC3_EP_DELAY_STOP;
>>>
>>> Can we clear this flag in __dwc3_stop_active_transfer(). It should apply
>>> if End Transfer command was sent.
>>
>> I wanted to make sure that we weren't modifying the DEP flags outside
>> of a spin lock.  Patch#3 modifies it where we unlock before calling
>> __dwc3_stop_active_transfer(), so we can allow the dwc3 threaded IRQ
>> handle events while the cmd status polling happens.
>>
>> Maybe we can unlock/lock the dwc3->lock inside
>> __dwc3_stop_active_transfer() and that way we can ensure DEP flags are
>> modified properly?
> 
> I didn't realize that you unlock/lock when calling
> __dwc3_stop_active_transfer(). We'd need to be careful if we want to
> unlock/lock it, and avoid it all together if possible. It can be easily
> overlooked just like dwc3_gadget_giveback().
> 
> What issue did you see without doing this?

I saw endxfer timeout issues if I didn't do it.  If we keep the lock 
held, then the DWC3 event processing would be blocked across the entire 
time we are waiting for the command act to clear.  With unlocking before 
polling, then at least we're still able to handle the EP0 events that 
are pending.

It was definitely one of the harder scenarios to reproduce.  The main 
patch series which resolved a lot of the issues early on was patch#1. 
After adding that the other issues are seen maybe after a day or so of 
testing.

Thanks
Wesley Cheng
