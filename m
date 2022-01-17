Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452F04901B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiAQFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:44:56 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:55122 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234284AbiAQFox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642398293; x=1673934293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LRTmn6d4Fhb6GUUsakzLGKaPO1cLGDSQ1y5UdpYtH5E=;
  b=Kah5ssv/df4YJBuahTdNyB1DbaCrGk89nJ9RfhJ83l0c0HcLadQc5yUI
   +UTwkD1y5AWWcE3Nv/AG8TbrcFGj8jHXlN6ap/dobKI110x29sz30+pp/
   yXJaHz+LOTn8S/Ts8GuzDmHXeWLn1ZUVIgVieg96COHw3DC+duZ1KHLra
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jan 2022 21:44:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:44:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:52 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:47 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during probe
Date:   Mon, 17 Jan 2022 11:14:08 +0530
Message-ID: <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the interrupts during probe and remove the disable interrupts
function.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 54dc3d3..7c5e636 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -306,25 +306,7 @@ static void dwc3_qcom_enable_wakeup_irq(int irq)
 	enable_irq_wake(irq);
 }
 
-static void dwc3_qcom_disable_wakeup_irq(int irq)
-{
-	if (!irq)
-		return;
-
-	disable_irq_wake(irq);
-	disable_irq_nosync(irq);
-}
 
-static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
-{
-	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
-
-	dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
-
-	dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
-
-	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
-}
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
@@ -356,9 +338,6 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
 	if (ret)
 		dev_warn(qcom->dev, "failed to disable interconnect: %d\n", ret);
 
-	if (device_may_wakeup(qcom->dev))
-		dwc3_qcom_enable_interrupts(qcom);
-
 	qcom->is_suspended = true;
 
 	return 0;
@@ -372,9 +351,6 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
 	if (!qcom->is_suspended)
 		return 0;
 
-	if (device_may_wakeup(qcom->dev))
-		dwc3_qcom_disable_interrupts(qcom);
-
 	for (i = 0; i < qcom->num_clocks; i++) {
 		ret = clk_prepare_enable(qcom->clks[i]);
 		if (ret < 0) {
@@ -832,6 +808,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	genpd->flags |= GENPD_FLAG_ALWAYS_ON;
 
 	device_init_wakeup(&pdev->dev, 1);
+
+	if (device_may_wakeup(qcom->dev))
+		dwc3_qcom_enable_interrupts(qcom);
+
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-- 
2.7.4

