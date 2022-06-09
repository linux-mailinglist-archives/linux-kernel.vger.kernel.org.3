Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9884544810
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbiFIJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbiFIJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:54:34 -0400
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [IPv6:2a01:4f8:a0:5496::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399A195974;
        Thu,  9 Jun 2022 02:54:29 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1654768466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EHEuZTnae7JIoJINVmYOdraD9EvP6HM8Di56khNR+uQ=;
        b=r94IREh6bcly39S5nnsnaC5t+otHkGUEXkMrZ9yFu0zBDWm6TtlStPI0XD1Bc0Thiz4VhD
        XPbChYw5Y5VVPHQ0PF5ysE6ugU3fiCwUC8jD+sp6wHGear7yTJxH9USFXF6AoqKM9/oY8L
        clMD62V4sKmSRhQcPZNBvbMud5+MhvuYLPQWwDflx2Rjw0uyzNczWKSgS9vmpHDfYs8PYQ
        ZcatI4/USt/HRHZl6fGhTMhqtigmjgmGD7jey4HknDfruQwI0hx4P44QGEpidKmWr8D7iL
        lKJrXA7xhFEGBxbAfuE9ZH+AqnR976qYgMio72jXzlLg89tmRp7Wdb3PxFC4Rg==
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>
Subject: [PATCH 1/2] arch: arm64: qcom: sdm845-shift-axolotl: fix Bluetooth firmware loading
Date:   Thu,  9 Jun 2022 11:54:11 +0200
Message-Id: <20220609095412.211060-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=amartinz@shiftphones.com smtp.mailfrom=amartinz@shiftphones.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dylan Van Assche <me@dylanvanassche.be>

Add hsuart0 alias, firmware name and prevent garbage data on Bluetooth UART lines
on the SHIFT 6mq based on the Qualcomm SDM845 chip.
I discovered that these were missing by comparing the DTS with similar
devices such as the Oneplus 6/6T and Dragonboard 845c.

Signed-of-by: Dylan Van Assche <me@dylanvanassche.be>
Tested-by: Alexander Martinz <amartinz@shiftphones.com>
---
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 103cc40816fd..fa72f23ef0c2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -20,6 +20,7 @@ / {
 
 	aliases {
 		display0 = &framebuffer0;
+		hsuart0 = &uart6;
 		serial0 = &uart9;
 	};
 
@@ -529,6 +530,32 @@ volume_down_resin: resin {
 	};
 };
 
+/*
+ * Prevent garbage data on bluetooth UART lines
+ */
+&qup_uart6_default {
+        pinmux {
+                pins = "gpio45", "gpio46", "gpio47", "gpio48";
+                function = "qup6";
+        };
+
+        cts {
+                pins = "gpio45";
+                bias-pull-down;
+        };
+
+        rts-tx {
+                pins = "gpio46", "gpio47";
+                drive-strength = <2>;
+                bias-disable;
+        };
+
+        rx {
+                pins = "gpio48";
+                bias-pull-up;
+        };
+};
+
 &qup_uart9_default {
 	pinconf-rx {
 		pins = "gpio5";
@@ -667,6 +694,12 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
+		/*
+		 * This path is relative to the qca/
+		 * subdir under lib/firmware.
+		 */
+		firmware-name = "axolotl/crnv21.bin";
+
 		vddio-supply = <&vreg_s4a_1p8>;
 		vddxo-supply = <&vreg_l7a_1p8>;
 		vddrf-supply = <&vreg_l17a_1p3>;
-- 
2.36.1

