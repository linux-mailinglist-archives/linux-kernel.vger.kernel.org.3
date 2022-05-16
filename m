Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3999527E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbiEPHGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbiEPHGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:06:43 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2930DFE6;
        Mon, 16 May 2022 00:06:39 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FLqfvZ020075;
        Mon, 16 May 2022 09:06:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=cYjwLbRLzYdDsFLihisSfMN+XqGpgF132qjaGsQ6oyU=;
 b=bH+Eekdvt8MylIj4GR+fujTXW6sS4jY8FROCyVIVDVsakdphaA/YK+Gug4VYuF+dh5lv
 +S72dhd3VWI+XU+WL5PM9sInCduZV3e5Tl67DUJ741pYV7b1ekK2nlCfJgAx2QQgR16s
 mIi2k9z+SMcRrAINpJn0VEnq2ZNVLVvym56WUSfV/lPt/2uT3FW7rkydQHi45EDxkpUw
 yRxx8krDuu90W3XxpjT7o2+QrlBui7pcVtzhh1VL/e6gLzom+ZsdqOmvO/qVRv7XNafG
 1aPoGfJeqkaasfPKiFcco+st4uoSdHliRyuUBXMwZ40EmGxmpb1JY8KtCpwdC+uUQxJB BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21ukfpe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 09:06:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71BF810003A;
        Mon, 16 May 2022 09:06:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A58D2122F8;
        Mon, 16 May 2022 09:06:04 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 09:06:03
 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 02/14] clk: stm32: Introduce STM32MP13 RCC drivers (Reset Clock Controller)
Date:   Mon, 16 May 2022 09:05:48 +0200
Message-ID: <20220516070600.7692-3-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_03,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

This driver manages Reset and Clock of STM32MP13 soc.
It uses a clk-stm32-core module to manage stm32 gate, mux and divider
for STM32MP13 and for new future soc.

All gates, muxes, dividers are identify by an index and information
are stored in array (register address, shift, with, flags...)
This is useful when we have two clocks with the same gate or
when one mux manages two output clocks.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/Kconfig                |    5 +
 drivers/clk/Makefile               |    1 +
 drivers/clk/stm32/Makefile         |    1 +
 drivers/clk/stm32/clk-stm32-core.c |   93 ++
 drivers/clk/stm32/clk-stm32-core.h |   92 ++
 drivers/clk/stm32/clk-stm32mp13.c  |  520 +++++++++
 drivers/clk/stm32/reset-stm32.c    |  122 ++
 drivers/clk/stm32/reset-stm32.h    |    8 +
 drivers/clk/stm32/stm32mp13_rcc.h  | 1748 ++++++++++++++++++++++++++++
 9 files changed, 2590 insertions(+)
 create mode 100644 drivers/clk/stm32/Makefile
 create mode 100644 drivers/clk/stm32/clk-stm32-core.c
 create mode 100644 drivers/clk/stm32/clk-stm32-core.h
 create mode 100644 drivers/clk/stm32/clk-stm32mp13.c
 create mode 100644 drivers/clk/stm32/reset-stm32.c
 create mode 100644 drivers/clk/stm32/reset-stm32.h
 create mode 100644 drivers/clk/stm32/stm32mp13_rcc.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3148d14702df..48f8f4221e21 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -377,6 +377,11 @@ config COMMON_CLK_VC5
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
 
+config COMMON_CLK_STM32MP135
+	def_bool COMMON_CLK && MACH_STM32MP13
+	help
+	  Support for stm32mp135 SoC family clocks
+
 config COMMON_CLK_STM32MP157
 	def_bool COMMON_CLK && MACH_STM32MP157
 	help
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 9db4f63fb71e..d5db170d38d2 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -115,6 +115,7 @@ obj-y					+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
+obj-$(CONFIG_ARCH_STM32)		+= stm32/
 obj-$(CONFIG_SOC_STARFIVE)		+= starfive/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-y					+= sunxi-ng/
