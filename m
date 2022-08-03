Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A899D5885C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiHCC2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiHCC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:28:48 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F41CFE5;
        Tue,  2 Aug 2022 19:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHii/pI4QuIwKRAmgKvMS2XWPDKV/lYt+QGxHZuKOJCk1zVkrAlWVsTF9Ji5x6dFi2yGgC0sq4yY3va9i3LAOKg8ZZsoX+EeBhyhU19sC3Xq4Svk+E+xuIlvsyWerlYvcB6ZXVDOdk24y8PPwsIT8CXvQaplsoM98e/2l0yqQVJ0v1pLYYyg9E9s4Y9v24Y7HzcZgWF1xJELHv7yHDV0GnxakM6e79iAzapOS5fM5MkxqFeshlPzOE/HCia1fvLwfS1aPAClt41asGWNmxz+WTwZFoiHO8ThVgAUIljTEC98SS2RmHEOJewZ2PpL/3xswlfijU+0B/qxje3Ja0O9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQs9NbHO7GD060VBKLV+6+Ue9SBGZ/5cITKeZu9Et6g=;
 b=e4kC/280p7keqxFtwTNbg2zgiyloe1j2qSvUr2FV+BlRPUL/+cuaNeJBY7lUMeobPerdzITgZHPS0u6tc6m8CcTeMlwDDUy+JXtqEqn2Cu9AIdrb56iMUpegqwBJ4nja0xW8f+FXRshPeJpWJV0u5QplZuosjTSEX/uaVNXUbnvYMG3LhjT8ZzpgBNEtUtuv6GwgSyrhc0PdAc2tVjj93QJjKRmWaj5WaGe++pcBx4Zix56gqY78cF/Dr1gam+ZZVUBrbLHE5aHc/OMxIAJ/71F+NsUU8rHTYPpolWFm7THcDA3t9pOJLFRFgowq0JDDEshosuJaSiP5R8CYXUMMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQs9NbHO7GD060VBKLV+6+Ue9SBGZ/5cITKeZu9Et6g=;
 b=R9YHqZj/25GNZcFLIdQhJFDXwOzynwfUoXXkk8JZf1mk4tdGkUDgnxjV0gCMckUhuUM5G1dfHrMKvXyCnOIes9bJrmD5pnWawizVhVw6m6nGp62yMDyroppVMlicQZ2Zw8YwcC9OUWa4ZzU3ajwYmR2uY8f/bpVrdurEWfTPIcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR04MB3077.eurprd04.prod.outlook.com (2603:10a6:6:8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.13; Wed, 3 Aug 2022 02:28:41 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 02:28:41 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] media: amphion: tell and handle contiguous and non contiguous format
