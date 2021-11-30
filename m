Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D706E464032
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbhK3Vaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:30:55 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:9000 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbhK3Vac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638307608;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CCzoD26r5WYLfaWl8adjwn/dam2pLbSIK+t8rP3qAZQ=;
    b=fyru67L0MqCKbfk/QqcZue4IEvgTSLrnPMRUE2nCLiul80jy3m/1MZUWo49yRwO771
    Gjtnl29dbNju+/ISUidAQccHpHtRDTFKAXSAAzi0QhvGddNMs+GI/idUbp4/9yX1/PDN
    6wwRiaqFSURBWLqmAMyM0wK7g1/IJmLE11aH08SIk2OHunHcCihlMmCT48kYPxCKE4Y1
    Xx8ODTzIqs8ohl/REHQH1XXMwfMVPHjelf7t5dY/XYHwR3L2gfC+NRiwXhsH2uJwTAJ5
    r2joWPKAmmiU6K9CvYmdUSR6WE45gNyi2uCW5d+t4dsSG9QwWksQAa2Scrqd57Ca6vKM
    1nLA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1KHeBQyh+ITDDJuCr4="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id e05ed8xAULQmToB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 Nov 2021 22:26:48 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v10 6/8] MIPS: DTS: CI20: Add DT nodes for HDMI setup
Date:   Tue, 30 Nov 2021 22:26:39 +0100
Message-Id: <7ea4b955be3531bf3988c383e0a5775488d2d56c.1638307601.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638307601.git.hns@goldelico.com>
References: <cover.1638307601.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Boddie <paul@boddie.org.uk>

We need to hook up
* HDMI connector
* HDMI power regulator
* JZ4780_CLK_HDMI @ 27 MHz
* DDC pinmux
* HDMI and LCDC endpoint connections

Signed-off-by: Paul Boddie <paul@boddie.org.uk>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 72 ++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index b249a4f0f6b62..3e336b3dbb109 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -78,6 +78,18 @@ eth0_power: fixedregulator@0 {
 		enable-active-high;
 	};
 
+	hdmi_out: connector {
+		compatible = "hdmi-connector";
+		label = "HDMI OUT";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&dw_hdmi_out>;
+			};
+		};
+	};
+
 	ir: ir {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
@@ -102,6 +114,17 @@ otg_power: fixedregulator@2 {
 		gpio = <&gpf 14 GPIO_ACTIVE_LOW>;
 		enable-active-high;
 	};
+
+	hdmi_power: fixedregulator@3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "hdmi_power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpa 25 0>;
+		enable-active-high;
+	};
 };
 
 &ext {
@@ -114,11 +137,12 @@ &cgu {
 	 * precision.
 	 */
 	assigned-clocks = <&cgu JZ4780_CLK_OTGPHY>, <&cgu JZ4780_CLK_RTC>,
-			  <&cgu JZ4780_CLK_SSIPLL>, <&cgu JZ4780_CLK_SSI>;
+			  <&cgu JZ4780_CLK_SSIPLL>, <&cgu JZ4780_CLK_SSI>,
+			  <&cgu JZ4780_CLK_HDMI>;
 	assigned-clock-parents = <0>, <&cgu JZ4780_CLK_RTCLK>,
 				 <&cgu JZ4780_CLK_MPLL>,
 				 <&cgu JZ4780_CLK_SSIPLL>;
-	assigned-clock-rates = <48000000>, <0>, <54000000>;
+	assigned-clock-rates = <48000000>, <0>, <54000000>, <0>, <27000000>;
 };
 
 &tcu {
@@ -509,6 +533,12 @@ pins_i2c4: i2c4 {
 		bias-disable;
 	};
 
+	pins_hdmi_ddc: hdmi_ddc {
+		function = "hdmi-ddc";
+		groups = "hdmi-ddc";
+		bias-disable;
+	};
+
 	pins_nemc: nemc {
 		function = "nemc";
 		groups = "nemc-data", "nemc-cle-ale", "nemc-rd-we", "nemc-frd-fwe";
@@ -539,3 +569,41 @@ pins_mmc1: mmc1 {
 		bias-disable;
 	};
 };
+
+&hdmi {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_hdmi_ddc>;
+
+	hdmi-5v-supply = <&hdmi_power>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dw_hdmi_in: endpoint {
+				remote-endpoint = <&lcd_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dw_hdmi_out: endpoint {
+				remote-endpoint = <&hdmi_con>;
+			};
+		};
+	};
+};
+
+&lcdc0 {
+	status = "okay";
+
+	port {
+		lcd_out: endpoint {
+			remote-endpoint = <&dw_hdmi_in>;
+		};
+	};
+};
-- 
2.33.0

