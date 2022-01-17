Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C74901B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiAQFoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:44:54 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53011 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiAQFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642398288; x=1673934288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5yVgU9EVxE9GEBX+xGWh+yY4Ybpo0uRO2KedqJ9IQao=;
  b=LfaPMV76dqaBOyLfVAglw9AkKsq0sguT4aZNOYsFr5/0Y6gEuQubVK28
   H+EUqROmLJPjtPrQMEanOw8v+12v6hYnokz9n7JePfPeYoHWBWNeAn7il
   +5Rdm0hJNZslnQNKyB7b6aBGAYWLPiyEyZvd5+NrO0iD9MbM7iBp1FLWS
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 21:44:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:44:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:47 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:44:43 -0800
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
Subject: [PATCH v10 5/6] usb: dwc3: qcom: Keep power domain on to retain controller status
Date:   Mon, 17 Jan 2022 11:14:07 +0530
Message-ID: <1642398248-21753-6-git-send-email-quic_c_sanm@quicinc.com>
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

Keep the power domain on in order to retail controller status and
to support wakeup from devices.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index b13e542..54dc3d3 100644
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
@@ -710,6 +711,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct resource		*res, *parent_res = NULL;
 	int			ret, i;
 	bool			ignore_pipe_clk;
+	struct generic_pm_domain *genpd;
 
 	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
 	if (!qcom)
@@ -718,6 +720,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qcom);
 	qcom->dev = &pdev->dev;
 
+	genpd = pd_to_genpd(qcom->dev->pm_domain);
+
 	if (has_acpi_companion(dev)) {
 		qcom->acpi_pdata = acpi_device_get_match_data(dev);
 		if (!qcom->acpi_pdata) {
@@ -825,6 +829,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto interconnect_exit;
 
+	genpd->flags |= GENPD_FLAG_ALWAYS_ON;
+
 	device_init_wakeup(&pdev->dev, 1);
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
-- 
2.7.4

