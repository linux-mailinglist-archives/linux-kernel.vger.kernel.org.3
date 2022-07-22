Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39B57E878
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiGVUkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGVUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:40:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C713F5B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g55NwXkE5GPk/Idr4qKPx/j9k1xnhC4BN7NbYrr1f8wH1hVqxNu2OhqOrO4nVNNo5aJjIPGUPpmRlpyxirleu2HL4Pu1WusUk0ehT+FKA4z6gqUOFPgrUM56MxENcdMRT1YeCXiBO00V0DU4vMxYmgBss9NgMJvEWBlFBYX2+kyF6QvZmu8H+mQeBtaN4/31xk3t33xQGvVQJclj6HPGsWnh+VKLTipXCun+/A4T4P4BPSW1wzKWjbKCzIrjvvffdHPEIv9LkzpcgA9U2k/1trsQ3T2Jizh2zkGkElnzT3C73LQ2oD1wD+xjQFWub5YSw4mVNTCbD9nS817t/woNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69T1aS+LP/snPDsnOecglGFjShkiMWPy6wkyv17VH+Y=;
 b=D5k825V2LHYhfwkKg02t5K1exDGgnZYhmxfEyiLs+gn16LygAv+ivvM2248TqI+VbmniUf2upn1npw7dNMkBoZ3DNgFg5FBDHEy8u4NwdPa/FJVJ8PTPsDsjLZMZUfdgi+8ccMp8X8erHE9IsmW44zZJEaeo/3FfWRLQ8Bfl1wsET6609qcdW+ydbWhZlcxE+P5CBUn7QOI9blTQnv+bPinFIQ17CMTCQNk32qHuZsa2vu09thtA+fn93DXJJmz+g/fB5cey0VaV7TJy5NHOP1292jhCe315rdFmUye7Yu2XU0/mBWFf+ILV5qGQqJYFtTDVsVqHg3Z6tjhvVYJ2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69T1aS+LP/snPDsnOecglGFjShkiMWPy6wkyv17VH+Y=;
 b=qWoMo2qiRPgqQ9GJC8GOPSgHg8EPxxeh4NAqJqYP8byzbTQvEciB6Y2vHgYctYhMcXd9UV00MugCIKWad4t8kJPX860N+hpT5iRpFc20idOf5N8gUXsp/WUIkNS1vBUtA6XrczcjwMEzA5s+KgGjzcydX1L9bYEXva3fl7/2Ll0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PAXPR04MB9254.eurprd04.prod.outlook.com (2603:10a6:102:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:40:37 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 20:40:37 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2] irqchip/ls-extirq: use raw spinlocks for regmap to avoid invalid wait context
