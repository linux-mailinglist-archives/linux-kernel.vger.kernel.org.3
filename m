Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828954C7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348205AbiFOLvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347300AbiFOLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE54C4AE32;
        Wed, 15 Jun 2022 04:51:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 25so15703736edw.8;
        Wed, 15 Jun 2022 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlGiQlFBs9Y0ysQYN1E7ZEh7FdwsGrUOirxOgzSRDic=;
        b=Vh83g9Cg69Mzkod0rYD8INfjqhWynhwdmyIH2T2drWRXicHIm/Zg3YGG63d+leBafL
         xGaw+JmzVLzue115lu70DpqHF1CLGbhXOx/nvqSZbow8rBBYkHMPawqsD1fZF0p4kx5E
         rNic7d5yTG//oHbSSw7kIT9wNHBMKfBTijhE54NWL2Maz5qbfTximhYTVn2CmNdPjf1n
         Rmu6DADdiUO3H6dp777yOpitN+1h5LKQCn15jN1vQ2NRrXZ4qBoGHJfSjCN/ckwiBRaP
         kUQ4Vtthc5kfFl2hpT+mBhwBQRsA2rO/U+7fFmlWowevA6sHVL8WSeh3LXMLQf/ielYw
         sj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlGiQlFBs9Y0ysQYN1E7ZEh7FdwsGrUOirxOgzSRDic=;
        b=NaxT/iMYg7VMTenz0BYG30yDUSQMhHyisCFK6ufUQoKzSkJqtp5wCF2ZalZNoiwkZc
         ftcX5deaoGxgq613y/A6Ez6ZSbPuC6+o+yPyIGIKtSa1n8vCnDbjPPgdf7QHwStPIf4m
         GpwSW4Uek9SgbpzLcCeHvb7Ul8kVJza7yfEUFnGdnQ9hHfSr5PsoMDxm8O9xZJB+sZSJ
         5455uxS7J/iOQkdhNRMBZY+ylRpsa86g8HLj9PMDDOkkw8C7c48UySTMVmkHF6HjK2Bd
         zPdOoGV+QYo8nCGx+eTPO/xU/Vxm1ONQd6VIKxktEe3fMXPS8GP+CljvhTR2oPhzpxSL
         q80Q==
X-Gm-Message-State: AOAM530HSTmBXckzT4/Bn00aRbhReOakuP8M3MxAk4rZXpWr9DbpbdUy
        nErm46mPAlB0AV8PKCtqwiFwavidOV51+w==
X-Google-Smtp-Source: ABdhPJz9S9PWBAk8rH7sYkTGOj+ge72aDAqj13TtYIlCQj7iYKKydxgnkmOGK52xGlgpxS2z7m+aHA==
X-Received: by 2002:a05:6402:40c6:b0:42f:9ff8:62f8 with SMTP id z6-20020a05640240c600b0042f9ff862f8mr12180177edb.95.1655293864380;
        Wed, 15 Jun 2022 04:51:04 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:51:03 -0700 (PDT)
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
Subject: [PATCH v2 17/18] ARM: dts: imx6q-apalis: backlight pwm: Adapt brightness steps
Date:   Wed, 15 Jun 2022 13:50:05 +0200
Message-Id: <20220615115006.45672-18-max.oss.09@gmail.com>
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

Adapt the brightness steps as the backlight doesn't light up
for very low duty cycles.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index c134e71f2a09..1144e4d106f0 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -20,8 +20,8 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
 		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-- 
2.20.1

