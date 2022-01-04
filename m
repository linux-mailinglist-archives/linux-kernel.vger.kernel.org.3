Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F454483BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiADG1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:27:01 -0500
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:59213
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231887AbiADG0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:26:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hF83nLVVFk1ATz6biZ9pa6rIiv9zcvbIScT7ZZ+iSo8wwzmFjLbl7IPLsaim6ABdRu+Q8SMEO4V27vybhSZZ9bcsphOoLPXaRCGYkRTnllGrXNqeKxQlfh3ms96bnpbD9J46Gs4oPOT7X6CP/7H1PYsGKyg4BDdID7UAiEKqOG0dvaFnWcrNlhasJNJbqz0t7Wtp9dOOw9skX9vwOFh0tnYyT69N/a/4r8Bke4p7vviLbIi0tftgjlQKltQxdH83RHVty9Ak4Q7dv+C6zvEWK0a6bTwsf8PVh228V2cOK8pXAafBp854KiwMTQ1CEGTzl5u2jMED3s96/8jtfAGU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly/pn7wK9oqqxMgm/iiK0vrriRQ8SLpSII5GwrkWfY4=;
 b=S7pNT5eYhYwmtsNCt5QD6q9kkFX/UVbT0tPornp2w6JipM53CmAhz8+e5Ez0f4w6eVDpkj6Bl6AUgmNvUuaojp1vtJmIn9ZoJJ5RwcFq11rSN52FqLH90EAInb/EAX6RDYmW9NkRNcQR73MUsp8lrVXPE6SEx/r/x3EZCY1dvrL2LvhZE0Npr9db8Lw8ffq02Fg/tiSyxyW7ghCdtyxxH5bbEzsUMl45Q/25aMMDtBxrNmLRW+lDnOnMd3kpKtik7blxWIIUy49gVYBROg17HvfQWNBmwtLJEKF5x0t/AJK5chQzCUnApaKh/WkoITxWD0ahlcboMXRyNmRFAxP8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly/pn7wK9oqqxMgm/iiK0vrriRQ8SLpSII5GwrkWfY4=;
 b=OlCjr2TtVF8QmSbcLdPttqJcuLh1X4lO+3EWpMJJN/xY1qQ27G6Oi3cj2GNOKm3IOCSE5oqkzLwDglJD4qpOxiMzHBg4HKglYmucolkq+2swn/itP0WElnhPve7soxDjAVAK1kSe0Upy6K7PYDe+MwEHapmPLfpHgDkMC9aQHr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 06:26:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4844.015; Tue, 4 Jan 2022
 06:26:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/7] mailbox: imx: fix crash in resume on i.mx8ulp
