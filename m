Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF44A53E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiBAALO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiBAALK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:11:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BEC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:10 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h14so13986561plf.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2qTb00lKiTZbvmTcgDQQgeFKRB9BF1Drl7IvQqo+cg=;
        b=Qqzjx7djR6Dqxaw9s/JBaAqWtti0yVDIuEf/ZUdPXYgkh3JQeIDA3HLbXa9APQZKAJ
         tke3KDV80cr6Q5yKcL9zTjMgR0nsmxyB9EkicRd7TNYHYwny/iKkJu3LBzMW3BNxlfZx
         tQtkfAFe9JZkdrh17IY2iTeI7Tkv2OSCieSTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2qTb00lKiTZbvmTcgDQQgeFKRB9BF1Drl7IvQqo+cg=;
        b=jZudsMR8AricjNWFkOLw7+BdPOrwh6/s323800RKkhsxmefMyxrCK7+YMy2Ue9jK8a
         Q905pKtOnHisn1gnukyBsMY2totyiDiUn87BazM5NJ3gPfunYglhzhBwCZexx0oUudTA
         SsQxXuC1Tu0w1ODv8fgrOSMnCPML6huhNYovLhmS/Y16nJtW1L+uJLoropuUIAa9jdgb
         UkdTplnaoDNu7VUEM7ITHbnIaXTmCtMZgXhbo+9qdX7vqKFFCMRUYOFgaQzVp0RhBlRW
         zvXAEXx9EqkYNFgohduOW6QX+ivhd+R1QHOmM6ttGXiypMj1t/HvFMG5/FEVlsIj8zTE
         aeyg==
X-Gm-Message-State: AOAM532t/x3Vbx4cGOrp0CxmqQrL/1zAzzSoY2z6rR1CAJuv3zatH/J8
        dQhO2Y6YYN+kGJThhQEgFNmOTg==
X-Google-Smtp-Source: ABdhPJwTs5SF6eAYyOLVKzV1c3bJYrEzS3dohfA2UPTY/3jBypPjbUBNaNbEkmWvbmgtF8SmDJUryg==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr14196308pll.107.1643674270003;
        Mon, 31 Jan 2022 16:11:10 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c47e:986d:769b:ead2])
        by smtp.gmail.com with ESMTPSA id oj5sm424024pjb.53.2022.01.31.16.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:11:09 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2 pinctrl
Date:   Mon, 31 Jan 2022 16:10:41 -0800
Message-Id: <20220131161034.4.I79baad7f52351aafb470f8b21a9fa79d7031ad6a@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220201001042.3724523-1-dianders@chromium.org>
References: <20220201001042.3724523-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a few improvements to the way that sdc1 / sdc2
pinctrl is specified on sc7280:

1. There's no reason to "group" the sdc pins into one overarching node
and there's a downside: we have to replicate the hierarchy in the
board device tree files. Let's clean this up.

2. There's really not a lot of reason not to list the "pinctrl" for
sdc1 (eMMC) in the SoC dtsi file. These aren't GPIO pins and
everyone's going to specify the same pins.

3. Even though it's likely that boards will need to override pinctrl
for sdc2 (SD card) to add the card detect GPIO, we can be symmetric
and add it to the SoC dsti file.

4. Let's get rid of the word "on" from the normal config and add a
"sleep" suffix to the sleep config. This looks cleaner to me.

