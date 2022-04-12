Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888C94FD4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352576AbiDLHYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbiDLHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:09:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E70149F17;
        Mon, 11 Apr 2022 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649746177; x=1681282177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+XDXOeZpM1JBBXTBf7y/zYMvg/OCqKw83jJ8o8A85GE=;
  b=V/rpB9bSYwqGGS6MH4ADnwoYYHCao6e9qeKiE/W3TLHoU23G+lARompA
   Y6tiSEL6tF/4Al3vazCeKe6zCD+ABWBIfweQmmsydeHJfNFu7tkGsSZTu
   47hExx2nxIN8btnKI44Fd84UvPweyiYowxIvFXqcVDBhWvusJSF5SLm+9
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 23:49:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:49:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 23:49:29 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 23:49:23 -0700
Date:   Tue, 12 Apr 2022 12:19:20 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>,
        <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v13 2/6] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <20220412064920.GD2627@hu-pkondeti-hyd.qualcomm.com>
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649704614-31518-3-git-send-email-quic_c_sanm@quicinc.com>
 <YlSVec5+SpdMZWCz@google.com>
 <36d22ad7-7f11-2f63-cd68-5d564476161e@quicinc.com>
 <20220412050018.GB2627@hu-pkondeti-hyd.qualcomm.com>
 <259c9e87-a52e-c063-7901-2c6decd42675@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <259c9e87-a52e-c063-7901-2c6decd42675@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On Tue, Apr 12, 2022 at 12:08:02PM +0530, Sandeep Maheswaram (Temp) wrote:
