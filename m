Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9315283B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiEPMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbiEPMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:00:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFA167F2;
        Mon, 16 May 2022 04:59:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so28201158ejk.5;
        Mon, 16 May 2022 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3Sfbr8BAGz5vkKbSG+pjMvzfsn3wzmqZ9XE0VbkJng=;
        b=hCuA99+WFKizFSAmRMvXuFpJr3npywXJ5ksCBqmNpF0lcK8Bo01paM87G+oHCtcSDN
         OIC4WURy0WHw+1+fubR0AnTJAoRasQ81Bhb1QNKktUvHRsTWHEmiyhaVsrPOWWY3/kM0
         7YYt2dowFs2NUUNKNDkmWGK6EkD6e5MkxVUFscaN0N2xNpDxDCtxWSDvwvr6b08oJVuu
         mZX8x4kiniCgMerq0jSczUx929quHINsMyg+WjY28YiJBK8e7/WjssbTGxcTTXUxnEj9
         X3Tl/etF8noLL6rY7BiAusIxWLMVBZbnhfYFzciUwCMW/QIIQOCMUBJGaflmZv/AqEZj
         CL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3Sfbr8BAGz5vkKbSG+pjMvzfsn3wzmqZ9XE0VbkJng=;
        b=s+rww8HiU90uX3fpXpq7MsxZprGUU/4oFNiwE85SoPqbV9oOFD9gy3cClujSelcpXx
         eNbhGaKfJjqRFXtfLAypkb2PoOa+BNv4krPG2KFFuUJNhV9p4rW3ZK6EF4ubwnzJYMo2
         zDhw8JIkgHY/7lTGLLK+yLTYv53iZ+3udTIO2m60Z6QzTtwhKkAcgnIIcVHVvHj7eBQ8
         SsoqG6MjmDmvpstBkohiNKqR5SO1G34ZbJkNLmaaxb0wXm3/rAKwrSuBIenYa6AYBQ1F
         pKzFESwpxaiaf8RjOA+iLcSPWYpmEVMLKJ0sPfXY2ivRHAWCBpMUCSK1nUgrXfQ/byOP
         lflg==
X-Gm-Message-State: AOAM532A+m8CnozZVDc7+imYeOvKUnhk+zrNsliPz5UuqDLfmRQbwVgH
        y4TnwMCIte0XxbHV6BelAjs=
X-Google-Smtp-Source: ABdhPJyvdsOLJCqOHH35vJvbh6yIAu5csT122cVuiLOjstV7U09o6OXSfunH8tSONhKku/lEU7Q9Nw==
X-Received: by 2002:a17:907:1ca5:b0:6f4:b220:430b with SMTP id nb37-20020a1709071ca500b006f4b220430bmr15086120ejc.261.1652702377813;
        Mon, 16 May 2022 04:59:37 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:37 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/17] ARM: dts: imx6q-apalis: Clean-up sd card support
Date:   Mon, 16 May 2022 13:58:41 +0200
Message-Id: <20220516115846.58328-14-max.oss.09@gmail.com>
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

From: Denys Drozdov <denys.drozdov@toradex.com>

Configure SOM DTSI to 8-bit, card detect in the SoM dtsi as this is
the Apalis family default functionality.
Limit the interface to 4-bit only on the Ixora V1.1 carrier boards.

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 3 ---
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 1 -
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 3 ++-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 2436f9a1e18c..5c4d9a4ec586 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -172,9 +172,6 @@
 
 /* MMC1 */
 &usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_usdhc1_8bit &pinctrl_mmc_cd>;
-	cd-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index b254e96d194a..2d0324103804 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -175,7 +175,6 @@
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_mmc_cd>;
-	cd-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index f33dfaa907d7..57642aefe349 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -817,7 +817,8 @@
 /* MMC1 */
 &usdhc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_usdhc1_8bit>;
+	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_usdhc1_8bit &pinctrl_mmc_cd>;
+	cd-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
 	vqmmc-supply = <&reg_module_3v3>;
 	bus-width = <8>;
 	disable-wp;
-- 
2.20.1

