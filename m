Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42D354C7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347117AbiFOLvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346018AbiFOLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:53 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F44B87F;
        Wed, 15 Jun 2022 04:50:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg6so22832272ejb.0;
        Wed, 15 Jun 2022 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Guka/3EkONPT7ruv1yB3htE4jlDLL09ghQ5WYAu5sy8=;
        b=K+DHI1DViDB+tXFVTvrhY3VUhuw/yC8eno48Q/6Cb0gqU2yhHqNX4x78GyzWWcvzFK
         PazxFdHnHYc9sVYbQdrXbBIpeKez1D/6dv1hkKQl+C7ZQI1YnoHQYbhkrhAxUg+5+XeL
         JyNTMavIHvbgr1Eo4SzcWzXUw+rtFuHxwRyyRogCbkWaxLmcEzWvY2VVggUXZmO566OE
         jND4Z1ZujLsDlXr3JtgsaSf2lZXDZMyDSHaiq1aPZvRbqnEp0Pg7LH7fxu6A1sBJY9qW
         Gw6B+XRIifa/fqlKCeZXenmgHpOL0SWrKOuMBJ9uY5szzb8Ydg51Owl16tpPUjufujUl
         Qe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Guka/3EkONPT7ruv1yB3htE4jlDLL09ghQ5WYAu5sy8=;
        b=4qcAIMbNpWK/hmDJ5iSuccmePKGiFCMCwhBrUGxgApYKHtlFbKxHduoMQ7j5thZwoB
         Lt1F3vnzI7gvch1yeV95LrGSOEoim+lf6h4BYVVLnmwATEvPcbV1qS1gNgfW7ABR8clQ
         85ISWKD9gmh8lgG4IXTIIb8H/tRMGpcbXzNUSK6u1ZJ9/UM764Fo+Ws3iLdOfaOcMrUw
         oGzrqJw9Ma+jvUKOsStlUCkbCTNaQawO4XQX0TlKhwJll+V56rUCM7ICOHYhxoqgsuZ+
         yZIv1bcDMMxrtuD+U1hTlLzoUIghi/Ib/y4FI6I0dRHFe2n9SI1V0D21sln/Q+dv2E/+
         yPtg==
X-Gm-Message-State: AOAM530EeExE1dLYDUcsPIGmJ1G8nxSa9aYl7lkxn6vv/+TY8G5Xs90N
        bFIvNgR5+drVEmMkUQb/Qn8=
X-Google-Smtp-Source: ABdhPJx4vH7IbXYyyAkivG+QfNnx5PEYLWveBTWQWpe+ymQB7/5adphCeYUi6oCABDjtTtSDxB+jBQ==
X-Received: by 2002:a17:906:33cc:b0:711:609f:8a63 with SMTP id w12-20020a17090633cc00b00711609f8a63mr8782057eja.128.1655293851154;
        Wed, 15 Jun 2022 04:50:51 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:50 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/18] ARM: dts: imx6q-apalis: Move pinmux groups to SoM dtsi
Date:   Wed, 15 Jun 2022 13:49:54 +0200
Message-Id: <20220615115006.45672-7-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
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

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

GPIO pinmux groups are declared on the module level. Move muxing
them to the same level. It also reduces code duplication.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 12 ------------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 10 ----------
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      |  8 --------
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         |  8 ++++++++
 4 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 1e6b5482a777..fe5d491e1399 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -206,15 +206,3 @@
 	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-
-&iomuxc {
-	/*
-	 * Mux the Apalis GPIOs
-	 */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
-		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
-		     &pinctrl_apalis_gpio5 &pinctrl_apalis_gpio6
-		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8
-		    >;
-};
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 527585d26e51..8febfc0aea93 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -202,16 +202,6 @@
 };
 
 &iomuxc {
-	/*
-	 * Mux the Apalis GPIOs
-	 */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
-		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
-		     &pinctrl_apalis_gpio5 &pinctrl_apalis_gpio6
-		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8
-		    >;
-
 	pinctrl_leds_ixora: ledsixoragrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14 0x1b0b0
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 9900ab04fb28..78cf1d9583c1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -205,14 +205,6 @@
 };
 
 &iomuxc {
-	/* Mux the Apalis GPIOs */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
-		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
-		     &pinctrl_apalis_gpio5 &pinctrl_apalis_gpio6
-		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8
-		    >;
-
 	pinctrl_leds_ixora: ledsixoragrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_DAT1__GPIO1_IO17 0x1b0b0
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index c0ae08780d86..9413c14ce5f6 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -709,6 +709,14 @@
 };
 
 &iomuxc {
+	/* Mux the Apalis GPIOs */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
+		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
+		     &pinctrl_apalis_gpio5 &pinctrl_apalis_gpio6
+		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8
+		    >;
+
 	pinctrl_apalis_gpio1: gpio2io04grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D4__GPIO2_IO04 0x130b0
-- 
2.20.1

