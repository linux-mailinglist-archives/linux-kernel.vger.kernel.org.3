Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E87049AD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443547AbiAYHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:15:25 -0500
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:47494
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1442946AbiAYHMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:12:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNpOYBpU3k65+ceZXXsnFtcjZYzZ9kXXQU6v84V2dcggaqBP9bANAXP+kLPwYkGnbRACXHei/62vPWZoCXQAM75Jjv780s+crVFVx7sTuO6mJIpL+IR3i8HY65Lp8BUeb46GUGdriE4XzU2XxVxfn+2zyPk3Ee9pD9S7m/QL1hROMCWlNq5MNY2et1dDJzw1GWGJJ8rgGjVbGAMPSNGg7G0xOO9VRQljLiPbZU+4lZXkG0kr56L85hmeiak5CQdrHUqyIYSCF/mAZDAY0Ok5yLkrQqrTGlAVCik+Xp533ADYF/lwnE5Ix7BfbaL+frFmN9trunEuzbwE4M/I5WwVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YljBed8gUEpVgcTNGcdWp4yQzRMg2BZTrek3BpvBADA=;
 b=MrjJU1QwIYFfx8EWKUufny2FKfjT213I+V9Q9PqS9NjgdnwKwz6YFHpZcZKatRDVOq184p6nIqYFWTPG6jKiu0j8vzl0301v0K/yDAakTrT6ByTykIiZIqzhIz7LEitoChDe5yTGY2Y4ygWvntKsxcFT8JeCoKx6sMRTQu569n6HO7w+Jnmvm2K6CPIqMRU/D3MNZcgnEL3gb7oGhAhdq3YkaRG8SXd5XMuaM5KNkjugEi74+PLPxrjA9zjlH/jKGPEJYv23Eu5e5+yvmq47Q9ab0eyy48lQoh+AO2R1fWWTCZX/LSVtu6UOQIpfEXALE17mmcNlF2awmYclMsXDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YljBed8gUEpVgcTNGcdWp4yQzRMg2BZTrek3BpvBADA=;
 b=qRL8HecG9Swmny+BZccYOpDZ44ldyxO6gRxWyDus2g9Wj2oUAgoCi9rxSIvFw2IXlrIeBgHlm7I02MFrCpHMqjH864ab6w+Z7ZuKLmqBM1TxPbTb8S9AuXfKHGsbyLRWCUwTFVsX4g6ksAcWvvyF5Q+PqjD4U4tv3bzjPcYFHFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6157.eurprd04.prod.outlook.com (2603:10a6:803:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 07:12:25 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 07:12:25 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 08/13] media: amphion: add v4l2 m2m vpu decoder stateful driver
