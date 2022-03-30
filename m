Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77BF4EC9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349019AbiC3Qsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348994AbiC3QsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:48:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA127970A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:46:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso388450pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EnWYpE15wn4tHabToNlwearQYD9ML88/dHm8ND724Nk=;
        b=LCDVU2bnZZTXTj6e1Hx64WIsifz8r9mSGCV3nPy8XLNSmqYQzU04G45xZbymBGwPGJ
         Tyz/c6PWuJWLWk8XKW41dEaG4K25sHiGsPe9XkEr33avb6fMMDnDgU1xvCXjViEEtBkR
         M7vmIlqCnM3fDGD+mNwQ0SA4S1oDZ36iclOb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EnWYpE15wn4tHabToNlwearQYD9ML88/dHm8ND724Nk=;
        b=LisABiqNCtGIgaG0AqL2GVHeHmrQ8py2q0EMGWMdkCZmg7jFTtaU127VGwWa1tyyo0
         4xqrrsRnpCL2hnWUwG7gdWywcy3pBfqZyzU57r7NRlPDy+9w0I1W+/Z3i+qxEGyHVUcx
         6Q2ApFOnSRriZwfktnDQiLSV0b6omnBweAfWcNTLa9MLOATN/9gq1zNV9sMc561GNuFa
         S24iVPSuZHvyW6USjWzhQK+tkUC+9xLTO+UKqYk5Ct12/dfmULjkh9kdrpu5XlpWO5AG
         mqadVE770flp4zr4+cVnwZ/51lxdj6m5Dn9zZOdaM+mCiSVat8QpK4m4lOJMnwvhkiw+
         CIXg==
X-Gm-Message-State: AOAM533CiAs9H9GxPTBHVo1/PhI0/+1hPKgENE3slj6njqWevBzYdWOu
        OIFibwXMBwXaOv9fG1RBOWGaIA==
X-Google-Smtp-Source: ABdhPJzQTLPZjbs55hr4hQ48KFQY2KhWkCZYWZQ7GvDmsmT7J7EnTMEsnqkkf8qkeLsjyeqTtAVlTQ==
X-Received: by 2002:a17:90a:8d85:b0:1b8:a215:e3e4 with SMTP id d5-20020a17090a8d8500b001b8a215e3e4mr401440pjo.175.1648658798421;
        Wed, 30 Mar 2022 09:46:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d50d:daac:acf3:cda6])
        by smtp.gmail.com with UTF8SMTPSA id 13-20020aa7920d000000b004fa94f26b48sm23290447pfo.118.2022.03.30.09.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 09:46:37 -0700 (PDT)
