Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B4495E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380207AbiAULXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:23:16 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:53830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380147AbiAULXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:23:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfJ5wIF273kO9kP+Ee+w1N+V1L+J4rKJZUS+oVrmeWNFMhP7IQWapBh2Pur/4OGANkOD30CnQ3vb/SV2niAU6pY0mNqL8JdNOF/MshKhTMrLhNH+FjwQSkOP5O8pamOYP6o07GO558vdt9Yxv11VtGNhuxMeI6Fij3PPxdFwT2i5DKsjUoPaNrKSchyiLQZoP7g7d0Tibmhq8EufZdDzs59nz291+kCbIKqGHPx/X61IJpRLbrgqQhbpR2w6vn+JaUMeKqwbx7+ThqQPsfa8QIgOmbZtCoOj8ox/wNFE7RSEfcYws/Ud6kSfCh3vz9oawXj/sHKdjhWtn3MKDHHLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3IKSnQV1ODAqPm2Nk0E+p1P1DBTcXvUIb92QOZi1lA=;
 b=YHGUwIzPpbA50JYHKZ7FIvRWMN3+ptr+SlSeGcpHRa6vfvSIFuY7BgmEb2czujuX6tEqK5t7n0L08rnV1QEQnNQlLDDTKkPkWu6iCe1mLQksYbgc1+1cV/paPwR5fGu9nqO05ewMElqo3WQ69kvocRlK5OkQn0GBQFECdHZQASAhLvCC3zAzUQ0gHMJeEd8M/5X1lAZlx7NO4Bk2eyP/j+LGx1f2zvgKqMQ2HUaFy6tDDw1Gv5SgYjzQRBrTS7JW7g4qnRI3Ytu06vUdvg65kencWIDPjlSVZTVEL1mGfhfwNDfVf4X9pMbHKvw3urA8Y/PHefkPr/6viMKEj9Z4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3IKSnQV1ODAqPm2Nk0E+p1P1DBTcXvUIb92QOZi1lA=;
 b=XhDWkcMGbSPZRbj0YIlLdDi2K0Pe0VVqaYXygMbt/uOqBNusQfNovsm848lhb1Nscn2HQx+LiBYSLLEu82XcgW6kciCjMOnm2VtlClcDW293IA+ANXpUVbSsBtjX/yUuipiz1xYEGaPHwbZD/hLHM6yBXivURKrPcWfH9pqw0os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB8PR04MB6731.eurprd04.prod.outlook.com (2603:10a6:10:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 11:22:54 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 11:22:53 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC 3/3] soc: imx: Rename generic BLK CTRL driver to suggest future usability