Date:   Wed,  3 Aug 2022 10:27:20 +0800
Message-Id: <7a17be1ed3bcb703a14f3d67b9fc547ead63a58b.1659493105.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659493105.git.ming.qian@nxp.com>
References: <cover.1659493105.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb596a40-2096-40f0-e8fd-08da74f7e145
X-MS-TrafficTypeDiagnostic: DB6PR04MB3077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRYk2iLUBkTHVc6hvRJO/VAElHPqGrfTa56CtcfKOam2wLyxkPzhF4EBDGDIO398vESweXxnxKZZ8BodHvVJ3lWnDnP24X9/I9206dgJQMl/vQvMR4P80Rn0KpI76/YvS2yfmBrg+DpRGJ5pfdQlvNbohtOyAH3j+pEMhPNmeiw1E+RpAEFtdKMfvhgZoHlZ41OKY2/4UpnzH71MuRcG+jqaHidR5bdRpNEhJSnyGOgfzi/55vLhYJ/8zc0ZmxZLiJrV3URa5wPAaFAPZS3uQ9gkSqNmXGdUv0ZBQXf+WjDmMHPB0cbOjEHwUX4mvl67AuVYsD7ZCze9f2raepWKc7QWsLy+9CFqZHTFFO0TILRfTeGLe+T7ryDTHZlFLhh3PkJjUb/cUESPPD1iQTPriYYG1q1H8Juz+OrErwVfxtllPb4Pi2viqT/6H46DB+sYWK9+JhuCZo2TPTaAu/dYxAVCrVHN/Etkstb7zOP0li6Iu/Ejy6l6N9We/3+UG68USCxBPLukbfdAva+ndzivQucyQkT2Zix/umDv4OqEVCVrbbX9+i2A3NyVw7/wFM0vqCaiYht6JoI9TeqbYPVoGxQgS83k2JHB/xevAmVBlRl3iDCmcJSfopDhweyeL4YcOI+1YeImGlEwp4Q/VKdgjjte4n/qOTrP2IAd9Q4CAhu4xh32w3hV/s8ar0KDbqeSeIgY9/tbGWDIAYQSKvEIa3/wX4cvzny/Vl8lBW+KF06E0tW9r9aJiOmpqdmlRcYSfZEjMOH5apIfrImTibBbdgZMTGsJ4xX1qo/zpTXl7eU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(44832011)(5660300002)(30864003)(8676002)(4326008)(66476007)(66556008)(66946007)(8936002)(7416002)(2906002)(83380400001)(36756003)(86362001)(38100700002)(6486002)(478600001)(41300700001)(38350700002)(316002)(186003)(2616005)(26005)(6666004)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8OwtkPEaoHN4IVZUebEeiD2Y2m02aBaQFRhXboqcFUgSV1VBcBCB9ruMnNHO?=
 =?us-ascii?Q?/9OJl5RqJ1WXLnL4qo///Bjo2vkVVsbjkjiIrYtqEu+NGGqDIyfj4OTjJ8nJ?=
 =?us-ascii?Q?67gjMZlgD1ZJPyjO7fS8lxW3g49hzVvrprTbt/tNt722vt9/EDFz1UjxFyEp?=
 =?us-ascii?Q?DvV3xhgh7Znusmzl+LBoGn6F3Aq6WBgRyMPsZ1LWsSoaWE4FG2MOAl64sKnb?=
 =?us-ascii?Q?9H/FLMku16RePzMpdV4wm6fA//5aRKxrJqq/88H/hzo4iDUiFmW6Li7BSzj1?=
 =?us-ascii?Q?qTWcvVPyRouf4uU33yNxzs240+ZbK1b7VeCeWmYUHWt/cnC+jpPx56oUaCoA?=
 =?us-ascii?Q?+osVVxMaEWm92r8Kn5jua7KNTR9lBK3rQcLcwBYR8GZD9cRdnqRj2q9p9wLd?=
 =?us-ascii?Q?22vk5OirW2ZMihlMf+iUWtbqj1X5zW6RKa9a11mq9wYuNtDo+46MisTm5g71?=
 =?us-ascii?Q?6BKZF0RxGFBAYzbt2Q77C64RRpJVVx0ifDsEiylcsLxwHHltB28nWApTh2zd?=
 =?us-ascii?Q?ZD2ZJ1FJNgnqopVGGrWkeoKiClsEj9Y1QUSO1CSfTRV7getTvK01n8A+3kOt?=
 =?us-ascii?Q?ZfCI4ha8e4vtj3W972f0I9DS/+M7p0LU9LF/b8n9kUiDrdFyMvDWqmP8pA39?=
 =?us-ascii?Q?PmmaHXEr98K4FTRv2hXRwXhXqC1L5mhGF+yb6UB2TQ4FM+/CDkz3G8huP6+2?=
 =?us-ascii?Q?WTXQR9PMnq85sswR46LmzNuXfPAOkjJYwzayTCTA9XjfPCOGMz+GDRZgk4Tx?=
 =?us-ascii?Q?jOGztX77LtC778iPkx7FtXlXBbJuj1JVoUikOzbGh8Q/TofXDwJRGBdUKsUj?=
 =?us-ascii?Q?PLIADq9dRqyMMgNqw8lRbOikNw/baL/O6af7w/yjhAIwTI4Q3mMPKxyF3gxX?=
 =?us-ascii?Q?uKRCBSPijE6JLZnzCq0EmDtNM/gVFkZmeid4NTR5/JAkCEbwB+FbKlJt4bbX?=
 =?us-ascii?Q?UQa17Mio9wUuByGWWOtp5/Hadopup8h1iWXeIlffUG4qUFf5uUZvsueWU45I?=
 =?us-ascii?Q?Ose0O3DLdWsUjigvhsdCmzCB4Tf1Hg8fS/gs0TEetf49sI1qtzLQ9WFSfgTo?=
 =?us-ascii?Q?tuxoqwj0MzU66UKANDwcEVsdClHhBcgvzGexyssNzUO3Q6XG7eh2p6zojqOC?=
 =?us-ascii?Q?RxsZIeRd18EtDPg4TgtryBd7tdop/OFZc1TNCGtiY2W056lXPeIoz0YhoXlV?=
 =?us-ascii?Q?lv7Fvk7dwMxtsHIyc6dz+ZrANOXmPnwoJQT2xFgo+Rbo9bTZnLYlseUrMx0d?=
 =?us-ascii?Q?CoY6Ez5L5ltsHxYMXQ17vayUmi1PsaqfQSdx46su4C8DpnJLGX5uNm8lyiaz?=
 =?us-ascii?Q?r+d3ACHjwsykWUaxKkaQr2HH6LZDkyR/3V6O+xtiU+KUXKm/lBKQ+TkjvHlB?=
 =?us-ascii?Q?10gvxqtMI1UNzu/Do0hzZrfTvJS7BcxH507bYR6SLCPj2mI51pxTIax7UIS+?=
 =?us-ascii?Q?W++zy6z7C8Q0TTjgYFDDsshkMTltCTxyXNwevLexy7P0qqm+QpbXV+lYBM8U?=
 =?us-ascii?Q?tVZPfWf0ITFpfBdRI0EB+XsgtS/tC+zUWbqGgC5o+Ahud72bzxjA1i9jYCij?=
 =?us-ascii?Q?BTRYplUkwJKwdQYyIdtRK55lQKxCm/jn7M032job?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb596a40-2096-40f0-e8fd-08da74f7e145
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 02:28:41.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGNuUwq28lf2QizzbZEE/7Kv/2xLF9d0/CjxNqoxMcLqS5+mJHCNrhs99CheAqOXNOcTdSUVfTlz7n9E8UDH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver should tell the number of memory planes and component planes.
the amphion vpu support non contiguous planes,
but for compatibility with other device
that only support contiguous planes.
driver can add support for contiguous planes in the same time.
Then the mem_planes can be different from the comp_planes.
driver need to handle buffer according mem_planes and comp_planes.

So driver can support NV12 and NV12M.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c        | 187 ++++++++++---------
 drivers/media/platform/amphion/venc.c        |  33 ++--
 drivers/media/platform/amphion/vpu.h         |   4 +-
 drivers/media/platform/amphion/vpu_dbg.c     |   8 +-
 drivers/media/platform/amphion/vpu_helpers.c |  48 ++++-
 drivers/media/platform/amphion/vpu_helpers.h |   2 +
 drivers/media/platform/amphion/vpu_malone.c  |   3 +-
 drivers/media/platform/amphion/vpu_v4l2.c    | 157 ++++++++++++----
 drivers/media/platform/amphion/vpu_v4l2.h    |   3 +-
 drivers/media/platform/amphion/vpu_windsor.c |   8 +-
 10 files changed, 290 insertions(+), 163 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index feb75dc204de..48ab664fa7ef 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -69,72 +69,85 @@ struct vdec_t {
 static const struct vpu_format vdec_formats[] = {
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_8L128,
-		.num_planes = 2,
+		.mem_planes = 2,
+		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
-		.num_planes = 2,
+		.mem_planes = 2,
+		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264_MVC,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_HEVC,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_MPEG2,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_MPEG4,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_XVID,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_VP8,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H263,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
-		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION | V4L2_FMT_FLAG_COMPRESSED
 	},
 	{0, 0, 0, 0},
 };
