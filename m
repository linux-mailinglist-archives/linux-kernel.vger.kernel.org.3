Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6791A4E819B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiCZOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiCZOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:45:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A8214FBF;
        Sat, 26 Mar 2022 07:43:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 85so8090750qkm.9;
        Sat, 26 Mar 2022 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EZGtbdxFZ3noOqFGyhG+BvJsZLtag7YF1nMBF77BO0=;
        b=cIQn3hDUSeODhnonXoVFAFnvS8krfyCi62wHCsv2WnywGPhzam3404KECiCenPDKCb
         u2njieX6nJ/5dfXl4lPEDAriruOTUbaXPxJJQQKVpPp4pWNwr+tJy250a5Hdm9XolnB1
         W96L/hRshcJnzPUBTOd+rGFi6PJRgaBhscI3azFFPaF0ItXqBxq3oUtMEIBF+log6tyf
         ELuaQ28I790f1pgxCLI4z1D5vovI+Rrzj6WfskLzqe+ERV0vm7OTGnneN/yRUJxARJzT
         k2TXO1hpTa2rfdLAtJKuLrrSt60HF4vCJ2vJwnb490/ElfLpv6ZNf50dS6PJjd78d/dt
         d6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EZGtbdxFZ3noOqFGyhG+BvJsZLtag7YF1nMBF77BO0=;
        b=w47YFQle6vWbmYHsvaS06mKjxBJq1xRaedHqGTBe8aZfw6hXqnzjlP/RMo4t3smhXI
         yr3j3+NFOLx5+sCXu9yxWAIsN2Z4XT6miiEz6AtUyuY/P4H/YibtnDZYXP/4na6d3MbY
         g2xwV08Tc4iTPmOw0Ye1lKXJgBtbV264nFR1ID4q3tNa9GYHDTZDPCWyD0YW98PHizUS
         ObtWvHc2OPmOJq4LgvUG21Wqch+HyPlSZ9O8LMYwGUxn0Q8nS431F5eDeX39t27s+FQT
         KlS1dWP5D7JHs4j/7ID/09IZ5cN7DkGEHAY512zCbj07aAQV34Yev/pQHw6n85SOgQqX
         4n5g==
X-Gm-Message-State: AOAM533UDMnyijdsEKTkxBMKP6oh8J/Ofre2iLDc2LjlhogcgqAKjXEp
        HPQXLuBaS6xT/uyTBaKL2WE=
