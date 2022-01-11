Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628D248A660
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiAKDec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:34:32 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:51701
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233987AbiAKDec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exQEhkE4sH+IZTpH9wDrfvlVtuHOuvfeJ1yYjOBlyy6Qfees4PjOKyE63kek/DZus//R2Gk6aO4YfKtVlhQsvbVTo9SgSfwYiMDqvAfVlHxampFliNxds+DhMKD1uHP/KFNESmKzGBry1JUipQxLBFCJfEvxDIBX3OxQx2BrY9M2ynrH0e4eDlTlwd/Lv8a4QVU5HCFTUR0FLuH6Q6mSLuAwMPVDrjtjTEYdTaKup6l1h5j2pNJPHx9ukEccM4OJck9G3HF/Qbwgk3zxZsO5pe1MQ2VeymYnvtjE8hCyJ4IZCitLK4Fm+OMN0o1obCKt3j7up7L09yoruc9zfn+36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfnUAKDE2hrELYIGop5msd+aUYhMqloWVurJ4vqeHIc=;
 b=FijBrMXvem+g7SOfVs9Guy9rVf8K0e67dZ/MVu66cmT+nyE4JX8qd8IclOa58gtafjnCu5yJ2dH8gwIOCIvPCLOsIMlf7upTrnOYAsMwvlZYjrbDopfNrFgk2Qs6oisRk5wVNmkVvybn/snqWMoIjiWJidcC/oIQ4Gffnw9IzBEuYEwdFbUzgadF9Ru7MeN6Z/IHL+kiddyK73upD8Q95ziiag/ufMBQagFC41kAyqz4Sf4BeNtlxG7oYwg9S3cd+R/p4oC+M26pcmmZKDoUCGGZ46wv65tEM9rJkhN9HJVwYJm1VwTZ8mKq2NWGyjxK1Yaz/Ey5tdFP2Fnr8qDyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfnUAKDE2hrELYIGop5msd+aUYhMqloWVurJ4vqeHIc=;
 b=KtFZD/4eQ0RyUJjiCfDA423mLlwuYK8Xd45c9+H48ImHvXU2FLSOaYhuSrWuF9LLRKF+eQ1x67izn/3T54mjI78KoyHaYgVipVLllRRMaILxu6pYygmqJ4Qiqlei5zxMr+Kmgj3PKNLTct9DzybhmvBxu1UBBLj02FmPxfMmSME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] remoteproc: imx_rproc: use imx specific hook for find_loaded_rsc_table
