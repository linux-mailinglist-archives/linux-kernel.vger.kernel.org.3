Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14247564624
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGCJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiGCJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFA2723;
        Sun,  3 Jul 2022 02:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1NHFQ7jdAUz04zi4+FGHiJ3RlqzBKXHvAAewR5G9+ERYQWn+xa1KiT8MCR9hLH8/sjYD7t/+Ylvx8P+iVVmKQwbJ6TnOCdfS2UnLRA44mJDXTOO+f+7lVnxduqT+FdQyzJUyy83HN5feXzXeEC/z9wHbNI3d1iytVv3gaVWIskiAURNP9DbLZIw3XOeU1ZxKpDtcBBWmldedCiXNO5SsEczRHtN4RMfKxB5+zXs3jg0+GthMrUZtsHjn/Tet+rBNUMZZ2R/flt8xBZWl3MOY57JW4QgYGRRfwS/54u+EMfzVB5rarxutW+U+IeDUEjqpkaaTsDab2YuPURjGuJR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acQKgVJF7AArGjJMPl+670oOUbjqsjIozrJ1xFJ5NrI=;
 b=TpU/7K7n5PkklZa2/GmkNcDC4eXofVvEl4jmpgiEqJllg9NkGb4lkn6zazsAfBmpqQwakryT05+Al2EjXX/zQJNu8xicmti4cucC+jYWWxVhRfBHOriee93M50RlfxgCaqYHtcUQYPxjxD4NQuMnLg3kd49cFbKO8fCU52O/HGu1MhnuqNR31gWwUcQ8GkH7QpzWw3fX69cxpta+XRBZHiKPsIIBZSu6aYYzIm7d6W7Zfr6ZXy1ptJ+yDGI1v/7jUOzWzkkq0c/fTioJntJtN3miTia0tX8x2VB+Zz2D57o+Uk6x/cwTV9lEyFriNMNXoOwrdigMVokNH/ArohkXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acQKgVJF7AArGjJMPl+670oOUbjqsjIozrJ1xFJ5NrI=;
 b=eSC7WMgylA0rH2aUXuG5PiHyeB2Lho1v6cquCHcCueuQGXF0lgTAytJ6ZiJhRaoe4qBZ/D/etg4+l9ijDos9f89hXwZEog1lTyRaAhVjGPRfZESOEKVg6datfpnZ0DAskmS3a2TPT/di4KwbIgI6Mdip752PzKHou7tREPSwSoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 03/10] interconnect: add device managed bulk API
