Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0F853B206
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiFBDMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiFBDMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:12:41 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8378F2AD98C;
        Wed,  1 Jun 2022 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654139559; x=1685675559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Nfkv+4eY4YXFFYfGobF1DPR6cfo7NJOqSSGFIKGYvTE=;
  b=LiTnDr/c5SXwYIRW8IK2yoh5WrhvWJbzWV7yU5LIegWg+zNRDv5I3DDP
   99QmTPydEuVG23gwXZwgvsAyi+cVkaSmUQ0rASxHq6aez7u8+dpbCg4Um
   2qx1I4AfTtpi5ZjBFVM+yFWZ5OsMeaX8YV0/1GAIhFTlYUvwV7jrHDCoq
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Jun 2022 20:12:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 20:12:38 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 20:12:38 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 20:12:32 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v19 4/5] usb: dwc3: qcom: Configure wakeup interrupts during suspend
Date:   Thu, 2 Jun 2022 08:41:54 +0530
Message-ID: <1654139515-8177-5-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654139515-8177-1-git-send-email-quic_kriskura@quicinc.com>
References: <1654139515-8177-1-git-send-email-quic_kriskura@quicinc.com>
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

From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>

Configure DP/DM line interrupts based on the USB2 device attached to
the root hub port. When HS/FS device is connected, configure the DP line
as falling edge to detect both disconnect and remote wakeup scenarios. When
LS device is connected, configure DM line as falling edge to detect both
disconnect and remote wakeup. When no device is connected, configure both
DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 72 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7352124..56ecee0 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -20,7 +20,8 @@
 #include <linux/usb/of.h>
 #include <linux/reset.h>
 #include <linux/iopoll.h>
-
+#include <linux/usb/hcd.h>
+#include <linux/usb.h>
 #include "core.h"
 
 /* USB QSCRATCH Hardware registers */
@@ -76,6 +77,7 @@ struct dwc3_qcom {
 	int			dp_hs_phy_irq;
 	int			dm_hs_phy_irq;
 	int			ss_phy_irq;
+	enum usb_device_speed	usb2_speed;
 
 	struct extcon_dev	*edev;
 	struct extcon_dev	*host_edev;
@@ -296,11 +298,34 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 	icc_put(qcom->icc_path_apps);
 }
 
-static void dwc3_qcom_enable_wakeup_irq(int irq)
+enum usb_device_speed dwc3_qcom_update_usb2_speed(struct dwc3_qcom *qcom)
+{
+	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct usb_hcd *hcd = platform_get_drvdata(dwc->xhci);
+	struct usb_device *udev;
+
+	/*
+	 * It is possible to query the speed of all children of
+	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
+	 * currently supports only 1 port per controller. So
+	 * this is sufficient.
+	 */
+	udev = usb_hub_find_child(hcd->self.root_hub, 1);
+
+	if (!udev)
+		return USB_SPEED_UNKNOWN;
+
+	return udev->speed;
+}
+
+static void dwc3_qcom_enable_wakeup_irq(int irq, unsigned int polarity)
 {
 	if (!irq)
 		return;
 
+	if (polarity)
+		irq_set_irq_type(irq, polarity);
+
 	enable_irq(irq);
 	enable_irq_wake(irq);
 }
@@ -318,22 +343,47 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
 	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
 
-	dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
-
-	dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+	if (qcom->usb2_speed == USB_SPEED_LOW) {
+		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
+			(qcom->usb2_speed == USB_SPEED_FULL)) {
+		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+	} else {
+		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+	}
 
 	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq);
+	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq, 0);
 
-	dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
+	/*
+	 * Configure DP/DM line interrupts based on the USB2 device attached to
+	 * the root hub port. When HS/FS device is connected, configure the DP line
+	 * as falling edge to detect both disconnect and remote wakeup scenarios. When
+	 * LS device is connected, configure DM line as falling edge to detect both
+	 * disconnect and remote wakeup. When no device is connected, configure both
+	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
+	 */
 
-	dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
+	if (qcom->usb2_speed == USB_SPEED_LOW) {
+		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
+						IRQ_TYPE_EDGE_FALLING);
+	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
+			(qcom->usb2_speed == USB_SPEED_FULL)) {
+		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
+						IRQ_TYPE_EDGE_FALLING);
+	} else {
+		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
+						IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
+						IRQ_TYPE_EDGE_RISING);
+	}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq);
+	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
@@ -355,8 +405,10 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
 	if (ret)
 		dev_warn(qcom->dev, "failed to disable interconnect: %d\n", ret);
 
-	if (device_may_wakeup(qcom->dev))
+	if (device_may_wakeup(qcom->dev)) {
+		qcom->usb2_speed = dwc3_qcom_update_usb2_speed(qcom);
 		dwc3_qcom_enable_interrupts(qcom);
+	}
 
 	qcom->is_suspended = true;
 
-- 
2.7.4

