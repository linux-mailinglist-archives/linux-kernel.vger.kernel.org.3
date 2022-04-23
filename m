Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAD50C704
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiDWDuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiDWDtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:49:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2043.outbound.protection.outlook.com [40.92.47.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCFA13976C;
        Fri, 22 Apr 2022 20:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhORCvLN9lhpZJvvQHVaOUFJ/G7++hoclB7isnmbHXrP7NSKAnhBCCLh8d0Yj6JwJarFuxwpsBRxTgEKOhsVF9sx/QpYK9oNSkG3C5DNWXHtyTZVFYiTGN++qR3Vn8LX/r+g0i28LXqMn90JK8j0q4Z94t5scmVSlVbycQgVCfPsU0eh7BU0jDkOoo4k5hnqtDdBQxbVovrhyDM0vF2gdojQSLITx7NBBpL+n+ZqXPjwMeR0B+m2lZpK2DIBYlcb23d35Yz0hec95OHKQQYQRdmQvY31iOhmQFCBpdMmLTdtGOyJgsIYQBHkNpK95fZAQwIFBiE5XiyNCrB2UgGAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcP75b0sIfQb1qUJhu4FHo+cowifBokjGJEEWhB4fmQ=;
 b=UqLA4nUegFmMwY8wD7IR5cZtuY2X6BkdVIgcyGBM1DzPobkNBCkBws7wZM3mFgtSqZkZDW4IoVdSQlReHzlwUUyAGeCbmEYkJu/Dlq8ymLgzArnMWw7AKhjl8wRx2HZe7/Oomn5JPg0QWFx+snyqDzl/3YRd83n5khKvogZRfZJA/pCOQVpJ2Ol+RgtuMaefnbYYLlO9NBOEx4aXEWSbTny6jJn5t714WR80Hfo2IiZwl908/iqcFf4bEBPR29W/OyKn8UvL6Z/8SfQ6lr6esdlC4vIGxKza35nVpYAFfFJYHrcRSH8ZLROzJQC4O0ICgivhjdOMJWAz04BpWP6GFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4205.namprd04.prod.outlook.com (2603:10b6:805:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 23 Apr
 2022 03:46:47 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5%5]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 03:46:47 +0000
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
Subject: [PATCH 4/5] mtd: onenand: samsung: Make sure that bus clock is enabled
Date:   Fri, 22 Apr 2022 20:46:21 -0700
Message-ID: <CY4PR04MB056777077970A6935BC6349BCBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423034622.366696-1-xc-racer2@live.ca>
References: <20220423034524.366612-1-xc-racer2@live.ca>
 <20220423034622.366696-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [jzISU3lGJgpMSJxoT8XLznq63W7cCwgumnU7uamOx5cgbkFrk0Xx4bEPZF4VEom7]
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220423034622.366696-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc3d1f3-057d-4284-a07e-08da24dbe454
X-MS-TrafficTypeDiagnostic: SN6PR04MB4205:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7JMQTwKf1gP4G3EdEh40g37+FbTyIuMpi4dPggSK812Pp865EqDbjq7/pZZVczXLMpligvLiO0kZO2egd9qgvF3uZ24l/V3l8MnOI78CLk5DPhYXsvRlhL0mQmG1trm9qHWWRrKCxBWTZ5DgR8Xz35Pp7lqaRciVVrCQ9j5KUvGWGarmktJD5js3wrVEunTr8B1IEPAfq9M4jS4MXwaop5tQ/KmkxeH+I0N/CsE0WzSagACiZmPIC9RZW7Zg4ck/6IVKquwq2ld++/WXESl6lDZUc20GdygvwQQhlrmHxpZzpCrucHUDLBSHoR/3k5JFtM2HGIIYibYhPne/UWwZvPsHK5tX0miT4trXsf7NIikshEzsMqsUn6dKJAlHBD+iI0wG4p+4sFlNOEqtx3ih95aTxMrd0nRpKpuZqrI4bQi0r4LuaZQrVMpx57nc221xPJzj+mx0bG1R64D+b/4PLf/zskGJGgT6ukeQtrx33U9n1cGB3PV+FRylCRyGlEMu7J2VgzOKyWzh8MXL0n9YTfXXb9xsN3JRnlg5ceBOpXjlVfaHeZIjkZ0lWVBgN7FaSczDkmDmv4gmnb/b7OrAw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDF2KzhPclFCaHFGY0M1OW0rclhJT2JwdThCa1lDSktWMXpQSzUvdHQ2ZHAy?=
 =?utf-8?B?aW96Q1VYS0VxZFVwRjFPbjU4b3lSRk5aK3IwM3JvYUo4TXNnbUFDc3BmTFgz?=
 =?utf-8?B?UlNIaWQvdU9MQlN3R3dGdmsrcktkVVk5SmRNNCt3Q0I0WXdhQnRXek5nSHpY?=
 =?utf-8?B?NFFwcmZHdFkwelRlTlp6ODdhUmtjZW1YSXluWWhqM3lOZlpxRUo4WmVnZHZX?=
 =?utf-8?B?bG4zdFBkYlhrMHZtUWZRMnVlRlo2RUVQZ3VrcGI1YUFCZzMzYlgxem9QWHp1?=
 =?utf-8?B?dis1WWtPaUZJMjkyK3Y5VWxGaXE2TkVjdlptbWxpMlcwcFN0Z05OUEFVRkd2?=
 =?utf-8?B?cGpJWkx1ME5CMTM5QXY2Qk5mZmZ5NkdERjFJMjkrUWd3ck5BdndBYWQrd2hK?=
 =?utf-8?B?NGRTNmYzMHRmeVJkSXowUlhuNDBTMnNFSi9JQ0JaaGk3SGk3b2tHaU9Kb3NS?=
 =?utf-8?B?MGJXTm5WR3hCeFl1VW5RSGdIUFh0NFFNanB2STNSTnYzZy9LUC9SZk01UHJZ?=
 =?utf-8?B?ejVycEJpUTZlZkJDUGZCYVAvdVZtQXVxL1NFVW9mQXplZndRK2pXVTJWYzFp?=
 =?utf-8?B?NHF3Skp2cVl5NHZyWmRVWm9BRXI2NkpIOGs3dkcyTExsdDh3QmljVmdoSWxU?=
 =?utf-8?B?TU5SS1dINE5LNnYxQzltNnNmdlRralowbEtwK1NnajRoVTZXUXQvakJUcXVa?=
 =?utf-8?B?eUlraHFJWnhQekM4NmN2UmlCWmVmT3BMK21jRURsSjRyL0NKQUtKWVQvUVBN?=
 =?utf-8?B?UVdrdkFiOGxEVU9VK0dza2RGdmtjTFM5eWJmcXpKbUNGUXBIbEIzM0RuOGdv?=
 =?utf-8?B?Z3BqSzZYRlhJR1VjdlNFczkrVzYxZkxENWp5a09BVzVzY3EzUjNseWlQb25M?=
 =?utf-8?B?cDJGMmlBOEtESEdvOWlNNFhQcFdINW1YcDloNUFIekJHYWw4cklDV1ZOMzYr?=
 =?utf-8?B?eXNrMzVTaWh5OU85VitoQ0ZlVGxqd1dxVlZ3L3JHRWJqbkVFYUYycjNJUHBw?=
 =?utf-8?B?ajZzdTQvMjFEUEhVTGROM1drbmhLbGhTQWgva1hsZjk1eGk1QmZ6UEZMTzM0?=
 =?utf-8?B?bTJORGRiM2FmZTBHQnVTQlRGM0k4S1lhS0FwRmFqcnZ4WDZTOE9KdWduVEZM?=
 =?utf-8?B?R0Y4a21mQmFWTVBSb1Y2MWorRHhoTGhIQVl3clV2VjBzalhBTnpBK2R2RFRC?=
 =?utf-8?B?RDgzNkloUjJvUHNkZ2w0bzM0V2dBRmEraTVYcW9hVHFoWklXUEwvVnZUbW83?=
 =?utf-8?B?RVFlNFBXRCsxdm5CMFhEcEsxbk5sK2I1bmd6aHZNUEJidFl3WFZDckl4NENp?=
 =?utf-8?B?TWpzMWhKTzdYMXJ2WXBzd0lsV2JVUGd2RnF0MG5vMHp1Wmdpei85T2lGSUNZ?=
 =?utf-8?B?a2kvaGttQlhjVEV1SUp3Q1NxM2RralRvSmpXSnN6R2xtQjJldlNndm5veU1W?=
 =?utf-8?B?Y1JUdGN5dHpTUkU5d1VNd0tDbUZ2QmNEREdicUk5NUxnaWEvZUNwSWY4UEVq?=
 =?utf-8?B?OTFrVnZlcmZ2M1F2MjI0ZHlieWpXMHRiR1dEMmRlYzRXUTBabC82RmJ5OE5X?=
 =?utf-8?B?dVJUdmlNRXB6YTQvN0dVZVoxNHQ0b0lIUWZEeUdHcUFFNmd6RWZRUi9SY3hr?=
 =?utf-8?B?cDFrOU4veUxWNU02eDVWNkZuRTluemU3ZGU3czkzYkdLc3ZFY0FIK0VITVJi?=
 =?utf-8?B?RytRTnducGxHcE5pdnI1VkFwRkltT2I5cnovSlI4MHRUNko1cjFXeXJMbU1m?=
 =?utf-8?B?L0hpVjFnZnNLL05wT3M1elZ5MTdYa2w5QjBKMWhTNzhQOGQyU2FFUzFOcHNG?=
 =?utf-8?B?T2NRLzAzd0RQanRMdWh4dHVXcGoxSEJ2RmFzcDJybjZqaHN0akF5M3lhdjF3?=
 =?utf-8?B?Ri9mYjFBU0ZpSWgrcStjdjloTGkzd1ZGUzRCQU0xOXA2Y1hKWm55OTFKS3Er?=
 =?utf-8?B?dldoZ2lpNi9mTG90RHR4a1BBWHE2UEhFdklWTVNPODB5Qk9NQnRGT2dzMlhS?=
 =?utf-8?Q?HkArovMRJUwd1VBU60ETka6sCjXAbY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc3d1f3-057d-4284-a07e-08da24dbe454
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 03:46:47.6972
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

This patch adds basic handling of controller bus clock to make sure that
in device probe it is enabled and device can operate correctly. The
clock is optional and driver behavior is identical as before this patch
if not provided.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/mtd/nand/onenand/onenand_samsung.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index a3ef4add865a..62014f8d27b6 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -11,6 +11,7 @@
  *	S5PC110: use DMA
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
@@ -122,6 +123,7 @@ enum soc_type {
 struct s3c_onenand {
 	struct mtd_info	*mtd;
 	struct platform_device	*pdev;
+	struct clk	*clk_bus;
 	enum soc_type	type;
 	void __iomem	*ctrl_base;
 	void __iomem	*chip_base;
@@ -914,6 +916,10 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 		}
 	}
 
+	onenand->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	if (!IS_ERR(onenand->clk_bus))
+		clk_prepare_enable(onenand->clk_bus);
+
 	err = onenand_scan(mtd, 1);
 	if (err)
 		return err;
@@ -945,6 +951,8 @@ static int s3c_onenand_remove(struct platform_device *pdev)
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 
 	onenand_release(mtd);
+	if (!IS_ERR(onenand->clk_bus))
+		clk_disable_unprepare(onenand->clk_bus);
 
 	return 0;
 }
-- 
2.30.2

