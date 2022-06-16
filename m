Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6854D697
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350285AbiFPAyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349356AbiFPAyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8788B5715D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l4so11840521pgh.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5S/RV9AELwOaDCH5atX+3Vv8RTm/1jcts99iBeZwt4M=;
        b=lPIYEy/Ev7bY5lYBtUS6w2mLvMyGLDODKCsFsOFEDQmclwrYDIZAWSFjvSHnx5rS5g
         DpruKpy+tpiOIPNkwAIJKOkMk0a9A9EYxBU6NPaBYwlah/m9lQS/66bAUINlP2jKsiJD
         BirKrA5qbovT41mGMFm7K97FmVFwjFnx1l/hocwV2nb6ZYp5WL0cGyJNFN8MDDWbzE0A
         M2Kk09RjxLK1x/z7+MNvgwW6dYJp0rkwaoE/uQLwMtkUKEyQSQFG9FQkEG/sJQb93pWP
         KhCbU9yBpyxmpMzJvR2fGy9fpDCUDRXv5cpMryWoF0t+QFUPWkxuDns5Jb+heffPPq51
         DcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5S/RV9AELwOaDCH5atX+3Vv8RTm/1jcts99iBeZwt4M=;
        b=viwm9lXo77TAEVBUiMlixMqXtv6cNWoG99SBghs2Kgfzw3E5jmqeIl+PFxYzuoVq5c
         FUqj7KpiTGHe0cHtieJ2CbbpfG5xgEKt71pb+NPJAFjI6IGSSVKgY1MZuloSQnsnLw1y
         XKJU0GArggNlfqTrhwvVUafzTF7c/MX4kHRHBpxcEnNEVo4NjwkT7FKyt1/T7ISAHDcF
         AggZK/7vZK8NZtRRDCI3i64vF4J8Q9YFdAX8c1CiZL7JvkAVpaaFMIe09F+r6+7l+OPR
         Y64HWDvzyAlmdVahogHS6T31R9ia82LSEv6bTWtHME+RjVmj3TSeMuMAR3GyP96fahZB
         sDZQ==
X-Gm-Message-State: AJIora8bM5OJo2ldCUKRB8yxIUidlLKXZ2n7ddxyrYvB4trYRaix8S5e
        B32VmcOVSEzu3JayL1o5pzJQPw==
X-Google-Smtp-Source: AGRyM1ssV/mWngKTiJ8cEhwCgTrohwZfv25DcWH/U2IFLH3vcLxe4TIus9wvmggWjkGbYD8zK6gCag==
X-Received: by 2002:a05:6a00:1811:b0:51b:fec8:be7b with SMTP id y17-20020a056a00181100b0051bfec8be7bmr2288972pfa.22.1655340846031;
        Wed, 15 Jun 2022 17:54:06 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 08/40] arm64: dts: freescale: align led node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:01 -0700
Message-Id: <20220616005333.18491-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
with 'led'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dts   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index aa38f5379558..ef6c8967533e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -52,17 +52,17 @@ button-admin {
 	leds {
 		compatible = "gpio-leds";
 
-		sfp1down {
+		led-0 {
 			label = "ten64:green:sfp1:down";
 			gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		sfp2up {
+		led-1 {
 			label = "ten64:green:sfp2:up";
 			gpios = <&gpio3 12 GPIO_ACTIVE_HIGH>;
 		};
 
-		admin {
+		led-2 {
 			label = "ten64:admin";
 			gpios = <&sfpgpio 12 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dts b/arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dts
index 92eaf4ef4563..c97f4e06ae5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dts
@@ -20,13 +20,13 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user1 {
+		led-1 {
 			label = "TestLed601";
 			gpios = <&gpio4 18 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 		};
 
-		user2 {
+		led-2 {
 			label = "TestLed602";
 			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.34.1

