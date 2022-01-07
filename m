Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937DC4871EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiAGE6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:58:09 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:21390 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231868AbiAGE6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641531488; x=1673067488;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uga+3cVxFTHnol9TYNiQ9BvLxyCVow4Vx6zh3T14HSI=;
  b=zJjxbUr5LNZk30ADU8tzBDqHxJrp8rHCEF9++vBTwAMIeoRsXsYfyUuu
   NeU7RLMt4iNTP6JSxXmtcffA5NtHVhkoYuunywSc2Eamz+vMNoGXOg+6T
   A/p6xEWwQkl+PcjnyIw8uPO0i0rqFk3pHVnqzX6i9m0/WzoQRYob7zpdr
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jan 2022 20:58:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 20:58:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 6 Jan 2022 20:58:06 -0800
Received: from [10.216.49.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 6 Jan 2022
 20:58:03 -0800
Subject: Re: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for
 DWC3 controller
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
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Message-ID: <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
Date:   Fri, 7 Jan 2022 10:27:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ydb79/twbxLDJB8/@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
> On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
>> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
>> usage value is 2 because the phy is initialized from DWC3 and HCD core.
>> DWC3 manages phy in their core drivers. Set this quirk to avoid phy
>> initialization in HCD core.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
>> v5:
>> Added comment to explain the change done.
>> v4:
>> Changed pdev->dev.parent->of_node to sysdev->of_node
>>
>>   drivers/usb/host/xhci-plat.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index c1edcc9..e6014d4 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>   					 &xhci->imod_interval);
>>   	}
>>   
>> +	/*
>> +	 * Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>> +	 * DWC3 manages phy in their core drivers. Set this quirk to avoid phy
>> +	 * initialization in HCD core.
>> +	 */
>> +	if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
>> +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
>> +
> Why is this function caring about dwc3 stuff?  Shoudn't this be a
> "generic" device property instead of this device-specific one?
>
> thanks,
>
> greg k-h

This quirk is set only if required for some controllers (eg: dwc3 & cdns3).

Please check below commit.

https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/


Regards

Sandeep


