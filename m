Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B5854C7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347467AbiFOLvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbiFOLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E54C403;
        Wed, 15 Jun 2022 04:50:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so22725715ejx.3;
        Wed, 15 Jun 2022 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVB55DEg2bPk+Jun3avPAlytYLNNRhGqMzJbc0Lw+GQ=;
        b=MZVLOdCFSGgMG13oaCBG7RstHuIo08+WtxMPHblfkDD/Btj2afR4FoVA9HFEddTdF2
         cBGkfcEeIjTRXeGZcBdVuKMqnlQFaPLjixZBNVF3RwuJ9j2VYyYG4yEz+XjGpv56IO2B
         JxFqHS8oWjmKqbMH+1m2OfNwv/N5p5fvfMi6U4mt2mlh5JgDT2rV/+0qP2codJc7yk+v
         mkjVAk5PtaZiN7yHfwbXjzQlVQ5UjdVG6Q0/h0ofyOTzT9kIX4XaM0n0mEGrCg/tXJCH
         cD16MTJu5ACLIDDehaHoDhyzjb4S7Jt+JEKTpDUZIvto7p0uvb0E9OpXkhqfs6Ss56HW
         13Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVB55DEg2bPk+Jun3avPAlytYLNNRhGqMzJbc0Lw+GQ=;
        b=mUq+Dodo2sK3sD0+BJ+XlYx5is/J/3KtmS9ifCKa2ojhPBpSi3UgY8WzgmGrcF/rSp
         GMAPTxHy6DNLxLmYxBOPwKIVq5BsI3xsCayXraVT0Q9LoILD9zKJF3Wa4XFzqWPoXfQq
         k4KAOJW/EmQ0/MQXCIJYUb2PwCiyzuXeMrEE0l6QPxiATDXJO7whrywStF8s/Hot4gW5
         lVSlsa63P5dw4MsnRrnetzG99DYRX5XqY675q2Mpqj4astbHLH2WiMJSQPG7h+/YnDow
         OH6yboi5Z6eiTVYMt3qh5n78Ydmfan5TYSssy8KjeqNP8aro7ZtvGim5vUeH5Gz8Z5jf
         gZGg==
X-Gm-Message-State: AOAM53278Gfa/qa+FF5UVD/9I8J3mXO3s1U+p8njix7dB06eqrvOejmN
        hsXU6vdCreob1VatGQUwzeE=
X-Google-Smtp-Source: AGRyM1sHQrHOVNyibv+XTyKQRzzevxy8F2eT1fvSbkEFBB13kwwGjNp2Cw4QM+lQow7uNDWrJQ0Jbg==
X-Received: by 2002:a17:907:1ca3:b0:705:5a6c:d113 with SMTP id nb35-20020a1709071ca300b007055a6cd113mr8999375ejc.535.1655293853494;
        Wed, 15 Jun 2022 04:50:53 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:53 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/18] ARM: dts: imx6q-apalis: move gpio-keys to SoM dtsi
Date:   Wed, 15 Jun 2022 13:49:56 +0200
Message-Id: <20220615115006.45672-9-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Move gpio-keys to module-level device tree given it is standard Apalis
functionality.
Sort properties alphabetical.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6q-apalis-eval.dts  | 14 --------------
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 14 --------------
 arch/arm/boot/dts/imx6qdl-apalis.dtsi    | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 5985d1169be1..fdcb740a7a54 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -30,20 +30,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_keys>;
-
-		wakeup {
-			label = "Wake-Up";
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
 	reg_pcie_switch: regulator-pcie-switch {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie_switch";
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 6743617ad1c1..e6fc76776b2e 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -30,20 +30,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_keys>;
-
-		wakeup {
-			label = "Wake-Up";
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 3aa66b6d0c88..240783d0901c 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -29,6 +29,20 @@
 		status = "disabled";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
 	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
-- 
2.20.1

