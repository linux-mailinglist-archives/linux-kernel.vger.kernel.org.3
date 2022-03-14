Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC374D8935
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiCNQcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbiCNQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8311A807;
        Mon, 14 Mar 2022 09:30:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p9so24863006wra.12;
        Mon, 14 Mar 2022 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BQc4OLG/fXKfwXIOJU2y/64eF1b0BRzKQ6czfrvnc0=;
        b=ZQAbFdrM8EX5U3VDL5EdlWNxlojepthplnVDHIIGI79L0tlXvQAKOKVi2s5xWjj9bS
         61J8v/tpkNeVzDhDRPupqm27GsCza4777Uf+ZD+DTmn+coUu6DV1brhxIReR0fKijRFP
         p8G+1pSyU3IsSCqvGhohW3NClb4Bw41UVjEc74RYz7qCcbuI8SG5oCRFfmqVtRmq1qvy
         aC+/VEX/kzd+3SvypUYqBDUMAaCl9rnC+MgVepThB0jR/I7GxIo4e/lU4THVEiE6szH/
         h5QtElto8Rf528cNdaVasQFs/J0gU+7vfcVDgB4RBZguXSRMxUMt+oVbRxrXDfOHPPGS
         nStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BQc4OLG/fXKfwXIOJU2y/64eF1b0BRzKQ6czfrvnc0=;
        b=C8Rwm8E+P6kP/7s0S0fo728B8LbSr1Kcs6Fyw9IxMOeekQUmKsWEg18dy2Fpietzlg
         rLlqR4YHsYFd7lmaCiWvKEKKBzjkfHMVQJ+Klk0ti9XaAWJzajnr1TSDc0bfwjxMmoWA
         K6hyOnH4nRBaXxZ86NouElJ+fqA2gxHxmp7WmZ/WH7l8J9eGAJP11Uc/uaVpCAXcL93k
         fWlGy3UziRboQzBukcGX/oKlmSSxBqkfWVFyroghRNWZqaYXtcAi+RSBXMTkTKKamgJZ
         u19cBDW4claeJNWFaT1eXuNyndl2KBfKQIlDLYpjy+qiTUeZmPnJJU95W2CJDB+8G5tk
         3GmQ==
X-Gm-Message-State: AOAM5308bLRD3JtTc+YvHgQRhgpgZ603SeghvQz6ZxAY/nLRfIS6g4Yu
        I1MHeqgS5+stS+MVwYY/kTM=
X-Google-Smtp-Source: ABdhPJz42yZOcArKLcysEgjWPOTJ5/YeaSZNHz68DrjZagWMxM+1CbmokJERc0A3ID6IRJf7D9A8UQ==
X-Received: by 2002:adf:d1eb:0:b0:203:9349:12b5 with SMTP id g11-20020adfd1eb000000b00203934912b5mr13604584wrd.285.1647275422428;
        Mon, 14 Mar 2022 09:30:22 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:22 -0700 (PDT)
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
Subject: [PATCH v1 08/14] ARM: dts: imx6dl-colibri: Add additional pingroups
Date:   Mon, 14 Mar 2022 17:29:52 +0100
Message-Id: <20220314162958.40361-9-max.krummenacher@toradex.com>
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

The Toradex board Iris V2 has an LVDS transceiver which is
configured with 4 signals. Add corresponding pins into the
separate pingroup to be able to manage the transceiver.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index da52a71bb6e7..3459bfb5c60b 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -700,6 +700,30 @@
 		>;
 	};
 
+	/* CSI pins used as GPIOs */
+	pinctrl_csi_gpio_1: csigpio1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D18__GPIO3_IO18   0x1b0b0
+			MX6QDL_PAD_EIM_A19__GPIO2_IO19   0x1b0b0
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29   0x130b0
+			MX6QDL_PAD_EIM_A23__GPIO6_IO06   0x1b0b0
+			MX6QDL_PAD_EIM_A20__GPIO2_IO18   0x1b0b0
+			MX6QDL_PAD_EIM_A17__GPIO2_IO21   0x1b0b0
+			MX6QDL_PAD_EIM_A18__GPIO2_IO20   0x1b0b0
+			MX6QDL_PAD_EIM_EB3__GPIO2_IO31   0x1b0b0
+			MX6QDL_PAD_EIM_D17__GPIO3_IO17   0x1b0b0
+			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0
+			MX6QDL_PAD_SD2_CMD__GPIO1_IO11   0x1b0b0
+			MX6QDL_PAD_SD2_DAT0__GPIO1_IO15  0x1b0b0
+		>;
+	};
+
+	pinctrl_csi_gpio_2: csigpio2grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A24__GPIO5_IO04   0x1b0b0
+		>;
+	};
+
 	pinctrl_ecspi4: ecspi4grp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D22__ECSPI4_MISO	0x100b1
@@ -739,6 +763,25 @@
 		>;
 	};
 
+	pinctrl_gpio_1: gpio1grp {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20     0x1b0b0
+			MX6QDL_PAD_EIM_D27__GPIO3_IO27      0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__GPIO1_IO23 0x1b0b0
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03     0x1b0b0
+			MX6QDL_PAD_NANDF_D4__GPIO2_IO04     0x1b0b0
+			MX6QDL_PAD_NANDF_D6__GPIO2_IO06     0x1b0b0
+			MX6QDL_PAD_SD4_DAT0__GPIO2_IO08     0x1b0b0
+			MX6QDL_PAD_SD4_DAT3__GPIO2_IO11     0x1b0b0
+		>;
+	};
+	pinctrl_gpio_2: gpio2grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07       0x1b0b0
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08       0x1b0b0
+		>;
+	};
+
 	pinctrl_gpio_bl_on: gpioblon {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x1b0b0
@@ -832,6 +875,15 @@
 		>;
 	};
 
+	pinctrl_lvds_transceiver: lvdstxgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_WAIT__GPIO5_IO00 0x03030 /* SODIMM  95 */
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07   0x0b030 /* SODIMM  55 */
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08   0x03030 /* SODIMM  63 */
+			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12 0x03030 /* SODIMM  99 */
+		>;
+	};
+
 	pinctrl_mic_gnd: gpiomicgnd {
 		fsl,pins = <
 			/* Controls Mic GND, PU or '1' pull Mic GND to GND */
-- 
2.20.1

