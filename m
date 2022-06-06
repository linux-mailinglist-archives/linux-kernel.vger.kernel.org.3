Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66353DF84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352084AbiFFBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352068AbiFFBtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:49:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F14F470;
        Sun,  5 Jun 2022 18:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu8mGqu/yJnyFAC0ND7tShTOr/Fg/4Zz2zce/da15U+UkPzcseVntgtj2LXjj6us4NUK1Vtk2qKYXnGyGlRqf6d6YVD4UcP4bWM4zxgshowcyGLWbkzCq0DDLnlQVFr/5K+v7KB9daaXvManhqk7yuQIIRH2xm3MKK1MESMkfH4tAZ7X8LkRqRT2sisbE1QW5+wkCv2x/cuKH/g55AOVST26tBfOfgYvlXh55kZdVE4ZyyB9LdkOKEQHQYDVfDMhnDxzvGeKNyyZ/TZUaJel4Jc13IwFQml1R2+vVdnUamqwsVMoJEskdpm5DZLxqw+89/hwpm1EEhamC+BgQzEwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=mc8Ymma2Vx7IuVjdrKx0jHRv7mMd05xc0Xuoo2kfXjDrRofQ2DGzddQaQRUSHZUuTuq/MDAbacWJWphiIVzH5Q8aTEFbl7Jde01Ye31GMTHZOhUKX+aiM10gXvXttyUpiKGFhY7GhKU+mWwok7U1b+jGFSzvwBRylSfA5uwZUuF5NaautEJr6bUUouCmGpP3cYDyPArkdDC+jXILn5fY3uQLcOjm0H6J5ebhA6x6hOeMJsTQvOohTSR/66sl9e0RKjqqvEkXYU1CMtC74YJFtmvOQkWZ1tA96INisyzPtg5cpkWh/Lde8YpR0UgWGTV7Wb7pVcc/cBRMgOYsVsWZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=NkpOPYF3pl4Vz0bHAFIql3DBf/MqJh8rRdy2QT9fPDyikwZZC2RNe0M6n/yv/ZGM6dQ7j00jhHZimncqrNKlkS5RD2zehvRmx9mBtfQOrUtlBGIEHVJ31VYG8kpN66sD0wulHI4edCzfpoW4TNvxsjcxMQqcTYlcueUQprm+8NI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:49:04 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:49:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/7] clk: export of_clk_bulk_get_all
