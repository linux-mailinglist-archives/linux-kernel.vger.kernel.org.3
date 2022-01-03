Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980C6483792
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiACT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:29:50 -0500
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:60390
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236159AbiACT3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:29:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTmFXyyLrAJgWGrFpr/89Z5KV5imDbBzYBY5KfjxM2ZX1cTxoBA5IZ/SWZ7Jx/UU0pF+7RI+AiKpKWJUR8Gg/95H45rm8X+fKaiIiu7luYDqFWnPrLljcM7eB6Tdv4vJxkQdsEQgEQ74I4k06AKTbcfsjBxRJnGiXgdruExWeW1O1dcp4t0eGvqzLelJfOhy+FZMgl5QhKzoCVW+UGLp7hvi92tY2f91OAJSDDIEUuhgWuoxGT3s8wwjnySqTBYqKAF1GjbmxcJdj7+indOO21bc1btfOQaDXlfRP65+WgR+nRmphtQraY9EClPYQsq9LkJfik6GlyvRXJmhan61cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFPVU1Abybot1iSdkbY4jqpdA8a8CQNs6d0OfZ3uFHg=;
 b=U3SN4o/m2N5h9NUZxpnqa62nMctKcDS2j8Tr/y58NTB3ICeBe7PFKNkvqNyAHDjomqBvNS4bCvc6UY9cFf9/2S4W1uRxxQj+rmvKe3nnkC6Rm4KlQyTCqOCNoAMIwaXPg/Fv4kTwBD1tGSnXSJ8HUuE42RxUVrkoI3UEqPopW6vk9WgIso/NTqgA1iX8cP9GUV+fKLksJlFfbM04OdHqIcVe/r9GesODAzNxrSGdHfPZArj/JmYqi9s2w0z9EBCjiKsLmevVzkW+ZbApksjRwO/M2C8gwhdN0YGpu6OMyv7QOQ41LkOfWka70jsi3X0IluUiRl31O1E5fQ2OmkfhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFPVU1Abybot1iSdkbY4jqpdA8a8CQNs6d0OfZ3uFHg=;
 b=dO0i+jBsWJfqNIoKv2e/i5XMP3FmznADNiY7YngN+jdcGyfSH8oaRv3Z3Q+T1g1jkiMlIalcrT7K4lLVpuEYXG91rPz9Coe9LEfbNDAzRPIR1wlgut32Vn4r0WVvOXdJRkMMad98OtWNpZUrX9naYYrWXm5YmywRLUuQMhiUgw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Mon, 3 Jan
 2022 19:29:43 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 19:29:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id node assignment
