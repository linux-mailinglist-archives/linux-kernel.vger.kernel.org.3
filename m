Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE34F612B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiDFOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiDFOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:07:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE9100A54;
        Wed,  6 Apr 2022 02:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN28yrhfYmxPO8ceskRwUbBATUzxTq+y8FgwPaaHACWSK/Tvz7tNBg/a1KTtcMJUtnwjwvOFhVL1HiAMl2GnkiV/br5c2I+HaZq9ykW8AxLOJcjD5m2VmOFBM88djBNm2uFTljyZP0HNMO6SghKwnzuUsqvGbASrGo2ccIuBAcDNfX4KYGiUnpGDmOdNX0mvoYtkzvdP/sGAmD4rmGslwMUnylbPABOF02dhclxck42UmvMcUDQIJihy2X0LTfQCXMNLAjYj9e76vytRnRT0C4h4g1caKp64fay9WvFjCSbECvlqz8zI1+Dkbh/hfeBQLtlVht+QhCzPGt+h8GuE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwHaDwvxASzJBr290ZaXFVJ0bE0g4TjzIARAOn7abk8=;
 b=RrOCRm5FXnokP4EMyJJEOBRhr5RIApSI1T/zAa22pmay4nHvb6BIneTYtTvRsFCwPltGvTveoaZzh7COHFtAn9l4CSzvtRswAcvwkR8eszaONh+gt4K/bV+nvw4JpBTCWH/A1I49v/cYjLtM/61WMzg2eCV8A3J9/diAJfUJeuembcnCTYj7E2Kt/xEV2HOlF82XX7T24zZdK2azYuNQB3kpVYr+rkKQRg3y599nqsO2eIEE81izpfiTq+A3zLEI8wTFSos680jZ4g6IjeFx5XtZ7GJhZGrDDXWu7l3gNxUMuD5KdE+GNaLQL7MLAWr+I/LwckGDdr65G5go3x4d4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwHaDwvxASzJBr290ZaXFVJ0bE0g4TjzIARAOn7abk8=;
 b=IvIx0ySO5oE8pV17Gn1DQNpSx41O2F7hAy3RXdYfhEcbpsBoAOhKhe2m9xDFjvB+ZuQPQ1h1qNGw73PMr/v4S2AvkTlQWduGQEtbp+x1TSilTWNE6kQ77nj+zuwRSGsH8GOmz+/ROuaXZef+KpIKBAwz3gR6EXsg5jLLScspTC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 09:47:23 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6881:df46:ac23:1bc3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6881:df46:ac23:1bc3%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 09:47:22 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Add pm-sleep support for imx-jpeg
