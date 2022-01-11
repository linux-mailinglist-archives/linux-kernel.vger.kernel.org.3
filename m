Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357A948A674
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347183AbiAKDga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:30 -0500
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]:16091
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347548AbiAKDfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:35:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH3YCbeIWIquy8AUmetFiviZZ2QIi/XPLGiwmGPRCKQpzx3cfygyRfOYXx71a2duzUgObzRYbe+ouQMTYpNRNPUuDJngDDRknTjb4SrpBpeJvSTjwlGRtN2J1KEpxZ/UWxcuZQEbOcbdIgyi/FC72Diuki1/VHds6EVHyJBTO7Tb/7eLT4HkYqxO7o7m0ACJZVuC7uGWv44v8mYKjxgPflzKI+KRCmu+zCrPQAW/UGkVPvEJgAp7p6lWIOWvey7A0Z3dNwXdFM6Fl+sclD5299c+hc+K6/VjFyyyOX/B+1x6muwJEOMUPMzujCtc13ODhGM39nFuZfmp7x6zUJFnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtpKuJAXl47t4yKty4/JdEtA7DB+EQTDkfxheBzZFjA=;
 b=f57CtLwLvsDqoP+CfqTT7sVAjYAzGZW6RdBcHcRMrqYgs4w6Qgv/Hg9JDqU+scDUm0uuz+W9rhhImCGxTGXxYliIC0PQagcKcsNSt6UZ3BM6mvWO5Gh2YwbytP8nA+JA4Bn6/s9vni2fcIMsq9BMxumClcDuwjFvQmQ0gDRstH39elEWEtASb6iRDTls7uY3S3NacG9PM/nsaAJ36DCuQDhxZqfS/qbCmI/gBelRbHv3riOxTtXG44VJYHMf7FbioiNDfRMgVQr0WDqItYrQaTef3tI1VyGoKM3rOGFldnaka1WxbmEMvWV7UbqdoY9KTARUnIqpe80vr8fZg/YROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtpKuJAXl47t4yKty4/JdEtA7DB+EQTDkfxheBzZFjA=;
 b=e/npsK55P30ZKkeFmL9NxfU2cTkA00Gc9XH/Du8dwj/w8I/h1DL8pIPKxTsJS9GbGYUUC8YsM45FbzMSj628+6AohqIYL29Rve1rAlor3YhtW70ZLDo0iRnsVozDIpf2g21bMvRMm37bqqC1I1gPQFNsHMcIY1qn5C4I1i2/amI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 03:35:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:35:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/9] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Tue, 11 Jan 2022 11:33:31 +0800
