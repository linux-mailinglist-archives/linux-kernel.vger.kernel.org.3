Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E826A473C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhLNEr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:47:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:40967 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhLNEr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639457276; x=1670993276;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9OVG4T7CGFREDUL/6qfTIna/U9LQMnLfxCuu0AOCp2A=;
  b=Gn7mHpiIv8SQT6F6VJJEVSLjZx0qOJ6hODWA423hAky0TN7a1jKAc97G
   hSO3UhxeVfDGjLVXKzWksGen2VplQJWjfVwd6Mezd4p7rbcG9IiT4t7LR
   eGS1Bd73OI2my/NEF4OYOViAKw4OImpdCT4n7BjBDd8c7QvUR2sN1m5nu
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Dec 2021 20:47:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 20:47:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 13 Dec 2021 20:47:55 -0800
Received: from [10.216.56.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 13 Dec
 2021 20:47:51 -0800
Subject: Re: [PATCH v3] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for
 DWC3 controller
To:     Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
References: <1638339338-6731-1-git-send-email-quic_c_sanm@quicinc.com>
 <1638339338-6731-2-git-send-email-quic_c_sanm@quicinc.com>
 <CAE-0n50YLsHhqoNQDNnGUYhHQSbMc7qnS5nGB-Nk2Z2J13xBVQ@mail.gmail.com>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Message-ID: <eeeedcb4-d444-5402-2822-0fe942bcb83a@quicinc.com>
Date:   Tue, 14 Dec 2021 10:17:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n50YLsHhqoNQDNnGUYhHQSbMc7qnS5nGB-Nk2Z2J13xBVQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/2021 8:47 AM, Stephen Boyd wrote:
> Quoting Sandeep Maheswaram (2021-11-30 22:15:38)
>> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>> Runtime suspend of phy drivers was failing from DWC3 driver as
>> runtime usage value is 2 because the phy is initialized from
>> DWC3 core and HCD core.
>> DWC3 manages phy in their core drivers.
> This looks wrapped weirdly.
>
>> Set this quirk to avoid phy initialization in HCD core.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Any Fixes tag?
Not sure about the commit id to be used here.
>
>> ---
>>   drivers/usb/host/xhci-plat.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index c1edcc9..9bbd939 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -327,6 +327,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>                                           &xhci->imod_interval);
>>          }
>>
>> +       if (of_device_is_compatible(pdev->dev.parent->of_node, "snps,dwc3"))
> Are we sure that pdev->dev.parent isn't NULL here?

+    if (of_device_is_compatible(to_of_node(sysdev->fwnode), "snps,dwc3"))

Will this be ok ?

>
>> +               xhci->quirks |= XHCI_SKIP_PHY_INIT;
>> +
>>          hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
>>          if (IS_ERR(hcd->usb_phy)) {
