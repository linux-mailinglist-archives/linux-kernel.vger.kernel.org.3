Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F7584209
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiG1OnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiG1OnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:43:10 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe07::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FEBFEE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD+8H2OMMl/K33yaoaIm/+y7w6MiyHILA2qXNDnUfsPnhpVIAvw475wx0pSLYCT0FrGfGKvkxQMoLXQlzmgnb0IuzHmPUjpMZ77A6lgRT0W9VSGFVtpw/snVvywW/9xTsw+CyFRfeZr1ZPUDPPF9SRT2ThFJMgw/FklMj5dkIGkmqEOUhMykCehCadYMoPO9bjIs57Oo8E1yHu0xBUGc6cXg5A3yUguTYBrxwTpSnv7AHesomjiGpXEyHlTG3LsJXOZ1oSJWYgNM3ICdsPklT8wZ56QacermjXQGYfTVxHYb69I/c3QcS7S2jCAoelDzuRgejEA86jCjKWJCgGeQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgkLEPCxNZZohmeygb20c/kiZ/DbgW50lUu0zN1kkGo=;
 b=IJG0oaWD0llJ7plrnw7FgeMLPMo0d3/sFEbAf0lCNZpWMrReaGRa8ksADKoFsCxlCZqflD2SSTjBG/rCAWznsNidCk/2Xzbn53//KUpAoEGMITMsTRYG3oOWvRow9W2NT7jW32FLlLjn1+eFu4ig0JAl5Cq1ElkjRJvJ/wnVvA44GqnPIjhnzvFDFZparOGeh5imeiyCfXJ6yS7FPo0t15nAtFPDiTnsi7rX/qYYarVMhOpgRfvq7xGr57c3+V1qNDV5QOja+IfJmSdIe7gsnodRCVVoejgpcFagEJtw7xJfNlHuPo0KAPK9/PBKrj7Mif5CZRaF9jw3MIKgV7rEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgkLEPCxNZZohmeygb20c/kiZ/DbgW50lUu0zN1kkGo=;
 b=dt+ACrnyVwxphdTVoY4fAOYmN/xO9axp1l3jvzIlmaVpusNXAJ7JjNprCjrNirG07gEc8ZkeKBeOs7WbLy1GqOOlYJ8p5zuKwHDDeEaxe3SHZFi5e5T6S6OgE6bo4rDGccQ3S5P+FSg5TujF37nI6fY4FfSS8WT+donwidjKptM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM0PR04MB6307.eurprd04.prod.outlook.com (2603:10a6:208:142::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Thu, 28 Jul
 2022 14:43:04 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5458.019; Thu, 28 Jul 2022
 14:43:04 +0000
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
Subject: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by avoiding to use regmap
Date:   Thu, 28 Jul 2022 17:42:54 +0300
Message-Id: <20220728144254.175385-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::11) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43291f4a-2e53-40b5-9d8f-08da70a77a2e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6307:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFlGBcTRVlolnu2wdZFFrLuhnBl5tPn9GzYsa5O/3U2CfbAb5+wtBbMbLzOVECVRY9z6CsM6ziJOo6ut1kUFHjMC3hbO2bMj+1kv+5fowfjzzqRSMzTXEPXfEdnLoDgSqH/v+DJc/XjbqYRiJ4CQg0nqKRshvMBL4C1PT8doilI8rBtLPg0JV+7WsUxixSJH5AI7ygKFcwia0e4mzwOX1b2gp2pCceiXAVTT7niYlDb8pR4udNAQc13KtCDPyVuSKypVahPcZRu3NbgNqebZ7s3W+Wv6D0eGszAOl9avgaYpLZO3aQ62yh0WkIG6vwIq6RUgl+xEWj1S8MIm7wA80xkJ+DYsclG8WJamWeHpVvCEF+PJOnHNzPpUoYItjIVcii2PH8RE5wKqFzQP8bteDeKL9wEidT/Bwcw87JfEuYQre7TUzxr2J6Rqh9ZtdS2DnbwtZHvp1ZrjJ/oy65TV4+0YtnTt514wuHGxy2/WyP6qCDGG8Tg8F3iLyh5EsnpezZ1f0MzAgVHE5Ylih5XtHpS8YXojZFveRRj/Cs01YqqtYJ+i5omFH4ygKb3gTBo8/J06EHEYzm+FPqt8AlUy57GA2y+FUtJ8OBCtMgWusJfU22Z7F9bjLPazyGMBI2FgDbsG4s3e2XWc4TNk5XU4JSEvZP0mN0JnvCKhvB3K+Ip4XN3XTeTi0jBPSUj6Avxyt09ClvZHI+xP2w8kgb/yc98aEWmjMX05f8ECSb5PnnYBox1LGvI7Bb4ktzVF3RUsYRgmIkR36I7t9gc5tfbskJpXpZ2J7bJ74c/pQluWYD+tZhDqFfiwk3LJC5q1xSFpzpruxyt04etPNzat6khxSQ0cW1V5afCgzKCfvXi0n+AWoW1k8dhIEkLwBYtvpBwX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(6916009)(5660300002)(6506007)(66476007)(38100700002)(4326008)(2906002)(38350700002)(1076003)(8676002)(83380400001)(8936002)(66946007)(44832011)(66556008)(54906003)(966005)(6512007)(86362001)(36756003)(478600001)(52116002)(26005)(316002)(41300700001)(2616005)(186003)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r84BFUkss21CYI8sVsbRuTNKEB8gpgUy0E+iK5mf6413D6VjZ/FAe77P4hI6?=
 =?us-ascii?Q?5MBoGmikwbNSPoOPqlPcEAX2m+t1uMKLSq5NpZt7Qpikk3qrjpFx5eLc83OT?=
 =?us-ascii?Q?L2F/9YCYW9D7xLXJngC18N14xrlxkUH7nF6DwJ+r0Bh8W8P57BzyElyPITw+?=
 =?us-ascii?Q?6l03+uR1IKGyInRlFOLQi74Hh7E0rMDUfrZyhuiESfUgYNeInRZnBSx7LCnx?=
 =?us-ascii?Q?fSHCrB9cIvQHIEF/g5CCuvM/ncHQPxWquxYid2aNhzt67kQst71+PwlKLZIj?=
 =?us-ascii?Q?66DjiJLkdFUQm9hvi6AVAwfavsJHKvkYVj8KbUAE1yywDIlPUY31ijhAMPxN?=
 =?us-ascii?Q?uFTDRUhaP+orgbA8EMvZcghjHKESwUJ7rUdCi2pqvtpsMVuuYi7tn02N36+3?=
 =?us-ascii?Q?LiOV4VnEERKtL6mM6aFdsm0pUDT0ttXDiGNuBBcZjqYPraHTJeDwm1fg8Xcr?=
 =?us-ascii?Q?h0evXEHJ/l7nm1Qee3oaoKEX4xlO+NvwMgO4Pf+Zio1qgrnDcRAqanoacqWW?=
 =?us-ascii?Q?WkxTPISSGEM2zXSRzffWSnqwVvG6M0ye+YwuC8qjlEe8Zg1yrPZlLpKLF70D?=
 =?us-ascii?Q?VuRaNhWPybLoMm4KyTI/93T8e85fHm59bwv50pqRTkvGh7oyFKeY/nGQXAfP?=
 =?us-ascii?Q?h3yUPqgjbtPlMoV2amQHpjnQJivYb66unMCd1oQgiHrah7O3zeS3dEx3TFV4?=
 =?us-ascii?Q?IQkS7VYuSd688OjwIHiUqIpvnxiWYQSsANhzUopt/VmbtD++fW4u2ug0N0qc?=
 =?us-ascii?Q?pC/cGLU2kl4gj99ZNFD1zbVM/o4hVzQQpS4gbtLn2EEn1re9bqrhbkDV4AoN?=
 =?us-ascii?Q?i/nM7YPtI/d56ZvAV12GZI5A8+hT9XWuZXRiCl3XPLLa1gGaJSBAGdbb0Z6l?=
 =?us-ascii?Q?qUT+95RYkdA35olmlvA/moJUnHYT8XWMJFNGS9A9HQBY0NtW2bR9HJc0i0FO?=
 =?us-ascii?Q?SzK9V+tfAjoRZsOboSrET8PwttXrnoHs9DdskZoHuGlBMwqjKTPcU46wVsCV?=
 =?us-ascii?Q?6k5avEY7qbdb/qVPULowNdrVdphTMqH/K5rk8m2Fr1XInEVAMICecuY3VhUD?=
 =?us-ascii?Q?TXx7J9pXjYdl6x3k88ZrwkHGvCVvv/wAKbII2X9uwrTwqc8Sftqc24CiXhAc?=
 =?us-ascii?Q?QikxA986l1qi0svTmpuBwG86+yNTtcrGBpDg6/RZdGWbxiYZhexzu/hLC3RL?=
 =?us-ascii?Q?fbQ044JTx3gqugAHnqzh8sLRTIL/RbtHAwpTSmvG9mgSp406agzpMmkP0/xH?=
 =?us-ascii?Q?12Ssrf/+QN6X/vSQA7eV1cm3OSdpPEiRLDavuddOXhsMFvncCuhlCxZ2E09j?=
 =?us-ascii?Q?ztFJaJr1go9JIW62UCDWOPJMXiPj4XQhXgh+G+k7KSpW59RD5bfhFOrjf3YG?=
 =?us-ascii?Q?P70egLFGLu6OzIz3XhiyPZVsuVhJTeQn/QUi2uEnsSgxrf08Fn3QWQKx1W79?=
 =?us-ascii?Q?DfS0L4p02fKGSzqhOYoYMGCj/NZLlp1jtDPJeGZVI67lEswatjxoSdaMfQOM?=
 =?us-ascii?Q?HWxr/yYWKWziOQnMecg0/yGUIQ2L3mgyiyepd5mFUfQ3K9rOisPE2i4Kh3MV?=
 =?us-ascii?Q?J5ECOvNz93WAwPlEjlPP3p7Hbk2P6DJcAzNelOhLo5Zg9VIfywIoilIDbdau?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43291f4a-2e53-40b5-9d8f-08da70a77a2e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 14:43:04.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMiQWEr2dK+Xs0IpP3l4KjhPrLhDO3xptF6xAkBEjc3G70yhE757+aJNYrBlExhfA/I6nwlWWSRwAX2N+oz4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6307
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
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

