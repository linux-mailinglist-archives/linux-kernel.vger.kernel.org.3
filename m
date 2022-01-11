Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E048A672
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbiAKDgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:25 -0500
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:39431
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347460AbiAKDe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:34:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YctBc2UUizrASyt48QrKpD4jPqf+DLM5dpfL1rubYQarYPG7ob0F/TIHn+J12AWMSofHaI7d5gC3A3MWX7JQIRKTL163QdwYjA2WfYfq0PB4+CCoZ9cXqijvn3JUzRS1m0rO7eJsSMm0FrFOpFtGbTPE/dQlu1a/USl2MvLuW+nYfxiF/yRpd6ybFQ/DyzhMRc/DRvDzVx3a+wT6akw97PLvdhGsROsMBBTNg7oFzITihfOxEVj7ZomlOwq7rxpY0GgRkV8zVVW/ZdOZtt7haDb9F+dYOnS9tUdRx1/5gDvOhmjUdGj5WA2bAB++8ez3xucV2565fxU8APMCKzOuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KkYVNVmejMvRcvJ3CaCgXo79GP41ktOGAMUzPddqSM=;
 b=Nl08+MYxSEzkXe+HjiCulqmL6CUshzo9t/pDAuhRBfiK4AwIwlwyH+aH6+HzUm5XlkB4vpSKM4GAhsBiMu5OomcpbXsbYhCkpzPzaMSnDD1nxIo2NvNr1/po3rqTKPjJLkl+5p8QiZ8R1encF5WMWo5d/BPqGQs0HdmwRI7BGbjUl1FJhmqbLGAdllJDJxY1SIn/TFwOusgf/PMLZK8m+ePgbZ+X9xgU4bLjD2/tRcHerPv79DOO3AGsp0y1ymPT14GNrLOvSIJtswQD4hB9UNlVxVQ+mwRkN6vRwAKNkH7bpNwp4f6S7xLXMyeRzWm1JwgewPimuQA7tED7r1Z6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KkYVNVmejMvRcvJ3CaCgXo79GP41ktOGAMUzPddqSM=;
 b=bjfAiWCfug/wLQAwBeZkg4JzOHD7MtV/556LP4ScZ+EB7aoZcfWIn+7t1VaPieYya/Uh9cL6IxuU9nUAScwPhLxmsE0CiCCV4S38zVKdQLuZ7CaxOKVWPLygLLTXmsXRDoyKEIZgKtZqK6wcGjYvusxPuXC0ZLdnxSGskXyXJ04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8725.eurprd04.prod.outlook.com (2603:10a6:10:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:34:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:34:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/9] remoteproc: imx_rproc: make clk optional
