Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFEC50C6F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiDWDua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiDWDtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:49:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2043.outbound.protection.outlook.com [40.92.47.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4381D13977A;
        Fri, 22 Apr 2022 20:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFmtbCaZIEnuiPmmNmwGITR1lZMLKCft3uUCaBWw2XVuXWJ0RYvWspUBRGSz2Se2DOW2sGnyYV4kHh3uXwxHIclEt9vnT9ND8hD2BVIR/aMwlObHYEAlyUdH3rmVDGBfVn/E/1DHLnTnmeu58/33D9ZVNBMkxN7AZDbhUFGPzdlGsHNTnUC314FFU/ZL9WjsXPvFQO1X4mmFrIvUW6FyFm0NorGm7dQR24EXOQnGy8Tw+izOHf6TgSOzEh3sLL2GSzfovbVziu7MG5mz6VcgD27llWcCRGSwcoVjsea3F9gen3OJQFjryb0jfczZIn+Gx3H1pTdcvH3XCWaWdAR+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRz4KJxx36uXke3/M9dDj+fZyMzrPh775UfAXXXdqLs=;
 b=JEIpcY9r0MdREHPGbC45BblBA7dO4DCoBM8EZ4f7xZA5DB/98fqFSWgBR5d2JL7hxNcIdd5nM+sc8ScVFYtSsQAsSiaKBMETvUClbw7YoImx37Q3t7BeMYszHzRcL/yYdJKprv1h96af+tdyCsDFET5RwkAYGreFzBqSEHP8lWWmC+uIePojvIUNrCF0QaOrxOHYbd9GP3zGUgjyJgP3pZgFfV1mh7/dJWNZ84zn+GIz2bIf8y8RZ6R2JAj4qHc+pnA8YCYQXhhDZq6EawtyrhYRAGEQLiLjn7j91PqFhyzIxAq9Pe1+PW33qOXD0KHdS/hsrcausW58jX7gb3GDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4205.namprd04.prod.outlook.com (2603:10b6:805:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 23 Apr
 2022 03:46:48 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5%5]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 03:46:48 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 5/5] mtd: onenand: samsung: Add device tree support
