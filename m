Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D4B48A661
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbiAKDgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:03 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:33056
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347188AbiAKDef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noH26asG3tEOGywPUAqaujoj4MgiWoVbPLiOHJE8oSaw+xmoFKW2hx+Rj4tO8IfUh7EV+juDsuPWj0ZPA2R4mUkimaAaKcfG5fdU4SQeT5kGH9riORslQcLnkRi8RvZ8WE8osPavjMP8xn/aYrGiojUNOLl5Nr+5BJQzJQSDh/ZQZmUr1sXX9yR2Zsr5ZkwFQ35wwqpTk0apbXdbP/zwTfpvaUMTWw2UaVnfSnnrEULFKRHnbUxfDigCfwjDLHqsMcqXTktlXKaU/lpsiUZcpTs//UF0zjFtA33JYSbT2/2p0K1dMniupb6KiOh0LXJ1inbb4hzZhbX58oWU4VbU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d85UYU0OBggYpx7wyH4M0D6F/kqurtjsEX4sZ0kDHSg=;
 b=PwXCQEqY25RXud7DJmEkNIE0Ti5xQqX+QGgP+VtFcBw2rOQQekC9DFTiQ0xNVadNdkXNRN16xpKbCvwzNsgNmwzzPdBtOKTvrff6ydHlqFa4CxFbjrneHD39FYCMIg2Cy2xRfBJSIo47QSGC7/Z5tUz1Cwt6Lp75sFVBfUsJhcz4yIcP8NHXzz3l2ThMvYoU85awqMOkjHe4k25zi5ba79Y/mht90DVZB656tU+EBpkmnK+0CrVh0nS8uKS3+pzOCtfr+LfiC1mev9zc/wIPdlt9cdRAdgEC4t4YN5HbKi8cX/IXkQkEZY2umbz8XLbYH9aGy6enusjId7WG5PZzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d85UYU0OBggYpx7wyH4M0D6F/kqurtjsEX4sZ0kDHSg=;
 b=SztoHI+6mpCRGiYhK5S2ylrmoLTSrTk6hXYE2CkseyaOq5xyETvvLj1oTqEYywudfcA/05w4Q00YYs0Sg0vPj7w8F2RmfSjqeOcmlTC8030MY2o84ZFI0Qmb8uFTu5BTn/oc9FHNiJOVlpnTVqH0z2D7taQ54r9oj/hk2G2rY3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] remoteproc: imx_rproc: validate resource table
