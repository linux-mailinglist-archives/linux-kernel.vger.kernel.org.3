Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21047FE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhL0PD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:03:57 -0500
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:12934
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230391AbhL0PD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:03:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc2DdT/Ap/K6VIagB9NicDVDUVxsc0qw8BZ5bjRz0tMUsZlsERap3hZkDQyQnEXvMrQ5sZrmGHuG12WaATRdp0MFlMYZh2SR77fDpeQcm8bvIYuF0Zg5kvuqSMSdKgO1Faqbxb90IoscVzeWyXYEQeih5ZvibDObuvUEP8LZjNlnCY2pt+pdsW/kMwTjOtouhgmwxX9RfwXKpottB7lgpU6Wt0H7H5G3RKzMOfE6a9pTS+BvNUgpRr6tA7kzX5sp++RH+bhvANOFSyw8i4dTZf821DYN8y1V9scrAJy2N85QbkYRbZYbM6mzSJc2v963zt7aQyON4LxDUM5hdhelxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4vGz8awWG53EPEs7r6z9Y8/5J0fqMRVbNuP5SaRmyQ=;
 b=AZZbOBkMVm+kKaoeI+o1W1lAlz/FAYOaTuhR3aJxmpN44kV0EBL9dTCPhJUtCHRBII/1J9xmUhI3PvEaPjw6U5mOuoGvpBdpMQne//ET6liPsQs/IQ10Smr4WkFfRU3fH+K9TmZz961Lzrh/+ofQ3Jb9P+v8QnWb7s6TGJd98wf94k+WB8Lpq8Uryyx3RMfyGFrWEQKl/tlcbYnM5u151F3zza+j/VApCWc6g+v7IPlH/mEqn3va0xcVtLTz04slqAz+XdyUkc6SBhQ2IxHcM2/OnMIWs2yBPc6awW0t6awYc2/StiRpn3zmOWUpiEWn0ABqomNAam5wY/KLNkGipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4vGz8awWG53EPEs7r6z9Y8/5J0fqMRVbNuP5SaRmyQ=;
 b=AobmrHiKjhCkTh5/X+2yQgKM6fOH/w802eJ6dErOQF+OEpFwWFOjqNXSmwi5I9ZcT1A3l+PUvLsrlEbJ7P/YY2sa5RYKoi5Ug2eLcnElzLw8CWa7my1Z6vsMZBaPv05HJnChKC7h8muoxh/ncFFT2FCKfHU569a6t8IhbqtrkvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3711.eurprd04.prod.outlook.com (2603:10a6:803:18::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Mon, 27 Dec
 2021 15:03:52 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 15:03:52 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] devfreq: imx-bus: Decouple imx-bus from icc made