Date:   Sun,  3 Jul 2022 17:11:25 +0800
Message-Id: <20220703091132.1412063-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57dfa2a8-3984-4ffa-1f0f-08da5cd3daa7
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hJZoWQvEuxXsaEWs3ioCcVvOyolJkgLv+fIuRTJuLbXtrvum7TathQRQNHpmTnVkY3BbACnayCEx9xSKPuX3hTXoG7mCxUdlL0Ec1JWIF8TZ9InW4/uz2g5XFG4fJWaro3osA99W6m0UEdOFmsuXzmTc1nbqT/S+YV77HV0y6ZVzym3Oayusw60vkME1/S7rWYTet0jzlDJ/bcrQ9QAQTErnXJHnOMbE4EkzbphDVD/SgGqyqeGOVibAKu6M0bjxH7LoD5pZMDoc8T19j8v9zOda9v6FN/NtjCLd3xLrn+q0RvMw7DEzUCSOnKnMEzDu9kTiRh/r1s16Cqdr80nOlzF5z0z8ByWZoqRB4cAoPFSvINPpAp/0v89cXGiJ2Ghq0KGDyda5//t1/NLIni40k4K5GuT71EcmyHhIbmY9UZ+6/NJh+SJqtnUvzOGwoi5T5g1zwvmXkRLVuvWQbH1BvqCqj6uyMHbN5xOBqvBKObgdnKAK7AuD5Gcx1On3sMXU8hpv9EQfCV/bcjxKOQTeqHNhUIi8Zbd+ibiRwEliUjP1doY4qAjswq3V5IhF5lXjfgK/BAlJw7u4BaclAM4NFhN4i31pYMYYNY+nrADzgbTW2ob+KuttglMwk/rnPEfm8iYv91bcJlEVgTli+iDej9SyZGVhgWXP7OBppbou7cPxW7Mj9CGmCfhdodjAHqGrfmmeo3CvNzYcVwioaZbPMJaWpENTDZnTLbnDJQhjr1aOtfVs9/bJ8TG0zC6gGhPimssBJcYYDW7hvP0njnvOVv0inuvrLyaSB5rRH4kClPwDWh3qcLqphwmAPxSplxMeTV2WDXYUhed+Ra+csyMPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(2906002)(41300700001)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(83380400001)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCPvXWjIBoO8pXFrrjDkrlnDVnSPRZPuLabQF+EnSyuLShXgu7rSmXc9JfPq?=
 =?us-ascii?Q?rHfPXybSUR/gnwyBm+qVPoiPLHMYkRoNWGLwd1TidE80unR3PL7EKkPYrC95?=
 =?us-ascii?Q?BRvsgieonnN1uDSkq0UFTPsA+9OwsJSOmRtnP/SvzDaB1SM/L6saVfuvxAtP?=
 =?us-ascii?Q?dyZig7VDLvyrfRM6+Ak0yfLKmFe1NGcvsMZEywE1y3LHft08INkM8Uzbqubd?=
 =?us-ascii?Q?W5ydmDikC1zF7etLX8ep0AiCqQ95TEsknASKVXtU1UFxDfUyVGWYtyzPQ2PR?=
 =?us-ascii?Q?a9UXxwVo4IHAjD8+cNwrz6AYNGUZgMNErPqc2TIdX27ZyV17MhDQ9cYkzRZ9?=
 =?us-ascii?Q?qVg2ODK7TpOR1XHVO4U8Iem4tSGUaAaPN9scPKdhbQIwloelTkisyOfecx0Q?=
 =?us-ascii?Q?Yi49INQwUEvY8f2pXUG4OzjRgMUchvi2IsmQnlt3CpguKGZCLIPmwGJvmZoH?=
 =?us-ascii?Q?MWRala29n5IQ7B7X89gRYnL2fHFH+9cyzfxzP9yT9nRN9aBsCYDLPCNz5JLN?=
 =?us-ascii?Q?CzS4q55KA3NmXxyTgHjC/RvH5BpqUVECTn5oWjcJj038e05OWyMrwDpgNr7e?=
 =?us-ascii?Q?AYDB4DzK8HuRNODbeZMQsFv9YsylS3xLWFJnHqX1rSVKE+OgB1Epe9X7zy1g?=
 =?us-ascii?Q?a8Rc5XWDRpbUnrBV9LyaE62BUxKHGfFBS0uoWFdNPzBNdWxbjoD/cQis4AHe?=
 =?us-ascii?Q?EK+BjNOX7FKOA9ayl8mr+Bsi1IX3GIXbLJnMjd3YEHK9W2aGp0lmIqZXwhQ8?=
 =?us-ascii?Q?nEjpzKL1IJxON1eBiv4CFHRP4zoAlDMsQ7ZuaPbnimc/Ry7Rwj3mUs2KMW82?=
 =?us-ascii?Q?ZGa+Xk0814JsslvqaqJ3WrP4f3mXE+F6I8lWBu7vu0kF2g0NcbUtHZyA7Cd+?=
 =?us-ascii?Q?tXZ1qE4bf9EBaaquUTn+MEmVhOHSlGyJAd/JO8iO8zyr8HQP02lg1YnZzMRl?=
 =?us-ascii?Q?RLVhYvW2ordgrPO0HAYDQTz4FwMacyNhNWtjhTuNfgqA8E6A8/PuZ3+cW/bl?=
 =?us-ascii?Q?1vh0Ym50+HlJbbPWmCtWVXDLtmOwg72Ss9aiwcU6U1aGKYU8mgdJcp0sDrhX?=
 =?us-ascii?Q?N0mPC0WNw3LmKwTj8fsjIBrUm3HqMNsJyxPvbHQpCxXQ9QmbB1548ZlW9GCs?=
 =?us-ascii?Q?N4rEZhHHMY/iV7bGVQOWVHf2u6BndjjDiAlpuRviLB1LHGDM96ZBKAy8U5xz?=
 =?us-ascii?Q?ciKahns6zbJLRwXa0a/MTJtKmBrt5fZULQarSHGVX9caXWquLMpu/t9yPwLm?=
 =?us-ascii?Q?r7j9v/1pURTW97DcpMeUAaMViaXUTQIYCdiUgET2yRtusOOdWotq5SaOC4oV?=
 =?us-ascii?Q?AxQuucQU7s48Hf9Bq+61UsBugPR5JoCyqNDW/jmYmyTjO4iFeC4o1wrJwSPg?=
 =?us-ascii?Q?4yPLavB8FRNpRoCfthpiOdZEDHosu7KztThk1fW36FwYCkWUZ4q+jpKOKOXy?=
 =?us-ascii?Q?FfC6mGn2YH5UFoYCx/b+fzMKq/AxUyVCs9DlBV4JzMWJND3wZ3EOgveLeX3K?=
 =?us-ascii?Q?Qwy2mw+ZsOM1Fm1vtNveB7674Tb9X9HCztv8f4JY4hAo6Bnh4wR3BrCjsXyM?=
 =?us-ascii?Q?31UAnoYp7uDGOygw5PnxZ1adfp+e1zw0XgD0u8z2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dfa2a8-3984-4ffa-1f0f-08da5cd3daa7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:20.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhqrfrsxSZBZa4CpbgOkrmAuXACdljYy6VBd0rLN9nup5j14QBrMfEjk1u/6OncPT/K6ZP/eUnIOGN7aP618vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add device managed bulk API to simplify driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/bulk.c  | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  7 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
