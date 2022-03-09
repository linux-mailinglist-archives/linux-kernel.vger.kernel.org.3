Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B844D39DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiCITRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiCITQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEED1111BB;
        Wed,  9 Mar 2022 11:15:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j17so4668093wrc.0;
        Wed, 09 Mar 2022 11:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N5yPmgu81Kg5Ttu8qB0Pb8ftCxNINmRYqyFzobmW46I=;
        b=ce5aWxrnIfeMZ07mhnSe3EF83hlZsJeRrsQ8RIFt4bRbYvAJTZ40xjDSWfMjh91IpX
         Z/X/8kQ0Xzw2Zccpvt4RkuAT6Xa0yZdsUsEJgZZZzEcBtJGlRmg0jE6fgyUBge/THYPY
         NSHCBtiCqnmTw5awRIqKy7+QTQGRmkAI5lj9o0U00UMBgYLnk4OlR1ZfUksD+Ccq5o1k
         PupnSENKF4Si/tVkacv4WKrPKAvHaskxwBlJKJ3+t0/AWlHxQGsqlRwzA3/a0nqbtd2E
         R17+mQD6A6V2X8vOpSoHPcE/cFTu5R2TkgKHmXHHFcG/gWRtfeTzxD6wUANZmZWqlHcI
         281w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N5yPmgu81Kg5Ttu8qB0Pb8ftCxNINmRYqyFzobmW46I=;
        b=3YGsGYP8INXD610Q1iyoJ2/zJNkRF2//NE3J4IxQs1ES2hQJKPQj0RdXWybr3McIR/
         fgFHHIDtkadCbAOAGYb5em8qewVMVlrwZsbrHGRJNjSr4Ll5MQ0fXRod3IZjYs5WxXxC
         eslaBT/QdqIhZ3vJWQye3dK1jND6OK1mrexMeUwu3ffoKmsZWryGW9Vm0EDU/qmw74XC
         eRTAhVcB6Q67ImMathjr2J8+1AZzURd/rqzlYhg8zidDXf9aoc1gTJ0EAw/xckm/cfh8
         wzWzTa2LFTbsySrhLJlwOVsNLB4/YPD4afh8XG3X7T3N/j85t3NKRtkIKs4aZ9DuMQ3L
         3EBg==
X-Gm-Message-State: AOAM530Ksi8ebkSbkOE0R1jtwnLZrEUK8RF/F5HjBH56ocBD5mnhQi82
        Nm1hdQPgLFyOUcWMABmOc1y4i/4agaY=
X-Google-Smtp-Source: ABdhPJxCFQaHZyhXut55CNnfAHOQT46M+WcJ1+UTfyJdvQfhShQTWaT8WD+FvChG+HcoPRX5tmnFUQ==
X-Received: by 2002:adf:a482:0:b0:1e3:3e5f:496c with SMTP id g2-20020adfa482000000b001e33e5f496cmr841369wrb.606.1646853331933;
        Wed, 09 Mar 2022 11:15:31 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:31 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 12/18] ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
Date:   Wed,  9 Mar 2022 20:01:46 +0100
Message-Id: <20220309190152.7998-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 50 ++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index df2702e6136d..7dd0b901cd30 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -568,6 +568,41 @@ sic_non_secure: sic-non-secure@12100000 {
 			reg = <0x12100000 0x10000>;
 		};
 
+		gsbi1: gsbi@12440000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <1>;
+			reg = <0x12440000 0x100>;
+			clocks = <&gcc GSBI1_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi1_serial: serial@12450000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x12450000 0x100>,
+				      <0x12400000 0x03>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
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
+				status = "disabled";
+			};
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
@@ -591,7 +626,7 @@ gsbi2_serial: serial@12490000 {
 				status = "disabled";
 			};
 
-			i2c@124a0000 {
+			gsbi2_i2c: i2c@124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
 				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
@@ -753,6 +788,19 @@ gsbi7_serial: serial@16640000 {
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
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		rng@1a500000 {
-- 
2.34.1

