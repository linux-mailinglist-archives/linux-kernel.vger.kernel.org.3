Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6574E9647
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiC1MNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiC1MNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:13:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6446175;
        Mon, 28 Mar 2022 05:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr9IMs2BzWg3IpLE5P5KbZyfBljrytvW+wsiJSbdt4s/mZWjapX/OpepG6+8hL70lTKO/VD7X35CdhDgOzegbZr7ZnW1dGtegplSwxuzGZIPIL7CdFP76O7zkGF0k7QNSRyNPcpGrLyDB6AqLO521lhr565omJn7c1+xWit7h/jtB5hzDEMeM2ZbJoW/JQazW4bMT/DMq/IAQubiMOQ7VRmNvfaLKRHhRQTGyXNboj2u22CHbJqNjfzmFoDHVLIhvlr8aPtx1U6QTGTEOUa/fRp943R2Vj6pPP7vbtvg5twKY/g3RMbJA51HLGiX4m/Nxetc4bp0m/gW9mPeIE29tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMgGUSuEI/SgMO69Gf3gBVbGWQ5EopaJWGTT/16x9I8=;
 b=DXKMz6bD3kwlRQ5SS2gBinoAfg/YMNFJ/22+QeUcTOT+47bA6rCXZ/JfmE1WprTvj8dWABT+PTVoPkM+L4kcEbIs4Zv2XBuepVpJq0g01TX4l+wmW3DYfCvVZF6t6GqPMpjd4NAHKos9vtmf3oaas7kAY0Rk1I8VHAOWRkxO6Y8HqsVw10fRIMZnbGZO5N5WmHrO8dl3Z7fRaGuD+V15dPp+vGhY/IdEsX+1daHXH6z7ATwn+FaDd2EwGpjmm4vC+cdaLlBftfo6WaD4sPYGcQRLZRbNDnEk88g7a80Maqj+ZoE6DmYUxhNnhxL78L8lnxXlYO/+c5Y4pGf/YwL37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMgGUSuEI/SgMO69Gf3gBVbGWQ5EopaJWGTT/16x9I8=;
 b=vDjf5l2oyDp8Jv2d/FOGnhfWgDwXZAcGA6L6oWXtaUR3gaOaKhYzzjDFkdJKCKXKdsWyrdMoyV0jCJg+AhX7WMbYrgPXWWISVpyssb70Wg98UAfv1+ZauXP8ooceiG6LZw5i8mmRfFU1nZxp86tL9DLih3fPV3Lme3dyNyZ3w3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB4170.namprd04.prod.outlook.com (2603:10b6:5:9c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 12:11:37 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::a865:6d10:c4a9:1142%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 12:11:37 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     robert.foss@linaro.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] media/v4l2-core: Add enum V4L2_FWNODE_BUS_TYPE_DPI
