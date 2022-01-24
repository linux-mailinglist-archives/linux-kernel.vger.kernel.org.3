Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A08497896
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiAXFbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:31:17 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:30990 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiAXFbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643002276; x=1674538276;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DoqT6Nd9m5ddsMLPEa2M02g3IGzfvPrjGA1J9RPy3JQ=;
  b=NdTa7XP0H6oNUhATfEx7mE0YhbjaeZwfQ+DlJ9c+Cib8BVGwxCsvqryl
   b6G2izbLQoZAup4aAaGhGBMIeLYJbH05x0O6T+evPmw8xa68+o8DIaJ5r
   udw6LhcDE9s80aDD5MpHqaZxypZBsG9IUoj7hw/Bz58izn3E93upcATOH
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Jan 2022 21:31:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 21:31:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 21:31:15 -0800
Received: from [10.216.10.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 23 Jan
 2022 21:31:10 -0800
Message-ID: <c34ea13b-f7ac-22de-6c5d-5e930853415c@quicinc.com>
Date:   Mon, 24 Jan 2022 11:01:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for
 DWC3 controller
Content-Language: en-US
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
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
In-Reply-To: <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/7/2022 10:27 AM, Sandeep Maheswaram wrote:
>
> On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
>> On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
>>> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>>> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
>>> usage value is 2 because the phy is initialized from DWC3 and HCD core.
>>> DWC3 manages phy in their core drivers. Set this quirk to avoid phy
>>> initialization in HCD core.
>>>
>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>> ---
>>> v5:
>>> Added comment to explain the change done.
>>> v4:
>>> Changed pdev->dev.parent->of_node to sysdev->of_node
>>>
>>>   drivers/usb/host/xhci-plat.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/xhci-plat.c 
>>> b/drivers/usb/host/xhci-plat.c
>>> index c1edcc9..e6014d4 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
>>> @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct 
>>> platform_device *pdev)
>>>                        &xhci->imod_interval);
>>>       }
>>>   +    /*
>>> +     * Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>>> +     * DWC3 manages phy in their core drivers. Set this quirk to 
>>> avoid phy
>>> +     * initialization in HCD core.
>>> +     */
>>> +    if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
>>> +        xhci->quirks |= XHCI_SKIP_PHY_INIT;
>>> +
>> Why is this function caring about dwc3 stuff?  Shoudn't this be a
>> "generic" device property instead of this device-specific one?
>>
>> thanks,
>>
>> greg k-h
>
> This quirk is set only if required for some controllers (eg: dwc3 & 
> cdns3).
>
> Please check below commit.
>
> https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/ 
>
>
>
> Regards
>
> Sandeep
>
>
Please let me know if anything more info needed for this patch.

Regards

Sandeep


