Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86C53B503
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiFBIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiFBIZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:25:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3E60DA9;
        Thu,  2 Jun 2022 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654158335; x=1685694335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/JpGcxJx1zccICeK2aLcmZmzUGXEqDBGEkwlWrR3/EU=;
  b=nd3v/EimNkZiathvuzhNK4ynpvEEkNOxmqE4cegZbG17ryryZ/qJV3fy
   Sv+xZwwUoxcNDu0yKZanfcEVIBWjFcGcaZN9/e+eZIri0rLm3Y3sZsYrm
   DkeqnyJ2j7sC7jz0Uv04HPYtdgKJoICgkDs6IOOqZcvUcvqu8mcehbGwg
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2022 01:25:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 01:25:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 01:25:34 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 01:25:28 -0700
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
Subject: [PATCH v20 5/5] usb: dwc3: qcom: Keep power domain on to retain controller status
Date:   Thu, 2 Jun 2022 13:54:37 +0530
Message-ID: <1654158277-12921-6-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
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

If dwc3 is wakeup capable, keep the power domain always ON so that
wakeup from system suspend can be supported. Otherwise, keep the
power domain ON only during runtime suspend to support wakeup from
runtime suspend.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 9395d79..7b6eff5 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_domain.h>
 #include <linux/usb/of.h>
 #include <linux/reset.h>
 #include <linux/iopoll.h>
@@ -756,12 +757,13 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
 
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
-	struct device_node	*np = pdev->dev.of_node;
-	struct device		*dev = &pdev->dev;
-	struct dwc3_qcom	*qcom;
-	struct resource		*res, *parent_res = NULL;
-	int			ret, i;
-	bool			ignore_pipe_clk;
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct dwc3_qcom *qcom;
+	struct resource	*res, *parent_res = NULL;
+	int ret, i;
+	bool ignore_pipe_clk;
+	struct generic_pm_domain *genpd;
 
 	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
 	if (!qcom)
@@ -770,6 +772,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qcom);
 	qcom->dev = &pdev->dev;
 
+	genpd = pd_to_genpd(qcom->dev->pm_domain);
+
 	if (has_acpi_companion(dev)) {
 		qcom->acpi_pdata = acpi_device_get_match_data(dev);
 		if (!qcom->acpi_pdata) {
@@ -877,7 +881,17 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto interconnect_exit;
 
-	device_init_wakeup(&pdev->dev, 1);
+	if (device_can_wakeup(&qcom->dwc3->dev)) {
+		/*
+		 * Setting GENPD_FLAG_ALWAYS_ON flag takes care of keeping
+		 * genpd on in both runtime suspend and system suspend cases.
+		 */
+		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
+		device_init_wakeup(&pdev->dev, true);
+	} else {
+		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+	}
+
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-- 
2.7.4