Date:   Fri, 22 Jul 2022 23:40:19 +0300
Message-Id: <20220722204019.969272-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0086.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::12) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5dde15-420b-42f6-3476-08da6c226f0e
X-MS-TrafficTypeDiagnostic: PAXPR04MB9254:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1XDU4h0d1rd5RebWmEaEskv+1BeLeZAlvBIBOMER2cn4xiJeo35SIhN9wFuI+brqlLo0bFl5TBMgUo0UmbMEljW0zahhTtwLLuXOgI6a+jGYvTQLNwc9q004bprJFutC5OXY5O03CA9BN++QusqoVSQXT4XUFhySmyzlU+en0g7KWOJbQOFCzEE9obWVTvAEn0n09I/4xPWQl3m8uxzAc8bXiCnaC4XK3tLtgcREXcaGiKiTdvMI9hmgWzmJW8T2gtfLTnJK4NkLEfxR3hMu8QsuMjH5SF5DiYpR9A0QOuMb1q63bofoYMht8xmE3GG9Aq0fSxDrMg4TwzW6dU4e268Xd/xZ6nNCZlvfgLJ1oRpnyRc2o/8u3xo3e59YD6s2vHWTWrVYn7HWg6WNGBhiLHVeSs9+48JK238JXtlspXy5+47XrB/y6zOX6T16osKfgL3c8HZOUYvukfq+jfA+Yq+jyOF1028vPTipGxlVNBerMYbTDFSngJ7fVWalK/BrUD0h7t7zkIZfAjvjkKUwh8ImI1e8NGvNvtfNSrwd2yk9xebPEvJ+UKhnp+bMm9alLtEgqymc7cS1i8JWMLuqpNtGRInlQGPKQKquhXLv46hNwuztMMrhKDZpCI5gn9vZINWUBxs1dU4/wP+z69sHI3tzsdL494grmKFAuG3mFJhja/OtUDILLk3AbQocEiMu4zFuLl9R3N7/wr9ExIR7BdEpYNZCh7dbsniQ6ymNSkLad2CFL5DOa+b+ROU6njiVAJn4OzsxIJfWEATl2ibiMCh4b25ToRJ73w2MQoSh3TAd0kSsTfjOORBx/pBJvjbtZlEvQwCkGxOJXOf4QIdBac58IRGpx9QHYblBc/WLVOOnT83OhYZFDSpSRALJOiq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(8936002)(478600001)(44832011)(38350700002)(2616005)(5660300002)(966005)(6486002)(6506007)(52116002)(1076003)(38100700002)(6666004)(26005)(66946007)(6512007)(6916009)(2906002)(86362001)(316002)(66556008)(36756003)(54906003)(8676002)(66476007)(186003)(83380400001)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQC3zZ5iPgw1ihAwbKu1h2FA/moWH7b8JDcfjTe6WdYO8ZxoePmAgabEtQae?=
 =?us-ascii?Q?AyIgVVcFqQg0wzMMqtExeWVMVyydvZVci5Vpz4BODhmyzP52u1WmgRu+/dXA?=
 =?us-ascii?Q?PtF0+N6LfViCKVP9QzzAvmx7jEKQNo2BiIx7idcwWzIfS4sfegkwTiiRGLey?=
 =?us-ascii?Q?mRFgrfAR1z5pNjRqhro3kBgYXMsSGEYjGHrWXxJISMvL4Z+6zQglR2XIoayA?=
 =?us-ascii?Q?3vLLV1Nd/TMZaFdE/1XL+JkIRBufP3cKMWdFG+ThHaEWOEi4y3tIXHiObOAV?=
 =?us-ascii?Q?XmRFcE/TVQui5hbOtGLL5HKrd+lYDBcTTCQCohmyuMTmrQfrKcXjw0Pc0/4i?=
 =?us-ascii?Q?ci1wolTCbXHwNqC0YU3tB4o2no9i1EKd0CbadBBJT+V9K93d99A6Hg06fyYW?=
 =?us-ascii?Q?EbzfJpDPQ70HfbRmR8gYv5c3kgyInHDfk4Q4J/hVs+EoOJY/nnm07csmCUIE?=
 =?us-ascii?Q?GJuOjdvUNKn4yORE6aIBA1n2m6hEtveHdfgj/HVEGzFCu4s+O17FaqEHnwC4?=
 =?us-ascii?Q?/h0K9+WvW3X0BQbKsnFYHSFoPn4qrD8DAP6iVyOTE/qWvKu0iYFP6N9E+8E0?=
 =?us-ascii?Q?nX0hbQ7SIuJbdm7dgbTHL63OVet4PpWZkNgePc0awPt+EsF3NaX0X7Yg3gIw?=
 =?us-ascii?Q?oBf/cQw486RoWrCm/xg5dXLt8xKzRoMvMqHwiK88f5xV7dMVRv2VQQBAwaox?=
 =?us-ascii?Q?9hx24nYM5bBg5Ut95IMyNjrHwFDS8KajGorEgPaPiduw/bacBVDhujhIHhD3?=
 =?us-ascii?Q?ummaGOTPCWcU/+rEfFux6uHwE8gA/SUkUKe8+PviRPtTeoGCWVEdX6/C9iaC?=
 =?us-ascii?Q?ihFomPE2E6oivfSXtSrcTH4ysp9h1NpPET6pw5IseKa/iAp+8tCPrc8goOXO?=
 =?us-ascii?Q?OalOp9wPg21zs1NanElrA9uoa8qjIxbDb8kHXMhhQpY4JsUoyTBvNS+tqQgK?=
 =?us-ascii?Q?Aj0VJ+mS9yG/ucPbGFcUJiSQnMEQMNfoH6Q894LvzP2kz7BMKOMY2Ir09eEL?=
 =?us-ascii?Q?QfmZC8uK/PXezmFDaADk5jy1/2tjDkPRugYYTo84jDoFVE5NQqi3lxcsWSWD?=
 =?us-ascii?Q?q/mki8tQVrpn9CDzU93/V3S2NsRACHI3t+HTQWmLnFLyMFaJjUJTwec8ZtZY?=
 =?us-ascii?Q?YxFxhl4niInBB3PVX5xxNDS/7F2N+g/03yeOdO2AUIJ5FOKdx6GVgKdLnyzW?=
 =?us-ascii?Q?TQOp35x8aCqfcz/n8+ZUM54bqGRz5RAb+VRnDp4CxKVLyRLQoLmwjyT0HjeJ?=
 =?us-ascii?Q?yJBJl+CIqinTDNGgmrhsnByRKaMvkN3os87nU35Xo2YCrh3e1KsSHNwWAN5p?=
 =?us-ascii?Q?ObmeL6CYIcUJUS9pf99XdgkQkRGn3NoRYmad93q3Dp+NtdWSNKJTeP8LcecV?=
 =?us-ascii?Q?KyzvyQCoVzkib1azcBbIFTa58t/ARFen1VOEFyKpbIRsuwDNhGhH+DBaKiXI?=
 =?us-ascii?Q?9JYMtF2eBDTsaaaBFukoAazBnxvd8rLhgklGK3ue76/mMv8J7vQYrAe9VtHA?=
 =?us-ascii?Q?yw+jdwFwlFGPZwAhvVBC5zUf4LfUtG7203XPlDEH4yhruofBa93co7yFKM+k?=
 =?us-ascii?Q?9o2EYCwxwAqj1v2JcenhLSdvD6KW9gX3Q0KasVBnhbG1FIRwxKjuGB/Pz8el?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5dde15-420b-42f6-3476-08da6c226f0e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:40:37.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wLhOMgYJg0RCTaPASqOIqeWCgl6N8iC2Of13XMWQMeq+5hkERe1xYv65CweI5tPfSj2da90ZCSvGsDO/NrtSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqchip->irq_set_type method is called by __irq_set_trigger() under
