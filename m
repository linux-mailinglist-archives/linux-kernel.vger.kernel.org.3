Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1157727F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiGPXiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiGPXiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:38:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64F717A84;
        Sat, 16 Jul 2022 16:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdOKOTJx4jl5mFZdIeKeoMnxVPSUxpH0aY471jK3rPyZm4OWE44911wqNt0jYPEB65mixCGFwXZvSx/s7i9FhlebujHUUz++aLxC33fGGGmPNQjEL6t+MoN0R1PuEJx/xMs90g++TvLLeOZt8JJOWwOxtaiY0CmZBKBJs0pI0G/w7b/iBQloEOc1fvX9CXRJz2E4mbCsGQrM2OWjckQpb5d8KY8W13hfSinCXwF4a7F/LbL5mLareGM3rlPhBQq5YX/y91L7pDTaB6W/p8ZLEwMeaqb1/K7A8ZzvU+UuOov0rtkbkGEd3p39x8mpjsVaSogNvxVESNOaysiKJ3GWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHBxT/wIuRVuWnNYKi1wE+p3yqUtT92JgyPs6X8RO3A=;
 b=fQrShwsuxhVKYRVye9XttYkBB1eK2XsIAJ76NZHthi5odBuMmhUKubLkGd426s7MyW116nvBVAt06F/DFzxTx3Vnw7kNO4Jh+JYBxY9NhQ8jvt7wh3nzziQqAWk4X/fljafEec/vo+y1+Xvt1UDONWFB/wJBtoxqZKRnR4cdq/jviEzlOKuaqVCTU2Qx4eatttHlAzq+T1oUIBWVzNdmKtwZDpQVzfZIkttRuD7E0ElKQlouFMwyDkJhUKCnyDHDhsj2sIvOzpZqxvyYFdegtBJAW7CSlGyf30rhq01qDcCqErdbQALMbyY0I9HtFXZmD88voJUaO0bti4uc0kIjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHBxT/wIuRVuWnNYKi1wE+p3yqUtT92JgyPs6X8RO3A=;
 b=O60GX/Yvhjh7rqcRuacfR0JKFNaC7sEdbLAq5EhGuQjHSm9Yyow3wdr3VP+OY/ijBjDe39xMSTKBx1LxyTDyBi7+3ykJ60/HbZ365eAMX0SAi9hTTC//jgzGTrC2fb2XZ8PU6Dq6vUbtIkhoSODBKcgkeZoVKNTPo/ywZcS2DqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB3997.eurprd04.prod.outlook.com (2603:10a6:803:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sat, 16 Jul
 2022 23:38:13 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 23:38:13 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 2/2] pinctrl: armada-37xx: use raw spinlocks for regmap to avoid invalid wait context
