Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC66E531653
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiEWSTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbiEWSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:18:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA277C17B;
        Mon, 23 May 2022 10:57:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq30so26931368lfb.3;
        Mon, 23 May 2022 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqvqGq9Z82oEF1qEGh1yx9lmGGvEQADLPFEeVY8PIpY=;
        b=OfpL62r+lR4reKq+3IWV6ZpreWQvE98HQM6jhsupy231GXYHnq01aEL4+94dpHJsFb
         +RgspUBmrdlL2XMV1KFsF2DM4GtNn9XkJ0bcW/nIoeIFlcQJFFjKSaVxYEzuXPJoZapi
         xjsWVOyZvHfEBSM4QOyLAho4/5voWpoS9PiLa/wdeGshTFfvh0KZ5CgUf+ZnlFGhiAxg
         mwuERP9hHevNnDYJuD3dOrk3T7q96jQreWCEeB4c7+R9/8p/ZjtDYi3Hhh2A/H68Eylg
         eZhd0bJSgnmF9DRHGrwWq0YxFoSudwBk7cK0lHJ+2brGgrRmvC5uKeiludU8SHJ157jF
         ylUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqvqGq9Z82oEF1qEGh1yx9lmGGvEQADLPFEeVY8PIpY=;
        b=3mFfL2B7OvRY8x6V6DR//RaWY3UO0DrFRROny6ng2suJ46wLDlbz9CrZ3ndP5CIcGU
         2YnPt32dQfNYhD420kxjTveI1wf/9wIaah0c0G8qM7c4h8M0YULcK1srztRSCv3hERyf
         stLp4qP0+oBcJEA2FwaGJFJMGgYXrFvgGP1Fe+53mZZ7HnR1ubgWeaThgHyHyMkuXprm
         gvp7BcC1nYN1SbbBa1RHlpvKuhSy7+rL9imFFRQEf/37AzDCtLTJ8B192LgAL5Z86/eH
         kjn1p+JsdE3fPUS2F1sYMedvk/drDMHuNvHpZt3etDnCs+FqTkmBob5EKs40aoZH7A3o
         T+nw==
X-Gm-Message-State: AOAM533QRodl0tY/YvtW/UNk4uZGX46rBlwUFVp2TJ7HxLUqYZrhYT/L
        NCxJ9jF2y9lyhGX38fCHLl9fhwuDWCC/sA==
X-Google-Smtp-Source: ABdhPJykIEV0IXS2xb9A19pkdl57PGsHRwTslqs6wtZoJzmKqGNsvsDGXfUCEgD+SPxaDgpLHBBpAg==
X-Received: by 2002:ac2:58d6:0:b0:477:de87:819e with SMTP id u22-20020ac258d6000000b00477de87819emr13413351lfo.356.1653328479993;
        Mon, 23 May 2022 10:54:39 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b0047255d211f9sm2087743lfr.296.2022.05.23.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:54:39 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org, jic23@kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support
Date:   Mon, 23 May 2022 20:53:44 +0300
Message-Id: <20220523175344.5845-6-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523175344.5845-1-markuss.broks@gmail.com>
References: <20220523175344.5845-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree support for the VL53L0X ToF sensor
found on all Yoshino devices.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 47488a1aecae..4bd1039d983d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -245,6 +245,24 @@ &blsp2_uart1 {
 	status = "okay";
 };
 
+&blsp2_i2c2 {
+	status = "okay";
+
+	proximity@29 {
+		compatible = "st,vl53l0x";
+		reg = <0x29>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+
+		reset-gpios = <&tlmm 27 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&cam_vio_vreg>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tof_int &tof_reset>;
+	};
+};
+
 &ibb {
 	regulator-min-microamp = <800000>;
 	regulator-max-microamp = <800000>;
@@ -606,6 +624,14 @@ cam0_vdig_default: cam0-vdig-default {
 		drive-strength = <2>;
 	};
 
+	tof_int: tof-int {
+		pins = "gpio22";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
+		input-enable;
+	};
+
 	cam1_vdig_default: cam1-vdig-default {
 		pins = "gpio25";
 		function = "gpio";
@@ -613,6 +639,13 @@ cam1_vdig_default: cam1-vdig-default {
 		drive-strength = <2>;
 	};
 
+	tof_reset: tof-reset {
+		pins = "gpio27";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
 	hall_sensor0_default: acc-cover-open {
 		pins = "gpio124";
 		function = "gpio";
-- 
2.36.1

