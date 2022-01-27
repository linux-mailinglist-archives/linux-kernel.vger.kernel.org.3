Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF349D9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiA0E7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:59:02 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:38991 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbiA0E7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643259541; x=1674795541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jf9V216nusuCRFt1B0tCe8eS+M0OwEBMRQly1e8ptqE=;
  b=RCEcHfHMN53N5SlMJOvLgC05u5nbTXPkspocEUJZuC8g3qy5fE6nSP8p
   OmDE0AP1rDPn1xqZ8h9k+lpfP5Ww8PPKmHAYXkrNR7o12KAmPr+JrrkRR
   4gE0CFC+GMbEhXWR4J8U3Za03/WFKT8abueqNWOCqJN+VEiMfZFjFeSGO
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 20:59:01 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 20:59:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 20:59:00 -0800
Received: from [10.216.22.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 26 Jan
 2022 20:58:56 -0800
Message-ID: <f45f5952-e31c-5e9d-2560-064199beb29f@quicinc.com>
Date:   Thu, 27 Jan 2022 10:28:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for
 DWC3 controller
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
 <Ydb79/twbxLDJB8/@kroah.com>
 <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
 <YfE9s06CIv1P3bA/@kroah.com>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
In-Reply-To: <YfE9s06CIv1P3bA/@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/2022 5:55 PM, Greg Kroah-Hartman wrote:
> On Fri, Jan 07, 2022 at 10:27:59AM +0530, Sandeep Maheswaram wrote:
>> On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
>>>> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>>>> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
>>>> usage value is 2 because the phy is initialized from DWC3 and HCD core.
>>>> DWC3 manages phy in their core drivers. Set this quirk to avoid phy
>>>> initialization in HCD core.
>>>>
>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>> ---
>>>> v5:
>>>> Added comment to explain the change done.
>>>> v4:
>>>> Changed pdev->dev.parent->of_node to sysdev->of_node
>>>>
>>>>    drivers/usb/host/xhci-plat.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>>> index c1edcc9..e6014d4 100644
>>>> --- a/drivers/usb/host/xhci-plat.c
>>>> +++ b/drivers/usb/host/xhci-plat.c
>>>> @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>>>    					 &xhci->imod_interval);
>>>>    	}
>>>> +	/*
>>>> +	 * Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>>>> +	 * DWC3 manages phy in their core drivers. Set this quirk to avoid phy
>>>> +	 * initialization in HCD core.
>>>> +	 */
>>>> +	if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
>>>> +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
>>>> +
>>> Why is this function caring about dwc3 stuff?  Shoudn't this be a
>>> "generic" device property instead of this device-specific one?
>>>
>>> thanks,
>>>
>>> greg k-h
>> This quirk is set only if required for some controllers (eg: dwc3 & cdns3).
>>
>> Please check below commit.
>>
>> https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/
> That commit has nothing to do with a specific "dwc3" quirk anywhere.
> Why not set this flag in the specific platform xhci driver instead where
> it belongs?
>
> thanks,
>
> greg k-h

There is no specific xhci platform driver for dwc3 controllers.

dwc3 controllers use xhci-plat driver .

We can add this quirk in usb/dwc3/host.c as cdns3 does but that requires 
tying dwc3 and xhci driver .

https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/

Regards

Sandeep


