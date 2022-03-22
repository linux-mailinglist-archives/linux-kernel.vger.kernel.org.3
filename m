Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4E4E435A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiCVPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiCVPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:53:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF489CFD;
        Tue, 22 Mar 2022 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647964319; x=1679500319;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9ttX9cZdVk3gMLlMA8zvmvOJ+iMJUZrKKbcKF7FJWwM=;
  b=WUe56AswEZUfydv1gfwAfD8UxOvIz1XjZA+VYyKdiVeVCotp/HJXJPH6
   SPu3E8nwBZVHCSqkKgctd7J6nemigN+1Q9FyMGoyhgytzYuZ1Yk9y8Imj
   RzNDFKRIpK7knTB8xxK9VfFOXYZeshzOKA+4DcQ9lwAePJ5Mpg1jKzUOW
   P8rkVYm6Flv7uRs5ngdpr27q7dL0iAgMdaWBHld6yhW661zwZE9003/8G
   wxJT1TR9PIxOw23muVSE52yOY49Gp4Yv1sgPPey2Gn3c24ANXRx2YDP+m
   5Pms4p7gLHxPURix8bXn9FESM700XFyFvhabrbuOpdu0Tu+HU8FSzsjW1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="255418969"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="255418969"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 08:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="649039098"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2022 08:51:54 -0700
To:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <ddc86a4f-8d1c-c02c-5600-4fa851568557@quicinc.com>
 <YjR0Ne3BDxxMfrxt@kroah.com>
 <b38ddfcc-68c3-d99f-816b-8b9f788aa88a@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Refactor xhci quirks and plat private data
Message-ID: <29ba84fb-1db2-1d84-cf9e-191e9bcbf739@linux.intel.com>
Date:   Tue, 22 Mar 2022 17:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b38ddfcc-68c3-d99f-816b-8b9f788aa88a@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.3.2022 8.21, Sandeep Maheswaram (Temp) wrote:
> Hi Mathias,
> 
> On 3/18/2022 5:29 PM, Greg Kroah-Hartman wrote:
>> On Thu, Mar 17, 2022 at 11:17:17AM +0530, Sandeep Maheswaram (Temp) wrote:
>>> Hi Greg,
>>>
>>> On 3/1/2022 3:58 PM, Sandeep Maheswaram wrote:
>>>> changes in v2:
>>>> Added a PATCH 2/3 to remove unwanted header inclusion.
>>>> Fixed minor nitpicks in PATCH 3/3.
>>>>
>>>> Pavankumar Kondeti (1):
>>>>     usb: xhci: refactor quirks and plat private data
>>>>
>>>> Sandeep Maheswaram (2):
>>>>     usb: xhci: Remove unwanted header inclusion
>>>>     usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
>>>>
>>>>    drivers/usb/cdns3/host.c        |  2 +-
>>>>    drivers/usb/dwc3/host.c         | 13 ++++++++
>>>>    drivers/usb/host/xhci-plat.c    |  3 +-
>>>>    drivers/usb/host/xhci-plat.h    | 24 ---------------
>>>>    drivers/usb/host/xhci-rcar.c    |  3 +-
>>>>    drivers/usb/host/xhci.h         | 60 ++++--------------------------------
>>>>    include/linux/usb/xhci-plat.h   | 24 +++++++++++++++
>>>>    include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
>>>>    8 files changed, 115 insertions(+), 81 deletions(-)
>>>>    delete mode 100644 drivers/usb/host/xhci-plat.h
>>>>    create mode 100644 include/linux/usb/xhci-plat.h
>>>>    create mode 100644 include/linux/usb/xhci-quirks.h
>>> Please let me know your opinion about this patch series.
>> I need the xhci maintainer to review it...
>>
>> thanks,
>>
>> greg k-h
> 
> 
> Can you please review this patch series.
> 

I don't have a better solution than this.

So neither devicetree or ACPI entries exists for the xHC part of this dwc3 controller?

A pure platform device is created, and it matches and binds to xhci-plat driver by "xhci-hcd" name.
I guess we have no way to identify this dwc3 xhci controller in xhci-plat.c, and set quirks there,
like all those devicetree xhci devices that we set quirks based on .compatibility. 

Thanks
Mathias

