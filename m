Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B459277D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiHOBaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiHOB3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CF012AAC;
        Sun, 14 Aug 2022 18:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD5zGy/B5fCAu819Qy57lmybRGtdRqh1InEG5olcJTU6GY7WPPwJqPw6NjPkQDlSoRpwQ3L4F7ki1FCPjNqU5c1zfQqIEZIZLnFkqyMdGvBidSjTExoM07Ek9BqWOtjPXtCUPd08684tASnag75XgnfW/lZO4GBmovcFlEJNtaJ6gqb6VDBBJz0d5zNzOw4heWl5xvkGUq0jHWMXAx4bGk9ZRc7ovJDnhYcdQRzdAQBehvlNridZQ+YhuDWWngXS7TLHPEsR4HJi7OmjQslntW4aS6mTYnbJBuc8DDLT7ZPW0UtXBNq2u/zteXqYPQKm4pQ+52Zkoef/cJGfy19vGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCQCaAr8HHthjGkAWhpi/N8DbRuObr7hZbfRNu6zGCA=;
 b=Hk0XQWCqrkFKtRE4R6+chRL0z7VQjSOZ/Cwj0yOnjqC8PA5lNwvFvx6Na+NqDF7b9RKfvxYDyL0OxVmId8IBq4mXU7YiAmguR6OQDvP2LvbGf8eRv/7AQKP+N15lMrUhGdy+JFfpJZruSLp+sfVJt/bRxjGcv8eDmdPbdN4vvAD+ahisO85e+h9SghxHmIlNwg1qOMo+N+FBrcI+E3CO6zAd2SlByVGL3yXTsIrAB0fI1wji9tw+RurA6xEoQuFdq3qsSGNY48xL0DTegn/2NBajd85Dw2xc9ewoKwioxkIxvNdWaJ4vrbJkqAhKg7BR/RD8UnJ+iCidRgg75auzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCQCaAr8HHthjGkAWhpi/N8DbRuObr7hZbfRNu6zGCA=;
 b=dp9gmb8jUJy6SBQydxzzn1aDhBr/d7m4ZIyJ4yxhvqVHvdvErU1aDLZ1bhyz4AZpBJJgmsrOvR5ougoum5bD59C+hwabcruMYyLFGfIv/ngF++RQGOez8uzL8hYVRmiyE2xsEgttltTtgO+76Mpsl0fAK+pTuFJN2izkI5C6/iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:29:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 5/8] clk: imx: add i.MX93 clk gate
