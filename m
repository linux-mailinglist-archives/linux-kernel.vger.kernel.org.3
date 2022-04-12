Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0954FCE39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbiDLEtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiDLEtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:49:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF727CE7;
        Mon, 11 Apr 2022 21:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649738810; x=1681274810;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=D36bdTmKmEtxRlAo6tPtUnIOLX1K62PUPHnP/fzHo/o=;
  b=togMrhqQmBYiYPIqp8PqEzZRLNQEl9u6UwxXqP63R8I6u1d4gez+8i0n
   K9xJKACAIeJ3IRanFpFiRneQ/nd/ySiQCiF7Q4vdN86x/DAzp4LKLBCEc
   fVJKPtYiQ1DZGqqbHV8c/C9VFxF2kDNJSJI1uS328jD28O7PKsBvJn7iE
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Apr 2022 21:46:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 21:46:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 21:46:48 -0700
Received: from [10.216.54.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 21:46:42 -0700
Subject: Re: [PATCH v13 2/6] usb: dwc3: core: Host wake up support from system
 suspend
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>, <quic_vpulyala@quicinc.com>
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649704614-31518-3-git-send-email-quic_c_sanm@quicinc.com>
 <YlSVec5+SpdMZWCz@google.com>
From:   "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Message-ID: <36d22ad7-7f11-2f63-cd68-5d564476161e@quicinc.com>
Date:   Tue, 12 Apr 2022 10:16:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <YlSVec5+SpdMZWCz@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 4/12/2022 2:24 AM, Matthias Kaehlcke wrote:
> On Tue, Apr 12, 2022 at 12:46:50AM +0530, Sandeep Maheswaram wrote:
>> During suspend read the status of all port and set hs phy mode
>> based on current speed. Use this hs phy mode to configure wakeup
>> interrupts in qcom glue driver.
>>
>> Check wakep-source property for dwc3 core node to set the
> s/wakep/wakeup/
Okay. Will update in next version.
>
>> wakeup capability. Drop the device_init_wakeup call from
>> runtime suspend and resume.
>>
>> Also check during suspend if any wakeup capable devices are
>> connected to the controller (directly or through hubs), if there
>> are none set a flag to indicate that the PHY is powered
>> down during suspend.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
> A per-patch change log would be really helpful for reviewers, even
> if it doesn't include older versions.
Okay. Will update in next version.
>
>>   drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
>>   drivers/usb/dwc3/core.h |  4 ++++
>>   drivers/usb/dwc3/host.c | 25 +++++++++++++++++++++++++
>>   3 files changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 1170b80..effaa43 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/usb/gadget.h>
>>   #include <linux/usb/of.h>
>>   #include <linux/usb/otg.h>
>> +#include <linux/usb/hcd.h>
>>   
>>   #include "core.h"
>>   #include "gadget.h"
>> @@ -1723,6 +1724,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, dwc);
>>   	dwc3_cache_hwparams(dwc);
>> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>>   
>>   	spin_lock_init(&dwc->lock);
>>   	mutex_init(&dwc->mutex);
>> @@ -1865,6 +1867,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   {
>>   	unsigned long	flags;
>>   	u32 reg;
>> +	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
>>   
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>> @@ -1877,10 +1880,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
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
>> @@ -1896,6 +1896,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   
>>   		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>>   		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
>> +
>> +		if (!PMSG_IS_AUTO(msg)) {
>> +			if (device_may_wakeup(dwc->dev) &&
>> +			    usb_wakeup_enabled_descendants(hcd->self.root_hub)) {
> You did not answer my question on v12, reposting it:
>
>    Did you ever try whether you could use device_children_wakeup_capable() from
>    [1] instead of usb_wakeup_enabled_descendants()?
>
>    [1] https://patchwork.kernel.org/project/linux-usb/patch/1635753224-23975-2-git-send-email-quic_c_sanm@quicinc.com/#24566065

Sorry ..I have replied in mail yesterday but it is not showing up in 
patchwork link.

Tried with  device_children_wakeup_capable(dwc->dev) instead of 
usb_wakeup_enabled_descendants and it always returns true even

when no devices are connected.

>
>> +				dwc->phy_power_off = false;
>> +			} else {
>> +				dwc->phy_power_off = true;
>> +				dwc3_core_exit(dwc);
>> +			}
>> +		}
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_OTG:
>>   		/* do nothing during runtime_suspend */
>> @@ -1939,11 +1949,12 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_HOST:
>>   		if (!PMSG_IS_AUTO(msg)) {
>> -			ret = dwc3_core_init_for_resume(dwc);
>> -			if (ret)
>> -				return ret;
>> -			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>> -			break;
>> +			if (dwc->phy_power_off) {
>> +				ret = dwc3_core_init_for_resume(dwc);
>> +				if (ret)
>> +					return ret;
>> +				dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>> +			}
>>   		}
>>   		/* Restore GUSB2PHYCFG bits that were modified in suspend */
>>   		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> @@ -2015,8 +2026,6 @@ static int dwc3_runtime_suspend(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	device_init_wakeup(dev, true);
>> -
>>   	return 0;
>>   }
>>   
>> @@ -2025,8 +2034,6 @@ static int dwc3_runtime_resume(struct device *dev)
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>>   	int		ret;
>>   
>> -	device_init_wakeup(dev, false);
>> -
>>   	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 5c9d467..6a5845f 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1154,6 +1154,9 @@ struct dwc3 {
>>   
>>   	bool			phys_ready;
>>   
>> +	unsigned int            hs_phy_mode;
>> +	bool			phy_power_off;
>> +
>>   	struct ulpi		*ulpi;
>>   	bool			ulpi_ready;
>>   
>> @@ -1537,6 +1540,7 @@ int dwc3_core_soft_reset(struct dwc3 *dwc);
>>   #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>>   int dwc3_host_init(struct dwc3 *dwc);
>>   void dwc3_host_exit(struct dwc3 *dwc);
>> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc);
>>   #else
>>   static inline int dwc3_host_init(struct dwc3 *dwc)
>>   { return 0; }
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index eda8719..7f22675 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/platform_device.h>
>>   
>>   #include "core.h"
>> +#include "../host/xhci.h"
>>   
>>   static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>>   					int irq, char *name)
>> @@ -138,3 +139,27 @@ void dwc3_host_exit(struct dwc3 *dwc)
>>   {
>>   	platform_device_unregister(dwc->xhci);
>>   }
>> +
>> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc)
>> +{
>> +
> delete empty line
Okay. Will update in next version.
>
>> +	int i, num_ports;
>> +	u32 reg;
>> +	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
>> +	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
>> +
>> +	dwc->hs_phy_mode = 0;
>> +
>> +	reg = readl(&xhci_hcd->cap_regs->hcs_params1);
>> +
>> +	num_ports = HCS_MAX_PORTS(reg);
>> +	for (i = 0; i < num_ports; i++) {
>> +		reg = readl(&xhci_hcd->op_regs->port_status_base + i * NUM_PORT_REGS);
>> +		if (reg & PORT_PE) {
>> +			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
>> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
>> +			else if (DEV_LOWSPEED(reg))
>> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
>> +		}
>> +	}
>> +}
>> -- 
>> 2.7.4
>>
