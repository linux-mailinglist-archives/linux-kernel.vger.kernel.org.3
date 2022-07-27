Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484B4582A65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiG0QJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiG0QJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:09:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63CC2E9F2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3noPByM21MkcgIzob+rj/Sf3IomGQjU+RAbOZ0B89wvKGfwkcGrDC3vkKz2g9X9A1u5BUf2NRtoctZVL6DCdobPm9KLGpn+s3DYfY3oV0X3e2ojGd499MUCccDF5KBdZQybzLGBTndA4Yu2Bye7KAgkQrSwTo3kUMuYCUfZOd62k+xuANPQUgRQ8LNDN2eF1vIdKnVjZO7noF/41ujOs9uBoyQVQKzM+panb3kzyn0+LyjfX5meG04FFQO0Z1h2WbY17Z06p7pHU1aOyEtX3DthrFP2Hustj0dnYqJecCYzpxXYcbsEV7Md9FUqiludA43s+IxJBEZwN4Nw8Bg8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFMkCPp4upT4djf0tN0UNxe2gZayzwAbh6bbJir5ENI=;
 b=lXOj8K7bgDxk6iQtxQwJvLpsaAPdHZovsSENEtxQofiofeRnbgeuwYExdB6YLgyviLh+C0fpTcg8iYm8JPK+4GRgFo0eAlKFnPj8ytDwmCmRDDoCVoAQl+zkvFVHrkLvVXzu1qKdylqJ5pcHdjRO1Di/yjHyNVuok3uF42mmka0BQ4GxH7anSyEfZA86Y31pSURcmEK9u7/EgRzNzbsONUD+USfTL9FFRNR3HDrWJ+nwSWraEqIC7Grsz5jjiV42VtgfBlWKghoZn4XZW1bLv8VgcAGmV2xyfTdSg11lF515I9BYBukipF6pBaXAYC2HrNfXTPwV3i2KySuu2MpPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFMkCPp4upT4djf0tN0UNxe2gZayzwAbh6bbJir5ENI=;
 b=KCYN9ChsnDEccP4OrLTqdqJ1mchyQooHoA3HGKEwpwUT0vkY9F6SqwHnCrhWFcjxop9mYF3Hcxfpa5JCPdd5yrSIfCbrDRQhXsS34kq+BLagCDZB7BZjJ7xIHhnwiZKTdhSqBKzBJuy4TzeV4o1rM/pAvktEAIMNZYqbujuHDTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by DB6PR04MB3190.eurprd04.prod.outlook.com (2603:10a6:6:5::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Wed, 27 Jul 2022 16:09:34 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5458.019; Wed, 27 Jul 2022
 16:09:34 +0000
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
Subject: [PATCH v3] irqchip/ls-extirq: fix invalid wait context by avoiding to use regmap
Date:   Wed, 27 Jul 2022 19:09:15 +0300
Message-Id: <20220727160915.3648155-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12006a96-c5ba-40a1-7b70-08da6fea656f
X-MS-TrafficTypeDiagnostic: DB6PR04MB3190:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/Jy7RmpXFIoVeB8pum6GWFi2pM2Op2GnCJOHxh1VhQ1fybIdn040SMUhC2PTPSozeHs7LBToMWYBCyhdzDgLuFXT+/H1at4oiBUBe9K4FYtrT8mNtYLPgGIpYcDLGxOg/9LWXsLQU7NywcKcDZuxzurpgyCcXCx4eCobNbnw3b/kk3+/F6Ukg39ndlxKQ0d/1pmQwmQthuqpx89ePFVzmdfDyiiXKJm+IISru8NKKvWezaYBNdILITPjz+7iB+7+KL7QWjKj6jrcQFREpgHbWFtBPyaK6+DMEmacOVTUA+l6JpGc4ZakVYKm1iuHVztApGLizO90QpMcZo8HT5LyNQ0OetE37CCXnnr2s36DmrIO1r9989gKmALp0cB34kN4So2vXGG1uJMY3LeffwyjPEgeznK7DxaMLxIDcxolW1L8LxkXiEhg2bYpfSvKRgzR8A5V5+jpeLFB68nJhxlBi0lixvIDm/TskzaeFYqwNhOexmFdsiVG2z3fHZbjWhjkg9N8WYieequy6zkGx7Nb+c/9C4nD1TRg0kc/mWTof9Nr8OPM5B7F2chBmTBdAPbWOj07O28aAsPRq6o58atqhy+c04jCwsTl1rzP6ki093iBxuKyNjHfolRbs8hf5LuK5vH6xb7VZ6+tf9mW19oWJEA43O/3kMP2OIuHYuJlA1efIGw4XilAqqBQIMk6vGWv17lxwCI84THwOxXXzoN4HZIFC7iqMPGFo4s0EgmGDcliaWSHOcGyQw0bGJtWiuDpLlNalp74I8oA8FOxtIVEWyOwYmtUMPqDvTcNg08hI+JA6OMt57lQvBaaCnwjZT7xz5dcBjl1BPyy+YK/dl+fRgt/exLftklZzm+E0sGXsqpHk86GVxqdqxNRbF2O6v5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(26005)(6512007)(186003)(2616005)(52116002)(38100700002)(1076003)(6486002)(966005)(38350700002)(6506007)(6666004)(478600001)(83380400001)(41300700001)(8936002)(44832011)(5660300002)(36756003)(316002)(54906003)(86362001)(6916009)(66946007)(2906002)(66556008)(66476007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uhU7HO7XOSrNVdbQbe6xmTQHsYjZTf4vy1e8H6Oz2Ji7bLxZWwmjF7yWEprK?=
 =?us-ascii?Q?cz4BWuPdbWwwfJHf6sW9HIOJp26hWPuca/AP5pW7WRLDUpC+0//UeDGck/Rz?=
 =?us-ascii?Q?UWn9ezFobG9SMLnKHGBAmKFhZ4bECtKlWIkb0W10ZbHDOtzki0BjM5VcnD01?=
 =?us-ascii?Q?ThG/M7CDkktWKBgXTv0Khjhg/njzQ6dVzalc6VoBstgfUua+/NAim5ZOslII?=
 =?us-ascii?Q?qoxMpCp3SBt+TNaQi2ldlOVsNQIA/aX4T65RmSZ4IowSXbdZkXK9ONRqovbj?=
 =?us-ascii?Q?SOH1M+aWSN9kM/4kt7v+q1FmSN9KWwrctRs79x9Yo9R90F2nu68BFGOCfWyu?=
 =?us-ascii?Q?lH7g3gC1i4kHKgS0Ad9vShX8HM2yKGuoAOMGohu7yTCKT7UBor3xgGZhHZnM?=
 =?us-ascii?Q?AH8KlJ2qTFlnIlyvYDAtt7TGS9uVuNM2fXLO2kTR9MbK5M+MI5gM4/rm/Bm/?=
 =?us-ascii?Q?hlFyWAGY0xq0mu7Zzl27v5CHajE5aHbNpJj11Iv43sypxH1ksoZhiUPL5ond?=
 =?us-ascii?Q?xV0YvHnfKdL7O1YXgx2K8MTf+CR7njrW+5WGNdymLe3xASV0Ffcb+h7b4wvZ?=
 =?us-ascii?Q?pFQOrEaw7SMt0P8bduYhTZnDd/7u7fNth42boJgTwO+1FJXM9iVX8bOfsG39?=
 =?us-ascii?Q?PDHmJosCE2QmrF0aOizD7792Cs3BL5+v3nF028a6XSiHZZNttbsMxDB6/rIh?=
 =?us-ascii?Q?IwEX8yoVf4DgC7wHZt90tjdCy4hPSevfx375ewqmRnQzi9SgrcMVBcwwqp69?=
 =?us-ascii?Q?BjKDNE46seCc1PDJDqD1oJmhGtVqg7bucywIUl6zhC5VAqeBg/+SPVo20MXE?=
 =?us-ascii?Q?0RwHReMqn9Uf6yMgajiM/yebx5qC+CdsWNykKFjWyTjRHe9zPO15nOpAHPhw?=
 =?us-ascii?Q?jXBVjT9K0dhL58Iey5o4mdqxjDB+14agIA4Xx4mrT7HpDEh/5wz5L6jI95ny?=
 =?us-ascii?Q?OPzlTeXS/yfGCgKFnIG5+t8tAb1R+U33wm/d0QFAGB7kVeosEWojKasHiwq0?=
 =?us-ascii?Q?hT4sdNq0ise1/9Umvxf/1wKbO0znQj/BL0Dt0oeJFkpR2PHexcDFw7d/YGKY?=
 =?us-ascii?Q?MY9V5JMgxZLw/VvK3URdeDqTTWLOqeuUo7x0fwHRLLl5yBdC3EPiOk8R2T8a?=
 =?us-ascii?Q?okuVYFZKxojCvvvENTjSW5BOJDl/Fot8ExDpXY5sgeWWSckUyiZbijnvkfOK?=
 =?us-ascii?Q?b4qcvhIlNGfLCqU+Mn9FUBb5bTgwNZgPieZYWwH5a7zIvEprabAXO9qwob7X?=
 =?us-ascii?Q?X/STsCMyf0xPac5fZzu9Rxh5E/cinkyltwdAQeGKKUK/hZ6/R6/FMopf6SjT?=
 =?us-ascii?Q?xmsT5APcqgNjrKrSf3eSiOKc4UTjevob6KSOc0ykvCgRd6PmgxTZH36TYBtl?=
 =?us-ascii?Q?qe1l5yMCshmqz3SdNAVRtVqXk/DD5TFO616BOaQw5WB2e+RtOjfEmsP+BDCr?=
 =?us-ascii?Q?hW0kx5pDMLNGqZ4w6DX8m9eapX0+quD2CWYFB613hMmT5DXDTQFvwMYlffNJ?=
 =?us-ascii?Q?/eQzPkQc2KKzXmdoHWWAItN6VrMyshfC5ZTmPXz61RiB/0Q/juHGuNfT95Fs?=
 =?us-ascii?Q?8bjxp0tAygY1gRmvuai682iuqBdJ6dNrKxd0PtvW4f66rFNIxWuO4/rgE5G7?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12006a96-c5ba-40a1-7b70-08da6fea656f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 16:09:34.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4mjHzRYfhSBjaI9Tg1dWqrbNuQ46p2MR3pnLlYJ6r9g8UCKizlhXZl514q+Tl70SvGiASCfd8rGuV2GOLkThA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3190
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

For extra reviewer convenience, the ls-extirq appears in the following
SoC device trees:
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi#L289
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi#L249
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi#L319
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi#L325
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi#L682
https://elixir.bootlin.com/linux/v5.18.13/source/arch/arm/boot/dts/ls1021a.dtsi#L182

Patch tested on LX2160A and LS1021A.

 drivers/irqchip/irq-ls-extirq.c | 91 ++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 853b3972dbe7..cfbbe5959c8e 100644
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
@@ -16,19 +15,40 @@
 #define LS1021A_SCFGREVCR 0x200
 
 struct ls_extirq_data {
-	struct regmap		*syscon;
-	u32			intpcr;
+	void __iomem		*intpcr;
+	u32			(*read)(void __iomem *addr);
+	void			(*write)(void __iomem *addr, u32 val);
 	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
 };
 
+static u32 ls_extirq_read_be(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static u32 ls_extirq_read(void __iomem *addr)
+{
+	return ioread32(addr);
+}
+
+static void ls_extirq_write_be(void __iomem *addr, u32 val)
+{
+	iowrite32be(val, addr);
+}
+
+static void ls_extirq_write(void __iomem *addr, u32 val)
+{
+	iowrite32(val, addr);
+}
+
 static int
 ls_extirq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct ls_extirq_data *priv = data->chip_data;
 	irq_hw_number_t hwirq = data->hwirq;
-	u32 value, mask;
+	u32 intpcr, value, mask;
 
 	if (priv->is_ls1021a_or_ls1043a)
 		mask = 1U << (31 - hwirq);
@@ -51,7 +71,11 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
+
+	intpcr = priv->read(priv->intpcr);
+	intpcr &= ~mask;
+	intpcr |= value;
+	priv->write(priv->intpcr, intpcr);
 
 	return irq_chip_set_type_parent(data, type);
 }
@@ -143,7 +167,6 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 static int __init
 ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 {
-
 	struct irq_domain *domain, *parent_domain;
 	struct ls_extirq_data *priv;
 	int ret;
@@ -151,40 +174,58 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
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
+	}
+
+	if (of_device_is_big_endian(parent)) {
+		priv->read = ls_extirq_read_be;
+		priv->write = ls_extirq_write_be;
+	} else {
+		priv->read = ls_extirq_read;
+		priv->write = ls_extirq_write;
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
+	iounmap(priv->intpcr);
+err_iomap:
+	kfree(priv);
+err_alloc_priv:
+err_irq_find_host:
 	return ret;
 }
 
-- 
2.34.1