Date:   Sun, 17 Jul 2022 02:37:45 +0300
Message-Id: <20220716233745.1704677-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220716233745.1704677-1-vladimir.oltean@nxp.com>
References: <20220716233745.1704677-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::13) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f66e11c9-b796-49e8-438a-08da67844012
X-MS-TrafficTypeDiagnostic: VI1PR04MB3997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIaBNXo+RdlinwFnTO4aRtBJCS2IQKJO5dQhcLwqWm/LfQ/sG2d5fK1yBCWAtHC9UoehWVNZp782zcEzpJR1OJIRQDdO69F47G1I0f/i2jcgGZRs6b3/Tk6uh2uXJQIqS6QfzE3TRVzFqGw4CA2/R53BsoKIPrfhZnvFbD0/4iW1eMyvn/m4xoacdestfTXJO7UdNgxGvmELMXwqXdrcYKjEHu5UdeUwsoQREZsFzgSSE/te2w6CPFF4TzhpnBvTFU2IJQNznsKruK+K8vlYg9iamFohyH8SPAeItGIelgQmngNO/MVrPRg/19R5ezs/m8P/QZ/CLRwV/IlIanLXYUYFkapQ9VLzppp51wdPdWxU5DJIuamWF9vGJ6bbRpm5xzyaBJFCeWNyVFQW1/oGtG3KSh6Gc4/btPvjy7/cCUcGDK1+JNWLml1RBx2VbWmJ141FGbQgRwGNt+jj5Dy3ijD0WCjaZ0q6falFURP07jBQsUSh1SAWk/JyahQigroFHQMpNn+x85P3Jcy7AuytO0bpECVgUgCIDHjCfYRLVeLBKPSvfF04D8tQOpzF/B1wSxY1YItNI9IJC/DpA161onvnzS+S3dP5ZJ8pKFq3OuegN7hWtlyTY4prgRthpP0Q3TewHG4oiOm9Huz65l9CJUM+8AWDGltz7jldDN3e4XlPGy+aPRsR4+7cCPZc9EChDKG6OG7SGQ9koGKS1ykfWTbFZVvuazKD/n6MfAEGc7igDLzr8V/acTvl9dmWN+wRaw7Np/sWuB84rcPoaDl6o/ZH8Q6Rz7ggKKfYL1nW0ucI9iUSDbfrOqbLH3tLPqxt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(5660300002)(8936002)(86362001)(2906002)(44832011)(6916009)(54906003)(4326008)(36756003)(316002)(8676002)(66476007)(66946007)(66556008)(6512007)(26005)(2616005)(52116002)(6506007)(478600001)(6666004)(6486002)(41300700001)(186003)(1076003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3lpnkD0wPIAK+fLcWNezfNyKepBnekxGZyVsuHU0gv5BR/jNS/nJIXKSSivd?=
 =?us-ascii?Q?dG7uiw+nyb+4qFQWFaDJ/GbuBfFvuTsDSdrQ3i8zQI3NMiE4kGVPZMgCQDMG?=
 =?us-ascii?Q?yhJu8T/eMQdwDESV+0BW6H1UY7qEL9moWH8gd9e4pXVM6feV4zMXy9/LbgQK?=
 =?us-ascii?Q?yDKAtfUna8B/kvejpS0mthfk5DF2fEzQIwuDuMYtzCdKBLanrlnPmTBJv8tA?=
 =?us-ascii?Q?J3Per3o9X7eOVTZovja4HMof9K7JRVhsNn3GQ+ll0kTO45EKqfycpyiPC1tE?=
 =?us-ascii?Q?IatZi3sIF5yh72tKQSbeXCQg8WFVAX2mach3dEb8wRbjI6udUjw9CAcpqOfa?=
 =?us-ascii?Q?26XAQqspSGgZl7C7yyNYwwb2bEQgnlC0DfRhisMdneMmxX74FIaruk/Yb5mi?=
 =?us-ascii?Q?kRwW3q59WkcpZq2IsUQhV/wlLgSo8aUCgy//tzEpR3jXHI0q2lulR8GLfuLQ?=
 =?us-ascii?Q?zxbowg/inumuDvhGwVrF5MqBA4shLoQvawZZvbM7rsXBtyI6CbP0zNws1l8t?=
 =?us-ascii?Q?XxoX3ebcwFnL5FVqm3F7WBY9Wy4RLVfMC8vvuujH7wROotfmxifMjZw6dnOV?=
 =?us-ascii?Q?ghBIBcMxONHILW/XrkwAiKxqaGay91sHJp1pugAYWzSXbWsfBUwyiVCRyNUU?=
 =?us-ascii?Q?N4ocjZwnlze+th4utnyo7QovSn3Q/D5fLUNKXrOfIHEliOjtVuvZTCM8XwHM?=
 =?us-ascii?Q?qgTY5qxjj13VHZUeKr6P6/QxeUDp2QMiwOVaGNqOxb+Cn17UTcMFF8L9EYXB?=
 =?us-ascii?Q?7xdA7rCcyCpMt3Ab0OK491unWZy/+z4z5hdtZ2zuUvB7ZDszqszGWivrePZj?=
 =?us-ascii?Q?XlUwSxqdqX4uOBk+CNTcEtUuuVwmdsu6F56y83sE3gJNMCoj/PS2QOq+vGeu?=
 =?us-ascii?Q?+CXQYCilq/nc6CMj6d1GXUXSk665Smp3AJYGPjVcFEaqUzczaXtgaQh0T+8X?=
 =?us-ascii?Q?bFSW/kL4CFeFNiytRn++7T0qda5YeXFXVuNuSkT+g0y1ILxi35/MwQkZdX2S?=
 =?us-ascii?Q?/9yoiCAfjlhW1r9iKbB8kfCs0rao+hUqbqo3t1Pc9CSnCzaN2Hh1yCWf09cU?=
 =?us-ascii?Q?+0H7mxC+m8zIU7fBqLIPEl9c/PS2leQo2dIUMXMb2tM+MZAqXD5NfWVQ8qWH?=
 =?us-ascii?Q?ryMDJDKqP8/tVkqb2L75JwSAmzhGZzyyWlaUB5GdX8gZwDPnCBKth+x035jw?=
 =?us-ascii?Q?nRtgQ1SpEF9HHQfv49/jXrwj6wEm75fOrRNK2P4r0CTwPgaVq06yzLrb9JPW?=
 =?us-ascii?Q?wgDrXaZkOPIqR2JS8fUN/OhgJisRhSNuCcKuJY64KXyzgLcipPy61IVH0lVO?=
 =?us-ascii?Q?WVdETOGnVq251vOIL73X9t3rpj8A16mN9Id+9yYw4j8Q92B9WU7/CPiia4Dx?=
 =?us-ascii?Q?C5re3wV/s2J3M8R6Cyl9bDdApI1ucpXMWsFt3O+iz3DHwGsoI8CqKy84NxZw?=
 =?us-ascii?Q?qAT6Bk/qEkvfxaq37PTNBJBEf72VKxg0DLHjPdYCzmHJuYAfOzTeoEmraTUj?=
 =?us-ascii?Q?el1zl07DEg8pEDFbXMzqLchwN7AhNP+2cqiUFpZTRpwOeQFXpMJBw38HIq6R?=
 =?us-ascii?Q?rUoa/t2jj86RMYiw5rx8PUgckWq2z2+P7szrT6wvu/d3vmVlfrSLFZeecFkn?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66e11c9-b796-49e8-438a-08da67844012
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 23:38:13.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJjidXs8aPkbPvuhTujhDKtn73RxRM+jGB1p7ELlxzVqSIR457oCWwVJMZY6Be3PMadd3+UqbWRjNRn9bViGrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3997
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

The armada-37xx implementation, armada_37xx_irq_set_type(), uses an MMIO
regmap created by of_syscon_register(), which uses plain spinlocks
(the kind that are sleepable on RT).

Therefore, this is an invalid locking scheme for which we get a kernel
splat stating just that ("[ BUG: Invalid wait context ]"), because the
context in which the plain spinlock may sleep is atomic due to the raw
spinlock. We need to go raw spinlocks all the way.

Make this driver create its own MMIO regmap, with use_raw_spinlock=true,
and stop relying on syscon to provide it.

This patch depends on commit 67021f25d952 ("regmap: teach regmap to use
raw spinlocks if requested in the config").

Fixes: 2f227605394b ("pinctrl: armada-37xx: Add irqchip support")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 27 ++++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 8fddc67271b4..bcde042d29dc 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -1107,25 +1107,40 @@ static const struct of_device_id armada_37xx_pinctrl_of_match[] = {
 	{ },
 };
 
+static const struct regmap_config armada_37xx_pinctrl_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.use_raw_spinlock = true,
+};
+
 static int __init armada_37xx_pinctrl_probe(struct platform_device *pdev)
 {
 	struct armada_37xx_pinctrl *info;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct regmap *regmap;
+	void __iomem *base;
 	int ret;
 
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(base)) {
+		dev_err(dev, "failed to ioremap base address: %pe\n", base);
+		return PTR_ERR(base);
+	}
+
+	regmap = devm_regmap_init_mmio(dev, base,
+				       &armada_37xx_pinctrl_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to create regmap: %pe\n", regmap);
+		return PTR_ERR(regmap);
+	}
+
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
 	info->dev = dev;
-
-	regmap = syscon_node_to_regmap(np);
-	if (IS_ERR(regmap))
-		return dev_err_probe(dev, PTR_ERR(regmap), "cannot get regmap\n");
 	info->regmap = regmap;
-
 	info->data = of_device_get_match_data(dev);
 
 	ret = armada_37xx_pinctrl_register(pdev, info);
-- 
2.34.1