Date:   Mon, 28 Mar 2022 20:09:52 +0800
Message-Id: <20220328120956.1848795-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3e99401-639e-4847-a0af-08da10b41bd1
X-MS-TrafficTypeDiagnostic: DM6PR04MB4170:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB41709B83DF11BB5E7F4B27EFC71D9@DM6PR04MB4170.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTmpJKBlGUOVD0GTJ7n8bO5r9RZpCDSzzCAqsHzHZu5iK/5G1XduAyoMAjM6/Qmq0uyCthLfsEvZMKndC+VPYhBmriTvj8Wo8JSm2Tdyf3ot9Xy7uQhzFCpREmVfJOp14M6GMh9meMH005wqBe4yhvOpJwPr38c1Wt1Rss4pMcjr9+YavQl4yOBTcbMii+mtIRXRvIejQy/u1hOL7hqrN0Pcqkr/Gq30LJpna4++UOjZ04NjBmKz6Nnl9Z1iCrGFnDSh3BDeFYt3ZKPB1p5VGRpZ8nbIUHz71dls7i5pLK1MNsVMn4UI66vZ6RJYCqqFWV6Hzeph/1FQQ8lt6Vk94CDTWsD91lq1bSzuP6NDd0gmuuP3bHQJ17bXn4RLrCv8/77qWyrScq0A0yOVGkJBAexXD/+tAFBapCGptEtJYfyDiXP+o9+fShNB5vkL8mIH5D43zNDWC59lmFJKKkOTmhoBIbCseL9ypYHDneJgUdtcMYLYyo+vgmu7xRV7GawikpCi3rX6k9PGXvOZQi0F3GwEViM7h8b4lMWtw8JBDmvIW5H8zsFiV97u7RrUFl4K8K9qf6Li1NnNpP9J2eDoDw08L5VFXIzGTucFAH5oHHeYWm54STBqU6fG555eQe9yVe2iOiz/w6pQS87FfwkCRrVQjBaBJkAXctzi4wFzkp0FP7jQm7zvcuRSv4PYtCoWMzJiUPQQtX8fdf3qTxNmrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(2906002)(6916009)(5660300002)(38100700002)(316002)(38350700002)(66476007)(4326008)(86362001)(52116002)(55236004)(66946007)(186003)(6512007)(1076003)(26005)(66556008)(2616005)(6486002)(6506007)(36756003)(508600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlxHMZwPWtT32rQ6GSXtOY/3F53qORq57C5fUBV9bXOKXR6TIXN2IqFsdONG?=
 =?us-ascii?Q?ftqgX1ECIawOAJ8Iy1ldrytmCbhC6t0Zim78c/NU2FftxaWD3cu5I88SaKfF?=
 =?us-ascii?Q?n8d5nSEQD7A5MzkrmMgTxZnwxGg/t2eoPxwU7wSp5KpoFNMzJ8/aEje5d1Mh?=
 =?us-ascii?Q?4Gm85UM2kGQeV2pa6ec8RAtHFytujqOWN7uNUn6rwCu4yXV+QRpiu7CVnbky?=
 =?us-ascii?Q?J+SGnUuPYahJDC6CNBHnrHRp086oo0gv2Eeffq8HkS8qPFXPGKlIBaQC2MdZ?=
 =?us-ascii?Q?bMYQyjPsAgNypIkW+WRNjEs1POb/mcqVOmyic/3FKmKZ8qHms4jkXEukBN+R?=
 =?us-ascii?Q?Yc6kfh6772zO34e2IJFdGFNpelxCQfJsY/ErE9o8gd8eArbXmprRmDJK/oey?=
 =?us-ascii?Q?NZSlvdQUxx/IVoasprVCcR/nvqOHY+UpgzpxVpBjHAx0fK/WmzPqkJNe4iAE?=
 =?us-ascii?Q?iSu3P4bVC69bJsFxwl6Y6lRSSamzJ4m6cYD8eSKbKErCo1nsmzZ1Gpb/NhxJ?=
 =?us-ascii?Q?xmT+Gtb/A1gumf8bnljJdHxwcr7/rwY0bdRdWdbEBYDfLlnD4BIcJk/TLsDO?=
 =?us-ascii?Q?gK4rK3luMeLfO23VbOIrZufVqF90t3clkPmYxZzWis3CyQ6xsDB70ZENarmn?=
 =?us-ascii?Q?YTfb/O8hzw43QJXjqLYerOzG6t3jTDxh9qDSDIGZSr+OdxKCmmsmE+UZ21ca?=
 =?us-ascii?Q?2koDjtbyGSfX/9gDHbPyxZWuxRSQk5Y3to98dB74tzR18ctwrm96SoS7FL+2?=
 =?us-ascii?Q?uWV86mNyB3lN4R+JRWEg/Y9D+0UsS2ieDHkqlbxhCkupK29JrRrsvkZMaiHg?=
 =?us-ascii?Q?iFWWmchqMwwyCvkMponNUdEWySP7yIlI1pX6NadfbjsiO78KGzqaAuOJtfPn?=
 =?us-ascii?Q?XtoZH5B8gjQQ4lbYj/eyqihZEkTnYWzvys3fs2k5PLhiOVqIIH6sp2MKj4wT?=
 =?us-ascii?Q?z3LphmEH/nFuB1jI307zMSuX5Fn7qAYZqAD0IAtFM6SSxBFcugMRqsV0l3mr?=
 =?us-ascii?Q?2cAUxwTHjnISb+5/U8ERdCrBquFcyJzIUJVdklKiW1/GIPhRLx+ZyAQsZRZ6?=
 =?us-ascii?Q?AJk48GFs5wXP4E6HOftJpllCUfZddhL8n1b68EjSHK/WpbTh4/Qz9EvsozDF?=
 =?us-ascii?Q?XqrVV5xiQvedhhOVEl17QC+w3g80nRlM70V1ZH6mvaj29s2mRQTARoDqiW3p?=
 =?us-ascii?Q?6Gnq8wh/gAW6mID6+FLABSiZLsEKVLT34AO+GnqiY5Yq+k2w+XO1dFFJM7QT?=
 =?us-ascii?Q?5DlAMf4ywF9CZX+KYPWndDrd1NKPxpN++kFHEQRtUVPESlJyAheZSwC0TnWa?=
 =?us-ascii?Q?EkQFoxCKcyCJJRszYPCw7F7KKPrZtO0egQ9zi/nwSFvZQWmAHc5HVFkZI9Ys?=
 =?us-ascii?Q?/f27Au1FZGhYuBosKIViAgXX0tFKW781Tdy/F1n+Sb9gDSDNakPRuWMJMBYk?=
 =?us-ascii?Q?b6vyvrx8dMgJ0EDFx/qqLLy7ZaX2Nq68RED/FGaiPzfL4K31dQ9aMZmgsVjD?=
 =?us-ascii?Q?mSuzC7fi4RFiqQjgVVVoMf1/EN/Wvh27qgBO6zMGgxCZd7ilyqqgvADhUmIv?=
 =?us-ascii?Q?1g6v9BQmjrlYADkBW2+Svmz7d2Md7yUpYlUtqpqJumfnn2eBpHSn27JZ5FWw?=
 =?us-ascii?Q?yOp0N3liEYfd9YKMSxwhM5YAf6ogf8yZyP1AmKBGbf56mqxkCLAdg2hvkK1h?=
 =?us-ascii?Q?fsT3lqSv55tx6U63T4EmYP0UkqH9be9JRJRXU1cXtHoJ94Z0V8fVR28i/tiB?=
 =?us-ascii?Q?ZIbp8aRgpw=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e99401-639e-4847-a0af-08da10b41bd1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 12:11:37.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rf6TOD6M5DYY+rXfuHagBEA97tcidgINxwnVKVr+HfgFtFq3hWwj9ubPi4nNwTPKRjk2bVFp6Is9wn3aT0NH3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4170
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As V4L2_FWNODE_BUS_TYPE_PARALLEL is not used for DPI interface, this
patch add V4L2_FWNODE_BUS_TYPE_DPI for video DPI interface.

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 4 ++++
 include/media/v4l2-fwnode.h           | 2 ++
 include/media/v4l2-mediabus.h         | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 00457e1e93f6..4bbb70b5e8c4 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -61,6 +61,10 @@ static const struct v4l2_fwnode_bus_conv {
 		V4L2_FWNODE_BUS_TYPE_BT656,
 		V4L2_MBUS_BT656,
 		"Bt.656",
+	}, {
+		V4L2_FWNODE_BUS_TYPE_DPI,
+		V4L2_MBUS_DPI,
+		"DPI",
 	}
 };
 
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index 9c97f1dbd1c6..e17e59dbb2e3 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -222,6 +222,7 @@ struct v4l2_fwnode_connector {
  * @V4L2_FWNODE_BUS_TYPE_CSI2_DPHY: MIPI CSI-2 bus, D-PHY physical layer
  * @V4L2_FWNODE_BUS_TYPE_PARALLEL: Camera Parallel Interface bus
  * @V4L2_FWNODE_BUS_TYPE_BT656: BT.656 video format bus-type
+ * @V4L2_FWNODE_BUS_TYPE_DPI: Video Parallel Interface bus
  * @NR_OF_V4L2_FWNODE_BUS_TYPE: Number of bus-types
  */
 enum v4l2_fwnode_bus_type {
@@ -232,6 +233,7 @@ enum v4l2_fwnode_bus_type {
 	V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
 	V4L2_FWNODE_BUS_TYPE_PARALLEL,
 	V4L2_FWNODE_BUS_TYPE_BT656,
+	V4L2_FWNODE_BUS_TYPE_DPI,
 	NR_OF_V4L2_FWNODE_BUS_TYPE
 };
 
diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
index 841e190aedd9..d35d8eafc7f7 100644
--- a/include/media/v4l2-mediabus.h
+++ b/include/media/v4l2-mediabus.h
@@ -103,6 +103,7 @@
  * @V4L2_MBUS_CCP2:	CCP2 (Compact Camera Port 2)
  * @V4L2_MBUS_CSI2_DPHY: MIPI CSI-2 serial interface, with D-PHY
  * @V4L2_MBUS_CSI2_CPHY: MIPI CSI-2 serial interface, with C-PHY
+ * @V4L2_MBUS_DPI:      MIPI VIDEO DPI interface
  * @V4L2_MBUS_INVALID:	invalid bus type (keep as last)
  */
 enum v4l2_mbus_type {
@@ -113,6 +114,7 @@ enum v4l2_mbus_type {
 	V4L2_MBUS_CCP2,
 	V4L2_MBUS_CSI2_DPHY,
 	V4L2_MBUS_CSI2_CPHY,
+	V4L2_MBUS_DPI,
 	V4L2_MBUS_INVALID,
 };
 
-- 
2.25.1

