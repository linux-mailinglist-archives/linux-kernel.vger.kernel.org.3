Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252A0589E65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiHDPKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiHDPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:10:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDA1F637;
        Thu,  4 Aug 2022 08:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EBE4B82521;
        Thu,  4 Aug 2022 15:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5672DC43159;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659625795;
        bh=AgrQZfa5kuZZEXO/hg1xFcWJZuBRQIUG8Mw/dSpRsM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cw4EtrOYS/wDTxjM9Nm9Nv1EmSHMeT0Fgb0dyICUhwaN/4V4HX6NFPDL/FqMOM6gm
         HKBL/K2Lzx5t0RQt0Niyxj/RP0uO+LTsFUWtG5PQVpqdAgJTHTFtwTM1fyHJfa+Z/0
         oU18S8eJpKHtbCdBrx8NZP44K8e/YNwHyFYOPMarxl8bnePJ51+3nVfiFftbfySnHL
         nIQTMFr4W7YvKhnhxIz+cOt7o7lUOqSPzIYynUJbVQ9bDtSAOApQ08SI+rJ8nWrH+R
         EP/U7h/RWE2t7JFCteqFJ+VJPUdqRxRLe9zoFk+Ko/DFY4K8yFmiJNGRr9mlCD1HEJ
         KTJBW0rmJahEg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJcUL-00069e-Ev; Thu, 04 Aug 2022 17:10:17 +0200
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
Subject: [PATCH v2 8/9] usb: dwc3: qcom: fix wakeup implementation
Date:   Thu,  4 Aug 2022 17:10:00 +0200
Message-Id: <20220804151001.23612-9-johan+linaro@kernel.org>
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

It is the Qualcomm glue wakeup interrupts that may be able to wake the
system from suspend and this can now be described in the devicetree.

Move the wakeup-source property handling over from the core driver and
instead propagate the capability setting to the core device during
probe.

This is needed as there is currently no way for the core driver to query
the wakeup setting of the glue device, but it is the core driver that
manages the PHY power state during suspend.

Also don't leave the PHYs enabled when system wakeup has been disabled
through sysfs.

Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/core.c      | 5 ++---
 drivers/usb/dwc3/dwc3-qcom.c | 6 +++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 16d1f328775f..8c8e32651473 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1822,7 +1822,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
-	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
 
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
@@ -1984,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
 			dwc3_core_exit(dwc);
 			break;
 		}
@@ -2045,7 +2044,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
+		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 6ae0b7fc4e2c..b05f67d206d2 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -786,6 +786,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	struct resource		*res, *parent_res = NULL;
 	int			ret, i;
 	bool			ignore_pipe_clk;
+	bool			wakeup_source;
 
 	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
 	if (!qcom)
@@ -901,7 +902,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto interconnect_exit;
 
-	device_init_wakeup(&pdev->dev, 1);
+	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
+	device_init_wakeup(&pdev->dev, wakeup_source);
+	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
+
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-- 
2.35.1

