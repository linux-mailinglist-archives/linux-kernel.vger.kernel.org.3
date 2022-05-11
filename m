Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B801523FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348454AbiEKVse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348382AbiEKVsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:48:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD6515B0;
        Wed, 11 May 2022 14:48:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d15so5854697lfk.5;
        Wed, 11 May 2022 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjFTO1D1EZDKKiJccbHJv6i5BuHy5bt8K51ddMuen78=;
        b=gXg11SMVbS7MdGdULt0/Q2dwr+lb6VgC7aQA1IJ7Lz0N+iATdF4knANd0/t3M28n5m
         27Rk+OdfyoNSV56ollhWuGjeOcp86A0fl8L0MUVaILWc9NSyrFA38ssX11IURCZmbHFK
         gSYxLBNLZoDj7L3UKIB2NSCCytNtSVkU1wcGKFnbrSs/H+2x/QjdGAsSijB/4TRQQCfR
         DzsYUSa1hLUgh6q8HxRHyDhNa8WQKW8kS26s7BCf8tEB09kBxnumEZtN9S7mJMudlVXJ
         kOE/KmcVR14QrlgDbPAjfX1ow3cK67Q1Rn32FUg5EFywEmIHU9Pit656mZ+aTxVkcPX0
         8rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjFTO1D1EZDKKiJccbHJv6i5BuHy5bt8K51ddMuen78=;
        b=5jPBqL/LyiRojauO/1raxB3kxc6gR7dLpKXCMQFr5+sYF2xGJVYYwWdRqxOjfMIZsG
         5T/QuojPEoOp/QrFivxiTIKb6SBN352cB6dGr32HyaUj1TLHMUikIKepfipNCn2Pb3OH
         rrie40YDB8OkiG2QwoGT47ZEhPXCtJgfhW7G0ndbfN6im6oENuN0h/JNqUo29sAjAidR
         0PAUu5KXyelJ+6xMyoLlWZkF3+3D+l/SdBoTLWYVSpVrpViXUDIS4bEjCPdWgUohf33m
         DNVM2Xk5WhJsI4dRjzhu/KIVp/asw4uwLfjWnApbe4cPqJ9fll/h+Oza/wwcu1QFQpzg
         dBnQ==
X-Gm-Message-State: AOAM531PJA+5ls2dRzbEc72M2GT7EQYxR1yUFNnha+vAshDyK/6EkBhC
        ASsmRkg4R57I/bYiVgI9i+ZyToM/bFRrIQ==
X-Google-Smtp-Source: ABdhPJyYNFiN9PteQqRh87oyzawDjvUiMWjw4JDEft2h/aD+ItAVOoshpTcGYPYGo7KqG2JM6BlLZQ==
X-Received: by 2002:a05:6512:12c3:b0:473:c7e2:b46b with SMTP id p3-20020a05651212c300b00473c7e2b46bmr21650100lfg.382.1652305688674;
        Wed, 11 May 2022 14:48:08 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b0047255d211afsm458891lfr.222.2022.05.11.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:48:08 -0700 (PDT)
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
Subject: [PATCH v2 5/5] arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support
Date:   Thu, 12 May 2022 00:47:17 +0300
Message-Id: <20220511214718.50879-6-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511214718.50879-1-markuss.broks@gmail.com>
References: <20220511214718.50879-1-markuss.broks@gmail.com>
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

