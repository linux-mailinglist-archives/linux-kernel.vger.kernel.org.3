Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168EF57BE17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiGTSvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGTSvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:51:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3047BA0;
        Wed, 20 Jul 2022 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658343067; x=1689879067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=31aoo9bp1wIMFqWUajED9dirY3x3ItLRRWPOC75kWEc=;
  b=XCLDFAz8WoqTmBKATRBTVV1gHWbGH2O3x/DaI55WHThdCbTumIIMDRkC
   pWtK4mOG9JgGPo//pLVShIHvvl0TXx+e7KbeNPcLunIm6iU/8dSYj7J/E
   HNe/qnAoxzsVQJPzSNLCrhpYwZkB0gyxipiGJBF1uhguzNYDvTg4UIZgm
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jul 2022 11:51:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 11:51:06 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 11:51:06 -0700
Received: from [10.110.25.47] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 11:51:05 -0700
Message-ID: <3e6867cc-489a-b626-ff9c-79615613b2dd@quicinc.com>
Date:   Wed, 20 Jul 2022 11:50:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/5] usb: dwc3: gadget: Adjust IRQ management during
 soft disconnect/connect
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20220713003523.29309-1-quic_wcheng@quicinc.com>
 <20220713003523.29309-4-quic_wcheng@quicinc.com>
 <fbfc9328-418c-4c5e-4553-993331b20cb6@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <fbfc9328-418c-4c5e-4553-993331b20cb6@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/14/2022 10:38 AM, Thinh Nguyen wrote:
> On 7/12/2022, Wesley Cheng wrote:
>> Local interrupts are currently being disabled as part of aquiring the
>> spin lock before issuing the endxfer command.  Leave interrupts enabled, so
>> that EP0 events can continue to be processed.  Also, ensure that there are
>> no pending interrupts before attempting to handle any soft
>> connect/disconnect.
>>
>> Fixes: 861c010a2ee1 ("usb: dwc3: gadget: Refactor pullup()")
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>    drivers/usb/dwc3/gadget.c | 21 ++++++++++++---------
>>    1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index a455f8d4631d..ee85b773e3fe 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1674,6 +1674,7 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
>>    static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
>>    {
>>    	struct dwc3_gadget_ep_cmd_params params;
>> +	struct dwc3 *dwc = dep->dwc;
>>    	u32 cmd;
>>    	int ret;
>>    
>> @@ -1682,7 +1683,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>>    	cmd |= interrupt ? DWC3_DEPCMD_CMDIOC : 0;
>>    	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
>>    	memset(&params, 0, sizeof(params));
>> +	spin_unlock(&dwc->lock);
>>    	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
>> +	spin_lock(&dwc->lock);
>>    	WARN_ON_ONCE(ret);
>>    	dep->resource_index = 0;
>>    
>> @@ -2029,12 +2032,11 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>>    	struct dwc3_ep			*dep = to_dwc3_ep(ep);
>>    	struct dwc3			*dwc = dep->dwc;
>>    
>> -	unsigned long			flags;
>>    	int				ret = 0;
>>    
>>    	trace_dwc3_ep_dequeue(req);
>>    
>> -	spin_lock_irqsave(&dwc->lock, flags);
>> +	spin_lock(&dwc->lock);
>>    
>>    	list_for_each_entry(r, &dep->cancelled_list, list) {
>>    		if (r == req)
>> @@ -2073,7 +2075,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>>    		request, ep->name);
>>    	ret = -EINVAL;
>>    out:
>> -	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	spin_unlock(&dwc->lock);
>>    
>>    	return ret;
>>    }
>> @@ -2489,9 +2491,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc);
>>    
>>    static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>>    {
>> -	unsigned long flags;
>> -
>> -	spin_lock_irqsave(&dwc->lock, flags);
>> +	spin_lock(&dwc->lock);
>>    	dwc->connected = false;
>>    
>>    	/*
>> @@ -2506,10 +2506,10 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>>    
>>    		reinit_completion(&dwc->ep0_in_setup);
>>    
>> -		spin_unlock_irqrestore(&dwc->lock, flags);
>> +		spin_unlock(&dwc->lock);
>>    		ret = wait_for_completion_timeout(&dwc->ep0_in_setup,
>>    				msecs_to_jiffies(DWC3_PULL_UP_TIMEOUT));
>> -		spin_lock_irqsave(&dwc->lock, flags);
>> +		spin_lock(&dwc->lock);
>>    		if (ret == 0)
>>    			dev_warn(dwc->dev, "timed out waiting for SETUP phase\n");
>>    	}
>> @@ -2523,7 +2523,7 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>>    	 */
>>    	dwc3_stop_active_transfers(dwc);
>>    	__dwc3_gadget_stop(dwc);
>> -	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	spin_unlock(&dwc->lock);
>>    
>>    	/*
>>    	 * Note: if the GEVNTCOUNT indicates events in the event buffer, the
>> @@ -2569,6 +2569,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>    		return 0;
>>    	}
>>    
>> +	synchronize_irq(dwc->irq_gadget);
>> +
>>    	if (!is_on) {
>>    		ret = dwc3_gadget_soft_disconnect(dwc);
>>    	} else {
>> @@ -3729,6 +3731,7 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>>    	 */
>>    
>>    	__dwc3_stop_active_transfer(dep, force, interrupt);
>> +
>>    }
>>    
>>    static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
> 
> Hi Greg,
> 
> Please don't pick up this patch yet. We're still in discussion with
> this. I have some concern with unlocking/locking when sending End
> Transfer command. For example, this patch may cause issues with
> DWC3_EP_END_TRANSFER_PENDING checks.
> 
> Hi Wesley,
> 
> Did you try out my suggestion yet?
> 

Just providing a quick update.

So with your suggestion, I was able to consistently reproduce the 
controller halt issue after a day or so of testing.  However, when I 
took a further look, I believe the problem is due to the DWC3 event handler:

static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
		const struct dwc3_event_depevt *event)
{
...
	if (!(dep->flags & DWC3_EP_ENABLED)) {
		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
			return;

		/* Handle only EPCMDCMPLT when EP disabled */
		if (event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT)
			return;
	}

The soft disconnect routine reached to the run/stop polling point, and I 
could see that DWC3_EP_DELAYED_STOP was set, and we got a xfercomplete 
event for the STATUS phase.  However, since we exit early in the event 
handler (due to __dwc3_gadget_stop() being called and disabling EP0), 
the STATUS complete is never handled, and we do not issue the endxfer 
command.

I don't think I saw this issue with my change, as we allowed the STATUS 
phase handling to happen BEFORE gadget stop was called (since I released 
the lock in the stop active transfers API).

However, I think even with my approach, we'd eventually run into a 
possibility of this issue, as we aren't truly handling EP0 events while 
polling for the halted status due to the above.  It was just reducing 
the chances.  The scenario of this issue is coming because the host took 
a long time to complete the STATUS phase, so we ran into a "timed out 
waiting for SETUP phase," which allowed us to call the run/stop routine 
while we were not yet in the SETUP phase.

I'm currently running a change to add a EP num check to this IF condition:

	if ((epnum > 1) && !(dep->flags & DWC3_EP_ENABLED)) {
		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
			return;

		/* Handle only EPCMDCMPLT when EP disabled */
		if (event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT)
			return;
	}

Thanks
Wesley Cheng
