Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B34E6AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355436AbiCXWgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355411AbiCXWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:36:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B9BA321;
        Thu, 24 Mar 2022 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648161278; x=1679697278;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QPHtBgpmj+pdnRd5iLwaN4PLxXJdwqwY6VkCkPvMiUI=;
  b=IiNHCWVmW4GELU0s63iDHlhQS2IN4K5h3EHW0CCi1QHq0R4sqO37a+M2
   9HXWJ1EymCL9mmo6l1elmYR3dVxw+MrtvAP6JSPoq/10oBQXKHUI/4J61
   FBODsIamFE9tQWS6dIXGOWtbnwjNZfJJ0nifoF1tx6HuDwY7n8dCRECBf
   1aNdmr8jqXbQ1PsbAdE7XLuWvGeB9ARF3MpC0QgMB5zcYkGUV48fJ5DA/
   Et2VIITNnqkZp0cEQqu1CJ+3xLRJjEn+jRn3q/Ot2Hbhkex44Wft4UjyJ
   +rWfVCbqz5o/yUj8GMYCOHaild9ojpCKf2Ul+0N6DwZnW4yjE4flxRJGI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238447070"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="238447070"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 15:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="650029183"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2022 15:34:33 -0700
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
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
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 3/3] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <4c2a28ad-b866-1b65-e73a-4eda0596cea2@linux.intel.com>
Date:   Fri, 25 Mar 2022 00:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YjxjxplpOpDC2JLs@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.3.2022 14.27, Heikki Krogerus wrote:
> On Thu, Mar 24, 2022 at 12:07:11PM +0530, Sandeep Maheswaram wrote:
>> Currently the phy init is done from dwc3 and also xhci which makes the
>> runtime_usage value 2 for the phy which causes issue during runtime
>> suspend. When we run the below command the runtime_status still shows
>> active.
>> echo auto > /sys/bus/platform/devices/88e3000.phy/power/control
>>
>> dwc3 manages PHY by own DRD driver, so skip the management by
>> HCD core by setting this quirk.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> ---
>>  drivers/usb/dwc3/host.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index eda8719..d4fcf06 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -13,6 +13,12 @@
>>  #include <linux/platform_device.h>
>>  
>>  #include "core.h"
>> +#include <linux/usb/xhci-plat.h>
>> +#include <linux/usb/xhci-quirks.h>
>> +
>> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
>> +	.quirks = XHCI_SKIP_PHY_INIT,
>> +};
>>  
>>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>>  					int irq, char *name)
>> @@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
>>  		}
>>  	}
>>  
>> +	ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
>> +			sizeof(xhci_plat_dwc3_xhci));
>> +	if (ret) {
>> +		dev_err(dwc->dev, "failed to add data to xHCI\n");
>> +		goto err;
>> +	}
>> +
>>  	ret = platform_device_add(xhci);
>>  	if (ret) {
>>  		dev_err(dwc->dev, "failed to register xHCI device\n");
> 
> I think you should just use device property:
> 

This was suggested in an earlier series, but was rejected as it also added
the property as a device tree parameter.

I think adding more device properties can be messy in the long run, especially if we
need to add them for many of the existing xhci quirks.
We also end up with a mix where some device properties are listed as device tree
parameters, and some not.

Defining xhci quirks and platform data structure in headers shared with dwc3 and cdns3
allow those drivers to easily set any existing xhci quirk, or other possible optional
callbacks.

cdns3 driver is already doing this, but it includes the full xhci.h header.
This series cleans up that a bit so cdns3 will only include xhci quirk bits and
platform data structure.

On the downside we add a couple xhci related header files to include/linux/usb/
Let me know if you see any other issues I missed with this approach.

Thanks
Mathias