Make this driver ioremap its INTPCR register on its own, and stop
relying on syscon to provide a regmap. Since the regmap we got from
syscon belonged to the parent and the newly ioremapped region belongs
just to us, the offset to the INTPCR register is now 0, because of the
address translation that takes place through the device tree.

One complication, due to the fact that this driver uses IRQCHIP_DECLARE
rather than traditional platform devices with probe and remove methods,
is that we cannot use devres, so we need to implement a full-blown
cleanup procedure on the error path.

Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- fix the dumb decision of dropping spinlocks altogether in the extirq
  driver, and add a comment as to why they're there
- drop priv->read() and priv->write() and open-code the read-modify-write
  inside a new ls_extirq_intpcr_rmw() helper.

v2->v3:
- stop using regmap, do the rmw manually using function pointers for BE/LE
- adapt comment style to the subsystem
- use of_device_is_big_endian
- reword commit message

v1->v2:
- create a separate regmap for the ls-extirq driver rather than relying
  on the one provided by syscon or modifying that.

For reference, v1 is at:
https://lore.kernel.org/lkml/20210825205041.927788-3-vladimir.oltean@nxp.com/
and v2 is at:
https://lore.kernel.org/lkml/20220722204019.969272-1-vladimir.oltean@nxp.com/
and v3 is at:
https://lore.kernel.org/lkml/20220727160915.3648155-1-vladimir.oltean@nxp.com/

