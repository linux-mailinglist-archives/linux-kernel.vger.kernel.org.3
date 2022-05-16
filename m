Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8025294C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350241AbiEPXNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 19:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348931AbiEPXNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 19:13:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6145534
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 16:13:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d25so15358078pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5H3z629Hzfk43FPeQ6l/HvvBwzEkP6gG3fYwPQ2Js60=;
        b=jhIu5fQgzwPiId/ZxVydKq1h+XIxL2F7FxjE6RLbLjB/hi59yOcqn8ZQzey53AkfLE
         7+wBDQR3CM6K7jvai1Sv0qU0Tt2NUOhf9Cm37Kv2CCO/OsXB6c2BByySQQTZsFDgXPCV
         Z1zcA7QhHnof/elpjpaLLtOrIfLm8UczZCpMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5H3z629Hzfk43FPeQ6l/HvvBwzEkP6gG3fYwPQ2Js60=;
        b=CpdwQGx8DqV4ocGfs9fCDuKZaLFNxMQoSNR4Gbv5hUw9byBEPCo2pHrg2Ep/fODyA0
         7iqcAlndBLSY0HTEvQc91MgOMcwWXHfieMIArEaZrE7qK3G9rmnzMtu4V9ySENB6QUkX
         6gHIDsC4lRh16uTrqn/7cHNfzHCBpMcoZGT2iPF9Pbx9wTlB3/3kDzKUf8WBEjmLHDc+
         /X6aeCy6KxaUMA9Lg2Q6oWWCy1EBYTc4aYKYJ7woFI1dc4B52FcCPdIqMB8V4DhMxqfK
         XXBRgU0LarJOZfqW1/yU0D8w4SMOBQsT37WEl4YBiQ+8Cn+MxnwE1q8uwBTORlWs7Oft
         wTtw==
X-Gm-Message-State: AOAM5305LgI/8lrLuj2in2aKVMwg05gg1IemPVx7VSuPjYOKbiq7LW8v
        VotJAU/nSbdx25KzMAwCy8Y8hw==
X-Google-Smtp-Source: ABdhPJwwnz9S624j2DyMnf5Z0FuaroubFYKYyHv08Qz90vcyybDrg5YFj61CBAtNHDlIP5z3XyNLVQ==
X-Received: by 2002:a63:8ac7:0:b0:3aa:fa62:5a28 with SMTP id y190-20020a638ac7000000b003aafa625a28mr17119678pgd.400.1652742826365;
        Mon, 16 May 2022 16:13:46 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:641e:de1c:873b:321e])
        by smtp.gmail.com with UTF8SMTPSA id q16-20020a170902dad000b0015e8d4eb26fsm7992100plx.185.2022.05.16.16.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 16:13:45 -0700 (PDT)
Date:   Mon, 16 May 2022 16:13:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [v16 2/5] usb: dwc3: core: Host wake up support from system
 suspend
Message-ID: <YoLaqDCNK0St8qsB@google.com>
References: <1652379802-8318-1-git-send-email-quic_kriskura@quicinc.com>
 <1652379802-8318-3-git-send-email-quic_kriskura@quicinc.com>
 <Yn2M5hrah78jro1C@google.com>
 <4124392b-a40f-c204-f9b0-68c3b22dd652@quicinc.com>
 <20220516044327.GA19209@hu-pkondeti-hyd.qualcomm.com>
 <20220516150445.GB19209@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220516150445.GB19209@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:34:45PM +0530, Pavan Kondeti wrote:
