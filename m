Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4BE4AB502
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiBGGe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbiBGG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:29:45 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10088.outbound.protection.outlook.com [40.107.1.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A85C043181;
        Sun,  6 Feb 2022 22:29:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh2hhvq8+ICs2RhO1yrYJg1BYrJHP1sGPY2riEkX7/vMi2A1biTNOP2C8hRr6E6OFkTf+Y4djPr+nuLHPGarwUb9FpSg7REoEHyg7CHMK091PAzrWLa7RcvGIZQEPE+4Ewm2tu+e3SbaH5fBADaLssemI6jb41AGpiMBkkr9otWcT5Dn8vsrpX6IUT/qvlDfeSUFXIXEWzJ/5g8rgnmRlnA0FI77s3jIDQN35moZRVdzSV3hPNB0M9p0AvMZZ2FXXGlqGIeJ1LLhjy/z15CyjG7PSbCqgoRPCHvr2SxYh3aqdegsS0RXbrUXtwCfj3HmnbGrsfPEiUtryEkNH2YnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcBq9rBqhKlkg0kWWxpsPQTZV0OTdpYq0gd4i25noqw=;
 b=kNlVOYuZkIi/YAUYRM5uRrVYuOz+hTBEhqoQSPV9X2XLGwU+IoIqenK68f8HdRqxUlRrLRDODNzCGQIoL+iELrMwvhKDjTztVP3gu64VAiCGsXDrpFeDulkkTvVnre995QLYncoXcJjBXQ1kOxgFNSbCU45UjUvbauUjmWWEjWvQ4+H0zaePU8lfzuAir8uLtTHFaFFrAlkSDwpdE4KOW54sAi2RYb0MtHlLhXEXRGvfP6xoSNOPWw4QVWz4kj49ZeuEEbXUmRLX3gczNsudsMcahrHmvzDhquf2go3hoVThVk8xEtlUWdoV5+1wyctLlUKGnwaay48jDVuL/yugjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcBq9rBqhKlkg0kWWxpsPQTZV0OTdpYq0gd4i25noqw=;
 b=TkV8r0jZlajxri4cvivnVdbwhuX1k1IvDKBm/2CKTkeMpg1CvKvzrBt4/7NDFMkEXf6HCy9T1v1Q0WK/R2x3UCq8uOf70L4MhwZ8k4qLXGrVa0eChlWTomn/Wi539QjiYBFWXVFuwoEUNJpqk8kLLX+nehVTbWBrVSreDoZ/BsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB6744.eurprd04.prod.outlook.com (2603:10a6:20b:f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Mon, 7 Feb
 2022 06:29:41 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 06:29:41 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        mirela.rabulea@oss.nxp.com
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] media: imx-jpeg: fix a bug of accessing array out of bounds
Date:   Mon,  7 Feb 2022 14:28:43 +0800
Message-Id: <20220207062843.15562-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2edb385e-b2ad-4379-6e56-08d9ea0338b1
X-MS-TrafficTypeDiagnostic: AM6PR04MB6744:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB674456EF48B6A7AA21857883E72C9@AM6PR04MB6744.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbzgelYCYFOZTyMIAb0i+VNXvAn5W9AZHq3m8rgW1EpZJyr36SH5UWWgYVfDQJGoO21RJqX2kzeUZ5IYi8GKdch1/531/poIvxTcm+eKqfc+0Y6+9B7XrM+sF72blVq9Cklqt+qyz4haYMOG7tIq79mxsI6loQetn1M9yngQcOyAtBhof5MhKC8/bj+p2JXTRmWC0gsewQni/Yrai7oUJ+Yk9fIKUTfJlEhyN0PiXxQV1R3ynAiXNo0k+NrV5PpgnNCYlIMw+HHdcgaojd28gpDNy3BlFZ2VMVPaTp6msaYc7RzSW6hrpdEj4o1N3tyn5Q7cqmIeDlJf/g7mcgsaL8ecmkmSt5hCLE+yWLr8Do+9SwWT6BLMNABN+UyKsrGP6AJduE9TrhB75XGczDQwdCDogcCaTPa5dRMM/GMlXUbFOal54UZzD+XB9g10tXOW8oiGtnbm8VTKRrQi8ADir5Bb792PVabLwLoBO3vfWwkfgkXnkESlYPydjG+b4mNIlrMkf609FGoJRkjoKG9YNeTjM+LNDex5pwRDMbHX+Qi/OXRWvMvyW+mDQcnTLxnvaEIa0icAvYCQbR98b5SNfpd/3GHHplcxENCtGRV5nU2aOQ7jjWO4LWk8P1UzkIEplUeJ5xn1Hi6c0tgBr0minVF34OrbulRw1hvs/SCHKzkEr9dxe7I+/B7BCmpn5TUBJ0c4JnNzX/pWUxkQGEIM2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(2906002)(52116002)(5660300002)(8936002)(508600001)(316002)(66476007)(66946007)(44832011)(36756003)(7416002)(6486002)(6506007)(6512007)(2616005)(1076003)(186003)(66556008)(26005)(4326008)(38350700002)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XKHo+e4yGgTageSfcxHbCtrnSo4hREYybDQOFnPyorH4YiynU6nPM0XNhpKP?=
 =?us-ascii?Q?fQnoChZiIgcceMqAUIrdZ6zfRroSjXUZzo4A1C6l9U21u4vua/Tn7TxltqZ5?=
 =?us-ascii?Q?KJ53/Apc7l2u1daViyZM+REF6xAZNga/jBQKNRICwHtknyPpGCT7ohz5QMb3?=
 =?us-ascii?Q?VMtSZfJFG6G4nkTyUXDHCkVJtR1f7qoDw9+3PSL0MEvEm4N6KZs0VzTjLT94?=
 =?us-ascii?Q?j17tk0DuMnNb/kBQbG8nPTBp1eL6cB7fScvzfEwlmcxMOjRMwzgl5Lr1juQD?=
 =?us-ascii?Q?wqOGt/Tx6VFlvwzWAw5gEGYjiBjAibX65nV8p5uxBpClxQDyrQOoRwWDpye5?=
 =?us-ascii?Q?/AIikIvKITy7Yabtp/f1ozBft7+DSfSMTEKvWZnlwOJ7eJNe6h4A+qRZACsX?=
 =?us-ascii?Q?AquklXagAu2zunBWNPZa0E8M12RcMgxhDUFfIasE9RryOT3jU7BP+HLi/zk1?=
 =?us-ascii?Q?oKYOIEYMhDG2W/OenCbbOBw/HARta+z4Yswmd9bIXDDUNRMWFleAa/eDHX9U?=
 =?us-ascii?Q?GfsjXLSb3neKw4Aottfwsq9S/qYFPFJwhSIpyemqAjkMbJPO/TIFu7BS5lqs?=
 =?us-ascii?Q?5WGOLVtnokIfBW+Z7wEjRoj307yHP7qMWC/QBfT/JiULCzdxsSxknh1vZJP1?=
 =?us-ascii?Q?K5BcP+Ax7+ckMsnKcn5LZrBZ5cAXmthkzRNT9Si7K7v7bG2WFuAm6FBXGFri?=
 =?us-ascii?Q?WduVBmbi7IiODf0UwVdbFg4z07C0HU9QFTTXYHImLpijLP67m2yEWjqliz5g?=
 =?us-ascii?Q?3GN+sijySwzOoFrw5RPFDIcPtaSnwZrijBdtbq8aZ4B+6IWMXpJBkEIWCxQu?=
 =?us-ascii?Q?pkpTMEnmUXV+1D1S/f7gy0x/6ZlMB4Ah4KeJprQUm3laZTYt1J8lm7UYP0Le?=
 =?us-ascii?Q?NUL7EaBNh0FC+eYmxuIZgxW6IfzuVjt2x0ubta49MU0HrhaZOeiWCMqKov/3?=
 =?us-ascii?Q?r6HA0wC8+KzJQTt7XUcuY0Fm87V9xvmZM7MEoTXQ3bYpjh5OKfjasps7I2c0?=
 =?us-ascii?Q?Fuhei0xt/8Hf7Xm4ZpYIrdgrvABTeOOYZLZiZPgAIwLdcWMQjmTLH3xsoiZp?=
 =?us-ascii?Q?Zct+cTLGjn6mxSSAUvIBFEq3EoN+oqSJwyqjxN/BZnZIF1ozBT/UXo6vT/IM?=
 =?us-ascii?Q?uL8sF3ZAHCGSQe9ZjS2isNcRJZ1fojOOOEiRELCTSptVudRfh/ymvVZYSlBf?=
 =?us-ascii?Q?tO8gzfCjKOJNywoDSplLu4eV/vRl6ldw5vcwxoohXzi+vHoW0lwQ/0Fxxm+3?=
 =?us-ascii?Q?ndoKNOLGfFlubG/V493h2bIEzhh5uQ8T0VqpR1b568wwmVriTcWzmBoVjQnq?=
 =?us-ascii?Q?NXyE8hEtwGGY2XnjJpKncbx02wNcwZpQTFspYmn8WkV6rlZMf4S23mONoczp?=
 =?us-ascii?Q?4JoT+SfaYZ97x1KbBm3f1hFr+F19z87GfPyP37BgN3tVV+iOshgcchyFGIuv?=
 =?us-ascii?Q?gQJpi1xuY0IL5MGGjhyOfIqbndjHiOrH+ggDclQ5UK5XQR/Yo6gvN6rUyy7u?=
 =?us-ascii?Q?jjFKFnXSvN0LIGIJ1D9m2MxDCrVI+0Q1dxd5mHV+IjI1+UXRxogpwLGf5Bjp?=
 =?us-ascii?Q?eSvfX3qHQ2c7MBaGCgyuiN8OEMqTx3NzRcqYB/4ycEjyfqDkcEWvteACgvvg?=
 =?us-ascii?Q?Taotz83MRxifhPQDVvRUYrU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edb385e-b2ad-4379-6e56-08d9ea0338b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:29:41.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86NkletwKZwQa5O3xu3ZOrOhw/W/1TfpRx3h+g4Cfiw7+avZcI2RcqWqikNhgzlgEfVZwnVAY8txTSIHCI3vCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When error occurs in parsing jpeg, the slot isn't acquired yet, it may
be the default value MXC_MAX_SLOTS.
If the driver access the slot using the incorrect slot number, it will
access array out of bounds.
The result is the driver will change num_domains, which follows
slot_data in struct mxc_jpeg_dev.
Then the driver won't detach the pm domain at rmmod, which will lead to
kernel panic when trying to insmod again.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 7c0366f5f801..86d37d14cfe2 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -948,7 +948,6 @@ static void mxc_jpeg_device_run(void *priv)
 
 	jpeg_src_buf = vb2_to_mxc_buf(&src_buf->vb2_buf);
 	if (jpeg_src_buf->jpeg_parse_error) {
-		jpeg->slot_data[ctx->slot].used = false;
 		v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
 		v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
-- 
2.33.0