@@ -256,23 +269,22 @@ static int vdec_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 	int ret = -EINVAL;
 
 	vpu_inst_lock(inst);
-	if (!V4L2_TYPE_IS_OUTPUT(f->type) && vdec->fixed_fmt) {
-		if (f->index == 0) {
-			f->pixelformat = inst->cap_format.pixfmt;
-			f->flags = inst->cap_format.flags;
-			ret = 0;
-		}
+	if (V4L2_TYPE_IS_CAPTURE(f->type) && vdec->fixed_fmt) {
+		fmt = vpu_get_format(inst, f->type);
+		if (f->index == 1)
+			fmt = vpu_helper_find_sibling(inst, f->type, fmt->pixfmt);
+		if (f->index > 1)
+			fmt = NULL;
 	} else {
 		fmt = vpu_helper_enum_format(inst, f->type, f->index);
-		memset(f->reserved, 0, sizeof(f->reserved));
-		if (!fmt)
-			goto exit;
-
-		f->pixelformat = fmt->pixfmt;
-		f->flags = fmt->flags;
-		ret = 0;
 	}
+	if (!fmt)
+		goto exit;
 
+	memset(f->reserved, 0, sizeof(f->reserved));
+	f->pixelformat = fmt->pixfmt;
+	f->flags = fmt->flags;
+	ret = 0;
 exit:
 	vpu_inst_unlock(inst);
 	return ret;
@@ -289,14 +301,14 @@ static int vdec_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	cur_fmt = vpu_get_format(inst, f->type);
 
 	pixmp->pixelformat = cur_fmt->pixfmt;
-	pixmp->num_planes = cur_fmt->num_planes;
+	pixmp->num_planes = cur_fmt->mem_planes;
 	pixmp->width = cur_fmt->width;
 	pixmp->height = cur_fmt->height;
 	pixmp->field = cur_fmt->field;
 	pixmp->flags = cur_fmt->flags;
 	for (i = 0; i < pixmp->num_planes; i++) {
 		pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
-		pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+		pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(cur_fmt, i);
 	}
 
 	f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
@@ -311,10 +323,19 @@ static int vdec_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct vdec_t *vdec = inst->priv;
-
-	vpu_try_fmt_common(inst, f);
+	struct vpu_format fmt;
 
 	vpu_inst_lock(inst);
+	if (V4L2_TYPE_IS_CAPTURE(f->type) && vdec->fixed_fmt) {
+		struct vpu_format *cap_fmt = vpu_get_format(inst, f->type);
+
+		if (!vpu_helper_match_format(inst, cap_fmt->type, cap_fmt->pixfmt,
+					     f->fmt.pix_mp.pixelformat))
+			f->fmt.pix_mp.pixelformat = cap_fmt->pixfmt;
+	}
+
+	vpu_try_fmt_common(inst, f, &fmt);
+
 	if (vdec->fixed_fmt) {
 		f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
 		f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
@@ -334,7 +355,7 @@ static int vdec_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 static int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
-	const struct vpu_format *fmt;
+	struct vpu_format fmt;
 	struct vpu_format *cur_fmt;
 	struct vb2_queue *q;
 	struct vdec_t *vdec = inst->priv;
@@ -349,36 +370,30 @@ static int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
 	if (vb2_is_busy(q))
 		return -EBUSY;
 
-	fmt = vpu_try_fmt_common(inst, f);
-	if (!fmt)
+	if (vpu_try_fmt_common(inst, f, &fmt))
 		return -EINVAL;
 
 	cur_fmt = vpu_get_format(inst, f->type);
 	if (V4L2_TYPE_IS_OUTPUT(f->type) && inst->state != VPU_CODEC_STATE_DEINIT) {
-		if (cur_fmt->pixfmt != fmt->pixfmt) {
+		if (cur_fmt->pixfmt != fmt.pixfmt) {
 			vdec->reset_codec = true;
 			vdec->fixed_fmt = false;
 		}
 	}
-	cur_fmt->pixfmt = fmt->pixfmt;
 	if (V4L2_TYPE_IS_OUTPUT(f->type) || !vdec->fixed_fmt) {
-		cur_fmt->num_planes = fmt->num_planes;
-		cur_fmt->flags = fmt->flags;
-		cur_fmt->width = pixmp->width;
-		cur_fmt->height = pixmp->height;
-		for (i = 0; i < fmt->num_planes; i++) {
-			cur_fmt->sizeimage[i] = pixmp->plane_fmt[i].sizeimage;
-			cur_fmt->bytesperline[i] = pixmp->plane_fmt[i].bytesperline;
-		}
-		if (pixmp->field != V4L2_FIELD_ANY)
-			cur_fmt->field = pixmp->field;
+		memcpy(cur_fmt, &fmt, sizeof(*cur_fmt));
 	} else {
-		pixmp->num_planes = cur_fmt->num_planes;
+		if (vpu_helper_match_format(inst, f->type, cur_fmt->pixfmt, pixmp->pixelformat)) {
+			cur_fmt->pixfmt = fmt.pixfmt;
+			cur_fmt->mem_planes = fmt.mem_planes;
+		}
+		pixmp->pixelformat = cur_fmt->pixfmt;
+		pixmp->num_planes = cur_fmt->mem_planes;
 		pixmp->width = cur_fmt->width;
 		pixmp->height = cur_fmt->height;
 		for (i = 0; i < pixmp->num_planes; i++) {
 			pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
-			pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+			pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(cur_fmt, i);
 		}
 		pixmp->field = cur_fmt->field;
 	}
@@ -678,9 +693,11 @@ static struct vpu_vb2_buffer *vdec_find_buffer(struct vpu_inst *inst, u32 luma)
 static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 {
 	struct vdec_t *vdec = inst->priv;
+	struct vpu_format *cur_fmt;
 	struct vpu_vb2_buffer *vpu_buf;
 	struct vb2_v4l2_buffer *vbuf;
 	u32 sequence;
+	int i;
 
 	if (!frame)
 		return;
@@ -699,6 +716,7 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 		return;
 	}
 
+	cur_fmt = vpu_get_format(inst, inst->cap_format.type);
 	vbuf = &vpu_buf->m2m_buf.vb;
 	if (vbuf->vb2_buf.index != frame->id)
 		dev_err(inst->dev, "[%d] buffer id(%d, %d) dismatch\n",
@@ -707,9 +725,9 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 	if (vpu_get_buffer_state(vbuf) != VPU_BUF_STATE_DECODED)
 		dev_err(inst->dev, "[%d] buffer(%d) ready without decoded\n", inst->id, frame->id);
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
-	vb2_set_plane_payload(&vbuf->vb2_buf, 0, inst->cap_format.sizeimage[0]);
-	vb2_set_plane_payload(&vbuf->vb2_buf, 1, inst->cap_format.sizeimage[1]);
-	vbuf->field = inst->cap_format.field;
+	for (i = 0; i < vbuf->vb2_buf.num_planes; i++)
+		vb2_set_plane_payload(&vbuf->vb2_buf, i, vpu_get_fmt_plane_size(cur_fmt, i));
+	vbuf->field = cur_fmt->field;
 	vbuf->sequence = sequence;
 	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 
@@ -747,15 +765,17 @@ static void vdec_stop_done(struct vpu_inst *inst)
 static bool vdec_check_source_change(struct vpu_inst *inst)
 {
 	struct vdec_t *vdec = inst->priv;
-	const struct vpu_format *fmt;
-	int i;
+	const struct vpu_format *sibling;
 
 	if (!inst->fh.m2m_ctx)
 		return false;
 
+	sibling = vpu_helper_find_sibling(inst, inst->cap_format.type, inst->cap_format.pixfmt);
+	if (sibling && vdec->codec_info.pixfmt == sibling->pixfmt)
+		vdec->codec_info.pixfmt = inst->cap_format.pixfmt;
+
 	if (!vb2_is_streaming(v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx)))
 		return true;
-	fmt = vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec_info.pixfmt);
 	if (inst->cap_format.pixfmt != vdec->codec_info.pixfmt)
 		return true;
 	if (inst->cap_format.width != vdec->codec_info.decoded_width)
@@ -772,14 +792,6 @@ static bool vdec_check_source_change(struct vpu_inst *inst)
 		return true;
 	if (inst->crop.height != vdec->codec_info.height)
 		return true;
-	if (fmt && inst->cap_format.num_planes != fmt->num_planes)
-		return true;
-	for (i = 0; i < inst->cap_format.num_planes; i++) {
-		if (inst->cap_format.bytesperline[i] != vdec->codec_info.bytesperline[i])
-			return true;
-		if (inst->cap_format.sizeimage[i] != vdec->codec_info.sizeimage[i])
-			return true;
-	}
 
 	return false;
 }
@@ -787,27 +799,21 @@ static bool vdec_check_source_change(struct vpu_inst *inst)
 static void vdec_init_fmt(struct vpu_inst *inst)
 {
 	struct vdec_t *vdec = inst->priv;
-	const struct vpu_format *fmt;
-	int i;
+	struct v4l2_format f;
 
-	fmt = vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec_info.pixfmt);
-	inst->out_format.width = vdec->codec_info.width;
-	inst->out_format.height = vdec->codec_info.height;
-	inst->cap_format.width = vdec->codec_info.decoded_width;
-	inst->cap_format.height = vdec->codec_info.decoded_height;
-	inst->cap_format.pixfmt = vdec->codec_info.pixfmt;
-	if (fmt) {
-		inst->cap_format.num_planes = fmt->num_planes;
-		inst->cap_format.flags = fmt->flags;
-	}
-	for (i = 0; i < inst->cap_format.num_planes; i++) {
-		inst->cap_format.bytesperline[i] = vdec->codec_info.bytesperline[i];
-		inst->cap_format.sizeimage[i] = vdec->codec_info.sizeimage[i];
-	}
+	memset(&f, 0, sizeof(f));
+	f.type = inst->cap_format.type;
+	f.fmt.pix_mp.pixelformat = vdec->codec_info.pixfmt;
+	f.fmt.pix_mp.width = vdec->codec_info.decoded_width;
+	f.fmt.pix_mp.height = vdec->codec_info.decoded_height;
 	if (vdec->codec_info.progressive)
-		inst->cap_format.field = V4L2_FIELD_NONE;
+		f.fmt.pix_mp.field = V4L2_FIELD_NONE;
 	else
-		inst->cap_format.field = V4L2_FIELD_SEQ_TB;
+		f.fmt.pix_mp.field = V4L2_FIELD_SEQ_TB;
+	vpu_try_fmt_common(inst, &f, &inst->cap_format);
+
+	inst->out_format.width = vdec->codec_info.width;
+	inst->out_format.height = vdec->codec_info.height;
 }
 
 static void vdec_init_crop(struct vpu_inst *inst)
@@ -966,7 +972,10 @@ static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vb
 	info.tag = vdec->seq_tag;
 	info.luma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 0);
 	info.luma_size = inst->cap_format.sizeimage[0];
