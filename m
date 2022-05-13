Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2953525FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379524AbiEMK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379209AbiEMK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:27:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D3C50451;
        Fri, 13 May 2022 03:27:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g23so9359186edy.13;
        Fri, 13 May 2022 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wjttoh5pJ3Cm9OJ+7lfSQscXOm+8KL2ATcs8KqsT+HA=;
        b=msYuy6T0lARvYyJaJSawEOZr3dDydhikevW3BwFGVTX5wJ7cpXtdPNtbiRqTbtsGLu
         0c6iVa3rEbA0+7p4SulwQ4w7vdifgtpidzsJKqqpc11+zB6GbDtJoxT/1WmQQM0W7uID
         g17a7NjqvSqJaMxJqN81YsBoiLAOpPibkWMt8EXsjxy5vEDRtxn39Te5jBONTlfaUor5
         F8V8IgwwmbvX7rwkOfeyGr0hYUsriTB/7UhB8XxKxlZYbkgbmDjTwD7fGaEviEimyNSa
         6RGreK8pnkvJ/hIBS52EuXPIiJjOlkFXuuQ6Cb+DzRpM5vUghLRUSn62bV/cAHz/SPDn
         NQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wjttoh5pJ3Cm9OJ+7lfSQscXOm+8KL2ATcs8KqsT+HA=;
        b=pt/7YjG4HE8Xo2SJHBTfufzlasUEGwpqrnK8B/XDQ+f4J/8ZA+HezYSOxRJj5xyb5M
         ttc9xygCE41TAc5qo8WD5yTdMUZqqQxt4kCYWgJGpSvRi4Sr/t3KMRNvWs7qNcmoe3ML
         ZyX0E23y9vs84F7pWKMem8jJySzuatu8ctPnR2MaXD9NWnThV1e52wsBAEM9jeuJddn9
         Fn7822SV/bzbb/ypvcHQ8k7flhpMrovgbREUHrmzv5jtAhZKjle5dyh0ZN69W6SLVtXt
         6Jy9hIzRky4f4YEtM1pkYZ/ME+aSHYNmJ9Ch255/7lRJ0DNJuwZq6thRRURoM4Z8QyQF
         AkNA==
X-Gm-Message-State: AOAM530WFBzAA+i3mI124YdjXZ2eNxVn6eUe4JWBdIHCIJKlybBj7FPC
        aSExWOnc/6ZnS+Rsbp1Ysnk=
X-Google-Smtp-Source: ABdhPJzfZZQ0iwoUhAxi7llnxPNl7jZQUVkZxsiuUFC6Gmb/knxfHIKdKy0GUvUJ6TNiDR9mDxE3ag==
X-Received: by 2002:a05:6402:42c4:b0:426:a7a8:348f with SMTP id i4-20020a05640242c400b00426a7a8348fmr39951718edc.341.1652437626688;
        Fri, 13 May 2022 03:27:06 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906100300b006f3ef214e40sm609677ejm.166.2022.05.13.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 03:27:06 -0700 (PDT)
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
Subject: [PATCH v3 3/4] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight
Date:   Fri, 13 May 2022 12:26:14 +0200
Message-Id: <20220513102616.48040-4-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220513102616.48040-1-max.oss.09@gmail.com>
References: <20220513102616.48040-1-max.oss.09@gmail.com>
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

Changes in v3:
- Add the reason why brightness-levels needs a change to commit
  comment as proposed by Fabio Estevam

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