Date:   Tue, 25 Jan 2022 15:11:24 +0800
Message-Id: <33db5d6269e6e85820062cfe81eb0fcededd96cc.1643077283.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643077283.git.ming.qian@nxp.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b360c9e5-563d-4b98-90af-08d9dfd209c2
X-MS-TrafficTypeDiagnostic: VI1PR04MB6157:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6157A00B9CE78B1DF4E9AFCCE75F9@VI1PR04MB6157.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tRDfZFSoX8PqGRCzIexzdEHyXgm2WKlnSSYsbo/PMICTdhTx3GlYDwW7TDy/FJ5lP8vkYj+30LVY+znl0gmSa4eDRgaksgffVKqsyDfe8mH1kBZLQ8+ikywdZgHTQxcTjzLEih6R9PWi/iMbIzKZcmEuJs5oLOZroXT42b5JJWw4gtT8vPmmF+JP7J2+PWPZRiCXv2a8EdhGn6o+cmqo0Y2MaUR62Xp5z3aws/ZoJ8PeIpj4GUioQNxcnrRMUnlG1XFu1brqpG62FFjcO04bfaQhbNH2LiCJs2vFCm5XtLGaPeZ84YDSSLEiIs2gSx4DoZSrsHOxuhgH7x2SPYyX6AhCpyTqPk/FZjtt8P+4HEP/WhAQzby43//aiNpq6erTNIKyd0noL5Dt3BFZOzwln7ggF5svxoSVrtX3GJFeFOQv3hRYRSaFdzuCRwmi5PUUZVU2/6UReM5BXsuJ46dWoEyO+2qBKLR2YHNAwsrpFcT+q61I+AowE3n1nLLeP46LvfRjLW1YNwP17CvPWQTr+Eu9/LKpYTZnZnhzdHSL2CGeNaxANwfwccQNoZFolG23OEE90b4KdGZsovoqqBmecRm0zaNExiqONR3UFs7/c90q9fiX9hjcopsFc2VwAeZ5qbK71KW+LKDqpRpk7WVPmDo0pDVfiRrAT+zSUHPfjRPNN2S2CArSrDeLHyIQ01YRl2sPyJtqWdlTmb86MH7YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(186003)(26005)(2616005)(38100700002)(2906002)(66946007)(66476007)(66556008)(7416002)(44832011)(30864003)(36756003)(8936002)(5660300002)(4326008)(8676002)(508600001)(52116002)(86362001)(316002)(6506007)(6512007)(83380400001)(6486002)(579004)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IV5hJw9Vw7HSXyKVQeyVWXEbOkKHSbSduo/iV8m51Bv+4P2vpV812BwCrPNT?=
 =?us-ascii?Q?787x0HNdtzpot8zPe0YjF6dofqTvikN5wdsDFMFbVWqQUZ/9OgHODaZpLErr?=
 =?us-ascii?Q?3dqO2Pd/edodwFsEiISdoDM7x8+mLSKYa8/ezMubsLbrbe0pA+zB9a+eSS5B?=
 =?us-ascii?Q?WZxKg/EPTNWr+QrtCvXj2uWdv/Cji7u+rF2yxnNYntni0p3VRBsdAjMXRXPD?=
 =?us-ascii?Q?I1NTiG/uNDtNZ17U/O2qKWPealH2ic5Qn1W3xKCmJFSwDlgvc8aIHc4U0/vW?=
 =?us-ascii?Q?M73oHxV1+qcHQ5fF4oDKJ45k5PNPuPPSp+ClDaorzcHfOWFpgRWTwBcZ4zQE?=
 =?us-ascii?Q?NXVCTyhIqiqa8+uE3SJlSHbWbcnwJl4iTkKEJZJFxfnoPvzBzuBLMh5QuNAK?=
 =?us-ascii?Q?GBFmj/F+V1+K/cXunZM3Gbt0zuCZiqicWibjRvMGAaRlXwRp0YFjRno2jcKN?=
 =?us-ascii?Q?KFHAd+6bX5w65tn6I8Jb+tmqwl/AIpsZq8HYbNzDyo7WfO3nZXefBiRly3Co?=
 =?us-ascii?Q?Ua5PZoZsPF7yux6kUyUBKtmpgFEaE1gcaApRs5hAadBmxslIX8Vaw95uBLA4?=
 =?us-ascii?Q?UGjmbQ1gFqR50ik4qyw7ZRKoqvI2MhPYMRe9Z90enhNHliZZbiwPRfZ9L3bW?=
 =?us-ascii?Q?NEi5G0nJYtVoDT7bVHE1Y3emlJr6llKOJt2061X2XYlrSTfeB31taTnhqi5z?=
 =?us-ascii?Q?4bbLviyYkoXjTyIv1mT4IYUhVeXlnDF6luFxbA2FKBhnZnwxj1CvWpAJuxr3?=
 =?us-ascii?Q?DnuXgO38vs4PfBuBKsnUGIASJxH91InQk59d+HzBM3JYvcIyFXgSZIS6K44i?=
 =?us-ascii?Q?AeWNMOdGYI3Us1jql5UdZQKlBMWZ1UTE+vKrHI04CZNRTl0ZN10Bi3W2/tfN?=
 =?us-ascii?Q?/m3FEiTAf11Kus7kZuCgIqnz7Gk4TU+mZ7oJ9hPus/jGqMFvwSwa2fVgrxQ7?=
 =?us-ascii?Q?zObPgdzMVEeyKX1z7Jb+M2dF/vaUpxdkMtFkPJ2cJHR3Cam9Z8qIt25R4b0y?=
 =?us-ascii?Q?/IAYm45v3uTB9akXUgd3Ne/Tp+ckZuJYsLEZbf4c+qcQEeUGwBnSAInoKR+4?=
 =?us-ascii?Q?MKDvbcRcGdNGs+Hm+fESUroErlgtbAsbeWYK/VVFLi24aiJgVjrNGlU43mYQ?=
 =?us-ascii?Q?+XZsi52AlgrOPiMhp759eDKO2NatUsWL2iVqSvS8755TePG26RI7Lcvo0lgE?=
 =?us-ascii?Q?B2eznVGEV1d3aurASxg+6XrQmN1H9EYvnEftUchdaxw9h7+0t3SF1pB/sxKK?=
 =?us-ascii?Q?jrdaCUQVX3VLpHwYmaBZ7eyBn/ECaQ4wCzrD6Ay70f3zAvSfAH4yeY3qE9LY?=
 =?us-ascii?Q?2NTec3vpZraVyaJggsmVxUtswEQknHqcge10uw1ZD5k1bQGACW9tXcf98Gd1?=
 =?us-ascii?Q?gGD5iB+SEnDBacqXwOditcOdgqVh29ggVTmq5U31Zkzd2s7pQ5UiFDz1ewNV?=
 =?us-ascii?Q?YcIiPdA8aiqNeFBzboiLfU2EnATRCDDz40jQTFkKO6qLNjNn8+vmzvDhLHOh?=
 =?us-ascii?Q?DLs3BSqNhqn/JBPlV/zd+S4ty/8dQvGCE8T1n4UsEb4uKdBEyF8jxQxDxCob?=
 =?us-ascii?Q?yh9DFFnbKId2kQ3yQ3RrbDZQJ/kvGAPQrC1P0KLR19iCsud4lP0vIoFqCEjw?=
 =?us-ascii?Q?mwuL+VfoqoXLlOteb6LYsWg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b360c9e5-563d-4b98-90af-08d9dfd209c2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:12:25.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/WNds664uA0mp2t5CodtE8237NXXbRLzRy9aLvvQ0oPBiWQkTrvrKsO7dLpyInzZ0TRuI2uTLZEpHspEwW3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This consists of video decoder implementation plus decoder controls.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/amphion/vdec.c | 1694 +++++++++++++++++++++++++
 1 file changed, 1694 insertions(+)
 create mode 100644 drivers/media/platform/amphion/vdec.c

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
new file mode 100644
index 000000000000..e45e12b65a3a
--- /dev/null
+++ b/drivers/media/platform/amphion/vdec.c
@@ -0,0 +1,1694 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020-2021 NXP
+ */
+
+#include <linux/init.h>
+#include <linux/interconnect.h>
+#include <linux/ioctl.h>
+#include <linux/list.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-vmalloc.h>
+#include "vpu.h"
+#include "vpu_defs.h"
+#include "vpu_core.h"
+#include "vpu_helpers.h"
+#include "vpu_v4l2.h"
+#include "vpu_cmds.h"
+#include "vpu_rpc.h"
+
+#define VDEC_FRAME_DEPTH		256
+#define VDEC_MIN_BUFFER_CAP		8
+
+struct vdec_fs_info {
+	char name[8];
+	u32 type;
+	u32 max_count;
+	u32 req_count;
+	u32 count;
+	u32 index;
+	u32 size;
+	struct vpu_buffer buffer[32];
+	u32 tag;
+};
+
+struct vdec_t {
+	u32 seq_hdr_found;
+	struct vpu_buffer udata;
+	struct vpu_decode_params params;
+	struct vpu_dec_codec_info codec_info;
+	enum vpu_codec_state state;
+
+	struct vpu_vb2_buffer *slots[VB2_MAX_FRAME];
+	u32 req_frame_count;
+	struct vdec_fs_info mbi;
+	struct vdec_fs_info dcp;
+	u32 seq_tag;
+
+	bool reset_codec;
+	bool fixed_fmt;
+	u32 decoded_frame_count;
+	u32 display_frame_count;
+	u32 sequence;
+	u32 eos_received;
+	bool is_source_changed;
+	u32 source_change;
+	u32 drain;
+	u32 ts_pre_count;
+	u32 frame_depth;
+	s64 ts_start;
+	s64 ts_input;
+	s64 timestamp;
+};
+
+static const struct vpu_format vdec_formats[] = {
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12M_8L128,
+		.num_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
+		.num_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H264,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H264_MVC,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_HEVC,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_G,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_VC1_ANNEX_L,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_MPEG2,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_MPEG4,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_XVID,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_VP8,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H263,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION
+	},
+	{0, 0, 0, 0},
+};
+
+static const struct v4l2_ctrl_ops vdec_ctrl_ops = {
+	.g_volatile_ctrl = vpu_helper_g_volatile_ctrl,
+};
+
+static int vdec_ctrl_init(struct vpu_inst *inst)
+{
+	struct v4l2_ctrl *ctrl;
+	int ret;
+
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 20);
+	if (ret)
+		return ret;
+
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
+				 V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
+				 V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	ret = v4l2_ctrl_handler_setup(&inst->ctrl_handler);
+	if (ret) {
+		dev_err(inst->dev, "[%d] setup ctrls fail, ret = %d\n", inst->id, ret);
+		v4l2_ctrl_handler_free(&inst->ctrl_handler);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vdec_set_last_buffer_dequeued(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (vdec->eos_received) {
+		if (!vpu_set_last_buffer_dequeued(inst))
+			vdec->eos_received--;
+	}
+}
+
+static void vdec_handle_resolution_change(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vb2_queue *q;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return;
+
+	if (inst->state != VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		return;
+	if (!vdec->source_change)
+		return;
+
+	q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
+	if (!list_empty(&q->done_list))
+		return;
+
+	vdec->source_change--;
+	vpu_notify_source_change(inst);
+}
+
+static int vdec_update_state(struct vpu_inst *inst, enum vpu_codec_state state, u32 force)
+{
+	struct vdec_t *vdec = inst->priv;
+	enum vpu_codec_state pre_state = inst->state;
+
+	if (state == VPU_CODEC_STATE_SEEK) {
+		if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+			vdec->state = inst->state;
+		else
+			vdec->state = VPU_CODEC_STATE_ACTIVE;
+	}
+	if (inst->state != VPU_CODEC_STATE_SEEK || force)
+		inst->state = state;
+	else if (state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		vdec->state = VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE;
+
+	if (inst->state != pre_state)
+		vpu_trace(inst->dev, "[%d] %d -> %d\n", inst->id, pre_state, inst->state);
+
+	if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		vdec_handle_resolution_change(inst);
+
+	return 0;
+}
+
+static int vdec_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, "amphion-vpu", sizeof(cap->driver));
+	strscpy(cap->card, "amphion vpu decoder", sizeof(cap->card));
+	strscpy(cap->bus_info, "platform: amphion-vpu", sizeof(cap->bus_info));
+
+	return 0;
+}
+
+static int vdec_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec = inst->priv;
+	const struct vpu_format *fmt;
+	int ret = -EINVAL;
+
+	vpu_inst_lock(inst);
+	if (!V4L2_TYPE_IS_OUTPUT(f->type) && vdec->fixed_fmt) {
+		if (f->index == 0) {
+			f->pixelformat = inst->cap_format.pixfmt;
+			f->flags = inst->cap_format.flags;
+			ret = 0;
+		}
+	} else {
+		fmt = vpu_helper_enum_format(inst, f->type, f->index);
+		memset(f->reserved, 0, sizeof(f->reserved));
+		if (!fmt)
+			goto exit;
+
+		f->pixelformat = fmt->pixfmt;
+		f->flags = fmt->flags;
+		ret = 0;
+	}
+
+exit:
+	vpu_inst_unlock(inst);
+	return ret;
+}
+
+static int vdec_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec = inst->priv;
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	struct vpu_format *cur_fmt;
+	int i;
+
+	cur_fmt = vpu_get_format(inst, f->type);
+
+	pixmp->pixelformat = cur_fmt->pixfmt;
+	pixmp->num_planes = cur_fmt->num_planes;
+	pixmp->width = cur_fmt->width;
+	pixmp->height = cur_fmt->height;
+	pixmp->field = cur_fmt->field;
+	pixmp->flags = cur_fmt->flags;
+	for (i = 0; i < pixmp->num_planes; i++) {
+		pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
+		pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+	}
+
+	f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
+	f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
+	f->fmt.pix_mp.ycbcr_enc = vdec->codec_info.matrix_coeffs;
+	f->fmt.pix_mp.quantization = vdec->codec_info.full_range;
+
+	return 0;
+}
+
+static int vdec_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec = inst->priv;
+
+	vpu_try_fmt_common(inst, f);
+
+	vpu_inst_lock(inst);
+	if (vdec->fixed_fmt) {
+		f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
+		f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
+		f->fmt.pix_mp.ycbcr_enc = vdec->codec_info.matrix_coeffs;
+		f->fmt.pix_mp.quantization = vdec->codec_info.full_range;
+	} else {
+		f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
+		f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
+		f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+		f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	}
+	vpu_inst_unlock(inst);
+
+	return 0;
+}
+
+static int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	const struct vpu_format *fmt;
+	struct vpu_format *cur_fmt;
+	struct vb2_queue *q;
+	struct vdec_t *vdec = inst->priv;
+	int i;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	q = v4l2_m2m_get_vq(inst->fh.m2m_ctx, f->type);
+	if (!q)
+		return -EINVAL;
+	if (vb2_is_busy(q))
+		return -EBUSY;
+
+	fmt = vpu_try_fmt_common(inst, f);
+	if (!fmt)
+		return -EINVAL;
+
+	cur_fmt = vpu_get_format(inst, f->type);
+	if (V4L2_TYPE_IS_OUTPUT(f->type) && inst->state != VPU_CODEC_STATE_DEINIT) {
+		if (cur_fmt->pixfmt != fmt->pixfmt) {
+			vdec->reset_codec = true;
+			vdec->fixed_fmt = false;
+		}
+	}
+	cur_fmt->pixfmt = fmt->pixfmt;
+	if (V4L2_TYPE_IS_OUTPUT(f->type) || !vdec->fixed_fmt) {
+		cur_fmt->num_planes = fmt->num_planes;
+		cur_fmt->flags = fmt->flags;
+		cur_fmt->width = pixmp->width;
+		cur_fmt->height = pixmp->height;
+		for (i = 0; i < fmt->num_planes; i++) {
+			cur_fmt->sizeimage[i] = pixmp->plane_fmt[i].sizeimage;
+			cur_fmt->bytesperline[i] = pixmp->plane_fmt[i].bytesperline;
+		}
+		if (pixmp->field != V4L2_FIELD_ANY)
+			cur_fmt->field = pixmp->field;
+	} else {
+		pixmp->num_planes = cur_fmt->num_planes;
+		pixmp->width = cur_fmt->width;
+		pixmp->height = cur_fmt->height;
+		for (i = 0; i < pixmp->num_planes; i++) {
+			pixmp->plane_fmt[i].bytesperline = cur_fmt->bytesperline[i];
+			pixmp->plane_fmt[i].sizeimage = cur_fmt->sizeimage[i];
+		}
+		pixmp->field = cur_fmt->field;
+	}
+
+	if (!vdec->fixed_fmt) {
+		if (V4L2_TYPE_IS_OUTPUT(f->type)) {
+			vdec->params.codec_format = cur_fmt->pixfmt;
+			vdec->codec_info.color_primaries = f->fmt.pix_mp.colorspace;
+			vdec->codec_info.transfer_chars = f->fmt.pix_mp.xfer_func;
+			vdec->codec_info.matrix_coeffs = f->fmt.pix_mp.ycbcr_enc;
+			vdec->codec_info.full_range = f->fmt.pix_mp.quantization;
+		} else {
+			vdec->params.output_format = cur_fmt->pixfmt;
+			inst->crop.left = 0;
+			inst->crop.top = 0;
+			inst->crop.width = cur_fmt->width;
+			inst->crop.height = cur_fmt->height;
+		}
+	}
+
+	vpu_trace(inst->dev, "[%d] %c%c%c%c %dx%d\n", inst->id,
+		  f->fmt.pix_mp.pixelformat,
+		  f->fmt.pix_mp.pixelformat >> 8,
+		  f->fmt.pix_mp.pixelformat >> 16,
+		  f->fmt.pix_mp.pixelformat >> 24,
+		  f->fmt.pix_mp.width,
+		  f->fmt.pix_mp.height);
+
+	return 0;
+}
+
+static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	struct vdec_t *vdec = inst->priv;
+	int ret = 0;
+
+	vpu_inst_lock(inst);
+	ret = vdec_s_fmt_common(inst, f);
+	if (ret)
+		goto exit;
+
+	if (V4L2_TYPE_IS_OUTPUT(f->type) && !vdec->fixed_fmt) {
+		struct v4l2_format fc;
+
+		memset(&fc, 0, sizeof(fc));
+		fc.type = inst->cap_format.type;
+		fc.fmt.pix_mp.pixelformat = inst->cap_format.pixfmt;
+		fc.fmt.pix_mp.width = pixmp->width;
+		fc.fmt.pix_mp.height = pixmp->height;
+		vdec_s_fmt_common(inst, &fc);
+	}
+
+	f->fmt.pix_mp.colorspace = vdec->codec_info.color_primaries;
+	f->fmt.pix_mp.xfer_func = vdec->codec_info.transfer_chars;
+	f->fmt.pix_mp.ycbcr_enc = vdec->codec_info.matrix_coeffs;
+	f->fmt.pix_mp.quantization = vdec->codec_info.full_range;
+
+exit:
+	vpu_inst_unlock(inst);
+	return ret;
+}
+
+static int vdec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_inst *inst = to_inst(file);
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE && s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+		return -EINVAL;
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_COMPOSE:
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+	case V4L2_SEL_TGT_COMPOSE_PADDED:
+		s->r = inst->crop;
+		break;
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->cap_format.width;
+		s->r.height = inst->cap_format.height;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vdec_drain(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	if (!vdec->drain)
+		return 0;
+
+	if (v4l2_m2m_num_src_bufs_ready(inst->fh.m2m_ctx))
+		return 0;
+
+	if (!vdec->params.frame_count) {
+		vpu_set_last_buffer_dequeued(inst);
+		return 0;
+	}
+
+	vpu_iface_add_scode(inst, SCODE_PADDING_EOS);
+	vdec->params.end_flag = 1;
+	vpu_iface_set_decode_params(inst, &vdec->params, 1);
+	vdec->drain = 0;
+	vpu_trace(inst->dev, "[%d] frame_count = %d\n", inst->id, vdec->params.frame_count);
+
+	return 0;
+}
+
+static int vdec_cmd_start(struct vpu_inst *inst)
+{
+	switch (inst->state) {
+	case VPU_CODEC_STATE_STARTED:
+	case VPU_CODEC_STATE_DRAIN:
+	case VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE:
+		vdec_update_state(inst, VPU_CODEC_STATE_ACTIVE, 0);
+		break;
+	default:
+		break;
+	}
+	vpu_process_capture_buffer(inst);
+	return 0;
+}
+
+static int vdec_cmd_stop(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vpu_trace(inst->dev, "[%d]\n", inst->id);
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT) {
+		vpu_set_last_buffer_dequeued(inst);
+	} else {
+		vdec->drain = 1;
+		vdec_drain(inst);
+	}
+
+	return 0;
+}
+
+static int vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, cmd);
+	if (ret)
+		return ret;
+
+	vpu_inst_lock(inst);
+	switch (cmd->cmd) {
+	case V4L2_DEC_CMD_START:
+		vdec_cmd_start(inst);
+		break;
+	case V4L2_DEC_CMD_STOP:
+		vdec_cmd_stop(inst);
+		break;
+	default:
+		break;
+	}
+	vpu_inst_unlock(inst);
+
+	return 0;
+}
+
+static int vdec_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	case V4L2_EVENT_SOURCE_CHANGE:
+		return v4l2_src_change_event_subscribe(fh, sub);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops vdec_ioctl_ops = {
+	.vidioc_querycap               = vdec_querycap,
+	.vidioc_enum_fmt_vid_cap       = vdec_enum_fmt,
+	.vidioc_enum_fmt_vid_out       = vdec_enum_fmt,
+	.vidioc_g_fmt_vid_cap_mplane   = vdec_g_fmt,
+	.vidioc_g_fmt_vid_out_mplane   = vdec_g_fmt,
+	.vidioc_try_fmt_vid_cap_mplane = vdec_try_fmt,
+	.vidioc_try_fmt_vid_out_mplane = vdec_try_fmt,
+	.vidioc_s_fmt_vid_cap_mplane   = vdec_s_fmt,
+	.vidioc_s_fmt_vid_out_mplane   = vdec_s_fmt,
+	.vidioc_g_selection            = vdec_g_selection,
+	.vidioc_try_decoder_cmd        = v4l2_m2m_ioctl_try_decoder_cmd,
+	.vidioc_decoder_cmd            = vdec_decoder_cmd,
+	.vidioc_subscribe_event        = vdec_subscribe_event,
+	.vidioc_unsubscribe_event      = v4l2_event_unsubscribe,
+	.vidioc_reqbufs                = v4l2_m2m_ioctl_reqbufs,
+	.vidioc_create_bufs	       = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_prepare_buf	       = v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_querybuf               = v4l2_m2m_ioctl_querybuf,
+	.vidioc_qbuf                   = v4l2_m2m_ioctl_qbuf,
+	.vidioc_expbuf                 = v4l2_m2m_ioctl_expbuf,
+	.vidioc_dqbuf                  = v4l2_m2m_ioctl_dqbuf,
+	.vidioc_streamon               = v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff              = v4l2_m2m_ioctl_streamoff,
+};
+
+static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		if (vdec->ts_pre_count >= vdec->frame_depth)
+			return false;
+		return true;
+	}
+
+	if (vdec->req_frame_count)
+		return true;
+
+	return false;
+}
+
+static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_dec_pic_info *info = arg;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vb2_v4l2_buffer *vbuf;
+	int ret = 0;
+
+	if (!info || info->id >= ARRAY_SIZE(vdec->slots))
+		return -EINVAL;
+
+	vpu_inst_lock(inst);
+	vpu_buf = vdec->slots[info->id];
+	if (!vpu_buf) {
+		dev_err(inst->dev, "[%d] decoded invalid frame[%d]\n", inst->id, info->id);
+		ret = -EINVAL;
+		goto exit;
+	}
+	vbuf = &vpu_buf->m2m_buf.vb;
+	if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_DECODED)
+		dev_info(inst->dev, "[%d] buf[%d] has been decoded\n", inst->id, info->id);
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_DECODED);
+	vdec->decoded_frame_count++;
+	if (vdec->ts_pre_count >= info->consumed_count)
+		vdec->ts_pre_count -= info->consumed_count;
+	else
+		vdec->ts_pre_count = 0;
+exit:
+	vpu_inst_unlock(inst);
+
+	return ret;
+}
+
+static struct vpu_vb2_buffer *vdec_find_buffer(struct vpu_inst *inst, u32 luma)
+{
+	struct vdec_t *vdec = inst->priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vdec->slots); i++) {
+		if (!vdec->slots[i])
+			continue;
+		if (luma == vdec->slots[i]->luma)
+			return vdec->slots[i];
+	}
+
+	return NULL;
+}
+
+static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vb2_v4l2_buffer *vbuf;
+	u32 sequence;
+
+	if (!frame)
+		return;
+
+	vpu_inst_lock(inst);
+	sequence = vdec->sequence++;
+	vpu_buf = vdec_find_buffer(inst, frame->luma);
+	vpu_inst_unlock(inst);
+	if (!vpu_buf) {
+		dev_err(inst->dev, "[%d] can't find buffer, id = %d, addr = 0x%x\n",
+			inst->id, frame->id, frame->luma);
+		return;
+	}
+	if (frame->skipped) {
+		dev_dbg(inst->dev, "[%d] frame skip\n", inst->id);
+		return;
+	}
+
+	vbuf = &vpu_buf->m2m_buf.vb;
+	if (vbuf->vb2_buf.index != frame->id)
+		dev_err(inst->dev, "[%d] buffer id(%d, %d) dismatch\n",
+			inst->id, vbuf->vb2_buf.index, frame->id);
+
+	if (vpu_get_buffer_state(vbuf) != VPU_BUF_STATE_DECODED)
+		dev_err(inst->dev, "[%d] buffer(%d) ready without decoded\n", inst->id, frame->id);
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
+	vb2_set_plane_payload(&vbuf->vb2_buf, 0, inst->cap_format.sizeimage[0]);
+	vb2_set_plane_payload(&vbuf->vb2_buf, 1, inst->cap_format.sizeimage[1]);
+	vbuf->vb2_buf.timestamp = frame->timestamp;
+	vbuf->field = inst->cap_format.field;
+	vbuf->sequence = sequence;
+	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, frame->timestamp);
+
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+	vpu_inst_lock(inst);
+	vdec->timestamp = frame->timestamp;
+	vdec->display_frame_count++;
+	vpu_inst_unlock(inst);
+	dev_dbg(inst->dev, "[%d] decoded : %d, display : %d, sequence : %d\n",
+		inst->id, vdec->decoded_frame_count, vdec->display_frame_count, vdec->sequence);
+}
+
+static void vdec_stop_done(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vpu_inst_lock(inst);
+	vdec_update_state(inst, VPU_CODEC_STATE_DEINIT, 0);
+	vdec->seq_hdr_found = 0;
+	vdec->req_frame_count = 0;
+	vdec->reset_codec = false;
+	vdec->fixed_fmt = false;
+	vdec->params.end_flag = 0;
+	vdec->drain = 0;
+	vdec->ts_pre_count = 0;
+	vdec->timestamp = VPU_INVALID_TIMESTAMP;
+	vdec->ts_start = VPU_INVALID_TIMESTAMP;
+	vdec->ts_input = VPU_INVALID_TIMESTAMP;
+	vdec->params.frame_count = 0;
+	vdec->decoded_frame_count = 0;
+	vdec->display_frame_count = 0;
+	vdec->sequence = 0;
+	vdec->eos_received = 0;
+	vdec->is_source_changed = false;
+	vdec->source_change = 0;
+	vpu_inst_unlock(inst);
+}
+
+static bool vdec_check_source_change(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	const struct vpu_format *fmt;
+	int i;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return false;
+	if (!vb2_is_streaming(v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx)))
+		return true;
+	fmt = vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec_info.pixfmt);
+	if (inst->cap_format.pixfmt != vdec->codec_info.pixfmt)
+		return true;
+	if (inst->cap_format.width != vdec->codec_info.decoded_width)
+		return true;
+	if (inst->cap_format.height != vdec->codec_info.decoded_height)
+		return true;
+	if (vpu_get_num_buffers(inst, inst->cap_format.type) < inst->min_buffer_cap)
+		return true;
+	if (inst->crop.left != vdec->codec_info.offset_x)
+		return true;
+	if (inst->crop.top != vdec->codec_info.offset_y)
+		return true;
+	if (inst->crop.width != vdec->codec_info.width)
+		return true;
+	if (inst->crop.height != vdec->codec_info.height)
+		return true;
+	if (fmt && inst->cap_format.num_planes != fmt->num_planes)
+		return true;
+	for (i = 0; i < inst->cap_format.num_planes; i++) {
+		if (inst->cap_format.bytesperline[i] != vdec->codec_info.bytesperline[i])
+			return true;
+		if (inst->cap_format.sizeimage[i] != vdec->codec_info.sizeimage[i])
+			return true;
+	}
+
+	return false;
+}
+
+static void vdec_init_fmt(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	const struct vpu_format *fmt;
+	int i;
+
+	fmt = vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec_info.pixfmt);
+	inst->out_format.width = vdec->codec_info.width;
+	inst->out_format.height = vdec->codec_info.height;
+	inst->cap_format.width = vdec->codec_info.decoded_width;
+	inst->cap_format.height = vdec->codec_info.decoded_height;
+	inst->cap_format.pixfmt = vdec->codec_info.pixfmt;
+	if (fmt) {
+		inst->cap_format.num_planes = fmt->num_planes;
+		inst->cap_format.flags = fmt->flags;
+	}
+	for (i = 0; i < inst->cap_format.num_planes; i++) {
+		inst->cap_format.bytesperline[i] = vdec->codec_info.bytesperline[i];
+		inst->cap_format.sizeimage[i] = vdec->codec_info.sizeimage[i];
+	}
+	if (vdec->codec_info.progressive)
+		inst->cap_format.field = V4L2_FIELD_NONE;
+	else
+		inst->cap_format.field = V4L2_FIELD_SEQ_BT;
+	if (vdec->codec_info.color_primaries == V4L2_COLORSPACE_DEFAULT)
+		vdec->codec_info.color_primaries = V4L2_COLORSPACE_REC709;
+	if (vdec->codec_info.transfer_chars == V4L2_XFER_FUNC_DEFAULT)
+		vdec->codec_info.transfer_chars = V4L2_XFER_FUNC_709;
+	if (vdec->codec_info.matrix_coeffs == V4L2_YCBCR_ENC_DEFAULT)
+		vdec->codec_info.matrix_coeffs = V4L2_YCBCR_ENC_709;
+	if (vdec->codec_info.full_range == V4L2_QUANTIZATION_DEFAULT)
+		vdec->codec_info.full_range = V4L2_QUANTIZATION_LIM_RANGE;
+}
+
+static void vdec_init_crop(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	inst->crop.left = vdec->codec_info.offset_x;
+	inst->crop.top = vdec->codec_info.offset_y;
+	inst->crop.width = vdec->codec_info.width;
+	inst->crop.height = vdec->codec_info.height;
+}
+
+static void vdec_init_mbi(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vdec->mbi.size = vdec->codec_info.mbi_size;
+	vdec->mbi.max_count = ARRAY_SIZE(vdec->mbi.buffer);
+	scnprintf(vdec->mbi.name, sizeof(vdec->mbi.name), "mbi");
+	vdec->mbi.type = MEM_RES_MBI;
+	vdec->mbi.tag = vdec->seq_tag;
+}
+
+static void vdec_init_dcp(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vdec->dcp.size = vdec->codec_info.dcp_size;
+	vdec->dcp.max_count = ARRAY_SIZE(vdec->dcp.buffer);
+	scnprintf(vdec->dcp.name, sizeof(vdec->dcp.name), "dcp");
+	vdec->dcp.type = MEM_RES_DCP;
+	vdec->dcp.tag = vdec->seq_tag;
+}
+
+static void vdec_request_one_fs(struct vdec_fs_info *fs)
+{
+	fs->req_count++;
+	if (fs->req_count > fs->max_count)
+		fs->req_count = fs->max_count;
+}
+
+static int vdec_alloc_fs_buffer(struct vpu_inst *inst, struct vdec_fs_info *fs)
+{
+	struct vpu_buffer *buffer;
+
+	if (!inst || !fs || !fs->size)
+		return -EINVAL;
+
+	if (fs->count >= fs->req_count)
+		return -EINVAL;
+
+	buffer = &fs->buffer[fs->count];
+	if (buffer->virt && buffer->length >= fs->size)
+		return 0;
+
+	vpu_free_dma(buffer);
+	buffer->length = fs->size;
+	return vpu_alloc_dma(inst->core, buffer);
+}
+
+static void vdec_alloc_fs(struct vpu_inst *inst, struct vdec_fs_info *fs)
+{
+	int ret;
+
+	while (fs->count < fs->req_count) {
+		ret = vdec_alloc_fs_buffer(inst, fs);
+		if (ret)
+			break;
+		fs->count++;
+	}
+}
+
+static void vdec_clear_fs(struct vdec_fs_info *fs)
+{
+	u32 i;
+
+	if (!fs)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(fs->buffer); i++)
+		vpu_free_dma(&fs->buffer[i]);
+	memset(fs, 0, sizeof(*fs));
+}
+
+static int vdec_response_fs(struct vpu_inst *inst, struct vdec_fs_info *fs)
+{
+	struct vpu_fs_info info;
+	int ret;
+
+	if (fs->index >= fs->count)
+		return 0;
+
+	memset(&info, 0, sizeof(info));
+	info.id = fs->index;
+	info.type = fs->type;
+	info.tag = fs->tag;
+	info.luma_addr = fs->buffer[fs->index].phys;
+	info.luma_size = fs->buffer[fs->index].length;
+	ret = vpu_session_alloc_fs(inst, &info);
+	if (ret)
+		return ret;
+
+	fs->index++;
+	return 0;
+}
+
+static int vdec_response_frame_abnormal(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_fs_info info;
+
+	if (!vdec->req_frame_count)
+		return 0;
+
+	memset(&info, 0, sizeof(info));
+	info.type = MEM_RES_FRAME;
+	info.tag = vdec->seq_tag + 0xf0;
+	vpu_session_alloc_fs(inst, &info);
+	vdec->req_frame_count--;
+
+	return 0;
+}
+
+static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vbuf)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vpu_fs_info info;
+	int ret;
+
+	if (inst->state != VPU_CODEC_STATE_ACTIVE)
+		return -EINVAL;
+
+	if (!vdec->req_frame_count)
+		return -EINVAL;
+
+	if (!vbuf)
+		return -EINVAL;
+
+	if (vdec->slots[vbuf->vb2_buf.index]) {
+		dev_err(inst->dev, "[%d] repeat alloc fs %d\n",
+			inst->id, vbuf->vb2_buf.index);
+		return -EINVAL;
+	}
+
+	dev_dbg(inst->dev, "[%d] state = %d, alloc fs %d, tag = 0x%x\n",
+		inst->id, inst->state, vbuf->vb2_buf.index, vdec->seq_tag);
+	vpu_buf = to_vpu_vb2_buffer(vbuf);
+
+	memset(&info, 0, sizeof(info));
+	info.id = vbuf->vb2_buf.index;
+	info.type = MEM_RES_FRAME;
+	info.tag = vdec->seq_tag;
+	info.luma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 0);
+	info.luma_size = inst->cap_format.sizeimage[0];
+	info.chroma_addr = vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
+	info.chromau_size = inst->cap_format.sizeimage[1];
+	info.bytesperline = inst->cap_format.bytesperline[0];
+	ret = vpu_session_alloc_fs(inst, &info);
+	if (ret)
+		return ret;
+
+	vpu_buf->tag = info.tag;
+	vpu_buf->luma = info.luma_addr;
+	vpu_buf->chroma_u = info.chromau_size;
+	vpu_buf->chroma_v = 0;
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
+	vdec->slots[info.id] = vpu_buf;
+	vdec->req_frame_count--;
+
+	return 0;
+}
+
+static void vdec_response_fs_request(struct vpu_inst *inst, bool force)
+{
+	struct vdec_t *vdec = inst->priv;
+	int i;
+	int ret;
+
+	if (force) {
+		for (i = vdec->req_frame_count; i > 0; i--)
+			vdec_response_frame_abnormal(inst);
+		return;
+	}
+
+	for (i = vdec->req_frame_count; i > 0; i--) {
+		ret = vpu_process_capture_buffer(inst);
+		if (ret)
+			break;
+		if (vdec->eos_received)
+			break;
+	}
+
+	for (i = vdec->mbi.index; i < vdec->mbi.count; i++) {
+		if (vdec_response_fs(inst, &vdec->mbi))
+			break;
+		if (vdec->eos_received)
+			break;
+	}
+	for (i = vdec->dcp.index; i < vdec->dcp.count; i++) {
+		if (vdec_response_fs(inst, &vdec->dcp))
+			break;
+		if (vdec->eos_received)
+			break;
+	}
+}
+
+static void vdec_response_fs_release(struct vpu_inst *inst, u32 id, u32 tag)
+{
+	struct vpu_fs_info info;
+
+	memset(&info, 0, sizeof(info));
+	info.id = id;
+	info.tag = tag;
+	vpu_session_release_fs(inst, &info);
+}
+
+static void vdec_recycle_buffer(struct vpu_inst *inst, struct vb2_v4l2_buffer *vbuf)
+{
+	if (!inst || !vbuf || !inst->fh.m2m_ctx)
+		return;
+
+	if (vbuf->vb2_buf.state != VB2_BUF_STATE_ACTIVE)
+		return;
+	if (vpu_find_buf_by_idx(inst, vbuf->vb2_buf.type, vbuf->vb2_buf.index))
+		return;
+	v4l2_m2m_buf_queue(inst->fh.m2m_ctx, vbuf);
+}
+
+static void vdec_clear_slots(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vb2_v4l2_buffer *vbuf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vdec->slots); i++) {
+		if (!vdec->slots[i])
+			continue;
+
+		vpu_buf = vdec->slots[i];
+		vbuf = &vpu_buf->m2m_buf.vb;
+
+		vdec_recycle_buffer(inst, vbuf);
+		vdec->slots[i]->state = VPU_BUF_STATE_IDLE;
+		vdec->slots[i] = NULL;
+	}
+}
+
+static void vdec_event_seq_hdr(struct vpu_inst *inst, struct vpu_dec_codec_info *hdr)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vpu_inst_lock(inst);
+	memcpy(&vdec->codec_info, hdr, sizeof(vdec->codec_info));
+
+	vpu_trace(inst->dev, "[%d] %d x %d, crop : (%d, %d) %d x %d, %d, %d\n",
+		  inst->id,
+		  vdec->codec_info.decoded_width,
+		  vdec->codec_info.decoded_height,
+		  vdec->codec_info.offset_x,
+		  vdec->codec_info.offset_y,
+		  vdec->codec_info.width,
+		  vdec->codec_info.height,
+		  hdr->num_ref_frms,
+		  hdr->num_dpb_frms);
+	inst->min_buffer_cap = hdr->num_ref_frms + hdr->num_dpb_frms;
+	vdec->is_source_changed = vdec_check_source_change(inst);
+	vdec_init_fmt(inst);
+	vdec_init_crop(inst);
+	vdec_init_mbi(inst);
+	vdec_init_dcp(inst);
+	if (!vdec->seq_hdr_found) {
+		vdec->seq_tag = vdec->codec_info.tag;
+		if (vdec->is_source_changed) {
+			vdec_update_state(inst, VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE, 0);
+			vpu_notify_source_change(inst);
+			vdec->is_source_changed = false;
+		}
+	}
+	if (vdec->seq_tag != vdec->codec_info.tag) {
+		vdec_response_fs_request(inst, true);
+		vpu_trace(inst->dev, "[%d] seq tag change: %d -> %d\n",
+			  inst->id, vdec->seq_tag, vdec->codec_info.tag);
+	}
+	vdec->seq_hdr_found++;
+	vdec->fixed_fmt = true;
+	vpu_inst_unlock(inst);
+}
+
+static void vdec_event_resolution_change(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vpu_trace(inst->dev, "[%d]\n", inst->id);
+	vpu_inst_lock(inst);
+	vdec->seq_tag = vdec->codec_info.tag;
+	vdec_clear_fs(&vdec->mbi);
+	vdec_clear_fs(&vdec->dcp);
+	vdec_clear_slots(inst);
+	vdec_init_mbi(inst);
+	vdec_init_dcp(inst);
+	if (vdec->is_source_changed) {
+		vdec_update_state(inst, VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE, 0);
+		vdec->source_change++;
+		vdec_handle_resolution_change(inst);
+		vdec->is_source_changed = false;
+	}
+	vpu_inst_unlock(inst);
+}
+
+static void vdec_event_req_fs(struct vpu_inst *inst, struct vpu_fs_info *fs)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (!fs)
+		return;
+
+	vpu_inst_lock(inst);
+
+	switch (fs->type) {
+	case MEM_RES_FRAME:
+		vdec->req_frame_count++;
+		break;
+	case MEM_RES_MBI:
+		vdec_request_one_fs(&vdec->mbi);
+		break;
+	case MEM_RES_DCP:
+		vdec_request_one_fs(&vdec->dcp);
+		break;
+	default:
+		break;
+	}
+
+	vdec_alloc_fs(inst, &vdec->mbi);
+	vdec_alloc_fs(inst, &vdec->dcp);
+
+	vdec_response_fs_request(inst, false);
+
+	vpu_inst_unlock(inst);
+}
+
+static void vdec_evnet_rel_fs(struct vpu_inst *inst, struct vpu_fs_info *fs)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_vb2_buffer *vpu_buf;
+	struct vb2_v4l2_buffer *vbuf;
+
+	if (!fs || fs->id >= ARRAY_SIZE(vdec->slots))
+		return;
+	if (fs->type != MEM_RES_FRAME)
+		return;
+
+	if (fs->id >= vpu_get_num_buffers(inst, inst->cap_format.type)) {
+		dev_err(inst->dev, "[%d] invalid fs(%d) to release\n", inst->id, fs->id);
+		return;
+	}
+
+	vpu_inst_lock(inst);
+	vpu_buf = vdec->slots[fs->id];
+	vdec->slots[fs->id] = NULL;
+
+	if (!vpu_buf) {
+		dev_dbg(inst->dev, "[%d] fs[%d] has bee released\n", inst->id, fs->id);
+		goto exit;
+	}
+
+	vbuf = &vpu_buf->m2m_buf.vb;
+	if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_DECODED) {
+		dev_dbg(inst->dev, "[%d] frame skip\n", inst->id);
+		vdec->sequence++;
+	}
+
+	vdec_response_fs_release(inst, fs->id, vpu_buf->tag);
+	if (vpu_get_buffer_state(vbuf) != VPU_BUF_STATE_READY)
+		vdec_recycle_buffer(inst, vbuf);
+
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
+	vpu_process_capture_buffer(inst);
+
+exit:
+	vpu_inst_unlock(inst);
+}
+
+static void vdec_event_eos(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vpu_trace(inst->dev, "[%d] input : %d, decoded : %d, display : %d, sequence : %d\n",
+		  inst->id,
+		  vdec->params.frame_count,
+		  vdec->decoded_frame_count,
+		  vdec->display_frame_count,
+		  vdec->sequence);
+	vpu_inst_lock(inst);
+	vdec->eos_received++;
+	vdec->fixed_fmt = false;
+	inst->min_buffer_cap = VDEC_MIN_BUFFER_CAP;
+	vdec_update_state(inst, VPU_CODEC_STATE_DRAIN, 0);
+	vdec_set_last_buffer_dequeued(inst);
+	vpu_inst_unlock(inst);
+}
+
+static void vdec_event_notify(struct vpu_inst *inst, u32 event, void *data)
+{
+	switch (event) {
+	case VPU_MSG_ID_SEQ_HDR_FOUND:
+		vdec_event_seq_hdr(inst, data);
+		break;
+	case VPU_MSG_ID_RES_CHANGE:
+		vdec_event_resolution_change(inst);
+		break;
+	case VPU_MSG_ID_FRAME_REQ:
+		vdec_event_req_fs(inst, data);
+		break;
+	case VPU_MSG_ID_FRAME_RELEASE:
+		vdec_evnet_rel_fs(inst, data);
+		break;
+	case VPU_MSG_ID_PIC_EOS:
+		vdec_event_eos(inst);
+		break;
+	default:
+		break;
+	}
+}
+
+static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vb2_v4l2_buffer *vbuf;
+	struct vpu_rpc_buffer_desc desc;
+	s64 timestamp;
+	u32 free_space;
+	int ret;
+
+	vbuf = to_vb2_v4l2_buffer(vb);
+	dev_dbg(inst->dev, "[%d] dec output [%d] %d : %ld\n",
+		inst->id, vbuf->sequence, vb->index, vb2_get_plane_payload(vb, 0));
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return -EINVAL;
+	if (vdec->reset_codec)
+		return -EINVAL;
+
+	if (inst->state == VPU_CODEC_STATE_STARTED)
+		vdec_update_state(inst, VPU_CODEC_STATE_ACTIVE, 0);
+
+	ret = vpu_iface_get_stream_buffer_desc(inst, &desc);
+	if (ret)
+		return ret;
+
+	free_space = vpu_helper_get_free_space(inst);
+	if (free_space < vb2_get_plane_payload(vb, 0) + 0x40000)
+		return -ENOMEM;
+
+	timestamp = vb->timestamp;
+	if (timestamp >= 0 && vdec->ts_start < 0)
+		vdec->ts_start = timestamp;
+	if (vdec->ts_input < timestamp)
+		vdec->ts_input = timestamp;
+
+	ret = vpu_iface_input_frame(inst, vb);
+	if (ret < 0)
+		return -ENOMEM;
+
+	dev_dbg(inst->dev, "[%d][INPUT  TS]%32lld\n", inst->id, vb->timestamp);
+	vdec->ts_pre_count++;
+	vdec->params.frame_count++;
+
+	v4l2_m2m_src_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+
+	if (vdec->drain)
+		vdec_drain(inst);
+
+	return 0;
+}
+
+static int vdec_process_capture(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	int ret;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+	if (inst->state == VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+		return -EINVAL;
+	if (vdec->reset_codec)
+		return -EINVAL;
+
+	ret = vdec_response_frame(inst, vbuf);
+	if (ret)
+		return ret;
+	v4l2_m2m_dst_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
+	return 0;
+}
+
+static void vdec_on_queue_empty(struct vpu_inst *inst, u32 type)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		return;
+
+	vdec_handle_resolution_change(inst);
+	if (vdec->eos_received)
+		vdec_set_last_buffer_dequeued(inst);
+}
+
+static void vdec_abort(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	struct vpu_rpc_buffer_desc desc;
+	int ret;
+
+	vpu_trace(inst->dev, "[%d] state = %d\n", inst->id, inst->state);
+	vpu_iface_add_scode(inst, SCODE_PADDING_ABORT);
+	vdec->params.end_flag = 1;
+	vpu_iface_set_decode_params(inst, &vdec->params, 1);
+
+	vpu_session_abort(inst);
+
+	ret = vpu_iface_get_stream_buffer_desc(inst, &desc);
+	if (!ret)
+		vpu_iface_update_stream_buffer(inst, desc.rptr, 1);
+
+	vpu_session_rst_buf(inst);
+	vpu_trace(inst->dev, "[%d] input : %d, decoded : %d, display : %d, sequence : %d\n",
+		  inst->id,
+		  vdec->params.frame_count,
+		  vdec->decoded_frame_count,
+		  vdec->display_frame_count,
+		  vdec->sequence);
+	vdec->params.end_flag = 0;
+	vdec->drain = 0;
+	vdec->ts_pre_count = 0;
+	vdec->timestamp = VPU_INVALID_TIMESTAMP;
+	vdec->ts_start = VPU_INVALID_TIMESTAMP;
+	vdec->ts_input = VPU_INVALID_TIMESTAMP;
+	vdec->params.frame_count = 0;
+	vdec->decoded_frame_count = 0;
+	vdec->display_frame_count = 0;
+	vdec->sequence = 0;
+}
+
+static void vdec_stop(struct vpu_inst *inst, bool free)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	vdec_clear_slots(inst);
+	if (inst->state != VPU_CODEC_STATE_DEINIT)
+		vpu_session_stop(inst);
+	vdec_clear_fs(&vdec->mbi);
+	vdec_clear_fs(&vdec->dcp);
+	if (free) {
+		vpu_free_dma(&vdec->udata);
+		vpu_free_dma(&inst->stream_buffer);
+	}
+	vdec_update_state(inst, VPU_CODEC_STATE_DEINIT, 1);
+	vdec->reset_codec = false;
+}
+
+static void vdec_release(struct vpu_inst *inst)
+{
+	if (inst->id != VPU_INST_NULL_ID)
+		vpu_trace(inst->dev, "[%d]\n", inst->id);
+	vpu_inst_lock(inst);
+	vdec_stop(inst, true);
+	vpu_inst_unlock(inst);
+}
+
+static void vdec_cleanup(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec;
+
+	if (!inst)
+		return;
+
+	vdec = inst->priv;
+	if (vdec)
+		vfree(vdec);
+	inst->priv = NULL;
+	vfree(inst);
+}
+
+static void vdec_init_params(struct vdec_t *vdec)
+{
+	vdec->params.frame_count = 0;
+	vdec->params.end_flag = 0;
+}
+
+static int vdec_start(struct vpu_inst *inst)
+{
+	struct vdec_t *vdec = inst->priv;
+	int stream_buffer_size;
+	int ret;
+
+	if (inst->state != VPU_CODEC_STATE_DEINIT)
+		return 0;
+
+	vpu_trace(inst->dev, "[%d]\n", inst->id);
+	if (!vdec->udata.virt) {
+		vdec->udata.length = 0x1000;
+		ret = vpu_alloc_dma(inst->core, &vdec->udata);
+		if (ret) {
+			dev_err(inst->dev, "[%d] alloc udata fail\n", inst->id);
+			goto error;
+		}
+	}
+
+	if (!inst->stream_buffer.virt) {
+		stream_buffer_size = vpu_iface_get_stream_buffer_size(inst->core);
+		if (stream_buffer_size > 0) {
+			inst->stream_buffer.length = stream_buffer_size;
+			ret = vpu_alloc_dma(inst->core, &inst->stream_buffer);
+			if (ret) {
+				dev_err(inst->dev, "[%d] alloc stream buffer fail\n", inst->id);
+				goto error;
+			}
+			inst->use_stream_buffer = true;
+		}
+	}
+
+	if (inst->use_stream_buffer)
+		vpu_iface_config_stream_buffer(inst, &inst->stream_buffer);
+	vpu_iface_init_instance(inst);
+	vdec->params.udata.base = vdec->udata.phys;
+	vdec->params.udata.size = vdec->udata.length;
+	ret = vpu_iface_set_decode_params(inst, &vdec->params, 0);
+	if (ret) {
+		dev_err(inst->dev, "[%d] set decode params fail\n", inst->id);
+		goto error;
+	}
+
+	vdec_init_params(vdec);
+	ret = vpu_session_start(inst);
+	if (ret) {
+		dev_err(inst->dev, "[%d] start fail\n", inst->id);
+		goto error;
+	}
+
+	vdec_update_state(inst, VPU_CODEC_STATE_STARTED, 0);
+
+	return 0;
+error:
+	vpu_free_dma(&vdec->udata);
+	vpu_free_dma(&inst->stream_buffer);
+	return ret;
+}
+
+static int vdec_start_session(struct vpu_inst *inst, u32 type)
+{
+	struct vdec_t *vdec = inst->priv;
+	int ret = 0;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		if (vdec->reset_codec)
+			vdec_stop(inst, false);
+		if (inst->state == VPU_CODEC_STATE_DEINIT) {
+			ret = vdec_start(inst);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		if (inst->state == VPU_CODEC_STATE_SEEK)
+			vdec_update_state(inst, vdec->state, 1);
+		vdec->eos_received = 0;
+		vpu_process_output_buffer(inst);
+	} else {
+		vdec_cmd_start(inst);
+	}
+	if (inst->state == VPU_CODEC_STATE_ACTIVE)
+		vdec_response_fs_request(inst, false);
+
+	return ret;
+}
+
+static int vdec_stop_session(struct vpu_inst *inst, u32 type)
+{
+	struct vdec_t *vdec = inst->priv;
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return 0;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		vdec_update_state(inst, VPU_CODEC_STATE_SEEK, 0);
+		vdec->drain = 0;
+	} else {
+		if (inst->state != VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
+			vdec_abort(inst);
+
+		vdec->eos_received = 0;
+		vdec_clear_slots(inst);
+	}
+
+	return 0;
+}
+
+static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i)
+{
+	struct vdec_t *vdec = inst->priv;
+	int num = -1;
+
+	switch (i) {
+	case 0:
+		num = scnprintf(str, size,
+				"req_frame_count = %d\ninterlaced = %d\n",
+				vdec->req_frame_count,
+				vdec->codec_info.progressive ? 0 : 1);
+		break;
+	case 1:
+		num = scnprintf(str, size,
+				"mbi: size = 0x%x request = %d, alloc = %d, response = %d\n",
+				vdec->mbi.size,
+				vdec->mbi.req_count,
+				vdec->mbi.count,
+				vdec->mbi.index);
+		break;
+	case 2:
+		num = scnprintf(str, size,
+				"dcp: size = 0x%x request = %d, alloc = %d, response = %d\n",
+				vdec->dcp.size,
+				vdec->dcp.req_count,
+				vdec->dcp.count,
+				vdec->dcp.index);
+		break;
+	case 3:
+		num = scnprintf(str, size, "input_frame_count = %d\n", vdec->params.frame_count);
+		break;
+	case 4:
+		num = scnprintf(str, size, "decoded_frame_count = %d\n", vdec->decoded_frame_count);
+		break;
+	case 5:
+		num = scnprintf(str, size, "display_frame_count = %d\n", vdec->display_frame_count);
+		break;
+	case 6:
+		num = scnprintf(str, size, "sequence = %d\n", vdec->sequence);
+		break;
+	case 7:
+		num = scnprintf(str, size, "drain = %d, eos = %d, source_change = %d\n",
+				vdec->drain, vdec->eos_received, vdec->source_change);
+		break;
+	case 8:
+		num = scnprintf(str, size, "ts_pre_count = %d, frame_depth = %d\n",
+				vdec->ts_pre_count, vdec->frame_depth);
+		break;
+	case 9:
+		num = scnprintf(str, size, "fps = %d/%d\n",
+				vdec->codec_info.frame_rate.numerator,
+				vdec->codec_info.frame_rate.denominator);
+		break;
+	case 10:
+	{
+		s64 timestamp = vdec->timestamp;
+		s64 ts_start = vdec->ts_start;
+		s64 ts_input = vdec->ts_input;
+
+		num = scnprintf(str, size, "timestamp = %9lld.%09lld(%9lld.%09lld, %9lld.%09lld)\n",
+				timestamp / NSEC_PER_SEC,
+				timestamp % NSEC_PER_SEC,
+				ts_start / NSEC_PER_SEC,
+				ts_start % NSEC_PER_SEC,
+				ts_input / NSEC_PER_SEC,
+				ts_input % NSEC_PER_SEC);
+	}
+		break;
+	default:
+		break;
+	}
+
+	return num;
+}
+
+static struct vpu_inst_ops vdec_inst_ops = {
+	.ctrl_init = vdec_ctrl_init,
+	.check_ready = vdec_check_ready,
+	.buf_done = vdec_buf_done,
+	.get_one_frame = vdec_frame_decoded,
+	.stop_done = vdec_stop_done,
+	.event_notify = vdec_event_notify,
+	.release = vdec_release,
+	.cleanup = vdec_cleanup,
+	.start = vdec_start_session,
+	.stop = vdec_stop_session,
+	.process_output = vdec_process_output,
+	.process_capture = vdec_process_capture,
+	.on_queue_empty = vdec_on_queue_empty,
+	.get_debug_info = vdec_get_debug_info,
+	.wait_prepare = vpu_inst_unlock,
+	.wait_finish = vpu_inst_lock,
+};
+
+static void vdec_init(struct file *file)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vdec_t *vdec;
+	struct v4l2_format f;
+
+	vdec = inst->priv;
+	vdec->frame_depth = VDEC_FRAME_DEPTH;
+	vdec->timestamp = VPU_INVALID_TIMESTAMP;
+	vdec->ts_start = VPU_INVALID_TIMESTAMP;
+	vdec->ts_input = VPU_INVALID_TIMESTAMP;
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	vdec_s_fmt(file, &inst->fh, &f);
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12M_8L128;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	vdec_s_fmt(file, &inst->fh, &f);
+}
+
+static int vdec_open(struct file *file)
+{
+	struct vpu_inst *inst;
+	struct vdec_t *vdec;
+	int ret;
+
+	inst = vzalloc(sizeof(*inst));
+	if (!inst)
+		return -ENOMEM;
+
+	vdec = vzalloc(sizeof(*vdec));
+	if (!vdec) {
+		vfree(inst);
+		return -ENOMEM;
+	}
+
+	inst->ops = &vdec_inst_ops;
+	inst->formats = vdec_formats;
+	inst->type = VPU_CORE_TYPE_DEC;
+	inst->priv = vdec;
+
+	ret = vpu_v4l2_open(file, inst);
+	if (ret)
+		return ret;
+
+	vdec->fixed_fmt = false;
+	inst->min_buffer_cap = VDEC_MIN_BUFFER_CAP;
+	vdec_init(file);
+
+	return 0;
+}
+
+static __poll_t vdec_poll(struct file *file, poll_table *wait)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct vb2_queue *src_q, *dst_q;
+	__poll_t ret;
+
+	ret = v4l2_m2m_fop_poll(file, wait);
+	src_q = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
+	dst_q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
+	if (vb2_is_streaming(src_q) && !vb2_is_streaming(dst_q))
+		ret &= (~EPOLLERR);
+	if (!src_q->error && !dst_q->error &&
+	    (vb2_is_streaming(src_q) && list_empty(&src_q->queued_list)) &&
+	    (vb2_is_streaming(dst_q) && list_empty(&dst_q->queued_list)))
+		ret &= (~EPOLLERR);
+
+	return ret;
+}
+
+static const struct v4l2_file_operations vdec_fops = {
+	.owner = THIS_MODULE,
+	.open = vdec_open,
+	.release = vpu_v4l2_close,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = vdec_poll,
+	.mmap = v4l2_m2m_fop_mmap,
+};
+
+const struct v4l2_ioctl_ops *vdec_get_ioctl_ops(void)
+{
+	return &vdec_ioctl_ops;
+}
+
+const struct v4l2_file_operations *vdec_get_fops(void)
+{
+	return &vdec_fops;
+}
-- 
2.33.0

