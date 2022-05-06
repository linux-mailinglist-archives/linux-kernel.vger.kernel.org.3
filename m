Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672C151D07F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiEFFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiEFFOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:14:53 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1885DA17;
        Thu,  5 May 2022 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651813871; x=1683349871;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LWa/GCb2e9nLWQ6HBGCRCWwheNv3vZF6ySDulKPKY7E=;
  b=Tr0y5sQhMBXnZrgpOaLQLrZQl0/f2SY8cHGIQw7DYdk1PObn5/fX8//h
   RHksbNsn19kqQbfGsVoqrLfXmEro8YQAnjFl5zbsq6+I4MNh8dIn2kHoB
   VpG/X8PL1gRlB1aEgz/M5/eGgTFXnuAQA+fWtjiufz6R81fZcbWYOiznn
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 May 2022 22:11:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:11:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 22:11:10 -0700
Received: from [10.206.28.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 22:11:04 -0700
Message-ID: <a83dea08-0920-17e6-ec1c-f9d8a490a08d@quicinc.com>
Date:   Fri, 6 May 2022 10:41:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [v15 3/6] usb: dwc3: core: Host wake up support from system
 suspend
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
References: <1651740973-7944-1-git-send-email-quic_kriskura@quicinc.com>
 <1651740973-7944-4-git-send-email-quic_kriskura@quicinc.com>
 <YnRUPxBZB55TPmf2@google.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <YnRUPxBZB55TPmf2@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/6/2022 4:18 AM, Matthias Kaehlcke wrote:
> On Thu, May 05, 2022 at 02:26:10PM +0530, Krishna Kurapati wrote:
>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>
>> During suspend read the status of all port and set hs phy mode
>> based on current speed. Use this hs phy mode to configure wakeup
>> interrupts in qcom glue driver.
>>
>> Check wakeup-source property for dwc3 core node to set the
>> wakeup capability. Drop the device_init_wakeup call from
>> runtime suspend and resume.
>>
>> Also check during suspend if any wakeup capable devices are
>> connected to the controller (directly or through hubs), if there
>> are none set a flag to indicate that the PHY is powered
>> down during suspend.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
>>   drivers/usb/dwc3/core.h |  4 ++++
>>   drivers/usb/dwc3/host.c | 24 ++++++++++++++++++++++++
>>   3 files changed, 48 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 950e238..cf377f5 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -33,6 +33,7 @@
>>   #include <linux/usb/gadget.h>
>>   #include <linux/usb/of.h>
>>   #include <linux/usb/otg.h>
>> +#include <linux/usb/hcd.h>
> This is not needed anymore
>
>>   
>>   #include "core.h"
>>   #include "gadget.h"
>> @@ -1787,6 +1788,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, dwc);
>>   	dwc3_cache_hwparams(dwc);
>> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>>   
>>   	spin_lock_init(&dwc->lock);
>>   	mutex_init(&dwc->mutex);
>> @@ -1936,6 +1938,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   {
>>   	unsigned long	flags;
>>   	u32 reg;
>> +	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
> This isn't used anymore, delete it
My bad, Will fix this in next version.
>>   
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>> @@ -1948,10 +1951,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   		dwc3_core_exit(dwc);
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_HOST:
>> -		if (!PMSG_IS_AUTO(msg)) {
>> -			dwc3_core_exit(dwc);
>> -			break;
>> -		}
>> +		dwc3_check_phy_speed_mode(dwc);
>>   
>>   		/* Let controller to suspend HSPHY before PHY driver suspends */
>>   		if (dwc->dis_u2_susphy_quirk ||
>> @@ -1967,6 +1967,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   
>>   		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>>   		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
>> +
>> +		if (!PMSG_IS_AUTO(msg)) {
>> +			if (device_may_wakeup(dwc->dev) &&
>> +					device_wakeup_path(dwc->dev)) {
> nit: the indentation is odd, align it with device_may_wakeup()?
Sure, Will take care of it.
>> +				dwc->phy_power_off = false;
>> +			} else {
>> +				dwc->phy_power_off = true;
>> +				dwc3_core_exit(dwc);
> As commented earlier, taking the controller and PHYs completely down causes a
> significant power draw in some USB clients. Let's clarify what the specific
> benefits are of doing dwc3_core_exit() vs. entering a low power mode.
Sure, once we come to a conclusion on this, I will refresh the patches.
