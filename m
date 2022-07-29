Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B24584D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiG2Ije (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiG2IjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:39:22 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B99382FA0;
        Fri, 29 Jul 2022 01:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvYhlPTn9WussMfcMShPe9KwSmxpe2GsJ/zK+hEvURWKIXOHO9R+72yD+pP/qt/EoXUHpXlV2aDNf4NovWgMrMfmz3mQAOxiuZeXp98gzJN6qfDtSZ8wLsFej3zHg5B3+pkrsdA5penjERanML3Lsy0Nh7Nbyu3ex1pK2JD6H7bab9AV23Hwq/n0wetqd/0YwIBp2IgHWb3kHgPKed6Qt86Fr936aBEEiiGJ/EdSS42UbO8cxn0RKfERNViZaPBPJdjrCU5XJ/ujxIvQ1QlzzuFo1tuJhFU3HCyAMNlvqd/hhaHZWxCsAutrCXXxPAmWxLu8Z+NFsNWteE21UEzMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPZPsjVK4KkE82rZlmw4T95v9YAmy+iU2EebdwQloo0=;
 b=EoMZxYQnLyiAMLMwBLHYQrESo6vs7VQ6MhsASwmra5YDt0og+/r/yofGmKxkSMcFJMnx1UWAgyDVypp0JZz+rC+xHSKKkZH9KRkozgh5Wfy2VQov3/E3711Y1iwsWpluktNK4cX98EGRnz6qq6KEOGBQY7bQNedvuYplQQFrtAJC5nZmDAQKyuzTWLxxmuCxCMref5xpm+Y8WU4Ocist3DazZyffCesWGITTa3u5uRZqNGRAvpIZgVx6BrgWxgIn9yAY8BHkqT8W3wkpIPVuzae8R2Uf/gLdOW0nnS1Tm9OhfSYXdMVDyOrnLp7DbOwVSU1DUwfZyweQlLsah0+7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPZPsjVK4KkE82rZlmw4T95v9YAmy+iU2EebdwQloo0=;
 b=U6OnNQL/klC/mlp9PrUNuncdRgFXyMmLGTK9MaPbmHLrod3CvvpP+Exvg5BLOb0Zd/AmyjNb9/RrRe+QAftGr2n2D54Q95w6bhsUfNsaHqbatd/cJpVFbexaXg4uQlLJp30CJX0Bu8Jw1kYyfCrmSls3UjjncRhZ++wMpQa1Z68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB3039.eurprd04.prod.outlook.com (2603:10a6:802:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 08:39:19 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5438.023; Fri, 29 Jul 2022
 08:39:19 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] media: amphion: decoder add support for contiguous planes
Date:   Fri, 29 Jul 2022 16:38:14 +0800
Message-Id: <2d0cac861e771a0c5f30c00f0159b7387a623407.1659082839.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659082839.git.ming.qian@nxp.com>
References: <cover.1659082839.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cc9e1c8-7cc0-4bf4-cd55-08da713dd3e5
X-MS-TrafficTypeDiagnostic: VI1PR04MB3039:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HD1tiQLgVCawHmDzmJj1kvPX5P3nwcU+PrE8EQfPcRKBFF/mUFWZanl7IKIUJh1+oMcRxcbjMnq+yMsZpBdbQ/mvV90+hDJxtJ05rgzHwnczijHFW5pa7rh8H5WS1RaQh0EqGOIKlTOLk4H6XcI8ngLu8TIbAHDM33PSjQOWWkRPNGYHhSAg8memsBWLZi8AnPj0I99CgFAVr16PHjgkVbbAh85h19Hqt4oc7ugtXeR5UqjWjWvBlBAjhsxAa1r5XmToFFQCHMhGlYq2wnvwCp8rHGnkUiIVLdpC6PViEVgQXitsOOTKvW9CYtDw98HeU0kU709vcxEykhP1EQl3jkihnzRcoMYur9x104Pv7UX+sW1+PkfQatjAtHBh8LX0dvrk6wCuSnXHIAw4yXG7vlqgZvWyhYVn2ffsS0QTGXzDUy0dCkjZHCWFz0Blwf7fark3XuOT9xrQgrivSQzX+Wca9j/Gq9t/QrISC0rGpu7T1B4czsmNQ7O1XTjPKmWXu/aQ7B0PiP8TklyczkzWrqJWzs8WAevfK8DDYjyw1CQEodW/P4ViF3XIytDoYchc9djVxS1covl3vC4LLFbcbWPMR+iN7AKT9eFLJUP/0PgOOI6qOwBgrxTwxMhwp3lxv9p3TtafladQWoX/rGEJIWix3+BC8NmVNmlc5Tq4boP4mos8iai2XK55o+KqrquCD/6pg9lfFOl1STyfSRZoe5tmaYH4n3MqPn4tY/T+w2W4vV4fuy7Z6k3CrwHi7cJ7JS6OE/S0uw/P98NFvoJp8MrQTjeW2Skc2qB15Gq+sI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(8676002)(5660300002)(52116002)(316002)(26005)(44832011)(8936002)(2906002)(7416002)(66556008)(4326008)(66946007)(36756003)(66476007)(86362001)(6512007)(6506007)(6666004)(186003)(41300700001)(2616005)(6486002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TY1frztoe0truGV2pfX3j8P+M4pvs7ZFpjWft72JZ3mAJkGcGuH/9tQ0DsO/?=
 =?us-ascii?Q?SG4JgRQeDAmdS+2UPcuQ2cXIZfvEgOAoycgQ18VeZs1BD0PbVhjrtd+C88Ch?=
 =?us-ascii?Q?PTnFM+DRHx+COrE/HTUXmZEGZHmaZzMfS6kdK6zvLKO6i1pthha/pykYBDy9?=
 =?us-ascii?Q?97INKx69M4h6jiZdqcbJ80YoPspUH7EKbLSr+xbJUXbGfOrtsUY/NVFGLoSs?=
 =?us-ascii?Q?lUk+Ic9ePM6rMAlr/AiGSmId+iPMQk7875zERMvrmtdZDxcaN5k0pfN7dppb?=
 =?us-ascii?Q?cVD2xog3mJJ4mZPGiT0dJKiQbBJthG5H3jaueUa2TuuGbYPPh8OlRgZuY9KA?=
 =?us-ascii?Q?K95rjqPmzvCwVtRbCv5XkJ8SQ3K6GThswjrAHCp+fjDq75JhdRH9nxUGbwJ5?=
 =?us-ascii?Q?DZUVJ5Rgs0TqD7qIlIHz79TFLwKTA3uI1AznrU6d550mu9FiZBLAVUlwPnAa?=
 =?us-ascii?Q?R1nTI4MPp/xGksyuEBlh3PmueCBZdgdYBBekmRMA+1B8H5xaZo63U9ewm0Cc?=
 =?us-ascii?Q?Y/9lLXThjFXxJK12Sd9ob7d7J+Lsn+GZG25mALedyFpwJSjm/vPO3FP4yQzK?=
 =?us-ascii?Q?UCHxcWDReqKPK2zuugJclyA+gFk5ryMlWqjIgfbrBxvV3TqRQQhKwGqVglNF?=
 =?us-ascii?Q?U14YXsw+XSI/6Tt9dvJvSFH9uz48O1WGfqs6ixab9GuU/NDBLUz0u/awpOx9?=
 =?us-ascii?Q?njs+v7MC+QAozD43jiwijvJQvlIs/ykliw9KKvS4G7SJ9aJq4j+LN4f2XcYG?=
 =?us-ascii?Q?mZYNsxvmZ8OqGVZDSJ05o4LYmpD63TGofHD1YGGecaEZqycrV6gS6CZfgvr8?=
 =?us-ascii?Q?Wfn8bDkxz1ZxWbcW8o3e4OAaRLCSG3WxFTGLRiSokDz+P4ig7kF/0a2uwPi1?=
 =?us-ascii?Q?IYZTJ5MJslOQ7pjqQVzhq287zd2DrT9D7nEP0cLzqjJpjgV9hjPAigR0UY6u?=
 =?us-ascii?Q?fTZqW/YfwSAj0Oqv/awmbRW3JD/+YHds7UZxvd34avJ35gKwFDn3GqVQg96S?=
 =?us-ascii?Q?dld8zHmC+h0gT0DZ8Sl2pID1Ms1q39Fjns+SYVyrgs1ddLx3zh0DI9hzGCEq?=
 =?us-ascii?Q?LmODhD+OE29/BXDF39UuLp5W0p1KBW1w+EzBo11ukGgdawSgQqtD/Cf0npDG?=
 =?us-ascii?Q?dRPtai6P0QiYRUfNWPYTzCY+IPRfD3l3lfDZD6wnHU3wrbFz900rz0EyA9TO?=
 =?us-ascii?Q?MukDOoA/rVuW6DzSqI/pud5VHmP6vVlRhF3i7PKiKvAhSKYlcUCnZlAIFtsg?=
 =?us-ascii?Q?9rYSKe+MbdljFM9NMvIonmWg8MMLEoTdydNUnu+RlPS8yxnOd8TNlrAZZcEc?=
 =?us-ascii?Q?MZLnG8ebLsz4ftq+jejHsYnz574TRryVLyc4NgNG7o1WTEKJseTljLHlbws+?=
 =?us-ascii?Q?78uSElxlZBoZvqE3Pryw0hlbtwrZpasEP7enRTdFkf/sG8/hl2sP/s3fF6GK?=
 =?us-ascii?Q?UMT3gOFB8AOX0gXyfv19oQDG9Cfb+hN05xLoMn84aoowR6YJtkgLMj2ouecR?=
 =?us-ascii?Q?2a1+Y7jzTRhJCDKaDi6e2bjbAXQYjMOogGAlEyPFepbVQZwCu/M71IJmQ3ih?=
 =?us-ascii?Q?5Sotj6ZX5FihYVxXDxaWG2CSPq1kx7LFIk9/0OXK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc9e1c8-7cc0-4bf4-cd55-08da713dd3e5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:39:19.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9NIPhHI+RV2P0iC1PhHXHiswTxnQDZJg4uZtGYQFsfHtLCgnR1L6tKmjW9nq5aSyf3zxRkz1xgkaydHpm1qlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
2.36.1

