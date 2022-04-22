Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFBA50BAB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbiDVOzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448956AbiDVOzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3DA5C643;
        Fri, 22 Apr 2022 07:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1bZePg6NjQMaf54ZVFmI+BZeVshNQlStXB1RLS0NY8nHmG6+/VhC0VYrE9nhuz1tX0odU7V79hVxnztLu6SSUk7sTFs9diGhDnUd62Bhftm3xQgq/aJFtYPzsLTuAxgIFQDcPoQyFUmp91y3zzk5u/JIfMwRwc0uCCSIsj/GXNZf3ZFa9XSVi8XNQjdEFL4pC9snozlMt7jAEn3w8stEoApCjq78bLjZWuLQdMV433F/9ozrONHYXpf8rSdeRJ0zuIFaph8daTMy6dVZs97lichQDYjAl2Ow913GWE1DsuFUlnVoWYF85cvLLpuJZDcwRtQXNwtzVfhb1EmZVtSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjr9JNKL9UO3Uu62qeHN87lvtt3gKFygNSJfogL6JwM=;
 b=oYbNC3xgWecBbOQk7UxQqI8LscB2iBxKQM227iOJ2kLvtUckPTMBfcmfgeQyxjo7bC6OM8/pgUEK63gyXiYi6M/Z308vcz1t2Wxttwj2zr2rTOy4Lp/7GzPvp6CH3pnXlOCzc6gevivp8bWea/RjDv80jPt15xB+T3S3svXNnhUpcYq5BY9MgThUUAAPNm7odZCPybX6NoEph1cZdKjfwYdJ4JRI6Xlm6A19iLl7cCkEOsoDQMdmvjgAavyVnB3GJ8q98VOsWOgwDXarSfr66ZP7cMVaz7DL4boRyOOVPkYEJ/4E45su3dbKsw+EYJt3nS2aJmbxysi8kGW0EqN1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjr9JNKL9UO3Uu62qeHN87lvtt3gKFygNSJfogL6JwM=;
 b=sd0X3Tnz6hz8CTuVWPumsXrbEP2cDzFyyV1qO6/XQeMxtMAVN1AOUKEnHWIvqrHV0O1AnOWqd0l2tPC26l0+glDU5VArxwr2TYqmJiqRzwzcecLT3uSpf2tK4vFmRsNbaDYLQkTIp4lboAIULfWq2sh8SHl5BAEcpTOUhrCOi2MtFZO7YKnzNX+AoZoE7xsM9p1aCz5Zzj0JQ68cX/egUoGZ0KSJvrlZQmjjQi4XA41cCq5W71+7ficQYd4Aaz/REk2jSCxfFpVJjCe+WoclH9mNiKQ9JxELLBUmWLMp5IMVJuGm0aW/nCyDglzEkN5ta/WZ8Ef9X39w/oaCa5Ir/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by VE1PR03MB5213.eurprd03.prod.outlook.com (2603:10a6:802:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:13 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:13 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 9/9] nvmem: sfp: Add support for TA 2.1 devices
