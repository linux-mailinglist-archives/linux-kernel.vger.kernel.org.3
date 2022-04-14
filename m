Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99498501DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbiDNVr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbiDNVrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:47:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F13633E;
        Thu, 14 Apr 2022 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649972696; x=1681508696;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rq7yUoLN5kZ74ztwyG29HHmd6+Kid7Wc5fWXZhevA0E=;
  b=ctHaCHRU3YF5OiAcXN5Qu8ufatuiR4+LZFXmievZErVeQjBQXy1njkLk
   xs2KEFWzBcVBdq8YMojfVSV6YPmtfm1gQKRc8xrrtkN3BI3v0BYDgMZWs
   GcFjmnOtLVsKrdzvogOd/E9VqQ5RNQ80unIHnGMjtXGVpPRaC6rejPjA3
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 14 Apr 2022 14:44:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 14:44:55 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 14:44:55 -0700
Received: from [10.110.74.74] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 14:44:54 -0700
Message-ID: <10f77fe4-a1a7-60a2-af98-a6060318ab0d@quicinc.com>
Date:   Thu, 14 Apr 2022 14:44:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: EP clear halt leading to incorrect submission
 of delayed_status
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220407015336.19455-1-quic_wcheng@quicinc.com>
 <20220411154803.GA26372@hu-pkondeti-hyd.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20220411154803.GA26372@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 4/11/2022 8:48 AM, Pavan Kondeti wrote:
> Hi Wesley,
> 
> On Wed, Apr 06, 2022 at 06:53:36PM -0700, Wesley Cheng wrote:
>> The usb_ep_clear_halt() API can be called from the function driver, and
>> translates to dwc3_gadget_ep_set_halt().  This routine is shared with when
>> the host issues a clear feature ENDPOINT_HALT, and is differentiated by the
>> protocol argument.  If the following sequence occurs, there can be a
>> situation where the delayed_status flag is improperly cleared for the wrong
>> SETUP transaction:
>>
>> 1. Vendor specific control transfer returns USB_GADGET_DELAYED_STATUS.
>> 2. DWC3 gadget sets dwc->delayed_status to '1'.
>> 3. Another function driver issues a usb_ep_clear_halt() call.
>> 4. DWC3 gadget issues dwc3_stop_active_transfer() and sets
>>     DWC3_EP_PENDING_CLEAR_STALL.
>> 5. EP command complete interrupt triggers for the end transfer, and
>>     dwc3_ep0_send_delayed_status() is allowed to run, as delayed_status
>>     is '1' due to step#1.
>> 6. STATUS phase is sent, and delayed_status is cleared.
>> 7. Vendor specific control transfer is finished being handled, and issues
>>     usb_composite_setup_continue().  This results in queuing of a data
>>     phase.
>>
>> Cache the protocol flag so that DWC3 gadget is aware of when the clear halt
>> is due to a SETUP request from the host versus when it is sourced from a
>> function driver.  This allows for the EP command complete interrupt to know
>> if it needs to issue a delayed status phase.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.h   | 1 +
>>   drivers/usb/dwc3/ep0.c    | 1 +
>>   drivers/usb/dwc3/gadget.c | 3 ++-
>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 5c9d467195a6..55f98485c54c 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1272,6 +1272,7 @@ struct dwc3 {
>>   	unsigned		connected:1;
>>   	unsigned		softconnect:1;
>>   	unsigned		delayed_status:1;
>> +	unsigned		clear_stall_protocol:1;
>>   	unsigned		ep0_bounced:1;
>>   	unsigned		ep0_expect_in:1;
>>   	unsigned		has_hibernation:1;
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 1064be5518f6..aa8476da222d 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -1080,6 +1080,7 @@ void dwc3_ep0_send_delayed_status(struct dwc3 *dwc)
>>   	unsigned int direction = !dwc->ep0_expect_in;
>>   
>>   	dwc->delayed_status = false;
>> +	dwc->clear_stall_protocol = 0;
>>   
>>   	if (dwc->ep0state != EP0_STATUS_PHASE)
>>   		return;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index ab725d2262d6..c427ddae016f 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2152,6 +2152,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
>>   		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
>>   		    (dep->flags & DWC3_EP_DELAY_STOP)) {
>>   			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
>> +			dwc->clear_stall_protocol = protocol;
>>   			return 0;
>>   		}
>>   
>> @@ -3483,7 +3484,7 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
>>   		}
>>   
>>   		dep->flags &= ~(DWC3_EP_STALL | DWC3_EP_WEDGE);
>> -		if (dwc->delayed_status)
>> +		if (dwc->clear_stall_protocol)
>>   			dwc3_ep0_send_delayed_status(dwc);
>>   	}
>>   
> 
> Is it safe to maintain clear_stall_protocol per dwc3 instance? What if
> CLEAR_FEATURE(halt_endpoint) and usb_ep_clear_halt() are interleaved and
> We come here as part of usb_ep_clear_halt()'s endpoint command complete.
> We may simply send the delayed status corresponding to the protocol clear
> stall.
> 
> We can still maintain a global flag if we cache endpoint number in it so
> that we can cross check against the endpoint for which completion received.
> 
> Thanks,
> Pavan
> 

Thanks for the comments/feedback.  I agree with what you mentioned, and 
will fix that potential condition.  Will resubmit a new rev, after some 
testing.

Thanks
Wesley Cheng
