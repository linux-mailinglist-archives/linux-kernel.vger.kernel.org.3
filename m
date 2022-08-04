Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B328589E61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiHDPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiHDPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:10:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CFA5FAEA;
        Thu,  4 Aug 2022 08:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2581EB825BC;
        Thu,  4 Aug 2022 15:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B390C43161;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659625795;
        bh=3866X7xrJmyeXtTJewkoWNkQ2GbChpdJNVta1bNWBdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNVUVhhtwsUu0LZ4LRZSN142L83weLjz1PEYYw1M4gV9Q1dohaxD4ij8Udv5tNj75
         TAxlGxS8Wf46/W5ueBsWbOwmEW94bDJnseguIKeXJwjX+0CVXGi1dP93PJeje5qbSL
         BdUeiQrC0h6WvL3MhKW2s9atq2PqkgYJvLesIOIYXCCSuNxr0+anRrbGfqaQtVvi+k
         cjGdDGjtoYUFtmTLDwdr+hcmhbq/VLEBGCKWZ3i7vh2iskHMBYV83NgTnuADRYNbov
         XSeeFQ0fjzaO1Zkn3o6YNuMb+I7BEARKNh0+6zK6DeMfyKcQNnEeyPlexeUscelV7h
         Dj8daAwouwJ3Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJcUL-00069h-IA; Thu, 04 Aug 2022 17:10:17 +0200
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
Subject: [PATCH v2 9/9] usb: dwc3: qcom: clean up suspend callbacks
Date:   Thu,  4 Aug 2022 17:10:01 +0200
Message-Id: <20220804151001.23612-10-johan+linaro@kernel.org>
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

Clean up the suspend callbacks by separating the error and success paths
to improve readability.

Also drop a related redundant initialisation.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index b05f67d206d2..197583ff3f3d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -959,14 +959,15 @@ static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
 {
 	struct dwc3_qcom *qcom = dev_get_drvdata(dev);
 	bool wakeup = device_may_wakeup(dev);
-	int ret = 0;
-
+	int ret;
 
 	ret = dwc3_qcom_suspend(qcom, wakeup);
-	if (!ret)
-		qcom->pm_suspended = true;
+	if (ret)
+		return ret;
 
-	return ret;
+	qcom->pm_suspended = true;
+
+	return 0;
 }
 
 static int __maybe_unused dwc3_qcom_pm_resume(struct device *dev)
@@ -976,10 +977,12 @@ static int __maybe_unused dwc3_qcom_pm_resume(struct device *dev)
 	int ret;
 
 	ret = dwc3_qcom_resume(qcom, wakeup);
-	if (!ret)
-		qcom->pm_suspended = false;
+	if (ret)
+		return ret;
 
-	return ret;
+	qcom->pm_suspended = false;
+
+	return 0;
 }
 
 static int __maybe_unused dwc3_qcom_runtime_suspend(struct device *dev)
-- 
2.35.1

