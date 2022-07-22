Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8757D89F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiGVC10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGVC1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:27:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DA4E6A;
        Thu, 21 Jul 2022 19:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658456843; x=1689992843;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DyMPVOVoUmbuRH2di/nCwEdlhMd9sv+uzLzhxXDTphk=;
  b=tHGA7cg0ikdP/EDH9lvKsluE7VbahQlmU8vpWBrRZ3zLgeLlqd3bDqgL
   oaqweZrCA8kCVKum/BRGbNxIzJpOlQgVwVLMDEf+Ki2/FYMxsPHk0r/4a
   ZRP8q5IQvlR1F5dmqqlNlnexL1o2smfm8sI4eC8LE1E1Epuobzxz6Fkxw
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Jul 2022 19:27:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:27:23 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Jul 2022 19:27:22 -0700
Received: from [10.110.106.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Jul
 2022 19:27:22 -0700
Message-ID: <53c24bea-10d9-5533-1384-8b34136059c4@quicinc.com>
Date:   Thu, 21 Jul 2022 19:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Content-Language: en-US
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-5-quic_wcheng@quicinc.com>
 <d8d26ce3-6773-bd9c-e227-0924f239eae0@synopsys.com>
 <98623d02-cde4-b036-a85c-9325b58c7eab@quicinc.com>
 <5d0cf380-e045-fcec-639f-ac2f6a187ca8@synopsys.com>
 <5a57d5b9-b81e-bb09-998b-2915d9ab6b2f@quicinc.com>
 <fa172e2c-eff6-002e-3687-d87a2986fd42@synopsys.com>
 <b431cfd5-65b8-aa31-ca13-a813a1ad2e10@quicinc.com>
In-Reply-To: <b431cfd5-65b8-aa31-ca13-a813a1ad2e10@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 7/21/2022 5:04 PM, Wesley Cheng wrote:
> Hi Thinh,
> 
> On 7/21/2022 5:00 PM, Thinh Nguyen wrote:
>> On 7/21/2022, Wesley Cheng wrote:
>>> Hi Thinh,
>>>
>>> On 7/21/2022 3:20 PM, Thinh Nguyen wrote:
>>>> On 7/21/2022, Wesley Cheng wrote:
>>>>> Hi Thinh,
>>>>>
>>>>> On 7/21/2022 3:08 PM, Thinh Nguyen wrote:
>>>>>> Hi Wesley,
>>>>>>
>>>>>> On 7/12/2022, Wesley Cheng wrote:
>>>>>>> If soft disconnect is in progress, allow the endxfer command to be
>>>>>>> sent,
>>>>>>> without this, there is an issue where the stop active transfer call
>>>>>>> (during pullup disable) wouldn't actually issue the endxfer command,
>>>>>>> while clearing the DEP flag.
>>>>>>>
>>>>>>> In addition, if the DWC3_EP_DELAY_STOP flag was set before soft
>>>>>>> disconnect
>>>>>>> started (i.e. from the dequeue path), ensure that when the EP0
>>>>>>> transaction
>>>>>>> completes during soft disconnect, to issue the endxfer with the 
>>>>>>> force
>>>>>>> parameter set, as it does not expect a command complete event.
>>>>>>>
>>>>>>> Fixes: e4cf6580ac740 ("usb: dwc3: gadget: Wait for ep0 xfers to
>>>>>>> complete during dequeue")
>>>>>>> Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>>>> ---
>>>>>>> Link:
>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/1a1a5485-790e-79ce-f5a6-1e96d9b49a47@synopsys.com/__;!!A4F2R9G_pg!cXW2TlALYWnXNPg-NoMFUrQ8K1egEZiQizZ5CA1DOM1Gcw4tfOULy-_2eMGvL8pQPte5dScFON-0wxH2eXu8ijEQUbs$ 
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>      drivers/usb/dwc3/ep0.c    | 3 +--
>>>>>>>      drivers/usb/dwc3/gadget.c | 5 ++++-
>>>>>>>      2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>>>>>> index 506ef717fdc0..5851b0e9db0a 100644
>>>>>>> --- a/drivers/usb/dwc3/ep0.c
>>>>>>> +++ b/drivers/usb/dwc3/ep0.c
>>>>>>> @@ -290,8 +290,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>>>>>>              if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
>>>>>>>                  continue;
>>>>>>>      -        dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
>>>>>>
>>>>>> If we don't clear this flag here,
>>>>>>
>>>>>
>>>>> This is why I added the dwc->connected argument to control the
>>>>> "interrupt" argument.
>>>>>
>>>>>>> - dwc3_stop_active_transfer(dwc3_ep, true, true);
>>>>>>> +        dwc3_stop_active_transfer(dwc3_ep, true, dwc->connected);
>>>>>>>          }
>>>>>>>      }
>>>>>>>      diff --git a/drivers/usb/dwc3/gadget.c
>>>>>>> b/drivers/usb/dwc3/gadget.c
>>>>>>> index ee85b773e3fe..41b7007358de 100644
>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>> @@ -1693,6 +1693,7 @@ static int __dwc3_stop_active_transfer(struct
>>>>>>> dwc3_ep *dep, bool force, bool int
>>>>>>>              dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
>>>>>>>          else if (!ret)
>>>>>>>              dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
>>>>>>> +    dep->flags &= ~DWC3_EP_DELAY_STOP;
>>>>>>>             return ret;
>>>>>>>      }
>>>>>>> @@ -3686,8 +3687,10 @@ void dwc3_stop_active_transfer(struct dwc3_ep
>>>>>>> *dep, bool force,
>>>>>>>          if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
>>>>>>>              return;
>>>>>>>      +    if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
>>>>>>> +        return;
>>>>>>> +
>>>>>>
>>>>>> then it may not go through here. I think I made this same mistake
>>>>>> in my
>>>>>> previous suggestion.
>>>>>>
>>>>>
>>>>> Since dwc->connected is set to FALSE before we call stop active
>>>>> transfers, if we ever run into a situation where delayed stop is set
>>>>> already, then it should go through.
>>>>>
>>>>
>>>> Then the check for request dequeue that we did previously will not work
>>>> anymore.
>>>>
>>>
>>> Could you help clarify?  The pullup refactor kind of shifted some of
>>> the previous checks we had in the dequeue path, and combined with with
>>> the stop active transfer checks.
>>>
>>> I think there was an issue w/ the patch I submitted though.  the above
>>> snippet should be replacing what is there:
>>>
>>> void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>>>      bool interrupt)
>>> {
>>> ...
>>>      if (!(dep->flags & DWC3_EP_TRANSFER_STARTED) ||
>>>          /* Following should be removed --- (dep->flags &
>>> DWC3_EP_DELAY_STOP) || */
>>>          (dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>>>          return;
>>>
>>
>> Request dequeue can occur while the device is connected. The
>> DWC3_EP_DELAY_STOP intention is to delay sending the End Transfer
>> command until the SETUP stage is prepared. If we don't clear the flag
>> before the flag check, then the End Transfer command will not go through.
>>
> 
> Thanks, got it.  Understand what you mean now.  Let me think about how 
> to go about it.  I probably don't see any issues as of now, because my 
> test does the soft disconnect, which will do the stop active transfers 
> forcefully.
> 
What do you think about just removing the

(dep->flags & DWC3_EP_DELAY_STOP)

check?  In the end, as long as the conditions are satisfied (ie we 
aren't in the middle of a SETUP transaction) then we don't care too much 
about who called dwc3_stop_active_transfer().  We would still be able to 
avoid issuing the endxfer here:

	if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status) {
		dep->flags |= DWC3_EP_DELAY_STOP;
		return 0;
	}


Thanks
Wesley Cheng
