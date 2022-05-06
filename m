Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22651DDC8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443872AbiEFQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443870AbiEFQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:47:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B056D4EE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:43:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x18so7961917plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bh6CSxzg+6JEuytBMw9j2GAuoj8y6isr1C8LlTE1oj0=;
        b=Wz5z/M4s4vEelC1rO7cvaON/5FHKnFmJUoy9cc/K0NCPWdiNWFx7lnSZCQI8WNZgRR
         oU5QrhdRhNqo7EbI18EeYzFv9eBZvL/FWHQ386cV0Kqgw0omywbeyeU1VKkDnV1eSsxX
         XkwwaphhHcbe5+IVaU1X4s7tc0XwptOkfXx0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bh6CSxzg+6JEuytBMw9j2GAuoj8y6isr1C8LlTE1oj0=;
        b=rZydF6xoNPpZjf7IDUesiKRj1fgPIboOfQt8Z6EuCHhWe1btZHvPxxazY2PTyV56bz
         4ShfcjWZx4AszritlnqYKIHcP6hAhIBCF4U5CccGrlfWIMbY2Ht1Am50nTnyd/WDQG2l
         aBCK1oqrVG8VhFChkwXn1GfjVNsR0JNDeOundYQaXWo9DO//u62nC8M643jCj1Lhqw8h
         H6BC70gvfHO6m9D+FznVKCmk1cqg32dZ6NAUa6vv1xbCxIRcA+uSOHiB/RSS/97Ubv7F
         WT/X69fOWmD6axJYhIAmR7Xm0CQbulvhh4Z8ZXdnIRpDX1ROAv8rxlFre8O00G6ntvto
         +sjA==
X-Gm-Message-State: AOAM533i2XEvn2bfE0NNZJQqhbRj4qbsmj8aAK0RgkGV+6Ayg17xwCt1
        ebr/IdwurPtOw13o9CZ/iX+kfQ==
X-Google-Smtp-Source: ABdhPJxF4L/wGCp4qcxZiMgtimiFuwwc7nuYDpCZz76X/jycgdjKkXzFHiicexTd65Ug7W5tdFP2rQ==
X-Received: by 2002:a17:903:94:b0:15c:f928:a373 with SMTP id o20-20020a170903009400b0015cf928a373mr4651954pld.26.1651855437956;
        Fri, 06 May 2022 09:43:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5605:d5cd:699b:1b26])
        by smtp.gmail.com with UTF8SMTPSA id c14-20020a170902848e00b0015e8d4eb205sm1969908plo.79.2022.05.06.09.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 09:43:57 -0700 (PDT)
Date:   Fri, 6 May 2022 09:43:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v14 3/7] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YnVQS5twzZ/q1iWu@google.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
 <1650395470-31333-4-git-send-email-quic_c_sanm@quicinc.com>
 <YnK79i3NiTdMmC98@google.com>
 <20220505032618.GC4640@hu-pkondeti-hyd.qualcomm.com>
 <YnP/PZViq1u0f2yl@google.com>
 <20220506030107.GD4640@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220506030107.GD4640@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 08:31:07AM +0530, Pavan Kondeti wrote:
