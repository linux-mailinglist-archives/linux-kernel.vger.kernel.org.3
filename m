Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F014DBBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352373AbiCQA3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351474AbiCQA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:29:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9301C93F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:28:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 132so1405181pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACtZLOUsEKL3RZmcnEkTB+sHZpJYYlU30MhaK0PAGw0=;
        b=P9pO/F33FUDOqGxMjS34mKrRhzcGWETsme09k+0RobF1mfoPgq5TAkICcVZels4aLC
         5Av4+UZAHAlBE+G8IL61Iv5DthHwXx5b9D/rfLXhYOLkfFZsLG1EAB3shf2IFBRBDktd
         KPvkqRk2YRyiZuv0ipRkSnMXNOzRSmWk8bX5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACtZLOUsEKL3RZmcnEkTB+sHZpJYYlU30MhaK0PAGw0=;
        b=2ik8ShDJ+ckVY2fOL+9hcJs45fjw9CageOXPYV8EPFQDJ/O5p1La0Axe4rmL+nsva6
         ly/rqKOJDS+b61QdQ3gqSLMUZtWjd5y2+Ik4qCVb5/BlvpntO/3XTy8UpzSImDijfO12
         J48IQVZYBIZGy9oxbZw2m/qYzrUtP/D2Tpi3LgkFSVWISWmSPiw9rypW+m2c5GqbmFRN
         /VRmgDpv+APYc6XfzTe7nJeBwzP6cjApOmup08EjB76X4QT5zXt3cHE06k0c5seXYkuf
         +4+GIyEh+3UvjOIboIl6xBNbdrooYT9JEaJXjLZx4T/ZWzD6V4SmqPXZOkdynTMY2F7N
         91LQ==
X-Gm-Message-State: AOAM533VAD6GGOT3tnn5Ux/eO3o6AYJxH4jWnF3u1+igwUn+DxtwqQqX
        9o56mEWDJCUKr0DbabizMEh3BQ==
X-Google-Smtp-Source: ABdhPJwCPte94KNgJ+auSrzd8vBjXMVP+z2KrTWz+4FAbpEukJ6wXFwWyGNfvKo8XQ5xgt6kWNe+Mw==
X-Received: by 2002:aa7:8211:0:b0:4f7:8b7:239b with SMTP id k17-20020aa78211000000b004f708b7239bmr1827222pfi.64.1647476910416;
        Wed, 16 Mar 2022 17:28:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3314:2f99:65d0:5a73])
        by smtp.gmail.com with UTF8SMTPSA id pi10-20020a17090b1e4a00b001bf9749b95bsm8073837pjb.50.2022.03.16.17.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 17:28:30 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v1 3/4] arm64: dts: qcom: sc7280: herobrine: disable some regulators by default
Date:   Wed, 16 Mar 2022 17:28:19 -0700
Message-Id: <20220316172814.v1.3.Iad21bd53f3ac14956b8dbbf3825fc7ab29abdf97@changeid>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all herobrine boards have a world facing camera or a fingerprint
sensor, disable the regulators that feed these devices by default and
only enable them for the boards that use them.

Similarly the audio configuration can vary between boards, not all
boards have the regulator pp3300_codec, disable it by default.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 .../qcom/sc7280-herobrine-herobrine-r1.dts    | 30 +++++++++++++++++++
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  6 ++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index f95273052da0..29c4ca095294 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -14,6 +14,36 @@ / {
 	compatible = "google,herobrine", "qcom,sc7280";
 };
 
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_codec {
+	status = "okay";
+};
+
+&pp3300_fp_mcu {
+	status = "okay";
+};
+
+&pp2850_vcm_wf_cam {
+	status = "okay";
+};
+
+&pp2850_wf_cam {
+	status = "okay";
+};
+
+&pp1800_wf_cam {
+	status = "okay";
+};
+
+&pp1200_wf_cam {
+	status = "okay";
+};
+
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
 &ap_spi_fp {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index dc17f2079695..40cca69b1414 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -92,6 +92,7 @@ pp3300_codec: pp3300-codec-regulator {
 		pinctrl-0 = <&en_pp3300_codec>;
 
 		vin-supply = <&pp3300_z1>;
+		status = "disabled";
 	};
 
 	pp3300_left_in_mlb: pp3300-left-in-mlb-regulator {
@@ -132,6 +133,7 @@ pp3300_fp_mcu: pp3300-fp-regulator {
 		pinctrl-0 = <&en_fp_rails>;
 
 		vin-supply = <&pp3300_z1>;
+		status = "disabled";
 	};
 
 	pp3300_hub: pp3300-hub-regulator {
@@ -194,6 +196,7 @@ pp2850_vcm_wf_cam: pp2850-vcm-wf-cam-regulator {
 		pinctrl-0 = <&wf_cam_en>;
 
 		vin-supply = <&pp3300_z1>;
+		status = "disabled";
 	};
 
 	pp2850_wf_cam: pp2850-wf-cam-regulator {
@@ -214,6 +217,7 @@ pp2850_wf_cam: pp2850-wf-cam-regulator {
 		 */
 
 		vin-supply = <&pp3300_z1>;
+		status = "disabled";
 	};
 
 	pp1800_fp: pp1800-fp-regulator {
@@ -258,6 +262,7 @@ pp1800_wf_cam: pp1800-wf-cam-regulator {
 		 */
 
 		vin-supply = <&vreg_l19b_s0>;
+		status = "disabled";
 	};
 
 	pp1200_wf_cam: pp1200-wf-cam-regulator {
@@ -278,6 +283,7 @@ pp1200_wf_cam: pp1200-wf-cam-regulator {
 		 */
 
 		vin-supply = <&pp3300_z1>;
+		status = "disabled";
 	};
 
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
-- 
2.35.1.723.g4982287a31-goog