> Hi Pavan,
> 
> On 4/12/2022 10:30 AM, Pavan Kondeti wrote:
> >Hi Sandeep,
> >
> >On Tue, Apr 12, 2022 at 10:16:39AM +0530, Sandeep Maheswaram (Temp) wrote:
> >>Hi Matthias,
> >>
> >>On 4/12/2022 2:24 AM, Matthias Kaehlcke wrote:
> >>>On Tue, Apr 12, 2022 at 12:46:50AM +0530, Sandeep Maheswaram wrote:
> >>>>During suspend read the status of all port and set hs phy mode
> >>>>based on current speed. Use this hs phy mode to configure wakeup
> >>>>interrupts in qcom glue driver.
> >>>>
> >>>>Check wakep-source property for dwc3 core node to set the
> >>>s/wakep/wakeup/
> >>Okay. Will update in next version.
> >>>>wakeup capability. Drop the device_init_wakeup call from
> >>>>runtime suspend and resume.
> >>>>
> >>>>Also check during suspend if any wakeup capable devices are
> >>>>connected to the controller (directly or through hubs), if there
> >>>>are none set a flag to indicate that the PHY is powered
> >>>>down during suspend.
> >>>>
> >>>>Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> >>>>---
> >>>A per-patch change log would be really helpful for reviewers, even
> >>>if it doesn't include older versions.
> >>Okay. Will update in next version.
> >>>>  drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
> >>>>  drivers/usb/dwc3/core.h |  4 ++++
> >>>>  drivers/usb/dwc3/host.c | 25 +++++++++++++++++++++++++
> >>>>  3 files changed, 49 insertions(+), 13 deletions(-)
> >>>>
> >>>>diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >>>>index 1170b80..effaa43 100644
> >>>>--- a/drivers/usb/dwc3/core.c
> >>>>+++ b/drivers/usb/dwc3/core.c
> >>>>@@ -32,6 +32,7 @@
> >>>>  #include <linux/usb/gadget.h>
> >>>>  #include <linux/usb/of.h>
> >>>>  #include <linux/usb/otg.h>
> >>>>+#include <linux/usb/hcd.h>
> >>>>  #include "core.h"
> >>>>  #include "gadget.h"
> >>>>@@ -1723,6 +1724,7 @@ static int dwc3_probe(struct platform_device *pdev)
> >>>>  	platform_set_drvdata(pdev, dwc);
> >>>>  	dwc3_cache_hwparams(dwc);
> >>>>+	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> >>>>  	spin_lock_init(&dwc->lock);
> >>>>  	mutex_init(&dwc->mutex);
> >>>>@@ -1865,6 +1867,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >>>>  {
> >>>>  	unsigned long	flags;
> >>>>  	u32 reg;
> >>>>+	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
> >>>>  	switch (dwc->current_dr_role) {
> >>>>  	case DWC3_GCTL_PRTCAP_DEVICE:
> >>>>@@ -1877,10 +1880,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >>>>  		dwc3_core_exit(dwc);
> >>>>  		break;
> >>>>  	case DWC3_GCTL_PRTCAP_HOST:
> >>>>-		if (!PMSG_IS_AUTO(msg)) {
> >>>>-			dwc3_core_exit(dwc);
> >>>>-			break;
> >>>>-		}
> >>>>+		dwc3_check_phy_speed_mode(dwc);
> >>>>  		/* Let controller to suspend HSPHY before PHY driver suspends */
> >>>>  		if (dwc->dis_u2_susphy_quirk ||
> >>>>@@ -1896,6 +1896,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >>>>  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> >>>>  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> >>>>+
> >>>>+		if (!PMSG_IS_AUTO(msg)) {
> >>>>+			if (device_may_wakeup(dwc->dev) &&
> >>>>+			    usb_wakeup_enabled_descendants(hcd->self.root_hub)) {
> >>>You did not answer my question on v12, reposting it:
> >>>
> >>>   Did you ever try whether you could use device_children_wakeup_capable() from
> >>>   [1] instead of usb_wakeup_enabled_descendants()?
> >>>
> >>>   [1] https://patchwork.kernel.org/project/linux-usb/patch/1635753224-23975-2-git-send-email-quic_c_sanm@quicinc.com/#24566065
> >>Sorry ..I have replied in mail yesterday but it is not showing up in
> >>patchwork link.
> >>
> >>Tried with  device_children_wakeup_capable(dwc->dev) instead of
> >>usb_wakeup_enabled_descendants and it always returns true even
> >>
> >>when no devices are connected.
> >>
> >What do you mean by when no devices are connected? There is always
> >root hub connected and we should not power down the DWC3 here even
> >when remote wakeup for root hub is enabled. Essentially
> >usb_wakeup_enabled_descendants() returns true even without any
> >physical devices connected.
> >
> >What does device_children_wakeup_capable() do? Sorry, I could not
> >find this function definition.
> >
> >Thanks,
> >Pavan
> 
> usb_wakeup_enabled_descendants() doesn't consider hubs. It only returns true if any devices
> are connected with wakeup capability apart from hubs. If we consider hubs also dwc3 core exit
> and phy exit will never be called.
> 

copy/pasting the code here. you are passing roothub as udev. As you can see
this function clearly takes the remote wakeup of root hub into account. Lets
take a simple case, we have a roothub with one port. nothing attached. so
we enter runtime suspend. Don't you want to keep PHY ON? otherwise, how can
you detect if a keyboard/mouse attached directly to root hub? 

In your configuration, is remote wakeup enabled for the roothub or not?

/* Count of wakeup-enabled devices at or below udev */
unsigned usb_wakeup_enabled_descendants(struct usb_device *udev)
{
	struct usb_hub *hub = usb_hub_to_struct_hub(udev);

	return udev->do_remote_wakeup +
			(hub ? hub->wakeup_enabled_descendants : 0);
}
> device_children_wakeup_capable() implementation was shared by Matthias in below thread
> https://patchwork.kernel.org/project/linux-usb/patch/1635753224-23975-2-git-send-email-quic_c_sanm@quicinc.com/#24566065
> 
> Probably device_children_wakeup_capable() is returning true because it considers hubs also.
> 

if you see choose_wakeup(), it derives the USB remote wakeup capability from
the device_may_wakeup(), so the patch suggested might work. Note that we have
to take wakeup capability of roothub into account even when there is no
USB device attached.

Thanks,
Pavan
