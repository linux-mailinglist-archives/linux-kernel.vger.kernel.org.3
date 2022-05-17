Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A88529832
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbiEQD3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiEQD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:28:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD246675;
        Mon, 16 May 2022 20:28:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s22so7831783qta.0;
        Mon, 16 May 2022 20:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9TCAH2X5KiZ5cE3KeOnKqp/d+7QP/7SQUkUYYFMkBM=;
        b=onNws3ojGjpISsTxBlp5naMm+Y80K8lY+CnvJHrvxs/nb3RX3wau3jNBK3AdtyvQR+
         c7d69M8V27AzT4Wd9tykRYPp2zx/R1mWgDJvRl0bt1jF8cmOU2mf/Xtq/UgoFIyA1UjR
         x54Ft2l0cttqOcLq8ovFrH705LRJPLFj/cUSABBI6+XqKV3LwMG6MxsCwh0xgMiYQePU
         tDIsdv4ftDbXhkfXEl6+f4MiZoxK+qYYq6E8/Bjpsf0SA0Ys0smYkUSY/66TquiP6Yc+
         R2CiywpKFT9rPYVDP4I3IGMQzRZ/XqHJo4/wWqDMtsmDBgZejnvKFG2iyIaDemBdvV6T
         7jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9TCAH2X5KiZ5cE3KeOnKqp/d+7QP/7SQUkUYYFMkBM=;
        b=UgHVPBDsD0t6qqKShkdpOiNjOEox+N3NL6f6Rx0xVKVHFqB1TFXPo819RemzWmF3z3
         D4vVLE+Z+PHVVz0/gjkblsboSAYdmL16Lnw0IdlNk5uikghfYMQ6+ieIdTDIDs4K279e
         mhVJxchJY+cEcKSNHZyr40B7abkpsZFa9wLS9WI83mJgqyhuaY8C2+M8Q4VhP5M6ea42
         l8+gGf7NKYT0ZlhrVh0BDoWpxeuXKuDZBoJo3ip2Kc3mj4NDdB2iQI2/M0Kyihkf7d2Z
         0N4vA5732FKzVLcD4jqAn4Z53uDlttHcJ7dYfiZ2UT6fnGXjR6hWDTJobsUci0ACa7hy
         FRsA==
X-Gm-Message-State: AOAM531FkwnhjIOmG5WFdatDmCy/lh4GfCpm5Ssve6gCdoC/ynI5Ii5R
        co11s7QP4o5LbirafiPELwI=
X-Google-Smtp-Source: ABdhPJwcUcDLZdjJ2Wyz4OgSCBbw0W5A4x51WHa9WuZpGN8QStrCQ63nLuZY63BzjmU1I/7agZ2cTQ==
X-Received: by 2002:a05:622a:1a18:b0:2f3:d6f8:5b43 with SMTP id f24-20020a05622a1a1800b002f3d6f85b43mr18065929qtb.660.1652758100523;
        Mon, 16 May 2022 20:28:20 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id a19-20020a376613000000b006a098381abcsm7079535qkc.114.2022.05.16.20.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:28:19 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 11/15] clk: imx: Add initial support for i.MXRT1170 clock driver
Date:   Mon, 16 May 2022 23:27:58 -0400
Message-Id: <20220517032802.451743-10-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
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

Add clock driver support for i.MXRT1170.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Add slab.h and clock-provider.h
 - Add spaces in `root_clocks`
 - Expand and sort macro
 - Move `clk_hw` structs to `clocks_probe`
 - Remove of_irq.h
 - Remove unused code/comments
V2 -> V3:
 - Expand root_clocks names array
 - Remove root_clock_names enum
---
 drivers/clk/imx/Kconfig         |   7 +
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-imxrt1170.c | 451 ++++++++++++++++++++++++++++++++
 3 files changed, 459 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imxrt1170.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 25785ec9c276..704a7777af4f 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -119,3 +119,10 @@ config CLK_IMXRT1050
 	select MXC_CLK
 	help
 	    Build the driver for i.MXRT1050 CCM Clock Driver
+
+config CLK_IMXRT1170
+	tristate "IMXRT1170 CCM Clock Driver"
+	depends on SOC_IMXRT
+	select MXC_CLK
+	help
+	    Build the driver for i.MXRT1170 CCM Clock Driver
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 88b9b9285d22..d607a6d8138a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -52,4 +52,5 @@ obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_CLK_IMXRT1050)  += clk-imxrt1050.o
+obj-$(CONFIG_CLK_IMXRT1170)  += clk-imxrt1170.o
 obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
