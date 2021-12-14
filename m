Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BBA473E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhLNIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:48:09 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:61006
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229577AbhLNIsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:48:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7ngCEb1jMz4V0YmCCe5HqBVtOW8xj8vZ+d00wfCCU/KIhnxUj9D9x+TDoQDfc7Ui8EtivFVv2PGbhuqKjqxMFh18NweKrQQ6QZ2GhHJjg3gO5ZEenU5iEhifBkNhVHukMwPFftsRljc6OeyrsnBzGGZE7xNrM2DlCLy/wYwOJVtQjaJA8JRaJNwVoD9tgDJaWKtBPIWNRuoDve0ORsBUL7hbWfbnT36TAqy/WuF9LAJ62vS8m66Q9wqneHtCoVoWAXveyyy3ndcXb7taMg5ZFhpPXYUWoLPfMh1zczKro2x+/D0Kn+SVlWYAgB0hIjJl6Mlga5WP2lxeVmVOrhD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKMWpX6wPDbrBFSVL6dGOn1actXFduVgS4kiFqUeE6I=;
 b=iFznAzl/u4bFRWH0uWtmC8RImOMeSSPyVQS3x03DoCBV/YVsjPGpghWmXJar86jSHyNVZUKziSYXUdkIndkfFjxydKdj0fAOPf3jr1ljHrswaVJQ3nibwfHVJIpx2snz3rdEFfxPLXYGvdBlK4uxMYRRbr69SAZqOAlI2IbhupHGLxnJTDWDGbE9pa2m6R8JEu0XP/c4MuVp0Dy9tQm5hTEHbtWLfvjaiOhz970R2x0NHuYAYQw2qIcA68PGQ9u+Xxstf1h0325uXI9Rk611TFFQglJOnQkwp7D+HCY1mgRvlDhzBVStOz8SBu8GzQ9wLdZHt2IBdOpv7JciMvmM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKMWpX6wPDbrBFSVL6dGOn1actXFduVgS4kiFqUeE6I=;
 b=EGcyZQlseTZX1yqoO9OfZUUqsC4EvTkN8WBgB0hrei3fNbpyoY2GuAZqc2CPOCPvyJbfNzqwtMibjF7L7Jps5B7TDEq5JRBak8JA3pWulfL5Bru8zi1KsvWQEYQHIVBnXnFFlpACiKENGBMyI1i2WckDhhOwlPIBEEcch+maKy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Tue, 14 Dec
 2021 08:48:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 08:48:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     tglx@linutronix.de, maz@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] irqchip/irq-imx-gpcv2: mark imx_gpcv2_instance with __ro_after_init
