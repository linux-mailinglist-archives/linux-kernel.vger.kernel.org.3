Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA05166AC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353411AbiEARiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiEARiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:38:11 -0400
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4542558A;
        Sun,  1 May 2022 10:34:45 -0700 (PDT)
From:   "Marty E. Plummer" <hanetzer@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1651426483;
        bh=uKzsMocNPxB/1naUTtl2JkyJA/D3L/SWYnjbfsqOT1w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=WYaiRbatvJm/8SQF7Nzn7XFo7NjpgIMTOuO6l/SERnqOHLbnzovP0hbOpjzheVFA0
         0vd/8SuWOqDGi5q9G77a59Hm29i/KKTgrb3VmEEJsAobFAXCTIYwQlqZbvnO60bAa4
         ZQCzPjg9Ri9/6F8LVdGdXY9QCIm9q1ySoiOgVXCTKvOsw+1b76ZEclu90t3oTBLC8A
         Gdx4RqezEJ0AqVHN3b3MX7gU6F/LGWDKaqMlS4qhduESRCw+GeOavpG67HbdhJyKQ7
         epFmTVi7VetgStPqxwk5g1BpJIFooQiQKhfFRpwoEk9k6Xvb4EavAwlTo+Mh34aC+z
         zUCQgDLWAaR5Q==
To:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        hanetzer@startmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
Subject: [RFC v2 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Date:   Sun,  1 May 2022 12:34:22 -0500
Message-Id: <20220501173423.2473093-2-hanetzer@startmail.com>
In-Reply-To: <20220501173423.2473093-1-hanetzer@startmail.com>
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
generates clock and reset signals used by other module blocks on SoC.

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
 drivers/clk/hisilicon/Kconfig             |   8 ++
 drivers/clk/hisilicon/Makefile            |   1 +
 drivers/clk/hisilicon/crg-hi3521a.c       | 141 ++++++++++++++++++++++
 include/dt-bindings/clock/hi3521a-clock.h |  34 ++++++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/clk/hisilicon/crg-hi3521a.c
 create mode 100644 include/dt-bindings/clock/hi3521a-clock.h

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index c1ec75aa4ccd..72435c06bf4d 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -15,6 +15,14 @@ config COMMON_CLK_HI3519
 	help
 	  Build the clock driver for hi3519.
 
+config COMMON_CLK_HI3521A
+	tristate "Hi3521a Clock Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	select RESET_HISI
+	default ARCH_HISI
+	help
+	  Build the clock driver for hi3521a.
+
 config COMMON_CLK_HI3559A
 	bool "Hi3559A Clock Driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 2978e56cb876..dc27acc5b885 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
 obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
 obj-$(CONFIG_COMMON_CLK_HI3516CV300)	+= crg-hi3516cv300.o
 obj-$(CONFIG_COMMON_CLK_HI3519)	+= clk-hi3519.o
+obj-$(CONFIG_COMMON_CLK_HI3521A)	+= crg-hi3521a.o
 obj-$(CONFIG_COMMON_CLK_HI3559A)	+= clk-hi3559a.o
 obj-$(CONFIG_COMMON_CLK_HI3660) += clk-hi3660.o
 obj-$(CONFIG_COMMON_CLK_HI3670) += clk-hi3670.o
diff --git a/drivers/clk/hisilicon/crg-hi3521a.c b/drivers/clk/hisilicon/crg-hi3521a.c
new file mode 100644
index 000000000000..42d8ff440f07
--- /dev/null
+++ b/drivers/clk/hisilicon/crg-hi3521a.c
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier:	GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017-2022 Marty E. Plummer <hanetzer@startmail.com>
+ */
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/hi3521a-clock.h>
+
+#include "clk.h"
+#include "crg.h"
+#include "reset.h"
+
+#define HI3521A_INNER_CLK_OFFSET	64
+#define HI3521A_FIXED_2M			65
+#define HI3521A_FIXED_24M			66
+#define HI3521A_FIXED_50M			67
+#define HI3521A_FIXED_83M			68
+#define HI3521A_FIXED_100M			69
+#define HI3521A_FIXED_150M			70
+#define HI3521A_FIXED_202P5M		71
+#define HI3521A_FIXED_250M			72
+#define HI3521A_SYSAXI_MUX			73
+#define HI3521A_FMC_MUX				74
+#define HI3521A_UART_MUX			75
+#define HI3521A_SP804_CLK			76
+
+#define HI3521A_NR_CLKS				128
+
+static const struct hisi_fixed_rate_clock hi3521a_fixed_rate_clks[] = {
+	{ HI3521A_FIXED_2M,         "2m", NULL, 0,   2000000, },
+	{ HI3521A_FIXED_3M,         "3m", NULL, 0,   3000000, },
+	{ HI3521A_FIXED_24M,       "24m", NULL, 0,  24000000, },
+	{ HI3521A_FIXED_50M,       "50m", NULL, 0,  50000000, },
+	{ HI3521A_FIXED_83M,       "83m", NULL, 0,  83000000, },
+	{ HI3521A_FIXED_100M,     "100m", NULL, 0, 100000000, },
+	{ HI3521A_FIXED_150M,     "150m", NULL, 0, 150000000, },
+	{ HI3521A_FIXED_202P5M, "202p5m", NULL, 0, 202500000, },
+	{ HI3521A_FIXED_250M,     "250m", NULL, 0, 250000000, },
+};
+
+static const char *const sysaxi_mux_p[] = { "24m", "250m", "202p5m", };
+static const char *const uart_mux_p[] = { "apb", "2m", "24m", };
+static const char *const fmc_mux_p[] = { "24m", "83m", "150m", };
+static const char *const timer_mux_p[] = { "3m", "clk_sp804", };
+
+static const u32 sysaxi_mux_table[] = {0, 1, 2};
+static const u32 uart_mux_table[] = {0, 1, 2};
+static const u32 fmc_mux_table[] = {0, 1, 2};
+static const u32 timer_mux_table[] = {0, 1};
+
+static const struct hisi_mux_clock hi3521a_mux_clks[] = {
+	{ HI3521A_APB_CLK, "apb", sysaxi_mux_p, ARRAY_SIZE(sysaxi_mux_p),
+		CLK_SET_RATE_PARENT, 0x34, 12, 2, 0, sysaxi_mux_table, },
+	{ HI3521A_UART_MUX, "uart_mux", uart_mux_p, ARRAY_SIZE(uart_mux_p),
+		CLK_SET_RATE_PARENT, 0x84, 18, 2, 0, uart_mux_table, },
+	{ HI3521A_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
+		CLK_SET_RATE_PARENT, 0x74, 2, 2, 0, fmc_mux_table, },
+};
+
+static const struct hisi_gate_clock hi3521a_gate_clks[] = {
+	{ HI3521A_FMC_CLK, "clk_fmc", "fmc_mux", CLK_SET_RATE_PARENT,
+		0x74, 1, 0, },
+	{ HI3521A_ETH_CLK, "clk_eth", NULL, 0, 0x78, 1, 0, },
+	{ HI3521A_ETH_MACIF_CLK, "clk_eth_macif", NULL, 0x78, 3, 0, },
+	{ HI3521A_DMAC_CLK, "clk_dmac", NULL, 0, 0x80, 5, 0, },
+	{ HI3521A_UART0_CLK, "clk_uart0", "uart_mux", CLK_SET_RATE_PARENT,
+		0x84, 15, 0, },
+	{ HI3521A_UART1_CLK, "clk_uart1", "uart_mux", CLK_SET_RATE_PARENT,
+		0x84, 16, 0, },
+	{ HI3521A_UART2_CLK, "clk_uart2", "uart_mux", CLK_SET_RATE_PARENT,
+		0x84, 17, 0, },
+	{ HI3521A_SPI0_CLK, "clk_spi0", "50m", CLK_SET_RATE_PARENT,
+		0x84, 13, 0, },
+};
+
+static const struct hisi_fixed_factor_clock hi3521a_fixed_factor_clks[] = {
+	{ HI3521A_SP804_CLK, "clk_sp804", "apb", 1, 4, CLK_SET_RATE_PARENT },
+};
+
+static void __init hi3521a_crg_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HI3521A_NR_CLKS);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_fixed_rate(hi3521a_fixed_rate_clks,
+				ARRAY_SIZE(hi3521a_fixed_rate_clks),
+				clk_data);
+	hisi_clk_register_mux(hi3521a_mux_clks,
+				ARRAY_SIZE(hi3521a_mux_clks),
+				clk_data);
+	hisi_clk_register_gate(hi3521a_gate_clks,
+				ARRAY_SIZE(hi3521a_gate_clks),
+				clk_data);
+	hisi_clk_register_fixed_factor(hi3521a_fixed_factor_clks,
+				ARRAY_SIZE(hi3521a_fixed_factor_clks),
+				clk_data);
+}
+CLK_OF_DECLARE(hi3521a_clk, "hisilicon,hi3521a-crg", hi3521a_crg_init);
+
+#define HI3521A_SYSCTRL_NR_CLKS 16
+
+static const struct hisi_mux_clock hi3521a_sysctrl_mux_clks[] = {
+	{ HI3521A_TIMER0_CLK, "clk_timer0", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 16, 1, 0, timer_mux_table, },
+	{ HI3521A_TIMER1_CLK, "clk_timer1", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 18, 1, 0, timer_mux_table, },
+	{ HI3521A_TIMER2_CLK, "clk_timer2", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 20, 1, 0, timer_mux_table, },
+	{ HI3521A_TIMER3_CLK, "clk_timer3", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 22, 1, 0, timer_mux_table, },
+	{ HI3521A_TIMER4_CLK, "clk_timer4", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 25, 1, 0, timer_mux_table, },
+	{ HI3521A_TIMER5_CLK, "clk_timer5", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 27, 1, 0, timer_mux_table, },
+	{ HI3521A_TIMER6_CLK, "clk_timer6", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 29, 1, 0, timer_mux_table, },
+	{ HI3521A_TIMER7_CLK, "clk_timer7", timer_mux_p, ARRAY_SIZE(timer_mux_p),
+		CLK_SET_RATE_PARENT, 0, 31, 1, 0, timer_mux_table, },
+};
+
+static void __init hi3521a_sysctrl_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HI3521A_SYSCTRL_NR_CLKS);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_mux(hi3521a_sysctrl_mux_clks,
+				ARRAY_SIZE(hi3521a_sysctrl_mux_clks),
+				clk_data);
+}
+CLK_OF_DECLARE(hi3521a_sysctrl, "hisilicon,hi3521a-sysctrl", hi3521a_sysctrl_init);
diff --git a/include/dt-bindings/clock/hi3521a-clock.h b/include/dt-bindings/clock/hi3521a-clock.h
new file mode 100644
index 000000000000..416a08079002
--- /dev/null
+++ b/include/dt-bindings/clock/hi3521a-clock.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier:	GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017-2022 Marty E. Plummer <hanetzer@startmail.com>
+ */
+
+#ifndef __DTS_HI3521A_CLOCK_H
+#define __DTS_HI3521A_CLOCK_H
+
+/* clocks provided by the crg */
+#define HI3521A_FIXED_3M		1
+#define HI3521A_FMC_CLK			2
+#define HI3521A_SPI0_CLK		3
+#define HI3521A_UART0_CLK		4
+#define HI3521A_UART1_CLK		5
+#define HI3521A_UART2_CLK		6
+#define HI3521A_DMAC_CLK		7
+#define HI3521A_IR_CLK			8
+#define HI3521A_ETH_CLK			9
+#define HI3521A_ETH_MACIF_CLK	10
+#define HI3521A_USB2_BUS_CLK	11
+#define HI3521A_USB2_PORT_CLK	12
+#define HI3521A_APB_CLK			13
+
+/* clocks provided by the sysctrl */
+#define HI3521A_TIMER0_CLK		1
+#define HI3521A_TIMER1_CLK		2
+#define HI3521A_TIMER2_CLK		3
+#define HI3521A_TIMER3_CLK		4
+#define HI3521A_TIMER4_CLK		5
+#define HI3521A_TIMER5_CLK		6
+#define HI3521A_TIMER6_CLK		7
+#define HI3521A_TIMER7_CLK		8
+
+#endif /* __DTS_HI3521A_CLK_H */
-- 
2.35.1

