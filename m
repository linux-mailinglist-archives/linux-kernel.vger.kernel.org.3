Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143B853871A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiE3SKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbiE3SKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:10:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE09A3083;
        Mon, 30 May 2022 11:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6/911kj4Op7MpLJvhbQh7+glqJckd8mIDH9HiD1qfPJCrszJWohf4kPV1zUri95+9b9Ba20a5T9Du19akpL3/XjuwyYPcok/2H/wMJVYRv9a2vImfoxsIiJHIx7nZ17m9AqD22LHxDxZOJwU+Id6M8Q0BLR6kAGgnqlQ3Kayww+5x9d9ZfIIJ27sJxSqMtVYG6pZGhEjZrvPKmkImbMbmFmmcz/AtB/3zdTtPw3IdSC3PIIzG9XvXt0FJ1Ef73szL2s0akBm0xUfop+sA+aDKMziQ3iXoe6PckRatupOhB6u3BOXdz6rpAqY6LvqkA+ukTAzQ1RbTilTqPKOzBS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70S4952JfaHb0TDlKokLRnv6THolE13SPrXlx+nj8X4=;
 b=LEzzAcv0p10crYG4QuSxmHBa0QYLwSy3FYKg2qu0J8OG/6Pm1xr8AFmAoVfO8fSDX81o5lqTAzrSMorGTxCjMNBn4A8BD/eehBAfEXbo+t4p7jUT4ZlW0r9iJNXgA73If7w7WOS17PWjAyLtIoanTTrMWzDzCCKofqK7OmtpMETTbxSwWyu/+q+KWGA28rhM/C5pFibtE3+SB0GIZ1W2NnwMdADLDtCE1RQzbMvyHBxY6tXi8DSCHPDgLAJtCQKVERFfAI38NGrzatnSBn82H58Smz4Bwe8d9+PgLe+Fv6TVMWUcZNsUQT5xsvquTsiwbFOm6lmfkQJFwiHp26EXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70S4952JfaHb0TDlKokLRnv6THolE13SPrXlx+nj8X4=;
 b=fjeikNe5VskE06AHHvDrDLfNL6h0isG80XK+8FYYwkEeMLQoQ9ugP2vyDUC015NM5ED2ScO0g47g3TaD2Iq/Qkpa6sivB1j6L74y5GojO7kdLAF/iOrhbVe3J+yK73SXn8qjut5LbmMRrelkx8iz1QCmlGL7whvWn9ZfHWQCf/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by VI1PR04MB4462.eurprd04.prod.outlook.com (2603:10a6:803:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 18:10:00 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d%9]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 18:10:00 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     horia.geanta@nxp.com, gaurav.jain@nxp.com, pankaj.gupta@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        silvano.dininno@nxp.com, V.Sethi@nxp.com
