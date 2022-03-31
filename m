Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015BA4ED84F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiCaLSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiCaLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:18:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A093205BD4;
        Thu, 31 Mar 2022 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648725420; x=1680261420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pjCtimjt0fYKXCjngBoxtDwovUxjoMR1xDl1UMLmYmA=;
  b=Hoj7jVyww/ALBn6MHGJ2fda05M4ruRXDUs5zyZOc9IWdeGGTxMbQ9hBj
   r+4CiODAx93kFvE/fQ/QHImq5ROjAgMdZSDILHQyf9LetSiMGo/grdp4N
   egyKXgnG+aQzOy5onej66DB0gqZ/9Zr3kqDA6nXK2STlpDRi4sBnw1ep0
   VYE7GP8qiVZPaxYUJQR0X5nZQgcQLbMNhqQbZL7y9Z4BVBjhROHxPB52D
   hKGjAN13xx/V3ExM0GRWZG8um1CpUpLiBGTA96inQGIF5MDyBGjPWV5ai
   fl2FVMoIXyOCqwjEK434S/a0MfEO+8WFWlLe11bpEp8bq1rCp42ozMpdQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259778552"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259778552"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 04:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="695451250"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Mar 2022 04:16:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 31 Mar 2022 14:16:53 +0300
Date:   Thu, 31 Mar 2022 14:16:53 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v3 3/3] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <YkWNpTLjh2weX9Mk@kuha.fi.intel.com>
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
 <1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com>
 <YjxjxplpOpDC2JLs@kuha.fi.intel.com>
 <4c2a28ad-b866-1b65-e73a-4eda0596cea2@linux.intel.com>
 <Yj2nPa6/Y01P5aCY@kuha.fi.intel.com>
 <4619c75c-cd34-82f2-56e1-a8bcb6d97177@linux.intel.com>
 <Yj3h4p/kmZTvMz0O@kuha.fi.intel.com>
 <fae54b27-9ae2-ecfc-69ae-40e5f5e1afbe@quicinc.com>
 <bd694ef9-be57-79f1-e95e-5501c396be25@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd694ef9-be57-79f1-e95e-5501c396be25@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 08:47:34PM +0300, Mathias Nyman wrote:
