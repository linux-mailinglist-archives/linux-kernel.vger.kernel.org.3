Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2647448681C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbiAFRFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:05:33 -0500
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:32001
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241500AbiAFRFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:05:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDUo79cgsXepSAn245CRqjgsnq0TfnQ24akhIHLv9fF4c8GJhp2L3ysmVdVJMa3DCgahotLqOx+HD3QjFB1HgiwzSeiqP6Wu5LcivMdMaiuBk2xVQRV2ngzDd/8wpdhORxR4It8IxI+qXT08kZpZhc4bmDsIPOF3cjhBGLHzACba5OnjVLykgB7teRzXxoAgGc5bD9NhcR7XpQTybQyseM7M14wySajXImJHsC/J/azg3Pe4eeXNfi+jVMnvIq81EONGN5+vT7ImNjD30Sja90XINDjoNU3Ykf3EbAwpMKviBjAo9geFEcO+KNRGjFQNlL+kyTXfVfoLaHBeN+1u2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJlQ4TwtkBOvPoo8CqHSIK/DDe0dj1kj2qMVke8z79s=;
 b=XWh/1oI0n1CoPL9b/vIWbBIYrgE68q9yOA97iQ28W+rURH3TXgdSlPPs0D/B/xIQbX1fSt63snrbkcxTzTGhiSxU6zK11VPWt32rft22NbaSDHr6vGoFyvBzaiS4I5U1e8hulBQZ4+yDEPekxX1jbOCDsrs2IIwtXAEWyYVvNaYumSssovRQr+1d3eicvNENHzb0+uWcS7aZVjCPZh42LAEBX2by7jd26rVT4r/jWdWfRGjbFp1Uj0JljtiCbEIreVEw7tDXfPkYDDpUidasAf/hrxYZnmwSzboLs96f+pBiyxpfgAmz5LFcGXByd57U7rFU52g6Nqiz+Bwp6l6jlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJlQ4TwtkBOvPoo8CqHSIK/DDe0dj1kj2qMVke8z79s=;
 b=K9Yjgk2P+Xcn3IL7V0RUmgCBVyh/5+N1NpzJfTGDlby+Op2XulnGu59sL9qyxMMDsSEtkIExPYy+SR1SD4+OKBkErP8FG5uh4ulqcJqjTVVoS9r2Mv9DkzgZWRxYe3V/4auLlbecttHGzI/wioijnunZ9O+S6WqjRt3wIIdRBk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3837.eurprd04.prod.outlook.com (2603:10a6:803:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 17:05:29 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 17:05:28 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3] interconnect: imx: Add imx_icc_get_bw function to set initial avg and peak