Date:   Fri, 22 Apr 2022 10:51:47 -0400
Message-Id: <20220422145147.2210587-10-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0cb66460-8794-40df-cad8-08da246faf7e
X-MS-TrafficTypeDiagnostic: VE1PR03MB5213:EE_
X-Microsoft-Antispam-PRVS: <VE1PR03MB5213B05DCCB2137235C7ACF696F79@VE1PR03MB5213.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9i23InlELqdprj+WSione1vYZoT9YpEgWQ08B91pDdQW2/dHsrMHhpA6XbJe6wlBOLD+Io9lpBvWyrv8UAW74/R2MXajqKFe7TmIlcTbG/Z/gD63MeqizEVPD2BLTRzf/2Q+F+5F9XgJ0i0QK+ozxAl0Q7DSj4BrNkIJFU1ZrS2SxSrMtjfRbJIfBJq/YAXi8wN03iaKrP019lu0s/8R0Xxi199pL+ZitoILEvrch+1XLMZID0f2OtWULdckN1MOhoFGufgcwzhEscO14hqMPpisbe35IFnyQ8z4JQ2gdOjhzNK0PEn2xycufwdLn34A1bKJmsPYbhQy7rI3tNfYcOCCdFCpd033tCbXYP7uierp7cW4mrFZCPSzdfJa4+LNrEkbu3AZVDvV+2Gv5BQEh4z0NPGiABbwlyKD+JMBlxic99PPK/E7bnSGKomE81oMvIy6b7tEeFZZhO5R4ATc343uYwW2wiqJIu397e0H2zWqI7uXr9Li2Du8XFn3UtytoNcBF0LzxCSsR89oeNgpVc1uHcM9zVDDQzKZeTqjMrxqueKVlFpJ7XXrJVcJwrajbPhwn/0BocWsfslB9qLmtnHom6oVDbTEUKwyBVCJtmqrR0qWQOeXD9OP3GYNgg7lPI4TL+mNE0Uwgm0SvEzYSUxJExnDuFAyc0pUVA+3uGAgDoXXuZOFB+N7sTd23k+z8BKuVB5heEK3hEVTxhsGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(186003)(7416002)(44832011)(508600001)(86362001)(52116002)(2906002)(6506007)(8936002)(107886003)(2616005)(6486002)(6666004)(36756003)(6512007)(54906003)(26005)(4326008)(38100700002)(38350700002)(66946007)(8676002)(1076003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/OG84B0FHw7b8CdfQzMn3G23EbBK+0ZKwh9OuEio51dH5vdS8fBuJORaSbS?=
 =?us-ascii?Q?DLSKCHhGcCgMAY6Y6rvwoRym48BNHoqzO2elBVqfqb1a98dMtcs80//Xny0g?=
 =?us-ascii?Q?I0yuLt2bTrS5x0bq7cRq72edFPp9WWMSdAzmFDrGIlQjh8+iw4LjfBY5zDO4?=
 =?us-ascii?Q?LOcjGUd//62Tkfp/C6J0XMhv2QGvnw0CXcdHI76rucu01XypE7PAcgn7K0Vk?=
 =?us-ascii?Q?lxcgP1SYQ85miPNQl+GA05phmkkIvZjdUmWoBkXM7mP4RynHwQHL8fsw926D?=
 =?us-ascii?Q?WMr/n6xM1TPpd7jwt5uu92oxZ9xO86119s3B0Ka6sdKOi+1DCAa0qoOM5FME?=
 =?us-ascii?Q?/JF7xijYEK52tSl78hEdMxcPQM0oS5Af/vdhUwZszg72eAIrlN+knXe1RLGd?=
 =?us-ascii?Q?rMnjiYxn90nHa0b5tLKbWxHQ6+gh+Ab11GHvPsNe3vocmemhxTVpvdokjiO7?=
 =?us-ascii?Q?c97795aQvSNxrT701/1+U2i5BK18ddxCZeT1vd0tpZzhI+uvXWg17JVVeQFw?=
 =?us-ascii?Q?n1/1ij6Mx//RSZIMsfmZS8bvfO63hBChleW0UhbHGXkrsAa+/x7qyUw6lm51?=
 =?us-ascii?Q?7M1Ax+eqrscD6Bsantgl8PVcPA7ng1thG1eeQh5gVQ7aFvZRPgxKcufrjej3?=
 =?us-ascii?Q?KGGvaLlg2rJqsZpV7qvsLbml7KJCiUhONFqlY/t0jKLHdmaYQlWGFmBru8uS?=
 =?us-ascii?Q?Ml9jG4TZ+a30D7mJPCzQAoRwKZJwdxlU2K9DeP6sUUasTIBBT/XAg4WPKljk?=
 =?us-ascii?Q?/oeaT31FHFUsU7uY5qKMRKhcolZ51iEqIgjHhWQ9aOD4PGZOh1mLuZnQAy0Z?=
 =?us-ascii?Q?Y4f8b5Cr14aXn5pomm/OTKQeAxpT35f0i0GBUvOuZDurJMq4Z44WTYCe3Rhu?=
 =?us-ascii?Q?P6ydrluLw38lAgCY0fWHbFM+JwlyFD7s41/osjJuYYICOrtZ8debceEghf1T?=
 =?us-ascii?Q?Cr0cLJ7fgWELpOwkX/fwleDJ/PXpQhDkbQnvvGd2XbQeN9EqZw/9ossenKLK?=
 =?us-ascii?Q?h2TfaE9b6AIDF3rmTvrdcXwu+Big6jGGICvluI+sf7y/LkvWUpipCScz26Aj?=
 =?us-ascii?Q?qbFiX7uzNSMNwTM+3PnIblL1GRk/IeFoGAhpPrZaofipFALB7L/zJnNbY3ap?=
 =?us-ascii?Q?oboeIKlX4/SQSms8cI///q/rT8VvbF8ZsttXV6nFEamE0c4uxg4cVB9tMYBA?=
 =?us-ascii?Q?Yy/lybde7wI31dDp0Yxj/6JcDnafC42AikXDf3W1EYmYlYf0iaDRsaOsKnm5?=
 =?us-ascii?Q?DDTSJNS/tq9U56S2aB1TPoEMVOKDkHUOCf8pHN7aGId4Nz48OhaZwrj1Kwg1?=
 =?us-ascii?Q?cvcAAnIVaVDYHIwl/0nW+nCBfKkFmuLa0/fkEOqUmCp5PMl9YJ629ZJtusL5?=
 =?us-ascii?Q?CLn/FdTAlpJboA12/y/I8WqSKgQdFptPyqEFY0m0tXP7ceZqD5Iu7Sbwk+NL?=
 =?us-ascii?Q?Z6/BiuRc4Hmt9tb+pHlywYQibgNq8vFfUalPue9bL82YjaMz2+TrQZQUpLAx?=
 =?us-ascii?Q?FkBL23Ru/eKMZuOJksS/6UOZUszLGFIZ/ysd2nlE4AnA1mJo9cbCV2a5HkEq?=
 =?us-ascii?Q?aBP+2FImfzsef0k/9vvfLhIcz8BNc0OTynbN0wwQRI9BN6Mf67cefafsFSX0?=
 =?us-ascii?Q?chKtDo+NN7PkyOB4G6+pHDKLZROT58kINWUSevanANI7JL5/bmWNOz+kNfQz?=
 =?us-ascii?Q?tO8iBU92unfWJqfdBRWr7CGBJXy696Q4/unaiX4RntZpXRCYnuPSBJDMmtLo?=
 =?us-ascii?Q?GQNVkzx7n2877NQtYk+wxs1lQLrbFxM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb66460-8794-40df-cad8-08da246faf7e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:13.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZdqYEJ2NlA8zbEcCfp7+jl//fowJKN6WY2Bql4+en5h1zEN9hIBwcwQfgFhNEIxyPATKt3Vjwbf2GAAgPAfIw==
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

This adds support for Trust Architecture (TA) 2.1 devices to the SFP driver.
There are few differences between TA 2.1 and TA 3.0, especially for
read-only support, so just re-use the existing data.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 drivers/nvmem/layerscape-sfp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index 59083f048921..e2b424561949 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -78,12 +78,18 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
+static const struct layerscape_sfp_data ls1021a_data = {
+	.size = 0x88,
+	.endian = REGMAP_ENDIAN_BIG,
+};
+
 static const struct layerscape_sfp_data ls1028a_data = {
 	.size = 0x88,
 	.endian = REGMAP_ENDIAN_LITTLE,
 };
 
 static const struct of_device_id layerscape_sfp_dt_ids[] = {
+	{ .compatible = "fsl,ls1021a-sfp", .data = &ls1021a_data },
 	{ .compatible = "fsl,ls1028a-sfp", .data = &ls1028a_data },
 	{},
 };
-- 
2.35.1.1320.gc452695387.dirty

