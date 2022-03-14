Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0754D892F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiCNQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243026AbiCNQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1C1F62A;
        Mon, 14 Mar 2022 09:30:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q20so9652192wmq.1;
        Mon, 14 Mar 2022 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7sn1A5Ozuehi07ptHlZt0U+bEDDAJG/k0sZ11rW7VA=;
        b=ha9K5e4RMjA2n83eAlkQwmiyQ03oTOZ/G3gMHrfi2TfD1gKrUnT5eKplz1j6yObapK
         DHmPHgxuQjt/F31S4IVQKmqLgVeZS24rBLwyHoo8lEwLq+KoA3lNb0Jtdtnge7JGj53c
         6KgBArpuvS4plBKuUJe5Y2DK5BcjywzF2qdsyaXYTO6nweZPKLqvXyi8StpPiOmwxvJG
         xQdNv3gpfS+y9Qy2+PjGPFwun2WVahwTTxSkdcj03KKRHC/PXS0sy4fep/XEN0M6ZdcE
         ZeYivgqdlI7bQqg3ZO0r1/o8Op8RqVhcKBHIS2yKCOHbLeBmyNhaJNZIUmOBDzl9u7ml
         R40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7sn1A5Ozuehi07ptHlZt0U+bEDDAJG/k0sZ11rW7VA=;
        b=jdn54lm5hpAvgJ6KeDbaWN3g3NX2q4UG2MuYliquh4cZlKERtkqKwcvVrbmO+RQA2V
         PEuy/UqjXnHct593z9JQA1zoKgqhp566Ynt2nRexibN79lVYkPGrX3XJacT9JB66VgAD
         fsA01O3weW1H47CM5DX/PbfKQhbIZvWOsdbMdL05ewm9bk6uUiHOC13DZfJLYk6VELpN
         5Pga2ouLW1/MWLVRqSoOLuWWbc6Hvx2ptjnhv0P1GMu27tqakaioEQ/ME3bH/YviGpdZ
         0UemaQ1LxQ/TSq072TwrmP1/CDekdS/U33iUtlGjfqRT1H/LmNuB2S2wvD/1J0h/S/xu
         iWvA==
X-Gm-Message-State: AOAM530viR7ViDgWQdjkysH3JgpMAj3fdYDBvXkVueOAyAnkNIRj5/2d
        yLaWguaarC+GYVbVqBxBxak=
X-Google-Smtp-Source: ABdhPJwAV+cOtsNQjo0fNzZI0Hh6k7GzMgJkaVZJ4u03DN68L7VD0Mif6uOiiq0bdwnCSpGEpt6vFA==
X-Received: by 2002:a05:600c:4fd0:b0:389:dfc0:445e with SMTP id o16-20020a05600c4fd000b00389dfc0445emr39198wmq.68.1647275425218;
        Mon, 14 Mar 2022 09:30:25 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:24 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/14] ARM: dts: imx6dl-colibri: Add usdhc1 sleep pin configuration
Date:   Mon, 14 Mar 2022 17:29:55 +0100
Message-Id: <20220314162958.40361-12-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314162958.40361-1-max.krummenacher@toradex.com>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
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

The Toradex board Iris V2 has a SD-card slot with switchable
power.
Add a pinctrl sleep used when the card power is off to avoid
backfeeding to the card and add the "sleep" pinctrl to the
usdhc1 controller.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 1c3c34bbfe98..c383e0e4110c 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -680,10 +680,11 @@
 	bus-width = <4>;
 	no-1-8-v;
 	disable-wp;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
+	pinctrl-3 = <&pinctrl_usdhc1_sleep &pinctrl_mmc_cd_sleep>;
 	vmmc-supply = <&reg_module_3v3>;
 	vqmmc-supply = <&vgen3_reg>;
 	status = "disabled";
@@ -951,6 +952,12 @@
 		>;
 	};
 
+	pinctrl_mmc_cd_sleep: mmccdslpgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05	0x0
+		>;
+	};
+
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b1
@@ -1097,6 +1104,18 @@
 		>;
 	};
 
+	/* avoid backfeeding with removed card power */
+	pinctrl_usdhc1_sleep: usdhc1sleepgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x3000
+			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x3000
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x3000
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x3000
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x3000
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x3000
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
-- 
2.20.1

