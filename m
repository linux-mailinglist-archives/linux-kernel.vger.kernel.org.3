Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1A5665BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiGEJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGEI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:59:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629913EA5;
        Tue,  5 Jul 2022 01:58:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so16534844wrd.8;
        Tue, 05 Jul 2022 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vk3XdzmxOZuQX0X0Z6lMmqAn6GT0lpJyIL575BVtaGI=;
        b=VJvXZ3rpFPUdQyfNiF+cSDsuTwRaAPFg6qME/h+d2kQWm9kQVVolCtWpzxbLaHzPrX
         SidADnmqdwAYM6NlDYHb3DAgG2NveV8a2uMnO716wlBymk+LUkzXts/6/13OPuknpXCa
         acsDveGGuEevSLsJGA+x3ft0HcIx9W5akWGkWVsfrCRWZ3YQXc80W8YKjVRzJ6Cv0ITQ
         55zu7IwjZMp2+AeBTTbPITXRBhfQDkf7W7WK7CtJM9RTRrU2T9oXiMj74bWWp/Q/sGZd
         UpcmmQCvJ4XKlj+mBTTdHtnsyUMr+DE1IfXcrer3qbJwiPvoxsHvX8BKteCAqwh8Nnxu
         /1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vk3XdzmxOZuQX0X0Z6lMmqAn6GT0lpJyIL575BVtaGI=;
        b=Z6VRLrCqE6jQgtei0Q2AkHzkCBz851oI8kVG1E+NB++9R6ozDUIR1oAnRBio889JjB
         jqpI/tpN+7pIZJhWBjAFMczCUJciekvdKg+2Nt/JE+aOgvcQOMKWg4vvPrr4dMO5DMzr
         7+gFf76nmB1E7F+oSmkKX25+wSdgr1R03baOe2wl9G/afkHi48vjHaNIs7wW7Y7dgfFz
         ftv9Mlpc3VRE/t1yXN/x5SZ1FsMYAbhjt7xl+TKsWBqzO5isizUBFY3+TKO1u8TGcUs2
         Vl83seN3zXJHTaqE975F2uvXb62L7yQyhRmr6sgsgt4T96SWvOU/Ty2L+zzDxuIQGmx1
         g82Q==
X-Gm-Message-State: AJIora+7cmReidf6oSSPVZ+ZK0jsYdZoVu9Cdiq/SoRIUPmbEriCI5oh
        lIP9+R9sdwT2whqJQuic1QSBAAB0rSU=
X-Google-Smtp-Source: AGRyM1uFtZJgxb7pIDxo5NVWNteuQ5ccm6KEylFZ2mugvloXx5fSiP0U7ovYfO99/NaN3pBx6LmwTA==
X-Received: by 2002:adf:d1c2:0:b0:21b:e465:1e36 with SMTP id b2-20020adfd1c2000000b0021be4651e36mr32397699wrd.271.1657011520750;
        Tue, 05 Jul 2022 01:58:40 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm39924763wro.54.2022.07.05.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:58:40 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: colibri-imx6ull: fix snvs pinmux group
Date:   Tue,  5 Jul 2022 10:58:24 +0200
Message-Id: <20220705085825.21255-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
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

A pin controlled by the iomuxc-snvs pin controller must be
specified under the dtb's iomuxc-snvs node.

Move the one and only pin of that category from the iomuxc node
and set the pinctrl-0 using it accordingly.

Fixes: 2aa9d6201949 ("ARM: dts: imx6ull-colibri: add touchscreen device nodes")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 623bb7585ad1..577a424b0e1d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -165,7 +165,7 @@
 	atmel_mxt_ts: touchscreen@4a {
 		compatible = "atmel,maxtouch";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_atmel_conn>;
+		pinctrl-0 = <&pinctrl_atmel_conn &pinctrl_atmel_snvs_conn>;
 		reg = <0x4a>;
 		interrupt-parent = <&gpio5>;
 		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;       /* SODIMM 107 / INT */
@@ -330,7 +330,6 @@
 	pinctrl_atmel_conn: atmelconngrp {
 		fsl,pins = <
 			MX6UL_PAD_JTAG_MOD__GPIO1_IO10          0xb0a0  /* SODIMM 106 */
-			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04     0xb0a0	/* SODIMM 107 */
 		>;
 	};
 
@@ -683,6 +682,12 @@
 };
 
 &iomuxc_snvs {
+	pinctrl_atmel_snvs_conn: atmelsnvsconngrp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04     0xb0a0	/* SODIMM 107 */
+		>;
+	};
+
 	pinctrl_snvs_gpio1: snvsgpio1grp {
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x110a0	/* SODIMM 93 */
-- 
2.20.1

