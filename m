Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7234827E0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiAAPxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 10:53:08 -0500
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:58694
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232479AbiAAPxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 10:53:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlwEpSK8ut59c7K3HTD75K5j2i/j4Pe/ONtcWysUiZxxdW8i0dDR0GIC2smG1WGkwxItUWGoqecT0UUNjgrpyoldxpHNoG2dxKe5NQo2QuBWxe+PwEc9P9aO0p03RMfIVwDQsxbM9WJT7EhgGYL+iKrV+CRzTI3lmgczv/85reBvT2l81vzjXfKkR4+oTMBJqhmT1wtgDUCezgX+PS/kJgDAtUanLw3Y1juu7oy4vQQH3WpJGvsMjfa3eg4kDMk6pVdEfyNnSk8fODSvgU6Rz7bIJFW03e9xWVYC70uMWmX21qsJ8+heflqubrGv/jcieRME3r+/hV5W+jtzZKaIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw7yRVtMw8ImJtrMwJWiIkn1XlzYpi4UXJ2tVA4J7Zg=;
 b=PpCTegxCbJXxhlVYRm6ecUlp1BOwcWZ4GC/LJNtKbzTVskdvsMeGh+maGh8EN+wzFRy8V7TSp/BKAObYxxyzqR8lx2fg+cVn9oCWWC/+GI9AIRJrFiL6kc+ySe08fv8pGPjiy+4mJYejOl7SqWMM4Jd0PZACHPIwpxCGMJUxVnoBBNFSqdOjHXHlf3YPfJedaNdysjdrRVqLWQwKlWsgToChENLSb0YAUktOUpfZaH4aa0GIYnWptULQoYQhYs8CZiPd4EHmkSSNk9npT+qXjA1EMZcFn7MXREmDed+0NPvR92GmJh3qfvsOeX9/DlHUl+KNnD6Kq1sr20f9fWD3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw7yRVtMw8ImJtrMwJWiIkn1XlzYpi4UXJ2tVA4J7Zg=;
 b=UyAMpf8g1Q1qOoUz3i1VytmpahMJ/i950AoqbR6PvgwGQeG9aIlvE9T6CPpvwpZnwVgDxLOAKDyblHl+6B5MrTlXd1YiNh6H7OqnPezyqTGWK3QoYZcBYJFvCQUnzNxoYZHH/AuWb2Ikwkflowc7FAmtbR8LZvWtdcuD5IXSX/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 15:53:02 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 15:53:02 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] interconnect: imx: Add imx_icc_get_bw and imx_icc_aggregate functions