diff --git a/drivers/clk/stm32/Makefile b/drivers/clk/stm32/Makefile
new file mode 100644
index 000000000000..95bd2230bba0
--- /dev/null
+++ b/drivers/clk/stm32/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_COMMON_CLK_STM32MP135)	+= clk-stm32mp13.o clk-stm32-core.o reset-stm32.o
diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
new file mode 100644
index 000000000000..0fab4a5a8c66
--- /dev/null
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "clk-stm32-core.h"
+#include "reset-stm32.h"
+
+static DEFINE_SPINLOCK(rlock);
+
+static int stm32_rcc_clock_init(struct device *dev,
+				const struct of_device_id *match,
+				void __iomem *base)
+{
+	const struct stm32_rcc_match_data *data = match->data;
+	struct clk_hw_onecell_data *clk_data = data->hw_clks;
+	struct device_node *np = dev_of_node(dev);
+	struct clk_hw **hws;
+	int n, max_binding;
+
+	max_binding =  data->maxbinding;
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, max_binding), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = max_binding;
+
+	hws = clk_data->hws;
+
+	for (n = 0; n < max_binding; n++)
+		hws[n] = ERR_PTR(-ENOENT);
+
+	for (n = 0; n < data->num_clocks; n++) {
+		const struct clock_config *cfg_clock = &data->tab_clocks[n];
+		struct clk_hw *hw = ERR_PTR(-ENOENT);
+
+		if (cfg_clock->func)
+			hw = (*cfg_clock->func)(dev, data, base, &rlock,
+						cfg_clock);
+
+		if (IS_ERR(hw)) {
+			dev_err(dev, "Can't register clk %d: %ld\n", n,
+				PTR_ERR(hw));
+			return PTR_ERR(hw);
+		}
+
+		if (cfg_clock->id != NO_ID)
+			hws[cfg_clock->id] = hw;
+	}
+
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+
+int stm32_rcc_init(struct device *dev, const struct of_device_id *match_data,
+		   void __iomem *base)
+{
+	const struct of_device_id *match;
+	int err;
+
+	match = of_match_node(match_data, dev_of_node(dev));
+	if (!match) {
+		dev_err(dev, "match data not found\n");
+		return -ENODEV;
+	}
+
+	/* RCC Reset Configuration */
+	err = stm32_rcc_reset_init(dev, match, base);
+	if (err) {
+		pr_err("stm32 reset failed to initialize\n");
+		return err;
+	}
+
+	/* RCC Clock Configuration */
+	err = stm32_rcc_clock_init(dev, match, base);
+	if (err) {
+		pr_err("stm32 clock failed to initialize\n");
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/stm32/clk-stm32-core.h b/drivers/clk/stm32/clk-stm32-core.h
new file mode 100644
index 000000000000..519723ae97eb
--- /dev/null
+++ b/drivers/clk/stm32/clk-stm32-core.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0  */
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
+ */
+
+#include <linux/clk-provider.h>
+
+struct stm32_rcc_match_data;
+
+struct stm32_mux_cfg {
+	u16	offset;
+	u8	shift;
+	u8	width;
+	u8	flags;
+	u32	*table;
+	u8	ready;
+};
+
+struct stm32_gate_cfg {
+	u16	offset;
+	u8	bit_idx;
+	u8	set_clr;
+};
+
+struct stm32_div_cfg {
+	u16	offset;
+	u8	shift;
+	u8	width;
+	u8	flags;
+	u8	ready;
+	const struct clk_div_table *table;
+};
+
+struct stm32_composite_cfg {
+	int	mux;
+	int	gate;
+	int	div;
+};
+
+#define NO_ID 0xFFFFFFFF
+
+#define NO_STM32_MUX		0xFFFF
+#define NO_STM32_DIV		0xFFFF
+#define NO_STM32_GATE		0xFFFF
+
+struct clock_config {
+	unsigned long	id;
+	void		*clock_cfg;
+
+	struct clk_hw *(*func)(struct device *dev,
+			       const struct stm32_rcc_match_data *data,
+			       void __iomem *base,
+			       spinlock_t *lock,
+			       const struct clock_config *cfg);
+};
+
+struct clk_stm32_clock_data {
+	u16 *gate_cpt;
+	const struct stm32_gate_cfg	*gates;
+	const struct stm32_mux_cfg	*muxes;
+	const struct stm32_div_cfg	*dividers;
+};
+
+struct stm32_rcc_match_data {
+	struct clk_hw_onecell_data	*hw_clks;
+	unsigned int			num_clocks;
+	const struct clock_config	*tab_clocks;
+	unsigned int			maxbinding;
+	struct clk_stm32_clock_data	*clock_data;
+	u32				clear_offset;
+};
+
+int stm32_rcc_reset_init(struct device *dev, const struct of_device_id *match,
+			 void __iomem *base);
+
+int stm32_rcc_init(struct device *dev, const struct of_device_id *match_data,
+		   void __iomem *base);
+
+/* MUX define */
+#define MUX_NO_RDY		0xFF
+
+/* DIV define */
+#define DIV_NO_RDY		0xFF
+
+/* Clock registering */
+#define STM32_CLOCK_CFG(_binding, _clk, _struct, _register)\
+{\
+	.id		= (_binding),\
+	.clock_cfg	= (_struct) {_clk},\
+	.func		= (_register),\
+}
diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-stm32mp13.c
new file mode 100644
index 000000000000..a2a6bbb4ace5
--- /dev/null
+++ b/drivers/clk/stm32/clk-stm32mp13.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/stm32mp13-clks.h>
+#include "clk-stm32-core.h"
+#include "stm32mp13_rcc.h"
+
+#define RCC_CLR_OFFSET		0x4
+
+/* STM32 Gates definition */
+enum enum_gate_cfg {
+	GATE_MCO1,
+	GATE_MCO2,
+	GATE_DBGCK,
+	GATE_TRACECK,
+	GATE_DDRC1,
+	GATE_DDRC1LP,
+	GATE_DDRPHYC,
+	GATE_DDRPHYCLP,
+	GATE_DDRCAPB,
+	GATE_DDRCAPBLP,
+	GATE_AXIDCG,
+	GATE_DDRPHYCAPB,
+	GATE_DDRPHYCAPBLP,
+	GATE_TIM2,
+	GATE_TIM3,
+	GATE_TIM4,
+	GATE_TIM5,
+	GATE_TIM6,
+	GATE_TIM7,
+	GATE_LPTIM1,
+	GATE_SPI2,
+	GATE_SPI3,
+	GATE_USART3,
+	GATE_UART4,
+	GATE_UART5,
+	GATE_UART7,
+	GATE_UART8,
+	GATE_I2C1,
+	GATE_I2C2,
+	GATE_SPDIF,
+	GATE_TIM1,
+	GATE_TIM8,
+	GATE_SPI1,
+	GATE_USART6,
+	GATE_SAI1,
+	GATE_SAI2,
+	GATE_DFSDM,
+	GATE_ADFSDM,
+	GATE_FDCAN,
+	GATE_LPTIM2,
+	GATE_LPTIM3,
+	GATE_LPTIM4,
+	GATE_LPTIM5,
+	GATE_VREF,
+	GATE_DTS,
+	GATE_PMBCTRL,
+	GATE_HDP,
+	GATE_SYSCFG,
+	GATE_DCMIPP,
+	GATE_DDRPERFM,
+	GATE_IWDG2APB,
+	GATE_USBPHY,
+	GATE_STGENRO,
+	GATE_LTDC,
+	GATE_RTCAPB,
+	GATE_TZC,
+	GATE_ETZPC,
+	GATE_IWDG1APB,
+	GATE_BSEC,
+	GATE_STGENC,
+	GATE_USART1,
+	GATE_USART2,
+	GATE_SPI4,
+	GATE_SPI5,
+	GATE_I2C3,
+	GATE_I2C4,
+	GATE_I2C5,
+	GATE_TIM12,
+	GATE_TIM13,
+	GATE_TIM14,
+	GATE_TIM15,
+	GATE_TIM16,
+	GATE_TIM17,
+	GATE_DMA1,
+	GATE_DMA2,
+	GATE_DMAMUX1,
+	GATE_DMA3,
+	GATE_DMAMUX2,
+	GATE_ADC1,
+	GATE_ADC2,
+	GATE_USBO,
+	GATE_TSC,
+	GATE_GPIOA,
+	GATE_GPIOB,
+	GATE_GPIOC,
+	GATE_GPIOD,
+	GATE_GPIOE,
+	GATE_GPIOF,
+	GATE_GPIOG,
+	GATE_GPIOH,
+	GATE_GPIOI,
+	GATE_PKA,
+	GATE_SAES,
+	GATE_CRYP1,
+	GATE_HASH1,
+	GATE_RNG1,
+	GATE_BKPSRAM,
+	GATE_AXIMC,
+	GATE_MCE,
+	GATE_ETH1CK,
+	GATE_ETH1TX,
+	GATE_ETH1RX,
+	GATE_ETH1MAC,
+	GATE_FMC,
+	GATE_QSPI,
+	GATE_SDMMC1,
+	GATE_SDMMC2,
+	GATE_CRC1,
+	GATE_USBH,
+	GATE_ETH2CK,
+	GATE_ETH2TX,
+	GATE_ETH2RX,
+	GATE_ETH2MAC,
+	GATE_ETH1STP,
+	GATE_ETH2STP,
+	GATE_MDMA,
+	GATE_NB
+};
+
+#define _CFG_GATE(_id, _offset, _bit_idx, _offset_clr)\
+	[(_id)] = {\
+		.offset		= (_offset),\
+		.bit_idx	= (_bit_idx),\
+		.set_clr	= (_offset_clr),\
+	}
+
+#define CFG_GATE(_id, _offset, _bit_idx)\
+	_CFG_GATE(_id, _offset, _bit_idx, 0)
+
+#define CFG_GATE_SETCLR(_id, _offset, _bit_idx)\
+	_CFG_GATE(_id, _offset, _bit_idx, RCC_CLR_OFFSET)
+
+static struct stm32_gate_cfg stm32mp13_gates[] = {
+	CFG_GATE(GATE_MCO1,		RCC_MCO1CFGR,		12),
+	CFG_GATE(GATE_MCO2,		RCC_MCO2CFGR,		12),
+	CFG_GATE(GATE_DBGCK,		RCC_DBGCFGR,		8),
+	CFG_GATE(GATE_TRACECK,		RCC_DBGCFGR,		9),
+	CFG_GATE(GATE_DDRC1,		RCC_DDRITFCR,		0),
+	CFG_GATE(GATE_DDRC1LP,		RCC_DDRITFCR,		1),
+	CFG_GATE(GATE_DDRPHYC,		RCC_DDRITFCR,		4),
+	CFG_GATE(GATE_DDRPHYCLP,	RCC_DDRITFCR,		5),
+	CFG_GATE(GATE_DDRCAPB,		RCC_DDRITFCR,		6),
+	CFG_GATE(GATE_DDRCAPBLP,	RCC_DDRITFCR,		7),
+	CFG_GATE(GATE_AXIDCG,		RCC_DDRITFCR,		8),
+	CFG_GATE(GATE_DDRPHYCAPB,	RCC_DDRITFCR,		9),
+	CFG_GATE(GATE_DDRPHYCAPBLP,	RCC_DDRITFCR,		10),
+	CFG_GATE_SETCLR(GATE_TIM2,	RCC_MP_APB1ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_TIM3,	RCC_MP_APB1ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_TIM4,	RCC_MP_APB1ENSETR,	2),
+	CFG_GATE_SETCLR(GATE_TIM5,	RCC_MP_APB1ENSETR,	3),
+	CFG_GATE_SETCLR(GATE_TIM6,	RCC_MP_APB1ENSETR,	4),
+	CFG_GATE_SETCLR(GATE_TIM7,	RCC_MP_APB1ENSETR,	5),
+	CFG_GATE_SETCLR(GATE_LPTIM1,	RCC_MP_APB1ENSETR,	9),
+	CFG_GATE_SETCLR(GATE_SPI2,	RCC_MP_APB1ENSETR,	11),
+	CFG_GATE_SETCLR(GATE_SPI3,	RCC_MP_APB1ENSETR,	12),
+	CFG_GATE_SETCLR(GATE_USART3,	RCC_MP_APB1ENSETR,	15),
+	CFG_GATE_SETCLR(GATE_UART4,	RCC_MP_APB1ENSETR,	16),
+	CFG_GATE_SETCLR(GATE_UART5,	RCC_MP_APB1ENSETR,	17),
+	CFG_GATE_SETCLR(GATE_UART7,	RCC_MP_APB1ENSETR,	18),
+	CFG_GATE_SETCLR(GATE_UART8,	RCC_MP_APB1ENSETR,	19),
+	CFG_GATE_SETCLR(GATE_I2C1,	RCC_MP_APB1ENSETR,	21),
+	CFG_GATE_SETCLR(GATE_I2C2,	RCC_MP_APB1ENSETR,	22),
+	CFG_GATE_SETCLR(GATE_SPDIF,	RCC_MP_APB1ENSETR,	26),
+	CFG_GATE_SETCLR(GATE_TIM1,	RCC_MP_APB2ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_TIM8,	RCC_MP_APB2ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_SPI1,	RCC_MP_APB2ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_USART6,	RCC_MP_APB2ENSETR,	13),
+	CFG_GATE_SETCLR(GATE_SAI1,	RCC_MP_APB2ENSETR,	16),
+	CFG_GATE_SETCLR(GATE_SAI2,	RCC_MP_APB2ENSETR,	17),
+	CFG_GATE_SETCLR(GATE_DFSDM,	RCC_MP_APB2ENSETR,	20),
+	CFG_GATE_SETCLR(GATE_ADFSDM,	RCC_MP_APB2ENSETR,	21),
+	CFG_GATE_SETCLR(GATE_FDCAN,	RCC_MP_APB2ENSETR,	24),
+	CFG_GATE_SETCLR(GATE_LPTIM2,	RCC_MP_APB3ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_LPTIM3,	RCC_MP_APB3ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_LPTIM4,	RCC_MP_APB3ENSETR,	2),
+	CFG_GATE_SETCLR(GATE_LPTIM5,	RCC_MP_APB3ENSETR,	3),
+	CFG_GATE_SETCLR(GATE_VREF,	RCC_MP_APB3ENSETR,	13),
+	CFG_GATE_SETCLR(GATE_DTS,	RCC_MP_APB3ENSETR,	16),
+	CFG_GATE_SETCLR(GATE_PMBCTRL,	RCC_MP_APB3ENSETR,	17),
+	CFG_GATE_SETCLR(GATE_HDP,	RCC_MP_APB3ENSETR,	20),
+	CFG_GATE_SETCLR(GATE_SYSCFG,	RCC_MP_NS_APB3ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_DCMIPP,	RCC_MP_APB4ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_DDRPERFM,	RCC_MP_APB4ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_IWDG2APB,	RCC_MP_APB4ENSETR,	15),
+	CFG_GATE_SETCLR(GATE_USBPHY,	RCC_MP_APB4ENSETR,	16),
+	CFG_GATE_SETCLR(GATE_STGENRO,	RCC_MP_APB4ENSETR,	20),
+	CFG_GATE_SETCLR(GATE_LTDC,	RCC_MP_NS_APB4ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_RTCAPB,	RCC_MP_APB5ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_TZC,	RCC_MP_APB5ENSETR,	11),
+	CFG_GATE_SETCLR(GATE_ETZPC,	RCC_MP_APB5ENSETR,	13),
+	CFG_GATE_SETCLR(GATE_IWDG1APB,	RCC_MP_APB5ENSETR,	15),
+	CFG_GATE_SETCLR(GATE_BSEC,	RCC_MP_APB5ENSETR,	16),
+	CFG_GATE_SETCLR(GATE_STGENC,	RCC_MP_APB5ENSETR,	20),
+	CFG_GATE_SETCLR(GATE_USART1,	RCC_MP_APB6ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_USART2,	RCC_MP_APB6ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_SPI4,	RCC_MP_APB6ENSETR,	2),
+	CFG_GATE_SETCLR(GATE_SPI5,	RCC_MP_APB6ENSETR,	3),
+	CFG_GATE_SETCLR(GATE_I2C3,	RCC_MP_APB6ENSETR,	4),
+	CFG_GATE_SETCLR(GATE_I2C4,	RCC_MP_APB6ENSETR,	5),
+	CFG_GATE_SETCLR(GATE_I2C5,	RCC_MP_APB6ENSETR,	6),
+	CFG_GATE_SETCLR(GATE_TIM12,	RCC_MP_APB6ENSETR,	7),
+	CFG_GATE_SETCLR(GATE_TIM13,	RCC_MP_APB6ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_TIM14,	RCC_MP_APB6ENSETR,	9),
+	CFG_GATE_SETCLR(GATE_TIM15,	RCC_MP_APB6ENSETR,	10),
+	CFG_GATE_SETCLR(GATE_TIM16,	RCC_MP_APB6ENSETR,	11),
+	CFG_GATE_SETCLR(GATE_TIM17,	RCC_MP_APB6ENSETR,	12),
+	CFG_GATE_SETCLR(GATE_DMA1,	RCC_MP_AHB2ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_DMA2,	RCC_MP_AHB2ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_DMAMUX1,	RCC_MP_AHB2ENSETR,	2),
+	CFG_GATE_SETCLR(GATE_DMA3,	RCC_MP_AHB2ENSETR,	3),
+	CFG_GATE_SETCLR(GATE_DMAMUX2,	RCC_MP_AHB2ENSETR,	4),
+	CFG_GATE_SETCLR(GATE_ADC1,	RCC_MP_AHB2ENSETR,	5),
+	CFG_GATE_SETCLR(GATE_ADC2,	RCC_MP_AHB2ENSETR,	6),
+	CFG_GATE_SETCLR(GATE_USBO,	RCC_MP_AHB2ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_TSC,	RCC_MP_AHB4ENSETR,	15),
+	CFG_GATE_SETCLR(GATE_GPIOA,	RCC_MP_NS_AHB4ENSETR,	0),
+	CFG_GATE_SETCLR(GATE_GPIOB,	RCC_MP_NS_AHB4ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_GPIOC,	RCC_MP_NS_AHB4ENSETR,	2),
+	CFG_GATE_SETCLR(GATE_GPIOD,	RCC_MP_NS_AHB4ENSETR,	3),
+	CFG_GATE_SETCLR(GATE_GPIOE,	RCC_MP_NS_AHB4ENSETR,	4),
+	CFG_GATE_SETCLR(GATE_GPIOF,	RCC_MP_NS_AHB4ENSETR,	5),
+	CFG_GATE_SETCLR(GATE_GPIOG,	RCC_MP_NS_AHB4ENSETR,	6),
+	CFG_GATE_SETCLR(GATE_GPIOH,	RCC_MP_NS_AHB4ENSETR,	7),
+	CFG_GATE_SETCLR(GATE_GPIOI,	RCC_MP_NS_AHB4ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_PKA,	RCC_MP_AHB5ENSETR,	2),
+	CFG_GATE_SETCLR(GATE_SAES,	RCC_MP_AHB5ENSETR,	3),
+	CFG_GATE_SETCLR(GATE_CRYP1,	RCC_MP_AHB5ENSETR,	4),
+	CFG_GATE_SETCLR(GATE_HASH1,	RCC_MP_AHB5ENSETR,	5),
+	CFG_GATE_SETCLR(GATE_RNG1,	RCC_MP_AHB5ENSETR,	6),
+	CFG_GATE_SETCLR(GATE_BKPSRAM,	RCC_MP_AHB5ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_AXIMC,	RCC_MP_AHB5ENSETR,	16),
+	CFG_GATE_SETCLR(GATE_MCE,	RCC_MP_AHB6ENSETR,	1),
+	CFG_GATE_SETCLR(GATE_ETH1CK,	RCC_MP_AHB6ENSETR,	7),
+	CFG_GATE_SETCLR(GATE_ETH1TX,	RCC_MP_AHB6ENSETR,	8),
+	CFG_GATE_SETCLR(GATE_ETH1RX,	RCC_MP_AHB6ENSETR,	9),
+	CFG_GATE_SETCLR(GATE_ETH1MAC,	RCC_MP_AHB6ENSETR,	10),
+	CFG_GATE_SETCLR(GATE_FMC,	RCC_MP_AHB6ENSETR,	12),
+	CFG_GATE_SETCLR(GATE_QSPI,	RCC_MP_AHB6ENSETR,	14),
+	CFG_GATE_SETCLR(GATE_SDMMC1,	RCC_MP_AHB6ENSETR,	16),
+	CFG_GATE_SETCLR(GATE_SDMMC2,	RCC_MP_AHB6ENSETR,	17),
+	CFG_GATE_SETCLR(GATE_CRC1,	RCC_MP_AHB6ENSETR,	20),
+	CFG_GATE_SETCLR(GATE_USBH,	RCC_MP_AHB6ENSETR,	24),
+	CFG_GATE_SETCLR(GATE_ETH2CK,	RCC_MP_AHB6ENSETR,	27),
+	CFG_GATE_SETCLR(GATE_ETH2TX,	RCC_MP_AHB6ENSETR,	28),
+	CFG_GATE_SETCLR(GATE_ETH2RX,	RCC_MP_AHB6ENSETR,	29),
+	CFG_GATE_SETCLR(GATE_ETH2MAC,	RCC_MP_AHB6ENSETR,	30),
+	CFG_GATE_SETCLR(GATE_ETH1STP,	RCC_MP_AHB6LPENSETR,	11),
+	CFG_GATE_SETCLR(GATE_ETH2STP,	RCC_MP_AHB6LPENSETR,	31),
+	CFG_GATE_SETCLR(GATE_MDMA,	RCC_MP_NS_AHB6ENSETR,	0),
+};
+
+/* STM32 Divivers definition */
+enum enum_div_cfg {
+	DIV_RTC,
+	DIV_HSI,
+	DIV_MCO1,
+	DIV_MCO2,
+	DIV_TRACE,
+	DIV_ETH1PTP,
+	DIV_ETH2PTP,
+	DIV_NB
+};
+
+static const struct clk_div_table ck_trace_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 16 }, { 6, 16 }, { 7, 16 },
+	{ 0 },
+};
+
+#define CFG_DIV(_id, _offset, _shift, _width, _flags, _table, _ready)\
+	[(_id)] = {\
+		.offset	= (_offset),\
+		.shift	= (_shift),\
+		.width	= (_width),\
+		.flags	= (_flags),\
+		.table	= (_table),\
+		.ready	= (_ready),\
+	}
+
+static const struct stm32_div_cfg stm32mp13_dividers[DIV_NB] = {
+	CFG_DIV(DIV_RTC, RCC_RTCDIVR, 0, 6, 0, NULL, DIV_NO_RDY),
+	CFG_DIV(DIV_MCO1, RCC_MCO1CFGR, 4, 4, 0, NULL, DIV_NO_RDY),
+	CFG_DIV(DIV_MCO2, RCC_MCO2CFGR, 4, 4, 0, NULL, DIV_NO_RDY),
+	CFG_DIV(DIV_TRACE, RCC_DBGCFGR, 0, 3, 0, ck_trace_div_table, DIV_NO_RDY),
+	CFG_DIV(DIV_ETH1PTP, RCC_ETH12CKSELR, 4, 4, 0, NULL, DIV_NO_RDY),
+	CFG_DIV(DIV_ETH2PTP, RCC_ETH12CKSELR, 12, 4, 0, NULL, DIV_NO_RDY),
+};
+
+/* STM32 Muxes definition */
+enum enum_mux_cfg {
+	MUX_ADC1,
+	MUX_ADC2,
+	MUX_DCMIPP,
+	MUX_ETH1,
+	MUX_ETH2,
+	MUX_FDCAN,
+	MUX_FMC,
+	MUX_I2C12,
+	MUX_I2C3,
+	MUX_I2C4,
+	MUX_I2C5,
+	MUX_LPTIM1,
+	MUX_LPTIM2,
+	MUX_LPTIM3,
+	MUX_LPTIM45,
+	MUX_MCO1,
+	MUX_MCO2,
+	MUX_QSPI,
+	MUX_RNG1,
+	MUX_SAES,
+	MUX_SAI1,
+	MUX_SAI2,
+	MUX_SDMMC1,
+	MUX_SDMMC2,
+	MUX_SPDIF,
+	MUX_SPI1,
+	MUX_SPI23,
+	MUX_SPI4,
+	MUX_SPI5,
+	MUX_STGEN,
+	MUX_UART1,
+	MUX_UART2,
+	MUX_UART4,
+	MUX_UART6,
+	MUX_UART35,
+	MUX_UART78,
+	MUX_USBO,
+	MUX_USBPHY,
+	MUX_NB
+};
+
+#define _CFG_MUX(_id, _offset, _shift, _witdh, _ready, _flags)\
+	[_id] = {\
+		.offset		= (_offset),\
+		.shift		= (_shift),\
+		.width		= (_witdh),\
+		.ready		= (_ready),\
+		.flags		= (_flags),\
+	}
+
+#define CFG_MUX(_id, _offset, _shift, _witdh)\
+	_CFG_MUX(_id, _offset, _shift, _witdh, MUX_NO_RDY, 0)
+
+static const struct stm32_mux_cfg stm32mp13_muxes[] = {
+	CFG_MUX(MUX_I2C12,	RCC_I2C12CKSELR,	0, 3),
+	CFG_MUX(MUX_LPTIM45,	RCC_LPTIM45CKSELR,	0, 3),
+	CFG_MUX(MUX_SPI23,	RCC_SPI2S23CKSELR,	0, 3),
+	CFG_MUX(MUX_UART35,	RCC_UART35CKSELR,	0, 3),
+	CFG_MUX(MUX_UART78,	RCC_UART78CKSELR,	0, 3),
+	CFG_MUX(MUX_ADC1,	RCC_ADC12CKSELR,	0, 2),
+	CFG_MUX(MUX_ADC2,	RCC_ADC12CKSELR,	2, 2),
+	CFG_MUX(MUX_DCMIPP,	RCC_DCMIPPCKSELR,	0, 2),
+	CFG_MUX(MUX_ETH1,	RCC_ETH12CKSELR,	0, 2),
+	CFG_MUX(MUX_ETH2,	RCC_ETH12CKSELR,	8, 2),
+	CFG_MUX(MUX_FDCAN,	RCC_FDCANCKSELR,	0, 2),
+	CFG_MUX(MUX_I2C3,	RCC_I2C345CKSELR,	0, 3),
+	CFG_MUX(MUX_I2C4,	RCC_I2C345CKSELR,	3, 3),
+	CFG_MUX(MUX_I2C5,	RCC_I2C345CKSELR,	6, 3),
+	CFG_MUX(MUX_LPTIM1,	RCC_LPTIM1CKSELR,	0, 3),
+	CFG_MUX(MUX_LPTIM2,	RCC_LPTIM23CKSELR,	0, 3),
+	CFG_MUX(MUX_LPTIM3,	RCC_LPTIM23CKSELR,	3, 3),
+	CFG_MUX(MUX_MCO1,	RCC_MCO1CFGR,		0, 3),
+	CFG_MUX(MUX_MCO2,	RCC_MCO2CFGR,		0, 3),
+	CFG_MUX(MUX_RNG1,	RCC_RNG1CKSELR,		0, 2),
+	CFG_MUX(MUX_SAES,	RCC_SAESCKSELR,		0, 2),
+	CFG_MUX(MUX_SAI1,	RCC_SAI1CKSELR,		0, 3),
+	CFG_MUX(MUX_SAI2,	RCC_SAI2CKSELR,		0, 3),
+	CFG_MUX(MUX_SPDIF,	RCC_SPDIFCKSELR,	0, 2),
+	CFG_MUX(MUX_SPI1,	RCC_SPI2S1CKSELR,	0, 3),
+	CFG_MUX(MUX_SPI4,	RCC_SPI45CKSELR,	0, 3),
+	CFG_MUX(MUX_SPI5,	RCC_SPI45CKSELR,	3, 3),
+	CFG_MUX(MUX_STGEN,	RCC_STGENCKSELR,	0, 2),
+	CFG_MUX(MUX_UART1,	RCC_UART12CKSELR,	0, 3),
+	CFG_MUX(MUX_UART2,	RCC_UART12CKSELR,	3, 3),
+	CFG_MUX(MUX_UART4,	RCC_UART4CKSELR,	0, 3),
+	CFG_MUX(MUX_UART6,	RCC_UART6CKSELR,	0, 3),
+	CFG_MUX(MUX_USBO,	RCC_USBCKSELR,		4, 1),
+	CFG_MUX(MUX_USBPHY,	RCC_USBCKSELR,		0, 2),
+	CFG_MUX(MUX_FMC,	RCC_FMCCKSELR,		0, 2),
+	CFG_MUX(MUX_QSPI,	RCC_QSPICKSELR,		0, 2),
+	CFG_MUX(MUX_SDMMC1,	RCC_SDMMC12CKSELR,	0, 3),
+	CFG_MUX(MUX_SDMMC2,	RCC_SDMMC12CKSELR,	3, 3),
+};
+
+static const struct clock_config stm32mp13_clock_cfg[] = {
+};
+
+static u16 stm32mp13_cpt_gate[GATE_NB];
+
+static struct clk_stm32_clock_data stm32mp13_clock_data = {
+	.gate_cpt	= stm32mp13_cpt_gate,
+	.gates		= stm32mp13_gates,
+	.muxes		= stm32mp13_muxes,
+	.dividers	= stm32mp13_dividers,
+};
+
+static const struct stm32_rcc_match_data stm32mp13_data = {
+	.tab_clocks	= stm32mp13_clock_cfg,
+	.num_clocks	= ARRAY_SIZE(stm32mp13_clock_cfg),
+	.clock_data	= &stm32mp13_clock_data,
+	.maxbinding	= STM32MP1_LAST_CLK,
+	.clear_offset	= RCC_CLR_OFFSET,
+};
+
+static const struct of_device_id stm32mp13_match_data[] = {
+	{
+		.compatible = "st,stm32mp13-rcc",
+		.data = &stm32mp13_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stm32mp13_match_data);
+
+static int stm32mp1_rcc_init(struct device *dev)
+{
+	void __iomem *rcc_base;
+	int ret = -ENOMEM;
+
+	rcc_base = of_iomap(dev_of_node(dev), 0);
+	if (!rcc_base) {
+		dev_err(dev, "%pOFn: unable to map resource", dev_of_node(dev));
+		goto out;
+	}
+
+	ret = stm32_rcc_init(dev, stm32mp13_match_data, rcc_base);
+out:
+	if (ret) {
+		if (rcc_base)
+			iounmap(rcc_base);
+
+		of_node_put(dev_of_node(dev));
+	}
+
+	return ret;
+}
+
+static int get_clock_deps(struct device *dev)
+{
+	static const char * const clock_deps_name[] = {
+		"hsi", "hse", "csi", "lsi", "lse",
+	};
+	size_t deps_size = sizeof(struct clk *) * ARRAY_SIZE(clock_deps_name);
+	struct clk **clk_deps;
+	int i;
+
+	clk_deps = devm_kzalloc(dev, deps_size, GFP_KERNEL);
+	if (!clk_deps)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(clock_deps_name); i++) {
+		struct clk *clk = of_clk_get_by_name(dev_of_node(dev),
+						     clock_deps_name[i]);
+
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -EINVAL && PTR_ERR(clk) != -ENOENT)
+				return PTR_ERR(clk);
+		} else {
+			/* Device gets a reference count on the clock */
+			clk_deps[i] = devm_clk_get(dev, __clk_get_name(clk));
+			clk_put(clk);
+		}
+	}
+
+	return 0;
+}
+
+static int stm32mp1_rcc_clocks_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret = get_clock_deps(dev);
+
+	if (!ret)
+		ret = stm32mp1_rcc_init(dev);
+
+	return ret;
+}
+
+static int stm32mp1_rcc_clocks_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *child, *np = dev_of_node(dev);
+
+	for_each_available_child_of_node(np, child)
+		of_clk_del_provider(child);
+
+	return 0;
+}
+
+static struct platform_driver stm32mp13_rcc_clocks_driver = {
+	.driver	= {
+		.name = "stm32mp13_rcc",
+		.of_match_table = stm32mp13_match_data,
+	},
+	.probe = stm32mp1_rcc_clocks_probe,
+	.remove = stm32mp1_rcc_clocks_remove,
+};
+
+static int __init stm32mp13_clocks_init(void)
+{
+	return platform_driver_register(&stm32mp13_rcc_clocks_driver);
+}
+core_initcall(stm32mp13_clocks_init);
diff --git a/drivers/clk/stm32/reset-stm32.c b/drivers/clk/stm32/reset-stm32.c
new file mode 100644
index 000000000000..040870130e4b
--- /dev/null
+++ b/drivers/clk/stm32/reset-stm32.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "clk-stm32-core.h"
+
+#define STM32_RESET_ID_MASK GENMASK(15, 0)
+
+struct stm32_reset_data {
+	/* reset lock */
+	spinlock_t			lock;
+	struct reset_controller_dev	rcdev;
+	void __iomem			*membase;
+	u32				clear_offset;
+};
+
+static inline struct stm32_reset_data *
+to_stm32_reset_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct stm32_reset_data, rcdev);
+}
+
+static int stm32_reset_update(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
+{
+	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+
+	if (data->clear_offset) {
+		void __iomem *addr;
+
+		addr = data->membase + (bank * reg_width);
+		if (!assert)
+			addr += data->clear_offset;
+
+		writel(BIT(offset), addr);
+
+	} else {
+		unsigned long flags;
+		u32 reg;
+
+		spin_lock_irqsave(&data->lock, flags);
+
+		reg = readl(data->membase + (bank * reg_width));
+
+		if (assert)
+			reg |= BIT(offset);
+		else
+			reg &= ~BIT(offset);
+
+		writel(reg, data->membase + (bank * reg_width));
+
+		spin_unlock_irqrestore(&data->lock, flags);
+	}
+
+	return 0;
+}
+
+static int stm32_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return stm32_reset_update(rcdev, id, true);
+}
+
+static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return stm32_reset_update(rcdev, id, false);
+}
+
+static int stm32_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	u32 reg;
+
+	reg = readl(data->membase + (bank * reg_width));
+
+	return !!(reg & BIT(offset));
+}
+
+static const struct reset_control_ops stm32_reset_ops = {
+	.assert		= stm32_reset_assert,
+	.deassert	= stm32_reset_deassert,
+	.status		= stm32_reset_status,
+};
+
+int stm32_rcc_reset_init(struct device *dev, const struct of_device_id *match,
+			 void __iomem *base)
+{
+	const struct stm32_rcc_match_data *data = match->data;
+	struct stm32_reset_data *reset_data = NULL;
+
+	data = match->data;
+
+	reset_data = kzalloc(sizeof(*reset_data), GFP_KERNEL);
+	if (!reset_data)
+		return -ENOMEM;
+
+	reset_data->membase = base;
+	reset_data->rcdev.owner = THIS_MODULE;
+	reset_data->rcdev.ops = &stm32_reset_ops;
+	reset_data->rcdev.of_node = dev_of_node(dev);
+	reset_data->rcdev.nr_resets = STM32_RESET_ID_MASK;
+	reset_data->clear_offset = data->clear_offset;
+
+	return reset_controller_register(&reset_data->rcdev);
+}
diff --git a/drivers/clk/stm32/reset-stm32.h b/drivers/clk/stm32/reset-stm32.h
new file mode 100644
index 000000000000..6eb6ea4b55ab
--- /dev/null
+++ b/drivers/clk/stm32/reset-stm32.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0  */
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
+ */
+
+int stm32_rcc_reset_init(struct device *dev, const struct of_device_id *match,
+			 void __iomem *base);
diff --git a/drivers/clk/stm32/stm32mp13_rcc.h b/drivers/clk/stm32/stm32mp13_rcc.h
new file mode 100644
index 000000000000..a82512ae08f2
--- /dev/null
+++ b/drivers/clk/stm32/stm32mp13_rcc.h
@@ -0,0 +1,1748 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (C) 2020, STMicroelectronics - All Rights Reserved
+ *
+ * Configuration settings for the STM32MP13x CPU
+ */
+
+#ifndef STM32MP13_RCC_H
+#define STM32MP13_RCC_H
+/* RCC registers */
+#define RCC_SECCFGR			0x0
+#define RCC_MP_SREQSETR			0x100
+#define RCC_MP_SREQCLRR			0x104
+#define RCC_MP_APRSTCR			0x108
+#define RCC_MP_APRSTSR			0x10c
+#define RCC_PWRLPDLYCR			0x110
+#define RCC_MP_GRSTCSETR		0x114
+#define RCC_BR_RSTSCLRR			0x118
+#define RCC_MP_RSTSSETR			0x11c
+#define RCC_MP_RSTSCLRR			0x120
+#define RCC_MP_IWDGFZSETR		0x124
+#define RCC_MP_IWDGFZCLRR		0x128
+#define RCC_MP_CIER			0x200
+#define RCC_MP_CIFR			0x204
+#define RCC_BDCR			0x400
+#define RCC_RDLSICR			0x404
+#define RCC_OCENSETR			0x420
+#define RCC_OCENCLRR			0x424
+#define RCC_OCRDYR			0x428
+#define RCC_HSICFGR			0x440
+#define RCC_CSICFGR			0x444
+#define RCC_MCO1CFGR			0x460
+#define RCC_MCO2CFGR			0x464
+#define RCC_DBGCFGR			0x468
+#define RCC_RCK12SELR			0x480
+#define RCC_RCK3SELR			0x484
+#define RCC_RCK4SELR			0x488
+#define RCC_PLL1CR			0x4a0
+#define RCC_PLL1CFGR1			0x4a4
+#define RCC_PLL1CFGR2			0x4a8
+#define RCC_PLL1FRACR			0x4ac
+#define RCC_PLL1CSGR			0x4b0
+#define RCC_PLL2CR			0x4d0
+#define RCC_PLL2CFGR1			0x4d4
+#define RCC_PLL2CFGR2			0x4d8
+#define RCC_PLL2FRACR			0x4dc
+#define RCC_PLL2CSGR			0x4e0
+#define RCC_PLL3CR			0x500
+#define RCC_PLL3CFGR1			0x504
+#define RCC_PLL3CFGR2			0x508
+#define RCC_PLL3FRACR			0x50c
+#define RCC_PLL3CSGR			0x510
+#define RCC_PLL4CR			0x520
+#define RCC_PLL4CFGR1			0x524
+#define RCC_PLL4CFGR2			0x528
+#define RCC_PLL4FRACR			0x52c
+#define RCC_PLL4CSGR			0x530
+#define RCC_MPCKSELR			0x540
+#define RCC_ASSCKSELR			0x544
+#define RCC_MSSCKSELR			0x548
+#define RCC_CPERCKSELR			0x54c
+#define RCC_RTCDIVR			0x560
+#define RCC_MPCKDIVR			0x564
+#define RCC_AXIDIVR			0x568
+#define RCC_MLAHBDIVR			0x56c
+#define RCC_APB1DIVR			0x570
+#define RCC_APB2DIVR			0x574
+#define RCC_APB3DIVR			0x578
+#define RCC_APB4DIVR			0x57c
+#define RCC_APB5DIVR			0x580
+#define RCC_APB6DIVR			0x584
+#define RCC_TIMG1PRER			0x5a0
+#define RCC_TIMG2PRER			0x5a4
+#define RCC_TIMG3PRER			0x5a8
+#define RCC_DDRITFCR			0x5c0
+#define RCC_I2C12CKSELR			0x600
+#define RCC_I2C345CKSELR		0x604
+#define RCC_SPI2S1CKSELR		0x608
+#define RCC_SPI2S23CKSELR		0x60c
+#define RCC_SPI45CKSELR			0x610
+#define RCC_UART12CKSELR		0x614
+#define RCC_UART35CKSELR		0x618
+#define RCC_UART4CKSELR			0x61c
+#define RCC_UART6CKSELR			0x620
+#define RCC_UART78CKSELR		0x624
+#define RCC_LPTIM1CKSELR		0x628
+#define RCC_LPTIM23CKSELR		0x62c
+#define RCC_LPTIM45CKSELR		0x630
+#define RCC_SAI1CKSELR			0x634
+#define RCC_SAI2CKSELR			0x638
+#define RCC_FDCANCKSELR			0x63c
+#define RCC_SPDIFCKSELR			0x640
+#define RCC_ADC12CKSELR			0x644
+#define RCC_SDMMC12CKSELR		0x648
+#define RCC_ETH12CKSELR			0x64c
+#define RCC_USBCKSELR			0x650
+#define RCC_QSPICKSELR			0x654
+#define RCC_FMCCKSELR			0x658
+#define RCC_RNG1CKSELR			0x65c
+#define RCC_STGENCKSELR			0x660
+#define RCC_DCMIPPCKSELR		0x664
+#define RCC_SAESCKSELR			0x668
+#define RCC_APB1RSTSETR			0x6a0
+#define RCC_APB1RSTCLRR			0x6a4
+#define RCC_APB2RSTSETR			0x6a8
+#define RCC_APB2RSTCLRR			0x6ac
+#define RCC_APB3RSTSETR			0x6b0
+#define RCC_APB3RSTCLRR			0x6b4
+#define RCC_APB4RSTSETR			0x6b8
+#define RCC_APB4RSTCLRR			0x6bc
+#define RCC_APB5RSTSETR			0x6c0
+#define RCC_APB5RSTCLRR			0x6c4
+#define RCC_APB6RSTSETR			0x6c8
+#define RCC_APB6RSTCLRR			0x6cc
+#define RCC_AHB2RSTSETR			0x6d0
+#define RCC_AHB2RSTCLRR			0x6d4
+#define RCC_AHB4RSTSETR			0x6e0
+#define RCC_AHB4RSTCLRR			0x6e4
+#define RCC_AHB5RSTSETR			0x6e8
+#define RCC_AHB5RSTCLRR			0x6ec
+#define RCC_AHB6RSTSETR			0x6f0
+#define RCC_AHB6RSTCLRR			0x6f4
+#define RCC_MP_APB1ENSETR		0x700
+#define RCC_MP_APB1ENCLRR		0x704
+#define RCC_MP_APB2ENSETR		0x708
+#define RCC_MP_APB2ENCLRR		0x70c
+#define RCC_MP_APB3ENSETR		0x710
+#define RCC_MP_APB3ENCLRR		0x714
+#define RCC_MP_S_APB3ENSETR		0x718
+#define RCC_MP_S_APB3ENCLRR		0x71c
+#define RCC_MP_NS_APB3ENSETR		0x720
+#define RCC_MP_NS_APB3ENCLRR		0x724
+#define RCC_MP_APB4ENSETR		0x728
+#define RCC_MP_APB4ENCLRR		0x72c
+#define RCC_MP_S_APB4ENSETR		0x730
+#define RCC_MP_S_APB4ENCLRR		0x734
+#define RCC_MP_NS_APB4ENSETR		0x738
+#define RCC_MP_NS_APB4ENCLRR		0x73c
+#define RCC_MP_APB5ENSETR		0x740
+#define RCC_MP_APB5ENCLRR		0x744
+#define RCC_MP_APB6ENSETR		0x748
+#define RCC_MP_APB6ENCLRR		0x74c
+#define RCC_MP_AHB2ENSETR		0x750
+#define RCC_MP_AHB2ENCLRR		0x754
+#define RCC_MP_AHB4ENSETR		0x760
+#define RCC_MP_AHB4ENCLRR		0x764
+#define RCC_MP_S_AHB4ENSETR		0x768
+#define RCC_MP_S_AHB4ENCLRR		0x76c
+#define RCC_MP_NS_AHB4ENSETR		0x770
+#define RCC_MP_NS_AHB4ENCLRR		0x774
+#define RCC_MP_AHB5ENSETR		0x778
+#define RCC_MP_AHB5ENCLRR		0x77c
+#define RCC_MP_AHB6ENSETR		0x780
+#define RCC_MP_AHB6ENCLRR		0x784
+#define RCC_MP_S_AHB6ENSETR		0x788
+#define RCC_MP_S_AHB6ENCLRR		0x78c
+#define RCC_MP_NS_AHB6ENSETR		0x790
+#define RCC_MP_NS_AHB6ENCLRR		0x794
+#define RCC_MP_APB1LPENSETR		0x800
+#define RCC_MP_APB1LPENCLRR		0x804
+#define RCC_MP_APB2LPENSETR		0x808
+#define RCC_MP_APB2LPENCLRR		0x80c
+#define RCC_MP_APB3LPENSETR		0x810
+#define RCC_MP_APB3LPENCLRR		0x814
+#define RCC_MP_S_APB3LPENSETR		0x818
+#define RCC_MP_S_APB3LPENCLRR		0x81c
+#define RCC_MP_NS_APB3LPENSETR		0x820
+#define RCC_MP_NS_APB3LPENCLRR		0x824
+#define RCC_MP_APB4LPENSETR		0x828
+#define RCC_MP_APB4LPENCLRR		0x82c
+#define RCC_MP_S_APB4LPENSETR		0x830
+#define RCC_MP_S_APB4LPENCLRR		0x834
+#define RCC_MP_NS_APB4LPENSETR		0x838
+#define RCC_MP_NS_APB4LPENCLRR		0x83c
+#define RCC_MP_APB5LPENSETR		0x840
+#define RCC_MP_APB5LPENCLRR		0x844
+#define RCC_MP_APB6LPENSETR		0x848
+#define RCC_MP_APB6LPENCLRR		0x84c
+#define RCC_MP_AHB2LPENSETR		0x850
+#define RCC_MP_AHB2LPENCLRR		0x854
+#define RCC_MP_AHB4LPENSETR		0x858
+#define RCC_MP_AHB4LPENCLRR		0x85c
+#define RCC_MP_S_AHB4LPENSETR		0x868
+#define RCC_MP_S_AHB4LPENCLRR		0x86c
+#define RCC_MP_NS_AHB4LPENSETR		0x870
+#define RCC_MP_NS_AHB4LPENCLRR		0x874
+#define RCC_MP_AHB5LPENSETR		0x878
+#define RCC_MP_AHB5LPENCLRR		0x87c
+#define RCC_MP_AHB6LPENSETR		0x880
+#define RCC_MP_AHB6LPENCLRR		0x884
+#define RCC_MP_S_AHB6LPENSETR		0x888
+#define RCC_MP_S_AHB6LPENCLRR		0x88c
+#define RCC_MP_NS_AHB6LPENSETR		0x890
+#define RCC_MP_NS_AHB6LPENCLRR		0x894
+#define RCC_MP_S_AXIMLPENSETR		0x898
+#define RCC_MP_S_AXIMLPENCLRR		0x89c
+#define RCC_MP_NS_AXIMLPENSETR		0x8a0
+#define RCC_MP_NS_AXIMLPENCLRR		0x8a4
+#define RCC_MP_MLAHBLPENSETR		0x8a8
+#define RCC_MP_MLAHBLPENCLRR		0x8ac
+#define RCC_APB3SECSR			0x8c0
+#define RCC_APB4SECSR			0x8c4
+#define RCC_APB5SECSR			0x8c8
+#define RCC_APB6SECSR			0x8cc
+#define RCC_AHB2SECSR			0x8d0
+#define RCC_AHB4SECSR			0x8d4
+#define RCC_AHB5SECSR			0x8d8
+#define RCC_AHB6SECSR			0x8dc
+#define RCC_VERR			0xff4
+#define RCC_IDR				0xff8
+#define RCC_SIDR			0xffc
+
+/* RCC_SECCFGR register fields */
+#define RCC_SECCFGR_HSISEC		0
+#define RCC_SECCFGR_CSISEC		1
+#define RCC_SECCFGR_HSESEC		2
+#define RCC_SECCFGR_LSISEC		3
+#define RCC_SECCFGR_LSESEC		4
+#define RCC_SECCFGR_PLL12SEC		8
+#define RCC_SECCFGR_PLL3SEC		9
+#define RCC_SECCFGR_PLL4SEC		10
+#define RCC_SECCFGR_MPUSEC		11
+#define RCC_SECCFGR_AXISEC		12
+#define RCC_SECCFGR_MLAHBSEC		13
+#define RCC_SECCFGR_APB3DIVSEC		16
+#define RCC_SECCFGR_APB4DIVSEC		17
+#define RCC_SECCFGR_APB5DIVSEC		18
+#define RCC_SECCFGR_APB6DIVSEC		19
+#define RCC_SECCFGR_TIMG3SEC		20
+#define RCC_SECCFGR_CPERSEC		21
+#define RCC_SECCFGR_MCO1SEC		22
+#define RCC_SECCFGR_MCO2SEC		23
+#define RCC_SECCFGR_STPSEC		24
+#define RCC_SECCFGR_RSTSEC		25
+#define RCC_SECCFGR_PWRSEC		31
+
+/* RCC_MP_SREQSETR register fields */
+#define RCC_MP_SREQSETR_STPREQ_P0	BIT(0)
+
+/* RCC_MP_SREQCLRR register fields */
+#define RCC_MP_SREQCLRR_STPREQ_P0	BIT(0)
+
+/* RCC_MP_APRSTCR register fields */
+#define RCC_MP_APRSTCR_RDCTLEN		BIT(0)
+#define RCC_MP_APRSTCR_RSTTO_MASK	GENMASK(14, 8)
+#define RCC_MP_APRSTCR_RSTTO_SHIFT	8
+
+/* RCC_MP_APRSTSR register fields */
+#define RCC_MP_APRSTSR_RSTTOV_MASK	GENMASK(14, 8)
+#define RCC_MP_APRSTSR_RSTTOV_SHIFT	8
+
+/* RCC_PWRLPDLYCR register fields */
+#define RCC_PWRLPDLYCR_PWRLP_DLY_MASK	GENMASK(21, 0)
+#define RCC_PWRLPDLYCR_PWRLP_DLY_SHIFT	0
+
+/* RCC_MP_GRSTCSETR register fields */
+#define RCC_MP_GRSTCSETR_MPSYSRST	BIT(0)
+#define RCC_MP_GRSTCSETR_MPUP0RST	BIT(4)
+
+/* RCC_BR_RSTSCLRR register fields */
+#define RCC_BR_RSTSCLRR_PORRSTF		BIT(0)
+#define RCC_BR_RSTSCLRR_BORRSTF		BIT(1)
+#define RCC_BR_RSTSCLRR_PADRSTF		BIT(2)
+#define RCC_BR_RSTSCLRR_HCSSRSTF	BIT(3)
+#define RCC_BR_RSTSCLRR_VCORERSTF	BIT(4)
+#define RCC_BR_RSTSCLRR_VCPURSTF	BIT(5)
+#define RCC_BR_RSTSCLRR_MPSYSRSTF	BIT(6)
+#define RCC_BR_RSTSCLRR_IWDG1RSTF	BIT(8)
+#define RCC_BR_RSTSCLRR_IWDG2RSTF	BIT(9)
+#define RCC_BR_RSTSCLRR_MPUP0RSTF	BIT(13)
+
+/* RCC_MP_RSTSSETR register fields */
+#define RCC_MP_RSTSSETR_PORRSTF		BIT(0)
+#define RCC_MP_RSTSSETR_BORRSTF		BIT(1)
+#define RCC_MP_RSTSSETR_PADRSTF		BIT(2)
+#define RCC_MP_RSTSSETR_HCSSRSTF	BIT(3)
+#define RCC_MP_RSTSSETR_VCORERSTF	BIT(4)
+#define RCC_MP_RSTSSETR_VCPURSTF	BIT(5)
+#define RCC_MP_RSTSSETR_MPSYSRSTF	BIT(6)
+#define RCC_MP_RSTSSETR_IWDG1RSTF	BIT(8)
+#define RCC_MP_RSTSSETR_IWDG2RSTF	BIT(9)
+#define RCC_MP_RSTSSETR_STP2RSTF	BIT(10)
+#define RCC_MP_RSTSSETR_STDBYRSTF	BIT(11)
+#define RCC_MP_RSTSSETR_CSTDBYRSTF	BIT(12)
+#define RCC_MP_RSTSSETR_MPUP0RSTF	BIT(13)
+#define RCC_MP_RSTSSETR_SPARE		BIT(15)
+
+/* RCC_MP_RSTSCLRR register fields */
+#define RCC_MP_RSTSCLRR_PORRSTF		BIT(0)
+#define RCC_MP_RSTSCLRR_BORRSTF		BIT(1)
+#define RCC_MP_RSTSCLRR_PADRSTF		BIT(2)
+#define RCC_MP_RSTSCLRR_HCSSRSTF	BIT(3)
+#define RCC_MP_RSTSCLRR_VCORERSTF	BIT(4)
+#define RCC_MP_RSTSCLRR_VCPURSTF	BIT(5)
+#define RCC_MP_RSTSCLRR_MPSYSRSTF	BIT(6)
+#define RCC_MP_RSTSCLRR_IWDG1RSTF	BIT(8)
+#define RCC_MP_RSTSCLRR_IWDG2RSTF	BIT(9)
+#define RCC_MP_RSTSCLRR_STP2RSTF	BIT(10)
+#define RCC_MP_RSTSCLRR_STDBYRSTF	BIT(11)
+#define RCC_MP_RSTSCLRR_CSTDBYRSTF	BIT(12)
+#define RCC_MP_RSTSCLRR_MPUP0RSTF	BIT(13)
+#define RCC_MP_RSTSCLRR_SPARE		BIT(15)
+
+/* RCC_MP_IWDGFZSETR register fields */
+#define RCC_MP_IWDGFZSETR_FZ_IWDG1	BIT(0)
+#define RCC_MP_IWDGFZSETR_FZ_IWDG2	BIT(1)
+
+/* RCC_MP_IWDGFZCLRR register fields */
+#define RCC_MP_IWDGFZCLRR_FZ_IWDG1	BIT(0)
+#define RCC_MP_IWDGFZCLRR_FZ_IWDG2	BIT(1)
+
+/* RCC_MP_CIER register fields */
+#define RCC_MP_CIER_LSIRDYIE		BIT(0)
+#define RCC_MP_CIER_LSERDYIE		BIT(1)
+#define RCC_MP_CIER_HSIRDYIE		BIT(2)
+#define RCC_MP_CIER_HSERDYIE		BIT(3)
+#define RCC_MP_CIER_CSIRDYIE		BIT(4)
+#define RCC_MP_CIER_PLL1DYIE		BIT(8)
+#define RCC_MP_CIER_PLL2DYIE		BIT(9)
+#define RCC_MP_CIER_PLL3DYIE		BIT(10)
+#define RCC_MP_CIER_PLL4DYIE		BIT(11)
+#define RCC_MP_CIER_LSECSSIE		BIT(16)
+#define RCC_MP_CIER_WKUPIE		BIT(20)
+
+/* RCC_MP_CIFR register fields */
+#define RCC_MP_CIFR_LSIRDYF		BIT(0)
+#define RCC_MP_CIFR_LSERDYF		BIT(1)
+#define RCC_MP_CIFR_HSIRDYF		BIT(2)
+#define RCC_MP_CIFR_HSERDYF		BIT(3)
+#define RCC_MP_CIFR_CSIRDYF		BIT(4)
+#define RCC_MP_CIFR_PLL1DYF		BIT(8)
+#define RCC_MP_CIFR_PLL2DYF		BIT(9)
+#define RCC_MP_CIFR_PLL3DYF		BIT(10)
+#define RCC_MP_CIFR_PLL4DYF		BIT(11)
+#define RCC_MP_CIFR_LSECSSF		BIT(16)
+#define RCC_MP_CIFR_WKUPF		BIT(20)
+
+/* RCC_BDCR register fields */
+#define RCC_BDCR_LSEON			BIT(0)
+#define RCC_BDCR_LSEBYP			BIT(1)
+#define RCC_BDCR_LSERDY			BIT(2)
+#define RCC_BDCR_DIGBYP			BIT(3)
+#define RCC_BDCR_LSEDRV_MASK		GENMASK(5, 4)
+#define RCC_BDCR_LSECSSON		BIT(8)
+#define RCC_BDCR_LSECSSD		BIT(9)
+#define RCC_BDCR_RTCSRC_MASK		GENMASK(17, 16)
+#define RCC_BDCR_RTCCKEN		BIT(20)
+#define RCC_BDCR_VSWRST			BIT(31)
+#define RCC_BDCR_LSEDRV_SHIFT		4
+#define RCC_BDCR_RTCSRC_SHIFT		16
+
+/* RCC_RDLSICR register fields */
+#define RCC_RDLSICR_LSION		BIT(0)
+#define RCC_RDLSICR_LSIRDY		BIT(1)
+#define RCC_RDLSICR_MRD_MASK		GENMASK(20, 16)
+#define RCC_RDLSICR_EADLY_MASK		GENMASK(26, 24)
+#define RCC_RDLSICR_SPARE_MASK		GENMASK(31, 27)
+#define RCC_RDLSICR_MRD_SHIFT		16
+#define RCC_RDLSICR_EADLY_SHIFT		24
+#define RCC_RDLSICR_SPARE_SHIFT		27
+
+/* RCC_OCENSETR register fields */
+#define RCC_OCENSETR_HSION		BIT(0)
+#define RCC_OCENSETR_HSIKERON		BIT(1)
+#define RCC_OCENSETR_CSION		BIT(4)
+#define RCC_OCENSETR_CSIKERON		BIT(5)
+#define RCC_OCENSETR_DIGBYP		BIT(7)
+#define RCC_OCENSETR_HSEON		BIT(8)
+#define RCC_OCENSETR_HSEKERON		BIT(9)
+#define RCC_OCENSETR_HSEBYP		BIT(10)
+#define RCC_OCENSETR_HSECSSON		BIT(11)
+
+/* RCC_OCENCLRR register fields */
+#define RCC_OCENCLRR_HSION		BIT(0)
+#define RCC_OCENCLRR_HSIKERON		BIT(1)
+#define RCC_OCENCLRR_CSION		BIT(4)
+#define RCC_OCENCLRR_CSIKERON		BIT(5)
+#define RCC_OCENCLRR_DIGBYP		BIT(7)
+#define RCC_OCENCLRR_HSEON		BIT(8)
+#define RCC_OCENCLRR_HSEKERON		BIT(9)
+#define RCC_OCENCLRR_HSEBYP		BIT(10)
+
+/* RCC_OCRDYR register fields */
+#define RCC_OCRDYR_HSIRDY		BIT(0)
+#define RCC_OCRDYR_HSIDIVRDY		BIT(2)
+#define RCC_OCRDYR_CSIRDY		BIT(4)
+#define RCC_OCRDYR_HSERDY		BIT(8)
+#define RCC_OCRDYR_MPUCKRDY		BIT(23)
+#define RCC_OCRDYR_AXICKRDY		BIT(24)
+
+/* RCC_HSICFGR register fields */
+#define RCC_HSICFGR_HSIDIV_MASK		GENMASK(1, 0)
+#define RCC_HSICFGR_HSITRIM_MASK	GENMASK(14, 8)
+#define RCC_HSICFGR_HSICAL_MASK		GENMASK(27, 16)
+#define RCC_HSICFGR_HSIDIV_SHIFT	0
+#define RCC_HSICFGR_HSITRIM_SHIFT	8
+#define RCC_HSICFGR_HSICAL_SHIFT	16
+
+/* RCC_CSICFGR register fields */
+#define RCC_CSICFGR_CSITRIM_MASK	GENMASK(12, 8)
+#define RCC_CSICFGR_CSICAL_MASK		GENMASK(23, 16)
+#define RCC_CSICFGR_CSITRIM_SHIFT	8
+#define RCC_CSICFGR_CSICAL_SHIFT	16
+
+/* RCC_MCO1CFGR register fields */
+#define RCC_MCO1CFGR_MCO1SEL_MASK	GENMASK(2, 0)
+#define RCC_MCO1CFGR_MCO1DIV_MASK	GENMASK(7, 4)
+#define RCC_MCO1CFGR_MCO1ON		BIT(12)
+#define RCC_MCO1CFGR_MCO1SEL_SHIFT	0
+#define RCC_MCO1CFGR_MCO1DIV_SHIFT	4
+
+/* RCC_MCO2CFGR register fields */
+#define RCC_MCO2CFGR_MCO2SEL_MASK	GENMASK(2, 0)
+#define RCC_MCO2CFGR_MCO2DIV_MASK	GENMASK(7, 4)
+#define RCC_MCO2CFGR_MCO2ON		BIT(12)
+#define RCC_MCO2CFGR_MCO2SEL_SHIFT	0
+#define RCC_MCO2CFGR_MCO2DIV_SHIFT	4
+
+/* RCC_DBGCFGR register fields */
+#define RCC_DBGCFGR_TRACEDIV_MASK	GENMASK(2, 0)
+#define RCC_DBGCFGR_DBGCKEN		BIT(8)
+#define RCC_DBGCFGR_TRACECKEN		BIT(9)
+#define RCC_DBGCFGR_DBGRST		BIT(12)
+#define RCC_DBGCFGR_TRACEDIV_SHIFT	0
+
+/* RCC_RCK12SELR register fields */
+#define RCC_RCK12SELR_PLL12SRC_MASK	GENMASK(1, 0)
+#define RCC_RCK12SELR_PLL12SRCRDY	BIT(31)
+#define RCC_RCK12SELR_PLL12SRC_SHIFT	0
+
+/* RCC_RCK3SELR register fields */
+#define RCC_RCK3SELR_PLL3SRC_MASK	GENMASK(1, 0)
+#define RCC_RCK3SELR_PLL3SRCRDY		BIT(31)
+#define RCC_RCK3SELR_PLL3SRC_SHIFT	0
+
+/* RCC_RCK4SELR register fields */
+#define RCC_RCK4SELR_PLL4SRC_MASK	GENMASK(1, 0)
+#define RCC_RCK4SELR_PLL4SRCRDY		BIT(31)
+#define RCC_RCK4SELR_PLL4SRC_SHIFT	0
+
+/* RCC_PLL1CR register fields */
+#define RCC_PLL1CR_PLLON		BIT(0)
+#define RCC_PLL1CR_PLL1RDY		BIT(1)
+#define RCC_PLL1CR_SSCG_CTRL		BIT(2)
+#define RCC_PLL1CR_DIVPEN		BIT(4)
+#define RCC_PLL1CR_DIVQEN		BIT(5)
+#define RCC_PLL1CR_DIVREN		BIT(6)
+
+/* RCC_PLL1CFGR1 register fields */
+#define RCC_PLL1CFGR1_DIVN_MASK		GENMASK(8, 0)
+#define RCC_PLL1CFGR1_DIVM1_MASK	GENMASK(21, 16)
+#define RCC_PLL1CFGR1_DIVN_SHIFT	0
+#define RCC_PLL1CFGR1_DIVM1_SHIFT	16
+
+/* RCC_PLL1CFGR2 register fields */
+#define RCC_PLL1CFGR2_DIVP_MASK		GENMASK(6, 0)
+#define RCC_PLL1CFGR2_DIVQ_MASK		GENMASK(14, 8)
+#define RCC_PLL1CFGR2_DIVR_MASK		GENMASK(22, 16)
+#define RCC_PLL1CFGR2_DIVP_SHIFT	0
+#define RCC_PLL1CFGR2_DIVQ_SHIFT	8
+#define RCC_PLL1CFGR2_DIVR_SHIFT	16
+
+/* RCC_PLL1FRACR register fields */
+#define RCC_PLL1FRACR_FRACV_MASK	GENMASK(15, 3)
+#define RCC_PLL1FRACR_FRACLE		BIT(16)
+#define RCC_PLL1FRACR_FRACV_SHIFT	3
+
+/* RCC_PLL1CSGR register fields */
+#define RCC_PLL1CSGR_MOD_PER_MASK	GENMASK(12, 0)
+#define RCC_PLL1CSGR_TPDFN_DIS		BIT(13)
+#define RCC_PLL1CSGR_RPDFN_DIS		BIT(14)
+#define RCC_PLL1CSGR_SSCG_MODE		BIT(15)
+#define RCC_PLL1CSGR_INC_STEP_MASK	GENMASK(30, 16)
+#define RCC_PLL1CSGR_MOD_PER_SHIFT	0
+#define RCC_PLL1CSGR_INC_STEP_SHIFT	16
+
+/* RCC_PLL2CR register fields */
+#define RCC_PLL2CR_PLLON		BIT(0)
+#define RCC_PLL2CR_PLL2RDY		BIT(1)
+#define RCC_PLL2CR_SSCG_CTRL		BIT(2)
+#define RCC_PLL2CR_DIVPEN		BIT(4)
+#define RCC_PLL2CR_DIVQEN		BIT(5)
+#define RCC_PLL2CR_DIVREN		BIT(6)
+
+/* RCC_PLL2CFGR1 register fields */
+#define RCC_PLL2CFGR1_DIVN_MASK		GENMASK(8, 0)
+#define RCC_PLL2CFGR1_DIVM2_MASK	GENMASK(21, 16)
+#define RCC_PLL2CFGR1_DIVN_SHIFT	0
+#define RCC_PLL2CFGR1_DIVM2_SHIFT	16
+
+/* RCC_PLL2CFGR2 register fields */
+#define RCC_PLL2CFGR2_DIVP_MASK		GENMASK(6, 0)
+#define RCC_PLL2CFGR2_DIVQ_MASK		GENMASK(14, 8)
+#define RCC_PLL2CFGR2_DIVR_MASK		GENMASK(22, 16)
+#define RCC_PLL2CFGR2_DIVP_SHIFT	0
+#define RCC_PLL2CFGR2_DIVQ_SHIFT	8
+#define RCC_PLL2CFGR2_DIVR_SHIFT	16
+
+/* RCC_PLL2FRACR register fields */
+#define RCC_PLL2FRACR_FRACV_MASK	GENMASK(15, 3)
+#define RCC_PLL2FRACR_FRACLE		BIT(16)
+#define RCC_PLL2FRACR_FRACV_SHIFT	3
+
+/* RCC_PLL2CSGR register fields */
+#define RCC_PLL2CSGR_MOD_PER_MASK	GENMASK(12, 0)
+#define RCC_PLL2CSGR_TPDFN_DIS		BIT(13)
+#define RCC_PLL2CSGR_RPDFN_DIS		BIT(14)
+#define RCC_PLL2CSGR_SSCG_MODE		BIT(15)
+#define RCC_PLL2CSGR_INC_STEP_MASK	GENMASK(30, 16)
+#define RCC_PLL2CSGR_MOD_PER_SHIFT	0
+#define RCC_PLL2CSGR_INC_STEP_SHIFT	16
+
+/* RCC_PLL3CR register fields */
+#define RCC_PLL3CR_PLLON		BIT(0)
+#define RCC_PLL3CR_PLL3RDY		BIT(1)
+#define RCC_PLL3CR_SSCG_CTRL		BIT(2)
+#define RCC_PLL3CR_DIVPEN		BIT(4)
+#define RCC_PLL3CR_DIVQEN		BIT(5)
+#define RCC_PLL3CR_DIVREN		BIT(6)
+
+/* RCC_PLL3CFGR1 register fields */
+#define RCC_PLL3CFGR1_DIVN_MASK		GENMASK(8, 0)
+#define RCC_PLL3CFGR1_DIVM3_MASK	GENMASK(21, 16)
+#define RCC_PLL3CFGR1_IFRGE_MASK	GENMASK(25, 24)
+#define RCC_PLL3CFGR1_DIVN_SHIFT	0
+#define RCC_PLL3CFGR1_DIVM3_SHIFT	16
+#define RCC_PLL3CFGR1_IFRGE_SHIFT	24
+
+/* RCC_PLL3CFGR2 register fields */
+#define RCC_PLL3CFGR2_DIVP_MASK		GENMASK(6, 0)
+#define RCC_PLL3CFGR2_DIVQ_MASK		GENMASK(14, 8)
+#define RCC_PLL3CFGR2_DIVR_MASK		GENMASK(22, 16)
+#define RCC_PLL3CFGR2_DIVP_SHIFT	0
+#define RCC_PLL3CFGR2_DIVQ_SHIFT	8
+#define RCC_PLL3CFGR2_DIVR_SHIFT	16
+
+/* RCC_PLL3FRACR register fields */
+#define RCC_PLL3FRACR_FRACV_MASK	GENMASK(15, 3)
+#define RCC_PLL3FRACR_FRACLE		BIT(16)
+#define RCC_PLL3FRACR_FRACV_SHIFT	3
+
+/* RCC_PLL3CSGR register fields */
+#define RCC_PLL3CSGR_MOD_PER_MASK	GENMASK(12, 0)
+#define RCC_PLL3CSGR_TPDFN_DIS		BIT(13)
+#define RCC_PLL3CSGR_RPDFN_DIS		BIT(14)
+#define RCC_PLL3CSGR_SSCG_MODE		BIT(15)
+#define RCC_PLL3CSGR_INC_STEP_MASK	GENMASK(30, 16)
+#define RCC_PLL3CSGR_MOD_PER_SHIFT	0
+#define RCC_PLL3CSGR_INC_STEP_SHIFT	16
+
+/* RCC_PLL4CR register fields */
+#define RCC_PLL4CR_PLLON		BIT(0)
+#define RCC_PLL4CR_PLL4RDY		BIT(1)
+#define RCC_PLL4CR_SSCG_CTRL		BIT(2)
+#define RCC_PLL4CR_DIVPEN		BIT(4)
+#define RCC_PLL4CR_DIVQEN		BIT(5)
+#define RCC_PLL4CR_DIVREN		BIT(6)
+
+/* RCC_PLL4CFGR1 register fields */
+#define RCC_PLL4CFGR1_DIVN_MASK		GENMASK(8, 0)
+#define RCC_PLL4CFGR1_DIVM4_MASK	GENMASK(21, 16)
+#define RCC_PLL4CFGR1_IFRGE_MASK	GENMASK(25, 24)
+#define RCC_PLL4CFGR1_DIVN_SHIFT	0
+#define RCC_PLL4CFGR1_DIVM4_SHIFT	16
+#define RCC_PLL4CFGR1_IFRGE_SHIFT	24
+
+/* RCC_PLL4CFGR2 register fields */
+#define RCC_PLL4CFGR2_DIVP_MASK		GENMASK(6, 0)
+#define RCC_PLL4CFGR2_DIVQ_MASK		GENMASK(14, 8)
+#define RCC_PLL4CFGR2_DIVR_MASK		GENMASK(22, 16)
+#define RCC_PLL4CFGR2_DIVP_SHIFT	0
+#define RCC_PLL4CFGR2_DIVQ_SHIFT	8
+#define RCC_PLL4CFGR2_DIVR_SHIFT	16
+
+/* RCC_PLL4FRACR register fields */
+#define RCC_PLL4FRACR_FRACV_MASK	GENMASK(15, 3)
+#define RCC_PLL4FRACR_FRACLE		BIT(16)
+#define RCC_PLL4FRACR_FRACV_SHIFT	3
+
+/* RCC_PLL4CSGR register fields */
+#define RCC_PLL4CSGR_MOD_PER_MASK	GENMASK(12, 0)
+#define RCC_PLL4CSGR_TPDFN_DIS		BIT(13)
+#define RCC_PLL4CSGR_RPDFN_DIS		BIT(14)
+#define RCC_PLL4CSGR_SSCG_MODE		BIT(15)
+#define RCC_PLL4CSGR_INC_STEP_MASK	GENMASK(30, 16)
+#define RCC_PLL4CSGR_MOD_PER_SHIFT	0
+#define RCC_PLL4CSGR_INC_STEP_SHIFT	16
+
+/* RCC_MPCKSELR register fields */
+#define RCC_MPCKSELR_MPUSRC_MASK	GENMASK(1, 0)
+#define RCC_MPCKSELR_MPUSRCRDY		BIT(31)
+#define RCC_MPCKSELR_MPUSRC_SHIFT	0
+
+/* RCC_ASSCKSELR register fields */
+#define RCC_ASSCKSELR_AXISSRC_MASK	GENMASK(2, 0)
+#define RCC_ASSCKSELR_AXISSRCRDY	BIT(31)
+#define RCC_ASSCKSELR_AXISSRC_SHIFT	0
+
+/* RCC_MSSCKSELR register fields */
+#define RCC_MSSCKSELR_MLAHBSSRC_MASK	GENMASK(1, 0)
+#define RCC_MSSCKSELR_MLAHBSSRCRDY	BIT(31)
+#define RCC_MSSCKSELR_MLAHBSSRC_SHIFT	0
+
+/* RCC_CPERCKSELR register fields */
+#define RCC_CPERCKSELR_CKPERSRC_MASK	GENMASK(1, 0)
+#define RCC_CPERCKSELR_CKPERSRC_SHIFT	0
+
+/* RCC_RTCDIVR register fields */
+#define RCC_RTCDIVR_RTCDIV_MASK		GENMASK(5, 0)
+#define RCC_RTCDIVR_RTCDIV_SHIFT	0
+
+/* RCC_MPCKDIVR register fields */
+#define RCC_MPCKDIVR_MPUDIV_MASK	GENMASK(3, 0)
+#define RCC_MPCKDIVR_MPUDIVRDY		BIT(31)
+#define RCC_MPCKDIVR_MPUDIV_SHIFT	0
+
+/* RCC_AXIDIVR register fields */
+#define RCC_AXIDIVR_AXIDIV_MASK		GENMASK(2, 0)
+#define RCC_AXIDIVR_AXIDIVRDY		BIT(31)
+#define RCC_AXIDIVR_AXIDIV_SHIFT	0
+
+/* RCC_MLAHBDIVR register fields */
+#define RCC_MLAHBDIVR_MLAHBDIV_MASK	GENMASK(3, 0)
+#define RCC_MLAHBDIVR_MLAHBDIVRDY	BIT(31)
+#define RCC_MLAHBDIVR_MLAHBDIV_SHIFT	0
+
+/* RCC_APB1DIVR register fields */
+#define RCC_APB1DIVR_APB1DIV_MASK	GENMASK(2, 0)
+#define RCC_APB1DIVR_APB1DIVRDY		BIT(31)
+#define RCC_APB1DIVR_APB1DIV_SHIFT	0
+
+/* RCC_APB2DIVR register fields */
+#define RCC_APB2DIVR_APB2DIV_MASK	GENMASK(2, 0)
+#define RCC_APB2DIVR_APB2DIVRDY		BIT(31)
+#define RCC_APB2DIVR_APB2DIV_SHIFT	0
+
+/* RCC_APB3DIVR register fields */
+#define RCC_APB3DIVR_APB3DIV_MASK	GENMASK(2, 0)
+#define RCC_APB3DIVR_APB3DIVRDY		BIT(31)
+#define RCC_APB3DIVR_APB3DIV_SHIFT	0
+
+/* RCC_APB4DIVR register fields */
+#define RCC_APB4DIVR_APB4DIV_MASK	GENMASK(2, 0)
+#define RCC_APB4DIVR_APB4DIVRDY		BIT(31)
+#define RCC_APB4DIVR_APB4DIV_SHIFT	0
+
+/* RCC_APB5DIVR register fields */
+#define RCC_APB5DIVR_APB5DIV_MASK	GENMASK(2, 0)
+#define RCC_APB5DIVR_APB5DIVRDY		BIT(31)
+#define RCC_APB5DIVR_APB5DIV_SHIFT	0
+
+/* RCC_APB6DIVR register fields */
+#define RCC_APB6DIVR_APB6DIV_MASK	GENMASK(2, 0)
+#define RCC_APB6DIVR_APB6DIVRDY		BIT(31)
+#define RCC_APB6DIVR_APB6DIV_SHIFT	0
+
+/* RCC_TIMG1PRER register fields */
+#define RCC_TIMG1PRER_TIMG1PRE		BIT(0)
+#define RCC_TIMG1PRER_TIMG1PRERDY	BIT(31)
+
+/* RCC_TIMG2PRER register fields */
+#define RCC_TIMG2PRER_TIMG2PRE		BIT(0)
+#define RCC_TIMG2PRER_TIMG2PRERDY	BIT(31)
+
+/* RCC_TIMG3PRER register fields */
+#define RCC_TIMG3PRER_TIMG3PRE		BIT(0)
+#define RCC_TIMG3PRER_TIMG3PRERDY	BIT(31)
+
+/* RCC_DDRITFCR register fields */
+#define RCC_DDRITFCR_DDRC1EN		BIT(0)
+#define RCC_DDRITFCR_DDRC1LPEN		BIT(1)
+#define RCC_DDRITFCR_DDRPHYCEN		BIT(4)
+#define RCC_DDRITFCR_DDRPHYCLPEN	BIT(5)
+#define RCC_DDRITFCR_DDRCAPBEN		BIT(6)
+#define RCC_DDRITFCR_DDRCAPBLPEN	BIT(7)
+#define RCC_DDRITFCR_AXIDCGEN		BIT(8)
+#define RCC_DDRITFCR_DDRPHYCAPBEN	BIT(9)
+#define RCC_DDRITFCR_DDRPHYCAPBLPEN	BIT(10)
+#define RCC_DDRITFCR_KERDCG_DLY_MASK	GENMASK(13, 11)
+#define RCC_DDRITFCR_DDRCAPBRST		BIT(14)
+#define RCC_DDRITFCR_DDRCAXIRST		BIT(15)
+#define RCC_DDRITFCR_DDRCORERST		BIT(16)
+#define RCC_DDRITFCR_DPHYAPBRST		BIT(17)
+#define RCC_DDRITFCR_DPHYRST		BIT(18)
+#define RCC_DDRITFCR_DPHYCTLRST		BIT(19)
+#define RCC_DDRITFCR_DDRCKMOD_MASK	GENMASK(22, 20)
+#define RCC_DDRITFCR_GSKPMOD		BIT(23)
+#define RCC_DDRITFCR_GSKPCTRL		BIT(24)
+#define RCC_DDRITFCR_DFILP_WIDTH_MASK	GENMASK(27, 25)
+#define RCC_DDRITFCR_GSKP_DUR_MASK	GENMASK(31, 28)
+#define RCC_DDRITFCR_KERDCG_DLY_SHIFT	11
+#define RCC_DDRITFCR_DDRCKMOD_SHIFT	20
+#define RCC_DDRITFCR_DFILP_WIDTH_SHIFT	25
+#define RCC_DDRITFCR_GSKP_DUR_SHIFT	28
+
+/* RCC_I2C12CKSELR register fields */
+#define RCC_I2C12CKSELR_I2C12SRC_MASK	GENMASK(2, 0)
+#define RCC_I2C12CKSELR_I2C12SRC_SHIFT	0
+
+/* RCC_I2C345CKSELR register fields */
+#define RCC_I2C345CKSELR_I2C3SRC_MASK	GENMASK(2, 0)
+#define RCC_I2C345CKSELR_I2C4SRC_MASK	GENMASK(5, 3)
+#define RCC_I2C345CKSELR_I2C5SRC_MASK	GENMASK(8, 6)
+#define RCC_I2C345CKSELR_I2C3SRC_SHIFT	0
+#define RCC_I2C345CKSELR_I2C4SRC_SHIFT	3
+#define RCC_I2C345CKSELR_I2C5SRC_SHIFT	6
+
+/* RCC_SPI2S1CKSELR register fields */
+#define RCC_SPI2S1CKSELR_SPI1SRC_MASK	GENMASK(2, 0)
+#define RCC_SPI2S1CKSELR_SPI1SRC_SHIFT	0
+
+/* RCC_SPI2S23CKSELR register fields */
+#define RCC_SPI2S23CKSELR_SPI23SRC_MASK	GENMASK(2, 0)
+#define RCC_SPI2S23CKSELR_SPI23SRC_SHIFT	0
+
+/* RCC_SPI45CKSELR register fields */
+#define RCC_SPI45CKSELR_SPI4SRC_MASK	GENMASK(2, 0)
+#define RCC_SPI45CKSELR_SPI5SRC_MASK	GENMASK(5, 3)
+#define RCC_SPI45CKSELR_SPI4SRC_SHIFT	0
+#define RCC_SPI45CKSELR_SPI5SRC_SHIFT	3
+
+/* RCC_UART12CKSELR register fields */
+#define RCC_UART12CKSELR_UART1SRC_MASK	GENMASK(2, 0)
+#define RCC_UART12CKSELR_UART2SRC_MASK	GENMASK(5, 3)
+#define RCC_UART12CKSELR_UART1SRC_SHIFT	0
+#define RCC_UART12CKSELR_UART2SRC_SHIFT	3
+
+/* RCC_UART35CKSELR register fields */
+#define RCC_UART35CKSELR_UART35SRC_MASK	GENMASK(2, 0)
+#define RCC_UART35CKSELR_UART35SRC_SHIFT	0
+
+/* RCC_UART4CKSELR register fields */
+#define RCC_UART4CKSELR_UART4SRC_MASK	GENMASK(2, 0)
+#define RCC_UART4CKSELR_UART4SRC_SHIFT	0
+
+/* RCC_UART6CKSELR register fields */
+#define RCC_UART6CKSELR_UART6SRC_MASK	GENMASK(2, 0)
+#define RCC_UART6CKSELR_UART6SRC_SHIFT	0
+
+/* RCC_UART78CKSELR register fields */
+#define RCC_UART78CKSELR_UART78SRC_MASK	GENMASK(2, 0)
+#define RCC_UART78CKSELR_UART78SRC_SHIFT	0
+
+/* RCC_LPTIM1CKSELR register fields */
+#define RCC_LPTIM1CKSELR_LPTIM1SRC_MASK	GENMASK(2, 0)
+#define RCC_LPTIM1CKSELR_LPTIM1SRC_SHIFT	0
+
+/* RCC_LPTIM23CKSELR register fields */
+#define RCC_LPTIM23CKSELR_LPTIM2SRC_MASK	GENMASK(2, 0)
+#define RCC_LPTIM23CKSELR_LPTIM3SRC_MASK	GENMASK(5, 3)
+#define RCC_LPTIM23CKSELR_LPTIM2SRC_SHIFT	0
+#define RCC_LPTIM23CKSELR_LPTIM3SRC_SHIFT	3
+
+/* RCC_LPTIM45CKSELR register fields */
+#define RCC_LPTIM45CKSELR_LPTIM45SRC_MASK	GENMASK(2, 0)
+#define RCC_LPTIM45CKSELR_LPTIM45SRC_SHIFT	0
+
+/* RCC_SAI1CKSELR register fields */
+#define RCC_SAI1CKSELR_SAI1SRC_MASK	GENMASK(2, 0)
+#define RCC_SAI1CKSELR_SAI1SRC_SHIFT	0
+
+/* RCC_SAI2CKSELR register fields */
+#define RCC_SAI2CKSELR_SAI2SRC_MASK	GENMASK(2, 0)
+#define RCC_SAI2CKSELR_SAI2SRC_SHIFT	0
+
+/* RCC_FDCANCKSELR register fields */
+#define RCC_FDCANCKSELR_FDCANSRC_MASK	GENMASK(1, 0)
+#define RCC_FDCANCKSELR_FDCANSRC_SHIFT	0
+
+/* RCC_SPDIFCKSELR register fields */
+#define RCC_SPDIFCKSELR_SPDIFSRC_MASK	GENMASK(1, 0)
+#define RCC_SPDIFCKSELR_SPDIFSRC_SHIFT	0
+
+/* RCC_ADC12CKSELR register fields */
+#define RCC_ADC12CKSELR_ADC1SRC_MASK	GENMASK(1, 0)
+#define RCC_ADC12CKSELR_ADC2SRC_MASK	GENMASK(3, 2)
+#define RCC_ADC12CKSELR_ADC1SRC_SHIFT	0
+#define RCC_ADC12CKSELR_ADC2SRC_SHIFT	2
+
+/* RCC_SDMMC12CKSELR register fields */
+#define RCC_SDMMC12CKSELR_SDMMC1SRC_MASK	GENMASK(2, 0)
+#define RCC_SDMMC12CKSELR_SDMMC2SRC_MASK	GENMASK(5, 3)
+#define RCC_SDMMC12CKSELR_SDMMC1SRC_SHIFT	0
+#define RCC_SDMMC12CKSELR_SDMMC2SRC_SHIFT	3
+
+/* RCC_ETH12CKSELR register fields */
+#define RCC_ETH12CKSELR_ETH1SRC_MASK	GENMASK(1, 0)
+#define RCC_ETH12CKSELR_ETH1PTPDIV_MASK	GENMASK(7, 4)
+#define RCC_ETH12CKSELR_ETH2SRC_MASK	GENMASK(9, 8)
+#define RCC_ETH12CKSELR_ETH2PTPDIV_MASK	GENMASK(15, 12)
+#define RCC_ETH12CKSELR_ETH1SRC_SHIFT	0
+#define RCC_ETH12CKSELR_ETH1PTPDIV_SHIFT	4
+#define RCC_ETH12CKSELR_ETH2SRC_SHIFT	8
+#define RCC_ETH12CKSELR_ETH2PTPDIV_SHIFT	12
+
+/* RCC_USBCKSELR register fields */
+#define RCC_USBCKSELR_USBPHYSRC_MASK	GENMASK(1, 0)
+#define RCC_USBCKSELR_USBOSRC		BIT(4)
+#define RCC_USBCKSELR_USBPHYSRC_SHIFT	0
+
+/* RCC_QSPICKSELR register fields */
+#define RCC_QSPICKSELR_QSPISRC_MASK	GENMASK(1, 0)
+#define RCC_QSPICKSELR_QSPISRC_SHIFT	0
+
+/* RCC_FMCCKSELR register fields */
+#define RCC_FMCCKSELR_FMCSRC_MASK	GENMASK(1, 0)
+#define RCC_FMCCKSELR_FMCSRC_SHIFT	0
+
+/* RCC_RNG1CKSELR register fields */
+#define RCC_RNG1CKSELR_RNG1SRC_MASK	GENMASK(1, 0)
+#define RCC_RNG1CKSELR_RNG1SRC_SHIFT	0
+
+/* RCC_STGENCKSELR register fields */
+#define RCC_STGENCKSELR_STGENSRC_MASK	GENMASK(1, 0)
+#define RCC_STGENCKSELR_STGENSRC_SHIFT	0
+
+/* RCC_DCMIPPCKSELR register fields */
+#define RCC_DCMIPPCKSELR_DCMIPPSRC_MASK	GENMASK(1, 0)
+#define RCC_DCMIPPCKSELR_DCMIPPSRC_SHIFT	0
+
+/* RCC_SAESCKSELR register fields */
+#define RCC_SAESCKSELR_SAESSRC_MASK	GENMASK(1, 0)
+#define RCC_SAESCKSELR_SAESSRC_SHIFT	0
+
+/* RCC_APB1RSTSETR register fields */
+#define RCC_APB1RSTSETR_TIM2RST		BIT(0)
+#define RCC_APB1RSTSETR_TIM3RST		BIT(1)
+#define RCC_APB1RSTSETR_TIM4RST		BIT(2)
+#define RCC_APB1RSTSETR_TIM5RST		BIT(3)
+#define RCC_APB1RSTSETR_TIM6RST		BIT(4)
+#define RCC_APB1RSTSETR_TIM7RST		BIT(5)
+#define RCC_APB1RSTSETR_LPTIM1RST	BIT(9)
+#define RCC_APB1RSTSETR_SPI2RST		BIT(11)
+#define RCC_APB1RSTSETR_SPI3RST		BIT(12)
+#define RCC_APB1RSTSETR_USART3RST	BIT(15)
+#define RCC_APB1RSTSETR_UART4RST	BIT(16)
+#define RCC_APB1RSTSETR_UART5RST	BIT(17)
+#define RCC_APB1RSTSETR_UART7RST	BIT(18)
+#define RCC_APB1RSTSETR_UART8RST	BIT(19)
+#define RCC_APB1RSTSETR_I2C1RST		BIT(21)
+#define RCC_APB1RSTSETR_I2C2RST		BIT(22)
+#define RCC_APB1RSTSETR_SPDIFRST	BIT(26)
+
+/* RCC_APB1RSTCLRR register fields */
+#define RCC_APB1RSTCLRR_TIM2RST		BIT(0)
+#define RCC_APB1RSTCLRR_TIM3RST		BIT(1)
+#define RCC_APB1RSTCLRR_TIM4RST		BIT(2)
+#define RCC_APB1RSTCLRR_TIM5RST		BIT(3)
+#define RCC_APB1RSTCLRR_TIM6RST		BIT(4)
+#define RCC_APB1RSTCLRR_TIM7RST		BIT(5)
+#define RCC_APB1RSTCLRR_LPTIM1RST	BIT(9)
+#define RCC_APB1RSTCLRR_SPI2RST		BIT(11)
+#define RCC_APB1RSTCLRR_SPI3RST		BIT(12)
+#define RCC_APB1RSTCLRR_USART3RST	BIT(15)
+#define RCC_APB1RSTCLRR_UART4RST	BIT(16)
+#define RCC_APB1RSTCLRR_UART5RST	BIT(17)
+#define RCC_APB1RSTCLRR_UART7RST	BIT(18)
+#define RCC_APB1RSTCLRR_UART8RST	BIT(19)
+#define RCC_APB1RSTCLRR_I2C1RST		BIT(21)
+#define RCC_APB1RSTCLRR_I2C2RST		BIT(22)
+#define RCC_APB1RSTCLRR_SPDIFRST	BIT(26)
+
+/* RCC_APB2RSTSETR register fields */
+#define RCC_APB2RSTSETR_TIM1RST		BIT(0)
+#define RCC_APB2RSTSETR_TIM8RST		BIT(1)
+#define RCC_APB2RSTSETR_SPI1RST		BIT(8)
+#define RCC_APB2RSTSETR_USART6RST	BIT(13)
+#define RCC_APB2RSTSETR_SAI1RST		BIT(16)
+#define RCC_APB2RSTSETR_SAI2RST		BIT(17)
+#define RCC_APB2RSTSETR_DFSDMRST	BIT(20)
+#define RCC_APB2RSTSETR_FDCANRST	BIT(24)
+
+/* RCC_APB2RSTCLRR register fields */
+#define RCC_APB2RSTCLRR_TIM1RST		BIT(0)
+#define RCC_APB2RSTCLRR_TIM8RST		BIT(1)
+#define RCC_APB2RSTCLRR_SPI1RST		BIT(8)
+#define RCC_APB2RSTCLRR_USART6RST	BIT(13)
+#define RCC_APB2RSTCLRR_SAI1RST		BIT(16)
+#define RCC_APB2RSTCLRR_SAI2RST		BIT(17)
+#define RCC_APB2RSTCLRR_DFSDMRST	BIT(20)
+#define RCC_APB2RSTCLRR_FDCANRST	BIT(24)
+
+/* RCC_APB3RSTSETR register fields */
+#define RCC_APB3RSTSETR_LPTIM2RST	BIT(0)
+#define RCC_APB3RSTSETR_LPTIM3RST	BIT(1)
+#define RCC_APB3RSTSETR_LPTIM4RST	BIT(2)
+#define RCC_APB3RSTSETR_LPTIM5RST	BIT(3)
+#define RCC_APB3RSTSETR_SYSCFGRST	BIT(11)
+#define RCC_APB3RSTSETR_VREFRST		BIT(13)
+#define RCC_APB3RSTSETR_DTSRST		BIT(16)
+#define RCC_APB3RSTSETR_PMBCTRLRST	BIT(17)
+
+/* RCC_APB3RSTCLRR register fields */
+#define RCC_APB3RSTCLRR_LPTIM2RST	BIT(0)
+#define RCC_APB3RSTCLRR_LPTIM3RST	BIT(1)
+#define RCC_APB3RSTCLRR_LPTIM4RST	BIT(2)
+#define RCC_APB3RSTCLRR_LPTIM5RST	BIT(3)
+#define RCC_APB3RSTCLRR_SYSCFGRST	BIT(11)
+#define RCC_APB3RSTCLRR_VREFRST		BIT(13)
+#define RCC_APB3RSTCLRR_DTSRST		BIT(16)
+#define RCC_APB3RSTCLRR_PMBCTRLRST	BIT(17)
+
+/* RCC_APB4RSTSETR register fields */
+#define RCC_APB4RSTSETR_LTDCRST		BIT(0)
+#define RCC_APB4RSTSETR_DCMIPPRST	BIT(1)
+#define RCC_APB4RSTSETR_DDRPERFMRST	BIT(8)
+#define RCC_APB4RSTSETR_USBPHYRST	BIT(16)
+
+/* RCC_APB4RSTCLRR register fields */
+#define RCC_APB4RSTCLRR_LTDCRST		BIT(0)
+#define RCC_APB4RSTCLRR_DCMIPPRST	BIT(1)
+#define RCC_APB4RSTCLRR_DDRPERFMRST	BIT(8)
+#define RCC_APB4RSTCLRR_USBPHYRST	BIT(16)
+
+/* RCC_APB5RSTSETR register fields */
+#define RCC_APB5RSTSETR_STGENRST	BIT(20)
+
+/* RCC_APB5RSTCLRR register fields */
+#define RCC_APB5RSTCLRR_STGENRST	BIT(20)
+
+/* RCC_APB6RSTSETR register fields */
+#define RCC_APB6RSTSETR_USART1RST	BIT(0)
+#define RCC_APB6RSTSETR_USART2RST	BIT(1)
+#define RCC_APB6RSTSETR_SPI4RST		BIT(2)
+#define RCC_APB6RSTSETR_SPI5RST		BIT(3)
+#define RCC_APB6RSTSETR_I2C3RST		BIT(4)
+#define RCC_APB6RSTSETR_I2C4RST		BIT(5)
+#define RCC_APB6RSTSETR_I2C5RST		BIT(6)
+#define RCC_APB6RSTSETR_TIM12RST	BIT(7)
+#define RCC_APB6RSTSETR_TIM13RST	BIT(8)
+#define RCC_APB6RSTSETR_TIM14RST	BIT(9)
+#define RCC_APB6RSTSETR_TIM15RST	BIT(10)
+#define RCC_APB6RSTSETR_TIM16RST	BIT(11)
+#define RCC_APB6RSTSETR_TIM17RST	BIT(12)
+
+/* RCC_APB6RSTCLRR register fields */
+#define RCC_APB6RSTCLRR_USART1RST	BIT(0)
+#define RCC_APB6RSTCLRR_USART2RST	BIT(1)
+#define RCC_APB6RSTCLRR_SPI4RST		BIT(2)
+#define RCC_APB6RSTCLRR_SPI5RST		BIT(3)
+#define RCC_APB6RSTCLRR_I2C3RST		BIT(4)
+#define RCC_APB6RSTCLRR_I2C4RST		BIT(5)
+#define RCC_APB6RSTCLRR_I2C5RST		BIT(6)
+#define RCC_APB6RSTCLRR_TIM12RST	BIT(7)
+#define RCC_APB6RSTCLRR_TIM13RST	BIT(8)
+#define RCC_APB6RSTCLRR_TIM14RST	BIT(9)
+#define RCC_APB6RSTCLRR_TIM15RST	BIT(10)
+#define RCC_APB6RSTCLRR_TIM16RST	BIT(11)
+#define RCC_APB6RSTCLRR_TIM17RST	BIT(12)
+
+/* RCC_AHB2RSTSETR register fields */
+#define RCC_AHB2RSTSETR_DMA1RST		BIT(0)
+#define RCC_AHB2RSTSETR_DMA2RST		BIT(1)
+#define RCC_AHB2RSTSETR_DMAMUX1RST	BIT(2)
+#define RCC_AHB2RSTSETR_DMA3RST		BIT(3)
+#define RCC_AHB2RSTSETR_DMAMUX2RST	BIT(4)
+#define RCC_AHB2RSTSETR_ADC1RST		BIT(5)
+#define RCC_AHB2RSTSETR_ADC2RST		BIT(6)
+#define RCC_AHB2RSTSETR_USBORST		BIT(8)
+
+/* RCC_AHB2RSTCLRR register fields */
+#define RCC_AHB2RSTCLRR_DMA1RST		BIT(0)
+#define RCC_AHB2RSTCLRR_DMA2RST		BIT(1)
+#define RCC_AHB2RSTCLRR_DMAMUX1RST	BIT(2)
+#define RCC_AHB2RSTCLRR_DMA3RST		BIT(3)
+#define RCC_AHB2RSTCLRR_DMAMUX2RST	BIT(4)
+#define RCC_AHB2RSTCLRR_ADC1RST		BIT(5)
+#define RCC_AHB2RSTCLRR_ADC2RST		BIT(6)
+#define RCC_AHB2RSTCLRR_USBORST		BIT(8)
+
+/* RCC_AHB4RSTSETR register fields */
+#define RCC_AHB4RSTSETR_GPIOARST	BIT(0)
+#define RCC_AHB4RSTSETR_GPIOBRST	BIT(1)
+#define RCC_AHB4RSTSETR_GPIOCRST	BIT(2)
+#define RCC_AHB4RSTSETR_GPIODRST	BIT(3)
+#define RCC_AHB4RSTSETR_GPIOERST	BIT(4)
+#define RCC_AHB4RSTSETR_GPIOFRST	BIT(5)
+#define RCC_AHB4RSTSETR_GPIOGRST	BIT(6)
+#define RCC_AHB4RSTSETR_GPIOHRST	BIT(7)
+#define RCC_AHB4RSTSETR_GPIOIRST	BIT(8)
+#define RCC_AHB4RSTSETR_TSCRST		BIT(15)
+
+/* RCC_AHB4RSTCLRR register fields */
+#define RCC_AHB4RSTCLRR_GPIOARST	BIT(0)
+#define RCC_AHB4RSTCLRR_GPIOBRST	BIT(1)
+#define RCC_AHB4RSTCLRR_GPIOCRST	BIT(2)
+#define RCC_AHB4RSTCLRR_GPIODRST	BIT(3)
+#define RCC_AHB4RSTCLRR_GPIOERST	BIT(4)
+#define RCC_AHB4RSTCLRR_GPIOFRST	BIT(5)
+#define RCC_AHB4RSTCLRR_GPIOGRST	BIT(6)
+#define RCC_AHB4RSTCLRR_GPIOHRST	BIT(7)
+#define RCC_AHB4RSTCLRR_GPIOIRST	BIT(8)
+#define RCC_AHB4RSTCLRR_TSCRST		BIT(15)
+
+/* RCC_AHB5RSTSETR register fields */
+#define RCC_AHB5RSTSETR_PKARST		BIT(2)
+#define RCC_AHB5RSTSETR_SAESRST		BIT(3)
+#define RCC_AHB5RSTSETR_CRYP1RST	BIT(4)
+#define RCC_AHB5RSTSETR_HASH1RST	BIT(5)
+#define RCC_AHB5RSTSETR_RNG1RST		BIT(6)
+#define RCC_AHB5RSTSETR_AXIMCRST	BIT(16)
+
+/* RCC_AHB5RSTCLRR register fields */
+#define RCC_AHB5RSTCLRR_PKARST		BIT(2)
+#define RCC_AHB5RSTCLRR_SAESRST		BIT(3)
+#define RCC_AHB5RSTCLRR_CRYP1RST	BIT(4)
+#define RCC_AHB5RSTCLRR_HASH1RST	BIT(5)
+#define RCC_AHB5RSTCLRR_RNG1RST		BIT(6)
+#define RCC_AHB5RSTCLRR_AXIMCRST	BIT(16)
+
+/* RCC_AHB6RSTSETR register fields */
+#define RCC_AHB6RSTSETR_MDMARST		BIT(0)
+#define RCC_AHB6RSTSETR_MCERST		BIT(1)
+#define RCC_AHB6RSTSETR_ETH1MACRST	BIT(10)
+#define RCC_AHB6RSTSETR_FMCRST		BIT(12)
+#define RCC_AHB6RSTSETR_QSPIRST		BIT(14)
+#define RCC_AHB6RSTSETR_SDMMC1RST	BIT(16)
+#define RCC_AHB6RSTSETR_SDMMC2RST	BIT(17)
+#define RCC_AHB6RSTSETR_CRC1RST		BIT(20)
+#define RCC_AHB6RSTSETR_USBHRST		BIT(24)
+#define RCC_AHB6RSTSETR_ETH2MACRST	BIT(30)
+
+/* RCC_AHB6RSTCLRR register fields */
+#define RCC_AHB6RSTCLRR_MDMARST		BIT(0)
+#define RCC_AHB6RSTCLRR_MCERST		BIT(1)
+#define RCC_AHB6RSTCLRR_ETH1MACRST	BIT(10)
+#define RCC_AHB6RSTCLRR_FMCRST		BIT(12)
+#define RCC_AHB6RSTCLRR_QSPIRST		BIT(14)
+#define RCC_AHB6RSTCLRR_SDMMC1RST	BIT(16)
+#define RCC_AHB6RSTCLRR_SDMMC2RST	BIT(17)
+#define RCC_AHB6RSTCLRR_CRC1RST		BIT(20)
+#define RCC_AHB6RSTCLRR_USBHRST		BIT(24)
+#define RCC_AHB6RSTCLRR_ETH2MACRST	BIT(30)
+
+/* RCC_MP_APB1ENSETR register fields */
+#define RCC_MP_APB1ENSETR_TIM2EN	BIT(0)
+#define RCC_MP_APB1ENSETR_TIM3EN	BIT(1)
+#define RCC_MP_APB1ENSETR_TIM4EN	BIT(2)
+#define RCC_MP_APB1ENSETR_TIM5EN	BIT(3)
+#define RCC_MP_APB1ENSETR_TIM6EN	BIT(4)
+#define RCC_MP_APB1ENSETR_TIM7EN	BIT(5)
+#define RCC_MP_APB1ENSETR_LPTIM1EN	BIT(9)
+#define RCC_MP_APB1ENSETR_SPI2EN	BIT(11)
+#define RCC_MP_APB1ENSETR_SPI3EN	BIT(12)
+#define RCC_MP_APB1ENSETR_USART3EN	BIT(15)
+#define RCC_MP_APB1ENSETR_UART4EN	BIT(16)
+#define RCC_MP_APB1ENSETR_UART5EN	BIT(17)
+#define RCC_MP_APB1ENSETR_UART7EN	BIT(18)
+#define RCC_MP_APB1ENSETR_UART8EN	BIT(19)
+#define RCC_MP_APB1ENSETR_I2C1EN	BIT(21)
+#define RCC_MP_APB1ENSETR_I2C2EN	BIT(22)
+#define RCC_MP_APB1ENSETR_SPDIFEN	BIT(26)
+
+/* RCC_MP_APB1ENCLRR register fields */
+#define RCC_MP_APB1ENCLRR_TIM2EN	BIT(0)
+#define RCC_MP_APB1ENCLRR_TIM3EN	BIT(1)
+#define RCC_MP_APB1ENCLRR_TIM4EN	BIT(2)
+#define RCC_MP_APB1ENCLRR_TIM5EN	BIT(3)
+#define RCC_MP_APB1ENCLRR_TIM6EN	BIT(4)
+#define RCC_MP_APB1ENCLRR_TIM7EN	BIT(5)
+#define RCC_MP_APB1ENCLRR_LPTIM1EN	BIT(9)
+#define RCC_MP_APB1ENCLRR_SPI2EN	BIT(11)
+#define RCC_MP_APB1ENCLRR_SPI3EN	BIT(12)
+#define RCC_MP_APB1ENCLRR_USART3EN	BIT(15)
+#define RCC_MP_APB1ENCLRR_UART4EN	BIT(16)
+#define RCC_MP_APB1ENCLRR_UART5EN	BIT(17)
+#define RCC_MP_APB1ENCLRR_UART7EN	BIT(18)
+#define RCC_MP_APB1ENCLRR_UART8EN	BIT(19)
+#define RCC_MP_APB1ENCLRR_I2C1EN	BIT(21)
+#define RCC_MP_APB1ENCLRR_I2C2EN	BIT(22)
+#define RCC_MP_APB1ENCLRR_SPDIFEN	BIT(26)
+
+/* RCC_MP_APB2ENSETR register fields */
+#define RCC_MP_APB2ENSETR_TIM1EN	BIT(0)
+#define RCC_MP_APB2ENSETR_TIM8EN	BIT(1)
+#define RCC_MP_APB2ENSETR_SPI1EN	BIT(8)
+#define RCC_MP_APB2ENSETR_USART6EN	BIT(13)
+#define RCC_MP_APB2ENSETR_SAI1EN	BIT(16)
+#define RCC_MP_APB2ENSETR_SAI2EN	BIT(17)
+#define RCC_MP_APB2ENSETR_DFSDMEN	BIT(20)
+#define RCC_MP_APB2ENSETR_ADFSDMEN	BIT(21)
+#define RCC_MP_APB2ENSETR_FDCANEN	BIT(24)
+
+/* RCC_MP_APB2ENCLRR register fields */
+#define RCC_MP_APB2ENCLRR_TIM1EN	BIT(0)
+#define RCC_MP_APB2ENCLRR_TIM8EN	BIT(1)
+#define RCC_MP_APB2ENCLRR_SPI1EN	BIT(8)
+#define RCC_MP_APB2ENCLRR_USART6EN	BIT(13)
+#define RCC_MP_APB2ENCLRR_SAI1EN	BIT(16)
+#define RCC_MP_APB2ENCLRR_SAI2EN	BIT(17)
+#define RCC_MP_APB2ENCLRR_DFSDMEN	BIT(20)
+#define RCC_MP_APB2ENCLRR_ADFSDMEN	BIT(21)
+#define RCC_MP_APB2ENCLRR_FDCANEN	BIT(24)
+
+/* RCC_MP_APB3ENSETR register fields */
+#define RCC_MP_APB3ENSETR_LPTIM2EN	BIT(0)
+#define RCC_MP_APB3ENSETR_LPTIM3EN	BIT(1)
+#define RCC_MP_APB3ENSETR_LPTIM4EN	BIT(2)
+#define RCC_MP_APB3ENSETR_LPTIM5EN	BIT(3)
+#define RCC_MP_APB3ENSETR_VREFEN	BIT(13)
+#define RCC_MP_APB3ENSETR_DTSEN		BIT(16)
+#define RCC_MP_APB3ENSETR_PMBCTRLEN	BIT(17)
+#define RCC_MP_APB3ENSETR_HDPEN		BIT(20)
+
+/* RCC_MP_APB3ENCLRR register fields */
+#define RCC_MP_APB3ENCLRR_LPTIM2EN	BIT(0)
+#define RCC_MP_APB3ENCLRR_LPTIM3EN	BIT(1)
+#define RCC_MP_APB3ENCLRR_LPTIM4EN	BIT(2)
+#define RCC_MP_APB3ENCLRR_LPTIM5EN	BIT(3)
+#define RCC_MP_APB3ENCLRR_VREFEN	BIT(13)
+#define RCC_MP_APB3ENCLRR_DTSEN		BIT(16)
+#define RCC_MP_APB3ENCLRR_PMBCTRLEN	BIT(17)
+#define RCC_MP_APB3ENCLRR_HDPEN		BIT(20)
+
+/* RCC_MP_S_APB3ENSETR register fields */
+#define RCC_MP_S_APB3ENSETR_SYSCFGEN	BIT(0)
+
+/* RCC_MP_S_APB3ENCLRR register fields */
+#define RCC_MP_S_APB3ENCLRR_SYSCFGEN	BIT(0)
+
+/* RCC_MP_NS_APB3ENSETR register fields */
+#define RCC_MP_NS_APB3ENSETR_SYSCFGEN	BIT(0)
+
+/* RCC_MP_NS_APB3ENCLRR register fields */
+#define RCC_MP_NS_APB3ENCLRR_SYSCFGEN	BIT(0)
+
+/* RCC_MP_APB4ENSETR register fields */
+#define RCC_MP_APB4ENSETR_DCMIPPEN	BIT(1)
+#define RCC_MP_APB4ENSETR_DDRPERFMEN	BIT(8)
+#define RCC_MP_APB4ENSETR_IWDG2APBEN	BIT(15)
+#define RCC_MP_APB4ENSETR_USBPHYEN	BIT(16)
+#define RCC_MP_APB4ENSETR_STGENROEN	BIT(20)
+
+/* RCC_MP_APB4ENCLRR register fields */
+#define RCC_MP_APB4ENCLRR_DCMIPPEN	BIT(1)
+#define RCC_MP_APB4ENCLRR_DDRPERFMEN	BIT(8)
+#define RCC_MP_APB4ENCLRR_IWDG2APBEN	BIT(15)
+#define RCC_MP_APB4ENCLRR_USBPHYEN	BIT(16)
+#define RCC_MP_APB4ENCLRR_STGENROEN	BIT(20)
+
+/* RCC_MP_S_APB4ENSETR register fields */
+#define RCC_MP_S_APB4ENSETR_LTDCEN	BIT(0)
+
+/* RCC_MP_S_APB4ENCLRR register fields */
+#define RCC_MP_S_APB4ENCLRR_LTDCEN	BIT(0)
+
+/* RCC_MP_NS_APB4ENSETR register fields */
+#define RCC_MP_NS_APB4ENSETR_LTDCEN	BIT(0)
+
+/* RCC_MP_NS_APB4ENCLRR register fields */
+#define RCC_MP_NS_APB4ENCLRR_LTDCEN	BIT(0)
+
+/* RCC_MP_APB5ENSETR register fields */
+#define RCC_MP_APB5ENSETR_RTCAPBEN	BIT(8)
+#define RCC_MP_APB5ENSETR_TZCEN		BIT(11)
+#define RCC_MP_APB5ENSETR_ETZPCEN	BIT(13)
+#define RCC_MP_APB5ENSETR_IWDG1APBEN	BIT(15)
+#define RCC_MP_APB5ENSETR_BSECEN	BIT(16)
+#define RCC_MP_APB5ENSETR_STGENCEN	BIT(20)
+
+/* RCC_MP_APB5ENCLRR register fields */
+#define RCC_MP_APB5ENCLRR_RTCAPBEN	BIT(8)
+#define RCC_MP_APB5ENCLRR_TZCEN		BIT(11)
+#define RCC_MP_APB5ENCLRR_ETZPCEN	BIT(13)
+#define RCC_MP_APB5ENCLRR_IWDG1APBEN	BIT(15)
+#define RCC_MP_APB5ENCLRR_BSECEN	BIT(16)
+#define RCC_MP_APB5ENCLRR_STGENCEN	BIT(20)
+
+/* RCC_MP_APB6ENSETR register fields */
+#define RCC_MP_APB6ENSETR_USART1EN	BIT(0)
+#define RCC_MP_APB6ENSETR_USART2EN	BIT(1)
+#define RCC_MP_APB6ENSETR_SPI4EN	BIT(2)
+#define RCC_MP_APB6ENSETR_SPI5EN	BIT(3)
+#define RCC_MP_APB6ENSETR_I2C3EN	BIT(4)
+#define RCC_MP_APB6ENSETR_I2C4EN	BIT(5)
+#define RCC_MP_APB6ENSETR_I2C5EN	BIT(6)
+#define RCC_MP_APB6ENSETR_TIM12EN	BIT(7)
+#define RCC_MP_APB6ENSETR_TIM13EN	BIT(8)
+#define RCC_MP_APB6ENSETR_TIM14EN	BIT(9)
+#define RCC_MP_APB6ENSETR_TIM15EN	BIT(10)
+#define RCC_MP_APB6ENSETR_TIM16EN	BIT(11)
+#define RCC_MP_APB6ENSETR_TIM17EN	BIT(12)
+
+/* RCC_MP_APB6ENCLRR register fields */
+#define RCC_MP_APB6ENCLRR_USART1EN	BIT(0)
+#define RCC_MP_APB6ENCLRR_USART2EN	BIT(1)
+#define RCC_MP_APB6ENCLRR_SPI4EN	BIT(2)
+#define RCC_MP_APB6ENCLRR_SPI5EN	BIT(3)
+#define RCC_MP_APB6ENCLRR_I2C3EN	BIT(4)
+#define RCC_MP_APB6ENCLRR_I2C4EN	BIT(5)
+#define RCC_MP_APB6ENCLRR_I2C5EN	BIT(6)
+#define RCC_MP_APB6ENCLRR_TIM12EN	BIT(7)
+#define RCC_MP_APB6ENCLRR_TIM13EN	BIT(8)
+#define RCC_MP_APB6ENCLRR_TIM14EN	BIT(9)
+#define RCC_MP_APB6ENCLRR_TIM15EN	BIT(10)
+#define RCC_MP_APB6ENCLRR_TIM16EN	BIT(11)
+#define RCC_MP_APB6ENCLRR_TIM17EN	BIT(12)
+
+/* RCC_MP_AHB2ENSETR register fields */
+#define RCC_MP_AHB2ENSETR_DMA1EN	BIT(0)
+#define RCC_MP_AHB2ENSETR_DMA2EN	BIT(1)
+#define RCC_MP_AHB2ENSETR_DMAMUX1EN	BIT(2)
+#define RCC_MP_AHB2ENSETR_DMA3EN	BIT(3)
+#define RCC_MP_AHB2ENSETR_DMAMUX2EN	BIT(4)
+#define RCC_MP_AHB2ENSETR_ADC1EN	BIT(5)
+#define RCC_MP_AHB2ENSETR_ADC2EN	BIT(6)
+#define RCC_MP_AHB2ENSETR_USBOEN	BIT(8)
+
+/* RCC_MP_AHB2ENCLRR register fields */
+#define RCC_MP_AHB2ENCLRR_DMA1EN	BIT(0)
+#define RCC_MP_AHB2ENCLRR_DMA2EN	BIT(1)
+#define RCC_MP_AHB2ENCLRR_DMAMUX1EN	BIT(2)
+#define RCC_MP_AHB2ENCLRR_DMA3EN	BIT(3)
+#define RCC_MP_AHB2ENCLRR_DMAMUX2EN	BIT(4)
+#define RCC_MP_AHB2ENCLRR_ADC1EN	BIT(5)
+#define RCC_MP_AHB2ENCLRR_ADC2EN	BIT(6)
+#define RCC_MP_AHB2ENCLRR_USBOEN	BIT(8)
+
+/* RCC_MP_AHB4ENSETR register fields */
+#define RCC_MP_AHB4ENSETR_TSCEN		BIT(15)
+
+/* RCC_MP_AHB4ENCLRR register fields */
+#define RCC_MP_AHB4ENCLRR_TSCEN		BIT(15)
+
+/* RCC_MP_S_AHB4ENSETR register fields */
+#define RCC_MP_S_AHB4ENSETR_GPIOAEN	BIT(0)
+#define RCC_MP_S_AHB4ENSETR_GPIOBEN	BIT(1)
+#define RCC_MP_S_AHB4ENSETR_GPIOCEN	BIT(2)
+#define RCC_MP_S_AHB4ENSETR_GPIODEN	BIT(3)
+#define RCC_MP_S_AHB4ENSETR_GPIOEEN	BIT(4)
+#define RCC_MP_S_AHB4ENSETR_GPIOFEN	BIT(5)
+#define RCC_MP_S_AHB4ENSETR_GPIOGEN	BIT(6)
+#define RCC_MP_S_AHB4ENSETR_GPIOHEN	BIT(7)
+#define RCC_MP_S_AHB4ENSETR_GPIOIEN	BIT(8)
+
+/* RCC_MP_S_AHB4ENCLRR register fields */
+#define RCC_MP_S_AHB4ENCLRR_GPIOAEN	BIT(0)
+#define RCC_MP_S_AHB4ENCLRR_GPIOBEN	BIT(1)
+#define RCC_MP_S_AHB4ENCLRR_GPIOCEN	BIT(2)
+#define RCC_MP_S_AHB4ENCLRR_GPIODEN	BIT(3)
+#define RCC_MP_S_AHB4ENCLRR_GPIOEEN	BIT(4)
+#define RCC_MP_S_AHB4ENCLRR_GPIOFEN	BIT(5)
+#define RCC_MP_S_AHB4ENCLRR_GPIOGEN	BIT(6)
+#define RCC_MP_S_AHB4ENCLRR_GPIOHEN	BIT(7)
+#define RCC_MP_S_AHB4ENCLRR_GPIOIEN	BIT(8)
+
+/* RCC_MP_NS_AHB4ENSETR register fields */
+#define RCC_MP_NS_AHB4ENSETR_GPIOAEN	BIT(0)
+#define RCC_MP_NS_AHB4ENSETR_GPIOBEN	BIT(1)
+#define RCC_MP_NS_AHB4ENSETR_GPIOCEN	BIT(2)
+#define RCC_MP_NS_AHB4ENSETR_GPIODEN	BIT(3)
+#define RCC_MP_NS_AHB4ENSETR_GPIOEEN	BIT(4)
+#define RCC_MP_NS_AHB4ENSETR_GPIOFEN	BIT(5)
+#define RCC_MP_NS_AHB4ENSETR_GPIOGEN	BIT(6)
+#define RCC_MP_NS_AHB4ENSETR_GPIOHEN	BIT(7)
+#define RCC_MP_NS_AHB4ENSETR_GPIOIEN	BIT(8)
+
+/* RCC_MP_NS_AHB4ENCLRR register fields */
+#define RCC_MP_NS_AHB4ENCLRR_GPIOAEN	BIT(0)
+#define RCC_MP_NS_AHB4ENCLRR_GPIOBEN	BIT(1)
+#define RCC_MP_NS_AHB4ENCLRR_GPIOCEN	BIT(2)
+#define RCC_MP_NS_AHB4ENCLRR_GPIODEN	BIT(3)
+#define RCC_MP_NS_AHB4ENCLRR_GPIOEEN	BIT(4)
+#define RCC_MP_NS_AHB4ENCLRR_GPIOFEN	BIT(5)
+#define RCC_MP_NS_AHB4ENCLRR_GPIOGEN	BIT(6)
+#define RCC_MP_NS_AHB4ENCLRR_GPIOHEN	BIT(7)
+#define RCC_MP_NS_AHB4ENCLRR_GPIOIEN	BIT(8)
+
+/* RCC_MP_AHB5ENSETR register fields */
+#define RCC_MP_AHB5ENSETR_PKAEN		BIT(2)
+#define RCC_MP_AHB5ENSETR_SAESEN	BIT(3)
+#define RCC_MP_AHB5ENSETR_CRYP1EN	BIT(4)
+#define RCC_MP_AHB5ENSETR_HASH1EN	BIT(5)
+#define RCC_MP_AHB5ENSETR_RNG1EN	BIT(6)
+#define RCC_MP_AHB5ENSETR_BKPSRAMEN	BIT(8)
+#define RCC_MP_AHB5ENSETR_AXIMCEN	BIT(16)
+
+/* RCC_MP_AHB5ENCLRR register fields */
+#define RCC_MP_AHB5ENCLRR_PKAEN		BIT(2)
+#define RCC_MP_AHB5ENCLRR_SAESEN	BIT(3)
+#define RCC_MP_AHB5ENCLRR_CRYP1EN	BIT(4)
+#define RCC_MP_AHB5ENCLRR_HASH1EN	BIT(5)
+#define RCC_MP_AHB5ENCLRR_RNG1EN	BIT(6)
+#define RCC_MP_AHB5ENCLRR_BKPSRAMEN	BIT(8)
+#define RCC_MP_AHB5ENCLRR_AXIMCEN	BIT(16)
+
+/* RCC_MP_AHB6ENSETR register fields */
+#define RCC_MP_AHB6ENSETR_MCEEN		BIT(1)
+#define RCC_MP_AHB6ENSETR_ETH1CKEN	BIT(7)
+#define RCC_MP_AHB6ENSETR_ETH1TXEN	BIT(8)
+#define RCC_MP_AHB6ENSETR_ETH1RXEN	BIT(9)
+#define RCC_MP_AHB6ENSETR_ETH1MACEN	BIT(10)
+#define RCC_MP_AHB6ENSETR_FMCEN		BIT(12)
+#define RCC_MP_AHB6ENSETR_QSPIEN	BIT(14)
+#define RCC_MP_AHB6ENSETR_SDMMC1EN	BIT(16)
+#define RCC_MP_AHB6ENSETR_SDMMC2EN	BIT(17)
+#define RCC_MP_AHB6ENSETR_CRC1EN	BIT(20)
+#define RCC_MP_AHB6ENSETR_USBHEN	BIT(24)
+#define RCC_MP_AHB6ENSETR_ETH2CKEN	BIT(27)
+#define RCC_MP_AHB6ENSETR_ETH2TXEN	BIT(28)
+#define RCC_MP_AHB6ENSETR_ETH2RXEN	BIT(29)
+#define RCC_MP_AHB6ENSETR_ETH2MACEN	BIT(30)
+
+/* RCC_MP_AHB6ENCLRR register fields */
+#define RCC_MP_AHB6ENCLRR_MCEEN		BIT(1)
+#define RCC_MP_AHB6ENCLRR_ETH1CKEN	BIT(7)
+#define RCC_MP_AHB6ENCLRR_ETH1TXEN	BIT(8)
+#define RCC_MP_AHB6ENCLRR_ETH1RXEN	BIT(9)
+#define RCC_MP_AHB6ENCLRR_ETH1MACEN	BIT(10)
+#define RCC_MP_AHB6ENCLRR_FMCEN		BIT(12)
+#define RCC_MP_AHB6ENCLRR_QSPIEN	BIT(14)
+#define RCC_MP_AHB6ENCLRR_SDMMC1EN	BIT(16)
+#define RCC_MP_AHB6ENCLRR_SDMMC2EN	BIT(17)
+#define RCC_MP_AHB6ENCLRR_CRC1EN	BIT(20)
+#define RCC_MP_AHB6ENCLRR_USBHEN	BIT(24)
+#define RCC_MP_AHB6ENCLRR_ETH2CKEN	BIT(27)
+#define RCC_MP_AHB6ENCLRR_ETH2TXEN	BIT(28)
+#define RCC_MP_AHB6ENCLRR_ETH2RXEN	BIT(29)
+#define RCC_MP_AHB6ENCLRR_ETH2MACEN	BIT(30)
+
+/* RCC_MP_S_AHB6ENSETR register fields */
+#define RCC_MP_S_AHB6ENSETR_MDMAEN	BIT(0)
+
+/* RCC_MP_S_AHB6ENCLRR register fields */
+#define RCC_MP_S_AHB6ENCLRR_MDMAEN	BIT(0)
+
+/* RCC_MP_NS_AHB6ENSETR register fields */
+#define RCC_MP_NS_AHB6ENSETR_MDMAEN	BIT(0)
+
+/* RCC_MP_NS_AHB6ENCLRR register fields */
+#define RCC_MP_NS_AHB6ENCLRR_MDMAEN	BIT(0)
+
+/* RCC_MP_APB1LPENSETR register fields */
+#define RCC_MP_APB1LPENSETR_TIM2LPEN	BIT(0)
+#define RCC_MP_APB1LPENSETR_TIM3LPEN	BIT(1)
+#define RCC_MP_APB1LPENSETR_TIM4LPEN	BIT(2)
+#define RCC_MP_APB1LPENSETR_TIM5LPEN	BIT(3)
+#define RCC_MP_APB1LPENSETR_TIM6LPEN	BIT(4)
+#define RCC_MP_APB1LPENSETR_TIM7LPEN	BIT(5)
+#define RCC_MP_APB1LPENSETR_LPTIM1LPEN	BIT(9)
+#define RCC_MP_APB1LPENSETR_SPI2LPEN	BIT(11)
+#define RCC_MP_APB1LPENSETR_SPI3LPEN	BIT(12)
+#define RCC_MP_APB1LPENSETR_USART3LPEN	BIT(15)
+#define RCC_MP_APB1LPENSETR_UART4LPEN	BIT(16)
+#define RCC_MP_APB1LPENSETR_UART5LPEN	BIT(17)
+#define RCC_MP_APB1LPENSETR_UART7LPEN	BIT(18)
+#define RCC_MP_APB1LPENSETR_UART8LPEN	BIT(19)
+#define RCC_MP_APB1LPENSETR_I2C1LPEN	BIT(21)
+#define RCC_MP_APB1LPENSETR_I2C2LPEN	BIT(22)
+#define RCC_MP_APB1LPENSETR_SPDIFLPEN	BIT(26)
+
+/* RCC_MP_APB1LPENCLRR register fields */
+#define RCC_MP_APB1LPENCLRR_TIM2LPEN	BIT(0)
+#define RCC_MP_APB1LPENCLRR_TIM3LPEN	BIT(1)
+#define RCC_MP_APB1LPENCLRR_TIM4LPEN	BIT(2)
+#define RCC_MP_APB1LPENCLRR_TIM5LPEN	BIT(3)
+#define RCC_MP_APB1LPENCLRR_TIM6LPEN	BIT(4)
+#define RCC_MP_APB1LPENCLRR_TIM7LPEN	BIT(5)
+#define RCC_MP_APB1LPENCLRR_LPTIM1LPEN	BIT(9)
+#define RCC_MP_APB1LPENCLRR_SPI2LPEN	BIT(11)
+#define RCC_MP_APB1LPENCLRR_SPI3LPEN	BIT(12)
+#define RCC_MP_APB1LPENCLRR_USART3LPEN	BIT(15)
+#define RCC_MP_APB1LPENCLRR_UART4LPEN	BIT(16)
+#define RCC_MP_APB1LPENCLRR_UART5LPEN	BIT(17)
+#define RCC_MP_APB1LPENCLRR_UART7LPEN	BIT(18)
+#define RCC_MP_APB1LPENCLRR_UART8LPEN	BIT(19)
+#define RCC_MP_APB1LPENCLRR_I2C1LPEN	BIT(21)
+#define RCC_MP_APB1LPENCLRR_I2C2LPEN	BIT(22)
+#define RCC_MP_APB1LPENCLRR_SPDIFLPEN	BIT(26)
+
+/* RCC_MP_APB2LPENSETR register fields */
+#define RCC_MP_APB2LPENSETR_TIM1LPEN	BIT(0)
+#define RCC_MP_APB2LPENSETR_TIM8LPEN	BIT(1)
+#define RCC_MP_APB2LPENSETR_SPI1LPEN	BIT(8)
+#define RCC_MP_APB2LPENSETR_USART6LPEN	BIT(13)
+#define RCC_MP_APB2LPENSETR_SAI1LPEN	BIT(16)
+#define RCC_MP_APB2LPENSETR_SAI2LPEN	BIT(17)
+#define RCC_MP_APB2LPENSETR_DFSDMLPEN	BIT(20)
+#define RCC_MP_APB2LPENSETR_ADFSDMLPEN	BIT(21)
+#define RCC_MP_APB2LPENSETR_FDCANLPEN	BIT(24)
+
+/* RCC_MP_APB2LPENCLRR register fields */
+#define RCC_MP_APB2LPENCLRR_TIM1LPEN	BIT(0)
+#define RCC_MP_APB2LPENCLRR_TIM8LPEN	BIT(1)
+#define RCC_MP_APB2LPENCLRR_SPI1LPEN	BIT(8)
+#define RCC_MP_APB2LPENCLRR_USART6LPEN	BIT(13)
+#define RCC_MP_APB2LPENCLRR_SAI1LPEN	BIT(16)
+#define RCC_MP_APB2LPENCLRR_SAI2LPEN	BIT(17)
+#define RCC_MP_APB2LPENCLRR_DFSDMLPEN	BIT(20)
+#define RCC_MP_APB2LPENCLRR_ADFSDMLPEN	BIT(21)
+#define RCC_MP_APB2LPENCLRR_FDCANLPEN	BIT(24)
+
+/* RCC_MP_APB3LPENSETR register fields */
+#define RCC_MP_APB3LPENSETR_LPTIM2LPEN	BIT(0)
+#define RCC_MP_APB3LPENSETR_LPTIM3LPEN	BIT(1)
+#define RCC_MP_APB3LPENSETR_LPTIM4LPEN	BIT(2)
+#define RCC_MP_APB3LPENSETR_LPTIM5LPEN	BIT(3)
+#define RCC_MP_APB3LPENSETR_VREFLPEN	BIT(13)
+#define RCC_MP_APB3LPENSETR_DTSLPEN	BIT(16)
+#define RCC_MP_APB3LPENSETR_PMBCTRLLPEN	BIT(17)
+
+/* RCC_MP_APB3LPENCLRR register fields */
+#define RCC_MP_APB3LPENCLRR_LPTIM2LPEN	BIT(0)
+#define RCC_MP_APB3LPENCLRR_LPTIM3LPEN	BIT(1)
+#define RCC_MP_APB3LPENCLRR_LPTIM4LPEN	BIT(2)
+#define RCC_MP_APB3LPENCLRR_LPTIM5LPEN	BIT(3)
+#define RCC_MP_APB3LPENCLRR_VREFLPEN	BIT(13)
+#define RCC_MP_APB3LPENCLRR_DTSLPEN	BIT(16)
+#define RCC_MP_APB3LPENCLRR_PMBCTRLLPEN	BIT(17)
+
+/* RCC_MP_S_APB3LPENSETR register fields */
+#define RCC_MP_S_APB3LPENSETR_SYSCFGLPEN	BIT(0)
+
+/* RCC_MP_S_APB3LPENCLRR register fields */
+#define RCC_MP_S_APB3LPENCLRR_SYSCFGLPEN	BIT(0)
+
+/* RCC_MP_NS_APB3LPENSETR register fields */
+#define RCC_MP_NS_APB3LPENSETR_SYSCFGLPEN	BIT(0)
+
+/* RCC_MP_NS_APB3LPENCLRR register fields */
+#define RCC_MP_NS_APB3LPENCLRR_SYSCFGLPEN	BIT(0)
+
+/* RCC_MP_APB4LPENSETR register fields */
+#define RCC_MP_APB4LPENSETR_DCMIPPLPEN		BIT(1)
+#define RCC_MP_APB4LPENSETR_DDRPERFMLPEN	BIT(8)
+#define RCC_MP_APB4LPENSETR_IWDG2APBLPEN	BIT(15)
+#define RCC_MP_APB4LPENSETR_USBPHYLPEN		BIT(16)
+#define RCC_MP_APB4LPENSETR_STGENROLPEN		BIT(20)
+#define RCC_MP_APB4LPENSETR_STGENROSTPEN	BIT(21)
+
+/* RCC_MP_APB4LPENCLRR register fields */
+#define RCC_MP_APB4LPENCLRR_DCMIPPLPEN		BIT(1)
+#define RCC_MP_APB4LPENCLRR_DDRPERFMLPEN	BIT(8)
+#define RCC_MP_APB4LPENCLRR_IWDG2APBLPEN	BIT(15)
+#define RCC_MP_APB4LPENCLRR_USBPHYLPEN		BIT(16)
+#define RCC_MP_APB4LPENCLRR_STGENROLPEN		BIT(20)
+#define RCC_MP_APB4LPENCLRR_STGENROSTPEN	BIT(21)
+
+/* RCC_MP_S_APB4LPENSETR register fields */
+#define RCC_MP_S_APB4LPENSETR_LTDCLPEN	BIT(0)
+
+/* RCC_MP_S_APB4LPENCLRR register fields */
+#define RCC_MP_S_APB4LPENCLRR_LTDCLPEN	BIT(0)
+
+/* RCC_MP_NS_APB4LPENSETR register fields */
+#define RCC_MP_NS_APB4LPENSETR_LTDCLPEN	BIT(0)
+
+/* RCC_MP_NS_APB4LPENCLRR register fields */
+#define RCC_MP_NS_APB4LPENCLRR_LTDCLPEN	BIT(0)
+
+/* RCC_MP_APB5LPENSETR register fields */
+#define RCC_MP_APB5LPENSETR_RTCAPBLPEN		BIT(8)
+#define RCC_MP_APB5LPENSETR_TZCLPEN		BIT(11)
+#define RCC_MP_APB5LPENSETR_ETZPCLPEN		BIT(13)
+#define RCC_MP_APB5LPENSETR_IWDG1APBLPEN	BIT(15)
+#define RCC_MP_APB5LPENSETR_BSECLPEN		BIT(16)
+#define RCC_MP_APB5LPENSETR_STGENCLPEN		BIT(20)
+#define RCC_MP_APB5LPENSETR_STGENCSTPEN		BIT(21)
+
+/* RCC_MP_APB5LPENCLRR register fields */
+#define RCC_MP_APB5LPENCLRR_RTCAPBLPEN		BIT(8)
+#define RCC_MP_APB5LPENCLRR_TZCLPEN		BIT(11)
+#define RCC_MP_APB5LPENCLRR_ETZPCLPEN		BIT(13)
+#define RCC_MP_APB5LPENCLRR_IWDG1APBLPEN	BIT(15)
+#define RCC_MP_APB5LPENCLRR_BSECLPEN		BIT(16)
+#define RCC_MP_APB5LPENCLRR_STGENCLPEN		BIT(20)
+#define RCC_MP_APB5LPENCLRR_STGENCSTPEN		BIT(21)
+
+/* RCC_MP_APB6LPENSETR register fields */
+#define RCC_MP_APB6LPENSETR_USART1LPEN	BIT(0)
+#define RCC_MP_APB6LPENSETR_USART2LPEN	BIT(1)
+#define RCC_MP_APB6LPENSETR_SPI4LPEN	BIT(2)
+#define RCC_MP_APB6LPENSETR_SPI5LPEN	BIT(3)
+#define RCC_MP_APB6LPENSETR_I2C3LPEN	BIT(4)
+#define RCC_MP_APB6LPENSETR_I2C4LPEN	BIT(5)
+#define RCC_MP_APB6LPENSETR_I2C5LPEN	BIT(6)
+#define RCC_MP_APB6LPENSETR_TIM12LPEN	BIT(7)
+#define RCC_MP_APB6LPENSETR_TIM13LPEN	BIT(8)
+#define RCC_MP_APB6LPENSETR_TIM14LPEN	BIT(9)
+#define RCC_MP_APB6LPENSETR_TIM15LPEN	BIT(10)
+#define RCC_MP_APB6LPENSETR_TIM16LPEN	BIT(11)
+#define RCC_MP_APB6LPENSETR_TIM17LPEN	BIT(12)
+
+/* RCC_MP_APB6LPENCLRR register fields */
+#define RCC_MP_APB6LPENCLRR_USART1LPEN	BIT(0)
+#define RCC_MP_APB6LPENCLRR_USART2LPEN	BIT(1)
+#define RCC_MP_APB6LPENCLRR_SPI4LPEN	BIT(2)
+#define RCC_MP_APB6LPENCLRR_SPI5LPEN	BIT(3)
+#define RCC_MP_APB6LPENCLRR_I2C3LPEN	BIT(4)
+#define RCC_MP_APB6LPENCLRR_I2C4LPEN	BIT(5)
+#define RCC_MP_APB6LPENCLRR_I2C5LPEN	BIT(6)
+#define RCC_MP_APB6LPENCLRR_TIM12LPEN	BIT(7)
+#define RCC_MP_APB6LPENCLRR_TIM13LPEN	BIT(8)
+#define RCC_MP_APB6LPENCLRR_TIM14LPEN	BIT(9)
+#define RCC_MP_APB6LPENCLRR_TIM15LPEN	BIT(10)
+#define RCC_MP_APB6LPENCLRR_TIM16LPEN	BIT(11)
+#define RCC_MP_APB6LPENCLRR_TIM17LPEN	BIT(12)
+
+/* RCC_MP_AHB2LPENSETR register fields */
+#define RCC_MP_AHB2LPENSETR_DMA1LPEN	BIT(0)
+#define RCC_MP_AHB2LPENSETR_DMA2LPEN	BIT(1)
+#define RCC_MP_AHB2LPENSETR_DMAMUX1LPEN	BIT(2)
+#define RCC_MP_AHB2LPENSETR_DMA3LPEN	BIT(3)
+#define RCC_MP_AHB2LPENSETR_DMAMUX2LPEN	BIT(4)
+#define RCC_MP_AHB2LPENSETR_ADC1LPEN	BIT(5)
+#define RCC_MP_AHB2LPENSETR_ADC2LPEN	BIT(6)
+#define RCC_MP_AHB2LPENSETR_USBOLPEN	BIT(8)
+
+/* RCC_MP_AHB2LPENCLRR register fields */
+#define RCC_MP_AHB2LPENCLRR_DMA1LPEN	BIT(0)
+#define RCC_MP_AHB2LPENCLRR_DMA2LPEN	BIT(1)
+#define RCC_MP_AHB2LPENCLRR_DMAMUX1LPEN	BIT(2)
+#define RCC_MP_AHB2LPENCLRR_DMA3LPEN	BIT(3)
+#define RCC_MP_AHB2LPENCLRR_DMAMUX2LPEN	BIT(4)
+#define RCC_MP_AHB2LPENCLRR_ADC1LPEN	BIT(5)
+#define RCC_MP_AHB2LPENCLRR_ADC2LPEN	BIT(6)
+#define RCC_MP_AHB2LPENCLRR_USBOLPEN	BIT(8)
+
+/* RCC_MP_AHB4LPENSETR register fields */
+#define RCC_MP_AHB4LPENSETR_TSCLPEN	BIT(15)
+
+/* RCC_MP_AHB4LPENCLRR register fields */
+#define RCC_MP_AHB4LPENCLRR_TSCLPEN	BIT(15)
+
+/* RCC_MP_S_AHB4LPENSETR register fields */
+#define RCC_MP_S_AHB4LPENSETR_GPIOALPEN	BIT(0)
+#define RCC_MP_S_AHB4LPENSETR_GPIOBLPEN	BIT(1)
+#define RCC_MP_S_AHB4LPENSETR_GPIOCLPEN	BIT(2)
+#define RCC_MP_S_AHB4LPENSETR_GPIODLPEN	BIT(3)
+#define RCC_MP_S_AHB4LPENSETR_GPIOELPEN	BIT(4)
+#define RCC_MP_S_AHB4LPENSETR_GPIOFLPEN	BIT(5)
+#define RCC_MP_S_AHB4LPENSETR_GPIOGLPEN	BIT(6)
+#define RCC_MP_S_AHB4LPENSETR_GPIOHLPEN	BIT(7)
+#define RCC_MP_S_AHB4LPENSETR_GPIOILPEN	BIT(8)
+
+/* RCC_MP_S_AHB4LPENCLRR register fields */
+#define RCC_MP_S_AHB4LPENCLRR_GPIOALPEN	BIT(0)
+#define RCC_MP_S_AHB4LPENCLRR_GPIOBLPEN	BIT(1)
+#define RCC_MP_S_AHB4LPENCLRR_GPIOCLPEN	BIT(2)
+#define RCC_MP_S_AHB4LPENCLRR_GPIODLPEN	BIT(3)
+#define RCC_MP_S_AHB4LPENCLRR_GPIOELPEN	BIT(4)
+#define RCC_MP_S_AHB4LPENCLRR_GPIOFLPEN	BIT(5)
+#define RCC_MP_S_AHB4LPENCLRR_GPIOGLPEN	BIT(6)
+#define RCC_MP_S_AHB4LPENCLRR_GPIOHLPEN	BIT(7)
+#define RCC_MP_S_AHB4LPENCLRR_GPIOILPEN	BIT(8)
+
+/* RCC_MP_NS_AHB4LPENSETR register fields */
+#define RCC_MP_NS_AHB4LPENSETR_GPIOALPEN BIT(0)
+#define RCC_MP_NS_AHB4LPENSETR_GPIOBLPEN BIT(1)
+#define RCC_MP_NS_AHB4LPENSETR_GPIOCLPEN BIT(2)
+#define RCC_MP_NS_AHB4LPENSETR_GPIODLPEN BIT(3)
+#define RCC_MP_NS_AHB4LPENSETR_GPIOELPEN BIT(4)
+#define RCC_MP_NS_AHB4LPENSETR_GPIOFLPEN BIT(5)
+#define RCC_MP_NS_AHB4LPENSETR_GPIOGLPEN BIT(6)
+#define RCC_MP_NS_AHB4LPENSETR_GPIOHLPEN BIT(7)
+#define RCC_MP_NS_AHB4LPENSETR_GPIOILPEN BIT(8)
+
+/* RCC_MP_NS_AHB4LPENCLRR register fields */
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOALPEN BIT(0)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOBLPEN BIT(1)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOCLPEN BIT(2)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIODLPEN BIT(3)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOELPEN BIT(4)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOFLPEN BIT(5)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOGLPEN BIT(6)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOHLPEN BIT(7)
+#define RCC_MP_NS_AHB4LPENCLRR_GPIOILPEN BIT(8)
+
+/* RCC_MP_AHB5LPENSETR register fields */
+#define RCC_MP_AHB5LPENSETR_PKALPEN	BIT(2)
+#define RCC_MP_AHB5LPENSETR_SAESLPEN	BIT(3)
+#define RCC_MP_AHB5LPENSETR_CRYP1LPEN	BIT(4)
+#define RCC_MP_AHB5LPENSETR_HASH1LPEN	BIT(5)
+#define RCC_MP_AHB5LPENSETR_RNG1LPEN	BIT(6)
+#define RCC_MP_AHB5LPENSETR_BKPSRAMLPEN	BIT(8)
+
+/* RCC_MP_AHB5LPENCLRR register fields */
+#define RCC_MP_AHB5LPENCLRR_PKALPEN	BIT(2)
+#define RCC_MP_AHB5LPENCLRR_SAESLPEN	BIT(3)
+#define RCC_MP_AHB5LPENCLRR_CRYP1LPEN	BIT(4)
+#define RCC_MP_AHB5LPENCLRR_HASH1LPEN	BIT(5)
+#define RCC_MP_AHB5LPENCLRR_RNG1LPEN	BIT(6)
+#define RCC_MP_AHB5LPENCLRR_BKPSRAMLPEN	BIT(8)
+
+/* RCC_MP_AHB6LPENSETR register fields */
+#define RCC_MP_AHB6LPENSETR_MCELPEN	BIT(1)
+#define RCC_MP_AHB6LPENSETR_ETH1CKLPEN	BIT(7)
+#define RCC_MP_AHB6LPENSETR_ETH1TXLPEN	BIT(8)
+#define RCC_MP_AHB6LPENSETR_ETH1RXLPEN	BIT(9)
+#define RCC_MP_AHB6LPENSETR_ETH1MACLPEN	BIT(10)
+#define RCC_MP_AHB6LPENSETR_ETH1STPEN	BIT(11)
+#define RCC_MP_AHB6LPENSETR_FMCLPEN	BIT(12)
+#define RCC_MP_AHB6LPENSETR_QSPILPEN	BIT(14)
+#define RCC_MP_AHB6LPENSETR_SDMMC1LPEN	BIT(16)
+#define RCC_MP_AHB6LPENSETR_SDMMC2LPEN	BIT(17)
+#define RCC_MP_AHB6LPENSETR_CRC1LPEN	BIT(20)
+#define RCC_MP_AHB6LPENSETR_USBHLPEN	BIT(24)
+#define RCC_MP_AHB6LPENSETR_ETH2CKLPEN	BIT(27)
+#define RCC_MP_AHB6LPENSETR_ETH2TXLPEN	BIT(28)
+#define RCC_MP_AHB6LPENSETR_ETH2RXLPEN	BIT(29)
+#define RCC_MP_AHB6LPENSETR_ETH2MACLPEN	BIT(30)
+#define RCC_MP_AHB6LPENSETR_ETH2STPEN	BIT(31)
+
+/* RCC_MP_AHB6LPENCLRR register fields */
+#define RCC_MP_AHB6LPENCLRR_MCELPEN	BIT(1)
+#define RCC_MP_AHB6LPENCLRR_ETH1CKLPEN	BIT(7)
+#define RCC_MP_AHB6LPENCLRR_ETH1TXLPEN	BIT(8)
+#define RCC_MP_AHB6LPENCLRR_ETH1RXLPEN	BIT(9)
+#define RCC_MP_AHB6LPENCLRR_ETH1MACLPEN	BIT(10)
+#define RCC_MP_AHB6LPENCLRR_ETH1STPEN	BIT(11)
+#define RCC_MP_AHB6LPENCLRR_FMCLPEN	BIT(12)
+#define RCC_MP_AHB6LPENCLRR_QSPILPEN	BIT(14)
+#define RCC_MP_AHB6LPENCLRR_SDMMC1LPEN	BIT(16)
+#define RCC_MP_AHB6LPENCLRR_SDMMC2LPEN	BIT(17)
+#define RCC_MP_AHB6LPENCLRR_CRC1LPEN	BIT(20)
+#define RCC_MP_AHB6LPENCLRR_USBHLPEN	BIT(24)
+#define RCC_MP_AHB6LPENCLRR_ETH2CKLPEN	BIT(27)
+#define RCC_MP_AHB6LPENCLRR_ETH2TXLPEN	BIT(28)
+#define RCC_MP_AHB6LPENCLRR_ETH2RXLPEN	BIT(29)
+#define RCC_MP_AHB6LPENCLRR_ETH2MACLPEN	BIT(30)
+#define RCC_MP_AHB6LPENCLRR_ETH2STPEN	BIT(31)
+
+/* RCC_MP_S_AHB6LPENSETR register fields */
+#define RCC_MP_S_AHB6LPENSETR_MDMALPEN	BIT(0)
+
+/* RCC_MP_S_AHB6LPENCLRR register fields */
+#define RCC_MP_S_AHB6LPENCLRR_MDMALPEN	BIT(0)
+
+/* RCC_MP_NS_AHB6LPENSETR register fields */
+#define RCC_MP_NS_AHB6LPENSETR_MDMALPEN	BIT(0)
+
+/* RCC_MP_NS_AHB6LPENCLRR register fields */
+#define RCC_MP_NS_AHB6LPENCLRR_MDMALPEN	BIT(0)
+
+/* RCC_MP_S_AXIMLPENSETR register fields */
+#define RCC_MP_S_AXIMLPENSETR_SYSRAMLPEN BIT(0)
+
+/* RCC_MP_S_AXIMLPENCLRR register fields */
+#define RCC_MP_S_AXIMLPENCLRR_SYSRAMLPEN BIT(0)
+
+/* RCC_MP_NS_AXIMLPENSETR register fields */
+#define RCC_MP_NS_AXIMLPENSETR_SYSRAMLPEN BIT(0)
+
+/* RCC_MP_NS_AXIMLPENCLRR register fields */
+#define RCC_MP_NS_AXIMLPENCLRR_SYSRAMLPEN BIT(0)
+
+/* RCC_MP_MLAHBLPENSETR register fields */
+#define RCC_MP_MLAHBLPENSETR_SRAM1LPEN	BIT(0)
+#define RCC_MP_MLAHBLPENSETR_SRAM2LPEN	BIT(1)
+#define RCC_MP_MLAHBLPENSETR_SRAM3LPEN	BIT(2)
+
+/* RCC_MP_MLAHBLPENCLRR register fields */
+#define RCC_MP_MLAHBLPENCLRR_SRAM1LPEN	BIT(0)
+#define RCC_MP_MLAHBLPENCLRR_SRAM2LPEN	BIT(1)
+#define RCC_MP_MLAHBLPENCLRR_SRAM3LPEN	BIT(2)
+
+/* RCC_APB3SECSR register fields */
+#define RCC_APB3SECSR_LPTIM2SECF	0
+#define RCC_APB3SECSR_LPTIM3SECF	1
+#define RCC_APB3SECSR_VREFSECF		13
+
+/* RCC_APB4SECSR register fields */
+#define RCC_APB4SECSR_DCMIPPSECF	1
+#define RCC_APB4SECSR_USBPHYSECF	16
+
+/* RCC_APB5SECSR register fields */
+#define RCC_APB5SECSR_RTCSECF		8
+#define RCC_APB5SECSR_TZCSECF		11
+#define RCC_APB5SECSR_ETZPCSECF		13
+#define RCC_APB5SECSR_IWDG1SECF		15
+#define RCC_APB5SECSR_BSECSECF		16
+#define RCC_APB5SECSR_STGENCSECF_MASK	GENMASK(21, 20)
+#define RCC_APB5SECSR_STGENCSECF	20
+#define RCC_APB5SECSR_STGENROSECF	21
+
+/* RCC_APB6SECSR register fields */
+#define RCC_APB6SECSR_USART1SECF        0
+#define RCC_APB6SECSR_USART2SECF	1
+#define RCC_APB6SECSR_SPI4SECF		2
+#define RCC_APB6SECSR_SPI5SECF		3
+#define RCC_APB6SECSR_I2C3SECF		4
+#define RCC_APB6SECSR_I2C4SECF		5
+#define RCC_APB6SECSR_I2C5SECF		6
+#define RCC_APB6SECSR_TIM12SECF		7
+#define RCC_APB6SECSR_TIM13SECF		8
+#define RCC_APB6SECSR_TIM14SECF		9
+#define RCC_APB6SECSR_TIM15SECF		10
+#define RCC_APB6SECSR_TIM16SECF		11
+#define RCC_APB6SECSR_TIM17SECF		12
+
+/* RCC_AHB2SECSR register fields */
+#define RCC_AHB2SECSR_DMA3SECF		3
+#define RCC_AHB2SECSR_DMAMUX2SECF	4
+#define RCC_AHB2SECSR_ADC1SECF		5
+#define RCC_AHB2SECSR_ADC2SECF		6
+#define RCC_AHB2SECSR_USBOSECF		8
+
+/* RCC_AHB4SECSR register fields */
+#define RCC_AHB4SECSR_TSCSECF		15
+
+/* RCC_AHB5SECSR register fields */
+#define RCC_AHB5SECSR_PKASECF		2
+#define RCC_AHB5SECSR_SAESSECF		3
+#define RCC_AHB5SECSR_CRYP1SECF		4
+#define RCC_AHB5SECSR_HASH1SECF		5
+#define RCC_AHB5SECSR_RNG1SECF		6
+#define RCC_AHB5SECSR_BKPSRAMSECF	8
+
+/* RCC_AHB6SECSR register fields */
+#define RCC_AHB6SECSR_MCESECF		1
+#define RCC_AHB6SECSR_FMCSECF		12
+#define RCC_AHB6SECSR_QSPISECF		14
+#define RCC_AHB6SECSR_SDMMC1SECF	16
+#define RCC_AHB6SECSR_SDMMC2SECF	17
+
+#define RCC_AHB6SECSR_ETH1SECF_MASK	GENMASK(11, 7)
+#define RCC_AHB6SECSR_ETH2SECF_MASK	GENMASK(31, 27)
+#define RCC_AHB6SECSR_ETH1SECF_SHIFT	7
+#define RCC_AHB6SECSR_ETH2SECF_SHIFT	27
+
+#define RCC_AHB6SECSR_ETH1CKSECF	7
+#define RCC_AHB6SECSR_ETH1TXSECF	8
+#define RCC_AHB6SECSR_ETH1RXSECF	9
+#define RCC_AHB6SECSR_ETH1MACSECF	10
+#define RCC_AHB6SECSR_ETH1STPSECF	11
+
+#define RCC_AHB6SECSR_ETH2CKSECF	27
+#define RCC_AHB6SECSR_ETH2TXSECF	28
+#define RCC_AHB6SECSR_ETH2RXSECF	29
+#define RCC_AHB6SECSR_ETH2MACSECF	30
+#define RCC_AHB6SECSR_ETH2STPSECF	31
+
+/* RCC_VERR register fields */
+#define RCC_VERR_MINREV_MASK		GENMASK(3, 0)
+#define RCC_VERR_MAJREV_MASK		GENMASK(7, 4)
+#define RCC_VERR_MINREV_SHIFT		0
+#define RCC_VERR_MAJREV_SHIFT		4
+
+/* RCC_IDR register fields */
+#define RCC_IDR_ID_MASK			GENMASK(31, 0)
+#define RCC_IDR_ID_SHIFT		0
+
+/* RCC_SIDR register fields */
+#define RCC_SIDR_SID_MASK		GENMASK(31, 0)
+#define RCC_SIDR_SID_SHIFT		0
+
+#endif /* STM32MP13_RCC_H */
+
-- 
2.25.1