Message-Id: <20220111033333.403448-10-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba1738a7-561b-490d-13c5-08d9d4b359d2
X-MS-TrafficTypeDiagnostic: DU2PR04MB8520:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8520C042E9F1A09D718ED417C9519@DU2PR04MB8520.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqhNLkZ+b364GwzJWvqgplKRjX5m+9SrXws1CGBGY2kNHECB3kOypUJkFWwLGb9dq9ZweOTK3F/FybbS0IuAtd19tHi2/yr4X5AHG564677bOB7KCu0J2PyiogBIejMcePSYWgp7SwNB3XfpcBZO8/GjQjj9XBlOArluDnIcwdQ83FQp9p3v4feVeB2HhuRF3L41f+dNBjAvax5y+qyKjqm5qIiik12hG2GfTMk0tKUAm6epvH1juvJPnkEjqrh+AImaQBFt+AzBzwbk6yCK3mo8TR6VC9Iw1cNBAuXnlJ3xO2ZBhVhe2KAJsMccMeTS6joTZUAWl5JXaoaPBvFqIxdekQKXBTQkxjVHeAvBDMaQdIrYK9p7CODA7KuR76bUc6DXxQsSo7sidQWw0R+FbrgISU8FWRW5ffRmwKJ/hB7WcRr05ImRgZ+jQ1UQHUSN0b1CxeKUAgATuN01YSmMPl2m6PCTcs269av4LMfsiztPJDr3d/aUMInS+5W6wWIp1Z7FZDv//yCFMPQdXOLkeUZsFsg1r9oCEV5aMJxlj4df3DRmcpotaq3dy0YdsorMDD7iTaw3sJeHx4F7we7Mm5EMAI1l06w1Js88fEfe9X8+BbPl59AXaXsYV945J1yw3zBnrNrC8D+12UqhCbKCkZBoFiyEBrBdpswSyQ0abxDrcB4WpXTnd6Js03nsreP6E9vwPMksJ9nQ5M8Ct5iIGr8wvQ4Gv4B15/FayfGWz6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2616005)(6666004)(4326008)(186003)(26005)(6486002)(2906002)(86362001)(921005)(6506007)(83380400001)(508600001)(38350700002)(52116002)(38100700002)(6512007)(66946007)(5660300002)(8676002)(1076003)(66476007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIU6qkQxKB56WPOlBZtBEwaRpbkZWCcp9LNLVwmS3EjOMJyY8+jbE44LARHq?=
 =?us-ascii?Q?KgIk5klHgyQ2+tCB07BvTlM8PSX8iccDGtI7gWscyxVbfYGJuGHBfDWzY+eN?=
 =?us-ascii?Q?4VMIwZ+v0WWlIp2mM4mimz0fOpOlbbKvaNAZ2IpVvcSgu8Nc1XZljLc84pJg?=
 =?us-ascii?Q?Xw2DRvuS5sQa03aw7tGG7/Kb9sQzIu7Hyn9auCV9aTh8gxcUNf1NJSFJrEFq?=
 =?us-ascii?Q?EZb+4awz8o9DfveZe1VOPbEoLk/h5S5Vvy4dfb2m3q44TQkFFEJBu39VWJ5Q?=
 =?us-ascii?Q?XMcZD6K1v/Hj2OEtxv3Sy16TsOQlE10gdnlJWQOGZY2G9xO9frrFZ+ug8IZD?=
 =?us-ascii?Q?pCEKQLuHcJin7uijbVo4sgDpBmZrhlgFioKnhJus7JAdz19ZEGpnLy/c05tK?=
 =?us-ascii?Q?dxaI43IJSTDpGK+SqXnT+wgkofmL/X+/HN5NjHxlLAIEif/zj+w2z7amAlWl?=
 =?us-ascii?Q?k7ynQNLZnHdJt4WrahSTzkpgfFO/IXbwAwgn8LcuSiKM+9GYqcYu+moVZZ3t?=
 =?us-ascii?Q?7HC6PT+3vhkUSBXQDSiX4LpNEemYg0Vb8h4c6hBH3/W4Ih/JMp1doy67AmGH?=
 =?us-ascii?Q?02iyvSrRg3R8C6NUNn4scKR1oNU4DH71Ewe2JwWs7KxK6K0IONVw5NAw68Py?=
 =?us-ascii?Q?xvd5hVF+luHCWzl5qTGdumpalp3ALDo1RyXpkilcEtwRE3PzwA671bvQINMo?=
 =?us-ascii?Q?BisCS2Rw771enVBEvoNsWdu0lMBQwAXRPmfF0K8AUZwN7zZeuTc5PNHvHzS6?=
 =?us-ascii?Q?8jlEshRBRJwCoWEqNJDmVIFHLRucqf80HgHcYtaRsWJepJw2aYXlKSAVlmtv?=
 =?us-ascii?Q?OZaD7H1HDTlGregxuKZ/3xpk8yBmkGkq3MUTTDWP3oxv1Mg65AWM6dsDnpC+?=
 =?us-ascii?Q?crg35U4cmeRZiTLD1SwBX9yWyY+zJcg1koP/4dZhKiy7/FJQHChZSktmL6Az?=
 =?us-ascii?Q?rsZcKxfcLU1jKljuvGoQOKpCl//CttoFQ45nDdHoqWICwC3hR58zFwrrBpj4?=
 =?us-ascii?Q?uPmv2aH37ToRPxUG3zsJoIgIF/dhWScvktCX5t146ePMOF4IcPcy/iEI19GY?=
 =?us-ascii?Q?aX/XcQ8V2xkNZJ3loJiSG7cKxOl1AHIxWPTdYHsO9y4M99PsAXHlyFj/0K6+?=
 =?us-ascii?Q?e3y/eGo7h4pGo0YgaoLWvFnZmNM5ncwik5aCnZVAaY14/Z30Xf/fQNYCuElF?=
 =?us-ascii?Q?5g2yrUz0KUluwKW5YGVQ1tOTnc77VHqY2Ctb8Ui1Ftrv/RbD9//4G1z3YWcn?=
 =?us-ascii?Q?vpkxQX1idm+IKJ+es67C8cHwZb4U2oQcHldKi85ELHhvfc2Cp5DACKwsbi6X?=
 =?us-ascii?Q?bALFm1o5ig+iNXX7MigDht+bAGzaWLEnnNli0CPox/RxTX3IaiV9gYmycPtM?=
 =?us-ascii?Q?z7TFz7/R+YJaP6vGJHAnwJEWqNlOIXxBB5YIinoRgdqRPW3j2lXo0I8WKynf?=
 =?us-ascii?Q?w4qRyTnaeTEnpBCT0TBcMpOSxP9v6nUsKY96mRLOODQvupcd38A3XTNpxfeD?=
 =?us-ascii?Q?fVUgPH8Q66n9VneLLf6BzuAKw4qz48Bsj8qrf+OTMzOB4vN0TIUYGwjUf8O8?=
 =?us-ascii?Q?FZvovowVCGq+EFk2ZMqMVnY/6LPZQKFU5G0JgnttNn5hug5X0sy24zGjeZPi?=
 =?us-ascii?Q?MsT4YJY2KYdhVXHpXs6OUW0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1738a7-561b-490d-13c5-08d9d4b359d2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:35:02.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9TbSjrPAggDZa7iunDic77ChekGzpA/wldl7q4zqSgwUbh+95e2WcVKpBVUdJLD49hhMLJucWx6AiBtJD/9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When M4 is in the same hardware partition with Cortex-A, it
