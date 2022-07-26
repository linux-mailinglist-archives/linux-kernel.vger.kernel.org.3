Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2185158181B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbiGZRIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiGZRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:08:06 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE8314D02;
        Tue, 26 Jul 2022 10:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBmTpxBvyPuDbu3xbR+EkJHYM23XgDBsOhGRdjWbi16VXaEqL1GtxroZfEiAKX+VqsRwDlyA0KVyDCdqvA8C5KmNVyr/nT2DrMDwWe1mxP8V9MLpbpc34478HxfypdDTisC0ZDH805FXJOrX5FPg0K89Tf4n2Cp8744c+ge2cHJlto0XjGYsvPiqMcHKMjgk4ffOQPnCd0sIR0dPNNJ6V4IDX0xkemyzoCSZrTfexFyUPR+zsLN6rhZgDb+oYQBsHUgJ75ut5MAO1/VcYcq7gwZvN9ju/353X/iZenJJu2kCSUkG87Vl8EBfSwsc2FVcsNoxwZicRKN3iMv914iVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLnhbqZuKV4v9IUby3nBS1sMQMk2zSEAHnuH8AAk8Xo=;
 b=TFK3u9UH4Ft8i99FLn4vsbYeZdjtQfAER+DANZHR/dpd6GJZP5FP2CU0icZ2NROksKs3RdE2uOKHKnfipucJMmsILYBS8iprPaKhpdqTtf4w1UwAPg6h66SmX8hjIZFGgwDHBmjhHboEg3IvQ51+T41fhAKg/teTqiws6miR+EfeRA6qnDEfhHyCh6L9NpWQI1WJdZtt58JU+3V2pmmp+frVw5WSbC8LSPc08vgzYWbG8H+GOo27Hs6pyBUbkA2UQtcjQpqd/rvokx3+33mqENQgnrJ6ZWWB0FZ0HgadLLLNhy+ZbCYJRnyLs1QinXCkbcUFz4q9zmyACc7OAyuMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLnhbqZuKV4v9IUby3nBS1sMQMk2zSEAHnuH8AAk8Xo=;
 b=oSPoCx2cQUgVAJuDbEGeVPhnbq+4Ibrxp97i9HAr9og2QoIPNen1Fso3wKyLgaQZMg+e+9/dEkoRJ6EEdnSuNUa8VyOtryXkNx3ZBV+Q+l1n7tBkVDk6kegNwyAuxcwxdSoPZU499YnMXoEbtAN0xISq82MFRihieC5S5ckZ0MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:3e::13) by
 PA4P190MB1197.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:100::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Tue, 26 Jul 2022 17:08:00 +0000
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::b89b:a8a:a1a1:c0c3]) by DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::b89b:a8a:a1a1:c0c3%5]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 17:08:00 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Date:   Tue, 26 Jul 2022 20:07:11 +0300
Message-Id: <20220726170711.30324-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::27) To DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:6:3e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75629c53-4d77-4fbd-d22c-08da6f2964d0
X-MS-TrafficTypeDiagnostic: PA4P190MB1197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gtXnCN0ICKe7NK4qlxD3mK7gJYz8U7xMICrjJ9rwz4zK/Xt9dYrBTDeCmzbMBUwidRd69GthYqTHG0SlMdBAeovVWfw73HyytdE6leTHdEY0IgAD4GGauQCLSzYVrXpT90b12Qpcof3p80IfIPPpJ1FxToqg2I32Q4MTzil2cW95uzj2hGKWOrnjq85lROlxPyoca0MUvihgdTP9n0cvwD0JTVMYzXYE/4oqAxtZ6h9fVf3dtV5yM866O1aD79JXLKMIWR4gIvg0ogXezj3YOaObGyMUOFyB9L5ck3p8brZsXx6ENuI/cvjof2zij5WNAn121zys+POpJT/peeenaSW4CLh6YCBM8v6EbR9q3XRhS7LAIupD+h56jInd2ZlKU7tyIAol7VrueDNyTY3VGiYgeOhIZ0zWRsSArCamm4Rb1NaP5WsivaMRdL5IDHCqNFEXbIoEQs4+Xi0NfN3isHqXqPaOphfaUN6DyltcJfjrdtyVNnSTDDjSaC+yCMm/vDa8tIfkAw8H6X4cQ8sO9G/lnPIgqK/1cw+9PI9lhr9U6287pTMDay/4XZa9dTfbOBSKsV0LIfA5lIn9RXH/ojnasjUi/CzqmnbIWbH5xbX45TSODg1QgjJtkZrShDvyvUWsz1dmVjLKl9wBb4z4OU7vndcFTKOyEp6A7uBPJMlfbXVnb1gPJpptChnMkM4lSo8KcnBW3UWSPDE6TAffwGcg72TEXw5drl+g3JZBHtk0Z4Sg8LvOsTlk6P0Sw93C4B79GWApE6bKGNeJBqHSJnGW6x9foiWL7aKGn5pBLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6P190MB0310.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39830400003)(376002)(346002)(136003)(396003)(6666004)(41300700001)(2906002)(52116002)(6506007)(6512007)(26005)(186003)(44832011)(86362001)(5660300002)(6486002)(478600001)(107886003)(1076003)(2616005)(83380400001)(8936002)(36756003)(316002)(54906003)(110136005)(38100700002)(38350700002)(66946007)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzA842/mxmM8VkEkdX/agYO94f7jJNX/9PWFmdo/+iPBKXdsRWZAS1OHX2YT?=
 =?us-ascii?Q?+B3tGr5e/h5P6phN1KhI/f73oiVI1Sy3BIS8aFvpwgQGu8FV8F+G31YBSQSu?=
 =?us-ascii?Q?nN7y4JW4dnoWD1DvP0Re1ldHui85E2O7ZX4kPvsTCUeT/Sq9PbreaEWGHzpK?=
 =?us-ascii?Q?DFXadKxvNE0zBA9c5HxRI+1Pi5idIPZT5xhPODGw1QheBqeDo9E6i8/ija7W?=
 =?us-ascii?Q?uqVBE1qrfleybvKDtztMGTH3CaRM4UDeudvUQgrbtGOAj4DlxUblOPnNYsnC?=
 =?us-ascii?Q?ptpEZekMFiH5IZdzgK34XsUod+JeIoSmkB/bLROlCPfRi6EPhGol8MyIFp1/?=
 =?us-ascii?Q?3Kc2hiETXhfz6Ew6OyZeMR+HiHP+rm6oLMRJaUnfW3Sp+niMoE7ruIEpqIPk?=
 =?us-ascii?Q?WSH3w7ZV/4xDhLuq4BkhY6e4bVU22nKDeawqyAVZOUeXvpmMIhYNCe4BOSE/?=
 =?us-ascii?Q?kk2j8cwMgD4rdmUd2vjNE5VIbVeYyfruXEkalZHJqJP6ke4ccboAAUJjLL33?=
 =?us-ascii?Q?4YM15LQ3Vhj8tHedSkqdZ9W/PRDN+0BHLtc9yDl8k91h22OYM1p6X4hhXopG?=
 =?us-ascii?Q?It2IaHCillGw89NcnWsZcvtuNnwHVPPb/ev7WBFTYdNLHYfGm3VQooZqri+0?=
 =?us-ascii?Q?6dpJksCa/80MO2jDk93JvyivczY0udgsMZ/tVuiXH6hUSyrG61xb3QuWXUvJ?=
 =?us-ascii?Q?zD82Q2jLRKmvhSsvKj5YtkH9P7M3QmvAl6FLGUtwi7/7tLYato0ct8hXAsVk?=
 =?us-ascii?Q?/nflWC2AWjOqgMvU8spCJiNLQB2sySwA8JnbfrwFSnI+4TwV4+a+3Zy8p2S5?=
 =?us-ascii?Q?YG5FEZKfEnhRidIS9QUX5X2mwmYqGyoavSJnQ0DKb3oBVbLphav9e3E5Gph4?=
 =?us-ascii?Q?bBUcQpX3395ZJv2S2kSRB7t+9HfgtWpEyt+SlwJ4Nr9u3bIUnY5x1uuXdLRF?=
 =?us-ascii?Q?7cK6n18WBrWQ37lkmSbK6iGg3ypS9Pa4LInyLy3ripySEbGlih/1jXR2A8wC?=
 =?us-ascii?Q?bOZzA28JBudGQX1Hih//PD4retlxuP8vqMh5iTu1Ots1W1qFrrUVoJ7lSih3?=
 =?us-ascii?Q?I0/etAOTn3ko78gIWjMVjQlJd53cx1FtdgMxTV+bfpPve0lYboZJBGJgXHBp?=
 =?us-ascii?Q?AuJY5ZpslNBM93R2OfqtlEE+um56D1uvwXYWEklKbUtWRqfGi+8yhq76iVTP?=
 =?us-ascii?Q?L4ng1HPm2dQo6AAvNw4Rut3KI3iYAGx+/pheKB2HH7hkG1B8fpUDNnSga31d?=
 =?us-ascii?Q?NEo02o3P10IQNHJIcSpAcK+NR/rnEQtgsMD/PtdhTDCiZ0JBgIrfUKod8ZUl?=
 =?us-ascii?Q?s1u/yQCj0LMcnErMDiASKC8unzI5i45vHeZdJp+u7br4k5XWRfSEAx6O9OtV?=
 =?us-ascii?Q?FHpMakTkegxcmnpKYzjFH8IxTgchR+EpoyJLEK2BjBIFN+rnWUM7+C+Xw87Y?=
 =?us-ascii?Q?jzopOVayeFhKWo1f9yVGavS9IVbS2UY7Jge9NHjoAJicWv5kMbqG7XVF/V6p?=
 =?us-ascii?Q?lsKyUnKTKKDdiALkpbyfKVzRzbT5XGVBwQq9cD10X9z5YdXbKn9IG3o2ysSj?=
 =?us-ascii?Q?y90VxOQDHHdsuJ1LgHrMwDO9q31xjyIxPL8ucDW9MAKSte0qJ81QLic5jshn?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 75629c53-4d77-4fbd-d22c-08da6f2964d0
