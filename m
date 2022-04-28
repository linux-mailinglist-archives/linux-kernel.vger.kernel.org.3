Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71994513B55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350945AbiD1SVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350922AbiD1SUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7216A02D;
        Thu, 28 Apr 2022 11:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9isLFzkl2t20A8LUMzo9BncFZDE4OiyKtF8j8FBbNmg1TYrCpziEmV9VIjPrYGfdz3VuiQHLaVh25Tsf5TEqCHYZuwCcYy0ZdeVbKm+q6P1mva4D1h+Mhh+G7363dd0JMTJFyyxDmcxfY9GmWE8UXTgKnIiXK8s/pKLY3XaHFP24MWXTJmJa01+9YPiSp8WE/5PggqgvHM4vSUh88X0nQIUkwyqj8Lea2mM89f+R/y2w1keXiXCgqP1ylEeMI7XdKXIfHDU5s2o6jSjAcwCzRJKxdS14HZRmepJTZ8wQbfvuSoTbdzNV8rSPm5pqbt7DozNhv6KtaP2KEls+Lg7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3ohv2uuhuUknQyZb3MQy4p0AuXKGDiBPO+j5olRxSc=;
 b=MCrDfYm55BrtTGfyB3n2mMYgQY/iG683csWlyOjrMnFflzX31G7O44h/R1YXIoau0d3fynp9APJKbVSnuBTItURWGIqz8ZGMHC3tk9FjWH5E/FGAiTbRyPu5qSrc8gsYnwa7tJV0mB+7PWetKqe96M7RYOhlLiNqCD/c+Wye6yAM5yZ885R8Xwwduhf4ceywR29nt9OXdxHRpM1MdUgY/noEQcj5VWomqDdl21yXkOU6jivgkn+zm6n3nZSPpYO30p3N1P5YTv3mLz5xRfARyaUCfkuifLZ8N2CI0hNLzW6PReWpVkni9FuE1CyANuzsb520FhN7UXkJnmN8CuZDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3ohv2uuhuUknQyZb3MQy4p0AuXKGDiBPO+j5olRxSc=;
 b=gfNj56EG6QpPecgcE4IF/j7o/9PM98wQDYWIWvWMQ6+XloMqF3QcgJ5Y3RLjga9gvQfvZ2ux6odUwOIIATps55uLRHkEmlOd9b6X8IDX6D5N7o0FDZ5zGS6Oz3SB22E0zAnBTYUHCo4GRSYO2XRTdVT6JmRXIqqfESl0D3vS8iaX5xuq7i2EmZ/rVQ1xJG0TOH6BSDhZLi+rNhNir5jPz5duhvPuVKb/hEfEeh5Brz4wxQ5g4ngj6I2yfgZBMgiIGmjdX951GQlT/jxvk87l67ssGhiEpDpXv4pchRMsC2ZJ9otNHeQVUrNbDB3N2H2bcNgzMnTNn9hMOF9GAUc3tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:27 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:27 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 8/9] nvmem: sfp: Use regmap