new file mode 100644
index 000000000000..d3a9293d22a4
--- /dev/null
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2022
+ * Author(s):
+ * Jesse Taube <Mr.Bossman075@gmail.com>
+ */
+#include <linux/clk.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/imxrt1170-clock.h>
+
+#include "clk.h"
+
+#define CLOCK_MUX_DEFAULT "rcosc48M_div2", "osc", "rcosc400M", "rcosc16M"
+
+#define LPCG_GATE(gate) (0x6000 + (gate * 0x20))
+
+static const char * const m7_sels[] = { CLOCK_MUX_DEFAULT, "pll_arm", "pll1_sys", "pll3_sys", "pll_video" };
+static const char * const m4_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5" };
+static const char * const bus_sels[] = { CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const bus_lpsr_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5" };
+static const char * const semc_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div5", "pll2_sys", "pll2_pfd1", "pll3_pfd0" };
+static const char * const cssys_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const cstrace_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_pfd1", "pll2_sys" };
+static const char * const m4_systick_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd0", "pll1_div5" };
+static const char * const m7_systick_sels[] = { CLOCK_MUX_DEFAULT, "pll2_sys", "pll3_div2", "pll1_div5", "pll2_pfd0" };
+static const char * const adc1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const adc2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const acmp_sels[] = { CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll_audio", "pll2_pfd3" };
+static const char * const flexio1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const flexio2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const gpt1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" };
+static const char * const gpt2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video" };
+static const char * const gpt3_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video" };
+static const char * const gpt4_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" };
+static const char * const gpt5_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" };
+static const char * const gpt6_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3" };
+static const char * const flexspi1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys" };
+static const char * const flexspi2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys" };
+static const char * const can1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const can2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const can3_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" };
+static const char * const lpuart1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart3_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart4_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart5_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart6_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart7_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart8_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart9_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart10_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpuart11_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" };
+static const char * const lpuart12_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" };
+static const char * const lpi2c1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpi2c2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpi2c3_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpi2c4_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpi2c5_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" };
+static const char * const lpi2c6_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5" };
+static const char * const lpspi1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpspi2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpspi3_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpspi4_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const lpspi5_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5" };
+static const char * const lpspi6_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5" };
+static const char * const emv1_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const emv2_sels[] = { CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3" };
+static const char * const enet1_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" };
+static const char * const enet2_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" };
+static const char * const enet_qos_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" };
+static const char * const enet_25m_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" };
+static const char * const enet_timer1_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" };
+static const char * const enet_timer2_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" };
+static const char * const enet_timer3_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1" };
+static const char * const usdhc1_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm" };
+static const char * const usdhc2_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm" };
+static const char * const asrc_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3" };
+static const char * const mqs_sels[] = { CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3" };
+static const char * const mic_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5" };
+static const char * const spdif_sels[] = { CLOCK_MUX_DEFAULT, "pll_audio", "pll3_sys", "pll3_pfd2", "pll2_pfd3" };
+static const char * const sai1_sels[] = { CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3" };
+static const char * const sai2_sels[] = { CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3" };
+static const char * const sai3_sels[] = { CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3" };
+static const char * const sai4_sels[] = { CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5" };
+static const char * const gc355_sels[] = { CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd1", "pll3_sys", "pll_video" };
+static const char * const lcdif_sels[] = { CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video" };
+static const char * const lcdifv2_sels[] = { CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video" };
+static const char * const mipi_ref_sels[] = { CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video" };
+static const char * const mipi_esc_sels[] = { CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video" };
+static const char * const csi2_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video" };
+static const char * const csi2_esc_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video" };
+static const char * const csi2_ui_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video" };
+static const char * const csi_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll3_pfd1", "pll_video" };
+static const char * const cko1_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_sys", "pll3_pfd1", "pll1_div5" };
+static const char * const cko2_sels[] = { CLOCK_MUX_DEFAULT, "pll2_pfd3", "rcosc48M", "pll3_pfd1", "pll_audio"};
+
+static const char * const pll_arm_mux[] = {"pll_arm_pre", "osc"};
+static const char * const pll3_mux[] = {"pll3_pre", "osc"};
+static const char * const pll2_mux[] = {"pll2_pre", "osc"};
+
+static const struct clk_div_table post_div_table[] = {
+	{ .val = 3, .div = 1, },
+	{ .val = 2, .div = 8, },
+	{ .val = 1, .div = 4, },
+	{ .val = 0, .div = 2, },
+	{ }
+};
+
+static int imxrt1170_clocks_probe(struct platform_device *pdev)
+{
+	void __iomem *ccm_base;
+	void __iomem *pll_base;
+	struct clk_hw **hws;
+	struct clk_hw_onecell_data *clk_hw_data;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *anp;
+	int ret;
+
+	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+					  IMXRT1170_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return -ENOMEM;
+
+	clk_hw_data->num = IMXRT1170_CLK_END;
+	hws = clk_hw_data->hws;
+
+	hws[IMXRT1170_CLK_OSC] = imx_obtain_fixed_clk_hw(np, "osc");
+	hws[IMXRT1170_CLK_RCOSC_16M] = imx_obtain_fixed_clk_hw(np, "rcosc16M");
+	hws[IMXRT1170_CLK_OSC_32K] = imx_obtain_fixed_clk_hw(np, "osc32k");
+
+	hws[IMXRT1170_CLK_RCOSC_48M] = imx_clk_hw_fixed_factor("rcosc48M",  "rcosc16M", 3, 1);
+	hws[IMXRT1170_CLK_RCOSC_400M] = imx_clk_hw_fixed_factor("rcosc400M",  "rcosc16M", 25, 1);
+	hws[IMXRT1170_CLK_RCOSC_48M_DIV2] = imx_clk_hw_fixed_factor("rcosc48M_div2",  "rcosc48M", 1, 2);
+
+	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
+	pll_base = of_iomap(anp, 0);
+	of_node_put(anp);
+	if (WARN_ON(!pll_base))
+		return -ENOMEM;
+
+	/* Anatop clocks */
+	hws[IMXRT1170_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
+
+	hws[IMXRT1170_CLK_PLL_ARM_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_SYSV2, "pll_arm_pre", "osc", pll_base + 0x200, 0xff);
+	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL_ARM_PRE], 13);
+	hws[IMXRT1170_CLK_PLL_ARM_BYPASS] = imx_clk_hw_mux("pll_arm_bypass",
+		pll_base + 0x200, 17, 1, pll_arm_mux, 2);
+	hws[IMXRT1170_CLK_PLL_ARM_DIV] = clk_hw_register_divider_table(NULL, "pll_arm_div",
+		"pll_arm_bypass", CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
+		pll_base + 0x200, 15, 2, 0, post_div_table, &imx_ccm_lock);
+	hws[IMXRT1170_CLK_PLL_ARM] = imx_clk_hw_gate("pll_arm", "pll_arm_div", pll_base + 0x200, 14);
+
+	hws[IMXRT1170_CLK_PLL3_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2, "pll3_pre", "osc", pll_base + 0x210, 0x1);
+	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL3_PRE], 21);
+	hws[IMXRT1170_CLK_PLL3_BYPASS] = imx_clk_hw_mux("pll3_bypass",
+		pll_base + 0x210, 16, 1, pll3_mux, 2);
+	hws[IMXRT1170_CLK_PLL3] = imx_clk_hw_gate("pll3_sys", "pll3_bypass", pll_base + 0x210, 13);
+
+	hws[IMXRT1170_CLK_PLL2_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2, "pll2_pre", "osc", pll_base + 0x240, 0x1);
+	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL2_PRE], 23);
+	hws[IMXRT1170_CLK_PLL2_BYPASS] = imx_clk_hw_mux("pll2_bypass",
+		pll_base + 0x240, 16, 1, pll2_mux, 2);
+	hws[IMXRT1170_CLK_PLL2] = imx_clk_hw_gate("pll2_sys", "pll2_bypass", pll_base + 0x240, 13);
+
+	hws[IMXRT1170_CLK_PLL3_PFD0] = imx_clk_hw_pfd("pll3_pfd0", "pll3_sys", pll_base + 0x230, 0);
+	hws[IMXRT1170_CLK_PLL3_PFD1] = imx_clk_hw_pfd("pll3_pfd1", "pll3_sys", pll_base + 0x230, 1);
+	hws[IMXRT1170_CLK_PLL3_PFD2] = imx_clk_hw_pfd("pll3_pfd2", "pll3_sys", pll_base + 0x230, 2);
+	hws[IMXRT1170_CLK_PLL3_PFD3] = imx_clk_hw_pfd("pll3_pfd3", "pll3_sys", pll_base + 0x230, 3);
+	hws[IMXRT1170_CLK_PLL3_DIV2_GATE] = imx_clk_hw_fixed_factor("pll3_div2_gate", "pll3_sys", 1, 2);
+	hws[IMXRT1170_CLK_PLL3_DIV2] = imx_clk_hw_gate("pll3_div2", "pll3_sys", pll_base + 0x210, 3);
+
+	hws[IMXRT1170_CLK_PLL2_PFD0] = imx_clk_hw_pfd("pll2_pfd0", "pll2_sys", pll_base + 0x270, 0);
+	hws[IMXRT1170_CLK_PLL2_PFD1] = imx_clk_hw_pfd("pll2_pfd1", "pll2_sys", pll_base + 0x270, 1);
+	hws[IMXRT1170_CLK_PLL2_PFD2] = imx_clk_hw_pfd("pll2_pfd2", "pll2_sys", pll_base + 0x270, 2);
+	hws[IMXRT1170_CLK_PLL2_PFD3] = imx_clk_hw_pfd("pll2_pfd3", "pll2_sys", pll_base + 0x270, 3);
+
+	/* CCM clocks */
+	ccm_base = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(IS_ERR(ccm_base)))
+		return PTR_ERR(ccm_base);
+
+	hws[IMXRT1170_CLK_M7_SEL] = imx_clk_hw_mux("m7_sel", ccm_base + (1 * 0x80), 8, 3, m7_sels, 8);
+	hws[IMXRT1170_CLK_M4_SEL] = imx_clk_hw_mux("m4_sel", ccm_base + (2 * 0x80), 8, 3, m4_sels, 8);
+	hws[IMXRT1170_CLK_BUS_SEL] = imx_clk_hw_mux("bus_sel", ccm_base + (3 * 0x80), 8, 3, bus_sels, 8);
+	hws[IMXRT1170_CLK_BUS_LPSR_SEL] = imx_clk_hw_mux("bus_lpsr_sel", ccm_base + (4 * 0x80), 8, 3, bus_lpsr_sels, 8);
+	hws[IMXRT1170_CLK_SEMC_SEL] = imx_clk_hw_mux("semc_sel", ccm_base + (5 * 0x80), 8, 3, semc_sels, 8);
+	hws[IMXRT1170_CLK_CSSYS_SEL] = imx_clk_hw_mux("cssys_sel", ccm_base + (6 * 0x80), 8, 3, cssys_sels, 8);
+	hws[IMXRT1170_CLK_CSTRACE_SEL] = imx_clk_hw_mux("cstrace_sel", ccm_base + (7 * 0x80), 8, 3, cstrace_sels, 8);
+	hws[IMXRT1170_CLK_M4_SYSTICK_SEL] = imx_clk_hw_mux("m4_systick_sel", ccm_base + (8 * 0x80), 8, 3, m4_systick_sels, 8);
+	hws[IMXRT1170_CLK_M7_SYSTICK_SEL] = imx_clk_hw_mux("m7_systick_sel", ccm_base + (9 * 0x80), 8, 3, m7_systick_sels, 8);
+	hws[IMXRT1170_CLK_ADC1_SEL] = imx_clk_hw_mux("adc1_sel", ccm_base + (10 * 0x80), 8, 3, adc1_sels, 8);
+	hws[IMXRT1170_CLK_ADC2_SEL] = imx_clk_hw_mux("adc2_sel", ccm_base + (11 * 0x80), 8, 3, adc2_sels, 8);
+	hws[IMXRT1170_CLK_ACMP_SEL] = imx_clk_hw_mux("acmp_sel", ccm_base + (12 * 0x80), 8, 3, acmp_sels, 8);
+	hws[IMXRT1170_CLK_FLEXIO1_SEL] = imx_clk_hw_mux("flexio1_sel", ccm_base + (13 * 0x80), 8, 3, flexio1_sels, 8);
+	hws[IMXRT1170_CLK_FLEXIO2_SEL] = imx_clk_hw_mux("flexio2_sel", ccm_base + (14 * 0x80), 8, 3, flexio2_sels, 8);
+	hws[IMXRT1170_CLK_GPT1_SEL] = imx_clk_hw_mux("gpt1_sel", ccm_base + (15 * 0x80), 8, 3, gpt1_sels, 8);
+	hws[IMXRT1170_CLK_GPT2_SEL] = imx_clk_hw_mux("gpt2_sel", ccm_base + (16 * 0x80), 8, 3, gpt2_sels, 8);
+	hws[IMXRT1170_CLK_GPT3_SEL] = imx_clk_hw_mux("gpt3_sel", ccm_base + (17 * 0x80), 8, 3, gpt3_sels, 8);
+	hws[IMXRT1170_CLK_GPT4_SEL] = imx_clk_hw_mux("gpt4_sel", ccm_base + (18 * 0x80), 8, 3, gpt4_sels, 8);
+	hws[IMXRT1170_CLK_GPT5_SEL] = imx_clk_hw_mux("gpt5_sel", ccm_base + (19 * 0x80), 8, 3, gpt5_sels, 8);
+	hws[IMXRT1170_CLK_GPT6_SEL] = imx_clk_hw_mux("gpt6_sel", ccm_base + (20 * 0x80), 8, 3, gpt6_sels, 8);
+	hws[IMXRT1170_CLK_FLEXSPI1_SEL] = imx_clk_hw_mux("flexspi1_sel", ccm_base + (21 * 0x80), 8, 3, flexspi1_sels, 8);
+	hws[IMXRT1170_CLK_FLEXSPI2_SEL] = imx_clk_hw_mux("flexspi2_sel", ccm_base + (22 * 0x80), 8, 3, flexspi2_sels, 8);
+	hws[IMXRT1170_CLK_CAN1_SEL] = imx_clk_hw_mux("can1_sel", ccm_base + (23 * 0x80), 8, 3, can1_sels, 8);
+	hws[IMXRT1170_CLK_CAN2_SEL] = imx_clk_hw_mux("can2_sel", ccm_base + (24 * 0x80), 8, 3, can2_sels, 8);
+	hws[IMXRT1170_CLK_CAN3_SEL] = imx_clk_hw_mux("can3_sel", ccm_base + (25 * 0x80), 8, 3, can3_sels, 8);
+	hws[IMXRT1170_CLK_LPUART1_SEL] = imx_clk_hw_mux("lpuart1_sel", ccm_base + (26 * 0x80), 8, 3, lpuart1_sels, 8);
+	hws[IMXRT1170_CLK_LPUART2_SEL] = imx_clk_hw_mux("lpuart2_sel", ccm_base + (27 * 0x80), 8, 3, lpuart2_sels, 8);
+	hws[IMXRT1170_CLK_LPUART3_SEL] = imx_clk_hw_mux("lpuart3_sel", ccm_base + (28 * 0x80), 8, 3, lpuart3_sels, 8);
+	hws[IMXRT1170_CLK_LPUART4_SEL] = imx_clk_hw_mux("lpuart4_sel", ccm_base + (29 * 0x80), 8, 3, lpuart4_sels, 8);
+	hws[IMXRT1170_CLK_LPUART5_SEL] = imx_clk_hw_mux("lpuart5_sel", ccm_base + (30 * 0x80), 8, 3, lpuart5_sels, 8);
+	hws[IMXRT1170_CLK_LPUART6_SEL] = imx_clk_hw_mux("lpuart6_sel", ccm_base + (31 * 0x80), 8, 3, lpuart6_sels, 8);
+	hws[IMXRT1170_CLK_LPUART7_SEL] = imx_clk_hw_mux("lpuart7_sel", ccm_base + (32 * 0x80), 8, 3, lpuart7_sels, 8);
+	hws[IMXRT1170_CLK_LPUART8_SEL] = imx_clk_hw_mux("lpuart8_sel", ccm_base + (33 * 0x80), 8, 3, lpuart8_sels, 8);
+	hws[IMXRT1170_CLK_LPUART9_SEL] = imx_clk_hw_mux("lpuart9_sel", ccm_base + (34 * 0x80), 8, 3, lpuart9_sels, 8);
+	hws[IMXRT1170_CLK_LPUART10_SEL] = imx_clk_hw_mux("lpuart10_sel", ccm_base + (35 * 0x80), 8, 3, lpuart10_sels, 8);
+	hws[IMXRT1170_CLK_LPUART11_SEL] = imx_clk_hw_mux("lpuart11_sel", ccm_base + (36 * 0x80), 8, 3, lpuart11_sels, 8);
+	hws[IMXRT1170_CLK_LPUART12_SEL] = imx_clk_hw_mux("lpuart12_sel", ccm_base + (37 * 0x80), 8, 3, lpuart12_sels, 8);
+	hws[IMXRT1170_CLK_LPI2C1_SEL] = imx_clk_hw_mux("lpi2c1_sel", ccm_base + (38 * 0x80), 8, 3, lpi2c1_sels, 8);
+	hws[IMXRT1170_CLK_LPI2C2_SEL] = imx_clk_hw_mux("lpi2c2_sel", ccm_base + (39 * 0x80), 8, 3, lpi2c2_sels, 8);
+	hws[IMXRT1170_CLK_LPI2C3_SEL] = imx_clk_hw_mux("lpi2c3_sel", ccm_base + (40 * 0x80), 8, 3, lpi2c3_sels, 8);
+	hws[IMXRT1170_CLK_LPI2C4_SEL] = imx_clk_hw_mux("lpi2c4_sel", ccm_base + (41 * 0x80), 8, 3, lpi2c4_sels, 8);
+	hws[IMXRT1170_CLK_LPI2C5_SEL] = imx_clk_hw_mux("lpi2c5_sel", ccm_base + (42 * 0x80), 8, 3, lpi2c5_sels, 8);
+	hws[IMXRT1170_CLK_LPI2C6_SEL] = imx_clk_hw_mux("lpi2c6_sel", ccm_base + (43 * 0x80), 8, 3, lpi2c6_sels, 8);
+	hws[IMXRT1170_CLK_LPSPI1_SEL] = imx_clk_hw_mux("lpspi1_sel", ccm_base + (44 * 0x80), 8, 3, lpspi1_sels, 8);
+	hws[IMXRT1170_CLK_LPSPI2_SEL] = imx_clk_hw_mux("lpspi2_sel", ccm_base + (45 * 0x80), 8, 3, lpspi2_sels, 8);
+	hws[IMXRT1170_CLK_LPSPI3_SEL] = imx_clk_hw_mux("lpspi3_sel", ccm_base + (46 * 0x80), 8, 3, lpspi3_sels, 8);
+	hws[IMXRT1170_CLK_LPSPI4_SEL] = imx_clk_hw_mux("lpspi4_sel", ccm_base + (47 * 0x80), 8, 3, lpspi4_sels, 8);
+	hws[IMXRT1170_CLK_LPSPI5_SEL] = imx_clk_hw_mux("lpspi5_sel", ccm_base + (48 * 0x80), 8, 3, lpspi5_sels, 8);
+	hws[IMXRT1170_CLK_LPSPI6_SEL] = imx_clk_hw_mux("lpspi6_sel", ccm_base + (49 * 0x80), 8, 3, lpspi6_sels, 8);
+	hws[IMXRT1170_CLK_EMV1_SEL] = imx_clk_hw_mux("emv1_sel", ccm_base + (50 * 0x80), 8, 3, emv1_sels, 8);
+	hws[IMXRT1170_CLK_EMV2_SEL] = imx_clk_hw_mux("emv2_sel", ccm_base + (51 * 0x80), 8, 3, emv2_sels, 8);
+	hws[IMXRT1170_CLK_ENET1_SEL] = imx_clk_hw_mux("enet1_sel", ccm_base + (52 * 0x80), 8, 3, enet1_sels, 8);
+	hws[IMXRT1170_CLK_ENET2_SEL] = imx_clk_hw_mux("enet2_sel", ccm_base + (53 * 0x80), 8, 3, enet2_sels, 8);
+	hws[IMXRT1170_CLK_ENET_QOS_SEL] = imx_clk_hw_mux("enet_qos_sel", ccm_base + (54 * 0x80), 8, 3, enet_qos_sels, 8);
+	hws[IMXRT1170_CLK_ENET_25M_SEL] = imx_clk_hw_mux("enet_25m_sel", ccm_base + (55 * 0x80), 8, 3, enet_25m_sels, 8);
+	hws[IMXRT1170_CLK_ENET_TIMER1_SEL] = imx_clk_hw_mux("enet_timer1_sel", ccm_base + (56 * 0x80), 8, 3, enet_timer1_sels, 8);
+	hws[IMXRT1170_CLK_ENET_TIMER2_SEL] = imx_clk_hw_mux("enet_timer2_sel", ccm_base + (57 * 0x80), 8, 3, enet_timer2_sels, 8);
+	hws[IMXRT1170_CLK_ENET_TIMER3_SEL] = imx_clk_hw_mux("enet_timer3_sel", ccm_base + (58 * 0x80), 8, 3, enet_timer3_sels, 8);
+	hws[IMXRT1170_CLK_USDHC1_SEL] = imx_clk_hw_mux("usdhc1_sel", ccm_base + (59 * 0x80), 8, 3, usdhc1_sels, 8);
+	hws[IMXRT1170_CLK_USDHC2_SEL] = imx_clk_hw_mux("usdhc2_sel", ccm_base + (60 * 0x80), 8, 3, usdhc2_sels, 8);
+	hws[IMXRT1170_CLK_ASRC_SEL] = imx_clk_hw_mux("asrc_sel", ccm_base + (61 * 0x80), 8, 3, asrc_sels, 8);
+	hws[IMXRT1170_CLK_MQS_SEL] = imx_clk_hw_mux("mqs_sel", ccm_base + (62 * 0x80), 8, 3, mqs_sels, 8);
+	hws[IMXRT1170_CLK_MIC_SEL] = imx_clk_hw_mux("mic_sel", ccm_base + (63 * 0x80), 8, 3, mic_sels, 8);
+	hws[IMXRT1170_CLK_SPDIF_SEL] = imx_clk_hw_mux("spdif_sel", ccm_base + (64 * 0x80), 8, 3, spdif_sels, 8);
+	hws[IMXRT1170_CLK_SAI1_SEL] = imx_clk_hw_mux("sai1_sel", ccm_base + (65 * 0x80), 8, 3, sai1_sels, 8);
+	hws[IMXRT1170_CLK_SAI2_SEL] = imx_clk_hw_mux("sai2_sel", ccm_base + (66 * 0x80), 8, 3, sai2_sels, 8);
+	hws[IMXRT1170_CLK_SAI3_SEL] = imx_clk_hw_mux("sai3_sel", ccm_base + (67 * 0x80), 8, 3, sai3_sels, 8);
+	hws[IMXRT1170_CLK_SAI4_SEL] = imx_clk_hw_mux("sai4_sel", ccm_base + (68 * 0x80), 8, 3, sai4_sels, 8);
+	hws[IMXRT1170_CLK_GC355_SEL] = imx_clk_hw_mux("gc355_sel", ccm_base + (69 * 0x80), 8, 3, gc355_sels, 8);
+	hws[IMXRT1170_CLK_LCDIF_SEL] = imx_clk_hw_mux("lcdif_sel", ccm_base + (70 * 0x80), 8, 3, lcdif_sels, 8);
+	hws[IMXRT1170_CLK_LCDIFV2_SEL] = imx_clk_hw_mux("lcdifv2_sel", ccm_base + (71 * 0x80), 8, 3, lcdifv2_sels, 8);
+	hws[IMXRT1170_CLK_MIPI_REF_SEL] = imx_clk_hw_mux("mipi_ref_sel", ccm_base + (72 * 0x80), 8, 3, mipi_ref_sels, 8);
+	hws[IMXRT1170_CLK_MIPI_ESC_SEL] = imx_clk_hw_mux("mipi_esc_sel", ccm_base + (73 * 0x80), 8, 3, mipi_esc_sels, 8);
+	hws[IMXRT1170_CLK_CSI2_SEL] = imx_clk_hw_mux("csi2_sel", ccm_base + (74 * 0x80), 8, 3, csi2_sels, 8);
+	hws[IMXRT1170_CLK_CSI2_ESC_SEL] = imx_clk_hw_mux("csi2_esc_sel", ccm_base + (75 * 0x80), 8, 3, csi2_esc_sels, 8);
+	hws[IMXRT1170_CLK_CSI2_UI_SEL] = imx_clk_hw_mux("csi2_ui_sel", ccm_base + (76 * 0x80), 8, 3, csi2_ui_sels, 8);
+	hws[IMXRT1170_CLK_CSI_SEL] = imx_clk_hw_mux("csi_sel", ccm_base + (77 * 0x80), 8, 3, csi_sels, 8);
+	hws[IMXRT1170_CLK_CKO1_SEL] = imx_clk_hw_mux("cko1_sel", ccm_base + (78 * 0x80), 8, 3, cko1_sels, 8);
+	hws[IMXRT1170_CLK_CKO2_SEL] = imx_clk_hw_mux("cko2_sel", ccm_base + (79 * 0x80), 8, 3, cko2_sels, 8);
+
+	hws[IMXRT1170_CLK_M7_GATE] = imx_clk_hw_gate_dis_flags("m7_gate", "m7_sel", ccm_base + (1 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_M4_GATE] = imx_clk_hw_gate_dis_flags("m4_gate", "m4_sel", ccm_base + (2 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_BUS_GATE] = imx_clk_hw_gate_dis_flags("bus_gate", "bus_sel", ccm_base + (3 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_BUS_LPSR_GATE] = imx_clk_hw_gate_dis_flags("bus_lpsr_gate", "bus_lpsr_sel", ccm_base + (4 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_SEMC_GATE] = imx_clk_hw_gate_dis_flags("semc_gate", "semc_sel", ccm_base + (5 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_CSSYS_GATE] = imx_clk_hw_gate_dis_flags("cssys_gate", "cssys_sel", ccm_base + (6 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_CSTRACE_GATE] = imx_clk_hw_gate_dis_flags("cstrace_gate", "cstrace_sel", ccm_base + (7 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_M4_SYSTICK_GATE] = imx_clk_hw_gate_dis_flags("m4_systick_gate", "m4_systick_sel", ccm_base + (8 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_M7_SYSTICK_GATE] = imx_clk_hw_gate_dis_flags("m7_systick_gate", "m7_systick_sel", ccm_base + (9 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ADC1_GATE] = imx_clk_hw_gate_dis_flags("adc1_gate", "adc1_sel", ccm_base + (10 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ADC2_GATE] = imx_clk_hw_gate_dis_flags("adc2_gate", "adc2_sel", ccm_base + (11 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ACMP_GATE] = imx_clk_hw_gate_dis_flags("acmp_gate", "acmp_sel", ccm_base + (12 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_FLEXIO1_GATE] = imx_clk_hw_gate_dis_flags("flexio1_gate", "flexio1_sel", ccm_base + (13 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_FLEXIO2_GATE] = imx_clk_hw_gate_dis_flags("flexio2_gate", "flexio2_sel", ccm_base + (14 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_GPT1_GATE] = imx_clk_hw_gate_dis_flags("gpt1_gate", "gpt1_sel", ccm_base + (15 * 0x80), 24, CLK_IS_CRITICAL);
+	hws[IMXRT1170_CLK_GPT2_GATE] = imx_clk_hw_gate_dis_flags("gpt2_gate", "gpt2_sel", ccm_base + (16 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_GPT3_GATE] = imx_clk_hw_gate_dis_flags("gpt3_gate", "gpt3_sel", ccm_base + (17 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_GPT4_GATE] = imx_clk_hw_gate_dis_flags("gpt4_gate", "gpt4_sel", ccm_base + (18 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_GPT5_GATE] = imx_clk_hw_gate_dis_flags("gpt5_gate", "gpt5_sel", ccm_base + (19 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_GPT6_GATE] = imx_clk_hw_gate_dis_flags("gpt6_gate", "gpt6_sel", ccm_base + (20 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_FLEXSPI1_GATE] = imx_clk_hw_gate_dis_flags("flexspi1_gate", "flexspi1_sel", ccm_base + (21 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_FLEXSPI2_GATE] = imx_clk_hw_gate_dis_flags("flexspi2_gate", "flexspi2_sel", ccm_base + (22 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CAN1_GATE] = imx_clk_hw_gate_dis_flags("can1_gate", "can1_sel", ccm_base + (23 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CAN2_GATE] = imx_clk_hw_gate_dis_flags("can2_gate", "can2_sel", ccm_base + (24 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CAN3_GATE] = imx_clk_hw_gate_dis_flags("can3_gate", "can3_sel", ccm_base + (25 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART1_GATE] = imx_clk_hw_gate_dis_flags("lpuart1_gate", "lpuart1_sel", ccm_base + (26 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART2_GATE] = imx_clk_hw_gate_dis_flags("lpuart2_gate", "lpuart2_sel", ccm_base + (27 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART3_GATE] = imx_clk_hw_gate_dis_flags("lpuart3_gate", "lpuart3_sel", ccm_base + (28 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART4_GATE] = imx_clk_hw_gate_dis_flags("lpuart4_gate", "lpuart4_sel", ccm_base + (29 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART5_GATE] = imx_clk_hw_gate_dis_flags("lpuart5_gate", "lpuart5_sel", ccm_base + (30 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART6_GATE] = imx_clk_hw_gate_dis_flags("lpuart6_gate", "lpuart6_sel", ccm_base + (31 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART7_GATE] = imx_clk_hw_gate_dis_flags("lpuart7_gate", "lpuart7_sel", ccm_base + (32 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART8_GATE] = imx_clk_hw_gate_dis_flags("lpuart8_gate", "lpuart8_sel", ccm_base + (33 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART9_GATE] = imx_clk_hw_gate_dis_flags("lpuart9_gate", "lpuart9_sel", ccm_base + (34 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART10_GATE] = imx_clk_hw_gate_dis_flags("lpuart10_gate", "lpuart10_sel", ccm_base + (35 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART11_GATE] = imx_clk_hw_gate_dis_flags("lpuart11_gate", "lpuart11_sel", ccm_base + (36 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPUART12_GATE] = imx_clk_hw_gate_dis_flags("lpuart12_gate", "lpuart12_sel", ccm_base + (37 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPI2C1_GATE] = imx_clk_hw_gate_dis_flags("lpi2c1_gate", "lpi2c1_sel", ccm_base + (38 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPI2C2_GATE] = imx_clk_hw_gate_dis_flags("lpi2c2_gate", "lpi2c2_sel", ccm_base + (39 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPI2C3_GATE] = imx_clk_hw_gate_dis_flags("lpi2c3_gate", "lpi2c3_sel", ccm_base + (40 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPI2C4_GATE] = imx_clk_hw_gate_dis_flags("lpi2c4_gate", "lpi2c4_sel", ccm_base + (41 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPI2C5_GATE] = imx_clk_hw_gate_dis_flags("lpi2c5_gate", "lpi2c5_sel", ccm_base + (42 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPI2C6_GATE] = imx_clk_hw_gate_dis_flags("lpi2c6_gate", "lpi2c6_sel", ccm_base + (43 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPSPI1_GATE] = imx_clk_hw_gate_dis_flags("lpspi1_gate", "lpspi1_sel", ccm_base + (44 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPSPI2_GATE] = imx_clk_hw_gate_dis_flags("lpspi2_gate", "lpspi2_sel", ccm_base + (45 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPSPI3_GATE] = imx_clk_hw_gate_dis_flags("lpspi3_gate", "lpspi3_sel", ccm_base + (46 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPSPI4_GATE] = imx_clk_hw_gate_dis_flags("lpspi4_gate", "lpspi4_sel", ccm_base + (47 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPSPI5_GATE] = imx_clk_hw_gate_dis_flags("lpspi5_gate", "lpspi5_sel", ccm_base + (48 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LPSPI6_GATE] = imx_clk_hw_gate_dis_flags("lpspi6_gate", "lpspi6_sel", ccm_base + (49 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_EMV1_GATE] = imx_clk_hw_gate_dis_flags("emv1_gate", "emv1_sel", ccm_base + (50 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_EMV2_GATE] = imx_clk_hw_gate_dis_flags("emv2_gate", "emv2_sel", ccm_base + (51 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ENET1_GATE] = imx_clk_hw_gate_dis_flags("enet1_gate", "enet1_sel", ccm_base + (52 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ENET2_GATE] = imx_clk_hw_gate_dis_flags("enet2_gate", "enet2_sel", ccm_base + (53 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ENET_QOS_GATE] = imx_clk_hw_gate_dis_flags("enet_qos_gate", "enet_qos_sel", ccm_base + (54 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ENET_25M_GATE] = imx_clk_hw_gate_dis_flags("enet_25m_gate", "enet_25m_sel", ccm_base + (55 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ENET_TIMER1_GATE] = imx_clk_hw_gate_dis_flags("enet_timer1_gate", "enet_timer1_sel", ccm_base + (56 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ENET_TIMER2_GATE] = imx_clk_hw_gate_dis_flags("enet_timer2_gate", "enet_timer2_sel", ccm_base + (57 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ENET_TIMER3_GATE] = imx_clk_hw_gate_dis_flags("enet_timer3_gate", "enet_timer3_sel", ccm_base + (58 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_USDHC1_GATE] = imx_clk_hw_gate_dis_flags("usdhc1_gate", "usdhc1_sel", ccm_base + (59 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_USDHC2_GATE] = imx_clk_hw_gate_dis_flags("usdhc2_gate", "usdhc2_sel", ccm_base + (60 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_ASRC_GATE] = imx_clk_hw_gate_dis_flags("asrc_gate", "asrc_sel", ccm_base + (61 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_MQS_GATE] = imx_clk_hw_gate_dis_flags("mqs_gate", "mqs_sel", ccm_base + (62 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_MIC_GATE] = imx_clk_hw_gate_dis_flags("mic_gate", "mic_sel", ccm_base + (63 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_SPDIF_GATE] = imx_clk_hw_gate_dis_flags("spdif_gate", "spdif_sel", ccm_base + (64 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_SAI1_GATE] = imx_clk_hw_gate_dis_flags("sai1_gate", "sai1_sel", ccm_base + (65 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_SAI2_GATE] = imx_clk_hw_gate_dis_flags("sai2_gate", "sai2_sel", ccm_base + (66 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_SAI3_GATE] = imx_clk_hw_gate_dis_flags("sai3_gate", "sai3_sel", ccm_base + (67 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_SAI4_GATE] = imx_clk_hw_gate_dis_flags("sai4_gate", "sai4_sel", ccm_base + (68 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_GC355_GATE] = imx_clk_hw_gate_dis_flags("gc355_gate", "gc355_sel", ccm_base + (69 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LCDIF_GATE] = imx_clk_hw_gate_dis_flags("lcdif_gate", "lcdif_sel", ccm_base + (70 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_LCDIFV2_GATE] = imx_clk_hw_gate_dis_flags("lcdifv2_gate", "lcdifv2_sel", ccm_base + (71 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_MIPI_REF_GATE] = imx_clk_hw_gate_dis_flags("mipi_ref_gate", "mipi_ref_sel", ccm_base + (72 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_MIPI_ESC_GATE] = imx_clk_hw_gate_dis_flags("mipi_esc_gate", "mipi_esc_sel", ccm_base + (73 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CSI2_GATE] = imx_clk_hw_gate_dis_flags("csi2_gate", "csi2_sel", ccm_base + (74 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CSI2_ESC_GATE] = imx_clk_hw_gate_dis_flags("csi2_esc_gate", "csi2_esc_sel", ccm_base + (75 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CSI2_UI_GATE] = imx_clk_hw_gate_dis_flags("csi2_ui_gate", "csi2_ui_sel", ccm_base + (76 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CSI_GATE] = imx_clk_hw_gate_dis_flags("csi_gate", "csi_sel", ccm_base + (77 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CKO1_GATE] = imx_clk_hw_gate_dis_flags("cko1_gate", "cko1_sel", ccm_base + (78 * 0x80), 24, 0);
+	hws[IMXRT1170_CLK_CKO2_GATE] = imx_clk_hw_gate_dis_flags("cko2_gate", "cko2_sel", ccm_base + (79 * 0x80), 24, 0);
+
+	hws[IMXRT1170_CLK_M7] = imx_clk_hw_divider("m7", "m7_gate", ccm_base + (1 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_M4] = imx_clk_hw_divider("m4", "m4_gate", ccm_base + (2 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_BUS] = imx_clk_hw_divider("bus", "bus_gate", ccm_base + (3 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_BUS_LPSR] = imx_clk_hw_divider("bus_lpsr", "bus_lpsr_gate", ccm_base + (4 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_SEMC] = imx_clk_hw_divider("semc", "semc_gate", ccm_base + (5 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CSSYS] = imx_clk_hw_divider("cssys", "cssys_gate", ccm_base + (6 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CSTRACE] = imx_clk_hw_divider("cstrace", "cstrace_gate", ccm_base + (7 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_M4_SYSTICK] = imx_clk_hw_divider("m4_systick", "m4_systick_gate", ccm_base + (8 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_M7_SYSTICK] = imx_clk_hw_divider("m7_systick", "m7_systick_gate", ccm_base + (9 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ADC1] = imx_clk_hw_divider("adc1", "adc1_gate", ccm_base + (10 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ADC2] = imx_clk_hw_divider("adc2", "adc2_gate", ccm_base + (11 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ACMP] = imx_clk_hw_divider("acmp", "acmp_gate", ccm_base + (12 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_FLEXIO1] = imx_clk_hw_divider("flexio1", "flexio1_gate", ccm_base + (13 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_FLEXIO2] = imx_clk_hw_divider("flexio2", "flexio2_gate", ccm_base + (14 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_GPT1] = imx_clk_hw_divider("gpt1", "gpt1_gate", ccm_base + (15 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_GPT2] = imx_clk_hw_divider("gpt2", "gpt2_gate", ccm_base + (16 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_GPT3] = imx_clk_hw_divider("gpt3", "gpt3_gate", ccm_base + (17 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_GPT4] = imx_clk_hw_divider("gpt4", "gpt4_gate", ccm_base + (18 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_GPT5] = imx_clk_hw_divider("gpt5", "gpt5_gate", ccm_base + (19 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_GPT6] = imx_clk_hw_divider("gpt6", "gpt6_gate", ccm_base + (20 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_FLEXSPI1] = imx_clk_hw_divider("flexspi1", "flexspi1_gate", ccm_base + (21 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_FLEXSPI2] = imx_clk_hw_divider("flexspi2", "flexspi2_gate", ccm_base + (22 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CAN1] = imx_clk_hw_divider("can1", "can1_gate", ccm_base + (23 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CAN2] = imx_clk_hw_divider("can2", "can2_gate", ccm_base + (24 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CAN3] = imx_clk_hw_divider("can3", "can3_gate", ccm_base + (25 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART1] = imx_clk_hw_divider("lpuart1", "lpuart1_gate", ccm_base + (26 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART2] = imx_clk_hw_divider("lpuart2", "lpuart2_gate", ccm_base + (27 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART3] = imx_clk_hw_divider("lpuart3", "lpuart3_gate", ccm_base + (28 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART4] = imx_clk_hw_divider("lpuart4", "lpuart4_gate", ccm_base + (29 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART5] = imx_clk_hw_divider("lpuart5", "lpuart5_gate", ccm_base + (30 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART6] = imx_clk_hw_divider("lpuart6", "lpuart6_gate", ccm_base + (31 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART7] = imx_clk_hw_divider("lpuart7", "lpuart7_gate", ccm_base + (32 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART8] = imx_clk_hw_divider("lpuart8", "lpuart8_gate", ccm_base + (33 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART9] = imx_clk_hw_divider("lpuart9", "lpuart9_gate", ccm_base + (34 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART10] = imx_clk_hw_divider("lpuart10", "lpuart10_gate", ccm_base + (35 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART11] = imx_clk_hw_divider("lpuart11", "lpuart11_gate", ccm_base + (36 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPUART12] = imx_clk_hw_divider("lpuart12", "lpuart12_gate", ccm_base + (37 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPI2C1] = imx_clk_hw_divider("lpi2c1", "lpi2c1_gate", ccm_base + (38 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPI2C2] = imx_clk_hw_divider("lpi2c2", "lpi2c2_gate", ccm_base + (39 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPI2C3] = imx_clk_hw_divider("lpi2c3", "lpi2c3_gate", ccm_base + (40 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPI2C4] = imx_clk_hw_divider("lpi2c4", "lpi2c4_gate", ccm_base + (41 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPI2C5] = imx_clk_hw_divider("lpi2c5", "lpi2c5_gate", ccm_base + (42 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPI2C6] = imx_clk_hw_divider("lpi2c6", "lpi2c6_gate", ccm_base + (43 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPSPI1] = imx_clk_hw_divider("lpspi1", "lpspi1_gate", ccm_base + (44 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPSPI2] = imx_clk_hw_divider("lpspi2", "lpspi2_gate", ccm_base + (45 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPSPI3] = imx_clk_hw_divider("lpspi3", "lpspi3_gate", ccm_base + (46 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPSPI4] = imx_clk_hw_divider("lpspi4", "lpspi4_gate", ccm_base + (47 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPSPI5] = imx_clk_hw_divider("lpspi5", "lpspi5_gate", ccm_base + (48 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LPSPI6] = imx_clk_hw_divider("lpspi6", "lpspi6_gate", ccm_base + (49 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_EMV1] = imx_clk_hw_divider("emv1", "emv1_gate", ccm_base + (50 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_EMV2] = imx_clk_hw_divider("emv2", "emv2_gate", ccm_base + (51 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ENET1] = imx_clk_hw_divider("enet1", "enet1_gate", ccm_base + (52 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ENET2] = imx_clk_hw_divider("enet2", "enet2_gate", ccm_base + (53 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ENET_QOS] = imx_clk_hw_divider("enet_qos", "enet_qos_gate", ccm_base + (54 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ENET_25M] = imx_clk_hw_divider("enet_25m", "enet_25m_gate", ccm_base + (55 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ENET_TIMER1] = imx_clk_hw_divider("enet_timer1", "enet_timer1_gate", ccm_base + (56 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ENET_TIMER2] = imx_clk_hw_divider("enet_timer2", "enet_timer2_gate", ccm_base + (57 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ENET_TIMER3] = imx_clk_hw_divider("enet_timer3", "enet_timer3_gate", ccm_base + (58 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_USDHC1] = imx_clk_hw_divider("usdhc1", "usdhc1_gate", ccm_base + (59 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_USDHC2] = imx_clk_hw_divider("usdhc2", "usdhc2_gate", ccm_base + (60 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_ASRC] = imx_clk_hw_divider("asrc", "asrc_gate", ccm_base + (61 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_MQS] = imx_clk_hw_divider("mqs", "mqs_gate", ccm_base + (62 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_MIC] = imx_clk_hw_divider("mic", "mic_gate", ccm_base + (63 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_SPDIF] = imx_clk_hw_divider("spdif", "spdif_gate", ccm_base + (64 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_SAI1] = imx_clk_hw_divider("sai1", "sai1_gate", ccm_base + (65 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_SAI2] = imx_clk_hw_divider("sai2", "sai2_gate", ccm_base + (66 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_SAI3] = imx_clk_hw_divider("sai3", "sai3_gate", ccm_base + (67 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_SAI4] = imx_clk_hw_divider("sai4", "sai4_gate", ccm_base + (68 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_GC355] = imx_clk_hw_divider("gc355", "gc355_gate", ccm_base + (69 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LCDIF] = imx_clk_hw_divider("lcdif", "lcdif_gate", ccm_base + (70 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_LCDIFV2] = imx_clk_hw_divider("lcdifv2", "lcdifv2_gate", ccm_base + (71 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_MIPI_REF] = imx_clk_hw_divider("mipi_ref", "mipi_ref_gate", ccm_base + (72 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_MIPI_ESC] = imx_clk_hw_divider("mipi_esc", "mipi_esc_gate", ccm_base + (73 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CSI2] = imx_clk_hw_divider("csi2", "csi2_gate", ccm_base + (74 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CSI2_ESC] = imx_clk_hw_divider("csi2_esc", "csi2_esc_gate", ccm_base + (75 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CSI2_UI] = imx_clk_hw_divider("csi2_ui", "csi2_ui_gate", ccm_base + (76 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CSI] = imx_clk_hw_divider("csi", "csi_gate", ccm_base + (77 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CKO1] = imx_clk_hw_divider("cko1", "cko1_gate", ccm_base + (78 * 0x80), 0, 8);
+	hws[IMXRT1170_CLK_CKO2] = imx_clk_hw_divider("cko2", "cko2_gate", ccm_base + (79 * 0x80), 0, 8);
+
+	hws[IMXRT1170_CLK_USB] = imx_clk_hw_gate("usb", "bus", ccm_base + LPCG_GATE(115), 0);
+
+	imx_check_clk_hws(hws, IMXRT1170_CLK_END);
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register clks for i.MXRT1170.\n");
+		imx_unregister_hw_clocks(hws, IMXRT1170_CLK_END);
+	}
+	return ret;
+}
+
+static const struct of_device_id imxrt1170_clk_of_match[] = {
+	{ .compatible = "fsl,imxrt1170-ccm" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imxrt1170_clk_of_match);
+
+static struct platform_driver imxrt1170_clk_driver = {
+	.probe = imxrt1170_clocks_probe,
+	.driver = {
+		.name = "imxrt1170-ccm",
+		.of_match_table = imxrt1170_clk_of_match,
+	},
+};
+module_platform_driver(imxrt1170_clk_driver);
-- 
2.36.1

