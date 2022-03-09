Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736084D2C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiCIJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCIJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:42:23 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50070.outbound.protection.outlook.com [40.107.5.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D7106CBA;
        Wed,  9 Mar 2022 01:41:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpogthNmxLLFg8ksB4onGZIzFE08z2jILUMg+/+A16+duITNUnb66CxtCMzB0LVCCGfxaiC3PIRo7dF9iN99tntHwjzaPOGJUTTPOyyrG1FkcjBEw9kbyHIVazwGVHUOAH8CSji8VKdaSDaKi2kls8YPyLqiPqs8iwgle5/8oc1t/qI3OLXD5ffz8utTiyjGKGUUrRqAnwHOw2Efw4Dns1/V6GQsx9bKHBkxoy2nT4/20bb6iFiFbtJGviMbMGSeLdQrjYy7twIdskGh/kuRGcwcJnfi9EwmNTMfZwVGsN9Hvy9Kq+5rW3Nvpdu3Ugi0G3NRJhbOr9yDAmlP2K1vRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIS1tDzX/A3x8V/BrcBG/rU8H/aVYGGa1Bz/ZKzN/kM=;
 b=AtCNySnDSNKs+YyMCx/EvB5Cv+q1dK6ggU3TNfNtuUJGJ+ZuCyBwxchIZ38laUPgYVOWrUuVyuap97SFq0FWxaz6uyLrnYLRFUphGOk5GOBYT0wEA8TvvmwmOh6hgVb/hAHs45uIs5xS7OgndNBce7QgltQkpngL0cJZs2ER8K0bAqGMuWeTVqe8lX/piPbdk7ezMBSsvlv25JsdQbEM6crX7JHPhiTfNiCy7tce1OSqoNdtxmSrf74iGOkmV1qT6b61TbY+NRdh+um4prGHdNgpokNq57PykzM8P5N4WQaDQsF2MGsZkrvytXpRJ3MXz+Dh0bKIMtpJB6oSBk4v3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIS1tDzX/A3x8V/BrcBG/rU8H/aVYGGa1Bz/ZKzN/kM=;
 b=DdE5T00LTOY0K60bHIrMGTmBIJbmXQi0F+AIK1GEksnq2h3qvbuZue6I7n6UAneH3xx7AlPF2vkCksxeYZ3iKoq7j6/PlanNmupsbxmHucDyyCNO2uEBZbsZkztk1phoZtqhgOC/mFBKf58MvJ9suQjs2nnul4zIHggaKmk8h1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:41:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:41:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/6] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Wed,  9 Mar 2022 18:21:16 +0800