Date:   Wed,  6 Apr 2022 17:47:03 +0800
Message-Id: <20220406094703.8229-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06296e3d-92a3-4974-de65-08da17b272ed
X-MS-TrafficTypeDiagnostic: DU0PR04MB9443:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB94433CA2A77FF82AAB11C182E7E79@DU0PR04MB9443.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3940ob3mLrPxN/48Fkbbx+Egct9DlTUXCXxXxOEuIhaPD3RYkcrQl1R7bdcat0QySBuRDXNNjVUu2XgHP06sztWCtwBe5mSSU1+Zu1QqW5uvbycIK+YobhqfC689CPfG9frAdj7lUYIGt6d0k326VxYAYT+u9qSkrq5c9MQE/cQqMfHUDXDPphtvhMahjYSSlC0p3Yh2KHm8850GY1H948IaT/WWqHfbgxTdxCnkrkO1oislQE0Z5S6oktHDpWyDYrZQheuzecv9OAaxcAPgZvjkSwSZQIHDL8QLUB3ImEE9qlyuL5aoaHT8zDZweCpF3XsmufMdDbamctQOAiqmCN9a9ewpwMW6+4yWGbapMCLADZYEiX0m2ggfryizTQdFmbEPr5eCZyRvZqvrOTsCHSJ8KLfU1yAIWcpj0jnPE/g2SHeW89pcpI9I52WhofAlTYRN+7SYg7r4LtbDquKKMA8LIOOqeTkDYEHqxGag+WjYYcgxqAi+OPrRyof92a9xqf4v+JROaSzSkJP/Bq2AKf197gps/26Ilhbp1GvZqtIMl8fAEbncTtzm7Zqq5O4L7kV6crpw/9Hzi0GQdq84MsNaxkyUUS9y7hbuNkBzpii5SKX10yU8hvobeDms0AE3w+E3OhVUk3sszN7VJqKlwNlC2YzXFOPpY3ErwF+Cwvx4gny4+dYRFqBgDLfGRgZSh3jSU/TGoeC0GnnwsIaVrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(8676002)(6486002)(6512007)(52116002)(316002)(6666004)(4326008)(6506007)(508600001)(5660300002)(186003)(83380400001)(26005)(66556008)(1076003)(36756003)(66946007)(44832011)(38100700002)(2616005)(38350700002)(86362001)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8Qo9gHea7JOG2v3lPYyljEX7cOo+lXaqrb+hjjn3+RK/6IZAozzYyDBiz2K?=
 =?us-ascii?Q?4U7Q0HN+FjIPTCxfnuG+YDrhM80Cy73atRkhVAPHU9Y5QOWufjbPnaYREL2l?=
 =?us-ascii?Q?vkWso55K9gj8gm/v1KlSO3nFKdQZHe0eGwD6qqt99lPaWkDCrmaBMbapDye7?=
 =?us-ascii?Q?D3HFeuer2wY4iXnYJTx91TsiPTSAkYSwJRKc1gK7lDHyL+YNpYdTx31h+H8L?=
 =?us-ascii?Q?SFiDz3i0Q2ovp9E2GFaYcI70udLLuYXaODQdKmhoAzUO/fO+mQiE5KV85sYu?=
 =?us-ascii?Q?eO+s3t/PDEqnVK04hx8zTG8J5fBZmsu1lSFqEUfz/sv8T+3+E5/uBxH2CwP0?=
 =?us-ascii?Q?ixNq9V6o2RPsP40t5tNPWPqO9lZ29XW0hK84CA6UdvQGzl71sVytaUEntCHP?=
 =?us-ascii?Q?HACl4GaQXKkArVq5UetbvT3X6HNfC7OcI1KYg/uRAPXVOp/UAYssxlOT3pET?=
 =?us-ascii?Q?z/Ru3Q7seDZjVXD3UwS1l9OCsVdYCICoOph3KBUyNHsiyBIDYtPzOGmnI0qw?=
 =?us-ascii?Q?WJ6gvkXFIIw5UUkcTbN9pWpoN4GJBxIn9BUCZfpmNXEcvO/e3NgNYeBnULd0?=
 =?us-ascii?Q?qF0DPL/fkPEH4MrFzpzb6KRZsJdRh8SBoU6OCddzodx3XKmtJ4sXyHpDxKhg?=
 =?us-ascii?Q?HUPpjqU0EF11qgx0W4xrnw2lgbO4VSqYcdxn/oqhWMXsrGETLCcMhofTR+j7?=
 =?us-ascii?Q?QCI7P4MBBve1wpt/56fAuSGoU9vib4tscTEU538UxCkHzhufW0Tq0yU258bZ?=
 =?us-ascii?Q?nAFLTadBg+YtiugED7yULDEYh4jFCDZQAQf+PpcG47eXl6UuNIRexOfE2/b5?=
 =?us-ascii?Q?Uh57PPEVWfEKzh9MFxx9kdEVV3xsVTIrIrIkW+hNJgPo01i9i+T4ICrCf29R?=
 =?us-ascii?Q?39aAWjOUfzbUoCeLhn+KBSOF+NVukz+p2ZM4C23yC+WrJjk7EdfCxhvvNjc5?=
 =?us-ascii?Q?uDF0d2MudKmKIMYW6N97SBvoxFfY985nZ4A985KziiY49z6ncmLdcWRRFDS1?=
 =?us-ascii?Q?7ddVlq9RRCUuY8r1LYTdBqh/2v10DTVzJ0nWnVJXqDifUPMhxhaXjliR9RMI?=
 =?us-ascii?Q?kSiA1Lp2HUr0HaTeM/pAu+PwFp35GC0Ai7c/JCQOXhzyjmFqcDUtYy1ZM0mE?=
 =?us-ascii?Q?3oYMzL8oh3t5QDtFCQbNTEYfmiij/1672sWOz1qkKj6/N/Fe8nptrqRQUMqe?=
 =?us-ascii?Q?glkbOOVU3s5LuvKhy0GVW10Nz222JMkdCl59OeioGBA0hz1+cKJzQXc39l1k?=
 =?us-ascii?Q?im7LIch3gKe2+EW0tUDr5vCLOcgB3AqZ8cjiTRKddYWjWN4plcCO2pMZf252?=
 =?us-ascii?Q?dsQ73dgX1oZpGfrjM5Z9zNlFkcvjHHWkwMPdZ9txTnkXylWvhxkC4haxcFhX?=
 =?us-ascii?Q?YO6st0PgRxoNmvLu54u5Kg5H5/4n6fS9pK9UgxFo+DUACRmPkgsUPqNzOLhU?=
 =?us-ascii?Q?iRntDsnHCooaHveDzcr7cQAJOekpO8AkNNPe3j0StoOqtTOr60m3lTkJNYm+?=
 =?us-ascii?Q?tXg40vGOT/i5DEqscLfJPIuBW/l31fZuYctkOJWViNIJnrkmm/PhOL7sz6xU?=
 =?us-ascii?Q?muDRFdLnVpizEOqHJ0JHbWYFfxPyZYDV21xMsxc4r3DD3/0G3Nz/FNsPVyMT?=
 =?us-ascii?Q?GvDdgv+VynWKsoj1ctTkzi58R0QXmp0g5xol81hxJHp7prEBcBECWGJlnVSY?=
 =?us-ascii?Q?YI5OXj11MZ0eo6PoDmMUpwFLJK+5L1FLV7DOQACgXwe6lyXtEWTKteuDizA5?=
 =?us-ascii?Q?0vsyC51org=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06296e3d-92a3-4974-de65-08da17b272ed
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 09:47:22.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JgrrJbAodady0r5QzYlK7iin7dR3bWQtWzbCQTnGMXEirLxcU/n9XJHfGBNyiqxgx1bdGdyWkOeGzMcXQg6Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wait finishing jpeg job before system sleep,
otherwise the encoding/decoding can't be resumed after suspend.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index ccc26372e178..3df51d866011 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2356,9 +2356,33 @@ static int mxc_jpeg_runtime_suspend(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int mxc_jpeg_suspend(struct device *dev)
+{
+	struct mxc_jpeg_dev *jpeg = dev_get_drvdata(dev);
+
+	v4l2_m2m_suspend(jpeg->m2m_dev);
+	return pm_runtime_force_suspend(dev);
+}
+
+static int mxc_jpeg_resume(struct device *dev)
+{
+	struct mxc_jpeg_dev *jpeg = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	v4l2_m2m_resume(jpeg->m2m_dev);
+	return ret;
+}
+#endif
+
 static const struct dev_pm_ops	mxc_jpeg_pm_ops = {
 	SET_RUNTIME_PM_OPS(mxc_jpeg_runtime_suspend,
 			   mxc_jpeg_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(mxc_jpeg_suspend, mxc_jpeg_resume)
 };
 
 static int mxc_jpeg_remove(struct platform_device *pdev)
-- 
2.33.0

