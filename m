Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DB74E722C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356184AbiCYL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355971AbiCYL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:29:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E514813FA7;
        Fri, 25 Mar 2022 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648207689; x=1679743689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dMgYIsDhZfpaODwuMAjjtTf/jqUDjedYJhO0eLc8fsM=;
  b=OIlQpdikF/FDLepEpsHKHI0e8B5f6UzLRZYoard5YsMRLvN1eIOcqTyr
   UBIA6Z0FE5H4o2SznNovocZ/ajHdJd3pVO2k3mjIj6ospGp8ezTt8Ec2O
   ty5SCmOotnuDqWVUK8DsZB99CBKxaW7Womf/DoAb1tZ/tvFdLibFNrwVk
   dnHdKSiob485U2qmL4kett/pqEzJxeQYNpXtWQ/uPifstQaUhc28SnR6v
   SwaqKL0UZQYrXhXW8+3myoZr2MsYSjLZx4TM/r0lnRFTMFFamjxP86AaJ
   qTIRrW8HdLHUKGdn7+O2903SpO3Z4Ur6FkRZ3GO8n2oXh3S5Olr0Tv79+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238555581"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="238555581"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="693652087"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Mar 2022 04:27:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 25 Mar 2022 13:27:57 +0200
Date:   Fri, 25 Mar 2022 13:27:57 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
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
Message-ID: <Yj2nPa6/Y01P5aCY@kuha.fi.intel.com>
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
 <1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com>
 <YjxjxplpOpDC2JLs@kuha.fi.intel.com>
 <4c2a28ad-b866-1b65-e73a-4eda0596cea2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2a28ad-b866-1b65-e73a-4eda0596cea2@linux.intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 12:36:22AM +0200, Mathias Nyman wrote:
> On 24.3.2022 14.27, Heikki Krogerus wrote:
> > On Thu, Mar 24, 2022 at 12:07:11PM +0530, Sandeep Maheswaram wrote:
> >> Currently the phy init is done from dwc3 and also xhci which makes the
> >> runtime_usage value 2 for the phy which causes issue during runtime
> >> suspend. When we run the below command the runtime_status still shows
> >> active.
> >> echo auto > /sys/bus/platform/devices/88e3000.phy/power/control
> >>
> >> dwc3 manages PHY by own DRD driver, so skip the management by
> >> HCD core by setting this quirk.
> >>
> >> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> >> ---
> >>  drivers/usb/dwc3/host.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> >> index eda8719..d4fcf06 100644
> >> --- a/drivers/usb/dwc3/host.c
> >> +++ b/drivers/usb/dwc3/host.c
> >> @@ -13,6 +13,12 @@
> >>  #include <linux/platform_device.h>
> >>  
> >>  #include "core.h"
> >> +#include <linux/usb/xhci-plat.h>
> >> +#include <linux/usb/xhci-quirks.h>
> >> +
> >> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> >> +	.quirks = XHCI_SKIP_PHY_INIT,
> >> +};
> >>  
> >>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> >>  					int irq, char *name)
> >> @@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
> >>  		}
> >>  	}
> >>  
> >> +	ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> >> +			sizeof(xhci_plat_dwc3_xhci));
> >> +	if (ret) {
> >> +		dev_err(dwc->dev, "failed to add data to xHCI\n");
> >> +		goto err;
> >> +	}
> >> +
> >>  	ret = platform_device_add(xhci);
> >>  	if (ret) {
> >>  		dev_err(dwc->dev, "failed to register xHCI device\n");
> > 
> > I think you should just use device property:
> > 
> 
> This was suggested in an earlier series, but was rejected as it also added
> the property as a device tree parameter.
> 
> I think adding more device properties can be messy in the long run, especially if we
> need to add them for many of the existing xhci quirks.
> We also end up with a mix where some device properties are listed as device tree
> parameters, and some not.
> 
> Defining xhci quirks and platform data structure in headers shared with dwc3 and cdns3
> allow those drivers to easily set any existing xhci quirk, or other possible optional
> callbacks.
> 
> cdns3 driver is already doing this, but it includes the full xhci.h header.
> This series cleans up that a bit so cdns3 will only include xhci quirk bits and
> platform data structure.
> 
> On the downside we add a couple xhci related header files to include/linux/usb/
> Let me know if you see any other issues I missed with this approach.

The problem here is that these drivers are now coupled together, and
that should not be taken lightly. We have a dependency hell in our
hands with a lot of drivers, and the culprit is always platform data.

Build-in device properties may be messy, but I would still say they
are less messy than those quirk flags - you got to admit, they are a
mess. The benefit from build-in properties is in any case the fact
that they remove the need to couple these drivers together.

You can also use something like naming convention if you are worried
about confusion between devicetree properties and build-in only
properties ("build-in:skip-phy-init" or whatever), and of course
require that each of the build-in only property is documented clearly
in drivers/usb/host/xhci-plat.c. But this in any case really can not
be justification for a platform data blob just so you can avoid using
the properties - honestly, it really should to be the other way
around.

Platform data is in practice always problematic. On top of the driver
coupling, it creates maintenance burden, code duplication, etc. Please
don't just accept it lightly. I'm telling you, for hacks like this, the
build-in device properties is a much much safer bet.

thanks,

-- 
heikki