> On Mon, May 16, 2022 at 10:13:27AM +0530, Pavan Kondeti wrote:
> > On Fri, May 13, 2022 at 09:28:16AM +0530, Krishna Kurapati PSSNV wrote:
> > > 
> > > On 5/13/2022 4:10 AM, Matthias Kaehlcke wrote:
> > > >On Thu, May 12, 2022 at 11:53:19PM +0530, Krishna Kurapati wrote:
> > > >>From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > >>
> > > >>During suspend read the status of all port and set hs phy mode
> > > >>based on current speed. Use this hs phy mode to configure wakeup
> > > >>interrupts in qcom glue driver.
> > > >>
> > > >>Check wakeup-source property for dwc3 core node to set the
> > > >>wakeup capability. Drop the device_init_wakeup call from
> > > >>runtime suspend and resume.
> > > >>
> > > >>Also check during suspend if any wakeup capable devices are
> > > >>connected to the controller (directly or through hubs), if there
> > > >>are none set a flag to indicate that the PHY is powered
> > > >>down during suspend.
> > > >>
> > > >>Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > >>Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > >>---
> > > >>  drivers/usb/dwc3/core.c | 30 +++++++++++++++++-------------
> > > >>  drivers/usb/dwc3/core.h |  4 ++++
> > > >>  drivers/usb/dwc3/host.c | 24 ++++++++++++++++++++++++
> > > >>  3 files changed, 45 insertions(+), 13 deletions(-)
> > > >>
> > > >>diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > >>index 01115df..8bcabc5 100644
> > > >>--- a/drivers/usb/dwc3/core.c
> > > >>+++ b/drivers/usb/dwc3/core.c
> > > >>@@ -1785,6 +1785,7 @@ static int dwc3_probe(struct platform_device *pdev)
> > > >>  	platform_set_drvdata(pdev, dwc);
> > > >>  	dwc3_cache_hwparams(dwc);
> > > >>+	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> > > >>  	spin_lock_init(&dwc->lock);
> > > >>  	mutex_init(&dwc->mutex);
> > > >>@@ -1946,10 +1947,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > >>  		dwc3_core_exit(dwc);
> > > >>  		break;
> > > >>  	case DWC3_GCTL_PRTCAP_HOST:
> > > >>-		if (!PMSG_IS_AUTO(msg)) {
> > > >>-			dwc3_core_exit(dwc);
> > > >>-			break;
> > > >>-		}
> > > >>+		dwc3_check_phy_speed_mode(dwc);
> > > >>  		/* Let controller to suspend HSPHY before PHY driver suspends */
> > > >>  		if (dwc->dis_u2_susphy_quirk ||
> > > >>@@ -1965,6 +1963,15 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > >>  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> > > >>  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> > > >>+
> > > >>+		if (!PMSG_IS_AUTO(msg)) {
> > > >>+			if (device_may_wakeup(dwc->dev))
> > > >I think this should be device_can_wakeup(), i.e. hardware capability instead of
> > > >device policy. A drawback of powering the PHYs off is that it causes a high
> > > >power consumption of certain peripherals if VBUS is still supplied, so this
> > > >should be limited to platforms where the PHYs must be powered off (using wakeup
> > > >capability as a proxy for now).
> > > Thnaks Mathias for the review. Will make this change in the next patchset.
> > > >>+				dwc->phy_power_off = false;
> > > >>+			else {
> > > >>+				dwc->phy_power_off = true;
> > > >>+				dwc3_core_exit(dwc);
> > > >>+			}
> > > >>+		}
> > > >>  		break;
> > > >>  	case DWC3_GCTL_PRTCAP_OTG:
> > > >>  		/* do nothing during runtime_suspend */
> > > >>@@ -2008,11 +2015,12 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> > > >>  		break;
> > > >>  	case DWC3_GCTL_PRTCAP_HOST:
> > > >>  		if (!PMSG_IS_AUTO(msg)) {
> > > >>-			ret = dwc3_core_init_for_resume(dwc);
> > > >>-			if (ret)
> > > >>-				return ret;
> > > >>-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> > > >>-			break;
> > > >>+			if (dwc->phy_power_off) {
> > > >>+				ret = dwc3_core_init_for_resume(dwc);
> > > >>+				if (ret)
> > > >>+					return ret;
> > > >>+				dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> > > >>+			}
> > > >>  		}
> > > >>  		/* Restore GUSB2PHYCFG bits that were modified in suspend */
> > > >>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> > > >>@@ -2084,8 +2092,6 @@ static int dwc3_runtime_suspend(struct device *dev)
> > > >>  	if (ret)
> > > >>  		return ret;
> > > >>-	device_init_wakeup(dev, true);
> > > >>-
> > > >>  	return 0;
> > > >>  }
> > > >>@@ -2094,8 +2100,6 @@ static int dwc3_runtime_resume(struct device *dev)
> > > >>  	struct dwc3     *dwc = dev_get_drvdata(dev);
> > > >>  	int		ret;
> > > >>-	device_init_wakeup(dev, false);
> > > >>-
> > > >>  	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
> > > >>  	if (ret)
> > > >>  		return ret;
> > > >>diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > > >>index 81c486b..37397a8 100644
> > > >>--- a/drivers/usb/dwc3/core.h
> > > >>+++ b/drivers/usb/dwc3/core.h
> > > >>@@ -1155,6 +1155,9 @@ struct dwc3 {
> > > >>  	bool			phys_ready;
> > > >>+	unsigned int            hs_phy_mode;
> > > >>+	bool			phy_power_off;
> > > >>+
> > > >>  	struct ulpi		*ulpi;
> > > >>  	bool			ulpi_ready;
> > > >>@@ -1539,6 +1542,7 @@ int dwc3_core_soft_reset(struct dwc3 *dwc);
> > > >>  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
> > > >>  int dwc3_host_init(struct dwc3 *dwc);
> > > >>  void dwc3_host_exit(struct dwc3 *dwc);
> > > >>+void dwc3_check_phy_speed_mode(struct dwc3 *dwc);
> > > >>  #else
> > > >>  static inline int dwc3_host_init(struct dwc3 *dwc)
> > > >>  { return 0; }
> > > >>diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > > >>index f56c30c..e19b40a 100644
> > > >>--- a/drivers/usb/dwc3/host.c
> > > >>+++ b/drivers/usb/dwc3/host.c
> > > >>@@ -12,6 +12,7 @@
> > > >>  #include <linux/platform_device.h>
> > > >>  #include "core.h"
> > > >>+#include "../host/xhci.h"
> > > >>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> > > >>  					int irq, char *name)
> > > >>@@ -136,3 +137,26 @@ void dwc3_host_exit(struct dwc3 *dwc)
> > > >>  {
> > > >>  	platform_device_unregister(dwc->xhci);
> > > >>  }
> > > >>+
> > > >>+void dwc3_check_phy_speed_mode(struct dwc3 *dwc)
> > > >>+{
> > > >>+	int i, num_ports;
> > > >>+	u32 reg;
> > > >>+	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
> > > >>+	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
> > > >>+
> > > >>+	dwc->hs_phy_mode = 0;
> > > >>+
> > > >>+	reg = readl(&xhci_hcd->cap_regs->hcs_params1);
> > > >>+
> > > >>+	num_ports = HCS_MAX_PORTS(reg);
> > > >>+	for (i = 0; i < num_ports; i++) {
> > > >>+		reg = readl(&xhci_hcd->op_regs->port_status_base + i * NUM_PORT_REGS);
> > > >>+		if (reg & PORT_PE) {
> > > >>+			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
> > > >>+				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
> > > >>+			else if (DEV_LOWSPEED(reg))
> > > >>+				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
> > > >>+		}
> > > >>+	}
> > > >>+}
> > > >I anticipate that it might raise concerns from maintainers that
> > > >dwc3_check_phy_speed_mode() accesses xHCI data structures and
> > > >registers directly. Could there be a generic HCD API that provides
> > > >this functionality (if implemented by the specific HCD)?
> > > 
> > > Hi Mathias, we are not sure if there is any such API present currently.
> > > 
> > > Hi Alan, can you help suggest any API (if present) that we can reuse here to
> > > avoid
> > > 
> > > xhci registers and structs here in dwc3.
> > > 
> > 
> > We can probably do something like below to query the speed. This avoids adding
> > another API and does not touch the underlying registers.
> > 
> > Pls define enum usb_device_speed usb2_speed in dwc3 structure.
> > 
> > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > index f29a264..fed1c58 100644
> > --- a/drivers/usb/dwc3/host.c
> > +++ b/drivers/usb/dwc3/host.c
> > @@ -9,9 +9,29 @@
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/usb.h>
> >  
> >  #include "core.h"
> >  
> > +void dwc3_update_hs_phy_speed(struct dwc3 *dwc)
> > +{
> > +	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
> > +	struct usb_device *udev;
> > +
> > +	/*
> > +	 * It is possible to query the speed of all children of
> > +	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
> > +	 * currently supports only 1 port per controller. So
> > +	 * this is sufficient.
> > +	 */
> > +	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> > +
> > +	if (udev)
> > +		dwc->usb2_speed = udev->speed;
> > +	else
> > +		dwc->usb2_speed = USB_SPEED_UNKNOWN;
> > +}
> > +
> >  static int dwc3_host_get_irq(struct dwc3 *dwc)
> >  {
> >  	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
> > 
> > 
> I am also thinking why dwc core needs to cache usb2_speed since dwc3-qcom glue
> driver is the only sole user. We also require it only during suspend and does
> not bother about dwc::usb2_speed correctness outside suspend. Lets move this
> to dwc3-qcom suspend routines where we have to rely on USB2 speed for
> configuring the D+/D- interrupt.

I like both of your suggestions. If something like dwc3_update_hs_phy_speed()
works properly here we should have finally sorted out all the layering issues
Felipe was unhappy about.
