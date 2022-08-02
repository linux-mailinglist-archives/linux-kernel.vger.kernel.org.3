Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98F587ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiHBPOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiHBPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB017E09;
        Tue,  2 Aug 2022 08:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 326B260304;
        Tue,  2 Aug 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E712C43142;
        Tue,  2 Aug 2022 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659453256;
        bh=Oc10iKL8iP3YYDdhgl1EaSJB79hlUqWQiGPijpdOAlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQMOp4ILxF80F4WoPemsfIMbZ6Iz7BuR2KIvzqR5hVXSA6SbgX+wHhJvf1qg53MoA
         qmH7LatfiN5vrLP8CQgimUFEfy12VeFj7+3Xy91UqstCyq6FheaL34QcgZwe3JOE2I
         4OSHvvIgv44fzTvnKG+Go1ZUylGZFF83IodMpPozuw22Qm1sCRXHsdknUFrzirnRGj
         A+YteNZQOdOPHwba/3RIHOcUCfzYTxCPIgbV/VWfrsjCK4c5ulYisjpMcGOUfT2IZD
         oCQlN23usfjVX1sRvBGh9gefeqpZA1DW5gSs9MZV4a05dVzxahdyTliZyLE96o1ANJ
         NxSegAiccZfTA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oItbM-0000TW-5k; Tue, 02 Aug 2022 17:14:32 +0200
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
Subject: [PATCH 2/8] Revert "usb: dwc3: qcom: Keep power domain on to retain controller status"
Date:   Tue,  2 Aug 2022 17:13:58 +0200
Message-Id: <20220802151404.1797-3-johan+linaro@kernel.org>
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

This reverts commit d9be8d5c5b032e5383ff5c404ff4155e9c705429.

Generic power-domain flags must be set before the power-domain is
initialised and must specifically not be modified by drivers for devices
that happen to be in the domain.

To make sure that USB power-domains are left enabled during system
suspend when a device in the domain is in the wakeup path, the
GENPD_FLAG_ACTIVE_WAKEUP flag should instead be set for the domain
unconditionally when it is registered.

Note that this also avoids keeping power-domains on during suspend when
wakeup has not been enabled (e.g. through sysfs).

For the runtime PM case, making sure that the PHYs are not suspended and
that they are in the same domain as the controller prevents the domain
from being suspended. If there are cases where this is not possible or
desirable, the genpd implementation may need to be extended.

Fixes: d9be8d5c5b03 ("usb: dwc3: qcom: Keep power domain on to retain controller status")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index c5e482f53e9d..be2e3dd36440 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -17,7 +17,6 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
-#include <linux/pm_domain.h>
 #include <linux/usb/of.h>
 #include <linux/reset.h>
 #include <linux/iopoll.h>
@@ -757,13 +756,12 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
 
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	struct dwc3_qcom *qcom;
-	struct resource	*res, *parent_res = NULL;
-	int ret, i;
-	bool ignore_pipe_clk;
-	struct generic_pm_domain *genpd;
+	struct device_node	*np = pdev->dev.of_node;
+	struct device		*dev = &pdev->dev;
+	struct dwc3_qcom	*qcom;
+	struct resource		*res, *parent_res = NULL;
+	int			ret, i;
+	bool			ignore_pipe_clk;
 
 	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
 	if (!qcom)
@@ -772,8 +770,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qcom);
 	qcom->dev = &pdev->dev;
 
-	genpd = pd_to_genpd(qcom->dev->pm_domain);
-
 	if (has_acpi_companion(dev)) {
 		qcom->acpi_pdata = acpi_device_get_match_data(dev);
 		if (!qcom->acpi_pdata) {
@@ -881,17 +877,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto interconnect_exit;
 
-	if (device_can_wakeup(&qcom->dwc3->dev)) {
-		/*
-		 * Setting GENPD_FLAG_ALWAYS_ON flag takes care of keeping
-		 * genpd on in both runtime suspend and system suspend cases.
-		 */
-		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
-		device_init_wakeup(&pdev->dev, true);
-	} else {
-		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
-	}
-
+	device_init_wakeup(&pdev->dev, 1);
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-- 
2.35.1

