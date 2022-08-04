Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6FE589E46
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiHDPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiHDPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A651A00;
        Thu,  4 Aug 2022 08:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C65296102A;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A4C433C1;
        Thu,  4 Aug 2022 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659625795;
        bh=VUaMhxBQV8r/Oni90w/+gnoNx4Bzx7lOs5aOtZB5EB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoPRHKvmlGVaXGsNbciqHSCl8N4I00QdRgFPkAwt2VxUrNIQBCbZdqmK2xgwy/9ub
         tcXmJbbbcOh2MoKfMLqhNfDanyrWIm1u0oDzX1rwY62fgZz97V4KUwWUDkqS+Gssaz
         EdFiyZOcbyQQIwbk4L0AsuoevmXgvweV/I3uI2cnlLIr1vDjVsDzS9e46KphRlEW4j
         4gqIdamg4xfDf0HYTXBM7MddJ+Dy/C5I14aURtVMh6mRuR7KfK7125Tvu5MUcCAve0
         oSWqjUpugNeIeoZqPdpwBmhSC10ZHrd+wGi2rZc63K5Z0etGRCe6H2lEIVUUOuT7Lu
         E1yYdAsAeyr3w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJcUL-00069a-99; Thu, 04 Aug 2022 17:10:17 +0200
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
Subject: [PATCH v2 6/9] usb: dwc3: qcom: fix peripheral and OTG suspend
Date:   Thu,  4 Aug 2022 17:09:58 +0200
Message-Id: <20220804151001.23612-7-johan+linaro@kernel.org>
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

A recent commit implementing wakeup support in host mode instead broke
suspend for peripheral and OTG mode.

The hack that was added in the suspend path to determine the speed of
any device connected to the USB2 bus not only accesses internal driver
data for a child device, but also dereferences a NULL pointer or
accesses freed data when the controller is not acting as host.

There's no quick fix to the layering violation, but since reverting
would leave us with broken suspend in host mode with wakeup triggering
immediately, let's keep the hack for now.

Fix the immediate issues by only checking the host bus speed and
enabling wakeup interrupts when acting as host.

Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - disable wakeup completely instead of falling back to the
   "disconnected" host configuration when not acting as host

 drivers/usb/dwc3/dwc3-qcom.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 05b4666fde14..6ae0b7fc4e2c 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -309,8 +309,13 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
-	struct usb_hcd *hcd = platform_get_drvdata(dwc->xhci);
 	struct usb_device *udev;
+	struct usb_hcd *hcd;
+
+	/*
+	 * FIXME: Fix this layering violation.
+	 */
+	hcd = platform_get_drvdata(dwc->xhci);
 
 	/*
 	 * It is possible to query the speed of all children of
@@ -416,7 +421,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 	if (ret)
 		dev_warn(qcom->dev, "failed to disable interconnect: %d\n", ret);
 
-	if (wakeup) {
+	/*
+	 * The role is stable during suspend as role switching is done from a
+	 * freezable workqueue.
+	 */
+	if (dwc3_qcom_is_host(qcom) && wakeup) {
 		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
 		dwc3_qcom_enable_interrupts(qcom);
 	}
@@ -434,7 +443,7 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 	if (!qcom->is_suspended)
 		return 0;
 
-	if (wakeup)
+	if (dwc3_qcom_is_host(qcom) && wakeup)
 		dwc3_qcom_disable_interrupts(qcom);
 
 	for (i = 0; i < qcom->num_clocks; i++) {
-- 
2.35.1

