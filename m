Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03594ECAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349444AbiC3Rri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiC3Rrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:47:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2DB11987E;
        Wed, 30 Mar 2022 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648662349; x=1680198349;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bhBu1QbtdGHCC2qA88WxU1+lM89JHNS2xL8ubX9vaIE=;
  b=KA/fjs/cHLcdsW63A2zlYO8k4nWzdUApAGBaQoD9ySGOi3xwccZ8MVhR
   uRIP/I7qgyEz8lkcdhPRBhdQqsw2gw/f+E4dVQp+M9tl5RPJY6PgZte/c
   7Nb5Qt8deI0QMBzo7evesl0K4XEtWjIYkUUeK1+Rx2lfnVq6+CHKybpSz
   0Qi0CPa4t786l9EHhtSrsDraS82jaUn1aY7WYQgpG5MaAw+PLAOfhoNzR
   RsXvo2/6VleUDx+C9lDZyo8VNcJUl32lPiFhZ+RJvOFYRBXeN2kuhyvJ7
   JkFkWkgDm4Wbp+LE+0Zvnc3MA8XWNbXRowT+aSPEQL2I9GOeUL6y/Wu24
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239534457"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="239534457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="653974778"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 10:45:44 -0700
To:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
 <1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com>
 <YjxjxplpOpDC2JLs@kuha.fi.intel.com>
 <4c2a28ad-b866-1b65-e73a-4eda0596cea2@linux.intel.com>
 <Yj2nPa6/Y01P5aCY@kuha.fi.intel.com>
 <4619c75c-cd34-82f2-56e1-a8bcb6d97177@linux.intel.com>
 <Yj3h4p/kmZTvMz0O@kuha.fi.intel.com>
 <fae54b27-9ae2-ecfc-69ae-40e5f5e1afbe@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 3/3] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <bd694ef9-be57-79f1-e95e-5501c396be25@linux.intel.com>
Date:   Wed, 30 Mar 2022 20:47:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fae54b27-9ae2-ecfc-69ae-40e5f5e1afbe@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.3.2022 12.18, Sandeep Maheswaram (Temp) wrote:
> Hi Mathias,Heikki
> 
> On 3/25/2022 9:08 PM, Heikki Krogerus wrote:
>> On Fri, Mar 25, 2022 at 04:33:27PM +0200, Mathias Nyman wrote:
>>> On 25.3.2022 13.27, Heikki Krogerus wrote:
>>>> On Fri, Mar 25, 2022 at 12:36:22AM +0200, Mathias Nyman wrote:
>>>>> On 24.3.2022 14.27, Heikki Krogerus wrote:
>>>>>> On Thu, Mar 24, 2022 at 12:07:11PM +0530, Sandeep Maheswaram wrote:
>>>>>>> Currently the phy init is done from dwc3 and also xhci which makes the
>>>>>>> runtime_usage value 2 for the phy which causes issue during runtime
>>>>>>> suspend. When we run the below command the runtime_status still shows
>>>>>>> active.
>>>>>>> echo auto > /sys/bus/platform/devices/88e3000.phy/power/control
>>>>>>>
>>>>>>> dwc3 manages PHY by own DRD driver, so skip the management by
>>>>>>> HCD core by setting this quirk.
>>>>>>>
>>>>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>>>>> ---
>>>>>>>   drivers/usb/dwc3/host.c | 13 +++++++++++++
>>>>>>>   1 file changed, 13 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>>>>>>> index eda8719..d4fcf06 100644
>>>>>>> --- a/drivers/usb/dwc3/host.c
>>>>>>> +++ b/drivers/usb/dwc3/host.c
>>>>>>> @@ -13,6 +13,12 @@
>>>>>>>   #include <linux/platform_device.h>
>>>>>>>     #include "core.h"
>>>>>>> +#include <linux/usb/xhci-plat.h>
>>>>>>> +#include <linux/usb/xhci-quirks.h>
>>>>>>> +
>>>>>>> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
>>>>>>> +    .quirks = XHCI_SKIP_PHY_INIT,
>>>>>>> +};
>>>>>>>     static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>>>>>>>                       int irq, char *name)
>>>>>>> @@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
>>>>>>>           }
>>>>>>>       }
>>>>>>>   +    ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
>>>>>>> +            sizeof(xhci_plat_dwc3_xhci));
>>>>>>> +    if (ret) {
>>>>>>> +        dev_err(dwc->dev, "failed to add data to xHCI\n");
>>>>>>> +        goto err;
>>>>>>> +    }
>>>>>>> +
>>>>>>>       ret = platform_device_add(xhci);
>>>>>>>       if (ret) {
>>>>>>>           dev_err(dwc->dev, "failed to register xHCI device\n");
>>>>>> I think you should just use device property:
>>>>>>
>>>>> This was suggested in an earlier series, but was rejected as it also added
>>>>> the property as a device tree parameter.
>>>>>
>>>>> I think adding more device properties can be messy in the long run, especially if we
>>>>> need to add them for many of the existing xhci quirks.
>>>>> We also end up with a mix where some device properties are listed as device tree
>>>>> parameters, and some not.
>>>>>
>>>>> Defining xhci quirks and platform data structure in headers shared with dwc3 and cdns3
>>>>> allow those drivers to easily set any existing xhci quirk, or other possible optional
>>>>> callbacks.
>>>>>
>>>>> cdns3 driver is already doing this, but it includes the full xhci.h header.
>>>>> This series cleans up that a bit so cdns3 will only include xhci quirk bits and
>>>>> platform data structure.
>>>>>
>>>>> On the downside we add a couple xhci related header files to include/linux/usb/
>>>>> Let me know if you see any other issues I missed with this approach.
>>>> The problem here is that these drivers are now coupled together, and
>>>> that should not be taken lightly. We have a dependency hell in our
>>>> hands with a lot of drivers, and the culprit is always platform data.
>>>>
>>>> Build-in device properties may be messy, but I would still say they
>>>> are less messy than those quirk flags - you got to admit, they are a
>>>> mess. The benefit from build-in properties is in any case the fact
>>>> that they remove the need to couple these drivers together.
>>> Agree, quirk bits are messy. Any suggestion that would work with
>>> PCI xHCI devices, devicetree, and "pure" platform devices?
>> I think xHCI driver should always be able to rely on being able to
>> read this kind of information from the fwnode. If there is no actual
>> firmware node (DT or ACPI), or if it's missing some information, the
>> glue driver needs to populate software node for the xHCI.
>>
>> Right now I just want to avoid having to pass the quirks using
>> platform data from drivers such as drivers/usb/cdns3/host.c and
>> drivers/usb/dwc3/host.c to xHCI.
>>
>> One way we could do that is by defining compatibility ID for both of
>> them that we provide using a single device property (like I guess DT
>> does). Then based on that compatibility ID, xhci-plat.c can set the
>> actual "static" quirk flags. That we could already do easily. How
>> would that sound to you?

Sounds good. 

> 
> This was my previous patch where I was using device tree property. Should we go ahead with this approach?
> 
> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-25582-1-git-send-email-quic_c_sanm@quicinc.com/
> 
> Any further changes to this ?

By dropping the DT part of that series we get a similar built-in device property
solution as Heikki initially suggested.

How about adding the compatibility ID device property that was just suggested?
Then matching the Id in xhci-plat.c against a static table containing Ids and
xhci_plat_priv structures, with the needed quirks for dwc3.

Thanks
-Mathias
