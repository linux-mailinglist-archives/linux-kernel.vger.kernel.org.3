Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E50524B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353021AbiELLIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352979AbiELLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:08:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30145D199;
        Thu, 12 May 2022 04:08:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d15so8413609lfk.5;
        Thu, 12 May 2022 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjFTO1D1EZDKKiJccbHJv6i5BuHy5bt8K51ddMuen78=;
        b=h9FmGSg4bI11T8kP5bLEDH1qqYkFrt3qTZmcdAjTGFQYt9wQXbDKgOqXfC+JYpujXu
         FvdC96vgRZ1QQoyFPFGTqC5H7q5SEqo/pxrG35EEu7sw1THgssiDtIfZddVWlppwATMF
         DQEcV7Ttr4YPAcbRZ5hP+XQc3FGqFBe6NMMZIDdYjkxfj/p7nriaquFmDWv2jZtJpE4o
         GLokkOOzk241QdGAVo2xcwKTQmkWPpLL7IzNrzLdWUMJPyE3HkIsduyM9x2hUfak6k2t
         GFpyRdam+7vpsdR41RAjGuTgycZ+SJJBSwxeO+luDitt0YnUk+GGn4sZhPnX5FdWHt/B
         wORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjFTO1D1EZDKKiJccbHJv6i5BuHy5bt8K51ddMuen78=;
        b=EN01Dir/xyhAvpyvCYtXjza1Pz+sX6AWShnVNPryberhQCEgo7eBC6j0SBNa8cwIWF
         UTewxjsPGJ9gJBiLPbRuRp+oVxmM2qcR35F/aA3qsLnYliMZ2OYILfQ+FkIQxuouu54E
         eaPqsKX/9QLRgqzWl5akU2lMOiYhZkzwAW3cmIKfbkxlGW8mb7oG67KPEBStuBUaR/Cx
         j+3+w1Jmk8XV0ZUWAzml6Yi8pQZYoaW7eqCQpyDK3W1cnn8Ke0yU9O0bsvGfZ8a5osoO
         9edDiIFOnsTZud/leJ1GcKG+eLZYatqyQwH4DyhNE+kZ4kGZujed/KynkgiZD5tKqJqS
         3jvg==
X-Gm-Message-State: AOAM531TVkfVbnQ5wyR9xtghk9ueN/4Nc2XoVY5CNr4IWEaZhpSQrYNJ
        r9+PBcXtdxuTpicolpiC9j72QbgewD0dUg==
X-Google-Smtp-Source: ABdhPJzV29F8YQmt876AcPMunxt7RvQwAWEqhPI/M867EYQL1xSd6Z1fcha4gXmGoRf9vbMonoSd1Q==
X-Received: by 2002:a05:6512:3a84:b0:473:de2d:ae1 with SMTP id q4-20020a0565123a8400b00473de2d0ae1mr23442455lfu.371.1652353700039;
        Thu, 12 May 2022 04:08:20 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i25-20020a056512007900b004725b99d2fdsm734883lfo.164.2022.05.12.04.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:08:19 -0700 (PDT)
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
Subject: [PATCH v3 5/5] arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support
Date:   Thu, 12 May 2022 14:07:57 +0300
Message-Id: <20220512110757.5297-6-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512110757.5297-1-markuss.broks@gmail.com>
References: <20220512110757.5297-1-markuss.broks@gmail.com>
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
index 47488a1aecae..a95fa29aa18b 100644
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
@@ -621,6 +639,21 @@ hall_sensor0_default: acc-cover-open {
 		input-enable;
 	};
 
+	tof_int: tof-int {
+		pins = "gpio22";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
+		input-enable;
+	};
+
+	tof_reset: tof-reset {
+		pins = "gpio27";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
 	ts_int_n: ts-int-n {
 		pins = "gpio125";
 		function = "gpio";
-- 
2.36.1

