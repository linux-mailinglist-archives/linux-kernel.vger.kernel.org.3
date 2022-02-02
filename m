Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B74A7A47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347554AbiBBVYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbiBBVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E8C061759
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:16 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so333730plh.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RR+ThUFVWTf4G7m8j1PiXLKZYfrCRssRc6rFuRuA7Cg=;
        b=Lazeas4oXeIhjdgnNWgPcPxpLUvqGW/Cu9Pf1LZ82E/5h+MMrzFo3+mYJSVvSf5obf
         2Rl9mjJ6pVLeTzfH9xLXc1X/NWNT8kB5HLaRV7kCpyOVRto2iLbGl6X67nPeJnQDTDGL
         sqRr634lr1WNhCj/jf4Z8f1hxe2YykPt0vLy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RR+ThUFVWTf4G7m8j1PiXLKZYfrCRssRc6rFuRuA7Cg=;
        b=bh/xIH1PacbAtg451NaxoxSuH+4amL2lzlQb2XY9/JZFvxNsExbIATJHSrHgr2Aa4S
         3+ZukLukZUXnFrqbzT/C/p01D28dv2TUF+NFXd8+oVB1W60moT6eeHSYlhm26MLkuoCG
         J0PXCF+HvYUT6oCnAkCQKsGvBTjY5xMBfArCUomLU5h5apuPvifcHnSwfeDrYb/1QLHl
         mMvzLsnNctsRDqgtKls/nNfywz2HAwuzDKWOoFh9xUR1vaNiJq4eZTIuWBJ6KzQS7/+q
         L7ut6XF+ufjN54He6tcUzCHz7wLRSF5gIk+WWZJmVq2ZWDm5wS9pPlGnyX6XuM2oR9qP
         H27g==
X-Gm-Message-State: AOAM5325jY41R8lInxUY/Pt4niH+sFsYiiYsyGlxU7Tmfe8zwHKR0/gH
        X28Z4iZjZ2ixAKDKyhwiC/GyTQ==
X-Google-Smtp-Source: ABdhPJzpyOZ0frHuXehgPmWm1noxfZg4/0G0SpYwD6kaD5rTrw9wQvLbC4KGmzkG1e9mPkgH9QzcBA==
X-Received: by 2002:a17:90b:390a:: with SMTP id ob10mr10382545pjb.110.1643837055792;
        Wed, 02 Feb 2022 13:24:15 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:15 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/14] arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2 pinctrl
Date:   Wed,  2 Feb 2022 13:23:38 -0800
Message-Id: <20220202132301.v3.4.I79baad7f52351aafb470f8b21a9fa79d7031ad6a@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
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

Changes in v3:
- Removed extra blank lines

 .../qcom/sc7280-herobrine-herobrine-r0.dts    |  73 +++++------
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  91 +++++++-------
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 117 +++++++++---------
 3 files changed, 133 insertions(+), 148 deletions(-)

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
index 40cb414bc377..5b1e23991a6a 100644
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
@@ -3943,81 +3949,74 @@ qup_uart15_rx: qup-uart15-rx {
 				function = "qup17";
 			};
 
-			sdc1_on: sdc1-on {
-				clk {
-					pins = "sdc1_clk";
-				};
+			sdc1_clk: sdc1-clk {
+				pins = "sdc1_clk";
+			};
 
-				cmd {
-					pins = "sdc1_cmd";
-				};
+			sdc1_cmd: sdc1-cmd {
+				pins = "sdc1_cmd";
+			};
 
-				data {
-					pins = "sdc1_data";
-				};
+			sdc1_data: sdc1-data {
+				pins = "sdc1_data";
+			};
 
-				rclk {
-					pins = "sdc1_rclk";
-				};
+			sdc1_rclk: sdc1-rclk {
+				pins = "sdc1_rclk";
 			};
 
-			sdc1_off: sdc1-off {
-				clk {
-					pins = "sdc1_clk";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc1_clk_sleep: sdc1-clk-sleep {
+				pins = "sdc1_clk";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				cmd {
-					pins = "sdc1_cmd";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc1_cmd_sleep: sdc1-cmd-sleep {
+				pins = "sdc1_cmd";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				data {
-					pins = "sdc1_data";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc1_data_sleep: sdc1-data-sleep {
+				pins = "sdc1_data";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				rclk {
-					pins = "sdc1_rclk";
-					bias-bus-hold;
-				};
+			sdc1_rclk_sleep: sdc1-rclk-sleep {
+				pins = "sdc1_rclk";
+				drive-strength = <2>;
+				bias-bus-hold;
 			};
 
-			sdc2_on: sdc2-on {
-				clk {
-					pins = "sdc2_clk";
-				};
+			sdc2_clk: sdc2-clk {
+				pins = "sdc2_clk";
+			};
 
-				cmd {
-					pins = "sdc2_cmd";
-				};
+			sdc2_cmd: sdc2-cmd {
+				pins = "sdc2_cmd";
+			};
 
-				data {
-					pins = "sdc2_data";
-				};
+			sdc2_data: sdc2-data {
+				pins = "sdc2_data";
 			};
 
-			sdc2_off: sdc2-off {
-				clk {
-					pins = "sdc2_clk";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc2_clk_sleep: sdc2-clk-sleep {
+				pins = "sdc2_clk";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				cmd {
-					pins ="sdc2_cmd";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc2_cmd_sleep: sdc2-cmd-sleep {
+				pins = "sdc2_cmd";
+				drive-strength = <2>;
+				bias-bus-hold;
+			};
 
-				data {
-					pins ="sdc2_data";
-					drive-strength = <2>;
-					bias-bus-hold;
-				};
+			sdc2_data_sleep: sdc2-data-sleep {
+				pins = "sdc2_data";
+				drive-strength = <2>;
+				bias-bus-hold;
 			};
 		};
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