Date:   Tue, 11 Jan 2022 11:33:29 +0800
Message-Id: <20220111033333.403448-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40d8ffc4-459f-4b50-11dc-08d9d4b35595
X-MS-TrafficTypeDiagnostic: DU2PR04MB8725:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB87259171E0BAA4347259E634C9519@DU2PR04MB8725.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/ZA9sYHAX0jRwHL5bwkEI/p1turxMD21oRGOm7LnePTHEHZIe/ZYvXegxOl0MgtwB9yb/wSKRV0Db//ht7W7rUwdgQSsgy1XBVMtKE1e/CukBtNcQYwI18YLkGwkgqGPr4lqrd0iSzf8PjaF7egZkcixgBEdV+ITt4Brxe4aNSTf84RCvVAgvY9I5EDBr3h6CX19X+WqMeIJS52RgJQwWqIcoBGvSAk/wY/MsFA9EwZK2vk7txSsnqovjwXjj+ihi06ZkTLwHN9Fa6qKb7GmeurJnEKBJqgQuTlC2QTPJlkSjlWHAj/WuUw3ScdjbUUuqRwdiKa9zY4hGlWk2C6iMzACwZd0664GQShNsDtvWIcSedt47WCEnRRJm4QYu0cwxL4N/u0+soU4u0njNyFGXNdXZmuZ0twsUaDL3Kn8+DJ9hN6x7xnUKMxzvsbvZ5ioSFI+lkGOI3FeWTHuWU5TNe1YksmdB4a0XgSgPdPC64EDlPC3cOClU1enc83Fewdf5z0Tr18pXYIq97ndS0E4eK6Uy+FTVjQyRI8JjYSnQJc5O/5d2wD/haIrMcBPXHL4LC7ogJGnBIVzzyJvStycwBxh8iWSh0j5QI10tLCo97vgYqjp04RD8b7xtbPXsHPniaYndQc3g5Yw4XQI2gr0LkKg1ASHKiwTCI3c+Y8fkIF5KhKvPq3Q9TP5auJEV0GtxHqri6W87ToUFPzkJQLaNO0BgWBLAl0mXbYND41Hdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6506007)(38100700002)(38350700002)(186003)(508600001)(921005)(2906002)(8936002)(26005)(8676002)(6486002)(5660300002)(6512007)(1076003)(316002)(6666004)(2616005)(66946007)(66556008)(66476007)(86362001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZZYNu02juIlo88T7x04GY18QNPGcS4E65A4qFM5HRx33lVMXfwgc7xWioZt?=
 =?us-ascii?Q?EPgN9z0+77dtgb271UIG8LK5ZT+tS2hYEN+LMgz7Rr0otEMBYTii5o1fOC3d?=
 =?us-ascii?Q?t42XNwvvfqp7SUZ+rozoDvwoms45KNSputx5mjFwNyW98LvuJmAywpfOOvsc?=
 =?us-ascii?Q?cAyDdqgVvxAgk8SSUCmzewEPzkT/IAA9oUkAykAI6oOQl+EqKaba3XJZEEEF?=
 =?us-ascii?Q?kOQ16DKfomGgltFFdnvNARYI39oetzAtVFJDMvohdX3TJ0/lttR7fCYdTmoE?=
 =?us-ascii?Q?tKUGGwdFwX+8ZLFc3/YAniM8RP+ukRnYVLUFizJd0XoA2Uv1mieOkwdZg/gr?=
 =?us-ascii?Q?Y0wO4ConQ0JVDfTe73aLAQgyMs2H7WliXmM5LMr4oF7mcIZwdCjZakO0kioj?=
 =?us-ascii?Q?BVY6TZSwi/xtm6nNFCgQGhjV0R3PQ/LmTTxSszs4TgrZTEkQnMdPIN35B9Dr?=
 =?us-ascii?Q?VYSzaRaunh5ze/WmrIr6PjnuA9o2/VmWpDLrzjUS6kKM1W4C1anpecURoBfx?=
 =?us-ascii?Q?FbfjeT+tFWHjnTNPu7wPuU/lQjdmk9EPLN1S+auCCNrPl4FsLZ2g64KkcdRl?=
 =?us-ascii?Q?WIWk1k+jzvKXx6WmU3XYv46vrCG3D3vWwCbOElu3hjGjKsQWn/jXB8PR8DDp?=
 =?us-ascii?Q?H7cJr8jF+U77m8F5jgf07tbmQoOSg+Sh1qKiXOxp3y+REDf4G9vwuduepjVn?=
 =?us-ascii?Q?xoquguOOn6L/WSqR+nWyb3apWksQLCg6mrx7zXaBnOBVa6vmffygBNmYcUkd?=
 =?us-ascii?Q?GLZLsWjyfOoClvBZLLanXjo9ezKr/DljgCWeJOmqz+lxZ1wKl3pvv8Mjmnl0?=
 =?us-ascii?Q?jWyNKsxx0ZEo/ihmC1HeX9VN150s8BIWte3Nzwx77vdrMyWnjLam67R3gjrm?=
 =?us-ascii?Q?YG9lIngQh9gYe/xhpXaAO396+wjj/6HeQv4CfuKR3nau/yE3dydDBkdhpMSY?=
 =?us-ascii?Q?PKP+h1leWX5ytk6GpsgCRcevurD5tWwGtv2v39tFDpCEgN2W/zSw1BrmNvRU?=
 =?us-ascii?Q?1ngRCta+285l1i3i8EkMjidcKrZDs9BKs/iPd0t5Io8zRVtlvogP77r4Xx29?=
 =?us-ascii?Q?k8n1VjCdEpJ7giLGy3CA9X8l8nXrGc6zAakwteU53TzLpHtnmUh67hwKLnm8?=
 =?us-ascii?Q?XnqcHsHv3T6S+g0fzylBDPcidx7+27ZJ9xEhCOV6o34E4vZAKaE9VbAgeSMi?=
 =?us-ascii?Q?9qbq4SWJSo8BrbzGCbAu2Y4zUUg1M3BVxpt4tl5NPwmHNwqTahEd2IvJUwRw?=
 =?us-ascii?Q?7YEUspirPKe+SWtFrYoxnsAsobT0GEzXO2izUax04I8C7AaXfW3VAxlZx1ec?=
 =?us-ascii?Q?BUoYtAF5k9+G8cBspoySz6iHMijOy/t4eJzjpvDRZoEsxfs1AfmfT+eiVn0A?=
 =?us-ascii?Q?WNXVzy4iFI8yY9S9WBIK0ZeEEtt6TNybKDOmgAEBgTBXIKle61gCZEHWs1TU?=
 =?us-ascii?Q?NR4gLqDVcSpjFw2WWp/4zRmPGPjPQk2hEn8eN3lxg3bIJH5DkOn6735Sc4JT?=
 =?us-ascii?Q?6dPgHKROPUtaPQclLd5TJqzHogddX2lRupT1q8KSOYxGLZvW4rUP4PKU2frn?=
 =?us-ascii?Q?MDnP6mF9tr5pLs8O0xax4HurPA5X1AUVHU77YV9ZAeKG4uOk7xRl/P4ftaTu?=
 =?us-ascii?Q?cKkTghM0d5zPve0+lWO7BxU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d8ffc4-459f-4b50-11dc-08d9d4b35595
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:34:55.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m71DS2BYrjnb5ftlqW4p2BRwxmaqbyK33ym/cGzGHry1aGjEoF/wiRoRp5hCC+AA8VmG0iTisCN/zoAzjt8E9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To i.MX8QXP/QM/ULP and i.MX7ULP, Mcore maybe out of control of Linux.
And in such case, no need clk, so make clk optional with has_clk.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7b2578177ea8..0e99a3ca6fbc 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -89,6 +89,7 @@ struct imx_rproc {
 	struct work_struct		rproc_work;
 	struct workqueue_struct		*workqueue;
 	void __iomem			*rsc_table;
+	bool				has_clk;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
@@ -724,6 +725,9 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
 	if (dcfg->method == IMX_RPROC_NONE)
 		return 0;
 
+	if (!priv->has_clk)
+		return 0;
+
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "Failed to get clock\n");
@@ -768,6 +772,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	priv->rproc = rproc;
 	priv->dcfg = dcfg;
 	priv->dev = dev;
+	priv->has_clk = true;
 
 	dev_set_drvdata(dev, rproc);
 	priv->workqueue = create_workqueue(dev_name(dev));
-- 
2.25.1

