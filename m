Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1015283AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbiEPL74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243311AbiEPL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A315FE2;
        Mon, 16 May 2022 04:59:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g12so2639286edq.4;
        Mon, 16 May 2022 04:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmdHqA0oaYOkSe9dGsepZveX0B9uSDC/sB1WxfLB/rc=;
        b=nWOMwweBoLWmosmAjjSCbL4rr16qLV3iGprVRhu3Q5guf2p2PcT+XZzH1uyNjzEX9F
         whwFjVnBWCmVDjJm6MJT5TLtcpYhrxaG4sT3PDZZhJp3/r9PbsP4znIoFzWelUbrWetc
         Bp9Ki/Ch0Hj2LGYZJHDu+c0YpTHDO9kcE1Jq0VbCwzezfsOxoxmrcClE2SQzBCHs+Gur
         8wiuoJ5XqvH32J1SdyBIdM2MaP5MJ+Cu9meSUjRUetNXHt9ISn9t9dF8weDkc+YWrmyP
         aG2uPWCgVe1pJKuwMK0ZURSwRV9pa6qMa6ExYCa5V9f8Y+QBBP76DmLmhOnZ7NyXNXk5
         fIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmdHqA0oaYOkSe9dGsepZveX0B9uSDC/sB1WxfLB/rc=;
        b=6wr49Z/m8GtpFlfxOEvPPxbsTOffrB/mGy3EST6flpXF4UMQTWN/z3WYMVYcRG/i9h
         SyLX1k8GC3MUz5M3jToaN/DqWRThyBb531lqAjLOOjHxReMy3gZGVKZ4505VL49X65X9
         PTMHIIapfLyUIUvtOFN2iYRDZRzS6W/UWI4qJpgSbtbGgJkz0AaPPg10DNB+yctGfouf
         v4VRkXNOHpTDxGoldxdhRVg8QHtfoyH/hlAY0JG5K5lNKdpsDZt0pGXL5JQZr4OSh1zL
         mAYFg4dP33UIRA4LZWO0zbUPOGHh7cqkjdx8x/FmBGU8v0x/sLTCK42oczAAXsbw3YDX
         POhA==
X-Gm-Message-State: AOAM532WBFeK+DgxGl1XOLFRXXkvWe0befaUXZmDy4vPpmRkcgpataLK
        y9BzmocUss4hwKwW0Srev1o=
X-Google-Smtp-Source: ABdhPJw60VJVPlZ1+ug5yXxRRBD2eI28gxK/k1AZCRb2cueQONF2HtDPxz4ZNaaRz4uXP6VgxncvTg==
X-Received: by 2002:a05:6402:d0e:b0:413:3d99:f2d6 with SMTP id eb14-20020a0564020d0e00b004133d99f2d6mr12990573edb.189.1652702367114;
        Mon, 16 May 2022 04:59:27 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:26 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/17] ARM: dts: imx6q-apalis: Move pinmux groups to SoM dtsi
Date:   Mon, 16 May 2022 13:58:34 +0200
Message-Id: <20220516115846.58328-7-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
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