Date:   Fri, 22 Apr 2022 20:46:22 -0700
Message-ID: <CY4PR04MB056716B2AE01D243F6AE3C13CBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423034622.366696-1-xc-racer2@live.ca>
References: <20220423034524.366612-1-xc-racer2@live.ca>
 <20220423034622.366696-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [lSK7iLLjEA4qxR34T9AkrmY8T4I/xv1/GtDCGGhtOGPCqTn2DHcGevU28dsWUlY+]
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220423034622.366696-4-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aa12229-2cfd-4497-1fbd-08da24dbe4f9
X-MS-TrafficTypeDiagnostic: SN6PR04MB4205:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSjq2cDEbz9929l0WJ5DX2V8SSHhDexGbbVKKH8u9EMklwUiL3xKzXvMeaD5OOXRsG1Ry/cCH1amM/NERgDITpBjiTEioZ9rNh+2+1kVdlyqHmxv9RAFM6Ur0nhUvOsiQ3laqzo2G2PSNrmMM3hzB3nvtMqdqXiL17zIWJPYv8MZVmQSSPLSffLAtlXdupSR2jBiYI4hH9c66wIUE7bGfxo4U0iElFvdPp9j4yCn15i7SeyaDjFcWni7cKE7X48QuzVr814gIwQgvdLvJDORRwRMeIZD1H3OFFgxM3EQ2fYhi2g1+rCEEtclyo7FhQuasg3KzYDzozSrNGiAAHDXN1az1G8zP9xfGWgOyrOvBTvY1+OC3dSG9x9fdU9gj0zZlBaueFY/14or6XztAmibdsTLIpNgxNVOMXuaN31kzXQi4taybi0cEzGHN053IZdNel2Ee+AN0K4CSa1dSxe52H7t30rfynG+t4CvVeRZ1sliemW4MKnF/0qgBHron4+oEsKqOFOL/mOl0Z56+bAYqu1p8h9b6wLsqAO4oywRMUfXrwGRC/Hc9UEJkpHu4i+EW3EzwMNZXN+gbWjma+XsJg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnpLU21FWWNGZDJEVndZbzRQMExWaUZPVWExMUw2eUxVNmJzUnRyTEVpeTNC?=
 =?utf-8?B?QlM1eUptc0dvRXA1WE9YT01uVjllR0JNMEVmR1ZaWXlJUTJZVGF4YWcrd3Iw?=
 =?utf-8?B?MjJ6M3BOWEpsTzgvYzdTTkJ4NmM2Uy9EcERGV0htSEc0N0I1ODQrWTFmcDNw?=
 =?utf-8?B?cVN5TnlJdG5QR01rSm92SHE5VllMT3o3N0FZa29qTGcxQjQ4SW4xYlZGWWpk?=
 =?utf-8?B?WkJBc0MrVFVTRFlxU2ppUmpCMk1ISVl5WkIyNjdqcnM4NHE0MVU1OUVMWG40?=
 =?utf-8?B?bXJQVEtLclhFeVpqeCsyR0NFMHFFaW8xbG50bEllWXhmUmZuQnU4OEU2MTlk?=
 =?utf-8?B?dEIrL0dsQ2c2OTNUek1tQ2tUc1dKQ2hCa0VOb0IwczlPMUNYYW1IK0ZDdFR4?=
 =?utf-8?B?eElsdE1LVDhJWm9WNlFIOTVWT3MwWnZSOGdVRW1zaEZ5NXh6UnBFcnNDdit3?=
 =?utf-8?B?b01KNWkxRlNiZmtDbnJVOCszelVwSld4ZGhIOEthZnpaMFpvVTFoM2gyeHhM?=
 =?utf-8?B?aDRVRy83MXV5TmtyNW0zOTNTd1kwZnlOK1ZiSUtYcDRHRzczaDRzbENmejZ1?=
 =?utf-8?B?WEdBQ1oxSlp3b0g2RVNCVzMzMXAvaDc2OVdsVGdocmpObWxTQ001b3NkVXE1?=
 =?utf-8?B?dWNpdW1pUHVqdE5LcmhGL0Z4cVd3MXAyNisyMk9rcmwzZnB5aUpYK0tDZkZG?=
 =?utf-8?B?WXlyQ1pLaDd1OUVWaU9KRHViaCs5S0VaYloxTDRNbjljNUIrcExjcVlYT0xn?=
 =?utf-8?B?Z2daU3JQK2pEUmsvelFEWmRxZFd6UnQzSUhMYTczcm1MT3RjNWxZYVZOYVkr?=
 =?utf-8?B?U1hRUjhJUVM4TmF5Yk5ob2lVUmV2aVVTcWJJUGJzWXY0LzlMZTJPejNLa2ZW?=
 =?utf-8?B?VmZhTlloZVZramVVdjBWbnljSU9SWnNCcUxMYUZmZmc2cFF6ZUNRdEZmODl0?=
 =?utf-8?B?UkxtRTBWYmdVRnNXZWhubWhzajlYSXQybldaY0FObStMZTY4bHdMendEd0lX?=
 =?utf-8?B?WmhseVR1RXZQOHRIb0hYTzVOamhPTnAycUgwZUw2MUoyVFNvc0VFUlM4bTdj?=
 =?utf-8?B?S3M4RmVwR1pXS3pieEtGMzNFcy9yQnQrUW5uQzd6T2hZTzNTSlVvODRwSU5j?=
 =?utf-8?B?dWtLRXlmdDdhczJ6V0ZSeGRRc2w4SnJOVE11T0RFU2lWL2xJN29QaHpVVUJJ?=
 =?utf-8?B?R1R5UzFyQm9HNThWNk52NWFLMnNKOHdPTTRQeFhmdFplcThibUhLRkVZQkZs?=
 =?utf-8?B?UzNoVFJ0V2s3L2liUzlhU2NwbHRPVDJEUGZZTjhROENFc2JwaDdlNGRXWEtO?=
 =?utf-8?B?Y2FjSWNRWGZmMVM0MFZ4U1pxaUNyaXJnTjBTeGZXTlNIMXVldXZ2RS9KQVVR?=
 =?utf-8?B?eFVGZWlsc2d6VDN3YllOUGFUMTVTcXE3T1VJYmxxaHZ5U2FaZFFwSlpzUzJo?=
 =?utf-8?B?Y0lRTWFoSXpzYWxXR1pmczdkSTdUcVpHaTVTdFBqeFJGL25RUTFFeHA4bStv?=
 =?utf-8?B?WDFBdk1QVXhPTUgrYXpOMlZuUEJpeCs3TjRMaXdHbWhCNXpIbXRvNW9IdGhT?=
 =?utf-8?B?WEkvTDRaNVpJV0NISi9jaDRERnFHWEZSN3BUemJEcFpCSFpmUU13VVdhamd1?=
 =?utf-8?B?YmZ3c2hqRllwcWRyL29xZHVzTE9ER0tWUVJpdnVZYS9UZk9OS1EySGEzdUpB?=
 =?utf-8?B?ZjJObzhhTStQN2ZINk5TWGVFcGozbXhVVjFibitQZFY2bFdnYy9EV3lJMzk0?=
 =?utf-8?B?cFNSSVRPSkZwMjFZL1dLOVd5R1dDOGp2a0kvUjhUNFJWcFJtMXJBc2xxMHBj?=
 =?utf-8?B?U2xGTExKOXVHZnRWaTQ4NGo5VWlSOUx3Q0pCRVhxWDRlSmN6NDgzWlplOTV6?=
 =?utf-8?B?WTdWajlvM2pzaHI3NkNHVUo1ekJjeEZIWDFHeEJoSlBBYmNFcm12bVFzNGF0?=
 =?utf-8?B?Nk9HbW9Fclg3L3JYb2VhZGVTWTVuNkplbmVoRXVGVkF4dnVoMXRHN0ZrOE9I?=
 =?utf-8?Q?qVjnUHKka+W+7hVeFRYHbKVgDF33tU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa12229-2cfd-4497-1fbd-08da24dbe4f9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 03:46:48.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4205
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds support for instantation using Device Tree.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

