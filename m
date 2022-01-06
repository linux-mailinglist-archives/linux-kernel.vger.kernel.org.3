Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526804867D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiAFQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:42:07 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:18017
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241308AbiAFQmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:42:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX5duIqwDft/1biSJyq4P6cve4t8lD0dNsmLda02krIeXuYwcdedSPfNG3exq3xcSf5Nv8ZW5s2RtQPoPN18M/1w6jz9wCiEbwJUAsSHX0Dg07RHVTGEYqaXVYgBjwKo5tv6Pw0WCSmikhcTeb4B31TJa/YdwHrz/D3LF2x+RYjjbzQfj/n/KF0tTaRuyn95dM8r6FHtj+gVwS01dR4HSEYTu2I8KRgkBk/bB4Yf/7zH12CqvXZlb+iffWu0MDdpBgUfgZcJ7GwInUUNZpGbx1HoypPzmzHl7ZA9LOR6gJmRbAtRJlfP6798237ofZepNoQinZPImEXm6S2GKR/v+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQD79r1qU3WTMkVCcPdvmg1gt+M77HKjCRcpsFfrFqM=;
 b=XIfxGJuOwGtTGUExjt8Zc++3YaRzlOxwGuFwNEA2g3RHhHRse+Ll28QHYgErXGy35pcXn3qCY3g6ntssXvxJEwfU8//OfKARsNdA3uF/cEABsBGSU/48xFNFtyqTGFsuiHFRFqfT1Nsv0WWXLbjxtdhizLXtpl+92kp8E4u5S3oHj1nzgXX0hae6PKq3/j3aIbrws31j0mwpTf78g2gU2HSycyo296kpqC9YQpy3CyUpgeR+zbIhG4/QYoh/c62ztTfUqxQztj+Fd/QFVKhWUeiIGJSdbPva9NonXjotLHUNcGOSX7oREh0ufVtgW1PBJOvC+z7eCNuK3PxZV6UC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQD79r1qU3WTMkVCcPdvmg1gt+M77HKjCRcpsFfrFqM=;
 b=nnd8QEEAUt+oyw7AHP8CSWgFcYssdPwa7jb1gdU3Sn0duQTXDhzn0xtMxQsZWJ6wB3VdNKSoxqt2l2zR742StzZUUHdUwKoy8yazlvWvQ/r+0yVgPwHhLwxRJJ1L0GnHD7k9irifkqHKPdIFt1hYrTZ+f1kbCmpri91SctZn1AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3837.eurprd04.prod.outlook.com (2603:10a6:803:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 16:42:01 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 16:42:01 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id node assignment
Date:   Thu,  6 Jan 2022 18:41:49 +0200
Message-Id: <20220106164150.3474048-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106164150.3474048-1-abel.vesa@nxp.com>
References: <20220106164150.3474048-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:802:2::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de1872ff-9bc3-4ca8-c6c8-08d9d1337664
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3837:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3837E1271A8E6DF781803819F64C9@VI1PR0402MB3837.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KY5MPElWpqDHPZguOhthu+iGeiQ3c9Vwj4Ebj4B7gWOMrqmwaWgRIu5iNo3VNBWKdmkbOqnH1tEB142ngo/yYxS8IlRMxwTswnkGM3SuIfRBrvcMm8Jti58Dql6ZvGosZx0C+fAz9iv/CIGKlR8MDPQUyisHFPfLcA6dKGxl9iv8Y/nIWDoQcV1cOSbREx/m97/Gk8BsmBDoB2Hi6MxoP7exfDYkehXVhjGl31t/yjeKYyiWBMeGwj1UAEs2nVa6O3hGOCbMJmDGI7nqOLDru+rhcmje3QOPm1tRL4Ipt9E3804vYmzkEGm4PiWdUQgYllAlWeRrs2F5fDIbcaHlAAEETJf99RK/BzXypeGvjzp4LHpcS0eKH/cnDAjHsC+otSS14fAMVy9JcdWsCGMT46MMyqXwzU8AVur+UpEW4x81hNG3gWXnvVNs8zDU78Ou49qdIHhUT+vjA6tfNvIg2mV/7cgwsRppDuVkaojztENlA8HEiP6lpKRQgeDit3XTlVEi7zqigw3lqOZj4QUJTLIrEY209eeUHuAnY8AeqfspnKEs6S1UTdKe4RQipc44cbRm4AaCsG5ZMnDjjy7CY+6uWfyuVLelLUNFk/fDxv/H9Umg31AwzIcs1OiOf+opCBUHvDrHW6ymQ/PaFqAZEn6s3cK3b76KypFZTfOZonefhojB66T/Iv94XGUMslKMLLjaH9XY6+mJlgy8iwMlPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6506007)(8936002)(52116002)(110136005)(54906003)(26005)(6512007)(508600001)(2906002)(2616005)(6486002)(4326008)(6666004)(1076003)(186003)(66946007)(86362001)(66556008)(44832011)(66476007)(5660300002)(316002)(36756003)(38100700002)(83380400001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vdVIey4MdNobZtf42UHk7/gwGFehhrYkCytJpClx9vZowNHPhAJUaB5B0BK1?=
 =?us-ascii?Q?Hw2w+o0eyR7GvFJd93TzSi6EJSP9xt0YMru4EPV4+RWUd/yRGtQ7A8lt/C66?=
 =?us-ascii?Q?V8UN/JIja32EmyK5hBjXMrp8t0uorKDcZ46+xHJVwlnxUsf2rzFoXZdpKIGT?=
 =?us-ascii?Q?J1nSkK8p/y+uSAG0+BnH/Hkicj2dtpRFpOhawc0TU94MRuilsjp9WsZcPtwX?=
 =?us-ascii?Q?SZq3W+ncVs7Wz0KGTb7n/qWkf0px7CdatGIp5OqXAlGqyK7MXp7dDMBFS28Y?=
 =?us-ascii?Q?+1588NCOhT+yrqbWFgM87uvS1n8a3ucAkRY0jzIjEbfOary9yRGtm+KD9YLF?=
 =?us-ascii?Q?43vXLkhq86lPRCz5eZAv9y2r1vwlgA7Q0VKIoy1W4SIcKhfu2K6q7tV7y/vV?=
 =?us-ascii?Q?Bh3BOMrDmFpNGKr2RdKgZea6gItsHtTVJ28Ii9uuHunyMXF94aK5DXc7KBdT?=
 =?us-ascii?Q?B+fScpqIzbmASl+xEHpENeoLBZ3sjqV2GRS3CGpJ5HghjCvg79lJhHu7koqB?=
 =?us-ascii?Q?FHZQ/f5CV1CAnYQQDD01psavbtJVl7FVsetrj32RQh4zKar1HGSePwEnydGp?=
 =?us-ascii?Q?imlsr3cknhctC5XuoJD2CYJqoJ9EGAaMg/fOSmxygcZ/Yqu45uwEz/0Butvy?=
 =?us-ascii?Q?AeAamKsMoUFG1eCdw6+FHDqkAhtY1GEPxwTfcWLsLEdLLkRG/UZeRF14Y6up?=
 =?us-ascii?Q?vtnEXn+dzwvgJ1xjE1ybcS7O+TlbDrSCShlq+NCzoIKe2gJlZGsnFHfhrid9?=
 =?us-ascii?Q?IRjbYYwG5rdF9rGq9CDB3WAbsdHPWtE8ETnew0IiDJ7L7AgrIRJ6CPnjgbtn?=
 =?us-ascii?Q?G1BHIxyiP6ZefYur0BsQvtVrB9GQRVAWjn0O/HnMJyWiWr7NwmXOX5KbeRFp?=
 =?us-ascii?Q?BYEc0Jd+ftLDK7Z1Mz9Lo1D7+WnWkkepdT4LsYUEgao7006MiYzsSaGfc00u?=
 =?us-ascii?Q?Vu9+uIma77ABtXRgP/m+xHSB4q0XggfGvT/51azN8YoNwrr1rNY4ihceoaqG?=
 =?us-ascii?Q?BEqiHHS3GqSOfhcTbobWzVZgmewEuz1tHkaMsp4dQoPkRZDNt6s/EgSXClU6?=
 =?us-ascii?Q?GxcvmNK8C59QQs1o3SAAcovt9m/J2K/2HPhc1JxVQ9C2hS76ifa84wHhuidk?=
 =?us-ascii?Q?HRkYPflN6lfyW2DtAVl8e+JXgwAxaMbk2Ve1G3M9f5jnUhyNaVAW/kKEBTou?=
 =?us-ascii?Q?DUlgdyx0KpI3DSzbERMHkE1UvHD4F5P7txBHYCjAvTdePsH8mKNdTaTVS5rq?=
 =?us-ascii?Q?VrxmP8KjryG+KiTdMGK3iy9Ba+wEsmxPJHRLA+IrtvQAih4ueA4bDvZH/vrH?=
 =?us-ascii?Q?oV8mpin43TGwFOPOJal+YNVNqxY4GBa3LwMmuLL4ed9uGK2O7GFVRJBEMyjt?=
 =?us-ascii?Q?1Ydjc3apqIab/0X4JuZj/VAXprnAXVIY2/Yql8rtx8KuZgL4WEIbvh7YHYvY?=
 =?us-ascii?Q?onUsMdGP/QnFJTUszhROg6ZPNWlnDFjy8UP8RtnrAlpRTJPCVj6zKEI33KkS?=
 =?us-ascii?Q?vsBNspGzVhjmuLINrrJxAGLbomDinL4LpNtqglfLdobnRxxPVIaAxheedlTE?=
 =?us-ascii?Q?2w0mCb0e2+tM07kaJfe+brXRXWaLhgrVKUc9BGKlivweiuWzCEqM345mQi4p?=
 =?us-ascii?Q?Zs+jo8H++LLkt3hD+cYZEK0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1872ff-9bc3-4ca8-c6c8-08d9d1337664
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 16:42:01.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9bbHRKDsxUZ+8APkSa5AWad0NXRBbacbMALIsyRiwlRPKsJYDFVkokhARIuJkuj7YYlKmRwqIPvMlF7Kv187g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3837
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

Changes since v3:
 * none

 drivers/interconnect/imx/imx.c | 70 +++++++++++++++-------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index c770951a909c..d5b36c478911 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -34,8 +34,8 @@ static int imx_icc_node_set(struct icc_node *node)
 	if (!node_data->qos_dev)
 		return 0;
 
-	freq = (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul;
-	do_div(freq, node_data->desc->adj->bw_div);
+	freq = node->peak_bw;
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

