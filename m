Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20584827F4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 17:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiAAQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 11:40:18 -0500
Received: from mail-vi1eur05on2078.outbound.protection.outlook.com ([40.107.21.78]:37760
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230122AbiAAQkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 11:40:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/roGSBm/QhfmqUgOG4VRvJMd6tEVCMhJfm2K3rXW14ropEjebaLp5TRI1kmcxgTdijNn3QAwISBzQ05kbzz9xqQLltYH8HWpkMlfqOfSOGMHA+UXh2Gt2jh51JWSQyTVZkhFeqFLMGzdGXCx5WSR9UzoCUOKW96Iq9lHA58PloCoNij73zs1su52zhkKqTKxRGdTkfMpuXZm4agD4Tu2YcrdFHL0qiqi3XFmqh656ridCzHXOuMe9+kCsPgmG8O8tXpbBgPOz7W/WlLUKXzmyVJbIV+Q7dQEzAxUa5/d4jGYcwkop2J0X4DP4fTisqW3BdoBnHa3gaX74aFUnPJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4d8jtgQPovNcyAGsqOUAeVMwIFS/fOgOpYnzGWvMhM=;
 b=aWHyu135tFN9Uw4Q9QyYQE+nxlxh4dFgLkHrmR8qzYnVXDtcbUBdqWovz49WLk8tEuNU+ZctTOd3ooHeZb2ljdGcH7JUzV+1Dq5DOg0RRScmQQY4tfeY8KN2vBQs87s+aRJi7oeYACmvzHzDbZvChkooUtms5j/FtEmLQ3BuKNlEqCjXDtr67regaq6LfYkdWnaQQ9jM5A1am9APeZOJiSaPDtMRC9umU8qu1b6nPOMUmHs4UYdTDtLSRSiRi5efHIUFOpn26V2lQcf/7xSPM0L+z3WWz0JEYAPX4+7l4GHpGoUSRaeyNBg4xznEHRwbxC4XmKGz6Xnchp1WCc1pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4d8jtgQPovNcyAGsqOUAeVMwIFS/fOgOpYnzGWvMhM=;
 b=Fd2n1rUYbzcnUN297rizKzJ7eX1m3Bn2J66+AOR2TllWuDILN4Wb9/mzMl6/4Cc9Nc7zbTX3fRyZn54nNdv60MFgW1VCwp7mrGH2X2EpKmPCG0GRBqOdimzB+KAsmMCog00lceE5X1UDT300cu1w5Np0QUBJH5v0WaQszQTc/i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB2797.eurprd04.prod.outlook.com (2603:10a6:800:ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 16:40:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 16:40:15 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] interconnect: imx: Add imx_icc_get_bw and imx_icc_aggregate functions
Date:   Sat,  1 Jan 2022 18:39:55 +0200
Message-Id: <20220101163956.3344467-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220101163956.3344467-1-abel.vesa@nxp.com>
References: <20220101163956.3344467-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P18901CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::24) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4592535-0bac-409c-66b4-08d9cd456305
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2797:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2797B75AB618A0E288201791F6479@VI1PR0402MB2797.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGch2a/Trea0cVL58HiyYRQLMtdlz8KuArLrufXiu++9ZporpWYn4sj+vpCdRUE187+RAmQHEtc63I9SjMNY5sGnUvfyexXdwr8ipOth7w54i3MlfO5Q63y5OCFDQ+GgLg1zIc7jWAfHElVMIbcXUqw58MBYuLx23nYb9nHYn0QtJRZkcuUHoCsGkELZr2qHUmJLGOa5bvIXaqyK/SYsp69lwe34AHbXyzHgZEWAl26leqfXKlv+w+oJ6CXe8DjHyhTq/J7xLwzRHbHZ0Y0oZh6PG/KtIdemCEvXs+RQZvY5h7OCydENVju9yc1EewG5dVPe+72AyoZ3aZbi/f09s/E5fqYNNA36p84FQwUJjC5je6KJ6dMmnf1kZYIR0Q5YdnpbhGJDOzVqJbxCRU6u2m9te+HHIFPCgpG/X3EKXuvgbs/0hzmkY7527gSkdhozV7sGkGwR2giFlFgbYLxlAPNp0ZWqGjsqIT5EiFn79u7ADrFocsZn1UkYA8m0xDvHdxda/EDOcuotq2WF4GW0YmYKtRZFQYITl8A+jycXLY9tkmDVAtwkZ9I7XYGDbdfdxCTCC3VtUQFg/S2GrFnUHkUqbGt5y59dNIbYuE4HRsKl6aIuwQq89ZVUzpXOS4I8ggQ7w3M+cQK4Kdc8YulfynglkpraklvZkBUaQmNX8wUSPlMYwZrAAteJo5QES+y9UiEf7xzPdV81qXgKE1YE8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6512007)(5660300002)(6486002)(36756003)(38350700002)(38100700002)(66476007)(316002)(2906002)(44832011)(86362001)(8936002)(110136005)(52116002)(2616005)(1076003)(186003)(6666004)(508600001)(8676002)(66556008)(83380400001)(26005)(6506007)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TiUtF3z/d1RwszTlg6rB1IETEgbIw1qdF8keU0/lqRKlpQtcQjBSwflnIkL0?=
 =?us-ascii?Q?4DrOqwEQb+TdhvEOO/h+Eh84ecj7J355GOWxkU38Q6D/28ik9qokVSlse1vh?=
 =?us-ascii?Q?itICDnwS1ArhZgnAPlWHTY4PjRNirC2V8bV4yBklWltt4bbpdpVSAA23beZm?=
 =?us-ascii?Q?y9aSgkLvvgilfbg3v+Iw/TjHyrwFHubQa2ORMy8ADW1vUg/aRRrGd/gZkSSB?=
 =?us-ascii?Q?DeWNRzpdh7s2FBOwfMtHbWLPQVlLc0881CanwQnZeF7VAb+gNJ4GlkYbyTN8?=
 =?us-ascii?Q?+UTgWKT3H8u5tdNx8aDSrYVh693h1ugbpYBhyp7y4zijhLp8NBTP5QAFzHby?=
 =?us-ascii?Q?+LQiOShiYHHIyZYDj9wWrqhBN800UG490MhLH7yZxVRBINqsWgK3/lNxjUy7?=
 =?us-ascii?Q?tBZOyZkhVjAjXZ1exDrtgF5Ypbw+hZzQ9hKYlvdvHYXN8zfcFVDFFEZX68Hs?=
 =?us-ascii?Q?03k0m7u4ZMy1KfBOdQBP+gqiXYMp3mY1qUwmbEkw2FAxjWVfX3YI11UjeIZk?=
 =?us-ascii?Q?khv7ClDK8+w8yvvL9ID0AfQFMYfgXQ9cb8yeT04iNgdMeXIDa7FAumOqzOKe?=
 =?us-ascii?Q?OjaBwMublb/r23b5f69fFmgPh/+78nGIV7EmR/aobuOp76IAihOSREMXwwD9?=
 =?us-ascii?Q?c5DBiQ38GUE7zLv1HVHbC8leGQRhipEjTD21/CCXY3Uu10zpzfOhrTdYqGzk?=
 =?us-ascii?Q?ZSpcCrYabvIKTzxuqCwI2lRFdp2ZkghPAUie/tS+ClvZfD41Bz9x9rBgGmo4?=
 =?us-ascii?Q?cSt4Yd2rhfK361/K3ZoBQfCwqQRTFpqKKYR96R39RzF3+FFfgKucXgx1+obL?=
 =?us-ascii?Q?6ToezF7WdPxLbRRV4g0ugpq2cg4VDOMMFVbNha4e1sPhC3jqg88wiR65MCyH?=
 =?us-ascii?Q?rhLeUhzDVAdxz97b5g+wVHW/TnX5PNji6TLXRjKBytXv6LLqGwR3XDPghv1n?=
 =?us-ascii?Q?UUSaqwkEgo/mPJ3yN+L99q/CYiWNTRV/q5ct0hB/lUXeEkSNyLbbPxYIXCCi?=
 =?us-ascii?Q?8bMM1AHUfKaMypfnI7AVxXBoL+hQIjWVOZSqNc3coWqISGIbGXvn5ijJ5Ipk?=
 =?us-ascii?Q?xh7DgOWpe4VCNcN/H2F/IPtHaVAkzZhb56r+X7btrWD+yytXvjrawUD8dlpA?=
 =?us-ascii?Q?lPez/goCJh9jb1ZUr6JZllTaOrrOM+J7vm7XLueuNJ56A7Zgte4AkSnc/yvo?=
 =?us-ascii?Q?3q/ZVWUwvPjfq+X4eA9mdornKnG7JZlkd7h5K+KPu7U2mY89AIVWrHrEPBJw?=
 =?us-ascii?Q?rsQPowAzYvOFpOgGDG910YbZPX/INB6xk4yA+Oa39vE/ZQCcDjh0Jtly355N?=
 =?us-ascii?Q?PcE142LysN8HFWZjg2fz/4FyZXekYwY139oxcrcPPjF8HA78EReZcOncrEt3?=
 =?us-ascii?Q?jDLtjYv0uO1083vgGHDpsgG5gQWNG62jknribwk07/Js5lhiZNytp83V7/hv?=
 =?us-ascii?Q?0dwcaU8dLVl5np5IGLdMyj7GcWsD3usok+Cu/XQj2ys2UkoSc66HpBcNybUI?=
 =?us-ascii?Q?re9lqSw4BB++kvyVOboB7+kCbaNeir+N18tWDDED7rzeKM9SoWccF7vAtvcT?=
 =?us-ascii?Q?dmHWwG9C1VSCGjUOCjhprtRNQ4HGW5JnHnToxseTPjc5PpClZyhTcpudNWsG?=
 =?us-ascii?Q?1M1mnFNrFqQy0YWiCNp2SmM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4592535-0bac-409c-66b4-08d9cd456305
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 16:40:14.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UqQ3RqBm+kDe0TWRF6wUg2lGyI6OoE9T6/V61QWuMBBXmtXVzBOo45akGnvZhVIfhdETmx3ZajSogZkux2a8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2797
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aggregate function will return whatever is the highest
rate for that specific node. The imx_icc_get_bw sets the
initial avg and peak to 0 in order to avoid setting them to
INT_MAX by the interconnect core.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

No changes since v1.

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

