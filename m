Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1D59BAAC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiHVHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHVHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:54:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A312A72D;
        Mon, 22 Aug 2022 00:53:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w10so622846edc.3;
        Mon, 22 Aug 2022 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6QJrT/nHZhtnj/AhwbICVx7wYH58RsjoZpITZLU2314=;
        b=ZIQIRcFPWNoF6hm8QRjzsJU/Zpx2zNaHoHeCpPHY9Kjg7Mg0tGu5yexHwW1EPmbEug
         q/rpFH72q0TFvYHMDuQzoCvj13IC4e+0lAT3grlecGaP7RAM5homELaMldAggsK0Vk0X
         tIfRVUFO9IqUpaqJRQdNVeiIneDi7nqqKmvXl5DxQ14BiIh4djXgkgv/PB5/IfrcccHj
         /xpJpkGxFn0ajkZLQjmJZ+qoJfiBmV4TPHpVH20ckORcvUoRXCfPZM1wvX9Q/gs8Mged
         +dk6UsJaH5kN9QmSW4Aa2LneMnvE3d9gBwvDd6W+A2hRoYJbshQNHc0bRE+O06CQmRqF
         HZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6QJrT/nHZhtnj/AhwbICVx7wYH58RsjoZpITZLU2314=;
        b=7FCzwan3DKVhC5b5PL5OHIWJw/bAenqybG15KMOshIhnQfSpyYK459V7wneDGuCER3
         3EOq883I2+F/T3Eh1ZI+MjqjyAhdbdrYs9A5+Z7yEaH9MwNA2P+Y6mqTA6on3qLh4L4c
         PQAxNqK2OBV5omgutVQicZYuLGMU6hpxQArsqMJAOBmukzyzSWXbs/owjnSpO3Ys87g8
         SRWdM2kTHpSPYE5Fd2feWtxDfSWCHQvIQfZZeUEyf+iZc1BAG57gGCUq4MNoMBjMmWby
         GSa2+Y+QRS+ez4hQR01nF5eb8E9qOriksFmncScv52Ki++V/VU19vBre7+q0IxBT5REU
         fH1A==
X-Gm-Message-State: ACgBeo2SN62gSjh+ByYCISJz9rNi7sOBWkeQadgw2IUZDkPRJEfsyvNR
        QkCsFHvzIVrqCVYCOXHsPXc=
X-Google-Smtp-Source: AA6agR68AL6r3Qh1hS1OJxvM5j19vBFqkkF2v0pZW9tcP/s5wJdcyfaRHOPfi9CyPgSILx07m6vPgw==
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id q13-20020a056402248d00b00437dd4ce70emr14690355eda.75.1661154837661;
        Mon, 22 Aug 2022 00:53:57 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a1709062ed200b00722e50dab2csm5764277eji.109.2022.08.22.00.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 00:53:57 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-verdin: add cpu-supply
Date:   Mon, 22 Aug 2022 09:53:42 +0200
Message-Id: <20220822075342.2611279-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Add the cpu-supply property to all CPU nodes to enable the cpufreq
driver.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 .../boot/dts/freescale/imx8mp-verdin.dtsi      | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index f062fdbb2719..dbc22b672fb3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -146,6 +146,22 @@ reserved-memory {
 	};
 };
 
+&A53_0 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_vdd_arm>;
+};
+
 &cpu_alert0 {
 	temperature = <95000>;
 };
@@ -453,7 +469,7 @@ BUCK1 {
 				regulator-ramp-delay = <3125>;
 			};
 
-			BUCK2 {
+			reg_vdd_arm: BUCK2 {
 				nxp,dvs-run-voltage = <950000>;
 				nxp,dvs-standby-voltage = <850000>;
 				regulator-always-on;
-- 
2.35.3

