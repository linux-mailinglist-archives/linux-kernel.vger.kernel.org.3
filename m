Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B66525584
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357953AbiELTOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiELTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:14:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4C277351;
        Thu, 12 May 2022 12:13:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m23so7751058ljc.0;
        Thu, 12 May 2022 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqvqGq9Z82oEF1qEGh1yx9lmGGvEQADLPFEeVY8PIpY=;
        b=Oj3EvGQ34k0DXRehSN9t1u1RTrvzp3dcB9qCIlXz1cW2niVqP5a63GgQF5/aNeqM5V
         xoT6L/8vaOo4Lz3a1SsVe2anShZJQv9Z0SjEicTWN4EcRF2TLNpHGMEk7+2BP+gItAUo
         Ub4tYlAWxCxhk0RHcpw1PJO15S4gAWkxDb080GUWzMoXIph/+ZoOCfJpTu7hRrF9TKvz
         Zrn6dhFtELmFnOmpZ7mRwXCmrQQdg1TbCBuARRaqzjWXLxh91yeSuGp+D6TNOwXXtKuy
         PeJaqC21aiOJN+Nw9W8MBuzjnkRSZZpqarH4MEvHfQPqBAdTMQysjPCeJptDMGvlW+d9
         27ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqvqGq9Z82oEF1qEGh1yx9lmGGvEQADLPFEeVY8PIpY=;
        b=FGUlQaGuw7E8khxKMLW+0ZgAMYseptgyZK31bMkKngrZ5/j0jgL6WMx5yBvu0CZvmT
         2vinrPifKMdfAJPc0bDpPgqhO8xvCHacB7zs1fo2yvMgrjNc6DNZ0M0arEu0a3Dczf1B
         JdtUBo7N/zpRs4n/pey8PXGcI9FNY1pmmvF6h8L4MiZBgTYgF6tW8AOakt4h4vUQDHnz
         qYNzpnytdJt5udNVOcCPq2tMMSDwFmb/xDq3G65ba6iecgOlvgddbHH96WORDw975gy6
         ZWOsKpPHP/iwh771+jI288u8xttwARzhYOlZ/pUgQ68+OBN0XkYE4TnzUMyn9kw7NQTH
         4FjA==
X-Gm-Message-State: AOAM531prM26cwo/LFsKLnKm+a6zwSqyNwCQjFDYTzkR4NKNAjP2rLz1
        ADVBxFvS1rT5f9GvuhwJxZLOUTbu+HPvOQ==
X-Google-Smtp-Source: ABdhPJzbF9eSPF1hlns9LPLPwVQf7Gmlrayz0fVOYafs+7dUkKjowsD5O/7A4Gi3HIEVF0B5CkiAFQ==
X-Received: by 2002:a2e:9188:0:b0:24f:1a0d:6bbd with SMTP id f8-20020a2e9188000000b0024f1a0d6bbdmr878261ljg.226.1652382836208;
        Thu, 12 May 2022 12:13:56 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b0047255d210f4sm62146lfg.35.2022.05.12.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:13:55 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 5/5] arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support
Date:   Thu, 12 May 2022 22:13:33 +0300
Message-Id: <20220512191334.61804-6-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512191334.61804-1-markuss.broks@gmail.com>
References: <20220512191334.61804-1-markuss.broks@gmail.com>
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

