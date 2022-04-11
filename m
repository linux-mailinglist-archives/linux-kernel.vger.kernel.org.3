Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952AF4FC08D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbiDKP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347908AbiDKPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5323C487;
        Mon, 11 Apr 2022 08:22:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b19so23517703wrh.11;
        Mon, 11 Apr 2022 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W70bMf1Ky2O8ngTc5hq7tyZ3VFa4hjG98xIoYgkJB40=;
        b=kkOto/2thn4dB/SOAQnrjLL2oePLHVjQgqP2iD6e4ZUfo6mF+PE380kKmq2+6nAM0H
         AYWnEcZ1D94GCV011vy4BXLxVv1Zxi8982SBuXoY5C7l1QEtV5uqrT1ONCKhWmnVnuIc
         ODxPh5lY+OGyOHEy0fdhgU0TdVNmIaEDaCx3Bnj7kEOs3JVv+VzV3YkdpHUW2O46+PvU
         YWsu6J0cf8pLjbVwtlYOi6HSFJ50WRO3UB7qyaeajK3FvYMEY59hvlvuYynHEa1pN0qI
         hA7kDSdFd9grzI+nZZk6av/ZGrEfkx+78TrATdk9Exh+zxfOPUFudwwUUkBpccmEpUwc
         t6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W70bMf1Ky2O8ngTc5hq7tyZ3VFa4hjG98xIoYgkJB40=;
        b=GWktGq0dkiR41LBq6e+UsCV8BYH9mBu4XUneAebJlEGAtNOz5Bg9xzKfRE9oAe6KzG
         vV8e1Mhgqhu3lYSlHTXtyxo3L56XCefw2gtETjhQz+K8qAM+5IAmvoTcmbK2X3IgtpPv
         tFQy217Ou9A+DzREgJalSSOIBsS2ROdTN5XwkvMC20nhSvX18IhFmUvIbNDnEBbwEoLw
         RE0CaJdEVU3EbHE2Go7qcbyzuw8Dj3GN8+KqK/qfA+UY4GhIPoRGJq3PaMtmB3dhNqoF
         eHRx/e4sK1r6FLAMI6vXv3VgIHnsjydzlKOTeduSf+B3+4jgfWa8mY0bTolPVgIFROPy
         bk6g==
X-Gm-Message-State: AOAM530+kgm0XywvCxan4p4BtDW8KrnMB8CFE3hVfFw8PFyyiruExGkb
        Swnl/JrJ8HGILZyfJodkXys=
X-Google-Smtp-Source: ABdhPJxD0md7ffzoBIiNS+vnYzG4eW9I7TLKF3hDG9tPy7dBiZzYf1OcMru1OIuaaHx8DvuZXzYtXw==
X-Received: by 2002:a5d:64e5:0:b0:205:9cf8:b552 with SMTP id g5-20020a5d64e5000000b002059cf8b552mr24007147wri.52.1649690575304;
        Mon, 11 Apr 2022 08:22:55 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:54 -0700 (PDT)
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
Subject: [PATCH v2 08/14] ARM: dts: imx6dl-colibri: Add additional pingroups
Date:   Mon, 11 Apr 2022 17:22:28 +0200
Message-Id: <20220411152234.12678-9-max.oss.09@gmail.com>
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

The Toradex board Iris V2 has an LVDS transceiver which is
configured with 4 signals. Add corresponding pins into the
separate pingroup to be able to manage the transceiver.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

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

