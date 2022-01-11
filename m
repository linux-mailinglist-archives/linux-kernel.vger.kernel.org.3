Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C748A671
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiAKDgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:17 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:13799
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347400AbiAKDex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dstE9/9gebhxhgXoRfqUionfQPANloKS1H33h+Ic24IkYEQ4Hrp/NBQWQsdCUQbIxQxodX1TTzfOxAqIzBRCFvoD7vxB5bmu7CKw17oq9vPueBsdjVlSdicJOgcBkHDOrYjYpp6JXVhLxEPIPk/qel/PVfKqdO2vkzhlFEDtJ32r8vlYPinEcOneivhfAE3AvIneDlsoh5n8m4FVa0yozlFCnKccfimoiGTxdwCaHvm6g8ilaXOTHJU/V8aN0wnwdYUrKc05KUYmzs9DxeWJ20g+RVhSKIK13ciXx9qOFy7+N3HNa9nevc0J8AwigZ7cWlRS4RrCKGt1xT3MNCekQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW990QU0UXEpb7bfVob1NrGOsD3DOdtKxo5hUVIajiM=;
 b=oZ9Yo6PyN094rseHUFOKhBCU3tfSETue6PS0FCaEKsySN9P1F+ZJQxsWJ59JqeEICYdeig4xW3EE4Wg7WP+sfLPY7DbC8uqCqyVKfidgHZyAa9aNmFwx4ObodyIg31c6jYLDGGsv7j/YVW27lFH+5XozSQL39Cb8yOuibsp/u+OSUCN24cpiUa483G6Hyh2y4zBfpRW6ig7NR0c1O7afexTQzdmqL99zCo39R1ArOkArhKstnMUKzERC/CnLnon0Qf/VU2OBGLPa6TL2BeqtH/2M+B/iOKXpWT/xjiRqYb93xM48wR/Hk4DqBV7qwDfwGZwWICVQdu72Du4fKCcAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW990QU0UXEpb7bfVob1NrGOsD3DOdtKxo5hUVIajiM=;
 b=T2L0h6M40tjsPoDwW3Kg6YCHGZp1zVFEN99EoJSaGcu/LnFTzGw6gb+Tu9ucu5dh8lhnV5Fj0L72tWL2ERDapUQswXuV7Wh/N8LC7DQ//9V9j//SF5uRHdAVzKx6BEMRoU+7/vfqz535VpyRISagpsZGUnxmCYzQ9HyWnAel7OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/9] remoteproc: imx_rproc: ignore create mem entry for resource table