Date:   Mon,  3 Jan 2022 21:28:59 +0200
Message-Id: <20220103192900.946521-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220103192900.946521-1-abel.vesa@nxp.com>
References: <20220103192900.946521-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0501CA0009.eurprd05.prod.outlook.com
 (2603:10a6:800:92::19) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f5c7a7c-5264-4ce3-9b07-08d9ceef647c
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB710435D2C3925BF54564DA43F6499@VI1PR04MB7104.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qNsKNBC+cEpZa8kXcAdaLg4y1/aDtAE7mg9JIXkfcHwU9TBFeo9+oH0Yy7zviCUcCm075JE9+S8hroE+GSP5NGab7izLt3Opta0RXqq5CeLrzWowYcEPsBu5moGsICqgTQ7S2q74RdfaDPm2qv68UY+n4XBplBVQ53izFS2G0yP1gXLrK48qjwoDRipXJhiMlCs4+3rk3BbKgRaivP041Q34H4TVjiROB1KUSFYUXurzshGFNVplRklMHmY4cnkyRmybo0lSDRuX4SBiipVNoKnOgu3HLXTrVHLaM4AiUQc9UYtacCux938tpDhFpBtYa9x5acARbhc4TsruHJ/BupGr1FOjR+lJPMe6c+bd9QLr+m4mi+AKDmHTLW2jjgjCheYYLEaYKFJt+4Tn8xL0iTk+hz9hPfCKwEMfkeIdIkJTGWw/9b+/kDDRJAE3mgXVEW8G+XMwRf8ChWcAkdy+X8afolgd1OCYtPegGFbCjVf86/qWcEcxqowUzWkOJGj8ivRc/8DGWx2/BwAFMype7LGyeevfVNBsnnE2KkObo28DfWMCla9qUJiYDrwuEDBOsahihwCDsbo6zFwYF2XORnBPOZ1ezmI16pNZ9lpX1X229OkCiptMyveCse4aYEXAqo4gdzO66BcUj5zk74wguDGhNIL/5jNW6TKL/kOC0vF93cu31fE3Yp3vZaUKvZcCxCBsO4VLEn1vNfRi9bvJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(66476007)(8936002)(36756003)(8676002)(38350700002)(38100700002)(54906003)(110136005)(86362001)(4326008)(66556008)(2616005)(66946007)(186003)(26005)(316002)(1076003)(6506007)(6486002)(6512007)(83380400001)(44832011)(5660300002)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+EhnK/HA3/KjnPrajkjrfjre+iikhYAUyeYIR2OnFNBuCH9zTzFgeZyfCz38?=
 =?us-ascii?Q?pf90Fk9/2G5w0zG6VJobLrphRDfc9wa0bCs00UKzD8M7hIa4H2qgiD8JH58C?=
 =?us-ascii?Q?GtcnUqg872aEBJ9sC/wtnMMcpOErWY53VWQek0TwgCbg3uFznXdVTo2sPmTT?=
 =?us-ascii?Q?y7PD3aWTFt9ieG1dUXHKXDdxZuSlUBJ5Nlkm0B0fgYVKyM/d5veUV1g1GQfl?=
 =?us-ascii?Q?AUp7aYUCc0Pprnv5BeOWazJ2pkW96RnTr+NS49Olf6uUXgPThrRwF/shNU5Z?=
 =?us-ascii?Q?B6iFroJ2we+8o9YIUGK4f7gMRWwX4/zNVZd28/ls89K9dHYok2qwCfpZWsFu?=
 =?us-ascii?Q?db1VkkBqovvaCc1tAQbEkUjvUus3Ou+nvazbQjAtlSfPMvXVwoBzWj4rCj1g?=
 =?us-ascii?Q?qfOZjI+VSnmhdWZyFzzm2YGxi/0GGH8hCkA7727lqxaPlfQk8S4JfwTTxphD?=
 =?us-ascii?Q?nAoaOkH6za4GlCW+cjrh2rTWPH50zvdl/WX4mpShC+ZpMER56vX1G9LLKwVj?=
 =?us-ascii?Q?qfpMHDtWSEvv167xy3NB9GmLndOF19ThrB2MA7wul8FOsMC1+tbIMycSmHQ/?=
 =?us-ascii?Q?3dTPrpx09r22aRCfSttURcvXnb6DmRH5JEwhG1V4TCfReqKmd8xAKYqpf823?=
 =?us-ascii?Q?zICY60OYo3mbmtOso9RB83mpFvKwq+naMrVdZXHU9mfWK9ecdUK7Wb/UIn44?=
 =?us-ascii?Q?XbH+9Ee8z0rhhpqe9ECvqAG0xC+5tPLICHvZ4YSATiM2Bz1/7l/ws8Iv3XwW?=
 =?us-ascii?Q?5bQ7quneCmNV4XLgOXRwqejrN/sdtZtbcivlCfmCcYsERnIzTK0bscEkrOTE?=
 =?us-ascii?Q?N5jV6r4QOvziBt5QdkmVIiGckZQrQCwnMSdoD4ZYtHVmXxQVnukNuWZJXv50?=
 =?us-ascii?Q?ltQkMrir/dfrEI6rTa8BTZHtfnbdE09q3gggx9NzO3OJj63GcXy/7sLm/iVL?=
 =?us-ascii?Q?i2lY+F4UKZZn/UNQTt3br+Qc5hp6pz+Ds7DX7xKZH0mX22v0UMcedIcTPGwW?=
 =?us-ascii?Q?pedc0Vf4xlrnfkuVA3fhJ9Mmg7kvdwL2jmt2veDXzzvetMgFXOO7uMs77up4?=
 =?us-ascii?Q?jv8I/CpG6mrwgpbLePESdCWN7kuHy9IidPAp++HHkmDIcW9641ecZu6ikMb7?=
 =?us-ascii?Q?LevmUXcQZFtvlF80J0GvnlcSPdg+yEiFv8+AX9lqiT1oIYQPgJDn235EmcVV?=
 =?us-ascii?Q?sEeJMjLarPRRoVXWhfRMbqQpCTRN0z/LBLFOPtdBdOqnWiTcrb5FkbHmi9jn?=
 =?us-ascii?Q?kucRMfksG5L38/54bSH9aqbg1srT7NW1ciR0NVi8HdJm2rxlituffK03J7A3?=
 =?us-ascii?Q?Ys5/BO2u99qGeYZnTOa0HcJLMrV1mXQjM+Ia7XPUAePwlOjaPtoz+oUh2YUs?=
 =?us-ascii?Q?P7YR64gE6gCXbGicYvf3MqzeAS5By+gPJvWycvBgwCkPP7SB6XBAcQUTr797?=
 =?us-ascii?Q?ne2QmPrsm9vccaQEzqASJnIqOOFyUYax2e4Cywi7AW0TqTDdhqX4wqSo6NbD?=
 =?us-ascii?Q?IOaAr1n7WYhZQNtvkCuHHBUh+OFiO2YJMuDDnKWGw4JXCZFQjsJRdms9hJUk?=
 =?us-ascii?Q?IvDhaqDfqJ2JZSnLrcyb0eKVzWiqSAFQ42dLgGUhJ4qWbx1MBjcF+FUlNWnC?=
 =?us-ascii?Q?CCNNdpnvLGORGcwkOUIwUHo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c7a7c-5264-4ce3-9b07-08d9ceef647c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 19:29:42.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+p0jMBq6KvBpkemivs+W15gm3ita/DPMLkGIGQQ2vIYiSvfLDspabSiYbN37U/FJcOBGz7+6Kxy/j1s+Xfx8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
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

Changes since v2:
 * switch to use only peak_bw rather than choosing max between peak_bw
   and avg_bw. This renders the imx_icc_aggregate from v2 unnecessary.

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