Date:   Tue, 14 Dec 2021 16:47:11 +0800
Message-Id: <20211214084711.1357325-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SI2PR06CA0014.apcprd06.prod.outlook.com (2603:1096:4:186::11) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 08:47:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e99be91-6577-4dcd-bf03-08d9bede6e73
X-MS-TrafficTypeDiagnostic: DU2PR04MB8712:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8712416AF1C369D68A7AF115C9759@DU2PR04MB8712.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Klg0WVRXJkDJuNDZDUp0g9qXlwcT5R3kojFUFCjBvlaRiL4oLbDoQeUXu/NEx90wIXOxuN57BxzccKyhcc4vj5pt76EpU2057067V1ZJ4sxi1J4+pKl72zx0E17Vpdjyk4hT9wDCv6B4awLvN4zqFhtaCGhugaPRAoS02klZQtLPHsAuBjk/vB3/vNo9qaGmr2/TvTPee7pxJuFOwqwC/PGE9MEhHWOrK2CXfetAffAaB5utARQy9v9GB58S2enAks4w0ZdSaPHHqn8jNvtK9pzJDjep+Ijy2TyB32xAietzYFephZMO7cyAhkRDKGNZxtTbztbztSfX2/EeA4sBtfsE7yZhPgTi1m1hZG4guLmEzVuY0takNE1J51laQbVNc8xpJxkBYNNn4IHysniVU+3iN8v5hVAMcx7QyWjXtfmuMeWv4okO9/k2rvnjn3FqQ/8ZrRPtQgHAnratGnImEJMkl376/H1577vAnXfMQb8Kch5YHf8ykxcJ7aNcrGM+RbUsjzxQ89shUiRRrVBrTvQ/DaGChTnPMbVD59Ht3PYdCe9jlyJP6/Z/ROG7t9dL31oKmDR5EEwKGK0zjqHYGyao4X4wky3nNfAz7kd1zh58dSFxsx8XcJ4B2Ds8RzowzocHPQJuyTrPO0HgbMlrFBxtKD609+dEAddeP7gDRAVWm9jzoyFFR+aTWb0uY75jJIUOr631aU3edJa0Vj+yYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6512007)(66476007)(8936002)(2616005)(6666004)(66946007)(6486002)(2906002)(316002)(52116002)(4326008)(186003)(26005)(66556008)(4744005)(956004)(1076003)(83380400001)(8676002)(38350700002)(38100700002)(508600001)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3G1Y+x6hj4Q6mEPv3fnHIVYiORF+E/LHgyMl9n34MqdEgnleNwAMWc73tRJP?=
 =?us-ascii?Q?huOp9nrKl7xoG8aapO5n52b4iz7qXff8FbrBdRjb+pounmYn1zACoHgDXRlo?=
 =?us-ascii?Q?piNODKT+KBaaCN3gAMbtId5qL5vA3mkui8RB3tPYRJ81jBKzDHqo3v3ynAMc?=
 =?us-ascii?Q?78kUmJQsWi8GCK+AVd04+WS5JVuqymfrRSpyXBuMQQhJjgzp4Lpq16rpwXWG?=
 =?us-ascii?Q?wkc+f89mdrR+azDtApvzlr5sOxfodLEbOpHVzizZX3foA1h2YtZMtsvOWgtL?=
 =?us-ascii?Q?VVrmDgickWN7bJRAKuDrtF1wTgsx7qrkK6dAcdyvyXTDM7qHm7b3Xeu49CIE?=
 =?us-ascii?Q?HxCrr2dGeoXCT/Wo/jT67B81Uav2lxzyX1bwGlUrtqJ9Ke/w0Qy9kRW16wY4?=
 =?us-ascii?Q?GgppZVNinAG/9Le/MBSXLua/wH1NH7HTGMvqIEGtp2QIJaR5vmAMKDsmy15l?=
 =?us-ascii?Q?J7oOdO8/amHVSJlcPSOtSup15UjHJ6b8pRA3FrJ+vja5bVgbD2bQAyrQhqLf?=
 =?us-ascii?Q?MTwL3/RqJ7qUfl6GBcPietgAExetCB6YcrS/rqL8BKf7iq2ztFU9Pki0jUSj?=
 =?us-ascii?Q?WRV5QR2IYwboFHzYbCw5ugVrZJCSr6LuL9ymefegB8EGekvNw8l0SioPW94R?=
 =?us-ascii?Q?om0puQHGGx3CMTVB7BlHN1QerVsI//QBiDIiXbnJ+fF3PMk8ieX3vVypV46x?=
 =?us-ascii?Q?NFsMAfML/TcIgg4P9nPIPSJ+lS8knPDirtyFCtyKgWeEdU1Jxji8lW27AMDJ?=
 =?us-ascii?Q?HOot3yyGEIIUNNhyBVrjq8rEEzzWjwr5OUH3xtpzLKZeaXfI+I791BQY0f9u?=
 =?us-ascii?Q?XwbAsAMe045THYFRJ6tzPtwYTAp0Szp3RFgD6wr5ItiUdaaY4cmsVb7NK/GH?=
 =?us-ascii?Q?a7mdQw34jWt9svIQnjgkk/Vv+DsnfiQFRd+H1OZ6DkDaduO1uHqb7A/pl1RC?=
 =?us-ascii?Q?xvraJcJjO9f/Dm28dvCzws07CUlx2ZOzbY0opitmQGNMLzXalx0bCjQbmsZ3?=
 =?us-ascii?Q?lUaVVFnslDT8fnKSONAMsQdGjTHzlvWZx9ZEStLeLaQkLo/EZDgzxdFK7xts?=
 =?us-ascii?Q?SGrqRVmssKm230wteBzID1qvcHqkKR5DIYkhpO9WIpxgdqUCfODDzKtzWMK/?=
 =?us-ascii?Q?Yp6bLk0BTNQP7g4flQxYJoZhmmAJ1ne205nwK4dBV0TzunH9fQiSgFo7NDMi?=
 =?us-ascii?Q?xFD/PbzmmEeUEcrC3QPpiOcXr5G6nsKZ03twN/aW8MhwxFTUjPhnFwdoqrAx?=
 =?us-ascii?Q?TWTnTNqcNoeQSGKeTVD+Wz6vv8AHp+YwiFarMWAKwR9p9/9XWcVzU1Ef4HuW?=
 =?us-ascii?Q?5cdING7n8NfzXpTkJ29lgAchI5TLBuxVpEpiHyAypIeubu49rClFxWQcHu2q?=
 =?us-ascii?Q?FRwxLt4CicOndC+9XgmLE/S03UektPpiWlCcFMbU+X8OdcIWAxZ0lFYABRX6?=
 =?us-ascii?Q?+TawtYWVmW5UgIxtyDuY0fnoSWVPmrTY4ZoKw/5eBnzCLhnjJsz1OeEdYGqE?=
 =?us-ascii?Q?sYo10tkE3d0vKz8gJGKSQSVmoHxUhnytvomPqqUmXedhhMZCjbsXA1JoM3n5?=
 =?us-ascii?Q?MZVJY8cW4vdj2d9nQrVR3ep+YJi1N6h6Lr9EgNPnYi4vJgy5RconCZzJpkcH?=
 =?us-ascii?Q?U2++KCR3ZjOqLX5KgaXCjpI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99be91-6577-4dcd-bf03-08d9bede6e73
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:48:00.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHHcFUY/ZaXMa53nMiew5eTtePMWZarU3nOA1Phm/Crd0WJY/zxZU/pR6ZTPLyOn7b5teH0my4jZSuNpAN1s3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

imx_gpcv2_instance will not be updated after init, so mark it with
__ro_after_init.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 5b5a365dbd5e..b9c22f764b4d 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -26,7 +26,7 @@ struct gpcv2_irqchip_data {
 	u32			cpu2wakeup;
 };
 
-static struct gpcv2_irqchip_data *imx_gpcv2_instance;
+static struct gpcv2_irqchip_data *imx_gpcv2_instance __ro_after_init;
 
 static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 {
-- 
2.25.1

