Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA285A955D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiIALEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiIALEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:04:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69871321F2;
        Thu,  1 Sep 2022 04:04:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso1214811wmq.1;
        Thu, 01 Sep 2022 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=hYO6m08D1m77fS4bLwKWIIJPEfZsg+AkhNMU05CQppg=;
        b=p0BWuO8iIXuIn25OJFE7kgCWFMDzefwMBnzQ/IuGJm7vW05X7pmTXi/OfpZaK2UjTR
         wGJchy3V5lczXEbUb6fhgnjlA+OcCSVEy59H/cZXNOI1SFHRZxYtL7WYLozgNDSkKKS5
         4JDnB1R1xGufOrJJjw0q91s8oD+5rHvip85JEcnkms/WASs3/P0brAZNIJ2gYlcvIzm0
         0UqawjA7xEaweohkcwewcUDhAXPxbllYs8JwvSDVfIu/lc3xObYi0wsurj3jPOMFxvFR
         ZAFyXuqe9apoxJmMyBEJ26UO9NhfJfjMGkum1lDrvv4JFQt6e+ScDJlzmT91DZ71Tjsq
         9x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hYO6m08D1m77fS4bLwKWIIJPEfZsg+AkhNMU05CQppg=;
        b=TMeZO53Hybdwva2JPNn/D1qQaJNfeZDyJX/YKqhZy0VIKxel71fVIo0lRJ+Rrl/SCQ
         yeT0cg/8vVA7WbUdZtsp5CGbXsEuIFfJ5qO8Tzn9yTIsNcjrUc7KA7ocvcgAieXKnoXT
         Fy9Df2zEUVgMoAVsENfGewdhM1TypoPZoxeUoEj4z8X8JPtsIfsbt9soVis0k/NY2wlK
         al9q4rfLzhNAxCrktxEfM9IElRYfX2udjmBKJpRKtS0oFD17r6WCTBso/gByAg2moeoi
         L6ustOF7qy1J7cGhTl4GDach3P+CLytBNMDwKwX6ttNc0CZQvXIIHC8rC95V+gjIemQe
         ZrMA==
X-Gm-Message-State: ACgBeo11eAW7i72pC3uTZlJ8Jwr55QgNj6c+tMnCmyU+sJtY9/cx9gL+
        kpYGMwOa5ZT5ztVSsmM0i24=
X-Google-Smtp-Source: AA6agR7t5nnSC6OuTNZedRbMPFLa6/MLr9nye3O9jkrmqUr5CvdkflXoRFV0WntgD6tZqOZjICrrzA==
X-Received: by 2002:a05:600c:22d2:b0:3a8:3e8c:d914 with SMTP id 18-20020a05600c22d200b003a83e8cd914mr4769300wmg.128.1662030280200;
        Thu, 01 Sep 2022 04:04:40 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003a5c75bd36fsm5315636wms.10.2022.09.01.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 04:04:39 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-verdin: board regulators: add always-on
Date:   Thu,  1 Sep 2022 13:04:22 +0200
Message-Id: <20220901110422.1859621-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.35.3
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

These regulators are switched on by HW during power up and can not
be influenced by SW.
Set the always-on property.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 557cfef8f049..76cc89296150 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -62,6 +62,7 @@ button-wakeup {
 	/* Carrier Board Supplies */
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
+		regulator-always-on;
 		regulator-max-microvolt = <1800000>;
 		regulator-min-microvolt = <1800000>;
 		regulator-name = "+V1.8_SW";
@@ -69,6 +70,7 @@ reg_1p8v: regulator-1p8v {
 
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
+		regulator-always-on;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "+V3.3_SW";
@@ -76,6 +78,7 @@ reg_3p3v: regulator-3p3v {
 
 	reg_5p0v: regulator-5p0v {
 		compatible = "regulator-fixed";
+		regulator-always-on;
 		regulator-max-microvolt = <5000000>;
 		regulator-min-microvolt = <5000000>;
 		regulator-name = "+V5_SW";
-- 
2.35.3