index 448cc536aa79..8b1d8a412464 100644
--- a/drivers/interconnect/bulk.c
+++ b/drivers/interconnect/bulk.c
@@ -115,3 +115,45 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths)
 		icc_disable(paths[num_paths].path);
 }
 EXPORT_SYMBOL_GPL(icc_bulk_disable);
+
+struct icc_bulk_devres {
+	struct icc_bulk_data *paths;
+	int num_paths;
+};
+
+static void devm_icc_bulk_release(struct device *dev, void *res)
+{
+	struct icc_bulk_devres *devres = res;
+
+	icc_bulk_put(devres->num_paths, devres->paths);
+}
+
+/**
+ * devm_of_icc_bulk_get() - resource managed of_icc_bulk_get
+ * @dev: the device requesting the path
+ * @num_paths: the number of icc_bulk_data
+ * @paths: the table with the paths we want to get
+ *
+ * Returns 0 on success or negative errno otherwise.
+ */
+int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
+{
+	struct icc_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_icc_bulk_release, sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = of_icc_bulk_get(dev, num_paths, paths);
+	if (!ret) {
+		devres->paths = paths;
+		devres->num_paths = num_paths;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_icc_bulk_get);
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index f685777b875e..2b0e784ba771 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -44,6 +44,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
+int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
 struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
 void icc_put(struct icc_path *path);
 int icc_enable(struct icc_path *path);
@@ -116,6 +117,12 @@ static inline int of_icc_bulk_get(struct device *dev, int num_paths, struct icc_
 	return 0;
 }
 
+static inline int devm_of_icc_bulk_get(struct device *dev, int num_paths,
+				       struct icc_bulk_data *paths)
+{
+	return 0;
+}
+
 static inline void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
 {
 }
-- 
2.25.1

