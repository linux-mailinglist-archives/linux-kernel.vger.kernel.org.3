Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE39525A73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376914AbiEMD6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353234AbiEMD63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:58:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277B61284;
        Thu, 12 May 2022 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652414307; x=1683950307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ncB+8XgICxsWrmIQFS+DFHIYDncUBCYudRXyg37O6lc=;
  b=WzyrJJ0QnXNIkCOouDpZ9vuAmKjJGhio675Wdu7HZgXX+bKLfzT3eXMg
   U9vuJjslAUo6JqqcmeqefVWIhnDsj6EAt4VmLvxrsaiMF90JSpdl5JRs2
   MVndaBCPdz9aZHmdCIuuOo7r3DzIk6OHvackBRezlj4z/IVg9xMv1t+vI
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 May 2022 20:58:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 20:58:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 20:58:26 -0700
Received: from [10.216.41.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 12 May
 2022 20:58:19 -0700
Message-ID: <4124392b-a40f-c204-f9b0-68c3b22dd652@quicinc.com>
Date:   Fri, 13 May 2022 09:28:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [v16 2/5] usb: dwc3: core: Host wake up support from system
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
References: <1652379802-8318-1-git-send-email-quic_kriskura@quicinc.com>
 <1652379802-8318-3-git-send-email-quic_kriskura@quicinc.com>
 <Yn2M5hrah78jro1C@google.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <Yn2M5hrah78jro1C@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/2022 4:10 AM, Matthias Kaehlcke wrote:
> On Thu, May 12, 2022 at 11:53:19PM +0530, Krishna Kurapati wrote:
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
>>   drivers/usb/dwc3/core.c | 30 +++++++++++++++++-------------
>>   drivers/usb/dwc3/core.h |  4 ++++
>>   drivers/usb/dwc3/host.c | 24 ++++++++++++++++++++++++
>>   3 files changed, 45 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 01115df..8bcabc5 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1785,6 +1785,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, dwc);
>>   	dwc3_cache_hwparams(dwc);
>> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>>   
>>   	spin_lock_init(&dwc->lock);
>>   	mutex_init(&dwc->mutex);
>> @@ -1946,10 +1947,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
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
>> @@ -1965,6 +1963,15 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   
>>   		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>>   		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
>> +
>> +		if (!PMSG_IS_AUTO(msg)) {
>> +			if (device_may_wakeup(dwc->dev))
> I think this should be device_can_wakeup(), i.e. hardware capability instead of
> device policy. A drawback of powering the PHYs off is that it causes a high
> power consumption of certain peripherals if VBUS is still supplied, so this
> should be limited to platforms where the PHYs must be powered off (using wakeup
> capability as a proxy for now).
Thnaks Mathias for the review. Will make this change in the next patchset.
>> +				dwc->phy_power_off = false;
>> +			else {
>> +				dwc->phy_power_off = true;
>> +				dwc3_core_exit(dwc);
>> +			}
>> +		}
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_OTG:
>>   		/* do nothing during runtime_suspend */
>> @@ -2008,11 +2015,12 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
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
>> @@ -2084,8 +2092,6 @@ static int dwc3_runtime_suspend(struct device *dev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	device_init_wakeup(dev, true);
>> -
>>   	return 0;
>>   }
>>   
>> @@ -2094,8 +2100,6 @@ static int dwc3_runtime_resume(struct device *dev)
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>>   	int		ret;
>>   
>> -	device_init_wakeup(dev, false);
>> -
>>   	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 81c486b..37397a8 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1155,6 +1155,9 @@ struct dwc3 {
>>   
>>   	bool			phys_ready;
>>   
>> +	unsigned int            hs_phy_mode;
>> +	bool			phy_power_off;
>> +
>>   	struct ulpi		*ulpi;
>>   	bool			ulpi_ready;
>>   
>> @@ -1539,6 +1542,7 @@ int dwc3_core_soft_reset(struct dwc3 *dwc);
>>   #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>>   int dwc3_host_init(struct dwc3 *dwc);
>>   void dwc3_host_exit(struct dwc3 *dwc);
>> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc);
>>   #else
>>   static inline int dwc3_host_init(struct dwc3 *dwc)
>>   { return 0; }
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index f56c30c..e19b40a 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/platform_device.h>
>>   
>>   #include "core.h"
>> +#include "../host/xhci.h"
>>   
>>   static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>>   					int irq, char *name)
>> @@ -136,3 +137,26 @@ void dwc3_host_exit(struct dwc3 *dwc)
>>   {
>>   	platform_device_unregister(dwc->xhci);
>>   }
>> +
>> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc)
>> +{
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
> I anticipate that it might raise concerns from maintainers that
> dwc3_check_phy_speed_mode() accesses xHCI data structures and
> registers directly. Could there be a generic HCD API that provides
> this functionality (if implemented by the specific HCD)?

Hi Mathias, we are not sure if there is any such API present currently.

Hi Alan, can you help suggest any API (if present) that we can reuse 
here to avoid

xhci registers and structs here in dwc3.