-	info.chroma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
+	if (vbuf->vb2_buf.num_planes > 1)
+		info.chroma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
+	else
+		info.chroma_addr = info.luma_addr + info.luma_size;
 	info.chromau_size = inst->cap_format.sizeimage[1];
 	info.bytesperline = inst->cap_format.bytesperline[0];
 	ret = vpu_session_alloc_fs(inst, &info);
@@ -975,7 +984,7 @@ static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vb
 
 	vpu_buf->tag = info.tag;
 	vpu_buf->luma = info.luma_addr;
-	vpu_buf->chroma_u = info.chromau_size;
+	vpu_buf->chroma_u = info.chroma_addr;
 	vpu_buf->chroma_v = 0;
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
 	vdec->slots[info.id] = vpu_buf;
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 37212f087fdd..060a1ee78b17 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -69,13 +69,16 @@ struct venc_frame_t {
 static const struct vpu_format venc_formats[] = {
 	{
 		.pixfmt = V4L2_PIX_FMT_NV12M,
-		.num_planes = 2,
+		.mem_planes = 2,
+		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-		.num_planes = 1,
+		.mem_planes = 1,
+		.comp_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.flags = V4L2_FMT_FLAG_COMPRESSED
 	},
 	{0, 0, 0, 0},
 };
@@ -173,14 +176,14 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	cur_fmt = vpu_get_format(inst, f->type);
 
 	pixmp->pixelformat = cur_fmt->pixfmt;
-	pixmp->num_planes = cur_fmt->num_planes;
+	pixmp->num_planes = cur_fmt->mem_planes;
 	pixmp->width = cur_fmt->width;
 	pixmp->height = cur_fmt->height;
 	pixmp->field = cur_fmt->field;
 	pixmp->flags = cur_fmt->flags;
 	for (i = 0; i < pixmp->num_planes; i++) {
 		pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
-		pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+		pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(cur_fmt, i);
 	}
 
 	f->fmt.pix_mp.colorspace = venc->params.color.primaries;
@@ -194,8 +197,9 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 static int venc_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_inst *inst = to_inst(file);
+	struct vpu_format fmt;
 
-	vpu_try_fmt_common(inst, f);
+	vpu_try_fmt_common(inst, f, &fmt);
 
 	return 0;
 }
