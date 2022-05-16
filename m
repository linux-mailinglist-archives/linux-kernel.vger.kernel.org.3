Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0155283B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbiEPMAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiEPL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1964715FCE;
        Mon, 16 May 2022 04:59:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id tk15so4685667ejc.6;
        Mon, 16 May 2022 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk+Al3GhpVx5YnHdlxIQSiRQjppttTaoPkIXQqKosHE=;
        b=MwShmOxoYa0ud8MhJ0NOSqRZ0X6ErVSIQhCK4u/i0r1M1PWmYQYxw3bb9scmXjtLOn
         QpUoAnvoNsA7XDVffaXiR5y6SnzhxiCh5n/bCT8CGkCqiQEDJzzMyE4F1FGzfoH541Dj
         anpBu3nzp/hOJ0rugwRES6jYaINHfj5CSF0GpWyNAyqQrVa54xJgyaggPjVvO0Cc/qiT
         aXU9oXiYR1YV7VqvDH5vfWkp5EA7F5vw44Ots1Y1/DT4TkpWhSZ7hjrMF0ASMKFshlBD
         Oz+2kk5vcjjJC+t+19KqfAFXoeetpLYvPH2X3aG+Zcos0XT+3sdmu34kirMMxzlUg10U
         oqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk+Al3GhpVx5YnHdlxIQSiRQjppttTaoPkIXQqKosHE=;
        b=1phZgIj+mfMJ+uZI0NYMJFGmOLeB+4BQqBDwiAPlIPNRWWxBi08TSMOx+OWiNy029I
         7mKzprufgz/xgm5q+gQK7nkyhmuFVFzwQ0w+er3neXG4z96XImO9zjE0t+DmsFLzfv4S
         29jDbPXD3PuQg6JBh0H5j3HfOBQbQjN9wYFAPCTnjuRDeFyCoCP6E0bBfxMkU9y0jGn4
         TjJs7xE3UNjZGo9YsSgwKXwlCu9ZWs7EGMtRduTMrQ6MxxGkL4JELw9dp/9QsNkwLm/E
         2Sa5ql9Cb63XWMrHUlzgKFdgfH8dU6IrmG7EQPDVPDt86a7BobY37QyPsIo/nKMAyuMi
         FMgw==
X-Gm-Message-State: AOAM531VRuJYCRhOjMHVPX82HzTN0hJaMtp9DULj0jpMtlMnbQu5GFjQ
        5Y92zdqn4yw6SO8YXflHowPn0rWCNpo=
X-Google-Smtp-Source: ABdhPJzpRcXV4iJUcMwBSRRFb2kS/v+knGeN0ueBE0f3EzuoxkNiKtYs5eBBHfhqMIFojNbojaAgIQ==
X-Received: by 2002:a17:907:3f16:b0:6f4:c54:2700 with SMTP id hq22-20020a1709073f1600b006f40c542700mr14812849ejc.615.1652702368590;
        Mon, 16 May 2022 04:59:28 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:28 -0700 (PDT)
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
Subject: [PATCH v1 07/17] ARM: dts: imx6q-apalis: Move Atmel MXT touch ctrl to SoM dtsi
Date:   Mon, 16 May 2022 13:58:35 +0200
Message-Id: <20220516115846.58328-8-max.oss.09@gmail.com>
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

Reduces code duplication. While at it drop the comments which do not
apply on Apalis iMX6 but add the correct SoM pin names.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 13 -------------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 13 -------------
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 13 -------------
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 11 +++++++++++
 4 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index fe5d491e1399..5985d1169be1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -82,19 +82,6 @@
 &i2c1 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		reg = <0x4a>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>; /* SODIMM 13 */
-		status = "disabled";
-	};
-
 	pcie-switch@58 {
 		compatible = "plx,pex8605";
 		reg = <0x58>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 8febfc0aea93..21f88e19e87d 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -89,19 +89,6 @@
 &i2c1 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		reg = <0x4a>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>; /* SODIMM 13 */
-		status = "disabled";
-	};
-
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible = "st,m41t0";
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 78cf1d9583c1..6743617ad1c1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -88,19 +88,6 @@
 &i2c1 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		reg = <0x4a>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>; /* SODIMM 13 */
-		status = "disabled";
-	};
-
 	eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 9413c14ce5f6..3aa66b6d0c88 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -416,6 +416,17 @@
 	scl-gpios = <&gpio5 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
+
+	atmel_mxt_ts: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		/* These GPIOs are muxed with the iomuxc node */
+		interrupt-parent = <&gpio6>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;	/* MXM3_11 */
+		reg = <0x4a>;
+		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>;	/* MXM3_13 */
+		status = "disabled";
+	};
+
 };
 
 /*
-- 
2.20.1

