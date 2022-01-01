Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1488E4827DE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 16:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiAAPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 10:53:06 -0500
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:58694
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229634AbiAAPxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 10:53:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNUTxKzKxxim9S3JgCoStrG7zwbTlRK5zsJmdXhgBCv7Q4i0DyKZKIFHqbjLrefdOtUNKvR3mY3yO7HRUC6D8Xpq2aEXFxKbfu5izcui3HNGZ3qqf9AxFMZjxcVgnwzMwzQ1hefjd7oeFEOWnQ6dH+aEbwr+ks1jeSAnR23W/lgAie9W4ePbq0a9IjMS7Z+OFdoNg8jH/+yyvmn8vckyzoi6Y9x9ZIWhWSvxBvI9orsvNcoXohrVRjYp3mhYkY7SzV4G8BQPR4Rk4mq3wqQ927ESe6rom3gQJ+5TUfdKk6p2ahYCCZ/WXSDcCJ1CndvgZYSRvbsxcK9c80f8p3hMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgNjz+O8hwfEvWjFsZd2UP50SV2XuyTPksBEuhMMz9Q=;
 b=KbwZlwSYH6qT9cqAi2rhpa03nTR06MRZoELdmw/1f3JHqTsf9kiuHBektcVUXrNoy+AaCiuHL+DprdvO78b5tpqJux6Q1DeS8meXZAwpGeihZxQeJ/FQVtRct0pYKurzeI4vjp0dpdT6+/fIV4ngHa9ny56iIyo2ShKynH4Q8aO755jnBY7DIpAxcFENMaQvP+BnDGTKPlCmP67XCdjAbMv0kfpMcHi9YuSCm0xm7s+MJKM+mzh/8HqtkM9jrAHSPFa0flpkOhW8BWJNv9Z7bTi1AwBksr6AycP52ntDvbWZth38vvszhHeBtl2BcdUTNsPONRH5NyyCrNCMfIYrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgNjz+O8hwfEvWjFsZd2UP50SV2XuyTPksBEuhMMz9Q=;
 b=f+1R/ZNrFYVw/S8myYR+b26tsd1R4D0J73IajfKVFF3iOm/lubr3LzrvOfX7QGHq/C+5P0i19zVGtBvRwbG9yyN1RJ2pGo3HLydCeVGAJNJ+lAKYm4RoCYsj6HPDvdYpyYsxXTCsRjoRr2KYgDajSty+LQ1NFQuyhjvKJ+kIAwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 15:53:01 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 15:53:01 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id node assignment