Date:   Tue,  4 Jan 2022 14:25:42 +0800
Message-Id: <20220104062547.2103016-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0089.apcprd06.prod.outlook.com
 (2603:1096:3:14::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e943148c-521c-41e6-cc89-08d9cf4b3109
X-MS-TrafficTypeDiagnostic: DU0PR04MB9298:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB92981BCF09003C16EB874274C94A9@DU0PR04MB9298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Niorq/AFA1zcV7oxIOomWhJAztq3PF7vU+xBddxG57ncVZonlyNfbJiXtyvwxJg9gm8u1xXWfUIgh9wk0jPis4bOiLnhPNWIRpAbonbUN2qRc6D66PKa5mb9+HKEiE/KsSvjqs77AXt6mgjiJ91IbyuKCZ+xD/CwMUMB1Pzq3Cx+GsQvqRE1XnLWXsg6geMbupf0jLGe4vL5Yy/RV1QpUFY1UGzh5xZge7rRVNf+pDx0kW3a9P8/lpBMStZ6BYkyeVlZ7mR1cEYPQHvjeJmQ7dSK5Wu42qu6FiEzelwLl9YFsZwOzb1hyALJCnd74+L+5s/svonZ0aQd4YNlW0pkge3Ri2d7ItFvs782So9rQaGxHBat5dP8muXbDzIzLmaEHciVurtygsq5flUA1VFxCLNzDcf4El/+aDEWf/RvIXTPbB/wdkbro4nqECEMG6+lvrCGpe1ereLBqZN+gzAAsvEjqm5PGnLOcvsNuYYD8B/gL5MqpkSLBi3tMk6Rbe4EZ1wyBw8Cx51F4nLqltv0YIHVqZSrKT1U7/O6zr0X6d2mWbE2O2wcYOBnWbOYTgFlSMyMMCd1ImjOFLAuRnttjravijn5QtgRHuRBHRzPyfhfk2yIFWAh31bMjRcfGwcPh2rPAEwKvdqx3rM4Jwsa97fVu6vTWEkbOUaovXyUdZrK/G842D69a/FEbNPuy1Jk2x/S0+sBGIOK3T0P8w4uzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(1076003)(6486002)(83380400001)(8676002)(38100700002)(508600001)(6666004)(186003)(6506007)(4326008)(15650500001)(38350700002)(66946007)(66556008)(66476007)(5660300002)(26005)(2906002)(52116002)(316002)(2616005)(8936002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0BBPRXOOQCmv6+mbkvtqtrXu5aipJcTVUJyxuQ/rPA/dVBtNJbhfnh+aGyQ?=
 =?us-ascii?Q?z755PrxODUxD4HD7iFgZEOJRmcTI3qjbAzLUj0ZKzebH9nXYm8QJQEXEBhjo?=
 =?us-ascii?Q?YOD6caza8GR1srE4FGgzjqJpel3Q7VK2bHwdZ19BDDNCWsw4DzQ0ixSzD+Hm?=
 =?us-ascii?Q?kbQ3Gl9cPG7WzkjKwumaB1eQh//o4DgTqyPnYTCgxSgc8GCTdJNgWt//7EPT?=
 =?us-ascii?Q?2cFAK7M+2jc1Wi5TrpwsQc3fLaAdelzBX+IK9ncw6mj3nReercHOOgJDA/XI?=
 =?us-ascii?Q?sN88Fd7y4Mjk1upkArVQl59/CS4MdqdcdVARoTgnYnMIJaZ+eUKyNUTjNi1D?=
 =?us-ascii?Q?b0IDJuAPJugk62LuapTrGQB1to3y04k2SxFAuZfOGX7LxbS1FKFZz+mOdtPG?=
 =?us-ascii?Q?2jD4Hol6TGo8SrPgxPtcbiYugTVvXpARnkJkkrxQtP7aGQDZXyLywb/s1WNg?=
 =?us-ascii?Q?kZdsYjKhYZ3rF0trRAmHrDTTYghDNmEf4jIsIBh+BRdqX6Fy85HvOzDBoK5N?=
 =?us-ascii?Q?XrO/f+ob9t/bmVpRsRtWGSiLYrhG0QQLs/8vWRbKV3r0UuAtXW+H5XpKDNBI?=
 =?us-ascii?Q?NJZ2UM9PwFDqydO1fIVDXNK0ejX1C0+Ydc6hUPo4Q63SEiuq+UFtJihgis6+?=
 =?us-ascii?Q?o03NPHV3OKlGTmSacPsQuAJauwL29PPSTeQ74oxPzoOUGCHnzjBhoxVLSlrL?=
 =?us-ascii?Q?0jI3Wy9QAeobFX5ztKis4LQh+YazCl5SnvogrRQfbAeKO+izF6O+frTHS8fF?=
 =?us-ascii?Q?fBbK5kPFyxZPBTuH4XpHwqi8XsYcDp06/mtLJ59IsHou/Dde70eHwiJeDj2m?=
 =?us-ascii?Q?VJF7xx9svQ9xmH/NoM3fy6s6P8q4izP6VroEZIN/GuRY6NPnEyZz0K5M0GPV?=
 =?us-ascii?Q?46H0pYPQ6K9Zq8UyuC+fHJxlO4viEIkURPCXNM7CwU6fzsrRB+SffbSez+wd?=
 =?us-ascii?Q?mv/EfWKTLUfHjvkX9pdoUOpHn+ancultQCoNJY5GuBTDjH7aOpWVNLtmEXRh?=
 =?us-ascii?Q?Yly6Ml4ln3fmY0DKRCc8nPSNRTXCVKNIzAGH6x8SrJKw9AcBegPF+/yavP2p?=
 =?us-ascii?Q?GjIrUVFOefSDEKpI9gZAg6Y9gbzJ7J/70WnATUeawuLzIdOu49KIrc+muYTC?=
 =?us-ascii?Q?njK8VxKYQzOcfDQbRCDRmshX5A3EFvLWwdOKNc2mrnh3c3RrKhW/r8BxsuWm?=
 =?us-ascii?Q?WihlyLom/VvvQwIAJzwmWmsosuZ6JgVuIHugT0zoLscNwINnk6Ak5H6HoDOs?=
 =?us-ascii?Q?m6Ra8U0jQ7XJrUAmBRefbhg/zJq+UWYVKt2p9uhQYDbM6ENriyC8VClJJYCU?=
 =?us-ascii?Q?CXcclEN6/k6nGdoXxTTx5XoB9AABF3L2Ova1aZRrxpfIQztZjZ+h9PdcY/mZ?=
 =?us-ascii?Q?d36EWgDiwF6cscyfbcPbadFGgA43TNgLBTq9zjfj3sembzQlSBnKmxSFZJnm?=
 =?us-ascii?Q?o2yCIQ7HCOIv6KpmC0K2eyjik6eYNcm27A4R0l9CXDFYYYCqw7TUiUZAx8NS?=
 =?us-ascii?Q?/bfouIK8szyVEd5C+Jz4yS2JBc35s3R5TU4luY2g+DeJpmkSMR6grlrOlhOZ?=
 =?us-ascii?Q?2NmPI/3qbgHIkTdG+Wfnw+jBtU7cbfTFQYAwk9C9moKs0DQ9FAwQRV90J5eo?=
 =?us-ascii?Q?KtaoK64T/zu+KU4APDBFBAg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e943148c-521c-41e6-cc89-08d9cf4b3109
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 06:26:50.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqSQZrPcCHohdlvSizeVrbfa1vjAzmx36vAcZe78hOEVgIruAggjtbfzz9K0+CHojrd8zQ7NrgqSBTWsmyAuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

check 'priv->clk' before 'imx_mu_read()' otherwise crash happens on
i.mx8ulp, since clock not enabled.

Fixes: 4f0b776ef5831 ("mailbox: imx-mailbox: support i.MX8ULP MU")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index b3a2772f0aa1..76d7d399790f 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -725,7 +725,7 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 	 * send failed, may lead to system freeze. This issue
 	 * is observed by testing freeze mode suspend.
 	 */
-	if (!imx_mu_read(priv, priv->dcfg->xCR[0]) && !priv->clk) {
+	if (!priv->clk && !imx_mu_read(priv, priv->dcfg->xCR[0])) {
 		for (i = 0; i < IMX_MU_xCR_MAX; i++)
 			imx_mu_write(priv, priv->xcr[i], priv->dcfg->xCR[i]);
 	}
-- 
2.25.1

