Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690B94827F7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 17:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiAAQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 11:40:21 -0500
Received: from mail-vi1eur05on2078.outbound.protection.outlook.com ([40.107.21.78]:37760
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232535AbiAAQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 11:40:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA39r04TnZrEeurx5kS3yle2lvX6DS8LE0diA0K750kU3CMAntFYuHsc6tJ7+wzv0uKUNLCjLac42Q04JOGcu7uLVYfHz3AE6hwZ5fbc5t2oXDx/Tmgfse0F90MI8r0Ld7MS+ouDVr3dBYtrHdDwvWL4aAckNH0VhEWZbxCV+L37MqMNbDM4A574FVFRbxfVBmD6jFjY5KrHGn+gmGaKvuQyleo28Fy6elINEu7dg7qqsmipJSuxOJ/ocnnJuqeAHc4sYmQfIt2xvpXfYaGSwSgDIGNYE0YdwAktTSZndtmkvELQG+saDpWyHBHR8WgM8hst7FY4qQYvELwR+mFAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHV70ZFxuNKZwO/6Zm4FAcelOFlwfp+t9TvLmt6+jUA=;
 b=MyBQ0ZN1UCaIK/KY6nxZhuTDBmxYZQJzlqMXjpTstneSS1XjxSkLEbhhab/egzdl3JOVrXl3MmD9exfjfzk30u6ezcbnZJul/vhBz09xdHIvXW8xrhgn0YqDugVlJXVZlLSKpPJn0uvcdUAEgsD7hHQYnGHJ+7qDo5p1mn1aqrh/A6soDNrk1CkVFtIvVXrOATNDUUrjgH5dprp2Sv1f/XaGP9+o+LApvD8P568tys0sbPRcTx4k/xBdNX/aWoSqvwvVmM3hGj706qVIjvk59iuNlNjhJSdP5Ql7Vql31c31s/3cM+glbC9d4rp1uxoDjqIg6Wm+hHX97mZQMT4ZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHV70ZFxuNKZwO/6Zm4FAcelOFlwfp+t9TvLmt6+jUA=;
 b=HSSV6z3dJZraI+qM1/i1FOv7O6PFeoaKac9sVlStkciUUsRNpDB5kKnqPTzF23nXQV3nZfvdX0yab/55TKanMQ4tg5Vta1Uvxmb9u2xLGkSljn9QebLXEsE/E0Tz0ua5UYu4jTEvzGtLvVCHKo5T8VBO5WXzAk6IaZyTuRW0C/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB2797.eurprd04.prod.outlook.com (2603:10a6:800:ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 16:40:14 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 16:40:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id node assignment
Date:   Sat,  1 Jan 2022 18:39:54 +0200
Message-Id: <20220101163956.3344467-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P18901CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::24) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88b8dafb-1cfa-4fd6-cbd0-08d9cd4562b5
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2797:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2797A392AA61515F02B6D315F6479@VI1PR0402MB2797.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTHFay5IYkn5vf/IGK5Unnh/0qgh0FYfuCzuwdB9X9Jq8mSIXUgsG6ej8LnkNfTXr6dZNb1ltspYVoF+1aWN4rqAmWpQ59kDgporpwLvZZZdS/kFHoVqXLUPAKpGlrASZMBLbhf2j2zNnkaVqZuEQGGFdJ1txVtvwNnN8mPWBvNZdMdSbVCv9AnyG6/bkxusctsOnImy3aCTm/HAU793XmKNWDGozcE6CfjENksL8GKW5UbJ/16lo2up+ikgloCxDVMXMKyBesgNP7+MIs/61spmubUmxMsoeZmLYzgK2pTf7ElQq9wBFX/ZcxbhNiSjGeSxHjZUk9XEHPE0mfmL65iH+IhBlhjZtAdS8fVVy4MdmHojh/3hKP0CeDNb01TrBl4wlv6ZVPc/YKMF9QGpFS3Cr189dAmWccDusSI5QQAvklGEnvH4KZ+aLVCzvQsa2O3qIk9TtI3SG9Hmajilt5Z7/Io6mjdgFOnBXgZfkouYBgfeg52pG/QKmqUKrzCS86U2O6fqujTWTuX8K83wn7uyr8JZ2z1nsD/KanfMWvu9D0SPYIgC4PkrxGvpnhxFRJaZffW0cUxw1gIlb8SET+FjmvIYoJLG6TqMerS+mwp6web6HoNygSkH2TwcnsV2yWJJxNZHpbDZehpIC+zJHIaPp9XfNDMcSpx8hVW6rFgJl0AktKr5wClghPBU/JHXRk5hLs6XtpR9ZY2MSSXFuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6512007)(5660300002)(6486002)(36756003)(38350700002)(38100700002)(66476007)(316002)(2906002)(44832011)(86362001)(8936002)(110136005)(52116002)(2616005)(1076003)(186003)(6666004)(508600001)(8676002)(66556008)(83380400001)(26005)(6506007)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4dZiDv5rvxsyaFaFcCpglUmHjo3I+fMJRBHNzoPWujWoj2yTVg5zC9OH3zyZ?=
 =?us-ascii?Q?+IHRf6pKCD5ASjo167VHYERz7dsvGN+teeGDkZyREna7LlU5YZRfnsJeeFkb?=
 =?us-ascii?Q?hzam/btxBg7HgPeqAgEBGky1uDQ7Z6mHfSbfZB7+7phCgioFa4Zi1v7qpFXd?=
 =?us-ascii?Q?y04eH5ci4Jbsvrmc2555T85qNdfU6OsUGe8bFjGYEQPp8j8IiXdtURCVqXH6?=
 =?us-ascii?Q?ekFgzP7u7+sYO/12lIL+26jxsPVMSAeVU3DYJZmN3oLNqP7C71vy2loXlCI/?=
 =?us-ascii?Q?6BOZCI7PltVBjtzNw15wOe4CF2aTHpKCBK1eqyHPXOUv5QeG3E+M1mhHFrdT?=
 =?us-ascii?Q?miS7K+BpSIljIJhH5l5fx1Wv/9E3oX7pxN8QaXN1dHgtEPIJqk+pGr2aT2ZT?=
 =?us-ascii?Q?842QnfcF2jCIB/QYalPNi+DzX9aPvtzIoqshx1JwLKv/XImHgCMeEB0ynxi9?=
 =?us-ascii?Q?xMQxTTktBiVpobDZxo6fKTUTcnagsOeeHntrYf6ssQjXoLkz0cnNTYj+qgcB?=
 =?us-ascii?Q?OXashzvzGfRbxIXkyUXQqIk8/hZnxQVqZSj3jq3xcxXCyffxBkte6DjWVKmo?=
 =?us-ascii?Q?S7ywx/fYl2wHj0FBlzJi879TeSMFSk0ozAyl6sBqL+zoBL5QYLfVCWdHklrW?=
 =?us-ascii?Q?KTIQ6I9x7R+zKDKIX5KQ69idIkBu32QsRcHELEneRQTYMFLPzM/MbzRxVSGh?=
 =?us-ascii?Q?4Khie0H8OHr3qTX5xIil4ujyk/iZqA7TjUJxGcnOrT0imh/g2eIPmxCEUmSU?=
 =?us-ascii?Q?p3dXiBbqUzWbXENOjNS27r56/iMhdlyXcx2klKIaeT64EQxS9FEMxyplwzts?=
 =?us-ascii?Q?K1GGyMDQoU5UtbLe1+wYeAfloFpGh5/mhYH5RO0QG+KA3ibov7bFoz7307/W?=
 =?us-ascii?Q?EyVTTrfQmzk5eDpna8C2ci4pjywqdfYEEr1vaANVwbpHSTuzuZdb0I7uq01n?=
 =?us-ascii?Q?ZTYzL2GmuW5HoTDH1/yotq5x7oVVmeA4MLixB3bYw/9DQKW+GQb9pCvRxVBS?=
 =?us-ascii?Q?w8obh0CLT6tUYiZsTSCktJ6byTJB4Nh6YT1my7dr7cbneYXDXZA7mBTV31N6?=
 =?us-ascii?Q?702mZRWcpTC+XCyDSoeP5xrmpC9EIDWPPZocHsMbZL3qPqStriePj+QAwJWD?=
 =?us-ascii?Q?eJMYVF9H7WyqwWsQyzBFbSPrBT65VVhPmlAXzsi+55Y+LR+oTfIERAny/Lh5?=
 =?us-ascii?Q?einn0kuRuNxZkvoLy0fYNeSa97HsL53loF5Zi3Wgcqq73UTo5J2d52N8tDZX?=
 =?us-ascii?Q?71OFeKcJlaH1SdaaVC7GusCXy7sF/Mw0Ue82ZVc0igrgTGINxE0SPY126cSQ?=
 =?us-ascii?Q?50tmL6WTHDChtu0fkasNNIAZcjZwML8FAxTJ1XK2mVDjnkRd9Slqjsbtvgck?=
 =?us-ascii?Q?T3SUxRnTr8+kTZE47P1+hb+dIrSHF+yizzinphRX585GIMrFQYtqhskIs8m+?=
 =?us-ascii?Q?esdjLOtBTFO6T8U/z9pMM54RhYLjmGqV7HZeMvcrg3R99yQmRcC+haSHJ2+u?=
 =?us-ascii?Q?RQjPAf8WvYd9SY6DXZ6ACwD9l5ZL7g7RPqis24Vrckxr97fT+K6YDm08GPj1?=
 =?us-ascii?Q?nUjZK9/EuMt8MAGiJcD4BP/z9DjxB6mGECzv6d+KdgmgBdW76B3W/VtpVRna?=
 =?us-ascii?Q?5gYhDlBBiGVR9StbgxN9K7c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b8dafb-1cfa-4fd6-cbd0-08d9cd4562b5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 16:40:14.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIgn5uBAEkNZpNq+n63k3ykBodlwguenSDY+VbeOHC3aTOIsJdZUfanzNCODTfKD0CXBT7UjzGuJ/eOqXMAVBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2797
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

No changes since v1.

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

