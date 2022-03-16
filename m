Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C084DA73F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352906AbiCPBMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiCPBMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:12:20 -0400
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id B29CD43EE2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:11:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1647393063; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: From: References: Cc: To: To: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=rJzMOl9nxtt7GhGevUnuI0rIWjcbPz3Dla8Nb02HdiQ=; b=MOILiI//6EIFjNzX94+ysYV55A8YEiGdJ3Ki3aSjGbqbgO4LfK+bWwn3yV9MV7U77mDTkP20
 K5MM7jYN0PZW3wnEe6OjkF8d54ODl7LOFnJHjULWTUY6ybRbU3TY0Hu24ZTPxMSmf9qSTCuH
 hOQFeC8g0joN5oARFVlnqhxFlu8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 623139262f1b1e8f798c9830 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Mar 2022 01:11:02
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 989BFC4360C; Wed, 16 Mar 2022 01:11:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from [192.168.1.17] (cpe-75-80-185-151.san.res.rr.com [75.80.185.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEA1BC4338F;
        Wed, 16 Mar 2022 01:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BEA1BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <7bbbe944-a28d-e45b-a189-0aa1dfdb3ebe@codeaurora.org>
Date:   Tue, 15 Mar 2022 18:10:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] usb: dwc3: Issue core soft reset before enabling
 run/stop
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20220315014317.14265-1-quic_wcheng@quicinc.com>
 <1e2ae095-4933-b268-ffa6-2899d49bffa2@synopsys.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
In-Reply-To: <1e2ae095-4933-b268-ffa6-2899d49bffa2@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2022 5:28 PM, Thinh Nguyen wrote:
> Wesley Cheng wrote:
>> It is recommended by the Synopsis databook to issue a DCTL.CSftReset
>> when reconnecting from a device-initiated disconnect routine.  This
>> resolves issues with enumeration during fast composition switching
>> cases, which result in an unknown device on the host.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>  Changes in v3:
>>    - Removed change from RFC series and placed into its own patch.
>>
>>  Previous patches:
>>   https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20220203080017.27339-1-quic_wcheng@quicinc.com/__;!!A4F2R9G_pg!OjNviLgYSUvXpUWpeTDiI6OVuwjW2kjQpACAYYo5MdI09GClnUHLGFjuoMrtquF8Qe9X$ 
>>
>>  drivers/usb/dwc3/core.c   |  4 +---
>>  drivers/usb/dwc3/core.h   |  2 ++
>>  drivers/usb/dwc3/gadget.c | 11 +++++++++++
>>  3 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 18adddfba3da..02d10e1cb774 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -115,8 +115,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>>  	dwc->current_dr_role = mode;
>>  }
>>  
>> -static int dwc3_core_soft_reset(struct dwc3 *dwc);
>> -
>>  static void __dwc3_set_mode(struct work_struct *work)
>>  {
>>  	struct dwc3 *dwc = work_to_dwc(work);
>> @@ -261,7 +259,7 @@ u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
>>   * dwc3_core_soft_reset - Issues core soft reset and PHY reset
>>   * @dwc: pointer to our context structure
>>   */
>> -static int dwc3_core_soft_reset(struct dwc3 *dwc)
>> +int dwc3_core_soft_reset(struct dwc3 *dwc)
>>  {
>>  	u32		reg;
>>  	int		retries = 1000;
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index eb9c1efced05..86e27afef6c5 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1530,6 +1530,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
>>  int dwc3_event_buffers_setup(struct dwc3 *dwc);
>>  void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>>  
>> +int dwc3_core_soft_reset(struct dwc3 *dwc);
>> +
>>  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>>  int dwc3_host_init(struct dwc3 *dwc);
>>  void dwc3_host_exit(struct dwc3 *dwc);
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index a0c883f19a41..448ff6cb9c22 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2544,6 +2544,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  						dwc->ev_buf->length;
>>  		}
>>  	} else {
>> +		/*
>> +		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 1.90a
Hi Thinh,

Thanks for the review.
> 
> It's "Synopsys". Version 1.90a is for DWC_usb31 controller.
> 
Ah, I need to get the incorrect spelling out of my head! :)

>> +		 * Section 4.1.9, it specifies that for a reconnect after a
>> +		 * device-initiated disconnect requires a core soft reset
>> +		 * (DCTL.CSftRst) before enabling the run/stop bit.
> 
> Just want to note that we're skipping some controller initialization on
> soft-reset here. But it's probably fine because the global registers
> don't get reset on soft reset. Just need to make sure that the registers
> that do get reset get reinitialized on __dwc3_gadget_start().
> 
>> +		 */
>> +		spin_unlock_irqrestore(&dwc->lock, flags);
>> +		dwc3_core_soft_reset(dwc);
>> +		spin_lock_irqsave(&dwc->lock, flags);
>> +
>> +		dwc3_event_buffers_setup(dwc);
>>  		__dwc3_gadget_start(dwc);
>>  	}
>>  
> 
> It's a little awkward because dwc3 also issues soft-reset during driver
> probe. Pullup() is called during driver bindings. So soft-reset is
> called multiple times. I don't have a better solution at the moment, but
> I don't see a problem with it either.
> Correct...this would mainly help w/ the soft connect/disconnect
situations.  Will fixup the typos and resend.

> After fixing the typos,
> 
> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> Thanks,
> Thinh

Thanks
Wesley Cheng

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