Date:   Fri, 21 Jan 2022 13:22:38 +0200
Message-Id: <20220121112238.47281-4-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220121112238.47281-1-abel.vesa@nxp.com>
References: <20220121112238.47281-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 983a08bf-57ea-47ee-d936-08d9dcd05dc4
X-MS-TrafficTypeDiagnostic: DB8PR04MB6731:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB6731233229A94C74956903D7F65B9@DB8PR04MB6731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kV0z7+eCQRj4WeHHBjXA9YFQAHyobqiN0y8ugOJOgMVvcaowwvTLrXEtOs043PoGrZtBjLN5eQKo0F2DgnDWqe7hlujty/EEDHqEGAvGkOajsL/jTgHrVmYtOuLl4Dio9JjzvPR7m3RvPpPQPOhIm9ffAiQG90j1Nk2xbKGEbvXqOaS5joSM2EllJ/a+GhZWobPVzdJL1RobIMbiwehfJ6IcxRHg1cdSpq45JHjZWrJSKA0fvXGc5M63GoSdte/F1GLnX0Y7Z4yqmDBWUq8DI+I/CUE8w8wwdCx6OsgLOBikk8BjmEZshcR+XYCIL8I0vsGScRjMDlHludnU5YU0g6dcCXoED17E6lqp28NMWN2xHARYYnebNj5uCA3AMPPt26r8uALO+mOdvtXPC5z4OPrZHuIq4wlR/+F9oAvRqot4HhJAz1h02O1SUdN3oRutJfhPkBUlHH322yled0mBB6sTgrqMbbdlwYPWLpOxDBzABS/WLmpWdj/C9jKMoyNg7+6x9PFzZOfLMg0FT6vnNaIrjRu+8BypYkC4dNzqxSiA7fx5bbmGz6sY+MT/EB7MGoPGB+TndoUTEhu28HBdZz8PmZ8gbhke+e/T8R6w8DXlK7PUyCiS3zBx9TOOJDShsBJhm7grzJsehktd65szSSBMuPFAnIFmURJe2soTXbOPnYY672ARUtbuzg3GhkRmHz70YIcACUP/IieJn/bGg2WvnrwQ8zYR3NsaIezYQt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(52116002)(2616005)(8676002)(6512007)(1076003)(6666004)(316002)(110136005)(54906003)(86362001)(6506007)(30864003)(6486002)(66946007)(5660300002)(4326008)(66556008)(66476007)(8936002)(36756003)(44832011)(83380400001)(2906002)(186003)(26005)(508600001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bRYIo+VShwShBhXhMqKdng9NZJGMJ5yy4/RG5Y8QoVcg/GmW9MLRrbswvuv1?=
 =?us-ascii?Q?xXDvxZ4VbUmSFEsEzNtM5uSs2unJWa/rkvmZlNgquVQs/BW9fSCZINICpODa?=
 =?us-ascii?Q?nFKUlj2WAgwoE91Rg5nthbydW7f3ypX+JXloi2j981t4uJNhqoTgqeZrl9Yz?=
 =?us-ascii?Q?TuiK9/srhFp6Nsj7mNwTa/Zkm5xaqqXVgtwxw9ptbKcJY1X8IX7VjwHI379i?=
 =?us-ascii?Q?PcX4mw+H9gMOFL4ZakUOUQUj5MYbRvAg68SrI+mBNV7T0SnqpQNyFokRHi5D?=
 =?us-ascii?Q?Ti3wPIJ1urT90SisSsIzPFGzAUoLKL9CtwRsl23hb2dqRceTEN0ZH37tQC0f?=
 =?us-ascii?Q?eZKSNLsfxLbuU8Brmnt3N6ztXBArpZrfsXNOLmMfbKKPP7Zj12cvTIv4QFCt?=
 =?us-ascii?Q?pwJdhoEdUghmk37CMbNQlcdOJBwVqiaV5WIyVOhDSwBXYCneBBs18irfuOZK?=
 =?us-ascii?Q?qHLM01TDheNoFC+fBaOq0/7+qWVx+ffikDQm7XNuLhryAiStAj/38rPHu15I?=
 =?us-ascii?Q?6L0L8AFGe9oOVEZo/A29WjR4uk6Txa2zYJdR6djB+gaA+SQXGXbDxgggC4Bo?=
 =?us-ascii?Q?D+il5DtMLtiDfRtB/IKN5ZOUBzoYPoxJILGi/XeWsR5UsfqelB87JjBp3AfJ?=
 =?us-ascii?Q?Z6joTxkfJf2gfegM3WcAVM8rn6t0yat5PsPGgG8AAdhjaJew6sMPhvuenTKY?=
 =?us-ascii?Q?1wAxISNv3DrIdIL36wLixXpbm3yPUZYcIrF3R6kk9TJrJWIqQGKPxOevSlSz?=
 =?us-ascii?Q?ek9dVzNL2wT/w/O1HLCsylZSS2h/kuNIynNpprybe8S0c9BP5B+ZRlA5pZCH?=
 =?us-ascii?Q?wAab0ZB4dXOm9nGmV/hw9FvdHtdgSihlooGipeYYLJjSRY1vhQjhL2MaJAcM?=
 =?us-ascii?Q?aaBA5ErH93HE63GLVF8GSZ3mYlT/KnjIV5PAufq+b5H/RxGzBUAheUwMqrBh?=
 =?us-ascii?Q?zBXZrOsAoFyQjWIXZufL13vR33IW9gpl5555by5YgkcinIhsHNBFipPSXyQB?=
 =?us-ascii?Q?M8bO1mcoJFGQXwG4dIydY41F2L1R6wq2253HW915AN3khEzEqEb+Q2xGdWNe?=
 =?us-ascii?Q?tryOnPxu1bOBVz3pjZl5694kMl5VTFdKgTyiLOoMa9UU9XVcIEbd8IkDxoQw?=
 =?us-ascii?Q?ZHANAjyRl/rFvZVqyEpJClv8MLgcfdERYWkeL3+obDCq8N6ZNR8Fzo8K/yWu?=
 =?us-ascii?Q?jCSUw4P3OAZIzdY674SYg0Awb8FpkT+gCMynTpwvNRpK0PkkcDvPwxifwGjk?=
 =?us-ascii?Q?+wy9emA3lf/rOY2au12r0oR5XprvKmFiKjVXy/RNsWKwCBVf1uwE7bviolPU?=
 =?us-ascii?Q?BE7CaFgB3SKsJ1Z89T44ERWKnSGFaja7CpiArB3eFLRFoJHjS7ep/8NiaxmK?=
 =?us-ascii?Q?vfx9z9uyor92ivET0c0W+ZeiOIG3OYjdRlKNIHjjrIRkSVdPDnk7cW74ez9r?=
 =?us-ascii?Q?oiZ4xclHrrAH/GL/IdnYjSdKl7QWUmlHb/91+23JUD/e2C0S5AKI5cVpysDH?=
 =?us-ascii?Q?o1ejIyOyzXiNJFuU/EWgdOVe1dP62SXjFoi7fvKy1ulwWkMk1iN+v7O5Vmpc?=
 =?us-ascii?Q?qE/X10d53T5Kc8bGbSP3V10YDCkew3sVLHADzmJ0yuLAGR6w1Z1AZoU0glvF?=
 =?us-ascii?Q?TeGtKR6nH0Okf5cQBEHgPjo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983a08bf-57ea-47ee-d936-08d9dcd05dc4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:22:53.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +87WGbmiqTHbO6dO7fJGTMEl6IP1+3j77BVwK2u5j7TjcYpMxIFHJY99dI3PeNRkto426P9WYVsYMmfrgDat7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6731
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By changing the prefix for every single generic API from "imx8m_" to
"imx_" we suggest that it can be used by future i.MX SoC families.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Makefile                      |  2 +-
 .../imx/{imx8m-blk-ctrl.c => imx-blk-ctrl.c}  | 64 +++++++++----------
 .../imx/{imx8m-blk-ctrl.h => imx-blk-ctrl.h}  | 24 +++----
 drivers/soc/imx/imx8mm-blk-ctrl.c             | 20 +++---
 drivers/soc/imx/imx8mn-blk-ctrl.c             | 14 ++--
 5 files changed, 62 insertions(+), 62 deletions(-)
 rename drivers/soc/imx/{imx8m-blk-ctrl.c => imx-blk-ctrl.c} (79%)
 rename drivers/soc/imx/{imx8m-blk-ctrl.h => imx-blk-ctrl.h} (72%)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index f5243bc5f08f..5cbcb14ab631 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -5,6 +5,6 @@ endif
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX8M) += imx-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8MM_BLK_CTRL) += imx8mm-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8MN_BLK_CTRL) += imx8mn-blk-ctrl.o
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx-blk-ctrl.c
similarity index 79%
rename from drivers/soc/imx/imx8m-blk-ctrl.c
rename to drivers/soc/imx/imx-blk-ctrl.c
index ebdb044c6afa..58452a936085 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx-blk-ctrl.c
@@ -6,19 +6,19 @@
 
 #include <linux/of_device.h>
 