Date:   Sat,  1 Jan 2022 17:52:43 +0200
Message-Id: <20220101155245.3139667-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0084.eurprd09.prod.outlook.com
 (2603:10a6:802:29::28) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e9d053-ef78-47da-94e4-08d9cd3ec9c6
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB7471BEEA02FC6E02A809BCE5F6479@VE1PR04MB7471.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPtM06VuBGEOzekTb/TejEtve4Rqu3EJ5g7mVCgJW5ApBmHHyvaXWDXxbVwEku2FSnrlfZgiKaCGeU9ULAudTIARMCP2Sbv5D5KgpufKrFCm2LiSdRM6pvJNC99rA5ygAk7xO5ZEG997tvM9ltMryacSjvoMujYYyu1OC0GNUREVBC5WDhmBBg0fyPXJpg9ZckvjTKJeB6A6KBFa7x3NAjO5xRz1YSPiS2t1PfiHEwvQ3FIcgtV1eIr2acCaCaxvn6UlcvsS3TUB+btXUvGkeOLExy5f6eJROsrqCeYPbXeru8W8j3aXjo/vzIzWCQDZiFWnZYbL4uL6Ddx5OrTemcq3UM/A2ZnpUS1k75dHb7kq+wshR8DHmkZInObn7mf0tSKinMKvUfxU+FTVA62YuGHHenD12aBUVTskXRRvZqcdNldUV2d15ZUQypeJFnOdR1+vd328JATyCZz8GfOVd4ukBCbfvf/ftTYyJMHIXznm12Epog8st6vkmtCRzhIHNB0rEq9o79CqXnkDngfh/rRwAHKDvFz9tsGMamoedJjpJWyh2w6+fhSPq5MyUf9qJHeqy0R93rLo4wH8tqh0uIXryijNtP/4N7XdLm/GdWauFdI4C3YjLLr1drBDzmJ6mVw5bh+oBSTnpcuGnxrl4pQ2+hZwce8/vDt6PIq67hVGrqKRUbr2Wwt1d9hsmV5ZtNwHv+LZpoyqAEW90ayCGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4326008)(66946007)(2616005)(52116002)(316002)(186003)(26005)(83380400001)(38350700002)(66556008)(38100700002)(5660300002)(1076003)(6666004)(110136005)(2906002)(36756003)(44832011)(8936002)(54906003)(508600001)(8676002)(86362001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVv/aAZbq3OwehEZgYx337qOsjhOvfDNkaG3M7SqW5W9vRhR+nQfZeS8vD8D?=
 =?us-ascii?Q?zSK+xWIDZqOvNIP6kb7EK7sFeEKPyR8DB98eBXvpC1LymlAMjn0xZxWhMbG/?=
 =?us-ascii?Q?BbTesDD3d675wNsodxapMxGC8G0XqnQH1lnyzs2ZD3DerO0jra1zPjTXfAJ8?=
 =?us-ascii?Q?eAB+JveHy3dmUunYmawb1rnkCAHEWlg4f2dYUZesGWUL8ACAzMPfUswpgBSU?=
 =?us-ascii?Q?BmXn6Ck8+g5mx+bAe3Bbpl07qTmp5P/Mvp458AfwnpnjhBTlY/KD/FjgcZfU?=
 =?us-ascii?Q?7dGguoSoLNehbUwxdk96igVMdQEQEHkXa5A27nVQI1+XlFrc2+g04/gaHUVv?=
 =?us-ascii?Q?y9yjuFszGCyVU71pGizZrlzbkR3S1agDd4QgFsKNDfEOIHOjgx11JbTwkr3N?=
 =?us-ascii?Q?E8kRS4F/dThJLPBvk6094sjWY9woUtdhmF2Pxa5MN03jJQJ5YqSA8lx0ovLq?=
 =?us-ascii?Q?/cpwN4vCxPEHJMnZ7tnNAvpt7hpx4rCGNmOlVmLwoE3wKChMD4/zBk/QRgwu?=
 =?us-ascii?Q?XI2TGEv53WuyafM1txSQsuzyc1C3yeEiNnD7Kygc91j7ij2qG7v8DE+z2IH3?=
 =?us-ascii?Q?K98QvOA/Gpi6tZ0nmw8vIa8DayYfUNvdwxhi3PctzPro5KgMHbW6i57sJwJ0?=
 =?us-ascii?Q?F05FglU2GoMN/FcCeXmLRbhH0o22rcFg/9VL5FgdyfoIgZQj92yWCca3YEwx?=
 =?us-ascii?Q?Qb/6t1s4XPjSi9q+6/3cIFrgTk6T+Bnqn3esalQVrwG+1DXrBZ3FK8sZGRn1?=
 =?us-ascii?Q?0HLHCjhEJIf3WQlY8s7JhxNthmWCsUrJydi/Ep+Q8S21wEvaQc5hv6HIID5Y?=
 =?us-ascii?Q?nhybRomHoW2aINMrrxYoxI47guk+vD7Tll1O+Osez9gI5lahBB9S9O0cIxBU?=
 =?us-ascii?Q?4F3F9DywtrZPNDdKwJR+1sg6tbSAuXYt6tsbV9pnzEDZH50vd/VcZhjKUFmA?=
 =?us-ascii?Q?G7eJ8b4s35jSxovxCvjUeEbh7EW6CI7+u8v4PxqNelz09pu+EaZwB9H8/KzS?=
 =?us-ascii?Q?v81pkci8xdNdYyxvWse8ah9ufxpgTbxl4eVNDkXXR2hzOoWoDsds9o3/9JiK?=
 =?us-ascii?Q?7y7pMv5ZqIiao/YTAbKCTcJIAsD8fhQRNGd1mt3yFCm2SIcDxtkZTeRCJlVA?=
 =?us-ascii?Q?qb7gNg2O7AeN4059liVbtolRtIsHpuD8nn3a3ThbiIiPxs3QW3Et7r2nsOaS?=
 =?us-ascii?Q?vqz1rhCYZwcbQnXPOr9VjUU1s6C3XgRmdnfM/cRZ07POqiiszKT0Jenmzdtl?=
 =?us-ascii?Q?3JKHc6YNFgtXcWlMbtPIzMUA06Otj5ZCcAfCoWiVThbyf7eDUc8Yj/25rwUG?=
 =?us-ascii?Q?mjD04R3G+0xh6TMOIZ9ylgSlBemG/eNyPUup6OGswS0LMOeal51vDPYRijCC?=
 =?us-ascii?Q?GcU1j6o7sm+xpXdQKjFxM92eRzYIf0HRmsLWZS8jl+4hHs0LGh/8i0v59YWf?=
 =?us-ascii?Q?lYdQ/E86xcztgbTlvLH+n2GbuSuXXt6/kEU7thyMAKlIC2JU89/yG3rEHCAv?=
 =?us-ascii?Q?8g3Bpl6vf6HVlWJmToJXND8SAEPqpdfZNDtpMk3zJgM0yrMiwDcosoFJrp4b?=
 =?us-ascii?Q?ElZMu9fhwl00X/15uU/WCVnN56gDt6eML1DK5spDnqrNbMT2wF/cGqkyoDix?=
 =?us-ascii?Q?lTqpDwmwf6HITqXARFZdvKo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e9d053-ef78-47da-94e4-08d9cd3ec9c6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 15:53:01.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LNnFRSXpZSLIzDpJ+lppBcVmzltZSqRRWeQaptjrsboP2NaR4OKRbE27vPUy2bje5s2UXrD4uo2940M8eboFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to have more than one NoCs in the interconnect net
we need to decouple the NoC from the dram. So instead of using the
imx_icc_node_adj_desc, we use the fsl,icc-id property that is in
each NoC (or pl301) to the icc node (based on the id) to it.
Along with all the NoC and pl301 nodes in the dts we will have a
interconnect dedicated node. This node will be the actual device of the
icc provider.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/interconnect/imx/imx.c | 70 +++++++++++++++-------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index c770951a909c..34bfc7936387 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -34,8 +34,8 @@ static int imx_icc_node_set(struct icc_node *node)
 	if (!node_data->qos_dev)
 		return 0;
 
-	freq = (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul;
-	do_div(freq, node_data->desc->adj->bw_div);
+	freq = max(node->avg_bw, node->peak_bw);
+
 	dev_dbg(dev, "node %s device %s avg_bw %ukBps peak_bw %ukBps min_freq %llukHz\n",
 		node->name, dev_name(node_data->qos_dev),
 		node->avg_bw, node->peak_bw, freq);
@@ -79,41 +79,35 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 				 struct icc_node *node)
 {
 	struct imx_icc_node *node_data = node->data;
-	const struct imx_icc_node_adj_desc *adj = node_data->desc->adj;
 	struct device *dev = provider->dev;
-	struct device_node *dn = NULL;
 	struct platform_device *pdev;
+	struct device_node *np = NULL, *dn = NULL;
+	int idx;
 
-	if (adj->main_noc) {
-		node_data->qos_dev = dev;
-		dev_dbg(dev, "icc node %s[%d] is main noc itself\n",
-			node->name, node->id);
-	} else {
-		dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);
-		if (!dn) {
-			dev_warn(dev, "Failed to parse %s\n",
-				 adj->phandle_name);
-			return -ENODEV;
-		}
-		/* Allow scaling to be disabled on a per-node basis */
-		if (!of_device_is_available(dn)) {
-			dev_warn(dev, "Missing property %s, skip scaling %s\n",
-				 adj->phandle_name, node->name);
-			of_node_put(dn);
-			return 0;
-		}
+	for_each_node_with_property(np, "fsl,icc-id") {
+		of_property_read_u32(np, "fsl,icc-id", &idx);
+		if (idx == node_data->desc->id)
+			dn = np;
+	}
 
-		pdev = of_find_device_by_node(dn);
-		of_node_put(dn);
-		if (!pdev) {
-			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
-				 node->name, node->id, dn);
-			return -EPROBE_DEFER;
-		}
-		node_data->qos_dev = &pdev->dev;
-		dev_dbg(dev, "node %s[%d] has device node %pOF\n",
-			node->name, node->id, dn);
+	if (!dn)
+		return 0;
+
+	if (!of_device_is_available(dn)) {
+		dev_warn(dev, "%pOF is disabled\n", dn);
+		return 0;
+	}
+
+	pdev = of_find_device_by_node(dn);
+	of_node_put(dn);
+	if (!pdev) {
+		dev_warn(dev, "node %s[%d] missing device for %pOF\n",
+			 node->name, node->id, dn);
+		return -EPROBE_DEFER;
 	}
+	node_data->qos_dev = &pdev->dev;
+	dev_dbg(dev, "node %s[%d] has device node %pOF\n", node->name,
+							node->id, dn);
 
 	return dev_pm_qos_add_request(node_data->qos_dev,
 				      &node_data->qos_req,
@@ -151,12 +145,10 @@ static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
 	node_data->desc = node_desc;
 	icc_node_add(node, provider);
 
-	if (node_desc->adj) {
-		ret = imx_icc_node_init_qos(provider, node);
-		if (ret < 0) {
-			imx_icc_node_destroy(node);
-			return ERR_PTR(ret);
-		}
+	ret = imx_icc_node_init_qos(provider, node);
+	if (ret < 0) {
+		imx_icc_node_destroy(node);
+		return ERR_PTR(ret);
 	}
 
 	return node;
@@ -244,7 +236,7 @@ int imx_icc_register(struct platform_device *pdev,
 	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
-	provider->dev = dev->parent;
+	provider->dev = dev;
 	platform_set_drvdata(pdev, provider);
 
 	ret = icc_provider_add(provider);
-- 
2.31.1