Date:   Tue, 11 Jan 2022 11:33:22 +0800
Message-Id: <20220111033333.403448-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcb265ff-210e-4224-d332-08d9d4b34636
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB872543C2230A8302C216A520C9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLcRoN/7gc3N/LS5tcQhSMqIfxiULACbVFwzK1mULRiYEHeJIjFG2sxVm3PY/Cs8aneYvTotFr6xCqyLZxnZRydARl4voisO+bNAQDUart+M2rp7CSWxvvzlDq9paLZHGiDyABwlDT9hXgCH2dAg7BPPsTgfrX/j6WFZIdw1XKNa2PB3V/gvN0SwJCIBEIqJaLi24knF5MuznI3RYXTxHBGxypQ1GY+KtFAsKbWOXhzMmvSojxFj4LiEx5oeR5biQIOFHf4oEJ4bxK8oSTxtjLg+tMXuJVji4Ky3T8k/ArGG6vwTNsqJb4fFQAcqTDy/Q/0Asn9HYEzR0YJOdkTXJnMvaoW7A/8KeXpdCtWR3KUE0zWUg3sh4+bxHfQYw5/+0vd7IJG2txe0YSwsmJmPJrckWkqyNLSepSBy7bdyPd2kvPn9JB+8v5xhXWXAOHBFfj1oOCdQPn3NHvJY2ccSN43nljokw7nH2KeigEbGuGmmEhgt++KUuu4BrCIUrArQLlPJuI466ZJ2EZ0G3e1ONDX84mWieilnMmYof9NJr0yfqY6FyCBOWQJvi7Phm/tDlrb8xcvwC4+M18GAWxJ9l9QvCM5M29tPg2ColJJf6cg5W2ofFQJvdYqaTVwOtQS5a4tOY04ZHvoPKhB/F2+/tWy777Ep+Hwuyy31/pyv5znazkzeyQekI4sD1unNxpc4Uuch0kuT6satOtIb2sxH+289EBQme39BoWdpmwgaQ6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNMu98fRSo81OxfBxvpGveKtDb0XZjXTh+Qqw07Po/CTj9dM/k+6gJ8+PErS?=
 =?us-ascii?Q?Kv3PfJ19fbz3+NsA5FJtgI1jwhwfcR3XUGSsr488d7NA9k8pqlq3Gv1Dkqlz?=
 =?us-ascii?Q?wdZMPBZkua7z0OoAr8cox9TGNfPeZeP5XSZItLRYO0oHORqUi0YErSTAErkr?=
 =?us-ascii?Q?WkYFHd6PZNd/D4rUFONyqDOno4zuP3fUzQgnvy+Jq8dJQFxszeSaUexKF/fS?=
 =?us-ascii?Q?tTrttqQ/ZUA+fQfvLU5aaI0pU9+gzfNTn1/eYvi1EQ22OsbNNbdjV6hQxyOq?=
 =?us-ascii?Q?BFAqNyddtcVmkW8mw38idrPl5gOHqFvYLBH2658XXbb7UImeu8FVnmcUcKR0?=
 =?us-ascii?Q?+2VPmwDpJ+Xs/f7SwW3wHIY/H3pwho8sBtgdjTCMbtdXXn/JfSl3VjXpQQyy?=
 =?us-ascii?Q?cmlyTc6c85a6fDu3EgIfvpYudXSetsi5CpubH2+0+xKx69mzsa7DMtYmjHIp?=
 =?us-ascii?Q?+XcZrrJjqP2pFz6EwG2hC3SO5LBujxvUNbpdW7NC+YXZoRlSLcut0yMnlDa9?=
 =?us-ascii?Q?i3Aw3YdqHopyfqFskVfrKtG7nMVX1+w/VnsNR8r8ZEm/duw7dgOfKHBPKEzu?=
 =?us-ascii?Q?YUoWtsrh76rJHieqCiu9Illf21/0w0iWLiE7YDvRt7zmoRu3WKRzUh2neZx7?=
 =?us-ascii?Q?huj5InvNvkbodpNlcz+BhTCtEj8WkWbYUiFiTK3dwUcYWLb8xLfYHMmqKivD?=
 =?us-ascii?Q?HRrmEs7HYiWcShc1I4sMY728gFKBSmw5BM4eG9wxYeF7FMMhSdcUPGcDP4uA?=
 =?us-ascii?Q?zhj/nvoowJ/ts1o9JtBp/6aO8bzp3e3tyJEEz3uFR7+XqNrbTeDw1Z/RZS+j?=
 =?us-ascii?Q?pjWwjF2gPf6NMRlG6yZ67fyVqC58dgc3gQja6Oww2uqPOrdeM7eUmrycsQyF?=
 =?us-ascii?Q?UxZYZFFYEpAQ4Lmfnpc/FBsixof8DwG9Dy+xOcOzk4BKyGcW//nvQ3NSIWgs?=
 =?us-ascii?Q?EgiTifT5R1WLH5GzC8jKTpjWUya4dq/gNuJvA83bTsBM4gm9Nylz38HY4i5u?=
 =?us-ascii?Q?+vwo0AfGwm0cj1ffkZ4PCmsMeUBE9lVDYnh6zcDLuPFOW2NEdY9ll51HzFkl?=
 =?us-ascii?Q?1uwVkFdqLyexoIrJvQNqpIFwHPvC6jftwgeT1B/qyQRuENeT+EQNcdKF7FRX?=
 =?us-ascii?Q?sQ60hcwmu5YFzYz+DyH15bbM5KTi8gT9YXVZLuyrVRcJ9bv0F0pAAelw9cQz?=
 =?us-ascii?Q?dHmRUEgXXZhvg75biYmRd1pqCsT34dtCHC3Tp9WOUcC43CGqRKo8X/nRw4Hy?=
 =?us-ascii?Q?oxMXawc9BBPIo9m4d0m1qm50ZmUsD7WNS8Jz1OUB0kDQPBZ6Y9R/NKXya5AV?=
 =?us-ascii?Q?stXXDIDmtYifb2ufd79qWC7XbcZw7++55NmTTYbm3RGYFr4rMLGHk6t2GCoq?=
 =?us-ascii?Q?OCThO0HnKkNWJ5zZMAu3e+tERWGEbA2pIJhp5f9yPsq/1wbh4ruGEBlzVH6v?=
 =?us-ascii?Q?75e8496xQtlsnLo42plHwWVDzDhLg5ckGpMN1ZvnDTjxyaDTnsQ9Xd7YSXBa?=
 =?us-ascii?Q?zrjPnOkK6PUmyA8+yAsurGORnFFdOMGfErj0aaK4Vua8woCXtnEJaTsPmId6?=
 =?us-ascii?Q?jryW0Jhy/iVDnbhVXRnbJHaNKPrLmZe73vujQ/xHLPraSiwHIXYdvfiHsQ1N?=
 =?us-ascii?Q?hMM8+xxs+08CVXMbzXIWmyM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb265ff-210e-4224-d332-08d9d4b34636
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:29.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InDe/aNC+dzXGRlkNM5d1Yul/1sgRmqlKR95EXPP1OC/ABOPDaDH5yOZ4U3Lpmkfw2JI+1uHVgo4fyxHUtuC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If there is a resource table device tree node, use the address as
the resource table address, otherwise use the address(where
.resource_table section loaded) inside the Cortex-M elf file.

And there is an update in NXP SDK that Resource Domain Control(RDC)
enabled to protect TCM, linux not able to write the TCM space when
updating resource table status and cause kernel dump. So use the address
from device tree could avoid kernel dump.

Note: NXP M4 SDK not check resource table update, so it does not matter
use whether resource table address specified in elf file or in device
tree. But to reflect the fact that if people specific resource table
address in device tree, it means people are aware and going to use it,
not the address specified in elf file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit message

 drivers/remoteproc/imx_rproc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7a096f1891e6..0bd24c937a73 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -499,6 +499,17 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 	return (struct resource_table *)priv->rsc_table;
 }
 
+static struct resource_table *
+imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+
+	if (priv->rsc_table)
+		return (struct resource_table *)priv->rsc_table;
+
+	return rproc_elf_find_loaded_rsc_table(rproc, fw);
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
@@ -508,7 +519,7 @@ static const struct rproc_ops imx_rproc_ops = {
 	.da_to_va       = imx_rproc_da_to_va,
 	.load		= rproc_elf_load_segments,
 	.parse_fw	= imx_rproc_parse_fw,
-	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.find_loaded_rsc_table = imx_rproc_elf_find_loaded_rsc_table,
 	.get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
-- 
2.25.1

