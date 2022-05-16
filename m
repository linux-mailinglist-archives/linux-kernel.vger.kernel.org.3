Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4C5283C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiEPMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243440AbiEPMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:00:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3971705D;
        Mon, 16 May 2022 04:59:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ks9so28180673ejb.2;
        Mon, 16 May 2022 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQ+/zAYDYzlIVwhBZOjr+9YmcuxLFRWGYnq8noCNm6Q=;
        b=Ul2ALb+PwrpKLFgrqQ2ddPMSS6EGneglWSb29zDFP9QO3F6HpYV3GsIJX/TX4FeKaS
         sh3REtOmRVVysBbyRKetx2mvKsIXfVdAj7wliiqyzPCYjKNE+kI5wQAluPX5QlHNqEkY
         m5teKtGq2++zpS5nHhe9BuoCXPbXOEyeraV/OdrT3su3IgHf5qG/TzhXiWOrmKpyuisG
         hFX9vCQx2Ic27oP2qY96k4SKtI92Mp3CHaF1nmJ9u1/Ml+wRe0Dwp1qFj6CA4ET+gbG1
         U/UjXG3quk5naFPEEDv/8bTVNrnEgc7ra7Q4y7iMoRfHsScr+UCuszL82TontIj8x74f
         8DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQ+/zAYDYzlIVwhBZOjr+9YmcuxLFRWGYnq8noCNm6Q=;
        b=nRy/oh3VdY4yePJ3OpH7vR+wckGKmztLOtClQuBZ0fZwLnfgWjK2Sz+olBOC6HO85F
         SxcERnn2QOXQFIxvMlSGCsoTKI1kXmGqJfLHxeyYJwa9WySX2E/yWCNtJw3hlqBmia8d
         iSLfSTPIWrU/yAU5kb/+zWK+PLcbsxx2cOgwdot4fujRMdcLC/k0d1SJBxMrBq5nl7MB
         7rzILK52w3MnaturHJzY9fJM9+HoVnx5kW/0SMmj4a+3jMidgouX1g3ShF8zV6a/vVQu
         orPuGeYVeQwlCAx4H/dcPaAVCAh1BiqboktI5ha9D6GzExv0Lx6mTVVf/rTxtxNIrEn7
         5ZUA==
X-Gm-Message-State: AOAM532SLWUb86jTr31ovcUlPJb91mpknJCJq9O3DvyP+lvm+SFFktqU
        FstkclZgQbsyWvoQcv62J/A=
X-Google-Smtp-Source: ABdhPJzGegeYVw0NU99xQNbBARJB4zkYwREXhG0v+IXsvWmsBLwKH/JJ1PRgnOJT6uwK5uUAGF+YGQ==
X-Received: by 2002:a17:906:7952:b0:6fe:1e0b:6343 with SMTP id l18-20020a170906795200b006fe1e0b6343mr9096414ejo.337.1652702380993;
        Mon, 16 May 2022 04:59:40 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:40 -0700 (PDT)
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
Subject: [PATCH v1 15/17] ARM: dts: imx6q-apalis: backlight pwm: Simplify inverted backlight
Date:   Mon, 16 May 2022 13:58:43 +0200
Message-Id: <20220516115846.58328-16-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Set #pwm-cells to the default 3 to gain access to the parameter
which allows inverting the PWM signal. This is useful to specify
a backlight which has its highest brightness at 0.

With the change to use the PWM with inverted polarity the PWM signal
is inverted to how it was before this patch.
This changes the meaning of the values in the brightness-levels
property. I.e. the duty-cycle changes from x/255 to (255-x)/255.
Keeping the brightness-levels will then have a big brightness
jump from 0 to 127 duty cycle, the other 6 steps will then be
barely noticeable.

Change the brightness-levels to provide the same brightness-levels
as before.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 57642aefe349..49669caac8b7 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Toradex Apalis iMX6Q/D Module";
@@ -19,13 +20,13 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		brightness-levels = <0 127 191 223 239 247 251 255>;
-		default-brightness-level = <1>;
-		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_module_3v3>;
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 PWM_POLARITY_INVERTED>;
 		status = "disabled";
 	};
 
@@ -761,7 +762,6 @@
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "disabled";
-- 
2.20.1

