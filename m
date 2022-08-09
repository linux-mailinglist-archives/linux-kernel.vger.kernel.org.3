Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D7058D40D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiHIGvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiHIGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:51:37 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00062.outbound.protection.outlook.com [40.107.0.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA9205C9;
        Mon,  8 Aug 2022 23:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHbj26kaLOhQkDwtWaGmiy8EHywHmPmlo5cRhguwq5TUsKNVg+78c3yOT5MFJ4j/fZQLunttiird3UEyKKXPCNY+w2qmxPWzWbCsHNgSMgg2F0jwxx6pJzGEcrcflce6hel+n1JmRGN5aqfdr3RNlq81TEyskBa7sRExm+NOxJHt7hPJnJ0aRLEFchsaczWpz7374Yz2qVlsT+xTUwVgBlgfduBN9bjEWSynoLg0XuKHxanS+QI/4TkEXtsxV6TA/9pk0SH1hXlLw1dj2wRr8mD/fmKwiXo2oGW9nKYsDEQxZRVzpdEkU4MFCSZTOX/m+QatxnCiJXFAW5xNizNGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDkTfxNOWCMwgkEiHCmfKKRGxwS7MQ9xxBjraUxchBk=;
 b=aodOJuHFxMqUUsNk2zo9WTk3jLY0ecot6a2XwbdgGBax+Q8YoKGiUqaTcPj+ugQCQBWHnReeKf+OD1aEW1yLq8jJM48d5CuEhr5N5bhB1b0Y6T+UNrw5ZXZYPbdxlFHdWEvtrE264xjO+OpCVIVUMUxjcoOjzmWR4LEbqNE0bn2w8f7HSXDak5sNsQy10+4rwNT00i0lpeXzCuZoK2on3hS1pRGgsFg8oP6QptG3It9y3bz8mmKW5XTPFh+lm9Lj4jLSoKVSwrw217qtAMYIer2qHOQUoTeLgle/+IySQmvyO0Mxqs7mLKqLNCFahQsZT8j+DaZhcKZRHO0aj5USyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDkTfxNOWCMwgkEiHCmfKKRGxwS7MQ9xxBjraUxchBk=;
 b=ChXeilC34RqpVEcLCHrtv27e/DJmQ2E+uuiOKwDavmDCTdPQEfCB0ZzPAh264uKNnCNSPzkauATntH5/ZfVUq6L/x34AYSi8c4841rELFoIQ63o/aMhsDN+8jFdGKBk4HXLsbXwetbsTDpIrHlSaiWmtmFsofxEr19dBfm15NdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8991.eurprd04.prod.outlook.com (2603:10a6:102:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 06:51:33 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.017; Tue, 9 Aug 2022
 06:51:33 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/4] media: amphion: decoder add support for contiguous planes
Date:   Tue,  9 Aug 2022 14:50:40 +0800
Message-Id: <c55f85d694cf6cd29fbd072b9246dda296ca6639.1660027440.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660027440.git.ming.qian@nxp.com>
References: <cover.1660027440.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac55b891-3508-4f3e-131f-08da79d39876
X-MS-TrafficTypeDiagnostic: PAXPR04MB8991:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnOVxiwtLJoX0IvPmCyX6yJHOeSLYIWo41GhkmDv34V3t8S6pewsho7dMir88I2uwh9MaUTzYFn83pASw70zptScKjjORaRuZKJPTyPo9puOncMC5WevjdMEYdO7+BSkhDxl/6+ItF9xN/0AgV5Z7dJIS14VTIRTPiLIXhwXIAXbxbTzpT4IZBeQvNBWWfejMJ0VCfmxCBg7Wne4/1zVH0w2U6CE33Q8KWiCmF3gqwI2vWHmy/nVrzTH4gz74os/pREkNSeKULoMQAbETBjNLVD/myUQVIJyh5vF14HEJElK8Tx0rO8Cq2ELO8wBta4/HQbC+4lcH38bxWC+JiY1A4xZVwTxEgOWOmMp/hos1CWZN8M84wO86rnANstDtoY2id4UCzaqMK8qwQTCz1DqTP2LxujxoAhcUZ7lTvwGUtLzD9iJYfyWIrk/x1GMGWo+c+WL5dLQWm/vdTRFPJtPnnivOun+/Cu63UgWFmwgU3oElb2Lc4qMiWvxHadvWxM3OXBnIBhoI5DhhxK1EKUNbpd0SjoqD3586EqOlDOn8V/45FWmUesMPnVxBSndJ3uf/p5imbegbM8lZw6slh0Gw/pjWNPgtnWOIbvShXxdjnofy2rwVDm5aRTZt29V45ZVAwUau8Q0w/03yO9deMsoFSQ0ZWt944srbw0g9Q57Yy4bOduKdPeu5Udknjea/buJAMirqdIPRJ/cZu25K+j/phB8f56gnJjxn8+FMBLTStlRkWlVnHNEmjPD1QAVCvavHSucawlf4zjXgkqdQ95hTgBbshrVSB1Yc6A87KrUQpsTAa0SOAKIQBzu2avXr3xD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(7416002)(36756003)(38350700002)(38100700002)(2906002)(86362001)(66946007)(66556008)(66476007)(6666004)(8676002)(52116002)(6506007)(6512007)(26005)(4326008)(316002)(6486002)(478600001)(41300700001)(186003)(2616005)(5660300002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tf9+eFokNDz0IA99vozIlX+iGu5EZuB8ztF2o5uYQUEcAIFskFZT2UH4jKfc?=
 =?us-ascii?Q?knwdZVi+83QfyALZNK7Wo7a4rhCBvzcq/aQmOLaYKaZLqEahYZKrl71NTnWp?=
 =?us-ascii?Q?8Bfej/Y8WPBMJhE4VjHrzW/ybP7Od1aBgp+fVuaBt2ksQQRTZTtJIIMKZZjn?=
 =?us-ascii?Q?kftwfiVnAl8q6scXZVVguYhunffqb4ZdeznmCY+LRIF7ccW10PRWIQ5hjbeC?=
 =?us-ascii?Q?BJ7ARhOSrZv9ieT6wjGZUVcOQj3DT/StKxD5tCH1kaEY7a3jqLiVZgFk6pdd?=
 =?us-ascii?Q?hHMcSG9+lsf2HWHtCmRjwfoX5ez096Zl/sq4RNWpNhp2oW1lm6eLHBrqLXKV?=
 =?us-ascii?Q?pbhbBMgpCxI5FT0zS2OndtOb0JQtpHtIXC69CVgeJU923zI4M/mnDJmVN9ZY?=
 =?us-ascii?Q?+Xe6VuRP7ps0x3zvQqc8L3fbO2lVZ1+67TZfxWnsrN2o7HoSO43PoxkBpb13?=
 =?us-ascii?Q?GKhQVJOz4PjX9bDXYVUsV3STkyp4WWXI+JuyIrGDf93xxRAupc84QkONs9Yp?=
 =?us-ascii?Q?36W5xw7XhiPgr74llzfNDb0vN/UkBJEvU4jJrCWu3spo0jdPMUpvYT5ekzGt?=
 =?us-ascii?Q?chm6p6ozqiWCF+e9aBpWShzMMw/ONqqcSuFPKHBnDxUirWQKuFtWZVNWp3tC?=
 =?us-ascii?Q?X/YOpHk1tUwrOyx8sSbYoVfmzKQ0/c2dSqacTKunOLwBP6aMFDPnW/IJlfQr?=
 =?us-ascii?Q?wU0PZ6CpB0jYbTS7u2mqm4Hi3xnmcTMqjf0mMwaNKW71l3Zmz0fnlbdiXA+0?=
 =?us-ascii?Q?nPcAGmnrBKg4pfEAeGMV1+V22PRZPeXmqMup7JxYcaRoDITbda9rdmzR9+CM?=
 =?us-ascii?Q?hxOGiQBrXVvgSxB3gp9gHGFGbGNS6ehvdI9caOyIdbFgqdxUX1WGuQug8lVx?=
 =?us-ascii?Q?zO3Il3EIVwBy4+Q/p5GwpjSZcl7xZV0E2YEg5YwH9YAsu7RVfsclBrnX7GW3?=
 =?us-ascii?Q?N+ZRY+ivLJ3dGARZQ3xSnc2Xv3eisTY8DB7Cqrxx168ieogqzJqEmtVkvpf0?=
 =?us-ascii?Q?Z63QtDYDZdiYfyOLzHwD6Mvbl7QXw68pam5Th9bIAjiGfn6QC4evzziLbuaR?=
 =?us-ascii?Q?y+LIgtLocW/T1rWqY/BVeTaRgn16rIWIPqzIwDtvqOxXP6cMmv1CvHjwITJh?=
 =?us-ascii?Q?pUt/mOA/QHo0GfpKf+hKihgIZoUzYRsQQpc4hSxeuclUnWf2urb7jGQ1Rqqo?=
 =?us-ascii?Q?NkTlW6OXk4xWIwK/NHThCDuWMSIaMqsMnQd+KxgwZfcehjC205R77PxtFGCl?=
 =?us-ascii?Q?TbM+X+ZoR2/Xn8NHFGOtB7R5MvVxqxukttp9GHVxXcWhDOfKRoYX5lfOOK/w?=
 =?us-ascii?Q?7PXy83/GAuZoesrS6ywoBH76l1r3pqrcxUT4s8KOxHqzThFDPcTB3EJLQJOE?=
 =?us-ascii?Q?aZqkAPAKzTso8zQP+rveIxp17LkwY4Is6WCZimf+i6ycjl/paZFsTnk19OyZ?=
 =?us-ascii?Q?C8uT5d5WWMUU6s1IvCSN0a+9k12H7HO49XsjJdQVdmokBMZoqGKIxzQjvkz5?=
 =?us-ascii?Q?+PMEnSpVoTBxBvigGY4gXrBIJVCK2FnddakrB/byni3Mi+czl9+PMdRAd1qs?=
 =?us-ascii?Q?yh+US3ugbOUaQS3dV89dhUeI2Zpzn2AD+tBhVMmu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac55b891-3508-4f3e-131f-08da79d39876
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 06:51:33.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oeUskWQg/XMpPILP+1kI8xQ1zsN/jGwyUjoIsNBBxH1kgc2AkHvSlttPA3VCqXqJhb/GqNS/OeTp7D/V9j4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

decoder add support for contiguous formats
V4L2_PIX_FMT_NV12_8L128 and V4L2_PIX_FMT_NV12_10BE_8L128

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 48ab664fa7ef..9c3324717cbc 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -72,12 +72,28 @@ static const struct vpu_format vdec_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_8L128,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12_10BE_8L128,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12_10BE_8L128,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M_10BE_8L128
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

