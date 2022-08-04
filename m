Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EDE589E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiHDPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiHDPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6896452FF0;
        Thu,  4 Aug 2022 08:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9E4F6101A;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA9BC433D7;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659625795;
        bh=Dh5hCxqjDHhUUABQ7LhlclsE5NhFFv8vFrTG0pCapLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWsrMp4poB2jekVZPx7jyCTLXFEm4nqGvO+xkxyIGetdEyaqZteI30WdzR0tWbh2q
         nL+uZQDMO3hLf/uNa/GxPfIyjGlfRW4vkj/tG6qf0cWVftsQSqYml0FvqsjT2BbgOG
         o1yKjH1gbQ8vKdtVjDsethoEq0Z9+UeAvBFohNGuYpwIG/vYMiJl16NYRn64Tey7bP
         saEyy08H0yrfeCjPTdRmvBSAMs87ZSWPWS2Ocz/G0h6qloj5HzBVEASvHYsEAAafFz
         0PJlFrKw/3zIKtD8Vct2cBwpNM/tpZe+GMz2IBsfIbHuDPhTOTgzgftV+2wn9hsyWW
         K+l0mCIrrOQqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJcUL-00069Y-6e; Thu, 04 Aug 2022 17:10:17 +0200
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
Subject: [PATCH v2 5/9] usb: dwc3: qcom: fix runtime PM wakeup
Date:   Thu,  4 Aug 2022 17:09:57 +0200
Message-Id: <20220804151001.23612-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220804151001.23612-1-johan+linaro@kernel.org>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
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
index 6884026b9fad..05b4666fde14 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -397,7 +397,7 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
 }
 
-static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
+static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 {
 	u32 val;
 	int i, ret;
@@ -416,7 +416,7 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
 	if (ret)
 		dev_warn(qcom->dev, "failed to disable interconnect: %d\n", ret);
 
-	if (device_may_wakeup(qcom->dev)) {
+	if (wakeup) {
 		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
 		dwc3_qcom_enable_interrupts(qcom);
 	}
@@ -426,7 +426,7 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
 	return 0;
 }
 
-static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
+static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 {
 	int ret;
 	int i;
@@ -434,7 +434,7 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
 	if (!qcom->is_suspended)
 		return 0;
 
-	if (device_may_wakeup(qcom->dev))
+	if (wakeup)
 		dwc3_qcom_disable_interrupts(qcom);
 
 	for (i = 0; i < qcom->num_clocks; i++) {
@@ -945,9 +945,11 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
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
 
@@ -957,9 +959,10 @@ static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
 static int __maybe_unused dwc3_qcom_pm_resume(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
+	bool wakeup = device_may_wakeup(dev);
 	int ret;
 
-	ret = dwc3_qcom_resume(qcom);
+	ret = dwc3_qcom_resume(qcom, wakeup);
 	if (!ret)
 		qcom->pm_suspended = false;
 
@@ -970,14 +973,14 @@ static int __maybe_unused dwc3_qcom_runtime_suspend(struct device *dev)
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

