Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0970B54C7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347673AbiFOLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347248AbiFOLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8184F1F7;
        Wed, 15 Jun 2022 04:51:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so22725715ejx.3;
        Wed, 15 Jun 2022 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hG0DQrrpzmf9pK0gpz+otWlL1eUOYhl7swC6XNn6u3Y=;
        b=TvI48J5Y9XPIJ7/pmfaUV+mPUivD0/X0C1W+6tVLYxiVx8EHhs8ztVAdra6t3ef4xi
         wOXijsGvskxYvyPjSkNqgwtZA/oasUeJa9p2UUvqvaQfv+B56QEWyEtmvEvuEiIwbmln
         dQh8cv7So0S0Z/6YR2AjxMceXUETP4AL/KlA3dR4ZWRcizZeYgxJWNgHK+hITZAcjhPl
         aMOYgqQn7ok+CyPbE8FLlskKr5cZE63PWxVHTYrPJclwyjME4ZyoXzf5JU5XvTvzOQ/4
         5oDLYKJiGIhUjfmWIGK0DjZpBrFUs6WiAG0k3lwWDIkZfTRUi2yUdRl99+HhbLszFUnH
         oVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hG0DQrrpzmf9pK0gpz+otWlL1eUOYhl7swC6XNn6u3Y=;
        b=CRQbGWxB3nUT+rhJUlFTpeTuEGugxHDVqJHwh02K+OrumJN5sqC0BTlmBaSlKSYHbP
         x5l227YhG5eR6BBOM2xOMORJIlYZfDV8jYxRJyVb0k6cam1PUPNK29wdVU84HH6kwAbf
         Cz8irNuBD5OTWEuA6UZLLvRSzMSWhPQrAW4545VgKr0WTvSDS2tAHii6ONPm3FF2+PHU
         HKiKJHdTWCL2Ey8tvKJSvJMFoUq7S1OIfCQB/gWIL63MO9VQ732hyVFijsDSJdj2b6dE
         P9RkzXc5Ep4Pic6+6mWChYmeM4Xcii59wOI0ewMFUjT2SvnVvZkyNLExppsSUyEP3m26
         hZfw==
X-Gm-Message-State: AOAM531VmLMbxLprwu6NG5eNFEXO8xQOLGMVysBvFV0e0UshPzCaVYT+
        FRysIMei8ETHUmgKQWUJOng=
X-Google-Smtp-Source: ABdhPJxJav8egmgVGQfvwcuVGKlHqlncBGrHi9htRZb+7ISkG3FS6UxcPQrrfBXt5LALzOvVII6ZXw==
X-Received: by 2002:a17:906:3c07:b0:718:e1a7:b834 with SMTP id h7-20020a1709063c0700b00718e1a7b834mr4802775ejg.635.1655293860677;
        Wed, 15 Jun 2022 04:51:00 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:51:00 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/18] ARM: dts: imx6q-apalis: Clean-up sd card support
Date:   Wed, 15 Jun 2022 13:50:02 +0200
Message-Id: <20220615115006.45672-15-max.oss.09@gmail.com>
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

From: Denys Drozdov <denys.drozdov@toradex.com>

Configure SOM DTSI to 8-bit, card detect in the SoM dtsi as this is
the Apalis family default functionality.
Limit the interface to 4-bit only on the Ixora V1.1 carrier boards.

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 3 ---
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 1 -
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 3 ++-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index eeb20d7a637d..19aaffd71f3d 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -158,9 +158,6 @@
 
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
index 6d072aa87952..4ff46ffd2300 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -832,7 +832,8 @@
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

