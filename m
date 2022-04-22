Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F250BBE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449487AbiDVPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449497AbiDVPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:44:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2051.outbound.protection.outlook.com [40.92.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81BB58391;
        Fri, 22 Apr 2022 08:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm7bI60lZoUhvUAidLWojGK+0BmJjD3ZUbaEK5H7jnfl83dahZoHz8bA921soJcteO1Akc78MF6y9N36zhA3AH4OPpvU1/oteL4gm3+X0TwtGLYpG1hFAhT1its00oVm0ZQ4iWYxgKxjWlwU7cfCYG8ZpunTCve42hDMXOp8kY+OwrXC4HEOKbYJjo4sLxjV8yAVdA0BOuPVinqUrWVmBDxs/LKxb9+mngSxPRPRX1WoGhUpI8/tBGM8Kk2+k6ZEoY4sIgCOjEvjf006XGjOMS98XG7LvawQtlEen90GIV3Kx1unj37RYV/b7CBDclFOglAPeY6ovpPovPiKj9+KyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHaoIR1QUh3BBmMvoFnaBr9dnfpOqU84ruv4bFwP+Bk=;
 b=JomQKBefZuTKQWZ6HoDZRj4rizPzwRSMG1lxbhysyBJeaK4uPl5HutUzNzSuHxvZbGuR+Cbe2EG1Hs181aaAIrjpcuJo/8S2HaA9rg8YBAmCUqD8xXmnB99EDF7A7ndQ69MlnutToZVdYk2M6UuXieGfUzY9+r4yibpP7r48lkGPSdOib/Puo+UdQ0vdgA+Pq5Ih6iuZC4Pl1jcTmTGBynQ816VPfOYXZg3LpgtrbEltffr0J68HDBOh6C6s2GeUo2N/hkpOkDvoWCH136OwyrO7uc+Iq3oAhOS4R3u1yN0PdcS90W++r9TfWUcneywQJ+e5sF2e9HT9hJXnKI1MHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHaoIR1QUh3BBmMvoFnaBr9dnfpOqU84ruv4bFwP+Bk=;
 b=N3WVaGDQaTXL7Pugy/HAfwP50G3HCUc03TyetmiOhLHKpcwbNfAyOVmuQQ+ASVjX8U2Sw7WqjmQXb0tvXzU4B2yvAcy3W3ulpISD75eMz/34Zj394n2hWNXoxKXJ/SEqHZrb4hUTe+WlrQRkmZBMZ7UYzZ02QjqJklI4HUq+iXdrJhf0xY/2DKUTTA+s+l5NPqZYYnjnfbiywdOSXq04Wqd4gnKpGu6X1GNRSsMYAO2RWzfTyWF/lkG36NtQsXbWs/foccAOOFNT5ieReIVr5rxTUY+4IH2B9Al1N+BNxZ1ZGN8sqwVL6+jOoh/her7pORw5z3GvUNW10mIjqy2lXA==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by SJ0PR20MB3642.namprd20.prod.outlook.com (2603:10b6:a03:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:41:31 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:41:30 +0000
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
Subject: [PATCH 03/12] pinctrl: sunxi: add support for R329 R-PIO pin controller
Date:   Fri, 22 Apr 2022 23:41:06 +0800
Message-ID: <BYAPR20MB247251E54E05FE4EB315B4C7BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Kw/wIjyQdoN/Uz8gmiAzP3r0tf2Qemi/]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-1-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d85fa127-d824-4272-af11-08da24769247
X-MS-TrafficTypeDiagnostic: SJ0PR20MB3642:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtNomxRJp6kMqwAZ+Qx64xBA7DX0WkzbtiPoEk2al8WKHyXTqfoIZYoyM8Qw0HR3GD01aSpbkB5ctJzv8xa4/CpIV8CRhmi65F88P3Nt1yhJX445OQJfhdrI5+Sw4jWB/8xNuAOq2ikQfyBPfeafOLYAScq/ZWbfbOjfaBZu20OWYU7w+hY/fEQV7N9BFuE/wmqA1jEnP0S1/8CkpnCgCm0KCoV5Gx18+cN6Mmfey4CsdiEJN3MtMCvjQHg3ZhnpTnKVGA51d+yRJiZTMrh/nvo4BbPcRvMcVS4AW2+XCNE9+Db5xibB36+gPhP5CAlHvXsIcFyZQU2rk2u7ZkBR3h17A6Y63gzk7NHYdnNClD33yWgEFFrXK+EPJqBXHZ7ncGHW+KBywrcRx9VqV7hNRXfWVM/EhfRMLXZ0mTpEG6OPshbDgrlkiroCrIX+lKs5+g55ODCUWhDT022AIDiKxSm/XfUJGR1l6qDRrAwC6a0h4gbxNQoaadMGLNLjwxreQt8o9daN8u9JDoSHrxZLhFJsRtQMPVO+OHSqLnWz8CcPV7Vk2En/AunER3xR3rAliE0frQqs0cDwMYjwq1+K/w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0JP+Z7bp0EZHj/bi5iuxMKqltB9IJPrP/oTqnVxNNjqZNFrUbij1g33Amg2?=
 =?us-ascii?Q?fdrF1ZYN7ci/DWzS4Mspi8J9I1kOnLIktLWD8VG2Dw4Km3MWYT2L/8UGsLDU?=
 =?us-ascii?Q?vFfIh95+w9LVG/RvzCy5EiF464W5ZBkrgF0LcxWw3EFVGJJNIwsO4XozsHuP?=
 =?us-ascii?Q?15iO3DKiqEYq6bIEJzNPyHxlOSJsYC+EdZv87JciULwoA4pg6sidxy2g3H+w?=
 =?us-ascii?Q?xhBRYfIUkmEcWjtyMIkP25nFwSKibZqS5K/jo77/STh2RezFa1n+O6+VeCCy?=
 =?us-ascii?Q?DotBl+yJFnxFGDYPopVnCEWNGtMpJOHPtpLgKQmlxempMqyanVSx5aj8c/T3?=
 =?us-ascii?Q?sdxd0DZEQFAGBI6Phne0B9SHHkSDqesz8HLEZ9+CZvYGFu0yMIw1+FkX7xF3?=
 =?us-ascii?Q?gcffB6gTWoHJ1WEaHYP6EEjpyg7INwkVbb7CD5NVssKYLy0z5ZoUpppnoX4j?=
 =?us-ascii?Q?F2VHhoBMlCoQmRCbfvMrnOGZR5XBvWAgnTji2/ACPmFu/kSyylcX0z9aNxPG?=
 =?us-ascii?Q?KlzAkHgTsBmciK+XbCqym9REroab8nPKxLVbIbN08e2mmw8yd9ur0zoe2aXV?=
 =?us-ascii?Q?2jHCjZOk0H3NSQUvNQ5sV6Z3ADFzfxMTAyzLAwK9JBU5thcN3HOi0rtroKv2?=
 =?us-ascii?Q?8BECPMA3/94oA4WxuEYbeyjX8jcI2GOBMOaKwqNBzo5Gr5xSeDjHrSiFUMsa?=
 =?us-ascii?Q?nxkLlogGCSibgtps28SBsD03t59l62uXRlfT8BcVZFEEuvkOdgGKSShw5Gft?=
 =?us-ascii?Q?or3jo8pSdmOW9QL8plMiu/AUAztJJ3JdjdRDfKMG71Em/y3XInP/VV9y1KcR?=
 =?us-ascii?Q?pA3upoSkQgD0MzjWhhmro7vJAPKxrYq/Fta9w/qvrm5Rp/4Y1QePFmBgEc2z?=
 =?us-ascii?Q?mbM7ILMRlBdLgX26ydj1FXQr5JFiXWzTISo8HWHcnwLdkzkAOuyoHOP1OtMl?=
 =?us-ascii?Q?sJeJHustqulQjRk9FfpKW87nMvI8y3gb1kVAbqN6ShLUq5JzK4+g2LyWIPDH?=
 =?us-ascii?Q?QCG/jrjmJwJ5KdzGP9OsqOWAHMYP+7zbvxn68IjQdF32ItjcBoDR5NvsDENz?=
 =?us-ascii?Q?lA9OF65tiqWhn22CWgV3HYV/UEOt/9qPWk5nOmS5eNvymwaQ13t/4jb6ZzrR?=
 =?us-ascii?Q?TzWHNu0rjOcmXt6cljInWD1f6pI0+BIzc+m/vxOjR05s5oF4ZKUH9SZnkbwU?=
 =?us-ascii?Q?5iFfjviCLWnmYmKViY/Qx/YYueZ479Yy2a/kdzCpxgGknvlEFjah9/V/DQaL?=
 =?us-ascii?Q?6NcI0CO7VwEakp9EQEix4KR28I0Eiu9vgDcqT6cDJ69MvI7tQiajgbmBUhJt?=
 =?us-ascii?Q?0olSb8JoOPwn0B/Y+lvyiqCa96LYL+lT7RgrGgAaS+xGgZ05EZZBuMsSStil?=
 =?us-ascii?Q?nVlogIU3E9xUbLWiryXGxXp0oxec/J7Ct2uzENt68gP46A9LPON4YBUq/wRk?=
 =?us-ascii?Q?XVg38agqb1w=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85fa127-d824-4272-af11-08da24769247
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:41:30.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3642
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

Allwinner R320 SoC has a pin controller in the CPUS power domain.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/Kconfig                 |   5 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c | 292 ++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index c662e8b1b351..abd60ff8daec 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -134,4 +134,9 @@ config PINCTRL_SUN50I_R329
 	default ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN50I_R329_R
+	bool "Support for the Allwinner R329 R-PIO"
+	default ARM64 && ARCH_SUNXI
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index e33f7c5f1ff9..245840a7959e 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -26,5 +26,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
+obj-$(CONFIG_PINCTRL_SUN50I_R329_R)	+= pinctrl-sun50i-r329-r.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
new file mode 100644
index 000000000000..268f03d79755
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner R329 R_PIO pin controller driver
+ *
+ * Copyright (C) 2021 Sipeed
+ * Based on former work, which is:
+ *   Copyright (C) 2020 Arm Ltd.
+ *   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/reset.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin sun50i_r329_r_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s"),		/* LRCK */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA3 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PL_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s"),		/* BCLK */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA2 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PL_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s_dout0"),
+		  SUNXI_FUNCTION(0x3, "s_i2s_din1"),
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA1 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PL_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s_dout1"),
+		  SUNXI_FUNCTION(0x3, "s_i2s_din0"),
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA0 */
+		  SUNXI_FUNCTION(0x5, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PL_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s"),		/* MCLK */
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* CLK */
+		  SUNXI_FUNCTION(0x5, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PL_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PL_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PL_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PL_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PL_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PL_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PL_EINT10 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* MS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PM_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* CK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PM_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DO */
+		  SUNXI_FUNCTION(0x4, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PM_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PM_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PM_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DI */
+		  SUNXI_FUNCTION(0x4, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PM_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nmi"),
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PM_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 7)),	/* PM_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 8)),	/* PM_EINT8 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PN_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* MDC */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PN_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* MDIO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PN_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PN_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PN_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PN_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PN_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PN_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXERR */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PN_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXCTL/TXEN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PN_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PN_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PN_EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXCTL/CRS_DV */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PN_EINT12 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PN_EINT13 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PN_EINT14 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PN_EINT15 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* EPHY-25M */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/* PN_EINT16 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 17),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* CLKIN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/* PN_EINT17 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 18),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/* PN_EINT18 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 19),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/* PN_EINT19 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 20),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 20)),	/* PN_EINT20 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 21),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 21)),	/* PN_EINT21 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 22),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 22)),	/* PN_EINT22 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 23),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 23)),	/* PN_EINT23 */
+};
+
+static const struct sunxi_pinctrl_desc sun50i_r329_r_pinctrl_data = {
+	.pins = sun50i_r329_r_pins,
+	.npins = ARRAY_SIZE(sun50i_r329_r_pins),
+	.pin_base = PL_BASE,
+	.irq_banks = 3,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int sun50i_r329_r_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev,
+				  &sun50i_r329_r_pinctrl_data);
+}
+
+static const struct of_device_id sun50i_r329_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun50i-r329-r-pinctrl", },
+	{}
+};
+
+static struct platform_driver sun50i_r329_r_pinctrl_driver = {
+	.probe	= sun50i_r329_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun50i-r329-r-pinctrl",
+		.of_match_table	= sun50i_r329_r_pinctrl_match,
+	},
+};
-- 
2.35.1