For extra reviewer convenience, the ls-extirq appears in the following
SoC device trees:
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi#L289
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi#L249
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi#L319
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi#L325
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi#L682
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm/boot/dts/ls1021a.dtsi#L182

Patch tested on LX2160A and LS1021A.

 drivers/irqchip/irq-ls-extirq.c | 87 ++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 853b3972dbe7..d8d48b1f7c29 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -6,8 +6,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -16,13 +15,41 @@
 #define LS1021A_SCFGREVCR 0x200
 
 struct ls_extirq_data {
-	struct regmap		*syscon;
-	u32			intpcr;
+	void __iomem		*intpcr;
+	raw_spinlock_t		lock;
+	bool			big_endian;
 	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
 };
 
+static void ls_extirq_intpcr_rmw(struct ls_extirq_data *priv, u32 mask,
+				 u32 value)
+{
+	u32 intpcr;
+
+	/*
+	 * Serialize concurrent calls to ls_extirq_set_type() from multiple
+	 * IRQ descriptors, making sure the read-modify-write is atomic.
+	 */
+	raw_spin_lock(&priv->lock);
+
+	if (priv->big_endian)
+		intpcr = ioread32be(priv->intpcr);
+	else
+		intpcr = ioread32(priv->intpcr);
+
+	intpcr &= ~mask;
+	intpcr |= value;
+
+	if (priv->big_endian)
+		iowrite32be(intpcr, priv->intpcr);
+	else
+		iowrite32(intpcr, priv->intpcr);
+
+	raw_spin_unlock(&priv->lock);
+}
+
 static int
 ls_extirq_set_type(struct irq_data *data, unsigned int type)
 {
@@ -51,7 +78,8 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
+
+	ls_extirq_intpcr_rmw(priv, mask, value);
 
 	return irq_chip_set_type_parent(data, type);
 }
@@ -143,7 +171,6 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 static int __init
 ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 {
-
 	struct irq_domain *domain, *parent_domain;
 	struct ls_extirq_data *priv;
 	int ret;
@@ -151,40 +178,52 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
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
 	}
-	ret = of_property_read_u32(node, "reg", &priv->intpcr);
-	if (ret) {
-		pr_err("Missing INTPCR offset value\n");
-		goto out;
+
+	/*
+	 * All extirq OF nodes are under a scfg/syscon node with
+	 * the 'ranges' property
+	 */
+	priv->intpcr = of_iomap(node, 0);
+	if (!priv->intpcr) {
+		pr_err("Cannot ioremap OF node %pOF\n", node);
+		ret = -ENOMEM;
+		goto err_iomap;
 	}
 
 	ret = ls_extirq_parse_map(priv, node);
 	if (ret)
-		goto out;
+		goto err_parse_map;
 
+	priv->big_endian = of_device_is_big_endian(parent);
 	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
+	raw_spin_lock_init(&priv->lock);
 
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
+	iounmap(priv->intpcr);
+err_iomap:
+	kfree(priv);
+err_alloc_priv:
+err_irq_find_host:
 	return ret;
 }
 
-- 
2.34.1

