Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE23C574BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiGNLPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGNLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:15:08 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9432BB2F;
        Thu, 14 Jul 2022 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657797306; x=1689333306;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sw5EplmL3w6i8CD/F39nsF5FlsG6fRIGVS912+rz3j4=;
  b=eVVPpcnJsJHp7pXqV/lbkcAPN/aOhYspmMZkr9eeTYss2GXxact+OdRN
   +iEF+8eSL4D8UplEXY1T3i35XwkS4f+QvXaVy9rjEb3RxPK9ysHlEk1ag
   qUY4qfp2oPjdRjMq/mKNvT9tKUEYFE8qH7JMw++6p9c6gB0bQgsfylEwW
   w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jul 2022 04:15:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:15:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 04:15:05 -0700
Received: from [10.206.25.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 04:15:03 -0700
Message-ID: <c8ce4a22-7394-5d20-1a8c-627c5cb666e7@quicinc.com>
Date:   Thu, 14 Jul 2022 16:44:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET
 during bootup
Content-Language: en-CA
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220712174423.20484-1-quic_rkollals@quicinc.com>
 <889f7a73-d8d9-2e40-3386-e8f3f30cad24@synopsys.com>
From:   Rohith Kollalsi <quic_rkollals@quicinc.com>
In-Reply-To: <889f7a73-d8d9-2e40-3386-e8f3f30cad24@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2022 6:36 AM, Thinh Nguyen wrote:
> On 7/12/2022, Rohith Kollalsi wrote:
>> According to the programming guide, it is recommended to
>> perform a GCTL_CORE_SOFTRESET only when switching the mode
>> from device to host or host to device. However, it is found
>> that during bootup when __dwc3_set_mode() is called for the
>> first time, GCTL_CORESOFTRESET is done with suspendable bit(BIT 17)
>> of DWC3_GUSB3PIPECTL set. This some times leads to issues
>> like controller going into bad state and controller registers
>> reading value zero. Until GCTL_CORESOFTRESET is done and
>> run/stop bit is set core initialization is not complete.
>> Setting suspendable bit of DWC3_GUSB3PIPECTL and then
>> performing GCTL_CORESOFTRESET is therefore not recommended.
>> Avoid this by only performing the reset if current_dr_role is set,
>> that is, when doing subsequent role switching.
>>
>> Fixes: f88359e1588b ("usb: dwc3: core: Do core softreset when switch mode")
>> Signed-off-by: Rohith Kollalsi <quic_rkollals@quicinc.com>
>> ---
>>    drivers/usb/dwc3/core.c | 10 +++++++---
>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 050b2ba5986d..7ce0e033d755 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -158,9 +158,13 @@ static void __dwc3_set_mode(struct work_struct *work)
>>    		break;
>>    	}
>>    
>> -	/* For DRD host or device mode only */
>> -	if ((DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
>> -	    dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG) {
>> +	/*
>> +	 * When current_dr_role is zero, do not perform GCTL_CORESOFTRESET.
> 
> The line above doesn't really explain why. Can you rephrase it to
> something like this or the equivalent:
> "When current_dr_role is not set, there's no role switching. Only
> perform GCTL.CoreSoftReset when there's DRD role switching."
> 
> Thanks,
> Thinh

Thanks for the review Thinh, I have updated the next version of the 
patch with this suggestion.

Thanks,
Rohith

> 
>> +	 * Perform it only for DRD host or device mode.
>> +	 */
>> +	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
>> +			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
>> +			dwc->desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
>>    		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>>    		reg |= DWC3_GCTL_CORESOFTRESET;
>>    		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> 
