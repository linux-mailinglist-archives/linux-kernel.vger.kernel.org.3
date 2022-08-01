Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0758662E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiHAITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHAITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:19:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F63AB11;
        Mon,  1 Aug 2022 01:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6rK/Nn5uGMEeHP5xCnF8AiInhJyX0NvivP3eppmq+nsueURZp5ZrAOMuUG5IkpI1zrRG6NW40MzmUNUGcJvmOD70RNXdcDBfgcZs/iWo+IOJ/1o/QR2KqcdjouQGv6bRSIpBSmew7iv9A1FQB+liKqzyxU1tDvoVxE/5fahN4ZDpd0qiAFxRVCVQwCMn08ng5BpxndlrbfkuPodWQL0ckFQgh0/72Puh44g+QRWhSHQbYblwfl4whtLF46eMf5l8B/2UbuCaYibOnGUiKQ6oKLLEuhFST5lOQvQ0BYxS4vBBaf6ngZMVfExO0vF/YYTNSoIYIxI0NbH97Yz935MCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN1Qwcq9eoWUxIJU9Yd2T4IGLMbZMN7Zb5GLCZFJBrk=;
 b=KXMrL+ybI475Kmj3giaHd2Q7ig6tXeL2gqnpUxZpMQkPevyB1jEwYDKy1YRMcdzdnCj5/lLdYXQcr0ZVtLCexPfLM706K+VPVsuPZ3rGIIbUjm3aDZmlFawlQB0UmhG4SHD2IfwCl6he4mcp43KIiMNRWmZ1F4cd2HGWma4rb3/EJ9oYxpMxVdEEWXHt/LZ6ui4hOPT2okOnLtQX1onf/cz3yrKc3lmbNmsZCZy4E/lFRUQuX1B/m0wYCW4UUh0KoHOfhCGTj7/4ip2MGeEnQ29OV3eLyvenRIH16pbDoLivsnPet9LGTpxnxBbCt06iBgJXPrW0Ya2JD4JEIXrNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN1Qwcq9eoWUxIJU9Yd2T4IGLMbZMN7Zb5GLCZFJBrk=;
 b=Rb+QmB/HAKgLd822/3n/OTRl9/GNvjHYGBbqFUx4EW+XoK7jUXqfB9zYx3EMPg0D67kVA+IIYhLaxkw2zNWoP150KeG4lYorhWjj67QEWMADgPAmiFwK5CZ2xA8sYqTqBFjM7qKHQoCbZiu/GUxQKVugZVfMpAfamGtJiU5WcjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 08:19:06 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5482.014; Mon, 1 Aug 2022
 08:19:06 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] media: amphion: encoder add support for contiguous planes
