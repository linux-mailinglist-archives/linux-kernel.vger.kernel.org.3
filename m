Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7678D50BAAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448953AbiDVOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448957AbiDVOzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF075C37B;
        Fri, 22 Apr 2022 07:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBv/hLbKBxSptfYF7B8wPdw0rE5z3tX4/iJo2bIyBya5p+xIctgkI1pt8rMHZoQhDgi56a56WEyFQUXFBJ2SIoRCZmmImPu9D2LH1pUTXDd3Tx62q2Vsamp276j45nytk0lMZBSfSgrJSHxd2h4jLCYbHl7bglhD5Vo7z1TfomCCa5/euELXcCV1ZJmg3h4ZZn1pKOSt4GrWVra3RKorl/aZ7MhTqw+7S1LnOSyoyPrGKZmuTQv3gilrCFg8tD6e+T6r2EwQUdyVA495h4SfMGW9hydCGTQG8Jxku1ghc2wln1HaOkMcb6GfbwshL9GzTN7Nf/ogyaqY7l36ZgWL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY+KrddlITclcy05ISnuSBCRR8YXMVd48hcCHAj4NKI=;
 b=Rhxu9ttSqCdDxPm5aQlYFty0XVHEc10FccRMyOvMu9lNIpORFtNK/lZh9qiEgfRHmdXBI82pO4ntz4gMGEJZxEga1T5xz167IObw24UuqqyoAp+l7C2F0SDIP39dtbDEUr1uD0A2evtUZpdil3zQXNpAxfEiIbsmdTN5XE+mQpubtFQfFwsOVihONutk3YU9XEhmfscvVZl9VVo4p+QookJtzcmTzy+zqXwrGKJi0pfk9B5ywedeIOuLGVaNXkUVeydwsIZndX8v/XLH5heLC8JUJlmEfdu+e8c30MUwoTFdDu0vHRGmA0HuoRXSg9cC8wMlMBiNJdmNZsZ4yoUHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY+KrddlITclcy05ISnuSBCRR8YXMVd48hcCHAj4NKI=;
 b=lqOMtYkckob8sbhyk7SCaOEjicQguW2UhrXgZ/D2U/PBKcjZQMr0sH5WOJNCt0NPhvEtqdwh/xgQLe4K4NnmxIv8J8H9gYN1jV9NXnHJvUAk3CA0VuBsMlJk0juItDYyjvm4E9PEKryeW6wW3WpCUlLmg2RoOcCaJLgyoLEZIiCyeZsv+w/rxxPrmQUKC1NYjAyF61Si6e8ks8PyvsAIb+krJHCmCcCqYD+pd9/sGGlxcQXKbgm3R3+NPxCmM9UGHkB1b9xmUZ9eNC8b0WuHEZJ8pSTuXwHQjP+RXqrbacY/+e46loxZjT3VOU3CH+/F7V8b/DMp11jXnBei2aC67w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by VE1PR03MB5213.eurprd03.prod.outlook.com (2603:10a6:802:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:11 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:11 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 8/9] nvmem: sfp: Use regmap