Date:   Mon,  6 Jun 2022 09:50:21 +0800
Message-Id: <20220606015025.180840-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606015025.180840-1-peng.fan@oss.nxp.com>
References: <20220606015025.180840-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9570801a-90e5-4381-11c1-08da475ebbdb
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB48409ED6B2D775C2A22C1211C9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCqZzYhAvhJP8NkQ5pFUPoygnoXx1h8KqLXqwXMbUpXXW15FEV3jhxuOXq2ZGtL0rG3f+5RMdmagUYgMqmWgMlwPXJZ05v278IgzntATwkWiKgBwow9QHJ2grEOPEz87lYyVPhARyj+wg4HCGASgJqmHZdvdY19fA8a7hWUVomHq/kmeL/pNE1F1/cxkvYLplL4fs3BEl4ldVwMvOqe+kK22p3Co40ctYxb/PkG3ynomLbFEEGOHuT+/wOY3RCf5wmVIth6sS5FA9nBjoZnjnB5SjIZsJQEpAKPm4Q1uEr4LNPS9AXi+Cov9a/kFGbejdcikWZcTofKGE8gVsJ0S7S7Koe0jFEyNbwiCQ6SVGGe1DnKrOXmbVbZsmMnIz7z+v5UiV2/J80gIlwbAjCrPR1r7hvORDUJF1IeZJ3uLaMQReqi8ZZC4ZwNZdtFIDNKIAcqECOydsc9f0ucm5NgZ/YiJW6UmiO1thTRR6PG+DgZXm1Um/1/UTTOA8cCHdUHABIv/UB5urk/Cw1NJyeA+/9Mlx/qXAL7NnQ94+ePxfyE+AgsFK+qSrBfpxz1BMIpG+WAHJCKzO+79b0yd4d5Rg4SYkeE5bOMvPO2S3DCMnU1fYb9hJfnvQen4nG7MvxOAz9taOG5/JZTBJYl/7ZFu1iIqA3u/6hYK/wXlF5Rgu8f9iRgrSgFnzJMwax6xRqGY7i7JsGrm5Mw9aC8IEp39iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDwuz3U5EhoA7uES5VL5/j3U5yVqN+9eWvW+3Z/nAKA0KS3K4b8d2kMKbESL?=
 =?us-ascii?Q?lUtlA1z9112p7cGaqS+bzxSkvJo1OYP3ZLTob7oJkHsRlOkFBqfxfjca/mTq?=
 =?us-ascii?Q?3dBQgDleln5p2aRb8iVxTOP6osIcauA1KrAE0fAGKMAe4eMMlaX5Y7SO+A2C?=
 =?us-ascii?Q?GMqqCYQ3lPRkwYeLSi4kEZLdWn2i1Ato8Fqy8NTPEbuvtljCvjrfijTBNBBJ?=
 =?us-ascii?Q?Ahg99714XfWvi1rX7lrUzgWf82G7C6CLm3pCRvEZlOPQUARiMxN9qJ0pTsTb?=
 =?us-ascii?Q?5CHOkibsmB+VjB9z7QMU2p6Geu1umt575vRvDXPHEmMnPH7U0JU3ysGHhGMA?=
 =?us-ascii?Q?6HHJ7sjb9oPg1vHIQLt5mVSxncLRUJPVnHYhODaDG1bsTdMfff9YnoBB4Ovf?=
 =?us-ascii?Q?jf/V4MC6a5p2qenF5aOJF1BsjAM3pDYO/XGLdIKkhBKOTgjT4W4iVu+wFKov?=
 =?us-ascii?Q?urzCSH8awwGp26Qm2wb2GskbLUIHKpxPycAil9pPm14vrStqecGxMJKZlpk/?=
 =?us-ascii?Q?fkdBB2n145MaBgSPl4mzV2x29AQhwuMJZnt+l0jf3QGAFV+bCc5ZGgtD0gZl?=
 =?us-ascii?Q?CQgRPxwPasWXQTdxQQhYXuB5i0C8G+VNQellDxjXioeTpsyBQgiiiIYE4W3V?=
 =?us-ascii?Q?qoi5CSbYuCKuvwEpGpZCmMj2cMV6Jxs4i2vQlNnhoeKpD8PwYdEcuYTnzphZ?=
 =?us-ascii?Q?ht5uSVn1D9CEKnYmqDnQQAWITYGB49tlOSQz8spEbqhM4P63m8O/vy2Sn+u4?=
 =?us-ascii?Q?5Yqyr/cG2C2Augt1DB3/+BPMnsyVoH4KtrBemyaPakgAna271Ix6wt6cTtUG?=
 =?us-ascii?Q?IzzjgaSOFTb8wEuGY3dkHrt48bKnlKmaD0Pnvte/cOmLmgZ6eRUHHD8xIYKq?=
 =?us-ascii?Q?4iph/TDHdcpYEhDAIvktog2bAHGlW2OFgCldsBwnMReq/Y3I0KghrZCZ+4Su?=
 =?us-ascii?Q?PyMT3AinJb2qB9R+roeLmxUKtlEIcl26s7fZvNF0FTG5YohKuesNd1CIFRT0?=
 =?us-ascii?Q?dIJVhX7Rf5iNd3dRhqOAbhJqN5sLlyeoYArxdIS4mhmWpUrAbloSfcLpYBO4?=
 =?us-ascii?Q?C5/Z+ZUuFZxjGuqsEpdQxfYSSn0vuGHhbbbpVVuV0Nn1ezd3UWp80u0yibmj?=
 =?us-ascii?Q?Fs3e3/ae38/Yav2OuFeeoDZtJAlQxXrbValeDwa/PJnTyqSAZel9mgsppzOp?=
 =?us-ascii?Q?g1WpR0Whvs0E7sldj5HuOkbmFVrQTZuwKprSyVqwmn3oIqIyLNG0bLkwTNQ1?=
 =?us-ascii?Q?3tHISGkBfe/I+yLKo0YWAYprVYCtG3UsEXlvz5XkKFJjBev5i6uhAQx4aIF8?=
 =?us-ascii?Q?wqU+ne3lQNm8YIhnwdI38B/q3rXtc4oWnVobtngcBUK8ehkGr9KjRESX/zZt?=
 =?us-ascii?Q?EJ/QoJEEqTDG2Rh9w+GkFfDYbq+wMThj0mwdJfe8y9+FXjJXJlyRP7tP4U3s?=
 =?us-ascii?Q?kDOWsTLLyKrneighDuiCNjADBPYzzAN4xcAKRHaQrGf6lM7uimg9Vt8Ei9Gh?=
 =?us-ascii?Q?fTn3jGcbIVJJb2cvCPGAhKFoafJbL5CMOwKEQUiWMH/Wa6Y+PauqOp2G5Z4Y?=
 =?us-ascii?Q?V8kfve0xs4lvX4zr7XgnAXYzr/IrrwHfh0FsXT7dgFb9U+hplMlhjHwC2YCf?=
 =?us-ascii?Q?MBq9Xhm0lT2nHGokxXRVH8m50p7EDugH2yYi05tyslGiFLgpAXShRnijIom/?=
 =?us-ascii?Q?gWNx8pgFw5kN/GM8uSUr+piQBl84/AGsI3/vyUjB7GpEg9ykB5R0BC5vxmG7?=
 =?us-ascii?Q?QjL3mrSL9A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9570801a-90e5-4381-11c1-08da475ebbdb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:49:03.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnQ0mpEoCs6hLsbVaCr1H5DxFsF3mdpGpXN9u491NcV+i3BJUM+xugrkkt0MFylPWo5zDx1FCkqQqgSMXOwYRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Export of_clk_bulk_get_all, so drivers could use this API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-bulk.c | 3 ++-
 include/linux/clk.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index e9e16425c739..470155856b02 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -43,7 +43,7 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
-static int __must_check of_clk_bulk_get_all(struct device_node *np,
+int __must_check of_clk_bulk_get_all(struct device_node *np,
 					    struct clk_bulk_data **clks)
 {
 	struct clk_bulk_data *clk_bulk;
@@ -68,6 +68,7 @@ static int __must_check of_clk_bulk_get_all(struct device_node *np,
 
 	return num_clks;
 }
+EXPORT_SYMBOL_GPL(of_clk_bulk_get_all);
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 39faa54efe88..ca74f4e83d25 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -372,6 +372,8 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 int __must_check clk_bulk_get_all(struct device *dev,
 				  struct clk_bulk_data **clks);
 
+int __must_check of_clk_bulk_get_all(struct device_node *np,
+				     struct clk_bulk_data **clks);
 /**
  * clk_bulk_get_optional - lookup and obtain a number of references to clock producer
  * @dev: device for clock "consumer"
-- 
2.25.1

