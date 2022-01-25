Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84DA49B040
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573935AbiAYJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:30:31 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:48570 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1572950AbiAYJS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643102309; x=1674638309;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=WCMvfojpGnDDo8OwfSsHCxCIjz0cLdSHACcu8tv3ne8=;
  b=u7BL6raKVH4FwjsXKh9ua5fsPiKXpfBM82QrlcdI0VeMcGM2c2d1HIbw
   rpIXO6gPhLy8PwjYlQJpn1jT5yoJEAoGndmC27tbmWu5etRyJPO1ds2Jl
   5zHH8RrscTuxbnbGQaNYYanvMcqQuGGPeK9frLPZIrdRRf9XRHhlXSPBv
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jan 2022 01:18:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:18:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 01:18:06 -0800
Received: from [10.216.59.162] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 25 Jan
 2022 01:18:02 -0800
Message-ID: <601cdc74-392f-dd4f-7ea0-8e65c6b6d7e2@quicinc.com>
Date:   Tue, 25 Jan 2022 14:47:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during
 probe
Content-Language: en-US
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
 <93b68251-7e7e-ac92-fb47-346c410744b2@kali.org>
 <20220118095255.GB11385@hu-pkondeti-hyd.qualcomm.com>
 <78c90e46-666b-bc9b-235d-ae4c69e19929@quicinc.com>
In-Reply-To: <78c90e46-666b-bc9b-235d-ae4c69e19929@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steev,

On 1/20/2022 10:52 AM, Sandeep Maheswaram wrote:
> Hi Pavan,
>
> On 1/18/2022 3:22 PM, Pavan Kondeti wrote:
>> On Tue, Jan 18, 2022 at 12:12:30AM -0600, Steev Klimaszewski wrote:
>>> On 1/16/22 11:44 PM, Sandeep Maheswaram wrote:
>>>> Enable the interrupts during probe and remove the disable interrupts
>>>> function.
>>>>
>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>> ---
>>>>   drivers/usb/dwc3/dwc3-qcom.c | 28 ++++------------------------
>>>>   1 file changed, 4 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c 
>>>> b/drivers/usb/dwc3/dwc3-qcom.c
>>>> index 54dc3d3..7c5e636 100644
>>>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>>>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>>>> @@ -306,25 +306,7 @@ static void dwc3_qcom_enable_wakeup_irq(int irq)
>>>>       enable_irq_wake(irq);
>>>>   }
>>>> -static void dwc3_qcom_disable_wakeup_irq(int irq)
>>>> -{
>>>> -    if (!irq)
>>>> -        return;
>>>> -
>>>> -    disable_irq_wake(irq);
>>>> -    disable_irq_nosync(irq);
>>>> -}
>>>> -static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>>>> -{
>>>> -    dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
>>>> -
>>>> -    dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
>>>> -
>>>> -    dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
>>>> -
>>>> -    dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
>>>> -}
>>>>   static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>>>>   {
>>>> @@ -356,9 +338,6 @@ static int dwc3_qcom_suspend(struct dwc3_qcom 
>>>> *qcom)
>>>>       if (ret)
>>>>           dev_warn(qcom->dev, "failed to disable interconnect: 
>>>> %d\n", ret);
>>>> -    if (device_may_wakeup(qcom->dev))
>>>> -        dwc3_qcom_enable_interrupts(qcom);
>>>> -
>>>>       qcom->is_suspended = true;
>>>>       return 0;
>>>> @@ -372,9 +351,6 @@ static int dwc3_qcom_resume(struct dwc3_qcom 
>>>> *qcom)
>>>>       if (!qcom->is_suspended)
>>>>           return 0;
>>>> -    if (device_may_wakeup(qcom->dev))
>>>> -        dwc3_qcom_disable_interrupts(qcom);
>>>> -
>>>>       for (i = 0; i < qcom->num_clocks; i++) {
>>>>           ret = clk_prepare_enable(qcom->clks[i]);
>>>>           if (ret < 0) {
>>>> @@ -832,6 +808,10 @@ static int dwc3_qcom_probe(struct 
>>>> platform_device *pdev)
>>>>       genpd->flags |= GENPD_FLAG_ALWAYS_ON;
>>>>       device_init_wakeup(&pdev->dev, 1);
>>>> +
>>>> +    if (device_may_wakeup(qcom->dev))
>>>> +        dwc3_qcom_enable_interrupts(qcom);
>>>> +
>>>>       qcom->is_suspended = false;
>>>>       pm_runtime_set_active(dev);
>>>>       pm_runtime_enable(dev);
>>> Hi Sandeep,
>>>
>>> I was testing this series on my Lenovo Yoga C630, and with this 
>>> patch in
>>> particular applied, my system will no longer boot. Unfortunately I 
>>> don't get
>>> any sort of good output at all, I just get hung tasks when trying to 
>>> probe
>>> things it would seem.
>>>
>>>
>>> With the other 5 patches in the series applied, the system still 
>>> boots and
>>> works correctly.
>>>
>>>
>> Sandeep,
>>
>> Enable DP/DM interrupts all the time might be creating a storm of 
>> interrupts.
>> calling enable_irq_wake() during probe is okay, but not the 
>> enable_irq().
>>
>> Did you verify your change with a Highspeed/Fullspeed device connected?
>>
>> Thanks,
>> Pavan
>
> I didn't face any such issue with devices connected.
>
> I think this is because I used IRQ_TYPE_EDGE_BOTH in device tree and 
> Steev has IRQ_TYPE_LEVEL_HIGH in his device tree.
>
> When i changed to IRQ_TYPE_LEVEL_HIGH I also observed a storm of 
> interrupts in my device though it booted .
>
> Regards
>
> Sandeep
>
Can you try with IRQ_TYPE_EDGE_BOTH in your device tree and see if you 
are getting the issue.

Regards

Sandeep

