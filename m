Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553E450BBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449177AbiDVPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449563AbiDVPoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:44:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2101.outbound.protection.outlook.com [40.92.41.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152AD5DA77;
        Fri, 22 Apr 2022 08:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKDThEq+zuhcv7qCTaxt+jjyue7Q1QRGemh2YMBgD4XVujr1ImXAZtc9bAu7j8FX08GdDOneoyOB6C6lftBiipsipIHTEtpW9Eh2AtovGUcx5y64yhRKejZnc044bmIloMWnocuWyre9RtiM9FQf2rLM+EFWuq0hENtcIKAaxHxxHHHqxlhUmRvvcZekd40tZjWXQEfRcvkg6CNy2ijtq9cxh86NGJ46Fj/0MqOgh0gKf/9Oyxnrd0rXoadZ9OPrx4oUmDcY/Vk5xwf9ip1CuRb96/3OtDtMtcd1BHRfEcPgQ2+/1yqSyEYgzgy6qkAJ3fQJL4CcCxolroAvXJstjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmEIvInO8dfP9OgoFcoQ30msujXOUf6wsxMobfkXhN8=;
 b=HMzrEVLaxbtrehLaC61TM3YPbriQCSyjwzfpTaqkNbHfpwd5ZWw2BVoRdMje+cxoBFPCSPBJXgvSF13X4Yl6XptxoDno725PXTWbYyp9G0BDlIvXT1V0W7euKGv5V8QZNKi2ltmOBECT+FEQ9hPU8RfrT+IS8YqfXJAnK7vj9n1RQ1XdgPHqEoqulFpqCRSLqU2r42/UKWueS43OPJv5WYuTeMSP3dTzq4vuSI5KL2NmDxQ59w1DZolU+ngOOIfBQzOjU8q2wCnrBuuy75Qe0DKVGfBNfvimeFN5IYSEvCML1d7B+7OzPkZ1F8ats1RCQACSk8lQPtfD06LYhmHjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmEIvInO8dfP9OgoFcoQ30msujXOUf6wsxMobfkXhN8=;
 b=JRYXgl6T+e/V3HoyARr+VIzXYtu/w66mB9TqX6c1bACuGMSXgL7+PQ/WzSBWHKLs80GH1X/38JhOF8d9yMcantCc7kCJ8L3rljtV+yEBz4CEkAxQ8uZ/3TaCEKFcM9h/jfOG+DRmCfgdYviz0CsVrwDmJC+zgKWCVE8lhZ38sg1iE2j+59nyJ3I8PJ4rG/jMA07DRftL/ro1k0JY7OpXpgDGxEs3/L5ewa+1uzG4X/bnSF81DIyOd0bpUrpTC/NYAGiyJqkIF+r54/UB9X/WXJIyyRpH+KdT7UkWt1rwyY2MeCmNTs0OwRkNe2DFrel/bfX/U1D/LqVMhF7KLaBTww==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by SA0PR20MB3359.namprd20.prod.outlook.com (2603:10b6:806:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:41:04 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:41:04 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 02/12] pinctrl: sunxi: add support for R329 CPUX pin controller
Date:   Fri, 22 Apr 2022 23:40:39 +0800
Message-ID: <BYAPR20MB2472B703E377AA813EE55B26BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [mvx97QenGwBAHwUPkF3Vy6NEID/qhk2l]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154049.1068519-1-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a77ece3-3f0d-4936-5713-08da2476820c
X-MS-TrafficTypeDiagnostic: SA0PR20MB3359:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PKiGCE7ym7V3Vu76i8PNUXuKQdkvuzv2XSRzQfe1q52iwkmG6r6quXHgQ+ZQ1FfkVf1h70GzGppsqKDoWdht/MD/BXyG7iH+qjHxbxAi7RSMzLau3Tt8ze1fCxX2ZfQpwcmWlNJWn5KjZaQAQX5alrnmbmZsoUfHfJkgOX7CAd3SCiSYzk15xXP/SajCGkDHat9ND7FTUeAvmoB+S46FvIIkE+yYpyBm4XHHledwaYmdjAR68fUC4zaCVNdfjgOps8N8wmhuIOY+gr1j5UgczWUPzsYuLVCDvdgskECA2HpsfE5MovK43m9ZyD51ygkekpTTFILt6Mp0AHd+kFzJZJrPRz91xM4808DN9ycFaaFdcSwnWJnghMnaTiJhz8sQueQg1K/iZgwfbh9CKG1VSIVGJNNW4zlsb0YTFSbby7WGV7Jjn7exCin5Vd0DWtk/0igfOSF15wxyeDFWRu8qD9AOfb4grZcRzwb0Hhh0X/kts7U+bechoW5WJYWN+Sk4wWI/joSRzqSHJvRu2uZyndnU+mrsdMeHCuD8rxqmoJioAJGaB928Rkrb4hkpL+gdZYzfK1/H5199NaLU37mpg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cEvlSG4IuO5i1oqUBTKFIBDP17/a4ecuJ18QQle7PE83NGJ2OzcPEVceheT?=
 =?us-ascii?Q?jIpp7prm8Gbt/wH9o0z7E+zkGa79PxQixjfVV42AgCG7eXLSfMD1avxG+MUb?=
 =?us-ascii?Q?PU5fpZRgUxh5d4Mwc8Fmuo1dT1eROu+42uTWk7WLWYSALGqHo4+EmDJNrw9J?=
 =?us-ascii?Q?Mkz1NlqWM8W13MWyEPh2NNw5fIH1ls14kvrTuK96ezBnXcLunRhHdgI+OY4k?=
 =?us-ascii?Q?JvXmMmH3p0xR0TeiXcPMfAR3QxETx3Oc8VgarVOEPX8MUGYJ9zzMeJJ/Uzuz?=
 =?us-ascii?Q?/CMiUURzMFqBAl+vyhTXl+CkLULdHrJU4JdsyYvQNG4N7j6WMpVaFL0bYB2p?=
 =?us-ascii?Q?D7SUpGV7xlFKYR0CkXozWfpJHz2XraAPU+8GizD1OYMLQSjLOHiKGxE13uJ3?=
 =?us-ascii?Q?M4DhpZMTRZ4wg51RHGxMPIpnceudXkzHxqS+2J5REP/MvQORhG8rKq/6Atgz?=
 =?us-ascii?Q?J8p0lUoAgjurkNt3NnS6IgGL/Jkn2bnU9goVyjIupVMDw4WC3zyPxFOQd4Rn?=
 =?us-ascii?Q?oAxP46nkYZdiY9uWg6XmnJXgBp8lOVA8HQYurRKfFG++FloIcMiUBhErcv4B?=
 =?us-ascii?Q?DHqqOvtAQrLP9OlchdNWBlccOJYnTrbcSHDpUDbLvlSNid682JIph0dsHajH?=
 =?us-ascii?Q?OgzorJC7NU0fw5UzrBCgl0v3yXZzOLq6MZxfq3/Sg6bpRDRGWVxEHHDmwDF2?=
 =?us-ascii?Q?bZZ1AQN5lTqcQ9HPnYrl8JPraORyXGHuNuMXB1Izu1gfxVyHxtj04kXiJkwM?=
 =?us-ascii?Q?UtG33srA9TzqVAeXnv8WxgKd0e9ii8/0jaCe9uvwtVMe7nnrXZuzkA9v49fI?=
 =?us-ascii?Q?21nM1r5vIa/0T4AN7gGUHBk1CO2rPL/s4hpLrHeUjo5Fla0Fnq/9wrcGMiuy?=
 =?us-ascii?Q?83UPCLnjntUAQ8hNyWv6QWrNeZZolFbef/JnZQg7sevWUTA6SgLEenAFgPIk?=
 =?us-ascii?Q?fNZEMOu81f24J6HMlL8YPvBjL1QvaY/q6uaGZJ/ISpDdMU2pI9u2CbxZv5RK?=
 =?us-ascii?Q?TiMs2UDnmx9iU+VR1md1DUREC9Jvq9iqspmu1FtFuJP3tBUDzAU5IhDZZcId?=
 =?us-ascii?Q?KMukVPK5HVkIQlVLCb7T5TgKSafJ6Z7Y9NGqBEQQRHr9HIlW5Eufm75I0aDz?=
 =?us-ascii?Q?Q9yYKG2So2cSyUK3UD2Akb9kuYRTw0PVKhmK4FQnZqzl+iyWD1j1KwJhYS8x?=
 =?us-ascii?Q?Wew/Qd/mA6kZa566TwPaVYgUlj6BpF45eaUTeyXVUV3wfmYySnxxJLVeUCS8?=
 =?us-ascii?Q?nWmxiq4IvWXKdNERpDdlT5sDlJ7S/t2VjURbW+FHR54DCtViCzR0u9XPZG9s?=
 =?us-ascii?Q?dyHcH/2FxuqIJZGuv6VNaf0HdB1/rIORPKjnCGyk2R6eK1FOokgRjqY/R2dN?=
 =?us-ascii?Q?yVJiEQPpH9tb/mgQc51vfMXebm+rgBvUeqBmQSmnszZVHmLgvzvgK7Jd6Cpd?=
 =?us-ascii?Q?NCdPHToa31E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a77ece3-3f0d-4936-5713-08da2476820c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:41:04.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3359
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner R329 SoC has two pin controllers similar to ones on previous
SoCs, one in CPUX power domain and another in CPUS.

This patch adds support for the CPUX domain pin controller.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/Kconfig               |   5 +
 drivers/pinctrl/sunxi/Makefile              |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c | 410 ++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 33751a6a0757..c662e8b1b351 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -129,4 +129,9 @@ config PINCTRL_SUN50I_H616_R
 	default ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN50I_R329
+	bool "Support for the Allwinner R329 PIO"
+	default ARM64 && ARCH_SUNXI
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index d3440c42b9d6..e33f7c5f1ff9 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -25,5 +25,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
+obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
new file mode 100644
index 000000000000..742f437ec0b6
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner R329 SoC pinctrl driver.
+ *
+ * Copyright (C) 2021 Sipeed
+ * based on the H616 pinctrl driver
+ *   Copyright (C) 2020 Arm Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin r329_pins[] = {
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PB_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* MCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PB_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* LRCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PB_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* BCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PB_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION(0x4, "i2s0_dout0"),
+		  SUNXI_FUNCTION(0x5, "i2s0_din1"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PB_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart0"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION(0x4, "i2s0_dout1"),
+		  SUNXI_FUNCTION(0x5, "i2s0_din0"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PB_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM6 */
+		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT2 */
+		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PB_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM7 */
+		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT3 */
+		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PB_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir_tx"),
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM8 */
+		  SUNXI_FUNCTION(0x4, "ir_rx"),
+		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PB_EINT8 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* RB0 */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* RE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MISO */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* CE0 */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* WP */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* CLE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* ALE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* WE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* HOLD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ0 */
+		  SUNXI_FUNCTION(0x3, "mmc0")),		/* RST */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ1 */
+		  SUNXI_FUNCTION(0x5, "boot_sel")),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ7 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPEN */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PF_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ6 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPPP */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PF_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ5 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* PWREN */
+		  SUNXI_FUNCTION(0x4, "uart"),		/* TX */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PF_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ4 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PF_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQS */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* DATA */
+		  SUNXI_FUNCTION(0x4, "uart"),		/* RX */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PF_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ2 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* RST */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PF_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ1 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* DET */
+		  SUNXI_FUNCTION(0x4, "spdif_in"),
+		  SUNXI_FUNCTION(0x5, "spdif_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PF_EINT6 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_clk"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d2"),
+		  /* 0x4 is also mmc1_d2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PG_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_cmd"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d3"),
+		  SUNXI_FUNCTION(0x4, "mmc1_clk"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PG_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d0"),
+		  SUNXI_FUNCTION(0x3, "mmc1_cmd"),
+		  SUNXI_FUNCTION(0x4, "mmc1_d3"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PG_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d1"),
+		  SUNXI_FUNCTION(0x3, "mmc1_clk"),
+		  /* 0x4 is also mmc1_d1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PG_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d2"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d0"),
+		  /* 0x4 is also mmc1_d0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PG_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d3"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d1"),
+		  SUNXI_FUNCTION(0x4, "mmc1_cmd"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PG_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PG_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PG_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PG_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* WP/DBI-TE */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PG_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* MCLK */
+		  SUNXI_FUNCTION(0x3, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PG_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* CS/DBI-CSX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PG_EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PG_EINT12 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "i2s1_dout0"),
+		  SUNXI_FUNCTION(0x4, "i2s1_din1"),
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* MOSI/DBI-SDO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PG_EINT13 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "i2s1_dout1"),
+		  SUNXI_FUNCTION(0x4, "i2s1_din0"),
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PG_EINT14 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS/DBI-CSX */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PH_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PH_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "ledc"),		/* DO */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI/DBI-SDO */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PH_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PH_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "spi1_cs"),	/* CS/DBI-CSX */
+		  SUNXI_FUNCTION(0x4, "spi1_hold"),	/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PH_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "spi1_clk"),	/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION(0x4, "spi1_wp"),	/* WP/DBI-TE */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PH_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* MOSI/SPI-DBO */
+		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PH_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PH_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* WP/DBI-TE */
+		  SUNXI_FUNCTION(0x4, "ledc"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PH_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION(0x4, "spdif"),		/* IN */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PH_EINT9 */
+};
+static const unsigned int r329_irq_bank_map[] = { 1, 5, 6, 7 };
+
+static const struct sunxi_pinctrl_desc r329_pinctrl_data = {
+	.pins = r329_pins,
+	.npins = ARRAY_SIZE(r329_pins),
+	.irq_banks = ARRAY_SIZE(r329_irq_bank_map),
+	.irq_bank_map = r329_irq_bank_map,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int r329_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev, &r329_pinctrl_data);
+}
+
+static const struct of_device_id r329_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun50i-r329-pinctrl", },
+	{}
+};
+
+static struct platform_driver r329_pinctrl_driver = {
+	.probe	= r329_pinctrl_probe,
+	.driver	= {
+		.name		= "sun50i-r329-pinctrl",
+		.of_match_table	= r329_pinctrl_match,
+	},
+};
+builtin_platform_driver(r329_pinctrl_driver);
-- 
2.35.1

