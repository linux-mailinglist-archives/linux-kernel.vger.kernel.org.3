Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB457727E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGPXiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGPXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:38:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614ED17E3A;
        Sat, 16 Jul 2022 16:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koSTa4JbgepLKVnfta6+W3lmHzrFV6D+Cf0Sv75zYAVcdZKOvsfNzM40usINL34d1yNx5TN5vxUJqNT+HZA+ewCD0WmRR1uVV17JjSv4lksGlmIFqGRpgrmwBPnEOr7X4EOQcUZJCsJELyQaElJrkZ5KQzPRgyv8Gco2wLm2+qAc9mNdMlR/iel260nxC41b6CJrRCeGhhgpv6vhypSR5+DtY9iz3fS1BdxiH938JiEOtaNK2pGGfjIarUS0LFRqKYkaxjTN+cMD0mZtFVRTqEybviHlCLnRyUQMUtLEE7oGq4RnNwY0soqUmIvvBRTXQU8SxhMCPFQnNDuv8Nneng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZHUSO9v7r/OYFD+iCVxP1N9ucYe3epBLm8ErRdo4lY=;
 b=eu1KaPu/cvXbSHpDzs8OowHbdZqw9Cmz0h7yHgL3CXb5tye+hzgzYWXGhQTU5v0fc6jdPW8TIOo1DgRhWfOkRVzEOXXgFbDuPkkstOmZDh0blY2iwDE8a3N8Hc7l9G7Q7G2KPWSb/cjvFaZHroE6D1rCaJ69psYU3mDg4Yy07DmJP+OXaGjq4qUIg8fxP/g/yyHOaJqyQMaeHSb2b+UF5M8jompjEknPZf9PXNgU9OLUnnsW8wbXSSc/yyTaumfXKHnYQA98nd0YX0UFKmhLIH7MC7hd22WTXy6G/p2+TxUD8QCg01eQFv/Kt2a1ZFrHyPgdku/5CrDEUrUhHn5Gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZHUSO9v7r/OYFD+iCVxP1N9ucYe3epBLm8ErRdo4lY=;
 b=OQdAaweM/wVBgHQM0MQ65q4rpralQYI+nfSi1MKsxG828XUvgLcO/+OYIQVXy1qB46I7xpG9cxlaPtRqAoCrm9/qXTyJcO1xK+CfZcX9vdle492O//95HDjpm1ic2aGiqd58pVXNg1Y6gvIxBU0UwEjs149G8aTjnzK/myn6AmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB3997.eurprd04.prod.outlook.com (2603:10a6:803:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sat, 16 Jul
 2022 23:38:12 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 23:38:12 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 1/2] pinctrl: armada-37xx: make irq_lock a raw spinlock to avoid invalid wait context
