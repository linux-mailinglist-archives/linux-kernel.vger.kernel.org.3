Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C45A5A01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiH3Dav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiH3Dae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:30:34 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4D79A65;
        Mon, 29 Aug 2022 20:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePYPAqzfHjLpeB3xdAe5w+/k9D4vxo82jDh3SfFgYJPeQgSG9CJrJafKYsaUIqazMJi1UI/HuILk6iTJzzIC+e1fSlAvM3mIvJFtjdhU7qZwFBKCFKP3WsS21LOr8qofGmhUpilaVnUMHGUIDMyiM+4m2xt2tMDYGWr6mqxcBDPxVO7s4c+MbGj+2kULBDM+N7oAtGL8cG62oTg5TJUXND+AF3k5NvLtv2uca6W9IOp7WJeL+5FMKaEBTPOIp/J3gMV0a0qVrdRiTspMuVOi3Sl2a4yw1M+br7GIVqf1AzCmYtY/vzHbWd8paZGG61z4f/qBfZnMsLRbXsrx/Kfveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCQCaAr8HHthjGkAWhpi/N8DbRuObr7hZbfRNu6zGCA=;
 b=jppYooS7PtjMzJ7a7L9bGTnz5PWsoV6IsHzrQwxSKrIZKNYw1P9PngmJzr6vYcVZ2MOb5QUHIhbOZ6mJsTMM1k++MXpIb/EO/np178FE5aZdU5Az/Psoq2195fguuRzBD/AKQj0JM8JeeLUJdKp1enkGK39AlDPhOw40tyoOUXWqQdGKXdUyNi6noDzMJWO/M/KDAsH7fkkcAwQqXKknfmErgQft1zSf+Y2MH5DJQKntlW3VEX2Y85S94qbKh0H8a9NMvi51GVdAfelBHCpV32vgtWsnBygOvpGmj4p+Akbh/zefrAkcgtygCT8LWkkdNaxbs1V+yU+AxhAWH/PJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCQCaAr8HHthjGkAWhpi/N8DbRuObr7hZbfRNu6zGCA=;
 b=NVMggIVbBclx1ukDtFshbnyUlLT6jABhBNEnXIDlOVR1VnzHctxnIsigrQ2LRc8uQQBdJ6+rVP6V9neaB4tfzv0N5PKPRien6m8JY5LsNi2Wap8FZG+m5akWyYecpDTcoCUOlkBOdUWnjlBLdz1I1wh5qKwUejIJV0zNft6vD4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 5/8] clk: imx: add i.MX93 clk gate
