Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07F4FC080
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbiDKPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347879AbiDKPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66B3BF97;
        Mon, 11 Apr 2022 08:22:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m33-20020a05600c3b2100b0038ec0218103so1084973wms.3;
        Mon, 11 Apr 2022 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4FQ/g2a7t4LgRUrQCaryqfylWafOYzKE+/XNS73Ii4=;
        b=ft4h9ejO3oGXDuFtLP5ILuctXYSPUU/Po68S0lbU+8oN6h71t0BJwhrW3Y4K7fLx9A
         VzwHlJQ8Xn0vijNYPcEL48zBGpU41kLPnIWxNBmqy8vw6A1TtQgnyi0Z0scOY1nHfJwp
         brXJBzMe7ivrO6MSKq3Cs4Ih0T5sVVx7Nao21hIjH3YOlQeFUJgsH4bZcFIEH6VbJNmw
         8grLRo67pLfitCXWmOkQIFivImlYGdbOi78gOlJO34VJ2PYIt+tYiOzkbRDH20RyHd02
         ihGQ+E7l0osyHtn4zLD0M7ap/LqG03iKaMexG22Ucjqb5ASGVnGNwYUOtA2cPk2JnJ50
         eyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4FQ/g2a7t4LgRUrQCaryqfylWafOYzKE+/XNS73Ii4=;
        b=axTZffbNP1zahVgp8sZUXQTsroKyCA1Y7eYVR/5GLmj44OAT470whvxfc1DTGww6G2
         H3ROoRffR/lwbuW2v1AakPCyaskSBhf3zrozN/Gak2pm4UjxJFTTVw3EpioEXnWFUyXs
         XKYY8R8WP3kNw0Dj2TSCrAwN5EcsKRRW+PUUfhGTsD/vPkPT+1VnU7ZQ+Uo6JWYzc4do
         FyDbQyWKS/1Hig58CpsoCWyrypDc/dmq5UfE+nvTDyPfGn4pdMlvNRq4oq/fTmU/hrmE
         ffvNIQTk3gFHQGTRoDSTOVyzCs1l69W1TzUSjgJcFl5Gp6bI2aTK+a39c46hkVWaA+r+
         36QQ==
X-Gm-Message-State: AOAM533W9vwd5sd5wBPrMi4NIHMV08bPDKUYwK5AeCDmZOpBA5ig598C
        66wCk4RVSzuigcmpZ4sVTAw=
X-Google-Smtp-Source: ABdhPJxJkaIeEm4rZC28A4TpZi8/G9oNkvqRjo0I+csDS0BxgCKeoo+aXCM6wm2pWeaZrb2zAqImXw==
X-Received: by 2002:a05:600c:3547:b0:38c:92a6:5a17 with SMTP id i7-20020a05600c354700b0038c92a65a17mr29740316wmq.20.1649690571320;
        Mon, 11 Apr 2022 08:22:51 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:50 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] ARM: dts: imx6dl-colibri: Fix I2C pinmuxing
Date:   Mon, 11 Apr 2022 17:22:24 +0200
Message-Id: <20220411152234.12678-5-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
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

Fix names of extra pingroup node and property for gpio bus recovery.
Without the change i2c2 is not functional.
Fixes: 56f0df6b6b58 ("ARM: dts: imx*(colibri|apalis): add missing
recovery modes to i2c")

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 16d38bc78b2a..c6112b1bffd4 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Copyright 2014-2020 Toradex
+ * Copyright 2014-2022 Toradex
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  */
@@ -132,7 +132,7 @@
 	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
-	pinctrl-0 = <&pinctrl_i2c2_gpio>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
 	scl-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio3 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
@@ -491,7 +491,7 @@
 		>;
 	};
 
-	pinctrl_i2c2_gpio: i2c2grp {
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x4001b8b1
 			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x4001b8b1
-- 
2.20.1

