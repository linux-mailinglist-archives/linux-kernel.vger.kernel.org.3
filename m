Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EED587ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiHBPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiHBPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:14:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C6186E2;
        Tue,  2 Aug 2022 08:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF98EB81F40;
        Tue,  2 Aug 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C80C43145;
        Tue,  2 Aug 2022 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659453256;
        bh=L27CX05HZf4XykjyTAIE7PhecrMdrN1NZ0CnEJimvZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+JX0WvqxmaSq2y24PC/MU2F2OTevTS/l3EzJOTjypDjnJVgDWtkK8cQEksYW0YxU
         2zPOej8GeD59ruH7sh+QezJZL2IPMJWdEHyYbIgtOG3ldtn2oB9n5bFCg0gRmAWkro
         QZm3IlUOf07sSMvVFHK9bhMqztgRhrxsfh0Std93MOvNGnhBICFQkr42B8FOtKtrL/
         W4r2AsRJF3ytk8mQdc8+VrYdkw+kzdpDfDyA7u5MPRe4oNXqPxFwjWgQ0kk555VyX4
         oqNACTcs6qG7v/0VUnwrR+3TmLegCOpNheW9c2HJuSh1GrCuJIMauM5QLxW5FaTas2
         wi2TFLRBNuYag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oItbM-0000Ta-BJ; Tue, 02 Aug 2022 17:14:32 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/8] usb: dwc3: qcom: fix runtime PM wakeup
Date:   Tue,  2 Aug 2022 17:14:00 +0200
Message-Id: <20220802151404.1797-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220802151404.1797-1-johan+linaro@kernel.org>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A device must enable wakeups during runtime suspend regardless of
whether it is capable and allowed to wake the system up from system
suspend.

Fixes: 2664deb09306 ("usb: dwc3: qcom: Honor wakeup enabled/disabled state")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index b75ff40f75a2..57d3a0e6f280 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -395,7 +395,7 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
 }
 
-static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
+static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 {
 	u32 val;
 	int i, ret;
@@ -414,7 +414,7 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
 	if (ret)
 		dev_warn(qcom->dev, "failed to disable interconnect: %d\n", ret);
 
-	if (device_may_wakeup(qcom->dev)) {
+	if (wakeup) {
 		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
 		dwc3_qcom_enable_interrupts(qcom);
 	}
@@ -424,7 +424,7 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
 	return 0;
 }
 
-static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
+static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 {
 	int ret;
 	int i;
@@ -432,7 +432,7 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
 	if (!qcom->is_suspended)
 		return 0;
 
-	if (device_may_wakeup(qcom->dev))
+	if (wakeup)
 		dwc3_qcom_disable_interrupts(qcom);
 
 	for (i = 0; i < qcom->num_clocks; i++) {
@@ -939,9 +939,11 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+	bool wakeup = device_may_wakeup(dev);
 	int ret = 0;
 
-	ret = dwc3_qcom_suspend(qcom);
+
+	ret = dwc3_qcom_suspend(qcom, wakeup);
 	if (!ret)
 		qcom->pm_suspended = true;
 
@@ -951,9 +953,10 @@ static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
 static int __maybe_unused dwc3_qcom_pm_resume(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+	bool wakeup = device_may_wakeup(dev);
 	int ret;
 
-	ret = dwc3_qcom_resume(qcom);
+	ret = dwc3_qcom_resume(qcom, wakeup);
 	if (!ret)
 		qcom->pm_suspended = false;
 
@@ -964,14 +967,14 @@ static int __maybe_unused dwc3_qcom_runtime_suspend(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
 
-	return dwc3_qcom_suspend(qcom);
+	return dwc3_qcom_suspend(qcom, true);
 }
 
 static int __maybe_unused dwc3_qcom_runtime_resume(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
 
-	return dwc3_qcom_resume(qcom);
+	return dwc3_qcom_resume(qcom, true);
 }
 
 static const struct dev_pm_ops dwc3_qcom_dev_pm_ops = {
-- 
2.35.1