X-MS-Exchange-CrossTenant-AuthSource: DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 17:08:00.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQP9s/whUUo9TVcjVVQ9yRQJVd1ru5ihQ2/od0jifHU/JSSlK6QQmhvORzQ5BOxZv9aVwSWes0+h3edb5O1wxLBsJTV8sfmjnqIikFLIQ2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

There is a limitation on AC5 SoC that mmc controller
can't have DMA access over 2G memory.

Signed-off-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/mmc/host/sdhci-xenon.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 08e838400b52..666d06b58564 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/mm.h>
 
 #include "sdhci-pltfm.h"
 #include "sdhci-xenon.h"
@@ -422,6 +423,8 @@ static int xenon_probe_params(struct platform_device *pdev)
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u32 sdhc_id, nr_sdhc;
 	u32 tuning_count;
+	struct device_node *np = pdev->dev.of_node;
+	struct sysinfo si;
 
 	/* Disable HS200 on Armada AP806 */
 	if (priv->hw_version == XENON_AP806)
@@ -450,6 +453,15 @@ static int xenon_probe_params(struct platform_device *pdev)
 	}
 	priv->tuning_count = tuning_count;
 
+	si_meminfo(&si);
+
+	if (of_device_is_compatible(np, "marvell,ac5-sdhci") &&
+	    ((si.totalram * si.mem_unit) > 0x80000000 /*2G*/)) {
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+		dev_info(mmc_dev(mmc), "Disabling DMA because of 2GB DMA access limit.\n");
+	}
+
 	return xenon_phy_parse_params(dev, host);
 }
 
@@ -682,6 +694,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
 	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
 	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
+	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
-- 
2.17.1

