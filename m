Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7ED523253
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiEKMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiEKMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:00:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0168243107;
        Wed, 11 May 2022 04:59:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g23so2187567edy.13;
        Wed, 11 May 2022 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9UUg/fQTsaqkN2h8KB+8rJP5/jfsoQ0IyVKGrfdu/4=;
        b=bX7HkIaoRGew6tEpswM1+CpQTkckKbCj2lnYq+HShOUZpzz+RfWZilYyN71yloU2uI
         ozyiwfQGWhSi7g+IzclDVQKRMv8hjB7jonUeVL9V8heuurAhq2C5G6iGiU2qmD6JWnRD
         ex/o125CBSZ6xJXfa6jS3NpnpebkYl5bUM/cih75cRfvYd5yYaU2FXTHFLfTXpwLJqm2
         7h0XsORg+WcxwkQanXx3QMJw+RRviq2wPVxyNE4KmbvVK1zFo5Db5HBNcto6CdvpTlzv
         90nbMW146FyRT035OgKdwKUcqY+aEoX5wMadvfSpTXuVTnX1ZEjitYya9oHC/S+t7jBK
         ZgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9UUg/fQTsaqkN2h8KB+8rJP5/jfsoQ0IyVKGrfdu/4=;
        b=43LTWGAda/EoZ7CzJf1p6LoQ8nwb1KQOUW1qTKhto88Cg9EtcBZX9kdyBiRBBxRrWI
         7aJEaXOAJMc5HwqJLL+0a+L3nvjDYL+A7CU++3rO2OKnOjRBzCDN864sP66Xe8vglMhd
         LdVoQm6PhHUZ4dsEcJ1L2D/+p6klMrdzoGYVAfnVHNEspDpzNutX3ck7Ar59ndN1XuS6
         +hjKNjHaWRCfduZ+cGWZJP9bV5obBDabCmOSsM4YZ1FLzC/iuOgmoV5Fgqs6fhsnDaOm
         ybhcSLpgRABPeNqarDn2b/pLPALq8EUUOvQHj5J8tMLQncM9sLYIxrsVHxX9mzFtZoxg
         oHRQ==
X-Gm-Message-State: AOAM533FqiXh3M+kNDVledX+3HQH9XQv71VdGjsSwEnLbghgSCv8464V
        khY9gHGiSiZOayqVILGlq1gr+kJo+j0=
X-Google-Smtp-Source: ABdhPJzxCvHM1I7LqhcNanhrQZI6z4CClwZqgmMIMSm/Hg8qiFB9Gdh0gSTe4+hoZrA1IWvHM7Pvsw==
X-Received: by 2002:a05:6402:2790:b0:427:d09b:df82 with SMTP id b16-20020a056402279000b00427d09bdf82mr28621102ede.151.1652270397282;
        Wed, 11 May 2022 04:59:57 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d0c6000000b0042617ba63aasm1089279edf.52.2022.05.11.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:59:56 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight
Date:   Wed, 11 May 2022 13:59:09 +0200
Message-Id: <20220511115911.54960-4-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220511115911.54960-1-max.oss.09@gmail.com>
References: <20220511115911.54960-1-max.oss.09@gmail.com>
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

Set #pwm-cells to the default 3 to gain access to the parameter
which allows inverting the PWM signal. This is useful to specify
a backlight which has its highest brightness at 0.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Split to two patches as proposed by Fabio Estevam

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index f0908b530f86..d91fae92c90a 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Toradex Colibri iMX6DL/S Module";
@@ -13,13 +14,13 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <0 127 191 223 239 247 251 255>;
-		default-brightness-level = <1>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
 		enable-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* Colibri BL_ON */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
 		power-supply = <&reg_module_3v3>;
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 PWM_POLARITY_INVERTED>;
 		status = "disabled";
 	};
 
@@ -620,7 +621,6 @@
 
 /* Colibri PWM<A> */
 &pwm3 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "disabled";
-- 
2.20.1