Date:   Tue, 11 Jan 2022 11:33:23 +0800
Message-Id: <20220111033333.403448-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1149fda5-38be-4af9-e1db-08d9d4b348db
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB872502CE99464576439A3B57C9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ns4UTGORhmz4G5OEJZUeY4tcuVbvGvhh6G93CcAMW8kxkthao/HEabOQVucAJ/R0U6SjBWXEBJr18hlCkIGB9VYTfSqXUuPQcOPOC2dhvfUevc95FdfaJGgWhzIZg+5fcuH5BRiyzzp60/lkBZlbSpY0pfY1KIiLYXj7qKom5ciyvbmha2VlZJ6beT2hyx/32hPVo8ndtY4wd7Em0GEz4eXsptsEJBHHupzlaXWJ3MImLRiELGOz013WwcS+xpKfOPJGiflZIYCPjqpxuuw8Pb6eU+vt+zp6QbD5mxGTwQp9LrtWQDcpXLz3cmk6FS+xgKvFAQOzEieXFAHf4adK2swgf0o2G1rBpvXEiXsYScspc2MIG9iBPhUU8Zr/1XJ5QNny2RI/1semwV1OmMoSVMfgkn4f2N3d1KkBBq6hxyyYfn9iaRcwDoi58GKMq8/6DxnDMuuTdb5lRKuBUKAB4uSJHxdy5cTXp5WIii4tmffrAhLIjwiAtfOQGt+8fWmYx1wxFZ15eNLGzbxeuwrqBijD0k9XgSlFo6sBPHAepFrFy3NfPRoy6WtxiI3Xcr7gJ0KTU7jLgPSkzHqh2BDJBEEqG84ifBjCxHBUJYe34QruLxeuR4hkYNVjBW3m3CHqb3LTB1kpZLRkT760wS1zeipynbGocDIH9LhOhQ5qB+Ez9kE8eJDojlgnMo2KIECAfG33ZotkUYl5FmhiTKscOf5IynY41KRrOsglwz9nXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(15650500001)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4b+IoP7EDKw5U5pEO5Kv2mx4IArsqgZ+7F0DzEw5JvdrxyQR8R67yL1F4hUA?=
 =?us-ascii?Q?90jgGxv6rBk5/SVvYDhobZvzQZ2KSp79cWD6y/aj9TWkTAV8OXCfJEHAjqAh?=
 =?us-ascii?Q?BbllG3bSehW3GRMNov6DTwOfLgyP9UpzzEbOXdQGDcO23OH7UZ4srk7TDnJe?=
 =?us-ascii?Q?2UEvMwdWHvLc+KqSzbm1EQQeu+Y8tIxxvNBEjfWWAvDIF+EYPYCI1+uyfjZm?=
 =?us-ascii?Q?PXPC8m26TOjApt0CRH5IGkQgyWOo5gXgP42OwHeAWWJr6RSp5qx1Wn8V9vRs?=
 =?us-ascii?Q?cq6x8ltdnxjAvU7aG1Jz7GUCBU4e8QjUsyVwe9z57NV2+RhotC+kkMJfA5fn?=
 =?us-ascii?Q?nHySV20yHvwMaX8RqFQInGC9WbeaIBvI4sodpW2+N/TLk0yyHYwQOBtiSz1/?=
 =?us-ascii?Q?pb73Re36kk5Hj3P2HcPiAMFmWWWo8jzFPbVP39J97itdZEfk0m0l75DNp8g3?=
 =?us-ascii?Q?J08RGJH8GPbeZGpbknRAmVi6kgU3o5irQ6PI5HE+H708PF35/NExrcG3i44W?=
 =?us-ascii?Q?R7wwPJLX/XedrMjQcgQaQoqN0K0D+KU0EbwBRXlLsBkUg4dBjs5PjhrmxriZ?=
 =?us-ascii?Q?Q8hfTjmbb94R/HxsKEme2bpHDlPSGVUC+4skBZEw70ESdRNfj1YUtm+8ROmk?=
 =?us-ascii?Q?WQBoOj3Zg+LfEzci1I+Upxt4SkI8tpViip1enoKLmskmH/jOowKxlPpIryDx?=
 =?us-ascii?Q?BY1Fw2ubECGljOQSJDj6FLkDn+qk1V/95Cj+WvSOYjwOh7qH9tbD7tOV/v9y?=
 =?us-ascii?Q?9kf6OgS0DC+H98g7FPhse3ql2GvKNlKahbixjVpmQrnEqIbYyz3xHJQISl1i?=
 =?us-ascii?Q?oAAPdKXwuaJKjgtrLkSZlGCpCzAiKhqgrNCy+EdyQyc+ZUZTsJxgPBEeG6LP?=
 =?us-ascii?Q?D7IE/VCgsZVA3PymHRYtZtQEzIothGJHetlE5KVha0aDCX43ipsAtuGnbCmM?=
 =?us-ascii?Q?p0a4kI2OqJbim165iBX7gncVBQQ296swPhHM+OyYA/owhi1ZjGpPJFTC2OcT?=
 =?us-ascii?Q?2uSswXMnKepz9Vl4nY+HD0dWyhOPyqBH10o2SvLDuVLmNTMJBlLEb/d0aVEO?=
 =?us-ascii?Q?dtPn03zEye/r4CxYw7SiOIo6LTav1Ah8iR0wREntr/Ht2aa5ds2OwBwds7s7?=
 =?us-ascii?Q?8YnGkhKy1pVixjKLp+CQbT2bpiMzCnupLUn9DfVqpQMz8TAvv0HJ6Oc8ofUS?=
 =?us-ascii?Q?3bgmPeStzbtpQ2ySgUovfruFfj7tXGMdj9BoBOkDCFK85ydH1xCOzywhd+7Q?=
 =?us-ascii?Q?S+9Jh0lsRlvEykXAb1Dd5Yk8874mHiHJPE3z+S5QBtNBp26uaaMNoRlHlb11?=
 =?us-ascii?Q?4XR/NTTM4qxPmxFutr5oKxpeYEWI83gTHtLV4+YPFe6Jwi4B02vUc1ocfX1K?=
 =?us-ascii?Q?RK1nBL4jVnTVNPZLtwHSwli3QxW+NmbTiWhk6FMvxYIAejEFIfR2KSOfgaAP?=
 =?us-ascii?Q?4S0SFpyhBSGswSGi5SWnIeED+zQ13AnCuVoazpAKb1EoOT3IkjBBvEgfLRW9?=
 =?us-ascii?Q?52L1FPD0RRw714OJnRD5F8HpFeP2E42J6VGcVHuZuY3rCIbzSyFvN2xf3aZ4?=
 =?us-ascii?Q?lGo70U0atm2xQkOEjmwyEgIDUMEuMibVNtpQxrWj7+E1GbY+Z2Gj6PDjqs63?=
 =?us-ascii?Q?xhvYZdZo/IzRpxgYj2Yr/hY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1149fda5-38be-4af9-e1db-08d9d4b348db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:33.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 757b/HwdTNv5s6NVsSx+c0ykvF6LItoLP2XmfLWgZwZZXikLLG6UQH7fvSzoyOWkvLn3Eav+TH3Hf/bKPaR9cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Currently NXP use one device tree to support all NXP released Cortex-M
demos. There is one simple demo that not need to communicate with
Linux, thus it will not update the resource table. So there maybe
garbage data in it. In such case, Linux should directly ignore it.

It is hard to decide what data is garbage data, NXP released SDK use
ver(1), reserved(0) in a valid resource table. But in case others
use different value, so here use 0xff as a max value for ver and num.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 0bd24c937a73..75fde16f80a4 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -490,11 +490,19 @@ static int imx_rproc_attach(struct rproc *rproc)
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 {
 	struct imx_rproc *priv = rproc->priv;
+	struct resource_table *table;
 
 	/* The resource table has already been mapped in imx_rproc_addr_init */
 	if (!priv->rsc_table)
 		return NULL;
 
+	table = priv->rsc_table;
+	/* Gabage data check */
+	if (table->ver >= 0xff || table->num >= 0xff || table->reserved[0] || table->reserved[1]) {
+		dev_err(priv->dev, "Ignore invalid rsc table\n");
+		return NULL;
+	}
+
 	*table_sz = SZ_1K;
 	return (struct resource_table *)priv->rsc_table;
 }
-- 
2.25.1