the desc->lock raw spinlock.

The ls-extirq implementation, ls_extirq_irq_set_type(), uses an MMIO
regmap created by of_syscon_register(), which uses plain spinlocks
(the kind that are sleepable on RT).

Therefore, this is an invalid locking scheme for which we get a kernel
splat stating just that ("[ BUG: Invalid wait context ]"), because the
context in which the plain spinlock may sleep is atomic due to the raw
spinlock. We need to go raw spinlocks all the way.

Make this driver create its own MMIO regmap, with use_raw_spinlock=true,
and stop relying on syscon to provide it. Since the regmap we got from
syscon belonged to the parent and this one belongs to us, the offset to
the INTPCR register is now 0, because of the address translation that
takes place through the device tree.

Another complication that we need to deal with is the fact that we need
to parse the 'little-endian'/'big-endian' specifiers that exist in
device trees for the parent ourselves now, since we no longer involve
syscon.

And yet one final complication, due to the fact that this driver uses
IRQCHIP_DECLARE rather than traditional platform devices with probe and
remove methods, is that we cannot use devres, so we need to implement a
full-blown cleanup procedure on the error path.

This patch depends on commit 67021f25d952 ("regmap: teach regmap to use
raw spinlocks if requested in the config").

Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: create a separate regmap for the ls-extirq driver rather than
        relying on the one provided by syscon or modifying that.

For reference, v1 is at:
https://lore.kernel.org/lkml/20210825205041.927788-3-vladimir.oltean@nxp.com/

For extra reviewer convenience, the ls-extirq appears in the following
SoC device trees:
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi#L289
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi#L249
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi#L319
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi#L325
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi#L682
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm/boot/dts/ls1021a.dtsi#L182

Patch tested on LX2160A and LS1021A.

 drivers/irqchip/irq-ls-extirq.c | 81 +++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 853b3972dbe7..94a22642b3f2 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -6,7 +6,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
-#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -16,8 +16,7 @@
 #define LS1021A_SCFGREVCR 0x200
 
 struct ls_extirq_data {
-	struct regmap		*syscon;
-	u32			intpcr;
+	struct regmap		*regmap;
 	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
@@ -51,7 +50,10 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
+	/* INTPCR is the only register of our regmap,
+	 * therefore its offset is 0
+	 */
+	regmap_update_bits(priv->regmap, 0, mask, value);
 
 	return irq_chip_set_type_parent(data, type);
 }
@@ -143,48 +145,81 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 static int __init
 ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 {
-
+	struct regmap_config extirq_regmap_config = {
+		.name = "intpcr",
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.use_raw_spinlock = true,
+	};
 	struct irq_domain *domain, *parent_domain;
 	struct ls_extirq_data *priv;
+	void __iomem *base;
 	int ret;
 
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("Cannot find parent domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_irq_find_host;
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->syscon = syscon_node_to_regmap(node->parent);
-	if (IS_ERR(priv->syscon)) {
-		ret = PTR_ERR(priv->syscon);
-		pr_err("Failed to lookup parent regmap\n");
-		goto out;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_alloc_priv;
+	}
+
+	/* All extirq OF nodes are under a scfg/syscon node with
+	 * the 'ranges' property
+	 */
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("Cannot ioremap OF node %pOF\n", node);
+		ret = -ENOMEM;
+		goto err_iomap;
 	}
-	ret = of_property_read_u32(node, "reg", &priv->intpcr);
-	if (ret) {
-		pr_err("Missing INTPCR offset value\n");
-		goto out;
+
+	/* Parse the parent device's DT node for an endianness specification */
+	if (of_property_read_bool(parent, "big-endian"))
+		extirq_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
+	else if (of_property_read_bool(parent, "little-endian"))
+		extirq_regmap_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
+	else if (of_property_read_bool(parent, "native-endian"))
+		extirq_regmap_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
+
+	priv->regmap = regmap_init_mmio(NULL, base, &extirq_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		pr_err("Cannot create MMIO regmap: %pe\n", priv->regmap);
+		ret = PTR_ERR(priv->regmap);
+		goto err_regmap_init;
 	}
 
 	ret = ls_extirq_parse_map(priv, node);
 	if (ret)
-		goto out;
+		goto err_parse_map;
 
 	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
-	if (!domain)
+	if (!domain) {
 		ret = -ENOMEM;
+		goto err_add_hierarchy;
+	}
 
-out:
-	if (ret)
-		kfree(priv);
+	return 0;
+
+err_add_hierarchy:
+err_parse_map:
+	regmap_exit(priv->regmap);
+err_regmap_init:
+	iounmap(base);
+err_iomap:
+	kfree(priv);
+err_alloc_priv:
+err_irq_find_host:
 	return ret;
 }
 
-- 
2.34.1