Date:   Fri, 22 Apr 2022 10:51:46 -0400
Message-Id: <20220422145147.2210587-9-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51b3def5-9feb-4e03-016f-08da246fae8e
X-MS-TrafficTypeDiagnostic: VE1PR03MB5213:EE_
X-Microsoft-Antispam-PRVS: <VE1PR03MB52130575A831C0A4FBC2C5DE96F79@VE1PR03MB5213.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jU60NtDlx3JAJMmT5NTiIq24KJRqBGNj5rFOE81SzXCtl1vq7W/am+oxKay2ZKOP+CAVCpM2G1ryOEe830Z1xgS82mlBwOT0Z6k9UEtHuo3SXt49x+Lr5KZrNb9bWFO9aH5fSmYSbiGTKNxiqCeI+cpHMiiYsAyzxGqDUtQKf/jpT0vpSwrwC5QlRMt7/u3l3D7LxxI4c3fvkiDOwArCNg9RLByAQH0N9MvDqAcI9vQozcUtdTg2jsqlmko/xTUN++QdcOufiYmWBYYY6YeCXFS+qKzjne6ghlxDacNf8LWsOX1t4nKwKQYRCqanXaofTob1cO3IXV0My4J+DOJSHn76FpEXO2gti9OtnY6XW+Zztyjobdw+mpYM4qbN0GkAwZR1iJ42VSXSCMpsTOs6WmT9MY87c5WIc1+iiYmhEQ3y0LU0uaNfxuyMRmzj4GPB+p2ZBsr7eUL4WoGlWVGF+NO1luqSnETaMr8X6138rSG+YPk9OlMc5/iDvM6WvHoqE+SYEU2n4JMXd+Rkg/4zf2nD/LKdNxSXCund0AGLu69m7mRm5cB6qrKTfwqREU3lcDDmSQTDXdlE8eGvbnDhyRUy6nXMZCYMhwYqZVEZmBNxjag5Kus8LWoOMkq7NlGhFjFOjhQKwd62fs46nhYzeOeMEnX2quMPPtZ65kNS3q6Jm4kLL+JyG2/PtY61g+DtMO/5n1haRi7lA2/LTtlO9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(186003)(7416002)(44832011)(508600001)(86362001)(52116002)(2906002)(6506007)(8936002)(107886003)(2616005)(6486002)(6666004)(83380400001)(36756003)(6512007)(54906003)(26005)(4326008)(38100700002)(38350700002)(66946007)(8676002)(1076003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnzRGXSrelwaj7Um4Sx469+RQisGfuabEU1hC0ArzPolzg7B6vw5G7hHRt6z?=
 =?us-ascii?Q?16sIKCEABb9k8DJOIj7OZOLEqP06KMdU/U2QeO+hFimRoB/9cqqg3RMYYEl6?=
 =?us-ascii?Q?kuFuFbvND60Nd024XgN7Zn9H/arh9U9Ptc/ZpjBnJdhg8A77f6V7CrHX2KxW?=
 =?us-ascii?Q?h9BiYaj+PwWpHDz+ZhVlwOVyjPF9X5ML5dMEALjzvEEA5i7I25IwBMVrldRu?=
 =?us-ascii?Q?n/CqYgIUePgukr6nL/bLHiARznwXxsO7n2cnsKMybkWW2Y4yA+PYEkGy5Pp3?=
 =?us-ascii?Q?ZavwBM31NZHG/J4jZj5ylPLuUOIkD0Iht+2Z6V5RIomADva/eOI96OxKjXjz?=
 =?us-ascii?Q?qKbJk9mf7mwg+/5L1Lh+nmmDB6qROccRj9tbesxvt4y2+V3860bFktus6x76?=
 =?us-ascii?Q?DDyVf/wFmlDkfJnrG6NDVcZKs6KbgFwevQRoFGC7PK1W1jHYMu7zPXTxs9R+?=
 =?us-ascii?Q?RqZCmcaWO42193p5vumFBJTqjcctOKCsGnvk3bE+604rgPrJfnm22g9AR/nD?=
 =?us-ascii?Q?oPTPczYA5KG99DbyNgf8v6DdUzK7rok3PcVTg2SOM2eMH2OmQbrsalVTXdgk?=
 =?us-ascii?Q?fidju57wYd57+UeK8iO42hMMYiLEDPZ98XZr/Pji4MvGyZkYjvhX1oaf99Ye?=
 =?us-ascii?Q?7N+3OHNEaHBoCrqHdQxUV6rfur7FGl28IYGfknAnQ+gXasoR8wLFCAYVV/d8?=
 =?us-ascii?Q?vITjVfgxvMdEsxJU0nPCto1rIxpTUipYA1u5AR29X3E1J/CLQWg8bXs79dBB?=
 =?us-ascii?Q?o4oJzdmW1c2Cn62NKL24w//RVeMFd0IIlT5U0kRbisM8mIajvOmO8H/Fme1U?=
 =?us-ascii?Q?dskIzNeCV1tg9s2xGf/UB12HQFfdruksLKKRqM5vS5uZ9ifNTkIWyZa6fu/v?=
 =?us-ascii?Q?SErSjYxN33mJ7l3iDnQ5JUrnDc9MYmfMpzxiNN2XkjxoA31gYY8R1WbTEZA/?=
 =?us-ascii?Q?fwGDrvGMTqbgFB2nXfmKZBRjFDQT8DXCCE5tThRFH+8BWUgyl/IG9FuzgsIE?=
 =?us-ascii?Q?4xoLeKa5Tb8X4FlnmmRxGUQUeS5wmPVF3RcsvTIA6IXjx0oearz9F2zD3y1F?=
 =?us-ascii?Q?+1zdysBdYPMfpAovXYV1tehZPHRIbUyEDg94O18pabN/bppyrFLktGOGo80h?=
 =?us-ascii?Q?0mDqBRZUD3/9NO4mpOyYMWhvfr4YKd3YsqwXyPpJ1ll5qKzXGGP0Q1VAL0Og?=
 =?us-ascii?Q?+/5Jv1VG+vF8jAat0poON0aSB1mik1j6FtKj16176MGXgLGCqwB1tXyemp4S?=
 =?us-ascii?Q?Mgnyg6Olo2469E5IC3jnxzW7Vtau/S7LkdzPuTNoQYzaK4rdVw54oERdXyRO?=
 =?us-ascii?Q?ccf0GsTFjNxGwcCdK+Jz8GO53aSeEFTqrp+XPDbsCXn8U9j/gIL59yldOvkp?=
 =?us-ascii?Q?TXpGoD4RQall8qxc0XtoRVmsXxBhjJ6cydCgE21hTR6a7XtIvGEiIADnyE/K?=
 =?us-ascii?Q?803552hV88YIAzDjCbI3B3rIrigfUMu9ggg6HSMMrF0j6kVli0YfA12OyRXC?=
 =?us-ascii?Q?9CqVCM7XoImDhHX9vWrnRVgEYXlWQlnnc3R3+YyA7knedK9m+CxMTPm4BNZG?=
 =?us-ascii?Q?dhSGWa1Zll7xC3d2R/GPez0PLRaqyIQw1NkWZkafDffyRDGrGRMvwOnUcgzR?=
 =?us-ascii?Q?RYqenZniVVSGfzruqme23wlJtFMAvb8vArdS3NJwu5cpMMzbqYeSFmDwSE4t?=
 =?us-ascii?Q?hv5bObARE5e504MMuv3m85LDmBGhDPYbm6jI2z0DxNAH4y2Zt/mcCPxiAnQd?=
 =?us-ascii?Q?e/4LHLabqPyACMXpHhIiSbOqHFxw1lU=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b3def5-9feb-4e03-016f-08da246fae8e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:11.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YqTdBehaY5c3aSNUCNYv1PD0wTLbd+CGAF1/h7VKe4L9BfH/TToZb/1tQZMu+eU3xnQ5eoTORRM4c9IsJVXkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5213
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

