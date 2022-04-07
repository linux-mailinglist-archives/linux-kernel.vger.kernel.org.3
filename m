Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF854F84A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345653AbiDGQNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbiDGQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:13:33 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 09:11:30 PDT
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834DE12082
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:11:29 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4KZ5VW3F8Pz119V;
        Thu,  7 Apr 2022 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
        s=stigmate; t=1649346739;
        bh=YY96/+Dgd8fDn9ZCYrRnAua7OzxXAs/qOe2O/oagfE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hB6yJ5dsD/HXR6OLOdl2z7fB8tBJwqAD4YRsMwnvfaXOTDNCiwSGbmsD0PrUHfkik
         GU5Xaw1cazoAm8R0Nd5+/s/s9/SweR2DW4lfifAv9DE8Y2CyOEZgg3HoKJp5k9zRjA
         ewoDJHelVgz9LiM1K+DbriZhS+KYeKO6dAqGUtrI=
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: rinni@inventati.org) by localhost (Postfix) with ESMTPSA id 4KZ5VW0Kj1z117n;
        Thu,  7 Apr 2022 15:52:19 +0000 (UTC)
From:   Philip Rinn <rinni@inventati.org>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Philip Rinn <rinni@inventati.org>
Subject: [PATCH v4] arm64: dts: allwinner: a64: olinuxino: Enable audio
Date:   Thu,  7 Apr 2022 17:51:45 +0200
Message-Id: <20220407155145.10891-1-rinni@inventati.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <4fc41278-c46c-6486-a336-f2a329bd6bd0@sholland.org>
References: <4fc41278-c46c-6486-a336-f2a329bd6bd0@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the audio hardware on the Olimex A64-OLinuXino board family.
Tested on the A64-OLinuXino-2Ge8G-IND variant.

Signed-off-by: Philip Rinn <rinni@inventati.org>
---

Changes in v2: added missing &sound {...} part
Changes in v3: removed HDMI audio part as requested by Jernej Škrabec
Changes in v4: right microphone jack is also biased on MBIAS

 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index ec7e2c0e82c1..6f2674bb1b7f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -58,6 +58,15 @@ wifi_pwrseq: wifi_pwrseq {
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	cpvdd-supply = <&reg_eldo1>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
@@ -74,6 +83,10 @@ &cpu3 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&dai {
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -328,6 +341,23 @@ &simplefb_hdmi {
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack Left",
+		    "Microphone", "Microphone Jack Right",
+		    "Headphone", "Headphone Jack";
+	simple-audio-card,routing = "Left DAC", "DACL",
+		    "Right DAC", "DACR",
+		    "Headphone Jack", "HP",
+		    "ADCL", "Left ADC",
+		    "ADCR", "Right ADC",
+		    "Microphone Jack Left", "MBIAS",
+		    "MIC1", "Microphone Jack Left",
+		    "Microphone Jack Right", "MBIAS",
+		    "MIC2", "Microphone Jack Right";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.34.1