Subject: [PATCH 3/3] crypto: caam: read entropy delay from device tree
Date:   Mon, 30 May 2022 23:39:24 +0530
Message-Id: <20220530180924.1792399-4-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
References: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 465b5490-841b-4b19-fcdc-08da42679cd5
X-MS-TrafficTypeDiagnostic: VI1PR04MB4462:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB44621FFBF6AC35AA29E34E08F3DD9@VI1PR04MB4462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuRTS30J1OO1VqyP7aaReq5eX6NjekcvIQYwsxfk0Ib89gCGfD3ryCGe/fNsA+wgO3KgENSS9FxLOyrTtHO6ppv/Fq7Vk+CFr3BIrADKO6DL8QlYgTWo2xQNvw81D872X+gyDahnX2FhsCLt96YjY7MjQlYgOeDFNawF3lmdMMmp4aXlqLAX26D/xodfq4u+9MFYvUlNWXrajbTjGlTsiLIyMyd5QkGnpx5on48Wq2k8ZDwQrkW/zveppm6Zao9qMshycAlxxOAWEuMRHKHSnj5UvPx6mSMgo/qOxeBPx3s9OsClITRK7S9WOpcZCA39dlEtdz7Al/1F9tqOi54c5gIi8SeCeZpKQdhoiQ5A6WcPO7Qmm/3rrP7axe6S95CW6X5SXKF30D4nEClSnZYPiQrHpEMOq4/QSGPF3LdSNfunaa12EAJJs2XUU6vlLSgB4n9zGTUUMuTsQSLQcE8e/rfbvx8fipfMZqNOBp6AS16KbOaWOnnEe8TYOBOyY/aOcRgk6yHeAJhOSzlCWMF9a4TCUtr/B+xypU9pDO6LqoiO/eKLVpXiAoWiG7iCctMfyriTY+EvBI0G3lqM0AirH/iJadXa3te6xAQ8umnbNBIuyWkZc9ro+Ty6EuZ7MTOOHC3zVAT3lRShO/WIw7k6+REJvG1nc4D7Qd2VvTHpjc/QHbrybeDNB2G2uxTE/pOFG9bMy1FJOfag+QD7pWNixw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38350700002)(8936002)(36756003)(6486002)(508600001)(44832011)(86362001)(5660300002)(38100700002)(4326008)(66946007)(66556008)(66476007)(8676002)(6512007)(26005)(6506007)(6666004)(52116002)(2906002)(55236004)(186003)(2616005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+XTNmdbI40FoT3uP/w5f17REplrj4R12UxDeca3GamXQgMQgN3OaujvGkyB?=
 =?us-ascii?Q?om/VCQDcaLBc1zUw80w0thDo6kiF8f3zp0tx2YPoW0briGlHpYCDFsKbzpTh?=
 =?us-ascii?Q?QXGtleW8b0+0zSMs+NsIojgyCzFafImPPIUT1Egs8c5YfEBfEMOu5XhKT+dG?=
 =?us-ascii?Q?y9JZUe99o3Ps+dB3zBKMiQV0I68hAVk4KeCS9zg0VEdVnvukcjyY3eMBlk01?=
 =?us-ascii?Q?MZTYK5J25JOL+FVp4Lr86II3p8W39flET5nwy8l99biw/S48o1PMXlV9//JX?=
 =?us-ascii?Q?BVDCl/RZlYBI/6I9BctZ69SFiavLfJbUFMzNc9Xm7qXjrFSyFyvVUy67N3GH?=
 =?us-ascii?Q?9U4NAciIrUreFDMtyMXul/pb7LKztGL5+rDeHseNiTwZW6doEmrj3dilOMuN?=
 =?us-ascii?Q?5mXgMYk6+kim2n2i/cycNs7sSvAxAP+WIfNjVcXsp+VldC8OSMk/J5nsXIGq?=
 =?us-ascii?Q?7bE/I0XG9VLzrhG46ltCmD8SX1z2Y7BWM3aqMbAC5SE14kzzUdADMRHzndsn?=
 =?us-ascii?Q?+TGO6u9aZthjDImdtV05gRn1+i1KmgiXwjZn4WO02zbDJHFwM1L7tJFsOJOz?=
 =?us-ascii?Q?B8vKW4rxdtg4NqaIFqWCTMoMvc9oiKoJQE2kAI/rkaKh2kcfI213a5mmQH/Q?=
 =?us-ascii?Q?c9oYCO1+p6M7zIgRuq68mFZpjvqWwbsOr397osQj/vKw2k51e256ZzDLrlzj?=
 =?us-ascii?Q?HSdpvcdC8hQ7LKntRPau/LvG3NaoLvbL0M6299+m9rFhiCmPNDPfklGfaLe5?=
 =?us-ascii?Q?O8LUZZFNYd4us6KdYZOZ6/lj4FIiLLZoPY2uJvpycnfAfOv56uXWVXJazzm1?=
 =?us-ascii?Q?2PoxWPYTl1mL+euBHAaac67Z4sXi9bS9O5hTQjbytA+i1w0XFD6cgntD5pVy?=
 =?us-ascii?Q?BXuQXYZZy2geefTTOSFeaAHPHyeghHFvPvMEINcw+oUSJmYvycjdXKxCXdYG?=
 =?us-ascii?Q?lyY53aK2Otq8JNaSYlD3eGgzojesZFCciU9pf3RXiW7m0N9psHoiZt/K+lGt?=
 =?us-ascii?Q?P7SFHnyBnds9O+gY9O4+K2UMUUCcI+BuwLOj6TWtvoeQL1C+dwPvZfMfJk+I?=
 =?us-ascii?Q?tYvC/B6U5uLemjsQdKF7NuXk7tT0RPb6fN7aQvOtH14XkXVvWSNaIV8AJmrI?=
 =?us-ascii?Q?FMeDP1FYb7RigaTWGcoYpvKwMUgJkkutLunqIqLhb6BC7JotBYii3SxPJPM+?=
 =?us-ascii?Q?gMLL05yl34ZyL1T5qpIDwGr2f4WZbdKZFPMfPJmb3A2HUa72uiCYD41YiW/Q?=
 =?us-ascii?Q?VOCxeANEzWtv/mRgHwWmFB/sBwyNZW0ut78vsr5iVrpzQM4DRw88KyArSVi1?=
 =?us-ascii?Q?DGJzavHso8oJRJPZ2jLq0kZWncIv7Pmn5DurFp+nEmAn+1rLRNKgCDm51DZ2?=
 =?us-ascii?Q?u6fHIw88YX31VKu6QRb3XQIfVHT8GC+NF5dxz5qxWtqSSSesvlhSWdPcIczt?=
 =?us-ascii?Q?TqDeS2M0HquaObVhq8+037eBbUDX8/t5gOevhZk6yQCnic2zGyrnqYh6Eq9Q?=
 =?us-ascii?Q?OAlSHMJHoRx1/vjIj+Eup5ZfQHviy755EBddbz0YEEFNkzrNmRusirvlqb2d?=
 =?us-ascii?Q?5W2l19EVmtLW2zGHvzDdB4cGtQ/pNY4fnKkEDimxsLJIqlK/KMI4Uuf1vVe0?=
 =?us-ascii?Q?UBxxj5bsEkfdn1h1GrONgVEc6LT6WrpcltVNDEPxLU0V4g5t1snp1jAZgrEl?=
 =?us-ascii?Q?d26VUHlSWU1wdPHVs/RiTPr9W3l4A4Z42m4tQnppHWtBk8oiETNrmxFSsYOT?=
 =?us-ascii?Q?L0I/JWpjsJh+Goo2D4MaKKJkIBU99RE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465b5490-841b-4b19-fcdc-08da42679cd5
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 18:10:00.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWXxdHCE1/xiowE/pg8pO2ltctPNKGuC0+UEfPPdr7I/mcEESrI2zPPc44ITaI/T64Q1samadIBIKKJgxIOx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read entropy-delay property from device tree for
TRNG configuration.

update the value if entry is missing in DT.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 32253a064d0f..5ffab99d831c 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -619,7 +619,7 @@ static bool needs_entropy_delay_adjustment(void)
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
-	int ret, ring, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
+	int ret, ring, gen_sk;
 	u64 caam_id;
 	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
@@ -627,7 +627,7 @@ static int caam_probe(struct platform_device *pdev)
 	struct caam_ctrl __iomem *ctrl;
 	struct caam_drv_private *ctrlpriv;
 	struct dentry *dfs_root;
-	u32 scfgr, comp_params;
+	u32 scfgr, comp_params, ent_delay = RTSDCTL_ENT_DLY_MIN;
 	u8 rng_vid;
 	int pg_size;
 	int BLOCK_OFFSET = 0;
@@ -847,6 +847,16 @@ static int caam_probe(struct platform_device *pdev)
 			(rd_reg32(&ctrl->vreg.aesa) & CHA_VER_MISC_AES_NUM_MASK);
 	}
 
+	/*
+	 * Read entropy-delay property from device tree. If property is not
+	 * available or missing, update the entropy delay value only for imx6sx.
+	 */
+	if (device_property_read_u32(dev, "entropy-delay", &ent_delay)) {
+		dev_dbg(dev, "entropy-delay property missing in DT\n");
+		if (needs_entropy_delay_adjustment())
+			ent_delay = 12000;
+	}
+
 	/*
 	 * If SEC has RNG version >= 4 and RNG state handle has not been
 	 * already instantiated, do RNG instantiation
@@ -875,8 +885,6 @@ static int caam_probe(struct platform_device *pdev)
 			 * Also, if a handle was instantiated, do not change
 			 * the TRNG parameters.
 			 */
-			if (needs_entropy_delay_adjustment())
-				ent_delay = 12000;
 			if (!(ctrlpriv->rng4_sh_init || inst_handles)) {
 				dev_info(dev,
 					 "Entropy delay = %u\n",
-- 
2.25.1