Date:   Thu, 28 Apr 2022 14:17:02 -0400
Message-Id: <20220428181703.2194171-9-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f8ee82-f958-44e1-7607-08da29435a17
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB6775B1598BFB3362FBC7F18896FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2SX8g1Oip1pPYUejqc5IRIollbcYbHOjo9ithZkp8fpLcL/6yijjCsOHQ74xaa1WeKeMEEIYY36OyuqYpy9n2TXQ5Wb90WEzbKl+fSng9MaX75A0mvT7Gkbk6dJ8fd24srh9D89RsLRT65f8BQVhCfe3xUt1PPZe2NQuHp9JgR7JExPP688NJ8Hhu1dY/qD85Zdk2ZeUXfncY1haaaZ3usBoshP8yNQHzDrkZwjqofdyEDiU2SkQO9XBc/6mwcjdeZ5FJPhZzGfCTpu8tgUKvKWz9KNoApRDgDOO161ZujLNnHNK0HpwjlvupQI3PeDkahRzEFtJF+G+0nKPeKFizPenfEOOzdPSScClFkN/O+EMhsQDJ9SpFObZnvm9cYaQeby2FmURvoh+kbAbfSN3HfnnWUXm35b2oi3+Jwpg4KK6BJfUJuoeyGg1vJcuruHRUhtbV6/opWooNrAGCvcgs0+WieAIbRoxSkcRbU7M5PDpXKv5RknMY3HSqFf5y1gUpz86gGtQ+ufILJhophKu1hquCU/wRLQL4HZ/qtkNkjp1TzFV2Nv4P8DtCoRlyj4w6T2lYgfdIHmx31NRobnv730sT7oipfN5tz5L2GTjmvn054LI7aymR8yx/4aI8NLaNjAoS7WG7x1hdkIRanl4CsnTlgxRDC1GkVA4un+foVCK7cGVALplaVP1cx/iyBzJiI+Ko0dB6uiacSxPMUkQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RKeHc8vtkbUx4xd4JuvyugXWJ9W66stfgiOOl0PkHh+40WG2dPEq5j3jHSZ7?=
 =?us-ascii?Q?arqcjq4ZsxNPXEw5P9dMe12kEeNGUhZT9e6zLkflJITkmuGDeLucrlxDrr+Y?=
 =?us-ascii?Q?AOsfY23iBF5FZHNXgbMQ0+o+mutX2DDgiGldefSGd5kWbSg5o3ItM1KybPkt?=
 =?us-ascii?Q?F2e7CXGtsfGAGCibEhC/7U1jQ1x2Z1XvNLQdYSppxEWZ4lUs604e6xdFyc9U?=
 =?us-ascii?Q?Se5Bb1W8TztwmIgy0GQUbDAkFQtrQL2ELxqPphbe26LWKvTmIDzOCwaPyfc3?=
 =?us-ascii?Q?8dX5Vb2bC8ePgfQhZpc4FFloSTq7VtW2Rhmy5iz2s7E+6cQYIkbERrY9KPYA?=
 =?us-ascii?Q?Tvj3HG2a+YasQ2PGhCnRXRKcAj+Qtb50UyDukm+PP25chjsY9eRkht0GYfxi?=
 =?us-ascii?Q?RHNrayLJGPIg2VJyJv+cBkYvPHuDgXLaH/O34NlkJ8XXQ688akGcWKfiDniG?=
 =?us-ascii?Q?ZzLAUsMPtE63C5FnmHNdQzYqEnv/74bSH2gAsLaMQtqnaX1M9el7zGRAXC2H?=
 =?us-ascii?Q?a4eXycUih/5aavHeZ/Ilc/eqCTnn/pU5Zl4b5YSWr2jDBBwxrFY/WS3hbWpJ?=
 =?us-ascii?Q?YrhtEwigaNAWMEhxRJXBqntTCKG2Xf7UdwYRhQ+CSqJYdSz6N555Ym0SGyLo?=
 =?us-ascii?Q?c5XTuSs907TY0HoLk7F/4UFmETURVgc76/oTfPIQgYX+OOA8CpcazJ1L7Qq2?=
 =?us-ascii?Q?jjkB9nf5FmJZoRGkO7hocp/F3pE30O2ac7/yOsOLyc1lV43gkpCzA2OI8J2S?=
 =?us-ascii?Q?i1hNAwmLIF+jFa0BgxVwsG77xIxrC31EPHsskGglGY6NIeGobAEPJjc1I+i7?=
 =?us-ascii?Q?FL0zleW89st60aFlKlLSQ7HAD2hSMibNaEml7bW0nk/ObYpoFAnfZHW0c0IV?=
 =?us-ascii?Q?hFNxM+EiY0GpqtmTAK0wD+EUW77yRIZnjLgp3yD9O7m9Zt0bPVsHom8600WU?=
 =?us-ascii?Q?cEB+5E4n49zbtVxPhtYax5R4BjX6d+0DqoR642ujE1ECSO7S9qnS8hW/yLWz?=
 =?us-ascii?Q?HMcYkxkLgmBvHo7TiH+wDA15pq6err0vzDbcLrAr5zHidWNW0lEl8Y2G0aLR?=
 =?us-ascii?Q?4XrkAUpSPmIYOKF7ki0zHbILkL7Rn7laAflOJSZucxbKfr/SNUTGDi2eHxsd?=
 =?us-ascii?Q?we7FjgyzGGOx0NH3zRlY6zNrMoOr3znI8CyFaxEbw1zMBsVja66rBN68mMfo?=
 =?us-ascii?Q?W4zsBhaOjXb2LsMZ6ITGeYa/Es292CaCZSoPwu+4rLsnzY7BwzEQ+GD8ucqw?=
 =?us-ascii?Q?VnkkSewasYnIqn85dh8ysdqqsMRPyp6ATvICagqYRxuH1RpYhR9ZMhyyn77e?=
 =?us-ascii?Q?Xdlok+1JePhSqwewJYFZIVvHVOkhFI6GN/SWAZY+/y5Z2JX0vLAF5jKbWzZj?=
 =?us-ascii?Q?trqgtX6Yf5YNJwnvcoZeJzkAi7wXKwZ5tbul8bfC4O7BorCYDV+JeXUjtSQ2?=
 =?us-ascii?Q?EAhgBTfBtMO9R/UGdRq/PrH8Pi2RcMnz5WLT46FtHuVC7PC7KlCjsVYDQlsA?=
 =?us-ascii?Q?kqzoQVHbmDvSRvJM17FyuF883Ku0qXwSKb7YbIxC7DQPwCfWSj3R40FJfEhJ?=
 =?us-ascii?Q?11vphGO5xQO7r/HuiRMTvMTndc25Q5P1QGe1K2CwkUOMZfnl+dRXGyhOSH6e?=
 =?us-ascii?Q?2NCkgLLfL2IGhN0Groqrh6RW4l0IxuAhCeI6/8/aQWS3nbaQqTWXZn2fDV3L?=
 =?us-ascii?Q?ER5XAmIDZ81cOmHNLk32aVpuXIxBA7ZOxQgQ6A3/hMlOLS6KC8dyl0c41QRW?=
 =?us-ascii?Q?nrtdPeCZr+cpoH3k1E9ToUKXyLDQboA=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f8ee82-f958-44e1-7607-08da29435a17
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:27.8631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcfw/Od+QwNefXlEEFgcat3yuDncRSbjHsyazeGOzQJdYO391RjmSXbJAsyi34fTQKRVCNiExkFsizTMOKHHkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the SFP driver to use regmap. This will allow easily
supporting devices with different endians. We disallow byte-level
access, as regmap_bulk_read doesn't support it (and it's unclear what
the correct result would be when we have an endianness difference).

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v2)

