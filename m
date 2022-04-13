Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C74FF4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiDMKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiDMKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:23:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5086027CE5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:20:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so2954819ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGO6fu5bsJKLhceCU/2eZbT6NC6ZKZlGiRFZPq4QBd8=;
        b=lUJPLTmrBG8EGdlglUt6FsdnyuMBIQH6L1xSpGJEabdt7ofMyOQaqeNHc/HErZUbbM
         CPvEkBqPWMxwgShffc4c0zIxaAczkglBwkcpQKrCIfrXO7sLlyXosLYMpPAN2x5kA5Uj
         WUoD6HblWk8E3RnB2o8u2Z23Jc7ubq3kR+pTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGO6fu5bsJKLhceCU/2eZbT6NC6ZKZlGiRFZPq4QBd8=;
        b=whNylKHfmPMLHy5ThZuBpGzSJN66RFaBOJUscB78V0V0f42LRDwlMy3IpJ6e3CoY7H
         2SUIefIIp23jr5AmAlDlDYE0gWtyXzfvJ7dlwtWWYu41/IWW8MT2u1l5wc8qUc9OVPWC
         VRVsOon7zHDlEEAY1nM9wYL8Fo7N1kec5ozPnu+qv8eassoF3HesOGI/a8DcQ29SqpKN
         3Gh8m2FU6wtJp004ANNJnRTu9puadD8FFZi2spJaZB3SS7vfhFmJEt7U6WeBfhK05BlM
         D54OE54KfpBUmyV10rWyDsjcstdgj4jyvWcyiNuk+CtL1lD/OigMgp4891Bj6Ez7rXtt
         +dCw==
X-Gm-Message-State: AOAM532mYppDXIzFL5dPnnpUrRdmROI5RUViU6EaMv4IzMxhzVeX43nG
        mLnabq/bZ1diL4fgBxBUOCH49g==
X-Google-Smtp-Source: ABdhPJyd46hjgiXiKc0E6A+TkwfuNjRpTspMmE/b+xlPHX9Jpc6mEp15RgVxpqgijjXtUcN2SGghkQ==
X-Received: by 2002:a17:906:6a0d:b0:6e8:c927:663 with SMTP id qw13-20020a1709066a0d00b006e8c9270663mr1940427ejc.394.1649845257887;
        Wed, 13 Apr 2022 03:20:57 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-245-147-71.retail.telecomitalia.it. [95.245.147.71])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm14021163ejo.190.2022.04.13.03.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 03:20:57 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     tommaso.merciai@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-evk: add pwm1/backlight support
Date:   Wed, 13 Apr 2022 12:20:51 +0200
Message-Id: <20220413102052.20207-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwm1/backlight support nodes for imx8mm_evk board. Align with u-boot
dts

References:
 - https://patchwork.ozlabs.org/project/uboot/patch/20220326111911.13720-9-tommaso.merciai@amarulasolutions.com/

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 6d67df7692f1..55566708f667 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -59,6 +59,15 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
+	backlight: backlight {
+		status = "disabled";
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 255>;
+		num-interpolated-steps = <255>;
+		default-brightness-level = <250>;
+	};
+
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
@@ -395,6 +404,12 @@ &wdog1 {
 	status = "okay";
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_backlight>;
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
@@ -549,4 +564,10 @@ pinctrl_wdog: wdoggrp {
 			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
 		>;
 	};
+
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x06
+		>;
+	};
 };
-- 
2.25.1