could be start/stop by Linux.

Added power domain to make sure M4 could run, it requires several power
domains to work. Make clk always optional for i.MX8QXP, because
SCFW handles it when power up M4 core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 64 +++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 5f04aea2f6a1..09d2a06e5ed6 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -16,6 +16,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 #include <linux/workqueue.h>
@@ -97,6 +98,9 @@ struct imx_rproc {
 	struct notifier_block		proc_nb;
 	u32				rproc_pt;
 	u32				rsrc;
+	int                             num_pd;
+	struct device                   **pd_dev;
+	struct device_link              **pd_dev_link;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
@@ -305,6 +309,9 @@ static int imx_rproc_start(struct rproc *rproc)
 		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
 		ret = res.a0;
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x34fe0000);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -334,6 +341,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 		if (res.a1)
 			dev_info(dev, "Not in wfi, force stopped\n");
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x34fe0000);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -719,6 +729,56 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static int imx_rproc_attach_pd(struct imx_rproc *priv)
+{
+	struct device *dev = priv->dev;
+	int ret, i;
+
+	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
+						  "#power-domain-cells");
+	if (priv->num_pd < 0)
+		return priv->num_pd;
+
+	if (!priv->num_pd)
+		return 0;
+
+	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
+	if (!priv->pd_dev)
+		return -ENOMEM;
+
+	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
+					       GFP_KERNEL);
+
+	if (!priv->pd_dev_link)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_pd; i++) {
+		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(priv->pd_dev[i])) {
+			ret = PTR_ERR(priv->pd_dev[i]);
+			goto detach_pd;
+		}
+
+		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
+						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+		if (!priv->pd_dev_link[i]) {
+			dev_pm_domain_detach(priv->pd_dev[i], false);
+			ret = -EINVAL;
+			goto detach_pd;
+		}
+	}
+
+	return 0;
+
+detach_pd:
+	while (--i >= 0) {
+		device_link_del(priv->pd_dev_link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return ret;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -749,13 +809,13 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			return ret;
 		}
 
+		priv->has_clk = false;
 		/*
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
 		 */
 		if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc)) {
 
-			priv->has_clk = false;
 			priv->rproc->self_recovery = true;
 			priv->rproc->state = RPROC_DETACHED;
 
@@ -782,6 +842,8 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 				dev_warn(dev, "Enable irq failed.\n");
 				return ret;
 			}
+		} else {
+			return imx_rproc_attach_pd(priv);
 		}
 
 		return 0;
-- 
2.25.1