Date:   Thu,  6 Jan 2022 19:05:01 +0200
Message-Id: <20220106170501.3513423-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c622fc56-1c1f-45fb-dbad-08d9d136bce3
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3837:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3837F9C992671423BCCDC30DF64C9@VI1PR0402MB3837.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/pU46+TeJWeYQc2ftWPVgoeLQs4GEGCwqoQvtRcvmYSebo5G/CZ3KHoY9P+mV1szju+lor/0BUZw/mqvA9WSIPqB6ucdJFZLZdhghA1KU9rLBNsJeuMSh4pLtTMDYoUr12xkyBuhf6w+oiw8KOaAl8Vchq4ufZwsJpO9tyCGETd8Jcen4YOGoNWkNXKaDlpdP5lP19O0IiPff+wl42SQBivnzj6w8uCqzveXahuRlN5uLMqOBKC+nOBhXFEl+ntePzQNIAseuKscR5Hg3RgjRPYb+MEVW3rkO1cR8H8C3A0REPOCyKYCJ3MKyvCg/YbIUrOfvFlzA4ENQhWLDQ1Wqj97OdO08hUZmPSgZEsWydDvu7pKrKJUKZ6xiozppLGCNqfIAY72ygvw2A3Mv5Znez6x5IVk8DXzTzWJlk6TJaoqEa/4o9bZnPBn0uJ3C1POfxZZFzFwOcpejeeTnJwCgoeEZ0TkdELcnb3gBS3pDIXyrWxSLOEArY7MV+PAgFlYeVyxj4er059MUCLsQBHCSffG7IM9i+Zf//czNYUolHbR5rftAxmzIcUS4lLfdjTDl9K55PJ29Rrgb/ZI7fkXwhyr6QsAF/s+KuhZSm0lc/LuTMur92FnfyKoNEFVq8h/h6+YCP52fdSYwN2fV5gRYZpbv3LpEeIerajA6lK++an6HqfmdnfKihhNX3g3AfSznhnDWpq4Gd5xxCoaglEtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6506007)(8936002)(52116002)(110136005)(54906003)(26005)(6512007)(508600001)(2906002)(2616005)(6486002)(4326008)(6666004)(1076003)(186003)(66946007)(86362001)(66556008)(44832011)(66476007)(5660300002)(316002)(36756003)(38100700002)(38350700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTwHRHAjRY3P9KwJhYNeHGxJCC0r5CvibuA/pO81d7u4qifJP26EBRyUtWaL?=
 =?us-ascii?Q?iGCF44z420F8wjgZLaZay8E3NGLdDPQlBkspizMtTU7PDBDFaeiMoHXVrQnN?=
 =?us-ascii?Q?KGShbo9gqzqfGne8+C943LI1AI4Exxv50gBgNxiBZGVgjwX2QG+A5h4bLxIY?=
 =?us-ascii?Q?CSFFqR79xPqEVWkC7ITCgo++9tpb/nGJX3PCo4G85Kr4npL/HgRBdFuqEeeR?=
 =?us-ascii?Q?D/vh2MsT7HKzffNTuNsyuu2xcQASJ4WXa6QNfD3mGZ79XDkjEMqg/V2k+Ko6?=
 =?us-ascii?Q?HamYgPzOUeb0h5yVePikOjK0aBmWc+Fsco2T+kyJQ6rQa8dbUe7LK7vAPgEM?=
 =?us-ascii?Q?F9Ma84UA3pP/lg9ACt8vuMRO1Gwk/L9sbfZ4qdTZtL2qBVm2U+VBDXtkPVVt?=
 =?us-ascii?Q?dPanqHu9V/pKWcryUCihgy1QaDdH8LgOnbnSzAGq/z2zcOir7eBfOjuohs7/?=
 =?us-ascii?Q?nZTPwBTj3Q2ze4PIfd1I+rJIHBBBNKLHQW8QSHA7VMasYj0LKfQKF1FCNgla?=
 =?us-ascii?Q?h0Z7G0yoqPw/yuuf9ul06+qRpXE9qF/7u5lypofYspIHvCi+8LksE3CN2gH+?=
 =?us-ascii?Q?Sz/RalnwMSZZF2/sA1pJup3QfwLWr1vV7WgS0s/AiZBdRKyYERAQRLbJ4nUz?=
 =?us-ascii?Q?NTigSwbFrwSIBlcAFwG4Zblt5gxtxct5lSCfinS88PdMjH98fMD6lA6vqW8U?=
 =?us-ascii?Q?dwuh43fwQQx3Th+DfGU4KxmflniVjTPclrMY3dKnbDo3UioECfLf5Xik04Hb?=
 =?us-ascii?Q?wFQqO3DIe6sUCva7Zsq4oHhiu5Wt1X9ymHh8R+LqHzKQUPzU5GxqvisPBENI?=
 =?us-ascii?Q?ym+PsbmdAjjumQ0HMGSC9yFuWYdm5XSdkbrHFd7G90aCUQGcaAx7+FrF8CWB?=
 =?us-ascii?Q?gwJzLWmha2Tl7S/7aaWzEV8MChshrxXXI/TzfY/xgVI+ihKPXlfFiPBTUIBT?=
 =?us-ascii?Q?yBWgOtXHAj9YZUUeqgaptUa16ihpcgXeNRLlg6/aCkEqkXGB/JvibEJnAxG5?=
 =?us-ascii?Q?E4oiOaXeFYwqBkzXrP1Z+1GaCyeGpkxyf+eIkz9W8F36CpqHgnUXgn4YHUBN?=
 =?us-ascii?Q?/iM3mrCuxe1s8b1reZ5o+nYDdjf3TTAPwzx2wnN/DWdFCD+GmvujPJC7FmgF?=
 =?us-ascii?Q?EtM4kxXHiU14q6+Npm3EJMT+yiXO4o2roP288lRpRRnuCNI6FsJBpdVEFz5q?=
 =?us-ascii?Q?M1qf/dA+sEaCxn/45emiwAryeXiBsw6FULUHTmWQgZK1mdjkGgfY6b7Qf7qm?=
 =?us-ascii?Q?+x5QHgkeZj1JuXzfnCDns0l51XTbyf5nG9iYsav5BF0/1fqAo+QBqrvnw7VB?=
 =?us-ascii?Q?w8F+tMy8PckbyixG0BJB3/zWXOpo41uNmiaupQCf2/e/Luu5fvf8hzdDpTGR?=
 =?us-ascii?Q?X6J7eKGTR7Hud8aqiL2hzSIx083KmNwwNX6gpmWuDj/7Y7HZjQCfZsxsw2uk?=
 =?us-ascii?Q?MORWYkqJz5zZPtZBzOaf0l73KlL8GZsJsIkfgKMn7m8pW8zmbSF0xfrXUQPo?=
 =?us-ascii?Q?ZrmvNJYvFiBzz1mrPPTGBlRR6b2f6MgfH+G0jm8OVESs4FkdWPBw8h1Oupke?=
 =?us-ascii?Q?s3IR1q+Xpd5mROcFfUm4Bp9dX5O5jR4GT4QNDapAMdhM5oIhoNpB63RPRQfg?=
 =?us-ascii?Q?WXnIrKYUZMYKezIwqf1npKQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c622fc56-1c1f-45fb-dbad-08d9d136bce3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 17:05:27.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41YVffF6kZvxgRaiBImH/rKI+MBcY3i59o6SLSRNEGSCX4yzSNJEhwls2ZqtJ+dHERWDJUHyRuC/rqgTj3pPiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the initial avg and peak to 0 in order to avoid setting them to
INT_MAX by the interconnect core.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v2:
 * sent as a separate patch
 * dropped the imx_icc_aggregate

 drivers/interconnect/imx/imx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index d5b36c478911..734807d8ccca 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -25,6 +25,14 @@ struct imx_icc_node {
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
 static int imx_icc_node_set(struct icc_node *node)
 {
 	struct device *dev = node->provider->dev;
@@ -233,6 +241,7 @@ int imx_icc_register(struct platform_device *pdev,
 	if (!provider)
 		return -ENOMEM;
 	provider->set = imx_icc_set;
+	provider->get_bw = imx_icc_get_bw;
 	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
-- 
2.31.1

