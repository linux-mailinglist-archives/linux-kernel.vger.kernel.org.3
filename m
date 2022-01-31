Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1784A3D82
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiAaFuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:50:35 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:14930 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiAaFuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643608233; x=1675144233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NSbTVg5sCTdAmXBhRH2OYQg5Av98vgep7b61yDctVLE=;
  b=VYrVve/PxUV8im4tg2aD4vx0NjtdVp9iMnfY3ywqPLxTYtFD6YOtffZG
   vTYC7ExoKukI0tqx6ITISPJ3I5M/L+wAJzyBYQIi1/p4tBAR6Ywi9UR3T
   vZhxKuY+dvPUghIYanRjL/VjPmduk/RlwZBAJf+UNkBywUWEWoLci/6ru
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Jan 2022 21:50:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 21:50:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 30 Jan 2022 21:50:16 -0800
Received: from [10.50.8.93] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 30 Jan
 2022 21:50:09 -0800
Message-ID: <bf41cb03-a836-11ed-c203-d78d420eca99@quicinc.com>
Date:   Mon, 31 Jan 2022 11:19:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 3/6] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <greg@kroah.com>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <7ccee5ae484e6917f5838c8abde368680ec63d05.1642768837.git.quic_schowdhu@quicinc.com>
 <YfDSZTZOryQuWIlJ@builder.lan>
 <c072d162-e371-e44b-8160-d06a8a6c051c@quicinc.com> <YfQVpzZ42MdJkkZW@ripper>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YfQVpzZ42MdJkkZW@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/2022 9:41 PM, Bjorn Andersson wrote:
> On Thu 27 Jan 04:01 PST 2022, Souradeep Chowdhury wrote:
>
>> On 1/26/2022 10:17 AM, Bjorn Andersson wrote:
>>> On Fri 21 Jan 07:53 CST 2022, Souradeep Chowdhury wrote:
> [..]
>>>> +		return PTR_ERR(chip->base);
>>>> +
>>>> +	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
>>>> +	if (IS_ERR(chip->mode_mgr))
>>>> +		return PTR_ERR(chip->mode_mgr);
>>>> +
>>>> +	chip->irq = platform_get_irq(pdev, 0);
>>>> +	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
>>>> +			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
>>>> +	if (ret)
>>>> +		return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
>>>> +
>>>> +	enable_irq_wake(chip->irq);
>>>> +
>>>> +	platform_set_drvdata(pdev, chip);
>>>> +
>>>> +	return 0;
>>> Per the updated binding, the EUD would now be a usb-role-switch as well
>>> and when not enabled should simply propagate the incoming requests. So I
>>> was expecting this to register as a usb_role_switch as well...
>> Can you please elaborate on this?
>>
>> Do I need to define a separate 'usb_role_switch_desc' here and register
>> using 'usb_role_switch_register'?
>>
>> Also what should be the set method in this case for usb_role_switch_desc?
>>
> My expectation is that in normal operation pmic_glink will provide role
> switching requests and then as you enable the EUD it will force the role
> to gadget.
>
> So my suggestion was that you make eud a role-switch and as long as EUD
> is disabled you just pass through the role-switch vote from pmic_glink
> onto the dwc3.
>
> Perhaps I'm misunderstanding how this is really working.

As per the code, the role-switching on dwc3 is enabled from 
drivers/usb/dwc3/drd.c on setting the usb mode to "otg " ,

that is being done on the 5th patch of this series. There is no other 
entity that is switching role for dwc3 other than EUD.

Also the role-switch registration happens from drivers/usb/dwc3/drd.c as 
follows

static int dwc3_setup_role_switch(struct dwc3 *dwc)
{
         struct usb_role_switch_desc dwc3_role_switch = {NULL};
         u32 mode;

         dwc->role_switch_default_mode = 
usb_get_role_switch_default_mode(dwc->dev);
         if (dwc->role_switch_default_mode == USB_DR_MODE_HOST) {
                 mode = DWC3_GCTL_PRTCAP_HOST;
         } else {
                 dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
                 mode = DWC3_GCTL_PRTCAP_DEVICE;
         }

         dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
         dwc3_role_switch.set = dwc3_usb_role_switch_set;
         dwc3_role_switch.get = dwc3_usb_role_switch_get;
         dwc3_role_switch.driver_data = dwc;
         dwc->role_sw = usb_role_switch_register(dwc->dev, 
&dwc3_role_switch);
         if (IS_ERR(dwc->role_sw))
                 return PTR_ERR(dwc->role_sw);

         dwc3_set_mode(dwc, mode);
         return 0;
}

Can you please point out the pmic_glink driver upstream and how it is 
related in this case?

>
> Regards,
> Bjorn
