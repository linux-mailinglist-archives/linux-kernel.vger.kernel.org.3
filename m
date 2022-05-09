Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7551FB1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiEILQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiEILQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:16:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967851A8E32;
        Mon,  9 May 2022 04:12:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l18so26074327ejc.7;
        Mon, 09 May 2022 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/dDZTXvhevSA0CwXNeoVIZNKRdACOkTC7CvftF8ff4=;
        b=hXKQ4iPhqEuKSEkcznKWL5bTQuEvBLD8qMJKXAdJhjdH1Jic9CSNhB1Eg9oqprJ32/
         u2sXG5GiPqCXo+JVf9HIPvgnlnW5jNThAK+2mvuoD/0hoWdwownTlRJ40GFBOGXrvlcP
         HxNMNQbeWLZJedRiOiPLzK5ZQGWaTiCh+OOKPvgjFjkNmS7k0H+qlevcVzjNyDRlPfXP
         mS/1fOkyR/y/h9Z4zZK3pLpUrFbd0x9ZLH6hzLUKDA6D2muVgTCt2UcbIfPq4+W9EpQP
         ubjPFJBoyTEy/o+MNaDwGJp8A9sL3waH6fhp3Nbvuvf38qRssQPnQQdMSmS0xuQKPJFK
         VahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/dDZTXvhevSA0CwXNeoVIZNKRdACOkTC7CvftF8ff4=;
        b=xyMK/4n0NjnDLh9PR840faqHmPsjm/3Hx8vRLKPPs8RxMXTiI74YDtxQFNAkooBc0q
         Yk54AeNVQNqH3AUK3apZUKWI6q16pNV/Tnes2Lp7yQPP4cklkTcyEq+7UBxSJ2hN4h3S
         H73spGWsqrm0Qws2w6Urz4h2WdrYdWub4ZeyJfjrDn/iCVi3p+CQIimDn10gkPiJHqlL
         YW6EmhhFLdnH3Wz652N0cmofMbcC1oF2kslgkZYfbuIfwHWcqhefktW522XSDQMbWBOQ
         1/n1RIA6BaDx1rMPzh5c5HaSqkvvaeKPdGphI1T5DLBk/fYIDO9bRQzqrOO5UtjlPOia
         R7yQ==
X-Gm-Message-State: AOAM5330+DP8hkj+SboZ9qOdXiMIlGeU2n5zy08byGpD3+vifpwHgoiv
        OIoXR+j1ErJ5+mFoyoGT4nc=
X-Google-Smtp-Source: ABdhPJyPZaWZhmEftwjIZNpESFxKpkKA8aFpNHgKO2srzDI3lGvnROkn2dDErjE2rjyHAthlHRo1AA==
X-Received: by 2002:a17:906:559:b0:6f3:8ba6:39c8 with SMTP id k25-20020a170906055900b006f38ba639c8mr14168185eja.486.1652094728074;
        Mon, 09 May 2022 04:12:08 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c24-20020aa7c758000000b0042617ba63b4sm6075672eds.62.2022.05.09.04.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:12:07 -0700 (PDT)
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
Subject: [PATCH v1 3/3] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight
Date:   Mon,  9 May 2022 13:11:26 +0200
Message-Id: <20220509111126.7032-4-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220509111126.7032-1-max.oss.09@gmail.com>
References: <20220509111126.7032-1-max.oss.09@gmail.com>
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

Also adapt the brightness steps as the backlight doesn't light up
for very low duty cycles.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index f0908b530f86..023e76215064 100644
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
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
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

