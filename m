Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725A04BA91C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244892AbiBQTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:01:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiBQTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:01:29 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F96E571;
        Thu, 17 Feb 2022 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645124474; x=1676660474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rGQbtp9LqUoh9hT+Zf+fO3W2z/XIBzvIThYzhRbRBjs=;
  b=tMP0RfGeXjUOx9u0u2RUzc5AGqX5I9VsAwtQ2k0iGB9PJGGzPq9WT69l
   taQC26d92U/0J1J/QmIkHHgljfW2IBCJ05yAlLSBxFotMnhsYAboiNL7h
   bMcasxmgA/xeWI+SYR0RMFFtnnhavsb5zR++xWXG53mHQlpF3OjsP5KeU
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Feb 2022 11:01:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:01:13 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 11:01:13 -0800
Received: from [10.110.4.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 17 Feb
 2022 11:01:12 -0800
Message-ID: <308846c0-0d41-9e2e-cfe0-210af74500ad@quicinc.com>
Date:   Thu, 17 Feb 2022 11:01:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH v2 3/3] usb: dwc3: Issue core soft reset before
 enabling run/stop
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <Thinh.Nguyen@synopsys.com>
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
 <CGME20220216000912epcas2p419fb5d4f7044389451e28802dd471c5e@epcas2p4.samsung.com>
 <20220216000835.25400-4-quic_wcheng@quicinc.com>
 <20220217055214.GA152781@ubuntu>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20220217055214.GA152781@ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Hi Daehwan,

On 2/16/2022 9:52 PM, Jung Daehwan wrote:
> Hi wesley,
> 
> On Tue, Feb 15, 2022 at 04:08:35PM -0800, Wesley Cheng wrote:
>> It is recommended by the Synopsis databook to issue a DCTL.CSftReset
>> when reconnecting from a device-initiated disconnect routine.  This
>> resolves issues with enumeration during fast composition switching
>> cases, which result in an unknown device on the host.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
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
>> index 00348d6d479b..b27ad8dad317 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1532,6 +1532,8 @@ bool dwc3_has_imod(struct dwc3 *dwc);
>>  int dwc3_event_buffers_setup(struct dwc3 *dwc);
>>  void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>>  
>> +int dwc3_core_soft_reset(struct dwc3 *dwc);
>> +
>>  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>>  int dwc3_host_init(struct dwc3 *dwc);
>>  void dwc3_host_exit(struct dwc3 *dwc);
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 0c89baedf220..788889f924f9 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2585,6 +2585,17 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>  						dwc->ev_buf->length;
>>  		}
>>  	} else {
>> +		/*
>> +		 * In the Synopsis DesignWare Cores USB3 Databook Rev. 1.90a
>> +		 * Section 4.1.9, it specifies that for a reconnect after a
>> +		 * device-initiated disconnect requires a core soft reset
>> +		 * (DCTL.CSftRst) before enabling the run/stop bit.
>> +		 */
>> +		spin_unlock_irqrestore(&dwc->lock, flags);
>> +		dwc3_core_soft_reset(dwc);
>> +		spin_lock_irqsave(&dwc->lock, flags);
>> +
>> +		dwc3_event_buffers_setup(dwc);
> 
> Could you tell me why you add dwc3_event_buffer_setup?
> 
During my testing if the event buffer re-initialization is not there,
then it resulted in the controller attempting to access an invalid
address space after the soft reset completed. (SMMU fault w/ FAR=0x0)

Likewise, in other scenarios where core soft reset is called, there is
always an event buffer re-init following it.

Thanks
Wesley Cheng
