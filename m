Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C504D3960
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiCITCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiCITCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:02:18 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 894FBD8859
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:01:19 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646852479; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: From: References: Cc: To: To: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=8C+xvbuy9RSAyuvBy0Tm2WB0XWQS+wESHMb9s4mczek=; b=jwJgT9q/FjszCZkynYwKJZQ43AVCy8WCi2Sk2dcEVVihyrRSisSJlTrzibbr25oO1cA4g+22
 86rsdu6AtiBICiiNOFDUuD+TqZkNXa8D8xx9bq8Nxl/rsC67WLl5lmlyFuxMQQu6BcMSRO+w
 fTLn4olMNG91ZlVL9HXGPwFLpK8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6228f97ea1f319ec73aeae5c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Mar 2022 19:01:18
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 605B1C4360D; Wed,  9 Mar 2022 19:01:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from [192.168.1.17] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0D4FC4338F;
        Wed,  9 Mar 2022 19:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B0D4FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <d8eb4c9d-3c68-b7f0-2dd6-600a542a64d1@codeaurora.org>
Date:   Wed, 9 Mar 2022 11:01:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] usb: dwc3: gadget: Wait for ep0 xfers to complete during
 dequeue
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
References: <20220309004148.12061-1-quic_wcheng@quicinc.com>
 <Yih/tapu/JMRgBqT@kroah.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <Yih/tapu/JMRgBqT@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 3/9/2022 2:21 AM, Greg KH wrote:
> On Tue, Mar 08, 2022 at 04:41:48PM -0800, Wesley Cheng wrote:
>> From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>
>> If the request being dequeued is currently active, then the current
>> logic is to issue a stop transfer command, and allow the command
>> completion to cleanup the cancelled list.  The DWC3 controller will
>> run into an end transfer command timeout if there is an ongoing EP0
>> transaction.  If this is the case, wait for the EP0 completion event
>> before proceeding to retry the endxfer command again.
>>
>> Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> 
> You sent this twice?  What is the differences between the patches?
> 
Sorry for sending it twice.  It was a mistake on my end, where I thought
the patch wasn't getting sent out by our email server, so I sent it out
several times to check.  Ended up just showing up after 30 mins or so :/.
> And as you sent it, your signed-off-by needs to be at the end, as per
> the kernel documentation.
> 
I'll fix this.
>> ---
>>  Patch discussion below:
>>    https://lore.kernel.org/linux-usb/1644836933-141376-1-git-send-email-dh10.jung@samsung.com/T/#t
> 
> So this is a v2?
> 
> 
This is an entirely different change, but the change was discussed in
the above thread.
>>
>>  drivers/usb/dwc3/core.h   |  2 +-
>>  drivers/usb/dwc3/ep0.c    | 14 ++++++++++++++
>>  drivers/usb/dwc3/gadget.c | 13 ++++++++-----
>>  drivers/usb/dwc3/gadget.h |  1 +
>>  4 files changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index eb9c1efced05..f557f5f36a7f 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -736,7 +736,7 @@ struct dwc3_ep {
>>  #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
>>  #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
>>  #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
>> -
>> +#define DWC3_EP_DELAY_STOP             BIT(13)
> 
> Why did you loose the blank line?
> 
I can add that back in.

Thanks
Wesley Cheng

>>  	/* This last one is specific to EP0 */
>>  #define DWC3_EP0_DIR_IN			BIT(31)
>>  
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 658739410992..1064be5518f6 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -271,6 +271,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>  {
>>  	struct dwc3_ep			*dep;
>>  	int				ret;
>> +	int                             i;
>>  
>>  	complete(&dwc->ep0_in_setup);
>>  
>> @@ -279,6 +280,19 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>>  			DWC3_TRBCTL_CONTROL_SETUP, false);
>>  	ret = dwc3_ep0_start_trans(dep);
>>  	WARN_ON(ret < 0);
>> +	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
>> +		struct dwc3_ep *dwc3_ep;
>> +
>> +		dwc3_ep = dwc->eps[i];
>> +		if (!dwc3_ep)
>> +			continue;
>> +
>> +		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
>> +			continue;
>> +
>> +		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
>> +		dwc3_stop_active_transfer(dwc3_ep, true, true);
>> +	}
>>  }
>>  
>>  static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index a0c883f19a41..ccef508b1296 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -654,9 +654,6 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
>>  	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
>>  }
>>  
>> -static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>> -		bool interrupt);
>> -
>>  /**
>>   * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
>>   * @dwc: pointer to the DWC3 context
>> @@ -1899,6 +1896,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>>  	 */
>>  	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
>>  	    (dep->flags & DWC3_EP_WEDGE) ||
>> +	    (dep->flags & DWC3_EP_DELAY_STOP) ||
>>  	    (dep->flags & DWC3_EP_STALL)) {
>>  		dep->flags |= DWC3_EP_DELAY_START;
>>  		return 0;
>> @@ -2033,6 +2031,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>>  		if (r == req) {
>>  			struct dwc3_request *t;
>>  
>> +			if (dwc->ep0state != EP0_SETUP_PHASE && !dwc->delayed_status)
>> +				dep->flags |= DWC3_EP_DELAY_STOP;
>> +
>>  			/* wait until it is processed */
>>  			dwc3_stop_active_transfer(dep, true, true);
>>  
>> @@ -2116,7 +2117,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
>>  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
>>  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
>>  
>> -		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
>> +		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
>> +		    (dep->flags & DWC3_EP_DELAY_STOP)) {
>>  			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
>>  			return 0;
>>  		}
>> @@ -3596,7 +3598,7 @@ static void dwc3_reset_gadget(struct dwc3 *dwc)
>>  	}
>>  }
>>  
>> -static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>> +void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
>>  	bool interrupt)
> 
> This is a horrid api (2 booleans?)  But you aren't adding it so I guess
> we can live with it :(
> 
> thanks,
> 
> greg k-h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