Date:   Sat,  1 Jan 2022 17:52:44 +0200
Message-Id: <20220101155245.3139667-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220101155245.3139667-1-abel.vesa@nxp.com>
References: <20220101155245.3139667-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0084.eurprd09.prod.outlook.com
 (2603:10a6:802:29::28) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2404160-fdc1-417e-c241-08d9cd3eca60
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB74715403E52167F91EA3683CF6479@VE1PR04MB7471.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wd866x90x12QLAI/2rdoMb7x/KTk43/SrxvSjFRkNy2pbjyX/laD/YxYeNohyYl1/bvt6Xf/ynNjMBDd5oTtp9IzxoVDoqfsZnOyKiSMixLFFsDvc6M+0LdNtgc8PKdyAJgh/WRTTyz/X/YjuxSDDKhRFGE3xFFD29S7xAqDGqZiXZnf1xLSC1SEhutuNfb12LFhMtiKj+Y0iKb7DLrG4wQcY4mPCPm7z9NobGQeF75cSH9dSEPbqwv/O8iEil/vZ0EInCJEUd3a1vi877uxUy6qLtksxYmL4LQNijCv9IV/mo0Q9QBKOJRtAMMKanupAFCqZxoROw4kZvc5VsNxEDutZxYRfUnY7f1QtOjMtAXJW2uppb1EWkkXz739ja9XI8tnrh0gaABp79KeYDU3mnY7v/00HFyvo2ZuyavPZvCbZdWQNdZX7FrqU8VHmGTaoL2YwhyeUnz12u7AIoYu300GcsxQGnukvLeO57Sa9zOLMqy+5OjaPYY3hnp1lvKkZ7jcXSEKyvYHqgic/2PwKvHp143p17FDjJWsUpwd4bDfrRYUkntQH0RMCqyD10iHmMrLwt7AYP+3kAtbBCg9QM4PhNkNGjNVJ20LMMg8QveUy3kfpQdcan6iCgb0k9wJBZ+ZVtqhuv29MFVzGu0lRKzeFm2sdC/V+dLqdLVB5UTnb29kMijjUYul5Hr+a3eXSruqeKHooHywT3Z+Ob2r/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4326008)(66946007)(2616005)(52116002)(316002)(186003)(26005)(83380400001)(38350700002)(66556008)(38100700002)(5660300002)(1076003)(6666004)(110136005)(2906002)(36756003)(44832011)(8936002)(54906003)(508600001)(8676002)(86362001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+W5qBoW+rBEtbWVrydUPPQA0sSyYdBobER9uBydZvnhyd/OZjaOSYWdTHDr1?=
 =?us-ascii?Q?gxVRRBjesF3yIb033psefSj8IkwwDbjAQF8MzIVS7DInle+tp0EtJ8OiYPVa?=
 =?us-ascii?Q?UrEbEfkW4QrmvOFm15nOMvV9QbVJPHiSnzXLgdv8UP+zWTHF2gjYLrk1ywfa?=
 =?us-ascii?Q?wVRw2JrYX45dZzUJeCbti3QI3q007RypQiyZrX8umivB+M9V8uHiBmwhUz7n?=
 =?us-ascii?Q?IZxIzEQII3ysRvprOe/Nc08bVmpeJ1Ny/DZlBeBZ0kaFBbtUm6PHrxZJJxTf?=
 =?us-ascii?Q?9gJk0prf58pwOi634o5lKCGlv6EnlkZNG4w5o1D9qCg1h7VaToz4rQ2TiVDh?=
 =?us-ascii?Q?kdGUIErNZaRMijxp/pPm6F8JLaaQr1Mis2Yxh7/4ELGhXRncs+a3XP0S9L9b?=
 =?us-ascii?Q?FJYZFGp5UeZ3BljUd6ARvMGyAdu8CwslBJNorkN0L8dfB1lU5p6LsFYiqYSW?=
 =?us-ascii?Q?ztA7lTVEgd/ChdyigEZ9355A3HiPBxnz65KggL1l/ENuZDf4eKrzovDZFlNy?=
 =?us-ascii?Q?mKMn+6hqO0Wmou+93/voTnasPgw/fYab7SQpsVRiT49EWdkcRoKIq2DaAKqB?=
 =?us-ascii?Q?XBVOQKSTNZzD4FnPwpHXUOxEM7wKImLgJvxq4GaA9A2MrO/kCOLllaahspDF?=
 =?us-ascii?Q?b5xjGAH6Ts3gDRA4yIWYCUm/KIGJmp7Y49PvmAUU3sTGR7XgqUGptZVLHhax?=
 =?us-ascii?Q?AUAZ0MphKfur8MVIeK9PAH5rmJWe86KDibKeeUF8xn6V2OnWZEVuAjUuER4t?=
 =?us-ascii?Q?NMcwn5umlTWNr98Y2f+0LyC0BbJl7QaPg1pwjN5eAO8E0YUWJxAb4CsUmZ9j?=
 =?us-ascii?Q?Bu5pLeTdrMNPy+TGEIZiux9aQ2XKpx2hvN0K/B5HtmqAWd6xPrNWBaxv0YJv?=
 =?us-ascii?Q?V5SvpUBea0eheExQOx8tVFCn5mhjucQTzgimWeuyKFa51oWefQr66Yze+MZU?=
 =?us-ascii?Q?8PlshGbp/ZHM+Uot/Nw2iOmX+gj43kLh42eWOXDm44Q0GoF+SH5w91PtLP66?=
 =?us-ascii?Q?HENrCOJQTImiRlKpWoCEMmtBtFi4ceNOcLzUXeYz2GaZcs3iApz5VSDK+VTA?=
 =?us-ascii?Q?enp2w7+MowVIUC/bBC+m30Q5rKzYWJvzTpVT6eBd+5LZJ73Gx/jnmZYSV5cZ?=
 =?us-ascii?Q?6DjS5vAuzqC15jsgQJIcAmOWhEp6KUo96gHCJPUdXxjcCXDHfGE/R7lQqk03?=
 =?us-ascii?Q?R+rmCFfqVCs4t4Fv0HnqO1YoxutTrvJ2Htjuih0vmDK8qkQoVvasi7yiwucp?=
 =?us-ascii?Q?IjapUdu4Lc0ebZzb+C+3oxtYRMWiEPkj8Ur+wvoWVDgDyKUuxJ/A7qdTvg1F?=
 =?us-ascii?Q?H22FzU9g+/fXawN/LPxxV9a0ZagnrSBN2WIA671BHtkaI8e4gRpXaeGTf34u?=
 =?us-ascii?Q?3NIJ5Xkugg38juq+lJodwxDO0vNm269q3yMJeBpCVkWb+M1hBwDIOl9pewtz?=
 =?us-ascii?Q?9dmDtV71g7NRNLZUX8w/D3ixvKeMmp1pseYv5+evlo2EQ64b2rSnUV9vigG5?=
 =?us-ascii?Q?srRqPh7pNUsuwCgylSsi7PJILDwZQbH/7Fy/qGOQKcLHpVIlt+Ex4M+fb/t4?=
 =?us-ascii?Q?WRQlxiN/VxSB6vxms89K03vV3ui9KrBfJiqsJ6fj7LTvd8V5gNdGuqzLuQDV?=
 =?us-ascii?Q?3JBgTCqbj/4x5UaYZdTVY/w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2404160-fdc1-417e-c241-08d9cd3eca60
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 15:53:02.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ/l6eOi3nxF7K3/3k5sSPNaX8ed4KuEgxVx3Lk8BdxVWIpzMQHHNXVQHQfSxw8KW9aDnFY208+qWyg092r35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aggregate function will return whatever is the highest
rate for that specific node. The imx_icc_get_bw sets the
initial avg and peak to 0 in order to avoid setting them to
INT_MAX by the interconnect core.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/interconnect/imx/imx.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 34bfc7936387..4d8a2a2d2608 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -25,6 +25,23 @@ struct imx_icc_node {
 	struct dev_pm_qos_request qos_req;
 };
 
+static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int imx_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg = max(*agg_avg, avg_bw);
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
 static int imx_icc_node_set(struct icc_node *node)
 {
 	struct device *dev = node->provider->dev;
@@ -233,7 +250,8 @@ int imx_icc_register(struct platform_device *pdev,
 	if (!provider)
 		return -ENOMEM;
 	provider->set = imx_icc_set;
-	provider->aggregate = icc_std_aggregate;
+	provider->get_bw = imx_icc_get_bw;
+	provider->aggregate = imx_icc_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev;
-- 
2.31.1

