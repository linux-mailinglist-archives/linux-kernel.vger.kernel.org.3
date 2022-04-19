Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0825079EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355465AbiDSTPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357166AbiDSTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:15:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCABB3B3FF;
        Tue, 19 Apr 2022 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650395536; x=1681931536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=s0v6Gyo5kLgOVviPNlXp49QgLmJSYpZlu/oVssdeGgg=;
  b=PwvXacKvSZjW4B+KtSfEBt8kzhOi2IaLXVhwxcmhNB8/FjKW5f7YTNhv
   Efq34cqomlysu+c+6raWr9YmU43X7HI27egQu4vrgVFLZ77BKyp8PBmSC
   QHRotLrHMKhW3L5OW3aA/QgJsM/VvylmQAlESagDu+TFv3u7gJlstAEmk
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 19 Apr 2022 12:12:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 12:12:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 12:12:15 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 12:12:08 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>,
        <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v14 6/7] usb: dwc3: qcom: Keep power domain on to retain controller status
Date:   Wed, 20 Apr 2022 00:41:09 +0530
Message-ID: <1650395470-31333-7-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep the power domain always on during runtime suspend or if the
controller supports wakeup in order to retain controller status
and to support wakeup from devices.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
v14:
Removed the unwanted spaces between the type
and the variable name in dwc3_qcom_probe.
Avoiding device_may_wakeup condition check multiple times.

v13:
Added GENPD_FLAG_RPM_ALWAYS_ON irrespective of wakeup capability.
Enable GENPD_FLAG_ALWAYS_ON only if device_may_wakeup is true.

 drivers/usb/dwc3/dwc3-qcom.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 9804a19..1f9589a 100644
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
@@ -718,12 +719,13 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
 
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
@@ -732,6 +734,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qcom);
 	qcom->dev = &pdev->dev;
 
+	genpd = pd_to_genpd(qcom->dev->pm_domain);
+
 	if (has_acpi_companion(dev)) {
 		qcom->acpi_pdata = acpi_device_get_match_data(dev);
 		if (!qcom->acpi_pdata) {
@@ -839,7 +843,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto interconnect_exit;
 
-	device_init_wakeup(&pdev->dev, 1);
+	genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+
+	if (device_may_wakeup(&qcom->dwc3->dev)) {
+		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
+		device_init_wakeup(&pdev->dev, true);
+	}
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-- 
2.7.4