Date:   Mon, 15 Aug 2022 09:30:36 +0800
Message-Id: <20220815013039.474970-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6be0db7-254f-4a2c-9914-08da7e5d9a92
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxgexLdBq6uv6ytmK3Fo8GANV5Zs3cFHHTosvnfxVLlt9O1GH5oCKEdVJeA600evSGGazkuXLZxAL1BtoS5yCXhRgb2jXjXysyyZPabecv8KJsbP+tmiYry7wjfzzWD+9O7O4BYAtMYNA1jpVcrURpN6W9ArY0LOrV35dO7zuU/MKIU8axZKvy+js5CUxRmpxX+dPbYmbpKixtbzBs5AXbzIPsgTNatxHjFZbp4P+iMHCrE3GkczbIPcwWkvlIL39Fajf7n0odf8lkqbMUyO+/zkq/jKe6w2eKA1pE7HBEf4/XDo7yEB4qK44fZITSKieBuoEFZNbjU8O3AYMKMzGLByrVk+ClyQC68fvRMWY9A0HiVwO+hR9GZ4dAJlu2raQhq0nlQsqsnZSXQialz+YDbKEmolUHqy0H/fLdEal63Gsm6TyMlNxjPyw4l2020EJ3zy59A3YlWy4Kf5gtgJ78e6xEVbld73066YJXX8G6YAJw30WrFergOGxXdCHN4WcsDaBpnCmUNszQflUfKdF/UD46S9qiOQM4Vlk7Cc0McpTwPsL+m1TrXC/GmpMvnCijyG6YR/DjwhAF+MEthE6AEnzxK7aGIHBZlrSuFFojnCEy9+d6OIf5ds6CaRuehKNNKlcEugoyxsL/I7djJ4wXfY8X7xw9yF4ji9H6JmXirCcOerg2LiRU7T4YKGd4cRCO+S5RBgv4fUuqYthUp4YBeByX1gVjc0M9A+gyrBx0JRvaf/qPLIaafNNDF9IUvOn4FD3V5E0kZhHSlmhUqfVK7TWMtAvA9lfSl8Vs5IiSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(38350700002)(86362001)(52116002)(186003)(2616005)(26005)(83380400001)(6506007)(6512007)(1076003)(6486002)(54906003)(41300700001)(478600001)(316002)(8936002)(5660300002)(7416002)(8676002)(66946007)(38100700002)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2TcHjyB4KM5hQtr3SuohJ7snl/s0QsE4qVR4mlMT6gJIej+4WCcIA/oL+GU?=
 =?us-ascii?Q?mjMdQXPjmdci7YbuLW8UtUUjDQoGl3EM8uJqV3Bc/aYnx9TtJMogxxrhqJpS?=
 =?us-ascii?Q?jji+HNMPcUK+YVymq3kYm7yP9gbho6e9gCDd3tJYvGriwwcZ7XmUc2InI6Py?=
 =?us-ascii?Q?KmOTA9xY8V2QqYZrVK1LHy42Q/pgHd3VyxQgFXPZy0VU6HuUBwYSauO5Q5P8?=
 =?us-ascii?Q?6FDOmJynvdE8sj1JudjTLmaU0RUBLGBpXuGdqZNzjyYiNWk44PE4C3GYy02o?=
 =?us-ascii?Q?5pcEDp1jDbT4UMfqU6IrFLJDLgzhPCcM0pQd8VgW9mhHYLuUCmbgCaAJfoff?=
 =?us-ascii?Q?GKXbIUHS74qdhhz1LgQfiEqZFE+g1xyL/QFBTTrE8LEunf6LVYNsyNpJNA7x?=
 =?us-ascii?Q?cB2iXGlvp/NE7ez6IBOJNKSbbC7c5PBZ10EVTwsimxCKwZYbabOdjxcUJy6i?=
 =?us-ascii?Q?CQgUPVWXLOkewB0F+8Iyjcj9E4I2fjZYw+L0U0fkIQPYRZL5Jd8KXU6sgBu8?=
 =?us-ascii?Q?HHbvBCMluQZaWjn9ysSYDyveWA6/PxvSnwbRCyVA+UDlgepsAfY3UFE9rNMp?=
 =?us-ascii?Q?VNCycyOuFoULD7DpdIRV8RxCINifSN1o1jlfkqakRQ6Isi8tfw4/O69iGyzn?=
 =?us-ascii?Q?xxchsvHLJGJj00T6YsasUMZ4LrkOioWzZiGOEZm/rI6Ij8QM0U4obY/IMLJ4?=
 =?us-ascii?Q?Vw2w+5BiAs3Xhlmi7GMl7GMgqz+71/A7UmjwbH6XxfqXKZMG4MYSFHxGRI34?=
 =?us-ascii?Q?647yCQxgXS88Aevws7jMEBdj+X09izMUgLhjmpeCBZdUhDA7xLpy0Q67EZl2?=
 =?us-ascii?Q?PHJsbXVlQqW+AyHVEC8WzUWENd2W6MDDXkge6+kFIgl5TC2ajL4tRrs1Vo6k?=
 =?us-ascii?Q?9NcIweg0zuePdZmVmIpTZKZVzDQjHFsChDMz/BYZ7FkiAyg7WGYMvvZ/PuKf?=
 =?us-ascii?Q?nfktRDRUPvJBubaLhK99Mox3sRPu4OGTXcyQw8Ho7Qt09/r5JiIU+eImmZqz?=
 =?us-ascii?Q?TxjBASM41OvFhPjPZSBpllT3NciZoOoEGHhlrNPPW2yDNakeydegzGdXDWQ6?=
 =?us-ascii?Q?glJIXPQ7p4akZ+C+urL+jeuRoYIcPDvEeOGqUu8Bdkce4prmg1tqSHG8CaX7?=
 =?us-ascii?Q?OCAxWTHft046sAqmByc9rKY5dlHSn4SUBp2O8NsgLQkA1C0B7/aU6jS1/p4k?=
 =?us-ascii?Q?yOvK12YmoRnLCdJNyvRAFzErO5k54K1Z1ahdi0PpLP09QQUjKgVl7TUaIJop?=
 =?us-ascii?Q?+UJqHksI7Ube8tn4ZZtUstPFin8X5NMpWjrasFkVIkARqzBP79L2xqF29SuN?=
 =?us-ascii?Q?sbSR0HkgJuhIPW+DIaFLarX1UtWPPzvCI5tNTThLPqfFtZmAzmVimPqC9zwY?=
 =?us-ascii?Q?OdMjJxYwuYzNq3a9e2IXhRWLjGyyCqn8u5K6R/85+z4ZZKYSV7uPIbm9Gf9X?=
 =?us-ascii?Q?XfBCJkb9j+KC+3NF1ZFhe1Z59OqE1V18DeJSoJYtJ6rUS/9Uvi3KDLjHSrXN?=
 =?us-ascii?Q?KqLdleQKbJdYUy2RoHsMzfLUVgWEP9MiT4EZ/CV3HTsTDQHKw+osy7NhN814?=
 =?us-ascii?Q?pz6oyjtMr17fjMrZihADp0XglyL1o3v9UQM6o5NH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6be0db7-254f-4a2c-9914-08da7e5d9a92
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:31.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWtcbzLrf2KkJUiZBiTN9gd/W3Z6wbvSYwIkww+LDHWTgrdct/tQWEJWYmZmbWF2odBXiAkQgBNm4s4JFJcELw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 LPCG is different from i.MX8M CCGR. Although imx_clk_hw_gate4_flags
is used here, it not strictly match i.MX93. i.MX93 has such design:
 - LPCG_DIRECT use BIT0 as on/off gate when LPCG_AUTHEN CPU_LPM is 0
 - LPCG_LPM_CUR use BIT[2:0] as on/off gate when LPCG_AUTHEN CPU_LPM is 1