Date:   Sun, 17 Jul 2022 02:37:44 +0300
Message-Id: <20220716233745.1704677-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 01cd95de-de2b-474f-38a4-08da67843f83
X-MS-TrafficTypeDiagnostic: VI1PR04MB3997:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6Urs9InASVAVDms4pE0TMEolflFYvSqDTnnWCOsN0qvYtSkkYQreIqB/BDIsT9DarWUoFT3wlYDnZh1x06+cvzyYevY4e6BpcqYhqa1MQcpnc3ZtfmKUpgTgG/62hWEl+e/yb7YAoVlXVkg0n4VIhEjaVMUQqzYGNsgQGTb1IU/L9gy3R7BR3CqjP2xOo6YVxvq6qidh9OvO1KHdJ5zrjVOm2x37v18TkCu8awJXyYpseh7L98P+FAbzaCDsf1WvS59x3fQqbzHNBtx79xQqlHqTh0E/DOOmTmJ4vY2z9oalr7f4IbNMrFcw0ZE2XdfDjH/sxUbzsk++WBWCTH3/Po5z2BD8WIYai4UCrCuhq38OzKsZfc1X0WGMft1gDsjy/d1lKrnbRGXYuJaH67lgj8+810f5/ors7N9Mc75Dp6DJtR/uw14672vGg8EGwknMJh96sQjO+xxkr5B+SOyEKgc+92YQNBDWNgkjJUY1Mpr/SliTOJ99pJBTSLNwDCEeVRO57Ch8369l98jHFbVo/LgHnlutQ8wLGKML52Sgax/b1RukH/mqG4YFkMVYWyxHLaPPNi0xE5P+ASvCwx8b1OGa+VOeYBSvejnXJqq6du0nH5z896Gen7HwvzzoOdQ0h4lW8Ihmz+PuFQvax4sFvIGotYsR45XXwbbnxuehnpCZ6k1upCX1O6DoS87TwwGwpuADVebOErWBaJCSJyIQQb8bWYy385fzIvzZYEmzDxILSJgzJhGNIbblNvusW5tdCunCv0bv4QZixknAVSOWghez8PTNdatHwOJUK9gvkiU9Cw+x9/0nuNjljXmRfCg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(5660300002)(8936002)(86362001)(2906002)(44832011)(6916009)(54906003)(4326008)(36756003)(316002)(8676002)(66476007)(66946007)(66556008)(6512007)(26005)(2616005)(52116002)(6506007)(478600001)(6666004)(6486002)(41300700001)(186003)(1076003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b9gwg1w3CJuNxYyWfN+zyUldetLQPIJ4fR26VbvTsXhwxhG3I3e/DIoKebhl?=
 =?us-ascii?Q?3tFrDzW2NTcAAZox/j+D+zAVhBorjtD2HuZbgoSzx0d24dk6FbbMzoJc7pKA?=
 =?us-ascii?Q?CLxBXT3f/Gz93za2f+m54su5io6T+x7K5SLvshQjJrxfwAK/e0LrK4q2qnU5?=
 =?us-ascii?Q?5EMEW5n4nOIo3lXGvxu7ZGHl5OQyBtNxiNMLdDAPLqIOtDjt3DWlqgFdDhpy?=
 =?us-ascii?Q?mEIeXjQ9JnkoP4tXYDKHzxL/L8yIpHHPdgcI5FmUky1vpjPoSPe0l1F+l61E?=
 =?us-ascii?Q?UcrujRaoTtI8lfJhggX/7C1YKAIywMPQUUVoBZvsSDPijIAQP6kb6VPPS9dl?=
 =?us-ascii?Q?hTix1wsyyI0+C7/G2ykyqzOZ1PM+hsIjr9qcxWSx5flq+DtQyvtLZ3KTaevl?=
 =?us-ascii?Q?ibjLlrjlIDvENSveqnEjKsu9CIx2wkQmKctCFBFMR0qGZr8oaHXogoEMqd3m?=
 =?us-ascii?Q?8OFKR5scdd4/9SlcUSjtCGnZMR7kssyggN5tut6bJEek77vDtt5Qgb+D5Hgo?=
 =?us-ascii?Q?kFU/it5Etq7dJkt/fPXwsfvBowHfgjctO78frAIeBYd56f+OMk2uQTIFHAPL?=
 =?us-ascii?Q?IpBwoBb+B7wjs3stHYkBh5nV/l7c6u8waIFsAHR5gjWNvfAo8RCBvtZ/prVY?=
 =?us-ascii?Q?AYE/t4tD5e6KejyMN9EP/GtEMDDsus5hMGCzx/7UYOAWjCbEjH1PRdMjCfNS?=
 =?us-ascii?Q?MqUgVAXyWEosVcv1SgrdmrgZu5HJ8PK6hi1skDtTPr6iAPI2HHexAY68pR+D?=
 =?us-ascii?Q?1NcqfVqCLnkMv21BkVBMQQOT6Dia1xcxkMIfvY4KBYFVhExVy9HgD76sXAGu?=
 =?us-ascii?Q?eP9yQMTXiO0HlgWy1C7imEW247WGdoCHIqeqWIxGMJKRUvgiXxxVnq6lN8PK?=
 =?us-ascii?Q?Z0+zXmvyWoV/PMox2SzPxYu4uIC3mR0TPuyNRHLr3BNKSJXrcKWmUOHwL9wq?=
 =?us-ascii?Q?KPxdtKtRTseJYDDc1EC7JOsBKQGIsBMOILrCnVksJtDlHqiAyaS5yrm7+S8E?=
 =?us-ascii?Q?+kG+2L7ZH3ZLon8MmAch55sRKFezaRz2oN8ISt1HHQRh8H4TMpDc6nifCgKr?=
 =?us-ascii?Q?RPUy+jp9RfmKftI732rVXrjRddb7yW7Q4ENFbmNd1VykZXSI/+MCa/SftQw2?=
 =?us-ascii?Q?bdGsg+mbnmFJ6XTBnLi+/BONkp81vrvbQcO6K+jUt0ojTvGGddA6cwldpuq7?=
 =?us-ascii?Q?uQqXtoo9X7iRxysuAxNtSHp7dVVHL78Ncrx8HL5CD8M6t+D4PVhaEdkE14xe?=
 =?us-ascii?Q?EzAy0OTayM/SWQF5+6+Ybo7ZmHzTtwX4CCXYyBbammMTYh6fgnWELogklGPa?=
 =?us-ascii?Q?G0h+xpW8EkA5OV3zIoq4DMJGG23Wme4IPKXim2PudWLN1LankGoBob5VvjH3?=
 =?us-ascii?Q?M7u1eyzx3v1VPJsyZkH3t7DQDPaGijumAcSsJ/m1fWhQtaqHPupsZIoC3T9x?=
 =?us-ascii?Q?a7KtVAq2WD9m2irVuuTPjYeOnvl1TQsNqSlQp50XXIACmlmMS6KuuzgpPMjC?=
 =?us-ascii?Q?FtQ9w8KKkXhSfHSDtOjQiAGkWYE0n2UT7aGSo/PaF16aRD5aj2ijkwlBmon7?=
 =?us-ascii?Q?VBjB/gV5M72x+RDQmjRc4VYvOtkIcmH9bDLN+CY29FYzIBLC2GcDKX4QlSGn?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cd95de-de2b-474f-38a4-08da67843f83
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 23:38:12.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKGqncZgILZ4kbb00KFZ4B368mOElVjKgR3v6ojUlZGveNDEtkkTBBh9+y3GPU91Iq/6zJExQckcCfBMM+Er9g==
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

The armada-37xx implementation, armada_37xx_irq_set_type(), takes a
plain spinlock, the kind that becomes sleepable on RT.

Therefore, this is an invalid locking scheme for which we get a kernel
splat stating just that ("[ BUG: Invalid wait context ]"), because the
context in which the plain spinlock may sleep is atomic due to the raw
spinlock. We need to go raw spinlocks all the way.

Replace the driver's irq_lock with a raw spinlock, to disable preemption
even on RT.

Fixes: 2f227605394b ("pinctrl: armada-37xx: Add irqchip support")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 38 ++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index a140b6bfbfaa..8fddc67271b4 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -102,7 +102,7 @@ struct armada_37xx_pinctrl {
 	struct device			*dev;
 	struct gpio_chip		gpio_chip;
 	struct irq_chip			irq_chip;
-	spinlock_t			irq_lock;
+	raw_spinlock_t			irq_lock;
 	struct pinctrl_desc		pctl;
 	struct pinctrl_dev		*pctl_dev;
 	struct armada_37xx_pin_group	*groups;
@@ -523,9 +523,9 @@ static void armada_37xx_irq_ack(struct irq_data *d)
 	unsigned long flags;
 
 	armada_37xx_irq_update_reg(&reg, d);
-	spin_lock_irqsave(&info->irq_lock, flags);
+	raw_spin_lock_irqsave(&info->irq_lock, flags);
 	writel(d->mask, info->base + reg);
-	spin_unlock_irqrestore(&info->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 }
 
 static void armada_37xx_irq_mask(struct irq_data *d)
@@ -536,10 +536,10 @@ static void armada_37xx_irq_mask(struct irq_data *d)
 	unsigned long flags;
 
 	armada_37xx_irq_update_reg(&reg, d);
-	spin_lock_irqsave(&info->irq_lock, flags);
+	raw_spin_lock_irqsave(&info->irq_lock, flags);
 	val = readl(info->base + reg);
 	writel(val & ~d->mask, info->base + reg);
-	spin_unlock_irqrestore(&info->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 }
 
 static void armada_37xx_irq_unmask(struct irq_data *d)
@@ -550,10 +550,10 @@ static void armada_37xx_irq_unmask(struct irq_data *d)
 	unsigned long flags;
 
 	armada_37xx_irq_update_reg(&reg, d);
-	spin_lock_irqsave(&info->irq_lock, flags);
+	raw_spin_lock_irqsave(&info->irq_lock, flags);
 	val = readl(info->base + reg);
 	writel(val | d->mask, info->base + reg);
-	spin_unlock_irqrestore(&info->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 }
 
 static int armada_37xx_irq_set_wake(struct irq_data *d, unsigned int on)
@@ -564,14 +564,14 @@ static int armada_37xx_irq_set_wake(struct irq_data *d, unsigned int on)
 	unsigned long flags;
 
 	armada_37xx_irq_update_reg(&reg, d);
-	spin_lock_irqsave(&info->irq_lock, flags);
+	raw_spin_lock_irqsave(&info->irq_lock, flags);
 	val = readl(info->base + reg);
 	if (on)
 		val |= (BIT(d->hwirq % GPIO_PER_REG));
 	else
 		val &= ~(BIT(d->hwirq % GPIO_PER_REG));
 	writel(val, info->base + reg);
-	spin_unlock_irqrestore(&info->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 
 	return 0;
 }
@@ -583,7 +583,7 @@ static int armada_37xx_irq_set_type(struct irq_data *d, unsigned int type)
 	u32 val, reg = IRQ_POL;
 	unsigned long flags;
 
-	spin_lock_irqsave(&info->irq_lock, flags);
+	raw_spin_lock_irqsave(&info->irq_lock, flags);
 	armada_37xx_irq_update_reg(&reg, d);
 	val = readl(info->base + reg);
 	switch (type) {
@@ -607,11 +607,11 @@ static int armada_37xx_irq_set_type(struct irq_data *d, unsigned int type)
 		break;
 	}
 	default:
-		spin_unlock_irqrestore(&info->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 		return -EINVAL;
 	}
 	writel(val, info->base + reg);
-	spin_unlock_irqrestore(&info->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 
 	return 0;
 }
@@ -626,7 +626,7 @@ static int armada_37xx_edge_both_irq_swap_pol(struct armada_37xx_pinctrl *info,
 
 	regmap_read(info->regmap, INPUT_VAL + 4*reg_idx, &l);
 
-	spin_lock_irqsave(&info->irq_lock, flags);
+	raw_spin_lock_irqsave(&info->irq_lock, flags);
 	p = readl(info->base + IRQ_POL + 4 * reg_idx);
 	if ((p ^ l) & (1 << bit_num)) {
 		/*
@@ -647,7 +647,7 @@ static int armada_37xx_edge_both_irq_swap_pol(struct armada_37xx_pinctrl *info,
 		ret = -1;
 	}
 
-	spin_unlock_irqrestore(&info->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 	return ret;
 }
 
@@ -664,11 +664,11 @@ static void armada_37xx_irq_handler(struct irq_desc *desc)
 		u32 status;
 		unsigned long flags;
 
-		spin_lock_irqsave(&info->irq_lock, flags);
+		raw_spin_lock_irqsave(&info->irq_lock, flags);
 		status = readl_relaxed(info->base + IRQ_STATUS + 4 * i);
 		/* Manage only the interrupt that was enabled */
 		status &= readl_relaxed(info->base + IRQ_EN + 4 * i);
-		spin_unlock_irqrestore(&info->irq_lock, flags);
+		raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 		while (status) {
 			u32 hwirq = ffs(status) - 1;
 			u32 virq = irq_find_mapping(d, hwirq +
@@ -695,12 +695,12 @@ static void armada_37xx_irq_handler(struct irq_desc *desc)
 
 update_status:
 			/* Update status in case a new IRQ appears */
-			spin_lock_irqsave(&info->irq_lock, flags);
+			raw_spin_lock_irqsave(&info->irq_lock, flags);
 			status = readl_relaxed(info->base +
 					       IRQ_STATUS + 4 * i);
 			/* Manage only the interrupt that was enabled */
 			status &= readl_relaxed(info->base + IRQ_EN + 4 * i);
-			spin_unlock_irqrestore(&info->irq_lock, flags);
+			raw_spin_unlock_irqrestore(&info->irq_lock, flags);
 		}
 	}
 	chained_irq_exit(chip, desc);
@@ -731,7 +731,7 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	unsigned int i, nr_irq_parent;
 
-	spin_lock_init(&info->irq_lock);
+	raw_spin_lock_init(&info->irq_lock);
 
 	nr_irq_parent = of_irq_count(np);
 	if (!nr_irq_parent) {
-- 
2.34.1