Date:   Tue, 11 Jan 2022 11:33:28 +0800
Message-Id: <20220111033333.403448-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111033333.403448-1-peng.fan@oss.nxp.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 723206f0-220d-4dfe-00ff-08d9d4b3536c
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8725D937696E2C560105DFCBC9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RKYw3VlxB4GaOO4OrgTO6RBxefKtkI53U6IKUsxuq6uB44OrRZSNPg07JnViaDJyKIQUJ84buYchDZc5fwp2GNzKR0y0Fh58jqiu2ABsDJA7eCnFPgNqTwTDNvxjMdwo968vUKM/nuZogoSC8eY+IHXAEtHS7dpYRgSARPFj5xw8vMYuS2LDS7Bmio22x+ZTCGY0pWFu1bZNBoox/JAcqtJM1mqwzVulWU4t3YncJ7Y2t6jg6f5mFR31jCVwG+GfUznYANVZgBpnrWKe8T9zTje175ExPdN1bWGI0+24GFTMHItWl5AER3WsTBXm6YUxwlrlee8Gjo6t+IslAOr53I8dSN48bcLZOiWq7xze8tkQ6QvECL0eVCe+GMWZrfzZXemoaOAb5FdDhaxnKS1FfNivKFtHYsWlHda4B9cnDwIeb7OpZQtoFNtFPFvLFB6K2487/u5YsFGlfbikWoxKP1hH2wdE8b0muy7U3uYITd4wPzZt6s6hCD/LjLUEZaU4Q2Rj9n15t0dczGdNOgu+63yNOuHrohgNc6Fa5QsNTNTV/Jj2OTbLk5vVRNrB0c/wXU84wn31pcnfHVvZiMBQbVLFOSfWk4Ikl9rKxkRJjI338CM0lBV8+asNe68aeGs/nJU3s5Mp7sIH3B/xogq5LHe7KjBKxkX78Bz5cLJcXtJ0i8JP8OqPgrvbM5H7vhw0Bpy7Djiu54v+oqzh/tgOpyFCkRvDyO3PjjdKd8UHJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(4744005)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mOQDu9XECQzSX1zUlaNz2UnKrNVgZMRgCowJ47l/UNvClUFXQN6whFpAfXd6?=
 =?us-ascii?Q?JWQvfRHVRvqSvMcdYBpz+a7Fzt096+JJb5JNNOAULjY4ti8EvImuoaSUj1eZ?=
 =?us-ascii?Q?bepFY2Krja0A64tkXiHJthHXw8yrY6yH2QA6qkmTZS9htTkaEdVvXTYCSEgW?=
 =?us-ascii?Q?6nC7rGqovC4igsAgqVTaPIKuM62whSUFHy/hoCAFaRDK6VJZiNRtSbTzusCN?=
 =?us-ascii?Q?CFIxmqZ79OzZP1ZFRqswll5htVXOM172/QQMhIsOAYS9kawWewKrpkqLvyE3?=
 =?us-ascii?Q?nYYgXZHe8UGc3bAJjgEVwc36marRZaFHAUuabIgStvgPzCyDpVfj0p6zuPdU?=
 =?us-ascii?Q?UnYrtusnWHBHKSgmAB3YX5ctSFY6AwlzQvQ1cnFI8hgaTiV/+I9l/gno0Oln?=
 =?us-ascii?Q?BMoAbWT8XbTVo5TQkYLR3s4svNsiA2srOxBjdxBi/swxowiFjzoChK/H7P2e?=
 =?us-ascii?Q?rMqNEbuAM7sKgdmq4/C4cjAs/1oWtGxRz6GnkTXs6qIdj3oe5ko4861vU7Su?=
 =?us-ascii?Q?BHIvC7M7IA8KYq+3LZH8NnnGglZDstgxpZOX479vUuxRY090gLdQZiNyJTok?=
 =?us-ascii?Q?EnKq+kvDTkq9rHTKOa9RpNxq7+cE9uAYHr6La8M7UziRyRrlZBuIBXPLvuMl?=
 =?us-ascii?Q?57NLZzm1GpEwGRholvn+HwMDojbt2/OifGqg3+t66SFuEmX5/NTqVNFCurIC?=
 =?us-ascii?Q?lkDONmcUfsaXWe29OpSeLtaJozTSASuSXlkDP7hw9S3obECT2WWdXQfDOALB?=
 =?us-ascii?Q?1DTddhQ0Mgxb23lAkLkche2SvkE/tz1VbKlwsEXiHv7gjslGOk4r4DjgiOUK?=
 =?us-ascii?Q?IAgG6QYRW5Vy9pRYtSFXSV/ua+7qnKCECgqc2XdB7ch9A5xUt9Q/yp2jCko9?=
 =?us-ascii?Q?g2upIViRacicnNU96Ef4EBeuu0QSpEhW20EFo2AZY4jl64iIsKRaFykRUvde?=
 =?us-ascii?Q?qu2z2XxTmvZQgUENL2IWHnrPG1juEp1bbApXp/HCl+K3B/VN7vnJknl6eYJ0?=
 =?us-ascii?Q?z7s/4gLpF18whrG5eXpEv3B6Z5DZkYZ3iK8/Fawz0BVuHA0M6vjb9a7FVqX6?=
 =?us-ascii?Q?8VxXGbln7NnvRcWo1w7odRU++SRzbOs1a0BfSpBtm/Hu7RJU+MGsmEZnJQOs?=
 =?us-ascii?Q?139vDs0p/f1i6n9g2nue8TMvMxd/DRI+TwMFeUGX0sVLVgMCdp9swEnF9bQc?=
 =?us-ascii?Q?JzCzo7ZDBw3aacDDGtFaRKhRLOGDv4xTMCIBVsM9gNYVBJqy9lp6pT43VbzJ?=
 =?us-ascii?Q?oHnHgM3WBpJ5/Fy8ohSnBKulhpaufrCWWNYIECViYBgpZeUg18QrSHH4hbom?=
 =?us-ascii?Q?TkBMMb3FvZrxmxmFUqSeEOJMdR+7F0Q78yxg9kIU+q0ut+/AeKQRy/Gtmwo5?=
 =?us-ascii?Q?fr8AE+fJ9nd79SPakWp9mLRtF0R19WwwjqufrxAO1aOg6LMnSD0Q/2+SByj8?=
 =?us-ascii?Q?Lflvp3ntTZBbv/x79gM9UXoEcRjgzy48ofVuZaiFXxeGEzXFEqkooSCEnkUc?=
 =?us-ascii?Q?vqLDpo/hQFg3BJoKdhibMFb4+qnu1+KMMSOa3QQFCvys9/qrfMP7PA7JNLo8?=
 =?us-ascii?Q?/MSSBMXwKvmQcHAOhlasFXII3Y9VySPH614zT14AlJ1faUTIag14RxgwHovx?=
 =?us-ascii?Q?VlE32ScUaDXHXB8SejKfql4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723206f0-220d-4dfe-00ff-08d9d4b3536c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:51.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8EgvjFa8RuIbQYM26KuTUsB0Wgx/0YXTJVa+RZbIdQtmedGeeFoQQrpQ2f7m8FdBP8JwG5jJi0QZ+JNcHINhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

resource table will not be used for memory allocation, no need to create
rproc mem entry.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 75fde16f80a4..7b2578177ea8 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -423,6 +423,9 @@ static int imx_rproc_prepare(struct rproc *rproc)
 		if (!strcmp(it.node->name, "vdev0buffer"))
 			continue;
 
+		if (!strncmp(it.node->name, "rsc-table", strlen("rsc-table")))
+			continue;
+
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
 			dev_err(priv->dev, "unable to acquire memory-region\n");
-- 
2.25.1

