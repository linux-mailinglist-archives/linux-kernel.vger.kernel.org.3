Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B64AE9DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiBIGCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:02:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiBIGBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:01:12 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F6C050CC2;
        Tue,  8 Feb 2022 22:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644386474; x=1675922474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4peUR/FlwKBQOuJfd2ZZpHK3WkZEECAcE1WpoWtMvdg=;
  b=FOjcW4zE2r5tgp4QWaTHBUPV5Q+BLMpaJMdoH+RAzvZCjVzA/8ATbbp9
   3N2VMZ7m+R/NjI48FcBEU5kHB+Q7/za/1fN31j+VlnRQOepcd1y27R+GY
   69VLUE7FL7QBJk6UQy/ffLhtcKI1Rp5AdgRORXFOlau7Uf9+A+34dx3nI
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2022 22:01:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 22:01:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 22:01:13 -0800
Received: from [10.216.51.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 8 Feb 2022
 22:01:10 -0800
Message-ID: <d0048456-eb0a-cf91-fc28-f1dda69c1432@quicinc.com>
Date:   Wed, 9 Feb 2022 11:31:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk for
 DWC3 controller
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
 <Ydb79/twbxLDJB8/@kroah.com>
 <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
 <YfE9s06CIv1P3bA/@kroah.com>
 <f45f5952-e31c-5e9d-2560-064199beb29f@quicinc.com>
 <ca306d7c-d816-3cbd-8c65-2c3619739d47@quicinc.com>
 <YgJB6bGm/y7C0oo/@kroah.com>
 <20220209055352.GA22550@hu-pkondeti-hyd.qualcomm.com>
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
In-Reply-To: <20220209055352.GA22550@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/2022 11:23 AM, Pavan Kondeti wrote:
> On Tue, Feb 08, 2022 at 11:11:53AM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Feb 08, 2022 at 03:34:22PM +0530, Sandeep Maheswaram wrote:
>>> Hi Greg,
>>>
>>> On 1/27/2022 10:28 AM, Sandeep Maheswaram wrote:
>>>> On 1/26/2022 5:55 PM, Greg Kroah-Hartman wrote:
>>>>> On Fri, Jan 07, 2022 at 10:27:59AM +0530, Sandeep Maheswaram wrote:
>>>>>> On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
>>>>>>>> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
>>>>>>>> Runtime suspend of phy drivers was failing from DWC3
>>>>>>>> driver as runtime
>>>>>>>> usage value is 2 because the phy is initialized from
>>>>>>>> DWC3 and HCD core.
>>>>>>>> DWC3 manages phy in their core drivers. Set this quirk to avoid phy
>>>>>>>> initialization in HCD core.
>>>>>>>>
>>>>>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>>>>>> ---
>>>>>>>> v5:
>>>>>>>> Added comment to explain the change done.
>>>>>>>> v4:
>>>>>>>> Changed pdev->dev.parent->of_node to sysdev->of_node
>>>>>>>>
>>>>>>>>     drivers/usb/host/xhci-plat.c | 8 ++++++++
>>>>>>>>     1 file changed, 8 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/host/xhci-plat.c
>>>>>>>> b/drivers/usb/host/xhci-plat.c
>>>>>>>> index c1edcc9..e6014d4 100644
>>>>>>>> --- a/drivers/usb/host/xhci-plat.c
>>>>>>>> +++ b/drivers/usb/host/xhci-plat.c
>>>>>>>> @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct
>>>>>>>> platform_device *pdev)
>>>>>>>>                          &xhci->imod_interval);
>>>>>>>>         }
>>>>>>>> +    /*
>>>>>>>> +     * Set XHCI_SKIP_PHY_INIT quirk to avoid phy
>>>>>>>> initialization twice.
>>>>>>>> +     * DWC3 manages phy in their core drivers. Set this
>>>>>>>> quirk to avoid phy
>>>>>>>> +     * initialization in HCD core.
>>>>>>>> +     */
>>>>>>>> +    if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
>>>>>>>> +        xhci->quirks |= XHCI_SKIP_PHY_INIT;
>>>>>>>> +
>>>>>>> Why is this function caring about dwc3 stuff?  Shoudn't this be a
>>>>>>> "generic" device property instead of this device-specific one?
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>> This quirk is set only if required for some controllers (eg:
>>>>>> dwc3 & cdns3).
>>>>>>
>>>>>> Please check below commit.
>>>>>>
>>>>>> https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/
>>>>>>
>>>>> That commit has nothing to do with a specific "dwc3" quirk anywhere.
>>>>> Why not set this flag in the specific platform xhci driver instead where
>>>>> it belongs?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>> There is no specific xhci platform driver for dwc3 controllers.
>>>>
>>>> dwc3 controllers use xhci-plat driver .
>>>>
>>>> We can add this quirk in usb/dwc3/host.c as cdns3 does but that requires
>>>> tying dwc3 and xhci driver .
>>>>
>>>> https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/
>>>>
>>>>
>>>> Regards
>>>>
>>>> Sandeep
>>>>
>>>>
>>> Can you suggest any other method to set this quirk for dwc3 controllers.
>> No idea, sorry.
> Sandeep,
>
> I agree with Greg's comments here. The compatible based check to detect dwc3
> controller is not elegant. Your proposal of adding a device tree param is
> overkill, I believe.
>
> Greg already gave us a pointer here [1] which I feel is the best approach going
> forward. We know that xhci-plat is being used by drivers like dwc3, cdns3 and
> these drivers need to expose their xhci quirks. As Greg suggested, why can't
> we move xhci quirks definition to include/linux/usb/xhci-quriks.h and directly
> access from the glue drivers? The attached is the patch (completely untested)
> for your reference. It will prepare the setup for you to add the private data
> and quirks in the dwc3 host glue driver.
>
> Thanks,
> Pavan
>
> [1]
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/
>
Thanks Pavan..will test the patch.
