Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C532C587ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiHBPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiHBPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:14:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7062D167CA;
        Tue,  2 Aug 2022 08:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D823B81F3A;
        Tue,  2 Aug 2022 15:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE7DC43151;
        Tue,  2 Aug 2022 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659453256;
        bh=HDXSUJAM6KP/jceAZJSA5f6hHQ5LwdeRI3r8X6y5ils=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUreBEosfSUZFnnsF46nBBB1G1aIvl2/nh2ElYeeYb6ttZVzKyuOY8xvCGlV/ncQB
         jkFdPCt23Lem9bsE8iNEHD96FPyJPZ6kERpW0ft/l1+F74wr4BZ/nnQzngibu8GZzM
         vDU9tM4bSm5bad1YFVFZEVoQIHTbISSyI2BG7fdPY/bxSraWQ+Xnlo/fdHDbgbzPMv
         bDCpnPUR4XoTtQ+wGb3lgCbsCpcX6Lgaaq/tJsakdW3VyOWpIeK+27kq0cfAjAqe7T
         vHFwsx1kstJh7LskeHAqAOHggaF5liARMTogPtKsuzQKfDBI1pr/i1TqYxfCBNQCm6
         twIDMAHz4yrHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oItbM-0000Ti-M9; Tue, 02 Aug 2022 17:14:32 +0200
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
Subject: [PATCH 8/8] usb: dwc3: qcom: clean up suspend callbacks
Date:   Tue,  2 Aug 2022 17:14:04 +0200
Message-Id: <20220802151404.1797-9-johan+linaro@kernel.org>
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

Clean up the suspend callbacks by separating the error and success paths
to improve readability.

Also drop a related redundant initialisation.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 1bd2818b4daa..01e8c2fc6914 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -944,14 +944,15 @@ static int __maybe_unused dwc3_qcom_pm_suspend(struct device *dev)
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
@@ -961,10 +962,12 @@ static int __maybe_unused dwc3_qcom_pm_resume(struct device *dev)
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

