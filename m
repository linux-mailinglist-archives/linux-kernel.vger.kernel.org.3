Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58805569747
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiGGBKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGGBKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8AA2D1DC;
        Wed,  6 Jul 2022 18:10:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r21so1056198eju.0;
        Wed, 06 Jul 2022 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpXoMxo0aQKIkiKPZdmGA4JTiZjUpQr6v1L8PEccH18=;
        b=HRTWX4j7HkFX4uMlrzY2dzJzvkfSpZ2hSe14YKdvP1miavqePcCENEVt+YCOD90oqV
         d3T2A4C8gZzXvb/7OqaBitojU3D+uN3a55CPc39U2plt8SfFe+FM+BbMNc6DzyPcHRZv
         e0SOJe7TdJMOLtCM+Ia4t8GbWlh4g2hE/KkpgpaWC5DXrUUz6mzJhsSTnL0ZlOGfv6NY
         1+oa/CK1ynWthaIipP1wokCE6Imgx2Ia6cDKjXaA5Yk62UOYfetuNNbubeHOnNOp4xiB
         3T9XdekweVTOW9JEZxW0R1Idqzujuj+VSQg3NMS8d4f/UmCIKNoUNvtc64yCvGKzMMok
         RtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpXoMxo0aQKIkiKPZdmGA4JTiZjUpQr6v1L8PEccH18=;
        b=T1An1exRT/0dx7PT0k4QhAwZIKr8Du5Y+ZGRLJzdEvKZi1uthrkbEJFNrjWQEutVct
         M2y4jJkL1q7QOPc6Nt6tPPYKe6ShXiPwJh4OgH1YiJg8YiAw6OFtLyl7q41qfHsIyI64
         R4drb8BW6Er8FN42HlrjmuQCIiGJGdbUWbWF9MxH6du5GlgtYME1A397myUJbTMIykOp
         jmAlTJAJI4OJ+siQ3Vvg5DuE5Tp2O/cSqVuydh6Kwrb72Sr9WG+oe31DOT/YOF/Y6NzV
         1bhAXF+ObPmNcnNYElp2xsLBBUo44wYetLnnXnRdnttXbm0SLDAS3f8x2N60scR4Uo4n
         jpTA==
X-Gm-Message-State: AJIora8MyEtVJyrZJDvRWU9C0xBaa5xIvHX3IEvaoCsOjgYkUxK8RyFK
        NYMmQI8rWlACuY65kcJAF1iZj35lPLE=
X-Google-Smtp-Source: AGRyM1t9R4P4RR1EyyBS1sA+dL+RrIu7VFwViovZPip1seLvD5AZhI/SB/nk8AJ2gBNjn1pLIlC0wQ==
X-Received: by 2002:a17:907:3e84:b0:6fe:8c5f:d552 with SMTP id hs4-20020a1709073e8400b006fe8c5fd552mr42214687ejc.710.1657156204617;
        Wed, 06 Jul 2022 18:10:04 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:04 -0700 (PDT)
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
Subject: [PATCH v2 1/8] ARM: dts: qcom: add multiple missing pin definition for ipq8064
Date:   Thu,  7 Jul 2022 03:09:35 +0200
Message-Id: <20220707010943.20857-2-ansuelsmth@gmail.com>
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

Add missing definition for mdio0 pins used for gpio-bitbang driver,i2c4
pins and rgmii2 pins for ipq8064.

Drop i2c4_pins node from ipq8064-ap148 dts as it's now moved to ipq8064
dtsi.

Drop mdio0_pins node from ipq8064-rb3011 dts as it's now moved to
ipq8064 dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts  |  6 -----
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  9 -------
 arch/arm/boot/dts/qcom-ipq8064.dtsi       | 32 +++++++++++++++++++++++
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index b63d01d10189..a654d3c22c4f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -7,12 +7,6 @@ / {
 
 	soc {
 		pinmux@800000 {
-			i2c4_pins: i2c4_pinmux {
-				pins = "gpio12", "gpio13";
-				function = "gsbi4";
-				bias-disable;
-			};
-
 			buttons_pins: buttons_pins {
 				mux {
 					pins = "gpio54", "gpio65";
diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 9034f00f2bd8..5a65cce2500c 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -307,15 +307,6 @@ mux {
 		};
 	};
 
-	mdio0_pins: mdio0_pins {
-		mux {
-			pins = "gpio0", "gpio1";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-	};
-
 	mdio1_pins: mdio1_pins {
 		mux {
 			pins = "gpio10", "gpio11";
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 4b475d98343c..bc9987c841d0 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -382,6 +382,13 @@ mux {
 				};
 			};
 
+			i2c4_pins: i2c4-default {
+				pins = "gpio12", "gpio13";
+				function = "gsbi4";
+				drive-strength = <12>;
+				bias-disable;
+			};
+
 			spi_pins: spi_pins {
 				mux {
 					pins = "gpio18", "gpio19", "gpio21";
@@ -424,6 +431,8 @@ mux {
 
 				pullups {
 					pins = "gpio39";
+					function = "nand";
+					drive-strength = <10>;
 					bias-pull-up;
 				};
 
@@ -431,9 +440,32 @@ hold {
 					pins = "gpio40", "gpio41", "gpio42",
 					       "gpio43", "gpio44", "gpio45",
 					       "gpio46", "gpio47";
+					function = "nand";
+					drive-strength = <10>;
 					bias-bus-hold;
 				};
 			};
+
+			mdio0_pins: mdio0-pins {
+				mux {
+					pins = "gpio0", "gpio1";
+					function = "mdio";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			rgmii2_pins: rgmii2-pins {
+				mux {
+					pins = "gpio27", "gpio28", "gpio29",
+					       "gpio30", "gpio31", "gpio32",
+					       "gpio51", "gpio52", "gpio59",
+					       "gpio60", "gpio61", "gpio62";
+					function = "rgmii2";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
 		};
 
 		intc: interrupt-controller@2000000 {
-- 
2.36.1