X-Google-Smtp-Source: ABdhPJwSvxSW149cdrkqZwpEFBScX8iFWme3hrzZrFJNukfVP6GCztYf5PKDTJG/J5EUjFGvkDihGQ==
X-Received: by 2002:a05:620a:44c3:b0:680:9fcf:4fe7 with SMTP id y3-20020a05620a44c300b006809fcf4fe7mr9437080qkp.95.1648305820978;
        Sat, 26 Mar 2022 07:43:40 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm4908918qkg.60.2022.03.26.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:40 -0700 (PDT)
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
Subject: [PATCH v1 08/12] clk: imx: Add initial support for i.MXRT1170 clock driver
Date:   Sat, 26 Mar 2022 10:43:09 -0400
Message-Id: <20220326144313.673549-9-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
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
 drivers/clk/imx/Kconfig         |   7 +
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-imxrt1170.c | 391 ++++++++++++++++++++++++++++++++
 3 files changed, 399 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imxrt1170.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 45641b8bdc50..009adbe8059f 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -112,3 +112,10 @@ config CLK_IMXRT1050
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
index 1e13c5cb37d9..0968d9ffcf6b 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -47,4 +47,5 @@ obj-$(CONFIG_CLK_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_CLK_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_CLK_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_CLK_IMXRT1050)  += clk-imxrt1050.o
+obj-$(CONFIG_CLK_IMXRT1170)  += clk-imxrt1170.o
 obj-$(CONFIG_CLK_VF610)  += clk-vf610.o
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
new file mode 100644
index 000000000000..041aea3d4b02
--- /dev/null
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2022
+ * Author(s):
+ * Jesse Taube <Mr.Bossman075@gmail.com>
+ */
+#include <linux/clk.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/imxrt1170-clock.h>
+
+#include "clk.h"
+
+#define CLOCK_MUX_DEFAULT "rcosc48M_div2", "osc", "rcosc400M", "rcosc16M"
+
+#define LPCG_GATE(gate) (0x6000 + (gate * 0x20))
+
+#define DEF_CLOCK(flags, macro, name) \
+do { \
+	hws[macro##_SEL] = imx_clk_hw_mux(#name"_sel", ccm_base + (name * 0x80), \
+		8, 3, root_clocks[name], 8); \
+	hws[macro##_GATE] = imx_clk_hw_gate_dis_flags(#name"_gate", #name"_sel", \
+		ccm_base + (name * 0x80), 24, flags); \
+	hws[macro] = imx_clk_hw_divider(#name, #name"_gate", ccm_base + (name * 0x80), 0, 8); \
+} while (0)
+
+enum root_clock_names {
+	m7,		/* root clock m7. */
+	m4,		/* root clock m4. */
+	bus,		/* root clock bus. */
+	bus_lpsr,	/* root clock bus lpsr. */
+	semc,		/* root clock semc. */
+	cssys,		/* root clock cssys. */
+	cstrace,	/* root clock cstrace. */
+	m4_systick,	/* root clock m4 systick. */
+	m7_systick,	/* root clock m7 systick. */
+	adc1,		/* root clock adc1. */
+	adc2,		/* root clock adc2. */
+	acmp,		/* root clock acmp. */
+	flexio1,	/* root clock flexio1. */
+	flexio2,	/* root clock flexio2. */
+	gpt1,		/* root clock gpt1. */
+	gpt2,		/* root clock gpt2. */
+	gpt3,		/* root clock gpt3. */
+	gpt4,		/* root clock gpt4. */
+	gpt5,		/* root clock gpt5. */
+	gpt6,		/* root clock gpt6. */
+	flexspi1,	/* root clock flexspi1. */
+	flexspi2,	/* root clock flexspi2. */
+	can1,		/* root clock can1. */
+	can2,		/* root clock can2. */
+	can3,		/* root clock can3. */
+	lpuart1,	/* root clock lpuart1. */
+	lpuart2,	/* root clock lpuart2. */
+	lpuart3,	/* root clock lpuart3. */
+	lpuart4,	/* root clock lpuart4. */
+	lpuart5,	/* root clock lpuart5. */
+	lpuart6,	/* root clock lpuart6. */
+	lpuart7,	/* root clock lpuart7. */
+	lpuart8,	/* root clock lpuart8. */
+	lpuart9,	/* root clock lpuart9. */
+	lpuart10,	/* root clock lpuart10. */
+	lpuart11,	/* root clock lpuart11. */
+	lpuart12,	/* root clock lpuart12. */
+	lpi2c1,		/* root clock lpi2c1. */
+	lpi2c2,		/* root clock lpi2c2. */
+	lpi2c3,		/* root clock lpi2c3. */
+	lpi2c4,		/* root clock lpi2c4. */
+	lpi2c5,		/* root clock lpi2c5. */
+	lpi2c6,		/* root clock lpi2c6. */
+	lpspi1,		/* root clock lpspi1. */
+	lpspi2,		/* root clock lpspi2. */
+	lpspi3,		/* root clock lpspi3. */
+	lpspi4,		/* root clock lpspi4. */
+	lpspi5,		/* root clock lpspi5. */
+	lpspi6,		/* root clock lpspi6. */
+	emv1,		/* root clock emv1. */
+	emv2,		/* root clock emv2. */
+	enet1,		/* root clock enet1. */
+	enet2,		/* root clock enet2. */
+	enet_qos,	/* root clock enet qos. */
+	enet_25m,	/* root clock enet 25m. */
+	enet_timer1,	/* root clock enet timer1. */
+	enet_timer2,	/* root clock enet timer2. */
+	enet_timer3,	/* root clock enet timer3. */
+	usdhc1,		/* root clock usdhc1. */
+	usdhc2,		/* root clock usdhc2. */
+	asrc,		/* root clock asrc. */
+	mqs,		/* root clock mqs. */
+	mic,		/* root clock mic. */
+	spdif,		/* root clock spdif */
+	sai1,		/* root clock sai1. */
+	sai2,		/* root clock sai2. */
+	sai3,		/* root clock sai3. */
+	sai4,		/* root clock sai4. */
+	gc355,		/* root clock gc355. */
+	lcdif,		/* root clock lcdif. */
+	lcdifv2,	/* root clock lcdifv2. */
+	mipi_ref,	/* root clock mipi ref. */
+	mipi_esc,	/* root clock mipi esc. */
+	csi2,		/* root clock csi2. */
+	csi2_esc,	/* root clock csi2 esc. */
+	csi2_ui,	/* root clock csi2 ui. */
+	csi,		/* root clock csi. */
+	cko1,		/* root clock cko1. */
+	cko2,		/* root clock cko2. */
+	end,		/* root clock end. */
+};
+
+static const char * const root_clocks[79][8] = {
+	{CLOCK_MUX_DEFAULT, "pll_arm", "pll1_sys", "pll3_sys", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_sys", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll1_div5", "pll2_sys", "pll2_pfd1", "pll3_pfd0"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_pfd1", "pll2_sys"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd0", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll3_div2", "pll1_div5", "pll2_pfd0"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_sys", "pll1_div5", "pll_audio", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll_audio", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll3_pfd2", "pll3_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd0", "pll2_sys", "pll2_pfd2", "pll3_sys"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll2_pfd3", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll3_pfd2", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_div2", "pll1_div5", "pll2_sys", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
+	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
+	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
+	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
+	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
+	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
+	{CLOCK_MUX_DEFAULT, "pll1_div2", "pll_audio", "pll1_div5", "pll2_pfd1"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm"},
+	{CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll1_div5", "pll3_div2", "pll_audio", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_sys", "pll3_pfd2", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll_audio", "pll3_pfd2", "pll1_div5", "pll2_pfd3"},
+	{CLOCK_MUX_DEFAULT, "pll3_pfd3", "pll3_sys", "pll_audio", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd1", "pll3_sys", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd2", "pll3_pfd0", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_sys", "pll2_pfd0", "pll3_pfd0", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll2_pfd0", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll3_sys", "pll3_pfd1", "pll_video"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd2", "pll2_sys", "pll3_pfd1", "pll1_div5"},
+	{CLOCK_MUX_DEFAULT, "pll2_pfd3", "rcosc48M", "pll3_pfd1", "pll_audio"}
+};
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
+static struct clk_hw **hws;
+static struct clk_hw_onecell_data *clk_hw_data;
+
+static int imxrt1170_clocks_probe(struct platform_device *pdev)
+{
+	void __iomem *ccm_base;
+	void __iomem *pll_base;
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
+	hws[IMXRT1170_CLK_PLL_ARM_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_SYSV2,
+		"pll_arm_pre", "osc", pll_base + 0x200, 0xff);
+	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL_ARM_PRE], 13);
+	hws[IMXRT1170_CLK_PLL_ARM_BYPASS] = imx_clk_hw_mux("pll_arm_bypass",
+		pll_base + 0x200, 17, 1, pll_arm_mux, 2);
+	hws[IMXRT1170_CLK_PLL_ARM_DIV] = clk_hw_register_divider_table(NULL, "pll_arm_div",
+		"pll_arm_bypass", CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
+		pll_base + 0x200, 15, 2, 0, post_div_table, &imx_ccm_lock);
+	hws[IMXRT1170_CLK_PLL_ARM] = imx_clk_hw_gate("pll_arm", "pll_arm_div", pll_base + 0x200, 14);
+
+	hws[IMXRT1170_CLK_PLL3_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2,
+		"pll3_pre", "osc", pll_base + 0x210, 0x1);
+	imx_clk_hw_pll3_powerbit(hws[IMXRT1170_CLK_PLL3_PRE], 21);
+	hws[IMXRT1170_CLK_PLL3_BYPASS] = imx_clk_hw_mux("pll3_bypass",
+		pll_base + 0x210, 16, 1, pll3_mux, 2);
+	hws[IMXRT1170_CLK_PLL3] = imx_clk_hw_gate("pll3_sys", "pll3_bypass", pll_base + 0x210, 13);
+
+	hws[IMXRT1170_CLK_PLL2_PRE] = imx_clk_hw_pllv3(IMX_PLLV3_GENERICV2,
+		"pll2_pre", "osc", pll_base + 0x240, 0x1);
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
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_M7, m7);
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_M4, m4);
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_BUS, bus);
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_BUS_LPSR, bus_lpsr);
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_SEMC, semc);
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_CSSYS, cssys);
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_CSTRACE, cstrace);
+	DEF_CLOCK(0, IMXRT1170_CLK_M4_SYSTICK, m4_systick);
+	DEF_CLOCK(0, IMXRT1170_CLK_M7_SYSTICK, m7_systick);
+	DEF_CLOCK(0, IMXRT1170_CLK_ADC1, adc1);
+	DEF_CLOCK(0, IMXRT1170_CLK_ADC2, adc2);
+	DEF_CLOCK(0, IMXRT1170_CLK_ACMP, acmp);
+	DEF_CLOCK(0, IMXRT1170_CLK_FLEXIO1, flexio1);
+	DEF_CLOCK(0, IMXRT1170_CLK_FLEXIO2, flexio2);
+	DEF_CLOCK(CLK_IS_CRITICAL, IMXRT1170_CLK_GPT1, gpt1);
+	DEF_CLOCK(0, IMXRT1170_CLK_GPT2, gpt2);
+	DEF_CLOCK(0, IMXRT1170_CLK_GPT3, gpt3);
+	DEF_CLOCK(0, IMXRT1170_CLK_GPT4, gpt4);
+	DEF_CLOCK(0, IMXRT1170_CLK_GPT5, gpt5);
+	DEF_CLOCK(0, IMXRT1170_CLK_GPT6, gpt6);
+	DEF_CLOCK(0, IMXRT1170_CLK_FLEXSPI1, flexspi1);
+	DEF_CLOCK(0, IMXRT1170_CLK_FLEXSPI2, flexspi2);
+	DEF_CLOCK(0, IMXRT1170_CLK_CAN1, can1);
+	DEF_CLOCK(0, IMXRT1170_CLK_CAN2, can2);
+	DEF_CLOCK(0, IMXRT1170_CLK_CAN3, can3);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART1, lpuart1);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART2, lpuart2);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART3, lpuart3);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART4, lpuart4);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART5, lpuart5);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART6, lpuart6);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART7, lpuart7);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART8, lpuart8);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART9, lpuart9);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART10, lpuart10);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART11, lpuart11);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPUART12, lpuart12);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C1, lpi2c1);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C2, lpi2c2);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C3, lpi2c3);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C4, lpi2c4);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C5, lpi2c5);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPI2C6, lpi2c6);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI1, lpspi1);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI2, lpspi2);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI3, lpspi3);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI4, lpspi4);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI5, lpspi5);
+	DEF_CLOCK(0, IMXRT1170_CLK_LPSPI6, lpspi6);
+	DEF_CLOCK(0, IMXRT1170_CLK_EMV1, emv1);
+	DEF_CLOCK(0, IMXRT1170_CLK_EMV2, emv2);
+	DEF_CLOCK(0, IMXRT1170_CLK_ENET1, enet1);
+	DEF_CLOCK(0, IMXRT1170_CLK_ENET2, enet2);
+	DEF_CLOCK(0, IMXRT1170_CLK_ENET_QOS, enet_qos);
+	DEF_CLOCK(0, IMXRT1170_CLK_ENET_25M, enet_25m);
+	DEF_CLOCK(0, IMXRT1170_CLK_ENET_TIMER1, enet_timer1);
+	DEF_CLOCK(0, IMXRT1170_CLK_ENET_TIMER2, enet_timer2);
+	DEF_CLOCK(0, IMXRT1170_CLK_ENET_TIMER3, enet_timer3);
+	DEF_CLOCK(0, IMXRT1170_CLK_USDHC1, usdhc1);
+	DEF_CLOCK(0, IMXRT1170_CLK_USDHC2, usdhc2);
+	DEF_CLOCK(0, IMXRT1170_CLK_ASRC, asrc);
+	DEF_CLOCK(0, IMXRT1170_CLK_MQS, mqs);
+	DEF_CLOCK(0, IMXRT1170_CLK_MIC, mic);
+	DEF_CLOCK(0, IMXRT1170_CLK_SPDIF, spdif);
+	DEF_CLOCK(0, IMXRT1170_CLK_SAI1, sai1);
+	DEF_CLOCK(0, IMXRT1170_CLK_SAI2, sai2);
+	DEF_CLOCK(0, IMXRT1170_CLK_SAI3, sai3);
+	DEF_CLOCK(0, IMXRT1170_CLK_SAI4, sai4);
+	DEF_CLOCK(0, IMXRT1170_CLK_GC355, gc355);
+	DEF_CLOCK(0, IMXRT1170_CLK_LCDIF, lcdif);
+	DEF_CLOCK(0, IMXRT1170_CLK_LCDIFV2, lcdifv2);
+	DEF_CLOCK(0, IMXRT1170_CLK_MIPI_REF, mipi_ref);
+	DEF_CLOCK(0, IMXRT1170_CLK_MIPI_ESC, mipi_esc);
+	DEF_CLOCK(0, IMXRT1170_CLK_CSI2, csi2);
+	DEF_CLOCK(0, IMXRT1170_CLK_CSI2_ESC, csi2_esc);
+	DEF_CLOCK(0, IMXRT1170_CLK_CSI2_UI, csi2_ui);
+	DEF_CLOCK(0, IMXRT1170_CLK_CSI, csi);
+	DEF_CLOCK(0, IMXRT1170_CLK_CKO1, cko1);
+	DEF_CLOCK(0, IMXRT1170_CLK_CKO2, cko2);
+
+	hws[IMXRT1170_CLK_USB] = imx_clk_hw_gate("usb", "bus", ccm_base + LPCG_GATE(115), 0);
+
+	clk_set_rate(hws[IMXRT1170_CLK_PLL_ARM]->clk, 90000000);
+
+	imx_check_clk_hws(hws, IMXRT1170_CLK_END);
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register clks for i.MXRT1170.\n");
+		imx_unregister_hw_clocks(hws, IMXRT1170_CLK_END);
+	}
+	return ret;
+
+	return 0;
+}
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
2.34.1