Changes in v2:
- New

 drivers/nvmem/Kconfig          |  1 +
 drivers/nvmem/layerscape-sfp.c | 30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 555aa77a574d..403ed5257592 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -304,6 +304,7 @@ config NVMEM_LAYERSCAPE_SFP
 	tristate "Layerscape SFP (Security Fuse Processor) support"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	help
 	  This driver provides support to read the eFuses on Freescale
 	  Layerscape SoC's. For example, the vendor provides a per part
diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index e591c1511e33..59083f048921 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -13,15 +13,17 @@
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 
 #define LAYERSCAPE_SFP_OTP_OFFSET	0x0200
 
 struct layerscape_sfp_priv {
-	void __iomem *base;
+	struct regmap *regmap;
 };
 
 struct layerscape_sfp_data {
 	int size;
+	enum regmap_endian endian;
 };
 
 static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
@@ -29,15 +31,16 @@ static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
 {
 	struct layerscape_sfp_priv *priv = context;
 
-	memcpy_fromio(val, priv->base + LAYERSCAPE_SFP_OTP_OFFSET + offset,
-		      bytes);
-
-	return 0;
+	return regmap_bulk_read(priv->regmap,
+				LAYERSCAPE_SFP_OTP_OFFSET + offset, val,
+				bytes / 4);
 }
 
 static struct nvmem_config layerscape_sfp_nvmem_config = {
 	.name = "fsl-sfp",
 	.reg_read = layerscape_sfp_read,
+	.word_size = 4,
+	.stride = 4,
 };
 
 static int layerscape_sfp_probe(struct platform_device *pdev)
@@ -45,16 +48,26 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 	const struct layerscape_sfp_data *data;
 	struct layerscape_sfp_priv *priv;
 	struct nvmem_device *nvmem;
+	struct regmap_config config = { 0 };
+	void __iomem *base;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	data = device_get_match_data(&pdev->dev);
+	config.reg_bits = 32;
+	config.reg_stride = 4;
+	config.val_bits = 32;
+	config.val_format_endian = data->endian;
+	config.max_register = LAYERSCAPE_SFP_OTP_OFFSET + data->size - 4;
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base, &config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
 
 	layerscape_sfp_nvmem_config.size = data->size;
 	layerscape_sfp_nvmem_config.dev = &pdev->dev;
@@ -67,6 +80,7 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 
 static const struct layerscape_sfp_data ls1028a_data = {
 	.size = 0x88,
+	.endian = REGMAP_ENDIAN_LITTLE,
 };
 
 static const struct of_device_id layerscape_sfp_dt_ids[] = {
-- 
2.35.1.1320.gc452695387.dirty