---
Changes from previous patchset
- Adjust to having a nand child node as per binding feedback
---
 drivers/mtd/nand/onenand/onenand_samsung.c | 67 +++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index 62014f8d27b6..0108c8c75d5b 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -22,6 +22,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include "samsung.h"
 
@@ -832,8 +833,36 @@ static void s3c_onenand_setup(struct mtd_info *mtd)
 	this->write_bufferram = onenand_write_bufferram;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c_onenand_of_match[] = {
+	{ .compatible = "samsung,s3c6400-onenand",
+		.data = (void *)TYPE_S3C6400 },
+	{ .compatible = "samsung,s3c6410-onenand",
+		.data = (void *)TYPE_S3C6410 },
+	{ .compatible = "samsung,s5pv210-onenand",
+		.data = (void *)TYPE_S5PC110 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, onenand_s3c_dt_match);
+#endif
+
+static enum soc_type s3c_onenand_get_device_id(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (IS_ENABLED(CONFIG_OF) && np) {
+		const struct of_device_id *match;
+
+		match = of_match_node(s3c_onenand_of_match, np);
+		return (enum soc_type)match->data;
+	}
+
+	return platform_get_device_id(pdev)->driver_data;
+}
+
 static int s3c_onenand_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct onenand_platform_data *pdata;
 	struct onenand_chip *this;
 	struct mtd_info *mtd;
@@ -856,9 +885,10 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	this = (struct onenand_chip *) &mtd[1];
 	mtd->name = dev_name(&pdev->dev);
 	mtd->priv = this;
+	mtd->dev.of_node = np;
 	mtd->dev.parent = &pdev->dev;
 	onenand->pdev = pdev;
-	onenand->type = platform_get_device_id(pdev)->driver_data;
+	onenand->type = s3c_onenand_get_device_id(pdev);
 
 	s3c_onenand_setup(mtd);
 
@@ -867,7 +897,35 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	if (IS_ERR(onenand->ctrl_base))
 		return PTR_ERR(onenand->ctrl_base);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (np) {
+		/* Determine which CS to use - this driver only supports one */
+		u32 cs = 0;
+		struct device_node *child_np;
+		struct device_node *extra_chip_np;
+
+		child_np = of_get_next_available_child(np, NULL);
+		if (child_np == NULL) {
+			dev_err(&pdev->dev, "failed to get chip node\n");
+			return -EINVAL;
+		}
+
+		/* Warn if more than one chip as this unsupported */
+		extra_chip_np = of_get_next_available_child(np, child_np);
+		if (extra_chip_np != NULL) {
+			dev_warn(&pdev->dev, "multiple chip nodes, using only first\n");
+			of_node_put(extra_chip_np);
+		}
+
+		err = of_property_read_u32(child_np, "reg", &cs);
+		of_node_put(child_np);
+		if (err < 0)
+			return err;
+
+		r = platform_get_resource(pdev, IORESOURCE_MEM, cs + 1);
+	} else {
+		r = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	}
+
 	onenand->chip_base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(onenand->chip_base))
 		return PTR_ERR(onenand->chip_base);
@@ -917,6 +975,10 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	}
 
 	onenand->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	if (np && IS_ERR(onenand->clk_bus)) {
+		dev_err(&pdev->dev, "failed to get bus clock\n");
+		return PTR_ERR(onenand->clk_bus);
+	}
 	if (!IS_ERR(onenand->clk_bus))
 		clk_prepare_enable(onenand->clk_bus);
 
@@ -998,6 +1060,7 @@ static struct platform_driver s3c_onenand_driver = {
 	.driver         = {
 		.name	= "samsung-onenand",
 		.pm	= &s3c_pm_ops,
+		.of_match_table = of_match_ptr(s3c_onenand_of_match),
 	},
 	.id_table	= s3c_onenand_driver_ids,
 	.probe          = s3c_onenand_probe,
-- 
2.30.2