> On 29.3.2022 12.18, Sandeep Maheswaram (Temp) wrote:
> > Hi Mathias,Heikki
> > 
> > On 3/25/2022 9:08 PM, Heikki Krogerus wrote:
> >> On Fri, Mar 25, 2022 at 04:33:27PM +0200, Mathias Nyman wrote:
> >>> On 25.3.2022 13.27, Heikki Krogerus wrote:
> >>>> On Fri, Mar 25, 2022 at 12:36:22AM +0200, Mathias Nyman wrote:
> >>>>> On 24.3.2022 14.27, Heikki Krogerus wrote:
> >>>>>> On Thu, Mar 24, 2022 at 12:07:11PM +0530, Sandeep Maheswaram wrote:
> >>>>>>> Currently the phy init is done from dwc3 and also xhci which makes the
> >>>>>>> runtime_usage value 2 for the phy which causes issue during runtime
> >>>>>>> suspend. When we run the below command the runtime_status still shows
> >>>>>>> active.
> >>>>>>> echo auto > /sys/bus/platform/devices/88e3000.phy/power/control
> >>>>>>>
> >>>>>>> dwc3 manages PHY by own DRD driver, so skip the management by
> >>>>>>> HCD core by setting this quirk.
> >>>>>>>
> >>>>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> >>>>>>> ---
> >>>>>>>   drivers/usb/dwc3/host.c | 13 +++++++++++++
> >>>>>>>   1 file changed, 13 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> >>>>>>> index eda8719..d4fcf06 100644
> >>>>>>> --- a/drivers/usb/dwc3/host.c
> >>>>>>> +++ b/drivers/usb/dwc3/host.c
> >>>>>>> @@ -13,6 +13,12 @@
> >>>>>>>   #include <linux/platform_device.h>
> >>>>>>>     #include "core.h"
> >>>>>>> +#include <linux/usb/xhci-plat.h>
> >>>>>>> +#include <linux/usb/xhci-quirks.h>
> >>>>>>> +
> >>>>>>> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> >>>>>>> +    .quirks = XHCI_SKIP_PHY_INIT,
> >>>>>>> +};
> >>>>>>>     static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> >>>>>>>                       int irq, char *name)
> >>>>>>> @@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
> >>>>>>>           }
> >>>>>>>       }
> >>>>>>>   +    ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> >>>>>>> +            sizeof(xhci_plat_dwc3_xhci));
> >>>>>>> +    if (ret) {
> >>>>>>> +        dev_err(dwc->dev, "failed to add data to xHCI\n");
> >>>>>>> +        goto err;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>>       ret = platform_device_add(xhci);
> >>>>>>>       if (ret) {
> >>>>>>>           dev_err(dwc->dev, "failed to register xHCI device\n");
> >>>>>> I think you should just use device property:
> >>>>>>
> >>>>> This was suggested in an earlier series, but was rejected as it also added
> >>>>> the property as a device tree parameter.
> >>>>>
> >>>>> I think adding more device properties can be messy in the long run, especially if we
> >>>>> need to add them for many of the existing xhci quirks.
> >>>>> We also end up with a mix where some device properties are listed as device tree
> >>>>> parameters, and some not.
> >>>>>
> >>>>> Defining xhci quirks and platform data structure in headers shared with dwc3 and cdns3
> >>>>> allow those drivers to easily set any existing xhci quirk, or other possible optional
> >>>>> callbacks.
> >>>>>
> >>>>> cdns3 driver is already doing this, but it includes the full xhci.h header.
> >>>>> This series cleans up that a bit so cdns3 will only include xhci quirk bits and
> >>>>> platform data structure.
> >>>>>
> >>>>> On the downside we add a couple xhci related header files to include/linux/usb/
> >>>>> Let me know if you see any other issues I missed with this approach.
> >>>> The problem here is that these drivers are now coupled together, and
> >>>> that should not be taken lightly. We have a dependency hell in our
> >>>> hands with a lot of drivers, and the culprit is always platform data.
> >>>>
> >>>> Build-in device properties may be messy, but I would still say they
> >>>> are less messy than those quirk flags - you got to admit, they are a
> >>>> mess. The benefit from build-in properties is in any case the fact
> >>>> that they remove the need to couple these drivers together.
> >>> Agree, quirk bits are messy. Any suggestion that would work with
> >>> PCI xHCI devices, devicetree, and "pure" platform devices?
> >> I think xHCI driver should always be able to rely on being able to
> >> read this kind of information from the fwnode. If there is no actual
> >> firmware node (DT or ACPI), or if it's missing some information, the
> >> glue driver needs to populate software node for the xHCI.
> >>
> >> Right now I just want to avoid having to pass the quirks using
> >> platform data from drivers such as drivers/usb/cdns3/host.c and
> >> drivers/usb/dwc3/host.c to xHCI.
> >>
> >> One way we could do that is by defining compatibility ID for both of
> >> them that we provide using a single device property (like I guess DT
> >> does). Then based on that compatibility ID, xhci-plat.c can set the
> >> actual "static" quirk flags. That we could already do easily. How
> >> would that sound to you?
> 
> Sounds good. 
> 
> > 
> > This was my previous patch where I was using device tree property. Should we go ahead with this approach?
> > 
> > https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-25582-1-git-send-email-quic_c_sanm@quicinc.com/
> > 
> > Any further changes to this ?
> 
> By dropping the DT part of that series we get a similar built-in device property
> solution as Heikki initially suggested.
> 
> How about adding the compatibility ID device property that was just suggested?
> Then matching the Id in xhci-plat.c against a static table containing Ids and
> xhci_plat_priv structures, with the needed quirks for dwc3.

There was a comment from Pavan. Is it still possible to get this
detail from DT?
I guess that would still be ideal, right?

I have another question. Can't we now just assume that if the sysdev
is the parent (or grandparent), then the phy initialization should
always be skipped? In that case we could just do something like this:

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 649ffd861b44e..1018b33488046 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -212,8 +212,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
 #endif
        }
 
-       if (!sysdev)
+       if (sysdev) {
+               if (sysdev != &pdev->dev)
+                       hcd->skip_phy_initialization = 1;
+       } else {
                sysdev = &pdev->dev;
+       }
 
        if (WARN_ON(!sysdev->dma_mask))
                /* Platform did not initialize dma_mask */


I did not go through all the drivers that carefully, so I may have
missed something, but it looks like the only drivers that can have the
sysdev as the parent or grandparent are cdns3 and dwc3.

thanks,

-- 
heikki