@@ -203,12 +207,11 @@ static int venc_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_inst *inst = to_inst(file);
-	const struct vpu_format *fmt;
+	struct vpu_format fmt;
 	struct vpu_format *cur_fmt;
 	struct vb2_queue *q;
 	struct venc_t *venc = inst->priv;
 	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
-	int i;
 
 	q = v4l2_m2m_get_vq(inst->fh.m2m_ctx, f->type);
 	if (!q)
@@ -216,24 +219,12 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	if (vb2_is_busy(q))
 		return -EBUSY;
 
-	fmt = vpu_try_fmt_common(inst, f);
-	if (!fmt)
+	if (vpu_try_fmt_common(inst, f, &fmt))
 		return -EINVAL;
 
 	cur_fmt = vpu_get_format(inst, f->type);
 
-	cur_fmt->pixfmt = fmt->pixfmt;
-	cur_fmt->num_planes = fmt->num_planes;
-	cur_fmt->flags = fmt->flags;
-	cur_fmt->width = pix_mp->width;
-	cur_fmt->height = pix_mp->height;
-	for (i = 0; i < fmt->num_planes; i++) {
-		cur_fmt->sizeimage[i] = pix_mp->plane_fmt[i].sizeimage;
-		cur_fmt->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
-	}
-
-	if (pix_mp->field != V4L2_FIELD_ANY)
-		cur_fmt->field = pix_mp->field;
+	memcpy(cur_fmt, &fmt, sizeof(*cur_fmt));
 
 	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
 		venc->params.input_format = cur_fmt->pixfmt;
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index f914de6ed81e..998591fa5b85 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -84,7 +84,8 @@ struct vpu_dev {
 
 struct vpu_format {
 	u32 pixfmt;
-	unsigned int num_planes;
+	u32 mem_planes;
+	u32 comp_planes;
 	u32 type;
 	u32 flags;
 	u32 width;
@@ -92,6 +93,7 @@ struct vpu_format {
 	u32 sizeimage[VIDEO_MAX_PLANES];
 	u32 bytesperline[VIDEO_MAX_PLANES];
 	u32 field;
+	u32 sibling;
 };
 
 struct vpu_core_resources {
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index f72c8a506b22..c41c9896912c 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -89,9 +89,9 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 			vq->last_buffer_dequeued);
 	if (seq_write(s, str, num))
 		return 0;
-	for (i = 0; i < inst->out_format.num_planes; i++) {
+	for (i = 0; i < inst->out_format.mem_planes; i++) {
 		num = scnprintf(str, sizeof(str), " %d(%d)",
-				inst->out_format.sizeimage[i],
+				vpu_get_fmt_plane_size(&inst->out_format, i),
 				inst->out_format.bytesperline[i]);
 		if (seq_write(s, str, num))
 			return 0;
@@ -113,9 +113,9 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 			vq->last_buffer_dequeued);
 	if (seq_write(s, str, num))
 		return 0;
-	for (i = 0; i < inst->cap_format.num_planes; i++) {
+	for (i = 0; i < inst->cap_format.mem_planes; i++) {
 		num = scnprintf(str, sizeof(str), " %d(%d)",
-				inst->cap_format.sizeimage[i],
+				vpu_get_fmt_plane_size(&inst->cap_format, i),
 				inst->cap_format.bytesperline[i]);
 		if (seq_write(s, str, num))
 			return 0;
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
index e9aeb3453dfc..db8f471b9187 100644
--- a/drivers/media/platform/amphion/vpu_helpers.c
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -59,6 +59,39 @@ const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type,
 	return NULL;
 }
 
+const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst *inst, u32 type, u32 pixelfmt)
+{
+	const struct vpu_format *fmt;
+	const struct vpu_format *sibling;
+
+	fmt = vpu_helper_find_format(inst, type, pixelfmt);
+	if (!fmt)
+		return NULL;
+	if (!fmt->sibling)
+		return NULL;
+	sibling = vpu_helper_find_format(inst, type, fmt->sibling);
+	if (!sibling)
+		return NULL;
+	if (sibling->sibling != fmt->pixfmt)
+		return NULL;
+	if (sibling->comp_planes != fmt->comp_planes)
+		return NULL;
+	return sibling;
+}
+
+bool vpu_helper_match_format(struct vpu_inst *inst, u32 type, u32 fmta, u32 fmtb)
+{
+	const struct vpu_format *sibling;
+
+	if (fmta == fmtb)
+		return true;
+
+	sibling = vpu_helper_find_sibling(inst, type, fmta);
+	if (sibling && sibling->pixfmt == fmtb)
+		return true;
+	return false;
+}
+
 const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index)
 {
 	const struct vpu_format *pfmt;
@@ -123,9 +156,10 @@ static u32 get_nv12_plane_size(u32 width, u32 height, int plane_no,
 	u32 bytesperline;
 	u32 size = 0;
 
-	bytesperline = ALIGN(width, stride);
+	bytesperline = width;
 	if (pbl)
 		bytesperline = max(bytesperline, *pbl);
+	bytesperline = ALIGN(bytesperline, stride);
 	height = ALIGN(height, 2);
 	if (plane_no == 0)
 		size = bytesperline * height;
@@ -148,13 +182,13 @@ static u32 get_tiled_8l128_plane_size(u32 fmt, u32 width, u32 height, int plane_
 
 	if (interlaced)
 		hs++;
-	if (fmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
+	if (fmt == V4L2_PIX_FMT_NV12M_10BE_8L128 || fmt == V4L2_PIX_FMT_NV12_10BE_8L128)
 		bitdepth = 10;
 	bytesperline = DIV_ROUND_UP(width * bitdepth, BITS_PER_BYTE);
-	bytesperline = ALIGN(bytesperline, 1 << ws);
-	bytesperline = ALIGN(bytesperline, stride);
 	if (pbl)
 		bytesperline = max(bytesperline, *pbl);
+	bytesperline = ALIGN(bytesperline, 1 << ws);
+	bytesperline = ALIGN(bytesperline, stride);
 	height = ALIGN(height, 1 << hs);
 	if (plane_no == 0)
 		size = bytesperline * height;
@@ -172,9 +206,10 @@ static u32 get_default_plane_size(u32 width, u32 height, int plane_no,
 	u32 bytesperline;
 	u32 size = 0;
 
-	bytesperline = ALIGN(width, stride);
+	bytesperline = width;
 	if (pbl)
 		bytesperline = max(bytesperline, *pbl);
+	bytesperline = ALIGN(bytesperline, stride);
 	if (plane_no == 0)
 		size = bytesperline * height;
 	if (pbl)
@@ -187,9 +222,12 @@ u32 vpu_helper_get_plane_size(u32 fmt, u32 w, u32 h, int plane_no,
 			      u32 stride, u32 interlaced, u32 *pbl)
 {
 	switch (fmt) {
+	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV12M:
 		return get_nv12_plane_size(w, h, plane_no, stride, interlaced, pbl);
+	case V4L2_PIX_FMT_NV12_8L128:
 	case V4L2_PIX_FMT_NV12M_8L128:
+	case V4L2_PIX_FMT_NV12_10BE_8L128:
 	case V4L2_PIX_FMT_NV12M_10BE_8L128:
 		return get_tiled_8l128_plane_size(fmt, w, h, plane_no, stride, interlaced, pbl);
 	default:
diff --git a/drivers/media/platform/amphion/vpu_helpers.h b/drivers/media/platform/amphion/vpu_helpers.h
index bc28350958be..0eaddb07190d 100644
--- a/drivers/media/platform/amphion/vpu_helpers.h
+++ b/drivers/media/platform/amphion/vpu_helpers.h
@@ -14,6 +14,8 @@ struct vpu_pair {
 int vpu_helper_find_in_array_u8(const u8 *array, u32 size, u32 x);
 bool vpu_helper_check_type(struct vpu_inst *inst, u32 type);
 const struct vpu_format *vpu_helper_find_format(struct vpu_inst *inst, u32 type, u32 pixelfmt);
+const struct vpu_format *vpu_helper_find_sibling(struct vpu_inst *inst, u32 type, u32 pixelfmt);
+bool vpu_helper_match_format(struct vpu_inst *inst, u32 type, u32 fmta, u32 fmtb);
 const struct vpu_format *vpu_helper_enum_format(struct vpu_inst *inst, u32 type, int index);
 u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width);
 u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height);
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 51e0702f9ae1..69d9a2269fce 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -583,7 +583,8 @@ bool vpu_malone_check_fmt(enum vpu_core_type type, u32 pixelfmt)
 	if (!vpu_imx8q_check_fmt(type, pixelfmt))
 		return false;
 
-	if (pixelfmt == V4L2_PIX_FMT_NV12M_8L128 || pixelfmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
+	if (pixelfmt == V4L2_PIX_FMT_NV12_8L128 || pixelfmt == V4L2_PIX_FMT_NV12_10BE_8L128 ||
+	    pixelfmt == V4L2_PIX_FMT_NV12M_8L128 || pixelfmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
 		return true;
 	if (vpu_malone_format_remap(pixelfmt) == MALONE_FMT_NULL)
 		return false;
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 8a3eed957ae6..7afebc8e0004 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -24,6 +24,8 @@
 #include "vpu_msgs.h"
 #include "vpu_helpers.h"
 
+#define MIN_BUFFER_SIZE		(80 * 1024)
+
 void vpu_inst_lock(struct vpu_inst *inst)
 {
 	mutex_lock(&inst->lock);
@@ -140,51 +142,126 @@ bool vpu_is_source_empty(struct vpu_inst *inst)
 	return true;
 }
 
-const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
+static int vpu_init_format(struct vpu_inst *inst, struct vpu_format *fmt)
+{
+	const struct vpu_format *info;
+
+	info = vpu_helper_find_format(inst, fmt->type, fmt->pixfmt);
+	if (!info) {
+		info = vpu_helper_enum_format(inst, fmt->type, 0);
+		if (!info)
+			return -EINVAL;
+	}
+	memcpy(fmt, info, sizeof(*fmt));
+
+	return 0;
+}
+
+static int vpu_calc_fmt_bytesperline(struct v4l2_format *f, struct vpu_format *fmt)
 {
 	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
-	u32 type = f->type;
-	u32 stride = 1;
-	u32 bytesperline;
-	u32 sizeimage;
-	const struct vpu_format *fmt;
-	const struct vpu_core_resources *res;
 	int i;
 
-	fmt = vpu_helper_find_format(inst, type, pixmp->pixelformat);
-	if (!fmt) {
-		fmt = vpu_helper_enum_format(inst, type, 0);
-		if (!fmt)
-			return NULL;
-		pixmp->pixelformat = fmt->pixfmt;
+	if (pixmp->num_planes == fmt->comp_planes) {
+		for (i = 0; i < fmt->comp_planes; i++)
+			fmt->bytesperline[i] = pixmp->plane_fmt[i].bytesperline;
+		return 0;
 	}
+	if (pixmp->num_planes > 1)
+		return -EINVAL;
+
+	/*amphion vpu only support nv12 and nv12 tiled,
+	 * so the bytesperline of luma and chroma should be same
+	 */
+	for (i = 0; i < fmt->comp_planes; i++)
+		fmt->bytesperline[i] = pixmp->plane_fmt[0].bytesperline;
+
+	return 0;
+}
+
+static int vpu_calc_fmt_sizeimage(struct vpu_inst *inst, struct vpu_format *fmt)
+{
+	u32 stride = 1;
+	const struct vpu_core_resources *res;
+	int i;
 
 	res = vpu_get_resource(inst);
 	if (res)
 		stride = res->stride;
-	if (pixmp->width)
-		pixmp->width = vpu_helper_valid_frame_width(inst, pixmp->width);
-	if (pixmp->height)
-		pixmp->height = vpu_helper_valid_frame_height(inst, pixmp->height);
+
+	for (i = 0; i < fmt->comp_planes; i++) {
+		fmt->sizeimage[i] = vpu_helper_get_plane_size(fmt->pixfmt,
+							      fmt->width,
+							      fmt->height,
+							      i,
+							      stride,
+							      fmt->field != V4L2_FIELD_NONE ? 1 : 0,
+							      &fmt->bytesperline[i]);
+		fmt->sizeimage[i] = max_t(u32, fmt->sizeimage[i], PAGE_SIZE);
+		if (fmt->flags & V4L2_FMT_FLAG_COMPRESSED)
+			fmt->sizeimage[i] = max_t(u32, fmt->sizeimage[i], MIN_BUFFER_SIZE);
+	}
+
+	return 0;
+}
+
+u32 vpu_get_fmt_plane_size(struct vpu_format *fmt, u32 plane_no)
+{
+	u32 size;
+	int i;
+
+	if (plane_no >= fmt->mem_planes)
+		return 0;
+
+	if (fmt->comp_planes == fmt->mem_planes)
+		return fmt->sizeimage[plane_no];
+	if (plane_no < fmt->mem_planes - 1)
+		return fmt->sizeimage[plane_no];
+	size = fmt->sizeimage[plane_no];
+	for (i = fmt->mem_planes; i < fmt->comp_planes; i++)
+		size += fmt->sizeimage[i];
+
+	return size;
+}
+
+int vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f, struct vpu_format *fmt)
+{
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	int i;
+	int ret;
+
+	fmt->pixfmt = pixmp->pixelformat;
+	fmt->type = f->type;
+	ret = vpu_init_format(inst, fmt);
+	if (ret < 0)
+		return ret;
+
+	fmt->width = pixmp->width;
+	fmt->height = pixmp->height;
+	if (fmt->width)
+		fmt->width = vpu_helper_valid_frame_width(inst, fmt->width);
+	if (fmt->height)
+		fmt->height = vpu_helper_valid_frame_height(inst, fmt->height);
+	fmt->field = pixmp->field == V4L2_FIELD_ANY ? V4L2_FIELD_NONE : pixmp->field;
+	vpu_calc_fmt_bytesperline(f, fmt);
+	vpu_calc_fmt_sizeimage(inst, fmt);
+	if (fmt->flags & V4L2_FMT_FLAG_COMPRESSED)
+		fmt->sizeimage[0] = max_t(u32, pixmp->plane_fmt[0].sizeimage, fmt->sizeimage[0]);
+
+	pixmp->pixelformat = fmt->pixfmt;
+	pixmp->width = fmt->width;
+	pixmp->height = fmt->height;
 	pixmp->flags = fmt->flags;
-	pixmp->num_planes = fmt->num_planes;
-	if (pixmp->field == V4L2_FIELD_ANY)
-		pixmp->field = V4L2_FIELD_NONE;
+	pixmp->num_planes = fmt->mem_planes;
+	pixmp->field = fmt->field;
+	memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
 	for (i = 0; i < pixmp->num_planes; i++) {
-		bytesperline = max_t(s32, pixmp->plane_fmt[i].bytesperline, 0);
-		sizeimage = vpu_helper_get_plane_size(pixmp->pixelformat,
-						      pixmp->width,
-						      pixmp->height,
-						      i,
-						      stride,
-						      pixmp->field > V4L2_FIELD_NONE ? 1 : 0,
-						      &bytesperline);
-		sizeimage = max_t(s32, pixmp->plane_fmt[i].sizeimage, sizeimage);
-		pixmp->plane_fmt[i].bytesperline = bytesperline;
-		pixmp->plane_fmt[i].sizeimage = sizeimage;
+		pixmp->plane_fmt[i].bytesperline = fmt->bytesperline[i];
+		pixmp->plane_fmt[i].sizeimage = vpu_get_fmt_plane_size(fmt, i);
+		memset(pixmp->plane_fmt[i].reserved, 0, sizeof(pixmp->plane_fmt[i].reserved));
 	}
 
-	return fmt;
+	return 0;
 }
 
 static bool vpu_check_ready(struct vpu_inst *inst, u32 type)
@@ -389,10 +466,10 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 	cur_fmt = vpu_get_format(inst, vq->type);
 
 	if (*plane_count) {
-		if (*plane_count != cur_fmt->num_planes)
+		if (*plane_count != cur_fmt->mem_planes)
 			return -EINVAL;
-		for (i = 0; i < cur_fmt->num_planes; i++) {
-			if (psize[i] < cur_fmt->sizeimage[i])
+		for (i = 0; i < cur_fmt->mem_planes; i++) {
+			if (psize[i] < vpu_get_fmt_plane_size(cur_fmt, i))
 				return -EINVAL;
 		}
 		return 0;
@@ -402,9 +479,9 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_out);
 	else
 		*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_cap);
-	*plane_count = cur_fmt->num_planes;
-	for (i = 0; i < cur_fmt->num_planes; i++)
-		psize[i] = cur_fmt->sizeimage[i];
+	*plane_count = cur_fmt->mem_planes;
+	for (i = 0; i < cur_fmt->mem_planes; i++)
+		psize[i] = vpu_get_fmt_plane_size(cur_fmt, i);
 
 	return 0;
 }
@@ -434,8 +511,8 @@ static int vpu_vb2_buf_prepare(struct vb2_buffer *vb)
 	u32 i;
 
 	cur_fmt = vpu_get_format(inst, vb->type);
-	for (i = 0; i < cur_fmt->num_planes; i++) {
-		if (vpu_get_vb_length(vb, i) < cur_fmt->sizeimage[i]) {
+	for (i = 0; i < cur_fmt->mem_planes; i++) {
+		if (vpu_get_vb_length(vb, i) < vpu_get_fmt_plane_size(cur_fmt, i)) {
 			dev_dbg(inst->dev, "[%d] %s buf[%d] is invalid\n",
 				inst->id, vpu_type_name(vb->type), vb->index);
 			vpu_set_buffer_state(vbuf, VPU_BUF_STATE_ERROR);
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 795ca33a6a50..ef5de6b66e47 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -16,7 +16,8 @@ unsigned int vpu_get_buffer_state(struct vb2_v4l2_buffer *vbuf);
 int vpu_v4l2_open(struct file *file, struct vpu_inst *inst);
 int vpu_v4l2_close(struct file *file);
 
-const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f);
+u32 vpu_get_fmt_plane_size(struct vpu_format *fmt, u32 plane_no);
+int vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f, struct vpu_format *fmt);
 int vpu_process_output_buffer(struct vpu_inst *inst);
 int vpu_process_capture_buffer(struct vpu_inst *inst);
 struct vb2_v4l2_buffer *vpu_next_src_buf(struct vpu_inst *inst);
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
index 1526af2ef9da..a454f142ae17 100644
--- a/drivers/media/platform/amphion/vpu_windsor.c
+++ b/drivers/media/platform/amphion/vpu_windsor.c
@@ -775,6 +775,8 @@ static int vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
 				      u32 instance,
 				      struct vb2_buffer *vb)
 {
+	struct vpu_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vpu_format *out_fmt;
 	struct vpu_enc_yuv_desc *desc;
 	struct vb2_v4l2_buffer *vbuf;
 
@@ -782,6 +784,7 @@ static int vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
 		return -EINVAL;
 
 	desc = get_yuv_desc(shared, instance);
+	out_fmt = vpu_get_format(inst, vb->type);
 
 	vbuf = to_vb2_v4l2_buffer(vb);
 	desc->frame_id = vbuf->sequence;
@@ -790,7 +793,10 @@ static int vpu_windsor_fill_yuv_frame(struct vpu_shared_addr *shared,
 	else
 		desc->key_frame = 0;
 	desc->luma_base = vpu_get_vb_phy_addr(vb, 0);
-	desc->chroma_base = vpu_get_vb_phy_addr(vb, 1);
+	if (vb->num_planes > 1)
+		desc->chroma_base = vpu_get_vb_phy_addr(vb, 1);
+	else
+		desc->chroma_base = desc->luma_base + out_fmt->sizeimage[0];
 
 	return 0;
 }
-- 
2.37.1

