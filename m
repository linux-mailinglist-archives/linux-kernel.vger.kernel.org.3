Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76015670A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiGEONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiGEOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E167224;
        Tue,  5 Jul 2022 07:06:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v12so2819515edc.10;
        Tue, 05 Jul 2022 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJh4STxYhKUEdraBnGSkmRWu6LkfaJesDml9XVRAwQw=;
        b=aqpKnA0LluE6mfA7TyX0qzY8QE0PGCn+o16kqXdgrFPx/DhkX0vwWX01d3hy1QNf9m
         5J++U1i4qZg9GmJrFDu8tnI1nhn8/n493naSE3N8sDEkwr930uGtw5m5JVBRgOHBosB7
         4PJWulrZpQ3IB38IPZXoaj+LwrG5pA1v/Ru6D+plMhCU7GKhv9yosHd/pCXatp+KHK6H
         ymraVk1VgDKe11AHSdSA0qhClVD3EIJQgEscCHHhB2WPLgraWp8cTe3DfpQNNR0AcyMf
         LOGcq45XbBTOUMc0yFxviEOlPPGGteu3QxkljRA2+yzZq6PisH4yFA5lUeddzLglet0f
         3u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJh4STxYhKUEdraBnGSkmRWu6LkfaJesDml9XVRAwQw=;
        b=aIwKo1K0xoIV7O5zWS+x/5IDE7BIQmmfNrbuDVX3juINt6OWQa08LIvJAaL8FjK6M5
         uDy1QkZW2JutkZGJrcIs5xhrRc5A80I/g0A9RZRn1lWOvSOLl1inGIkVCPmxecjzaPQt
         CWzZK4yKvmZMbC+b395N7/cuZrVuBFsLn/EZjax7Vr9Fh2zXuSKDhWs/SWwXL1Md3irk
         ybh4OBC5bs88FcdPXcRSQROhgvQkSciYk0Ds9L8kn6r+5jzFsAzZB5bcGpnOCmZz8Cr9
         YXDOnJ+Wy3ur8bkh1wLnoyK2ZTMiJruEzpXo6mvHp+xQ7iDIvimGEj3w4Ex9f+7tb0Iu
         joWA==
X-Gm-Message-State: AJIora/wfBY2xYqv+t9s6kQPF4lktpIM8ua5y7iu/ytTtC++RFPHdIE7
        Ud2tVX35MrOQ9DFQfS2E+lk=
X-Google-Smtp-Source: AGRyM1tuacpWYvPb/hyoC/y1SFKvtm5cVxdA1/xO6dVUtiBeR6SdWTfOMyv32xXIh1XAmACH/A5cHQ==
X-Received: by 2002:a05:6402:3307:b0:43a:826c:d8b4 with SMTP id e7-20020a056402330700b0043a826cd8b4mr9603eda.32.1657029989172;
        Tue, 05 Jul 2022 07:06:29 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:28 -0700 (PDT)
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
Subject: [PATCH 01/13] ARM: dts: qcom: add multiple missing pin definition for ipq8064
Date:   Tue,  5 Jul 2022 15:39:05 +0200
Message-Id: <20220705133917.8405-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 4b475d98343c..f06a17bd915a 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -382,6 +382,15 @@ mux {
 				};
 			};
 
+			i2c4_pins: i2c4_pinmux {
+				mux {
+					pins = "gpio12", "gpio13";
+					function = "gsbi4";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
+
 			spi_pins: spi_pins {
 				mux {
 					pins = "gpio18", "gpio19", "gpio21";
@@ -424,6 +433,8 @@ mux {
 
 				pullups {
 					pins = "gpio39";
+					function = "nand";
+					drive-strength = <10>;
 					bias-pull-up;
 				};
 
@@ -431,9 +442,32 @@ hold {
 					pins = "gpio40", "gpio41", "gpio42",
 					       "gpio43", "gpio44", "gpio45",
 					       "gpio46", "gpio47";
+					function = "nand";
+					drive-strength = <10>;
 					bias-bus-hold;
 				};
 			};
+
+			mdio0_pins: mdio0_pins {
+				mux {
+					pins = "gpio0", "gpio1";
+					function = "mdio";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			rgmii2_pins: rgmii2_pins {
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