Message-Id: <20220309102118.8131-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220309102118.8131-1-peng.fan@oss.nxp.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71526fbe-8dd9-48dc-654a-08da01b0f840
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB604323E17E7F17699447AB87C90A9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anG/FtnPQcDi6+ezkud9/L17TnxBGbHJVE/iRc93o89i+ytUXnjwPHYEu2snPrhQhV3rpNuF1DYvb8Aw437ZTb+hvGKrULyb4yPlHDBJSXXNCvjNpEryGDNq6cgJG3TCdTZdzLpkmyi4GSpKHFy7/zuEzfeVfCNxLqRQe+p9sUqnRGXIS96ptEdQHdPSU1vOHJnQX5AN44oDI/m0C+Ww+3J8pWY8rof2tA8Di7lOIeNhabDSN5S1j2HNOgvsob9XPRzphpHzdkIJJl0ekWPDdlYRARzA6AmoiZbCq5N6ztlFp2cm+Ra/ssvqXKfshWw3oqwIm6dP5AqsTARYnKtesPCQzO53Xq9esR6MMAP2SFeL5np3r0ehGh4y8YnVMK3wpTgxx8psOUapCpLwIXXBUFShquz4dtuJm9DqV39Yaq9HPOJPNGBsrWCcnAXgBsi3XO1WTY43rHAwvKFi6IlNJGsnh2rZCX7QQF3jsSiEVvd3qeJjV6ofhxJGhb6etFFaJ16CHltiUFXq5MflEezdx2m5eVoKyL1VE9UC8fpm7SlfMxjWWuBkYGsBIaff8NYutN+sGwukG9sXA6RyYE+OPg31nMwFgRPsDKbd+1OduoEveQdI45Ee3OlOcJ9W6SZHbsQXQq3rAM6gi1YhdbSj8DLc9QyB0Eao+AehBongsRCfC+A5fnktfWGOfeXpK5vJ8hmrPEnqj6cah/oeDXalXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(66476007)(66556008)(66946007)(6512007)(8676002)(8936002)(7416002)(2906002)(6506007)(4326008)(6666004)(6486002)(38350700002)(38100700002)(5660300002)(498600001)(1076003)(186003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j8Bywb+sngx3srf/f0HC9duAc73ihA+j4E5JRgJLOhzfsgfdI00zIeEPUhfO?=
 =?us-ascii?Q?ptRjNp1LSH1ViSDUfkSsZFyPoWmMfoFo1b3jMKqfZwYU2IEoO7IrXFG7wg5z?=
 =?us-ascii?Q?UQEZxSxkJt6RK8UvUWcI0KEI4l6I7jPcfr4rQ6NC+U2eDNn37846IsbYMg/6?=
 =?us-ascii?Q?u96IvtDrD7a4UzAfyYEMcvfEp8tiMh0Un6EiXVqrode9B0vAt2vHZsQSt5kE?=
 =?us-ascii?Q?mWcAy3qNCMoVsROflWwfiYu3Vt/No1WM4c+ldoQzNVdW2tgl8ZbFQlBcaY1z?=
 =?us-ascii?Q?eVSONeOYuCBCbj6X16Pfm5Zv90EMKjFtHS9N8UbBup0TtBOHG9CyPDs67SmR?=
 =?us-ascii?Q?F6b5j9bYzx6bufT1k89YyBMZm8WsuqNqyOFaBtchcGGXkZ8z5Y3mZ5Tpy9Hh?=
 =?us-ascii?Q?fwAa5G+WKaiBPdyc5MhegjXUwEzyAf1DFYg/I31JrmoFkl26IyNr62RZ9oYe?=
 =?us-ascii?Q?IVvbY0QCUtu+QBrezSlT0tPPJnp75a+TIxaCZLElkL/WJfN0KoXuim7hD7Y6?=
 =?us-ascii?Q?S1GJeIrj0UaVmhzdOBHGP6L5VTMWR0WDTbTSrKuWFu4688CQMnBO+h83E864?=
 =?us-ascii?Q?omLUpDPV4FdN065SEiKjGO7r4aV6NgZWVt6cEfBpaPUVIovM+xX2c82yVBdc?=
 =?us-ascii?Q?/dJyL0miWZ5I+FDWQgnuxsggq1JSACR9+zmn7b5GJOCzfZavLQ3AThiMUZpp?=
 =?us-ascii?Q?HgZEMuKTluzPtf2J5vAookEfmP1A1GEB4fkTE5RSyzSzhq5g8JaSQOMduCDP?=
 =?us-ascii?Q?ZPoLEduqV+sI3G0IV743DGlXTh3PLD3XcjwDsL0mzpBB+n+XwXi0Wb+4GVhB?=
 =?us-ascii?Q?ZwXwDnzgU1A5F/HsEMFyFhMdA3so2D2xoobPYZHIHZ0T8o4Lx2klH4sah/UI?=
 =?us-ascii?Q?w0uL8FHhmupiIM7qbZaWCCRLFTRMh7ZChD16O1JKU73OJPCmYJn5Et9axmuq?=
 =?us-ascii?Q?eHbL6tdNRACjLICBQl9mNkP3ebKFySQk8Ux03zeafkDQAqfaY6mpOhwjZDpz?=
 =?us-ascii?Q?MmOLqoBqiZlyFaDe0PdiO1E9BadCixWSddMV+HW1iM8zUgiv+44R/SWd2/iE?=
 =?us-ascii?Q?Ewzx2VEsg5EnbsO0BJIr+6g/hFhi/CxuOwwYFyabf1u2bf02AnLro0DRyjq1?=
 =?us-ascii?Q?TXZTDvCGKSVZqANwGQgOxzFL51LVJGuHhsazk7EqFsRADINwZpHD9BqE2YNS?=
 =?us-ascii?Q?n3fvQCdjn04uVABXh9Kfw4S94ficReT2xthJJZ3cVloS+1W4jJPgnpnEsC/4?=
 =?us-ascii?Q?+b2VMxr0PvIMJSY/WkLF4WhvOEQiTT4wD/oaA3iWNuplx7N+7+scOcCJ9Pm+?=
 =?us-ascii?Q?s4JE00fRLkRUkHghjz128zqLtJFFUEPrSCeVg8TJBsIhxZstniw9PdyOXRjR?=
 =?us-ascii?Q?QZoxou2WVqSi/nQhucDVO0/A+7wnA7dGuqYL1IxPzlxfUVnGObOT+pzt46Tq?=
 =?us-ascii?Q?XxBx7aSYIQSQbQCLpxgdNE1ySinjs7Fbw7Va5BrCunbE2cujuoqPU7yZn1tF?=
 =?us-ascii?Q?ZxzkYsCNjHbNvV+a6Apl1Ta8QIMQOBpp0DDjohPmhiJ0iujZJhlAuqDLiFPw?=
 =?us-ascii?Q?CItPOArChx9IFlYngE/wXb3MJHbGFoflQa5HuvIOaUGRSqVRLLnhx34Pl1w6?=
 =?us-ascii?Q?XetKxpGrFkCRJg/upHeaYhk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71526fbe-8dd9-48dc-654a-08da01b0f840
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:41:21.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGBNzrcg4HTQpI8uG/jB0zOdmyvdfY/1/NuTd27AW+Vu6kuQAx99DgIBv40DLoGnMLoX1guJGa1bw0nbol63OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/remoteproc/imx_rproc.c | 69 +++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 6ed53c660c18..7b84fb6d168f 100644
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
@@ -96,6 +97,10 @@ struct imx_rproc {
 	struct notifier_block		proc_nb;
 	u32				rproc_pt;	/* partition id */
 	u32				rsrc;		/* resource id */
+	u32				entry;		/* cpu start address */
+	int                             num_pd;
+	struct device                   **pd_dev;
+	struct device_link              **pd_dev_link;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
@@ -304,6 +309,9 @@ static int imx_rproc_start(struct rproc *rproc)
 		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
 		ret = res.a0;
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -333,6 +341,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 		if (res.a1)
 			dev_info(dev, "Not in wfi, force stopped\n");
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -703,6 +714,56 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
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
@@ -737,8 +798,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
 		 */
-		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc))
-			return 0;
+		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc)) {
+			if (of_property_read_u32(dev->of_node, "entry", &priv->entry))
+				return -EINVAL;
+
+			return imx_rproc_attach_pd(priv);
+		}
 
 		rproc_set_feature(priv->rproc, RPROC_FEAT_ATTACH_RECOVERY);
 		priv->rproc->state = RPROC_DETACHED;
-- 
2.30.0