The current implementation suppose CPU_LPM is 0, and use LPCG_DIRECT
BIT[1:0] as on/off gate. Although BIT1 is touched, actually BIT1 is
reserved.

And imx_clk_hw_gate4_flags use mask 0x3 to determine whether the clk
is enabled or not, but i.MX93 LPCG only use BIT0 to control when CPU_LPM
is 0. So clk disabled unused during kernel boot not able to gate off
the unused clocks.

To match i.MX93 LPCG, introduce imx93_clk_gate.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/clk/imx/Makefile      |   2 +-
 drivers/clk/imx/clk-gate-93.c | 199 ++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h         |   4 +
 3 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-gate-93.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 88b9b9285d22..89fe72327788 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
-obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+obj-$(CONFIG_CLK_IMX93) += clk-imx93.o clk-gate-93.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
diff --git a/drivers/clk/imx/clk-gate-93.c b/drivers/clk/imx/clk-gate-93.c
new file mode 100644
index 000000000000..ceb56b290394
--- /dev/null
+++ b/drivers/clk/imx/clk-gate-93.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2022 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define DIRECT_OFFSET		0x0
+
+/*
+ * 0b000 - LPCG will be OFF in any CPU mode.
+ * 0b100 - LPCG will be ON in any CPU mode.
+ */
+#define LPM_SETTING_OFF		0x0
+#define LPM_SETTING_ON		0x4
+
+#define LPM_CUR_OFFSET		0x1c
+
+#define AUTHEN_OFFSET		0x30
+#define CPULPM_EN		BIT(2)
+#define TZ_NS_SHIFT		9
+#define TZ_NS_MASK		BIT(9)
+
+#define WHITE_LIST_SHIFT	16
+
+struct imx93_clk_gate {
+	struct clk_hw hw;
+	void __iomem	*reg;
+	u32		bit_idx;
+	u32		val;
+	u32		mask;
+	spinlock_t	*lock;
+	unsigned int	*share_count;
+};
+
+#define to_imx93_clk_gate(_hw) container_of(_hw, struct imx93_clk_gate, hw)
+
+static void imx93_clk_gate_do_hardware(struct clk_hw *hw, bool enable)
+{
+	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
+	u32 val;
+
+	val = readl(gate->reg + AUTHEN_OFFSET);
+	if (val & CPULPM_EN) {
+		val = enable ? LPM_SETTING_ON : LPM_SETTING_OFF;
+		writel(val, gate->reg + LPM_CUR_OFFSET);
+	} else {
+		val = readl(gate->reg + DIRECT_OFFSET);
+		val &= ~(gate->mask << gate->bit_idx);
+		if (enable)
+			val |= (gate->val & gate->mask) << gate->bit_idx;
+		writel(val, gate->reg + DIRECT_OFFSET);
+	}
+}
+
+static int imx93_clk_gate_enable(struct clk_hw *hw)
+{
+	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	if (gate->share_count && (*gate->share_count)++ > 0)
+		goto out;
+
+	imx93_clk_gate_do_hardware(hw, true);
+out:
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static void imx93_clk_gate_disable(struct clk_hw *hw)
+{
+	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	if (gate->share_count) {
+		if (WARN_ON(*gate->share_count == 0))
+			goto out;
+		else if (--(*gate->share_count) > 0)
+			goto out;
+	}
+
+	imx93_clk_gate_do_hardware(hw, false);
+out:
+	spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int imx93_clk_gate_reg_is_enabled(struct imx93_clk_gate *gate)
+{
+	u32 val = readl(gate->reg + AUTHEN_OFFSET);
+
+	if (val & CPULPM_EN) {
+		val = readl(gate->reg + LPM_CUR_OFFSET);
+		if (val == LPM_SETTING_ON)
+			return 1;
+	} else {
+		val = readl(gate->reg);
+		if (((val >> gate->bit_idx) & gate->mask) == gate->val)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int imx93_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	ret = imx93_clk_gate_reg_is_enabled(gate);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return ret;
+}
+
+static void imx93_clk_gate_disable_unused(struct clk_hw *hw)
+{
+	struct imx93_clk_gate *gate = to_imx93_clk_gate(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	if (!gate->share_count || *gate->share_count == 0)
+		imx93_clk_gate_do_hardware(hw, false);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static const struct clk_ops imx93_clk_gate_ops = {
+	.enable = imx93_clk_gate_enable,
+	.disable = imx93_clk_gate_disable,
+	.disable_unused = imx93_clk_gate_disable_unused,
+	.is_enabled = imx93_clk_gate_is_enabled,
+};
+
+static const struct clk_ops imx93_clk_gate_ro_ops = {
+	.is_enabled = imx93_clk_gate_is_enabled,
+};
+
+struct clk_hw *imx93_clk_gate(struct device *dev, const char *name, const char *parent_name,
+			      unsigned long flags, void __iomem *reg, u32 bit_idx, u32 val,
+			      u32 mask, u32 domain_id, unsigned int *share_count)
+{
+	struct imx93_clk_gate *gate;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+	u32 authen;
+
+	gate = kzalloc(sizeof(struct imx93_clk_gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	gate->reg = reg;
+	gate->lock = &imx_ccm_lock;
+	gate->bit_idx = bit_idx;
+	gate->val = val;
+	gate->mask = mask;
+	gate->share_count = share_count;
+
+	init.name = name;
+	init.ops = &imx93_clk_gate_ops;
+	init.flags = flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	gate->hw.init = &init;
+	hw = &gate->hw;
+
+	authen = readl(reg + AUTHEN_OFFSET);
+	if (!(authen & TZ_NS_MASK) || !(authen & BIT(WHITE_LIST_SHIFT + domain_id)))
+		init.ops = &imx93_clk_gate_ro_ops;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(gate);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+EXPORT_SYMBOL_GPL(imx93_clk_gate);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 396a5ea75083..dd49f90110e8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -451,6 +451,10 @@ struct clk_hw *imx93_clk_composite_flags(const char *name,
 	imx93_clk_composite_flags(name, parent_names, num_parents, reg, domain_id \
 				  CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
 
+struct clk_hw *imx93_clk_gate(struct device *dev, const char *name, const char *parent_name,
+			      unsigned long flags, void __iomem *reg, u32 bit_idx, u32 val,
+			      u32 mask, u32 domain_id, unsigned int *share_count);
+
 struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
-- 
2.37.1