Date:   Wed, 30 Mar 2022 09:46:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com
Subject: Re: [PATCH v11 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YkSJbLRL1QbINedE@google.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-3-git-send-email-quic_c_sanm@quicinc.com>
 <YjthzwUldu2+31Pm@google.com>
 <b044f873-c20a-c666-0bd3-8d67c3337b03@quicinc.com>
 <20220330040318.GB29680@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220330040318.GB29680@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 09:33:18AM +0530, Pavan Kondeti wrote:
> Hi Sandeep/Matthias,
> 
> On Thu, Mar 24, 2022 at 10:24:55AM +0530, Sandeep Maheswaram (Temp) wrote:
> > 
> > On 3/23/2022 11:37 PM, Matthias Kaehlcke wrote:
> > >On Tue, Mar 22, 2022 at 12:37:53PM +0530, Sandeep Maheswaram wrote:
> > >>During suspend read the status of all port and make sure the PHYs
> > >>are in the correct mode based on current speed.
> > >>Phy interrupt masks are set based on this mode. Keep track of the mode
> > >>of the HS PHY to be able to configure wakeup properly.
> > >>
> > >>Also check during suspend if any wakeup capable devices are
> > >>connected to the controller (directly or through hubs), if there
> > >>are none set a flag to indicate that the PHY is powered
> > >>down during suspend.
> > >>
> > >>Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > >>---
> > >>  drivers/usb/dwc3/core.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
> > >>  1 file changed, 45 insertions(+), 9 deletions(-)
> > >>
> > >>diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > >>index 1170b80..232a734 100644
> > >>--- a/drivers/usb/dwc3/core.c
> > >>+++ b/drivers/usb/dwc3/core.c
> > >>@@ -32,12 +32,14 @@
> > >>  #include <linux/usb/gadget.h>
> > >>  #include <linux/usb/of.h>
> > >>  #include <linux/usb/otg.h>
> > >>+#include <linux/usb/hcd.h>
> > >>  #include "core.h"
> > >>  #include "gadget.h"
> > >>  #include "io.h"
> > >>  #include "debug.h"
> > >>+#include "../host/xhci.h"
> > >>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
> > >>@@ -1861,10 +1863,36 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
> > >>  	return ret;
> > >>  }
> > >>+static void dwc3_set_phy_speed_mode(struct dwc3 *dwc)
> > >>+{
> > >>+
> > >>+	int i, num_ports;
> > >>+	u32 reg;
> > >>+	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
> > >>+	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
> > >>+
> > >>+	dwc->hs_phy_mode = 0;
> > >>+
> > >>+	reg = readl(&xhci_hcd->cap_regs->hcs_params1);
> > >>+
> > >>+	num_ports = HCS_MAX_PORTS(reg);
> > >>+	for (i = 0; i < num_ports; i++) {
> > >>+		reg = readl(&xhci_hcd->op_regs->port_status_base + i * 0x04);
> > >s/0x04/NUM_PORT_REGS/
> > Okay. Will update in next version.
> > >
> > >>+		if (reg & PORT_PE) {
> > >>+			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
> > >>+				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
> > >>+			else if (DEV_LOWSPEED(reg))
> > >>+				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
> > >>+		}
> > >>+	}
> > >>+	phy_set_mode(dwc->usb2_generic_phy, dwc->hs_phy_mode);
> > >>+}
> > >>+
> > >>  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >>  {
> > >>  	unsigned long	flags;
> > >>  	u32 reg;
> > >>+	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
> > >>  	switch (dwc->current_dr_role) {
> > >>  	case DWC3_GCTL_PRTCAP_DEVICE:
> > >>@@ -1877,10 +1905,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >>  		dwc3_core_exit(dwc);
> > >>  		break;
> > >>  	case DWC3_GCTL_PRTCAP_HOST:
> > >>-		if (!PMSG_IS_AUTO(msg)) {
> > >>-			dwc3_core_exit(dwc);
> > >>-			break;
> > >>-		}
> > >>+		dwc3_set_phy_speed_mode(dwc);
> > >>  		/* Let controller to suspend HSPHY before PHY driver suspends */
> > >>  		if (dwc->dis_u2_susphy_quirk ||
> > >>@@ -1896,6 +1921,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >>  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> > >>  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> > >>+
> > >>+		if (!PMSG_IS_AUTO(msg)) {
> > >>+			if (device_may_wakeup(&dwc->xhci->dev) &&
> > >Does the xHCI actually provide the correct information? I think Brian brought
> > >up earlier that xhci-plat always marks the xHCI as wakeup capable, regardless
> > >of whether the specific implementation actually supports wakeup. So a dwc3
> > >without wakeup support would keep the PHY and the dwc3 active during suspend
> > >if wakeup capable devices are connected (unless the admin disabled wakeup),
> > >even though wakeup it doesn't support wakeup.
> > >
> > >Using the wakeup capability/policy of the xHCI to make decisions in the dwc3
> > >driver might still be the best we can do with the weird driver split over 3
> > >drivers for dwc3. Maybe the dwc3 could pass the actual capability to wake up
> > >to the xHCI through a property_entry? Then again, it's actually the 'glue'
> > >driver (dwc3-qcom) who knows about the actual wakeup capability, and not the
> > >dwc3 core/host ...
> > Will check if we can do something regarding this.
> 
> Can we introduce a device tree param to xhci-plat to specify if the underlying
> device is wakeup capable or not. Based on this xhci-plat can call
> device_set_wakeup_capable() with correct argument.

This also came to my mind, the existing 'wakeup-source' property could be an
option, I share your concern about breaking existing use cases though ...

> One immediate problem is that current code unconditionally calls
> device_set_wakeup_capable(&pdev->dev, true). So we may break existing use
> cases also.

> Given that xHC assumes that the undelying device is wakeup capable but dwc3
> tearing the stack during PM suspend does not make any sense. can we atleast
> create a device tree param for dwc3 not to do this?

I'm not sure I fully understand what you have in mind. Are you thinking about
a parameter/property to indicate whether wakeup should be enabled for the dwc3?
'wakeup_source' could serve that purpose, it is also used by xhci-mtk.c and
mtu3_host.c.
