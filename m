Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739F74C1579
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbiBWOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiBWOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:35:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DDB3E59;
        Wed, 23 Feb 2022 06:34:57 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:7ebc:9e38:c4df:c57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBD2EDD;
        Wed, 23 Feb 2022 15:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645626895;
        bh=5HWjNN3NE/0dwqMwH6miWTJGR2v4JvCgHSIlTXK9vFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMkbY4538nW0Bq9QIZbscLJKu/tItsAK0vO9dlnvtbvxb35jWuH97SgGeeM19Shiz
         LtcmeOiwsTMDg/4KteonbPyBDl3ftAO5QQa8z6sTQ5xDi2MoU7LctGnv86vOFcjvLY
         cOUqTDlZ9lhNLLnhylk8X/SLzH1GUofziWgOe1rk=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, f.fainelli@gmail.com, nsaenz@kernel.org,
        robh+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        stefan.wahren@i2se.com, dave.stevenson@raspberrypi.com,
        naush@raspberrypi.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Subject: [PATCH v5.1 1/2] ARM: dts: bcm2835-rpi: Move the firmware clocks
Date:   Wed, 23 Feb 2022 15:34:33 +0100
Message-Id: <20220223143434.71853-1-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208155027.891055-7-jeanmichel.hautbois@ideasonboard.com>
References: <20220208155027.891055-7-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bcm2835-rpi.dtsi is used by all Raspberry Pi generations. Move the
firmware clocks from bcm2711 specific dtsi to the general dtsi.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 arch/arm/boot/dts/bcm2711-rpi.dtsi | 5 -----
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
index ca266c5d9f9b..93b96cebe949 100644
--- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
@@ -19,11 +19,6 @@ aliases {
 };
 
 &firmware {
-	firmware_clocks: clocks {
-		compatible = "raspberrypi,firmware-clocks";
-		#clock-cells = <1>;
-	};
-
 	expgpio: gpio {
 		compatible = "raspberrypi,firmware-gpio";
 		gpio-controller;
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 87ddcad76083..8f988dd253fc 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -21,6 +21,11 @@ firmware: firmware {
 			dma-ranges;
 		};
 
+		firmware_clocks: clocks {
+			compatible = "raspberrypi,firmware-clocks";
+			#clock-cells = <1>;
+		};
+
 		power: power {
 			compatible = "raspberrypi,bcm2835-power";
 			firmware = <&firmware>;
-- 
2.32.0