Date:   Tue, 30 Aug 2022 11:31:34 +0800
Message-Id: <20220830033137.4149542-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d8e99c-3839-463c-1784-08da8a37faa0
X-MS-TrafficTypeDiagnostic: VI1PR04MB6926:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6o72BhFEOr/0Lyzob3cZxhngil9/ZpKmtw8kj0rR9Nycigf72ShcxKC7zYuME1/UKVYPLXh4I/2uEBK4O2RjTyEfnVI6drmLqtPgGj/QZBSWeVGewWJ9KmIP+QR0wTBUmGwtVe3Pusx8M3cQyJmmAMHPw1bkhJp8XPe+D5XERKnIcwkWvXCP8nXB/4aviX6bOfKEqZbAtk9QxBjf6zv8yikFkJefMjT6rs/4xzcznb+TRru+zdHvwxAqVw/1z46cB8n4h/OKQvQoUvAw/Fw4nS7+v8CSlxZMrPn9B6c0k5up+RU/EYsXlT9LQOXKQnI9buS3oPN7mpX90OdmBKDhQoOCFqkJ6AoDImqk+4SW1k9nViSJIu+61S1m9fObd3TRskxhHSg+yKoe+WNkXb/i0FD1HV77kCzMOtDra8cnfG/T4P2fK85mU0zjIQKeZ5xcQuaWVwErMB8jPkLuWGbMP738zKPqYwU5Ek1PBbTPnZZe4/MBbtVnnzKeC7fb72Pb4WgyINnCMAF6Q0iQUcleBDy2QakSZ9ywvhQXGKNLRoL09m9ttKaIFEt1I+9dyus/2e1NAgrmA/JCdw8EStEnZ3SsktXuW7hBudxg2EHUDfYgm17BEUu9oFgj5lNbbb85SAjgxNu/jT4p8yT4cqTJEFXhi5U9w7epFaa/EpxIGpUIMHqFo1BazTxQpnTDD2p2BjE/5CKjbxDgpHj67C7V16N0qz1F2KUtyrXZ8DRJHP3s0wryd4W9uLro4gX4YdpBq9en81Kgvb+llXAnLj/djw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(6512007)(2906002)(38100700002)(6666004)(6506007)(2616005)(26005)(38350700002)(52116002)(186003)(1076003)(83380400001)(4326008)(66476007)(66946007)(66556008)(8676002)(316002)(6486002)(7416002)(8936002)(54906003)(86362001)(41300700001)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zd/CVOKIv4V3mLrIpSApT5BLEepg75zs3Y38XzCU+snKfQGisQqkK6OQ6dP?=
 =?us-ascii?Q?8SlXjVWsxc8dctEuATiJ3tyrMsGQeLGM/dH6B5QmNvdPWDBjkIRCyPLzUbt/?=
 =?us-ascii?Q?wBcoDPXLIez/6Pw5VDTFGotQnjJvzvd9fZNeBG+lHQhi9xRXmGUhB0t3wjxm?=
 =?us-ascii?Q?kThV+Ed7P8VX7EK4NAOA21YCV1A+FQBbs4sOyW8+2SDm3B0No9p5o29kvnVa?=
 =?us-ascii?Q?5VYTNhuOjxlkleEpvobePt22BK+p9C54lIJtYbNs1S0IJ6XFB2rt/AsIeHTq?=
 =?us-ascii?Q?lcky6Okv9KmUPwlg4e2F8yHTUi07Nv/6IA+cNCmMyM24TXQz6MP++xCPWcna?=
 =?us-ascii?Q?VoDTukkrlkSIr6bpxxFgsYcv82Y0tKekdS1dY0E1RQ0AA/vcPORZ8ovro7H1?=
 =?us-ascii?Q?wVD0KuOWlC7SpS+NsQAofXC5eXI1IghkQiaCNkcH/MAN2jPB0pM0+iOyag3e?=
 =?us-ascii?Q?JYMYCZv9xwvRYIWtGW9iwM3CbF0p8/D1Zt01VkJIAxkb8GSOaQXrllcXGrdF?=
 =?us-ascii?Q?mLh1+e+8KtUQQeZ1GO3aUxlOT4NmCs7azjK8ZKVZameF+d1Gx3bltsprEFGG?=
 =?us-ascii?Q?2PyLuvFmp5F9SVTtSEmUJhX/RQvspHhtw2WxWe3qOMiZ1pDwra/08zCkjOLf?=
 =?us-ascii?Q?bw0yV2QcrVjawiOTuuPhrjshiPq6+GDmhE/D/ufWZUvT3reqBylWcxhaih3x?=
 =?us-ascii?Q?469jjmCv87klkVfnWpk4ibrDVnjszoX4V1pEz24W2hMBnnNezYMBBLBbf3md?=
 =?us-ascii?Q?5o93RxEaiYQQmjPKEPUpJqDO22vMl6OVuOdU+ECXdtoYDcT4smwG3Z3yPWUT?=
 =?us-ascii?Q?/aMUIkTahga3JKleuxdJkOesm1dKK17ZQ9ZXey1n60cGaO8wj7OD2ftGWhYw?=
 =?us-ascii?Q?CIZ7HCmQUATGSASEAG4yoxc7kVbVEqnrznX9h6N+6AVUvA0LXzPxEbtX1KnI?=
 =?us-ascii?Q?F2pGDCPJ2k/wB28Bq0M2rNTWHS54mtT8ViIsTeqewKexKq3HYXbmVNTx9CHO?=
 =?us-ascii?Q?uAVcQFOma2+amYQROR5aurtv9ZX3KA5XEwD83b6YKfIpfhiulpdKOLweFiq3?=
 =?us-ascii?Q?iqthA7YLhkhGyuiL1cWW89kjWlA12jjD16fd6nZpsdhrHl4wOhLJi57ss6cI?=
 =?us-ascii?Q?9wJXtOtWyedcICoQZL2iKg/oiEGBicZ2OVX5EJLULoGXVP+aNN3ngnfQYE/t?=
 =?us-ascii?Q?qeUJoQtJeC/xOhz+O7LdnLSb7F9UOwjqF0EOjblRe9UpEa16QCEWUY7vhebA?=
 =?us-ascii?Q?oh1rPjWoU92/gipQ7ECPxwgYAbkjE9l8687tg0nKOnO3Nwi9dErwAYh4yDkx?=
 =?us-ascii?Q?7n32E8NpROXhd4B0MqaeFW2J/CGh7Wt6xafQZbUJJf9C71L8KV2Mq+rZ3pAt?=
 =?us-ascii?Q?wG+BuMgrxcT3SF1AvS0vEY1wpEEWCLdNcP8ed6CgMTN0NhyCFUY9jPNzk6LP?=
 =?us-ascii?Q?UAm0HPdgaL7p6z1hFQle0TEo1D2UVlVnbDrQCBhJglHUxW6tUbjchEixuam8?=
 =?us-ascii?Q?LI5x7dPU7JR9N8y0vOwYS+pUeFOz6I4NAjMh4BcXCTWFXhWS8VcnQh5PYuvD?=
 =?us-ascii?Q?zDcK4vh2GViSNABr+bHfbmCOr5rrtp98R366uykq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d8e99c-3839-463c-1784-08da8a37faa0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:26.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1I4cUodjz15FX0HsX+00OvTnJ4fX7/2vv/+9N7NiMOQGpQA2F57mhF7/exuq0iaC8VQR3sG5uJo6n8KKcE0diw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