> On Thu, May 05, 2022 at 09:45:49AM -0700, Matthias Kaehlcke wrote:
> > On Thu, May 05, 2022 at 08:56:18AM +0530, Pavan Kondeti wrote:
> > > On Wed, May 04, 2022 at 10:46:30AM -0700, Matthias Kaehlcke wrote:
> > > > On Wed, Apr 20, 2022 at 12:41:06AM +0530, Sandeep Maheswaram wrote:
> > > > > During suspend read the status of all port and set hs phy mode
> > > > > based on current speed. Use this hs phy mode to configure wakeup
> > > > > interrupts in qcom glue driver.
> > > > > 
> > > > > Check wakeup-source property for dwc3 core node to set the
> > > > > wakeup capability. Drop the device_init_wakeup call from
> > > > > runtime suspend and resume.
> > > > > 
> > > > > Also check during suspend if any wakeup capable devices are
> > > > > connected to the controller (directly or through hubs), if there
> > > > > are none set a flag to indicate that the PHY is powered
> > > > > down during suspend.
> > > > > 
> > > > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > > ---
> > > > > v14:
> > > > > Used device_children_wakeup_capable instead of usb_wakeup_enabled_descendants.
> > > > > 
> > > > > v13:
> > > > > Changed dwc3_set_phy_speed_mode to dwc3_check_phy_speed_mode.
> > > > > Removed device_init_wakeup calls from dwc3_runtime_suspend and dwc3_runtime_resume
> > > > > as we have a new dt property wakeup-source.
> > > > > 
> > > > > 
> > > > >  drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
> > > > >  drivers/usb/dwc3/core.h |  4 ++++
> > > > >  drivers/usb/dwc3/host.c | 24 ++++++++++++++++++++++++
> > > > >  3 files changed, 48 insertions(+), 13 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > > index 1170b80..898aa66 100644
> > > > > --- a/drivers/usb/dwc3/core.c
> > > > > +++ b/drivers/usb/dwc3/core.c
> > > > > @@ -32,6 +32,7 @@
> > > > >  #include <linux/usb/gadget.h>
> > > > >  #include <linux/usb/of.h>
> > > > >  #include <linux/usb/otg.h>
> > > > > +#include <linux/usb/hcd.h>
> > > > >  
> > > > >  #include "core.h"
> > > > >  #include "gadget.h"
> > > > > @@ -1723,6 +1724,7 @@ static int dwc3_probe(struct platform_device *pdev)
> > > > >  
> > > > >  	platform_set_drvdata(pdev, dwc);
> > > > >  	dwc3_cache_hwparams(dwc);
> > > > > +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> > > > >  
> > > > >  	spin_lock_init(&dwc->lock);
> > > > >  	mutex_init(&dwc->mutex);
> > > > > @@ -1865,6 +1867,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > > >  {
> > > > >  	unsigned long	flags;
> > > > >  	u32 reg;
> > > > > +	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
> > > > >  
> > > > >  	switch (dwc->current_dr_role) {
> > > > >  	case DWC3_GCTL_PRTCAP_DEVICE:
> > > > > @@ -1877,10 +1880,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > > >  		dwc3_core_exit(dwc);
> > > > >  		break;
> > > > >  	case DWC3_GCTL_PRTCAP_HOST:
> > > > > -		if (!PMSG_IS_AUTO(msg)) {
> > > > > -			dwc3_core_exit(dwc);
> > > > > -			break;
> > > > > -		}
> > > > > +		dwc3_check_phy_speed_mode(dwc);
> > > > >  
> > > > >  		/* Let controller to suspend HSPHY before PHY driver suspends */
> > > > >  		if (dwc->dis_u2_susphy_quirk ||
> > > > > @@ -1896,6 +1896,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > > >  
> > > > >  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> > > > >  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> > > > > +
> > > > > +		if (!PMSG_IS_AUTO(msg)) {
> > > > > +			if (device_may_wakeup(dwc->dev) &&
> > > > > +			    device_children_wakeup_capable(&hcd->self.root_hub->dev)) {
> > > > > +				dwc->phy_power_off = false;
> > > > > +			} else {
> > > > > +				dwc->phy_power_off = true;
> > > > > +				dwc3_core_exit(dwc);
> > > > 
> > > > I found that shutting the PHYs down during suspend leads to high power
> > > > consumption of a downstream hub (about 80mW vs 15mW when the PHYs are
> > > > not shut down).
> > > > 
> > > > It would be interesting to know if this also impacts other non-hub
> > > > peripherals. Unfortunately I can't test that, the hub on my system is
> > > > soldered to the board.
> > > > 
> > > > I understand that shutting the PHYs down might be beneficial in terms
> > > > of power on some systems, however on those I'm looking at we'd strongly
> > > > prefer to save the 65mW of power consumed by the hub, rather than
> > > > whatever smaller amount of power that is saved by powering down the
> > > > PHYs.
> > > > 
> > > > Could we introduce a sysfs attribute (or some other sort of knob) to
> > > > allow the admin to configure whether the PHYs should remain on or off
> > > > during suspend? That is assuming that it is actually desirable to power
> > > > them off on some systems.
> > > 
> > > The result may vary across SoCs also. The current proposal is to keep PHY
> > > powered during system suspend if any of the downstream USB devices are enabled
> > > for wakeup. This also includes USB2/USB3 root hub. If one wants to keep PHY
> > > always powered on even when no device is attached, they can do so by enabling
> > > wakeup (echo enabled > /sys/bus/usb/devices/usbX/power/wakeup). This is anyway
> > > needed if you want to detect a peripheral attach during system suspend.
> > 
> > My concern is that it is not evident for an admin what causes the high power
> > consumption of the USB client (if they detect/localize it in the first place),
> > and even less that wakeup needs to be enabled to mitigate it.
> > 
> > Why can't we just put the PHYs in suspend, rather than taking the controller
> > down completely during suspend?
> 
> Agreed and I also have the same question.
> 
> I don't know the background on why DWC3 chooses to power down the PHY(s)
> during system suspend. Probably it is beneficial in some board designs.
> Atleast this patch series provides a way to wakeup the USB from system
> suspend, which also can be used not to power down the PHY(s). If all the users
> of DWC3 agree that powering down the PHY is bad, then we can do something
> about it.

I came across this commit while doing a bit of archeology:

  commit c4a5153e87fdf6805f63ff57556260e2554155a5
  Author: Manu Gautam <mgautam@codeaurora.org>
  Date:   Thu Jan 18 16:54:30 2018 +0530

  usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode

  Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
  host bus-suspend/resume") updated suspend/resume routines to not
  power_off and reinit PHYs/core for host mode.
  It broke platforms that rely on DWC3 core to power_off PHYs to
  enter low power state on system suspend.

  Perform dwc3_core_exit/init only during host mode system_suspend/
  resume to addresses power regression from above mentioned patch
  and also allow USB session to stay connected across
  runtime_suspend/resume in host mode. While at it also replace
  existing checks for HOST only dr_mode with current_dr_role to
  have similar core driver behavior for both Host-only and DRD+Host
  configurations.

  Fixes: 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during host bus-suspend/resume")
  Reviewed-by: Roger Quadros <rogerq@ti.com>
  Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
  Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>


So apparently powering off the core and PHYs is needed on some
platforms.

We could introduce a DT property that indicates that keeping the core/PHYs
on is supported. Another hint could be the fact that the controller is
marked as wakeup capable, however that would still power the core/PHYs
down if the 'wakeup-source' property isn't set for a controller that is
technically wakeup capable.