Date:   Mon, 27 Dec 2021 17:03:44 +0200
Message-Id: <20211227150344.3070564-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::26) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33727ab-95ac-41f7-53ac-08d9c94a1862
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3711:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3711E9B37D29076A8293A556F6429@VI1PR0402MB3711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 127VOTSf4tfqvBzi4uNgZpk1Dr/pkq8UtpN8s74FYV/7LiIMJvQZaKYbjhaL1n4g9TmejT0ULxEM+h0zGNudfaJXZFpNNBybB+L9QOMyMLI54I9Uf8lLncKL5KXqgCUNH3IVZIrkAsAoCRW/86PTm9yPb4oDqEZ8zAI8F0uUOUL8VFX4ccLCfQK1Gvvh3hMKyuD2o50JFQUXM/jYPyLeOvZIB2edWO/9hoKRfGE2LflfFPcGx61/C796f3L/BGADZmOnAiATdyzJpxrYTGA3UlaotCAMpVxpJoCedtxRqXfElC7Q9tXdJUNYVZ3MDrhFfwLRDiSmIGCI+07oUIYOHEyF+wbtGCii24fv/NzwDgxLhpIN/Q4izM9gvWOAIo/nKsCs1ukxIoV93yrSrzdQ63J+SQjV0Ou5VNIVwV4CPa89Q82tYmHJyc/V7/Aa3BsMhfwX97N1NRRbuGTluiojP49LZfWIfNyKFIkN5xO6uo4xwZD6PNk0NHg4+ki0EaNcfcsdX5T9c0/K/uI+uNp06PGQ4rg1bJIiD+t0uEtYY9dkcKzFIecdupMcep/MUk1940j6XfX6Smwo8P8Nz26Ot1qKP0FqxunPdZNMurlZBMDfSrltNAeeqcohZ/AcRMI4eR0HDukvBg+ni0zDFLD8gVE07wcY2JQIunhzykYDQ7JqB6Sts74q96i3VmQpKwXZYHFDkRyWTMv85gonlbEHtJfr8tMhJApoOUmnHr8UzI5/XCrLR+vQ8HcDsNx+3LAjyf69fNjbVgijcTtFeRwiAZ4/OeeB2X0y+k12YgfLIIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(8676002)(38100700002)(316002)(26005)(110136005)(86362001)(186003)(6512007)(4326008)(2906002)(6486002)(6506007)(1076003)(38350700002)(966005)(2616005)(83380400001)(52116002)(66946007)(66476007)(5660300002)(66556008)(44832011)(6666004)(508600001)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CmftArMa/TDNaWDhK0wTCO7eUZFSw9SPTOSMgMGk6M8cq+yGCBO38c4p6X0z?=
 =?us-ascii?Q?4M1yIFw28IY8PT0xzxKt1CavPPj35e9YrV0HKIyPjXPyE2EccHYKbXnR2J6t?=
 =?us-ascii?Q?CRdzg4RohRvC3VKGgeUL/enzRAGUtylFnQPruJL/hI5RoHIybKkVj3HvyYX4?=
 =?us-ascii?Q?5E0K+Q01wqokeTWmICNxA84wGFgkXeHyERjaqrq6677LAzvppFg8tjCvyHP5?=
 =?us-ascii?Q?Uk/l/DDjxY18QWvPxso3xJszwpAXvdd3G4CPm82rkPMZHnv7R0VEMAqQWu99?=
 =?us-ascii?Q?+TWhEOm61uOSiylG0WxPh0n9KZvwdCgPcT9W1WEf1p+a8myRzaYpClRj22Mw?=
 =?us-ascii?Q?z/viuGkQfVDFy3Vbvc/w8yYhrdBji6+XRizOdXPqNMhEiVx23NQCs/SbYuMl?=
 =?us-ascii?Q?Z6l+AIYG0oytILPTCaeZeJbx5nGJdq3BOCvBmQLl6bE2rqH3ZJ1mNlVUMfJa?=
 =?us-ascii?Q?Fzv+MNqbvbrt990IkgSyHrroqt73/CGkMJ0fFF5xufR7nAnJtJrzGVcLDqiz?=
 =?us-ascii?Q?J/I21z4l8SkAu4la0//H3LHTkAFlRAs5ZbvC9ebD1sZS7mqOCJ/ygLof0NYa?=
 =?us-ascii?Q?T7vKRZF1FL3MzCYRgksgR0OrqDFL+0mTSeJe6wJKDx+TlDmmnv4lgxgBa8yJ?=
 =?us-ascii?Q?o8+29daU2lbZJc08DY3DtquxsFhlE1HTSngOH+fSoY0rQaSMAS+QyQk19LOC?=
 =?us-ascii?Q?yFnOtSUogUCXg7Vk/p+ifECHKISaEaVPm/pHxGhGjIoM73FtJWnl6Gfc88du?=
 =?us-ascii?Q?+HyHa7pmcvvYMIG6bsohS0DgK3oRhxbV89/g5Aa3BIV4AOoh+ikSMBGTAk7f?=
 =?us-ascii?Q?NL9Lx4eRhbO6L9+FPXTRdI99jbGYFwK9WgrtHqR+UNca26M2HmbMbQZqYKyo?=
 =?us-ascii?Q?yAYGu0pBU1M6+/gyFVe6nj6v8HHNIKFSJh/5Pf6SAA5Jh3qqOaxvKGWYN+H4?=
 =?us-ascii?Q?LqAUtXh7ncrB9tEHWoizkxMS0LWRZGEainWaLB+IqJAfeoRzwnrueFTpVFkF?=
 =?us-ascii?Q?8lrZej/YEJRYr4iK8TNHgx2wt/SbWMup4cevgx+pK00OW5uzEgfcwkqFfihe?=
 =?us-ascii?Q?I0F3f21rRP9cJqYRQVr7e3UwcSXpOxrmtbGLYgpTp/VRI17DaUT4Er+Q8eEQ?=
 =?us-ascii?Q?2zKFGDLZb+5lOi0Db4l//WoQ9KdUEJi4hOMLckdmtz6Hkx0knoC02YKK6MNn?=
 =?us-ascii?Q?k9xQC6vP3Xz8t66qGK1L1V92cz8PI0dqfrtVDTM4RsRZa4ceppusmwVIGTKu?=
 =?us-ascii?Q?5WQDhvEweN6AW62KRedLEh/eqVOs3wuKtblt1lqLVwNza0FtIJNLAj7B4eau?=
 =?us-ascii?Q?2/m9145e9kEMTwu9MWWhywEbK/g7RP1U69/9vqZcElXCji61X0iZZ5u5z4Ew?=
 =?us-ascii?Q?cEkwXTd/idBFNYJZrGTYDTcM75E8YUMfxSLDTcvCnixJFeqS7ozMz0Hawv0w?=
 =?us-ascii?Q?LcQDB9YTqnP5dcQDjM4L1ISKleVJWCMfvPeMFJX0MNrHOqIQrtS6oHBjR+RX?=
 =?us-ascii?Q?jnO2LmKCzSrzlOHKw7EiI8PaAzU7ax17kZ5e8cBmJV46IcbWK/1eLUchWZx5?=
 =?us-ascii?Q?u5ZDbzB7TELCkls4EOsLcVqPZG2ObvScBwblpnukvvoMUuQbli25iXoSWi4t?=
 =?us-ascii?Q?K3Fd2TbDFnD+tZvll2uQAOQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33727ab-95ac-41f7-53ac-08d9c94a1862
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 15:03:52.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv7rVi9y2oUSXl5fLehCDoTy2ij+193e2mbKhdX+FqhobOhZ9yOgjaN08LDdO8op4nhswdnVTBdyH6MLBk9fTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link between an imx-bus device and its icc id will be done
through the fsl,icc-id property in each dts node. The imx
interconnect driver will pick up all the dts nodes that have that
property defined and will link them to the rightfull icc id.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

