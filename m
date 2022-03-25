Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0637F4E79A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbiCYRFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiCYREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:04:46 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2001:41d0:d:357f:aaaa::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30F06404;
        Fri, 25 Mar 2022 10:03:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3278131FD9;
        Fri, 25 Mar 2022 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1648227313; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=759V8GCMo8/v4gz2XHnDLRHPRulPKeOQ2ejVOii6Cqg=;
        b=UraC8yxZq38pDkOCRL/19YO+ULXzaYRpXBuHZFNUr/tPcauhlUTQTs05FOc5go9LPkLERp
        s3UHhi+jh1OaI1v8sZohHOJcmlRO4jpSfyhFt4epMm8jEQJNCTFuj/waVcm1pahgBWstag
        RMG5rzWjq4Qe15wCMXEdXaE6eu6pO8zdq50nNPc4gkIKy1cPmZUKzUBw3iIlVLGiZNbNMZ
        P2t+cvkPagTtHBtdOgIiL6/AukjlPvKAsynqY39r8kFraaHysjHKgl/rQ2ZT7+1oND657e
        g9qonnuKFzD1Gknr1IJVAbLx9o6HvHt9ZDXnT4ePX8PzoSMWraGFYhRox3RUxQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm64: meson: update SDIO in dts for JetHub D1
Date:   Fri, 25 Mar 2022 19:55:01 +0300
Message-Id: <20220325165501.81551-4-adeep@lexina.in>
In-Reply-To: <20220325165501.81551-1-adeep@lexina.in>
References: <20220325165501.81551-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the dts to match board's reference design:
- update vddio_boot regulator to 3.3v (Wi-Fi SDIO module)
- add vccq_1v8 regulator with 1.8v for eMMC SDIO

In the first revision of JetHub D1 the vccq_1v8 regulator was 3.3v.
All installed eMMC modules were tested to work in HS200 mode at 3.3v
supply voltage. In the next revisions of the board eMMC will be
powered with 1.8v according to the standard.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 .../dts/amlogic/meson-axg-jethome-jethub-j100.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
index 66c1eeba8f48..bc00d672a357 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
@@ -81,12 +81,22 @@ vddio_ao18: regulator-vddio_ao18 {
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vddao_3v3>;
+		regulator-always-on;
+	};
+
+	vccq_1v8: regulator-vccq_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCCQ_1V8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		vin-supply = <&vddao_3v3>;
 		regulator-always-on;
 	};
 
+
 	usb_pwr: regulator-usb_pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "USB_PWR";
@@ -248,8 +258,7 @@ &sd_emmc_b {
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr104;
-	max-frequency = <200000000>;
+	max-frequency = <50000000>;
 	non-removable;
 	disable-wp;
 
@@ -282,7 +291,7 @@ &sd_emmc_c {
 	mmc-pwrseq = <&emmc_pwrseq>;
 
 	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vddio_boot>;
+	vqmmc-supply = <&vccq_1v8>;
 };
 
 /* UART Bluetooth */
-- 
2.30.2