Date:   Mon,  1 Aug 2022 16:18:05 +0800
Message-Id: <72174e3feb8427f255dd65d081765bef23b4cfea.1659340974.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659340974.git.ming.qian@nxp.com>
References: <cover.1659340974.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7ab328-ec26-476b-9e0f-08da73968054
X-MS-TrafficTypeDiagnostic: AS1PR04MB9334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyebxqza+X+btEKdd3kVt+Etf/1dO3ndyaEv64IrAeMwcCAIs+qORapNGIe4d7ydgYTiM0p+/RmI2jZRov45TwliWaSPEBQCs+KSc68hb+s0soXcDdA3h/Wy1kU3O2yONY5YfNUvcpofFYFJyyltTuRoQsdB34LAp9+rOC11F11c1Y9/6JFUAVLCw+HmOtGriPGLv1tqHhhucaG5VOv2WotjJ3BsvGa5v6QaLXf2HEhd6tlGqt9aI4CIRDUfjyf/V4QbX4lFiVWxLU5qhh3to6eRVMajM/hx6Fe7D0710BRIy+Sds3nphJDBMotRN6W7ghN66ly8jeRPo9WRUoRBtmQMCdH/gZpiND5gjvHK48ayFQuQlgvGd54shFBoqBS0NDBxyvW3i68CkNpGfo0Y4+ONyQt88CUb/BTIDzpDnQrDrmW5CM2OjiKoS3F0yUt7ghtbgiSktqFDE/QZQvOz0jR2SkmL+7BFXvJeqTGtVT5PWhesbOEDow2tds+QhZK17PYbqxTIcw9Vr7dXcxk3hjkSFV/9d56xMZjt0khC6D0ufviKFN/ShN0LyLfU5psQLnmuSqodel/jOR1dTlPIdQhyzcPgc4VlPofScfGacDMPTaEfV10ixhv0TbA63BPoDX1zzmmNKP1Jn3x6pKsrSCbn31rAvpddLwj4S3UkFyacSYQ2yK4XiQzbPLdJOVtu68WuQPOnBqIPC+5RkrmmeLB22mS/NHFyx1MEstoKGOHMXQu/SLfBbn26gsAbhL6Y1VE30Ae/x51oYR2HmtIWOkytZ2vkkqZwviUUODUs46XnjVkW1hKLPaEWkBf9K2fU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(66946007)(316002)(6506007)(6512007)(52116002)(26005)(6486002)(86362001)(2616005)(41300700001)(38350700002)(478600001)(5660300002)(7416002)(44832011)(4744005)(36756003)(38100700002)(66476007)(66556008)(4326008)(8676002)(8936002)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdwMtpUGukYQbj5vOyjIqCWyIMtKSfJ+SUn2Nq5L4pcskQ2D7guopUyBQfhR?=
 =?us-ascii?Q?eYIOXrQWecf1dOrLItngfZB9bS6YbLNBfx6Sylqfaur9LlMd3BmceuoLxegM?=
 =?us-ascii?Q?J8NRGdtPe5HXhWfhCT6Z8fJAPRKt6FdqumXSArnCh0W3gruldxSnnWsjkBvp?=
 =?us-ascii?Q?xjl5sKvKrB1oPs+w6ckgkyu4TWyqj+87CSF8C/bobbEPLdXjDSozC3Fl5WIP?=
 =?us-ascii?Q?xzDQUT9QWeA0+r+GS8b7eQANnSzSeN8ORooQtN8pHsuWdMN6Qwtg5482Jako?=
 =?us-ascii?Q?+cpsGKpqexicJw5FCYaC5MHinO0TE5X/GolQCcQqURmbPx6u3BF+j33uIgZm?=
 =?us-ascii?Q?yZxtuziN3qQvmIxtR6a19k0bQ5WWFl67mRLAgzDgzfoCu2/ocQG4xEAQ2wU/?=
 =?us-ascii?Q?kBdEO/rkYVs9BZ5lXOUQJIp36S8ckiTpkkANmJRcaU3xeXaOV/UYQpyyNuob?=
 =?us-ascii?Q?UWVxY4Lqwsw630vM471rLGO1nTjhhrSAH4Wlgn4bHrPTStlTJ59rnA0hvNuw?=
 =?us-ascii?Q?gf6F9skvbesNFcvdDbaHHLJLrEf0k/qDvcOdqPeypQcqGnYwqVJoIA1xfvBW?=
 =?us-ascii?Q?vp4dWvGigteJ8/2O8yte0gjdPqqzruG/w2W8hVEsxwem7mBMyg0xWUmSJvw7?=
 =?us-ascii?Q?NqDPa4Cp/bYngEhhST/IdA9aitJU4AhJEKlnOqbazY/yDU4Ptue+DVpINUcM?=
 =?us-ascii?Q?eCZDJ8mkwuuI1UF6a6ud76hrMRhRPDRBf1NfcMXVrMxq0HkDCGZS5/nzKCmH?=
 =?us-ascii?Q?G5/bYrMdnpdrJABY8JfJ8dQbGGet3lzSn4DZuCjz5EjfQO+EvCOlamOsoRM1?=
 =?us-ascii?Q?F2GIiyWVK77TtzQImIFTRrt52UQq8t39Ok+1nhoNbfzs/OtjDdRv69qRTMyW?=
 =?us-ascii?Q?/1lvziNNof5BS9eItIxpqBCQkFBO0eDuxZ/3S+MUE90P8h1QDlp7m5kwwYWp?=
 =?us-ascii?Q?V8f5C6hliPfHPHHBfdEzOXNMa2GYXtwuXR8mNKfKHE1RsD2w3HnsNsJUQWjV?=
 =?us-ascii?Q?evIRlTTXcJHz5N3xSB2zA7YEJr8lmsU1rQLmSwYfpaiGklycr8ZbnmlT89I1?=
 =?us-ascii?Q?eLjLmb3GPBzVFzGWe2fTCYX9dK4un4/J6Ky8jqQCsB7ilnv93gL3EpSn7njW?=
 =?us-ascii?Q?VifMyN31UjikWmMVp3JaZ3b+fpwDAz6RjmQZ2psxZgb4TLQOib8NwFJB2AFg?=
 =?us-ascii?Q?6y17kS2vOcNcBY0/mgUYM4IJ59IxAef4BwUytAmbZv6QmRzwtUD9AidnBQIc?=
 =?us-ascii?Q?9e7iqs4XLaR0FgKGR/cc2b0XZRFSIqjuQmxYoBV0VpbsQQ63XVE75+ZyZSmT?=
 =?us-ascii?Q?4d73s4WF456tDNKE0yY6u3qUHb8DDHbZCj3ReOb8DxlJuXyVbCH8949aJOb8?=
 =?us-ascii?Q?QsoKTMaNoNru8Bf0PuNcgh07Vq1aSvneOs7Kl2vBsr6dOjh8EDAvWEKdwgOv?=
 =?us-ascii?Q?yIaQeJQ8yNwwwRCAdFHUumO2SdQ5XTzfawATc9V9B+bFK6fFMy+PtzGc1CHR?=
 =?us-ascii?Q?z+xa7LjoK2Sy4mb2Vyihl0OllF/mgK9lnRHTw27TV9ewkDxcKQI3wdp+qrSQ?=
 =?us-ascii?Q?cv/xnS3WjQZeC3Jgbb6NN4f6AkzdBnSx4wVSI6N5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7ab328-ec26-476b-9e0f-08da73968054
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 08:19:06.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTIYpchjPSNXS3rrFl/8oAv352gw4GD8LsNUQB+9vz0vWZYlp7bfB64CYWRGXo1FUYjqSNJM5J0oNe2Pp7jnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

encoder add support for contiguous formats NV12

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 060a1ee78b17..3cbe8ce637e5 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -72,6 +72,14 @@ static const struct vpu_format venc_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