This is intended to be a no-op change but it could plausibly change
behavior depending on how the pinctrl code parses things. One thing to
note is that "SD card detect" is explicitly listed now as keeping its
pull enabled in sleep since we still want to detect card insertions
even if the controller is suspended (because no card is inserted). The
pinctrl framework likely did this anyway, but it's nice to see it
explicit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../qcom/sc7280-herobrine-herobrine-r0.dts    |  73 +++++------
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  91 +++++++-------
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 119 +++++++++---------
 3 files changed, 135 insertions(+), 148 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index f159b5a6d7ef..918352c097bc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -676,9 +676,6 @@ &qupv3_id_1 {
 &sdhc_1 {
 	status = "okay";
 
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_on>;
-	pinctrl-1 = <&sdc1_off>;
 	vmmc-supply = <&pp2950_l7b>;
 	vqmmc-supply = <&pp1800_l19b>;
 };
@@ -686,9 +683,8 @@ &sdhc_1 {
 &sdhc_2 {
 	status = "okay";
 
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_on>;
-	pinctrl-1 = <&sdc2_off>;
+	pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>, <&sd_cd>;
+	pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>, <&sd_cd>;
 	vmmc-supply = <&pp2950_l9c>;
 	vqmmc-supply = <&ppvar_l6c>;
 
@@ -883,47 +879,38 @@ &qup_uart7_rx {
 	bias-pull-up;
 };
 
-&sdc1_on {
-	clk {
-		bias-disable;
-		drive-strength = <16>;
-	};
-
-	cmd {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
+&sdc1_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
 
-	data {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
+&sdc1_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
 
-	rclk {
-		bias-pull-down;
-	};
+&sdc1_data {
+	bias-pull-up;
+	drive-strength = <10>;
 };
 
-&sdc2_on {
-	clk {
-		bias-disable;
-		drive-strength = <16>;
-	};
+&sdc1_rclk {
+	bias-pull-down;
+};
 
-	cmd {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
+&sdc2_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
 
-	data {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
+&sdc2_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
 
-	sd-cd {
-		pins = "gpio91";
-		bias-pull-up;
-	};
+&sdc2_data {
+	bias-pull-up;
+	drive-strength = <10>;
 };
 
 /* PINCTRL - board-specific pinctrl */
@@ -1311,6 +1298,12 @@ qup_uart7_sleep_tx: qup-uart7-sleep-tx {
 		bias-pull-up;
 	};
 
+	sd_cd: sd-cd {
+		pins = "gpio91";
+		function = "gpio";
+		bias-pull-up;
+	};
+
 	tp_int_odl: tp-int-odl {
 		pins = "gpio102";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 78da9ac983db..7a987bc9b758 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -278,10 +278,6 @@ &qupv3_id_1 {
 &sdhc_1 {
 	status = "okay";
 
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_on>;
-	pinctrl-1 = <&sdc1_off>;
-
 	non-removable;
 	no-sd;
 	no-sdio;
@@ -293,9 +289,8 @@ &sdhc_1 {
 &sdhc_2 {
 	status = "okay";
 
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_on>;
-	pinctrl-1 = <&sdc2_off>;
+	pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>, <&sd_cd>;
+	pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>, <&sd_cd>;
 
 	vmmc-supply = <&vreg_l9c_2p9>;
 	vqmmc-supply = <&vreg_l6c_2p9>;
@@ -424,6 +419,40 @@ &qup_uart7_rx {
 	bias-pull-up;
 };
 
+&sdc1_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
+
+&sdc1_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc1_data {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc1_rclk {
+	bias-pull-down;
+};
+
+&sdc2_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
+
+&sdc2_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc2_data {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
 &tlmm {
 	bt_en: bt-en {
 		pins = "gpio85";
@@ -496,53 +525,17 @@ qup_uart7_sleep_rx: qup-uart7-sleep-rx {
 		bias-pull-up;
 	};
 
-	sw_ctrl: sw-ctrl {
-		pins = "gpio86";
+	sd_cd: sd-cd {
+		pins = "gpio91";
 		function = "gpio";
-		input-enable;
-		bias-pull-down;
-	};
-};
-
-&sdc1_on {
-	clk {
-		bias-disable;
-		drive-strength = <16>;
-	};
-
-	cmd {
 		bias-pull-up;
-		drive-strength = <10>;
 	};
 
-	data {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
-
-	rclk {
+	sw_ctrl: sw-ctrl {
+		pins = "gpio86";
+		function = "gpio";
+		input-enable;
 		bias-pull-down;
 	};
 };
 
-&sdc2_on {
-	clk {
-		bias-disable;
-		drive-strength = <16>;
-	};
-
-	cmd {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
-
-	data {
-		bias-pull-up;
-		drive-strength = <10>;
-	};
-
-	sd-cd {
-		pins = "gpio91";
-		bias-pull-up;
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 40cb414bc377..dc98a87e2871 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -616,6 +616,9 @@ qfprom: efuse@784000 {
 
 		sdhc_1: sdhci@7c4000 {
 			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc1_clk>, <&sdc1_cmd>, <&sdc1_data>, <&sdc1_rclk>;
+			pinctrl-1 = <&sdc1_clk_sleep>, <&sdc1_cmd_sleep>, <&sdc1_data_sleep>, <&sdc1_rclk_sleep>;
 			status = "disabled";
 
 			reg = <0 0x007c4000 0 0x1000>,
@@ -2425,6 +2428,9 @@ apss_merge_funnel_in: endpoint {
 
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>;
+			pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>;
 			status = "disabled";
 
 			reg = <0 0x08804000 0 0x1000>;
@@ -3943,81 +3949,76 @@ qup_uart15_rx: qup-uart15-rx {
 				function = "qup17";
 			};
 
-			sdc1_on: sdc1-on {
-				clk {
-					pins = "sdc1_clk";
-				};
 
-				cmd {
-					pins = "sdc1_cmd";
-				};
 
-				data {
-					pins = "sdc1_data";
-				};
+			sdc1_clk: sdc1-clk {
+				pins = "sdc1_clk";
+			};
 
-				rclk {
-					pins = "sdc1_rclk";
-				};
+			sdc1_cmd: sdc1-cmd {
+				pins = "sdc1_cmd";
 			};
 
-			sdc1_off: sdc1-off {
-				clk {
-					pins = "sdc1_clk";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc1_data: sdc1-data {
+				pins = "sdc1_data";
+			};
 
-				cmd {
-					pins = "sdc1_cmd";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc1_rclk: sdc1-rclk {
+				pins = "sdc1_rclk";
+			};
 
-				data {
-					pins = "sdc1_data";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc1_clk_sleep: sdc1-clk-sleep {
+				pins = "sdc1_clk";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				rclk {
-					pins = "sdc1_rclk";
-					bias-bus-hold;
-				};
+			sdc1_cmd_sleep: sdc1-cmd-sleep {
+				pins = "sdc1_cmd";
+				drive-strength = <2>;
+				bias-bus-hold;
 			};
 
-			sdc2_on: sdc2-on {
-				clk {
-					pins = "sdc2_clk";
-				};
+			sdc1_data_sleep: sdc1-data-sleep {
+				pins = "sdc1_data";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				cmd {
-					pins = "sdc2_cmd";
-				};
+			sdc1_rclk_sleep: sdc1-rclk-sleep {
+				pins = "sdc1_rclk";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				data {
-					pins = "sdc2_data";
-				};
+			sdc2_clk: sdc2-clk {
+				pins = "sdc2_clk";
 			};
 
-			sdc2_off: sdc2-off {
-				clk {
-					pins = "sdc2_clk";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc2_cmd: sdc2-cmd {
+				pins = "sdc2_cmd";
+			};
 
-				cmd {
-					pins ="sdc2_cmd";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc2_data: sdc2-data {
+				pins = "sdc2_data";
+			};
 
-				data {
-					pins ="sdc2_data";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc2_clk_sleep: sdc2-clk-sleep {
+				pins = "sdc2_clk";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
+
+			sdc2_cmd_sleep: sdc2-cmd-sleep {
+				pins = "sdc2_cmd";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
+
+			sdc2_data_sleep: sdc2-data-sleep {
+				pins = "sdc2_data";
+				drive-strength = <2>;
+				bias-bus-hold;
 			};
 		};
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

