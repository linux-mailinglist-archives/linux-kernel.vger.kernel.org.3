Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB324569730
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiGGBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiGGBKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236702E683;
        Wed,  6 Jul 2022 18:10:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o25so29862250ejm.3;
        Wed, 06 Jul 2022 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d740HDHVkVSMWNQkMas7UaJOTPQjPYncz2ZhstpS/S4=;
        b=qoRsjSMaBvY3qb2Uq0ydXg39J/+17zCQTU/2MELLEbWnPvku2pVOrSbupQJOi88xAV
         nzx1Uqv5p6URNan9VCwts7O/FfVrmqnyMbZIIBzRTALQ7jDJ2siAc+NKAp5nqFmBH6u6
         ZnU9QSdEKrpE9Q+wXiC5wUN/JigmXlEGbLYKm3nPi6xwGKgkdC/IGl0QBJ93y3Zrj7A/
         0yLfqjJ4bzNBfAwHdPgsFLj+g0dJMwsgjHN/zC6aN4imkmrzNPAChOOc1wasByHSvusM
         bnANBeyKGbB/jn7e93r1ZTjK7jEehj5FwcINgxKsg8jE3fzjCvCUqsGRIoo1lMA4+M86
         di4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d740HDHVkVSMWNQkMas7UaJOTPQjPYncz2ZhstpS/S4=;
        b=b9wbza9HUlF96t7OycmNstn40xI1JWOSF9oP+g7EG4R/aMxrjXtmlSq4Z41wgNkzZ8
         6pxtM0i/WRTMD1Z9T30UFL5vQWV2wjAXLjW+//f+GrOK2EZ7iVFXBYDhTycfGJJGLuAA
         3C40TYOLdxTiiEGlcCVt0zjBsiE8Xypjj8qkWtDhpKlVzl4ID1RIgZpM+TPJBajSQds+
         SOUL/PqfKcclI2fnjTyAU7KEC+QPrnJDwBnWVc0HfSt5i4/ffCTwcCqSu4gilhZ9ptcq
         ztxtgouEzWLmm+N4fzZB8Om8MYTy8Cm38xtkca7rGQNcWLwASi1hmGeEwj3+KQ+YvXV5
         kfZg==
X-Gm-Message-State: AJIora91le5xvb3lZIHxXCGo2GhKNneWWnM+y7XfFQ3Ybq1JmxmbGGXM
        0m+40QZiZubXvNH+0HOD3X6h49k2DnU=
X-Google-Smtp-Source: AGRyM1tfPONvctUYTbbD5sdNIH1yBLRzrg4/KKPhyYGAKrFbHSCfNSbi9lqF8908E4c+XLH0cagUxg==
X-Received: by 2002:a17:907:2856:b0:72a:f13e:6c6c with SMTP id el22-20020a170907285600b0072af13e6c6cmr8393808ejc.642.1657156211629;
        Wed, 06 Jul 2022 18:10:11 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:11 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v2 7/8] ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
Date:   Thu,  7 Jul 2022 03:09:41 +0200
Message-Id: <20220707010943.20857-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
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

Add some tag for gsbi to make them usable for ipq8064 SoC. Add missing
gsbi7 i2c node and gsbi1 node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 54 ++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 8d2f7c8bf6ac..69cf664851c6 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -539,6 +539,44 @@ saw1: regulator@2099000 {
 			regulator;
 		};
 
+		gsbi1: gsbi@12440000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x12440000 0x100>;
+			cell-index = <1>;
+			clocks = <&gcc GSBI1_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			status = "disabled";
+
+			gsbi1_serial: serial@12450000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x12450000 0x100>,
+				      <0x12400000 0x03>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+
+				status = "disabled";
+			};
+
+			gsbi1_i2c: i2c@12460000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x12460000 0x1000>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
@@ -562,7 +600,7 @@ gsbi2_serial: serial@12490000 {
 				status = "disabled";
 			};
 
-			i2c@124a0000 {
+			gsbi2_i2c: i2c@124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
 				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,6 +765,20 @@ gsbi7_serial: serial@16640000 {
 				clock-names = "core", "iface";
 				status = "disabled";
 			};
+
+			gsbi7_i2c: i2c@16680000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16680000 0x1000>;
+				interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI7_QUP_CLK>, <&gcc GSBI7_H_CLK>;
+				clock-names = "core", "iface";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
 		};
 
 		rng@1a500000 {
-- 
2.36.1