-#include "imx8m-blk-ctrl.h"
+#include "imx-blk-ctrl.h"
 
-static inline struct imx8m_blk_ctrl_domain *
-to_imx8m_blk_ctrl_domain(struct generic_pm_domain *genpd)
+static inline struct imx_blk_ctrl_domain *
+to_imx_blk_ctrl_domain(struct generic_pm_domain *genpd)
 {
-	return container_of(genpd, struct imx8m_blk_ctrl_domain, genpd);
+	return container_of(genpd, struct imx_blk_ctrl_domain, genpd);
 }
 
-static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
+static int imx_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 {
-	struct imx8m_blk_ctrl_domain *domain = to_imx8m_blk_ctrl_domain(genpd);
-	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
-	struct imx8m_blk_ctrl *bc = domain->bc;
+	struct imx_blk_ctrl_domain *domain = to_imx_blk_ctrl_domain(genpd);
+	const struct imx_blk_ctrl_domain_data *data = domain->data;
+	struct imx_blk_ctrl *bc = domain->bc;
 	int ret;
 
 	/* make sure bus domain is awake */
@@ -70,11 +70,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
+static int imx_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 {
-	struct imx8m_blk_ctrl_domain *domain = to_imx8m_blk_ctrl_domain(genpd);
-	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
-	struct imx8m_blk_ctrl *bc = domain->bc;
+	struct imx_blk_ctrl_domain *domain = to_imx_blk_ctrl_domain(genpd);
+	const struct imx_blk_ctrl_domain_data *data = domain->data;
+	struct imx_blk_ctrl *bc = domain->bc;
 
 	/* put devices into reset and disable clocks */
 	if (data->mipi_phy_rst_mask)
@@ -93,7 +93,7 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 }
 
 static struct generic_pm_domain *
-imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
+imx_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
 {
 	struct genpd_onecell_data *onecell_data = data;
 	unsigned int index = args->args[0];
@@ -107,11 +107,11 @@ imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
 
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
-int imx8m_blk_ctrl_probe(struct platform_device *pdev)
+int imx_blk_ctrl_probe(struct platform_device *pdev)
 {
-	const struct imx8m_blk_ctrl_data *bc_data;
+	const struct imx_blk_ctrl_data *bc_data;
 	struct device *dev = &pdev->dev;
-	struct imx8m_blk_ctrl *bc;
+	struct imx_blk_ctrl *bc;
 	void __iomem *base;
 	int i, ret;
 
@@ -140,13 +140,13 @@ int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 				     "failed to init regmap\n");
 
 	bc->domains = devm_kcalloc(dev, bc_data->num_domains,
-				   sizeof(struct imx8m_blk_ctrl_domain),
+				   sizeof(struct imx_blk_ctrl_domain),
 				   GFP_KERNEL);
 	if (!bc->domains)
 		return -ENOMEM;
 
 	bc->onecell_data.num_domains = bc_data->num_domains;
-	bc->onecell_data.xlate = imx8m_blk_ctrl_xlate;
+	bc->onecell_data.xlate = imx_blk_ctrl_xlate;
 	bc->onecell_data.domains =
 		devm_kcalloc(dev, bc_data->num_domains,
 			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
@@ -159,8 +159,8 @@ int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 				     "failed to attach power domain\n");
 
 	for (i = 0; i < bc_data->num_domains; i++) {
-		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
-		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
+		const struct imx_blk_ctrl_domain_data *data = &bc_data->domains[i];
+		struct imx_blk_ctrl_domain *domain = &bc->domains[i];
 		int j;
 
 		domain->data = data;
@@ -184,8 +184,8 @@ int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		}
 
 		domain->genpd.name = data->name;
-		domain->genpd.power_on = imx8m_blk_ctrl_power_on;
-		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
+		domain->genpd.power_on = imx_blk_ctrl_power_on;
+		domain->genpd.power_off = imx_blk_ctrl_power_off;
 		domain->bc = bc;
 
 		ret = pm_genpd_init(&domain->genpd, NULL, true);
@@ -241,15 +241,15 @@ int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-int imx8m_blk_ctrl_remove(struct platform_device *pdev)
+int imx_blk_ctrl_remove(struct platform_device *pdev)
 {
-	struct imx8m_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
+	struct imx_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
 	int i;
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
 	for (i = 0; bc->onecell_data.num_domains; i++) {
-		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
+		struct imx_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
 		dev_pm_domain_detach(domain->power_dev, true);
@@ -263,9 +263,9 @@ int imx8m_blk_ctrl_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int imx8m_blk_ctrl_suspend(struct device *dev)
+static int imx_blk_ctrl_suspend(struct device *dev)
 {
-	struct imx8m_blk_ctrl *bc = dev_get_drvdata(dev);
+	struct imx_blk_ctrl *bc = dev_get_drvdata(dev);
 	int ret, i;
 
 	/*
@@ -283,7 +283,7 @@ static int imx8m_blk_ctrl_suspend(struct device *dev)
 	}
 
 	for (i = 0; i < bc->onecell_data.num_domains; i++) {
-		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
+		struct imx_blk_ctrl_domain *domain = &bc->domains[i];
 
 		ret = pm_runtime_get_sync(domain->power_dev);
 		if (ret < 0) {
@@ -303,9 +303,9 @@ static int imx8m_blk_ctrl_suspend(struct device *dev)
 	return ret;
 }
 
-static int imx8m_blk_ctrl_resume(struct device *dev)
+static int imx_blk_ctrl_resume(struct device *dev)
 {
-	struct imx8m_blk_ctrl *bc = dev_get_drvdata(dev);
+	struct imx_blk_ctrl *bc = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < bc->onecell_data.num_domains; i++)
@@ -317,6 +317,6 @@ static int imx8m_blk_ctrl_resume(struct device *dev)
 }
 #endif
 
-const struct dev_pm_ops imx8m_blk_ctrl_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(imx8m_blk_ctrl_suspend, imx8m_blk_ctrl_resume)
+const struct dev_pm_ops imx_blk_ctrl_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(imx_blk_ctrl_suspend, imx_blk_ctrl_resume)
 };
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.h b/drivers/soc/imx/imx-blk-ctrl.h
similarity index 72%
rename from drivers/soc/imx/imx8m-blk-ctrl.h
rename to drivers/soc/imx/imx-blk-ctrl.h
index 618b3429bb69..8b70e072db1c 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.h
+++ b/drivers/soc/imx/imx-blk-ctrl.h
@@ -18,18 +18,18 @@
 #define BLK_CLK_EN	0x4
 #define BLK_MIPI_RESET_DIV	0x8 /* Mini/Nano DISPLAY_BLK_CTRL only */
 
-struct imx8m_blk_ctrl_domain;
+struct imx_blk_ctrl_domain;
 
-struct imx8m_blk_ctrl {
+struct imx_blk_ctrl {
 	struct device *dev;
 	struct notifier_block power_nb;
 	struct device *bus_power_dev;
 	struct regmap *regmap;
-	struct imx8m_blk_ctrl_domain *domains;
+	struct imx_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
 };
 
-struct imx8m_blk_ctrl_domain_data {
+struct imx_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
 	int num_clks;
@@ -49,24 +49,24 @@ struct imx8m_blk_ctrl_domain_data {
 
 #define DOMAIN_MAX_CLKS 3
 
-struct imx8m_blk_ctrl_domain {
+struct imx_blk_ctrl_domain {
 	struct generic_pm_domain genpd;
-	const struct imx8m_blk_ctrl_domain_data *data;
+	const struct imx_blk_ctrl_domain_data *data;
 	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
 	struct device *power_dev;
-	struct imx8m_blk_ctrl *bc;
+	struct imx_blk_ctrl *bc;
 };
 
-struct imx8m_blk_ctrl_data {
+struct imx_blk_ctrl_data {
 	int max_reg;
 	notifier_fn_t power_notifier_fn;
-	const struct imx8m_blk_ctrl_domain_data *domains;
+	const struct imx_blk_ctrl_domain_data *domains;
 	int num_domains;
 };
 
-extern const struct dev_pm_ops imx8m_blk_ctrl_pm_ops;
+extern const struct dev_pm_ops imx_blk_ctrl_pm_ops;
 
-int imx8m_blk_ctrl_remove(struct platform_device *pdev);
-int imx8m_blk_ctrl_probe(struct platform_device *pdev);
+int imx_blk_ctrl_remove(struct platform_device *pdev);
+int imx_blk_ctrl_probe(struct platform_device *pdev);
 
 #endif
diff --git a/drivers/soc/imx/imx8mm-blk-ctrl.c b/drivers/soc/imx/imx8mm-blk-ctrl.c
index eb63d28b0157..15f1e431c1f3 100644
--- a/drivers/soc/imx/imx8mm-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mm-blk-ctrl.c
@@ -7,12 +7,12 @@
 
 #include <dt-bindings/power/imx8mm-power.h>
 
-#include "imx8m-blk-ctrl.h"
+#include "imx-blk-ctrl.h"
 
 static int imx8mm_vpu_power_notifier(struct notifier_block *nb,
 				     unsigned long action, void *data)
 {
-	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+	struct imx_blk_ctrl *bc = container_of(nb, struct imx_blk_ctrl,
 						 power_nb);
 
 	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
@@ -45,7 +45,7 @@ static int imx8mm_vpu_power_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static const struct imx8m_blk_ctrl_domain_data imx8mm_vpu_blk_ctl_domain_data[] = {
+static const struct imx_blk_ctrl_domain_data imx8mm_vpu_blk_ctl_domain_data[] = {
 	[IMX8MM_VPUBLK_PD_G1] = {
 		.name = "vpublk-g1",
 		.clk_names = (const char *[]){ "g1", },
@@ -72,7 +72,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_vpu_blk_ctl_domain_data[]
 	},
 };
 
-static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
+static const struct imx_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
 	.max_reg = 0x18,
 	.power_notifier_fn = imx8mm_vpu_power_notifier,
 	.domains = imx8mm_vpu_blk_ctl_domain_data,
@@ -82,7 +82,7 @@ static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
 static int imx8mm_disp_power_notifier(struct notifier_block *nb,
 				      unsigned long action, void *data)
 {
-	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+	struct imx_blk_ctrl *bc = container_of(nb, struct imx_blk_ctrl,
 						 power_nb);
 
 	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
@@ -104,7 +104,7 @@ static int imx8mm_disp_power_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[] = {
+static const struct imx_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[] = {
 	[IMX8MM_DISPBLK_PD_CSI_BRIDGE] = {
 		.name = "dispblk-csi-bridge",
 		.clk_names = (const char *[]){ "csi-bridge-axi", "csi-bridge-apb",
@@ -141,7 +141,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
 	},
 };
 
-static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
+static const struct imx_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
 	.max_reg = 0x2c,
 	.power_notifier_fn = imx8mm_disp_power_notifier,
 	.domains = imx8mm_disp_blk_ctl_domain_data,
@@ -162,11 +162,11 @@ static const struct of_device_id imx8mm_blk_ctrl_of_match[] = {
 MODULE_DEVICE_TABLE(of, imx8mm_blk_ctrl_of_match);
 
 static struct platform_driver imx8mm_blk_ctrl_driver = {
-	.probe = imx8m_blk_ctrl_probe,
-	.remove = imx8m_blk_ctrl_remove,
+	.probe = imx_blk_ctrl_probe,
+	.remove = imx_blk_ctrl_remove,
 	.driver = {
 		.name = "imx8mm-blk-ctrl",
-		.pm = &imx8m_blk_ctrl_pm_ops,
+		.pm = &imx_blk_ctrl_pm_ops,
 		.of_match_table = imx8mm_blk_ctrl_of_match,
 	},
 };
diff --git a/drivers/soc/imx/imx8mn-blk-ctrl.c b/drivers/soc/imx/imx8mn-blk-ctrl.c
index 20f53cd4e387..932b81515792 100644
--- a/drivers/soc/imx/imx8mn-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mn-blk-ctrl.c
@@ -7,12 +7,12 @@
 
 #include <dt-bindings/power/imx8mn-power.h>
 
-#include "imx8m-blk-ctrl.h"
+#include "imx-blk-ctrl.h"
 
 static int imx8mn_disp_power_notifier(struct notifier_block *nb,
 				      unsigned long action, void *data)
 {
-	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+	struct imx_blk_ctrl *bc = container_of(nb, struct imx_blk_ctrl,
 						 power_nb);
 
 	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
@@ -34,7 +34,7 @@ static int imx8mn_disp_power_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
+static const struct imx_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
 	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
 		.name = "dispblk-mipi-dsi",
 		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
@@ -72,7 +72,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[]
 	},
 };
 
-static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
+static const struct imx_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
 	.max_reg = 0x84,
 	.power_notifier_fn = imx8mn_disp_power_notifier,
 	.domains = imx8mn_disp_blk_ctl_domain_data,
@@ -90,11 +90,11 @@ static const struct of_device_id imx8mn_blk_ctrl_of_match[] = {
 MODULE_DEVICE_TABLE(of, imx8mn_blk_ctrl_of_match);
 
 static struct platform_driver imx8mn_blk_ctrl_driver = {
-	.probe = imx8m_blk_ctrl_probe,
-	.remove = imx8m_blk_ctrl_remove,
+	.probe = imx_blk_ctrl_probe,
+	.remove = imx_blk_ctrl_remove,
 	.driver = {
 		.name = "imx8mn-blk-ctrl",
-		.pm = &imx8m_blk_ctrl_pm_ops,
+		.pm = &imx_blk_ctrl_pm_ops,
 		.of_match_table = imx8mn_blk_ctrl_of_match,
 	},
 };
-- 
2.31.1