This is part of the following patchset:
https://lore.kernel.org/lkml/1631554694-9599-1-git-send-email-abel.vesa@nxp.com/

 drivers/devfreq/imx-bus.c | 40 +++------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 9d8dc9824d21..95339de8cccf 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -53,36 +53,6 @@ static void imx_bus_exit(struct device *dev)
 	platform_device_unregister(priv->icc_pdev);
 }
 
-/* imx_bus_init_icc() - register matching icc provider if required */
-static int imx_bus_init_icc(struct device *dev)
-{
-	struct imx_bus *priv = dev_get_drvdata(dev);
-	const char *icc_driver_name;
-
-	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
-		return 0;
-	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
-		dev_warn(dev, "imx interconnect drivers disabled\n");
-		return 0;
-	}
-
-	icc_driver_name = of_device_get_match_data(dev);
-	if (!icc_driver_name) {
-		dev_err(dev, "unknown interconnect driver\n");
-		return 0;
-	}
-
-	priv->icc_pdev = platform_device_register_data(
-			dev, icc_driver_name, -1, NULL, 0);
-	if (IS_ERR(priv->icc_pdev)) {
-		dev_err(dev, "failed to register icc provider %s: %ld\n",
-				icc_driver_name, PTR_ERR(priv->icc_pdev));
-		return PTR_ERR(priv->icc_pdev);
-	}
-
-	return 0;
-}
-
 static int imx_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -130,10 +100,6 @@ static int imx_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = imx_bus_init_icc(dev);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -142,9 +108,9 @@ static int imx_bus_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_bus_of_match[] = {
-	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
-	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
-	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
+	{ .compatible = "fsl,imx8mq-noc",},
+	{ .compatible = "fsl,imx8mm-noc",},
+	{ .compatible = "fsl,imx8mn-noc",},
 	{ .compatible = "fsl,imx8m-noc", },
 	{ .compatible = "fsl,imx8m-nic", },
 	{ /* sentinel */ },
-- 
2.31.1

