Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368D14E3952
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiCVHJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiCVHJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:09:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5D6005D;
        Tue, 22 Mar 2022 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647932904; x=1679468904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KmFbDG7xXoBfyjJdNvXdqkE0h32cJDnnFWEReLnDNUs=;
  b=HqgUDTx/Rz2gxjnT1pcSsT0D2dj1nX2kIgyiDDeDEKfkQQripcDsxvqX
   wUJSI64sZDtzYFAb9jxJ/mCTIji/b5QxZ9xo7XNeppYeMB+2Ycna8aMtZ
   nQn7RPHgM4Zo4894ksUm5pailkrRkVuC94GVLvccyn1TjXmHBMPcp1NtI
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 00:08:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 00:08:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 00:08:22 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 00:08:18 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v11 2/5] usb: dwc3: core: Host wake up support from system suspend
Date:   Tue, 22 Mar 2022 12:37:53 +0530
Message-ID: <1647932876-23249-3-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend read the status of all port and make sure the PHYs
are in the correct mode based on current speed.
Phy interrupt masks are set based on this mode. Keep track of the mode
of the HS PHY to be able to configure wakeup properly.

Also check during suspend if any wakeup capable devices are
connected to the controller (directly or through hubs), if there
are none set a flag to indicate that the PHY is powered
down during suspend.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 drivers/usb/dwc3/core.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1170b80..232a734 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -32,12 +32,14 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/hcd.h>
 
 #include "core.h"
 #include "gadget.h"
 #include "io.h"
 
 #include "debug.h"
+#include "../host/xhci.h"
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
@@ -1861,10 +1863,36 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return ret;
 }
 
+static void dwc3_set_phy_speed_mode(struct dwc3 *dwc)
+{
+
+	int i, num_ports;
+	u32 reg;
+	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
+	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
+
+	dwc->hs_phy_mode = 0;
+
+	reg = readl(&xhci_hcd->cap_regs->hcs_params1);
+
+	num_ports = HCS_MAX_PORTS(reg);
+	for (i = 0; i < num_ports; i++) {
+		reg = readl(&xhci_hcd->op_regs->port_status_base + i * 0x04);
+		if (reg & PORT_PE) {
+			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
+				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
+			else if (DEV_LOWSPEED(reg))
+				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
+		}
+	}
+	phy_set_mode(dwc->usb2_generic_phy, dwc->hs_phy_mode);
+}
+
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	u32 reg;
+	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -1877,10 +1905,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg)) {
-			dwc3_core_exit(dwc);
-			break;
-		}
+		dwc3_set_phy_speed_mode(dwc);
 
 		/* Let controller to suspend HSPHY before PHY driver suspends */
 		if (dwc->dis_u2_susphy_quirk ||
@@ -1896,6 +1921,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
 		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
+
+		if (!PMSG_IS_AUTO(msg)) {
+			if (device_may_wakeup(&dwc->xhci->dev) &&
+			    usb_wakeup_enabled_descendants(hcd->self.root_hub)) {
+				dwc->phy_power_off = false;
+			} else {
+				dwc->phy_power_off = true;
+				dwc3_core_exit(dwc);
+			}
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -1939,11 +1974,12 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg)) {
-			ret = dwc3_core_init_for_resume(dwc);
-			if (ret)
-				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
-			break;
+			if (dwc->phy_power_off) {
+				ret = dwc3_core_init_for_resume(dwc);
+				if (ret)
+					return ret;
+				dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			}
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-- 
2.7.4

