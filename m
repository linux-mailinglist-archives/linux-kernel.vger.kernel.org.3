Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58FC4BD5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbiBUGMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:12:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345019AbiBUGMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:12:34 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20065.outbound.protection.outlook.com [40.107.2.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9FBC86;
        Sun, 20 Feb 2022 22:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPDxJQ5KprOLdt+O0pxo8P1T6tT6TisR04H8RkGy5SufXelFQ7EJ0NDaE7NWp70hKE+eKIg3+ovx8MF8LbOCEl7RCdW2rsEQYEiAZEHDekXac9Dy+OAPx8JI7JacqJu8u7p3kzaD9ess7nSSZbVcL8P8n8qJ6UtTPR4wfBYMc2Q2KLbvjD4los6MGfYE7kkO8L/6n1+mKU0+fPP2fz4je3og91Ivs1Y89hJp05o858iWDbAOy386+lmQSvyja0sbGAsIeZLPfQmC+toZF6E3xopJKb+MPpIiQSsSSC580HpvflW4xLkDkz3/mGPdmZ9bWs+Ml0AXJHV4GN6abmpbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa2q21vSCYb4PGVbCvZZk3Xg5QVz0njkVo4CaqCTqeI=;
 b=SaPqJ1RQZ/R8f10VULhVaAVDooZI6ub37SPOok5RK2VNRNjXiw+/SbF89B/5czOC4N/MibrM12xNMb/Ta3isvCS9I3rc6bKottK2ETJI0UZ2Or9u2AL8rNsiahZGB5CiHKKGudiGlgSSf1mrqD6yCIBbhGcN+AL3IY+QTBDFxjKkfpUZukyCQ7ABFyP7J/4YwBiU5VE/9oRpGJ1N+Ehd5xYqsM5jEOUPkTUbF7v0MxOs+PzjWpx40eY+3EdDyrHz6xkKp32xEBCKd2PYqTN4nxLLdwcod7+ep4MfZOfyC/66yYdZEZx9n3vSJB5e0V5h+FLaT/aHWlYQXnUbWJ5bGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa2q21vSCYb4PGVbCvZZk3Xg5QVz0njkVo4CaqCTqeI=;
 b=DIWAJwJxa66khf6xnwrkFHRQ7ecxRKQFTvB/XIJZ/xuiLgvLiUArlwK7djwqXXeZWyT7LR8vYMLop/LydmYvdckRnMlfMH7uf3qL8Dw12jOoA0sz9q2gzAWtkvNHIwRKvZ5hT6LMwEExH0Ihv2fUXQH3qe8yvkb354ZA+3wF3Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:11:52 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 06:11:52 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 07/13] media: amphion: add v4l2 m2m vpu encoder stateful driver
Date:   Mon, 21 Feb 2022 14:10:26 +0800
Message-Id: <a40c2d467ef38baaef1402ff687e43bba91e99ae.1645422822.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645422822.git.ming.qian@nxp.com>
References: <cover.1645422822.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 909eb00b-8cb0-4e50-f237-08d9f5010da6
X-MS-TrafficTypeDiagnostic: PR3PR04MB7322:EE_
X-Microsoft-Antispam-PRVS: <PR3PR04MB73226708CF97707AE5D78BF2E73A9@PR3PR04MB7322.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNe3CWdMrVB1Zo+qMHYiCQDgOqhtAVEdBY4feXwkU4hFSM5ezUHbtco1cbmKaRhzVNFNHhOLaz/oOXUkYWjOsvvkYKfDixHtwElAMyMo/k5O93UA8x2CvABDbK1meBA4r87SmMqwdLyI+qADsoE7omF8/5/A10I2evesVkZOynfVYMzFoQWHSoDiiDwtoerw+4fxnMAuRi6ui2/8depNPgoefoKnpuLDmEw3XAvmGlHxuqHff1O7ou//nY2gGJowXTOww5rTE9NtXP50u40fUnFx43Wk2BNALTolO9pfGJbtBRk3KdIEByCPuAtLtOnailcxca2NFDhut2eZWmUG1f8QtcLhRYu0Id3EUP5dSgmR1uTp1pVOCYOfeuUXNbOG2DwdSIPXMX0JZUSyoSk/bNAZB35NVWW666vOgh99kYeGGR58TIYt4l9HCA1h5BBqX1XoXWH7i29bw6SD6XNHMRBn9QJ2jSw15L7Ux37NN8WDy2G9F/mbYCMTZn8kff4CL7j5A0IKqC6tq6ECMT2doVqaruDdCExX5LmAEeXFjZnWfV3+sjsFNikYLufDGU/GyzWCjQr+UrFEVwPIfDNsXCoQ3lefvDE3wlMY/N22odfB4ptss6aQZafZkRbA9szt6DDSRgPDkF5U1+DPc0/UalQFB2xgeE0bokUFMXhJTM8nA+CWM5ybk5AxRon+RUWiVfR14rEoXiyqkF9OXPnT5funOT5infvJ0wiTmf2U+9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(83380400001)(66946007)(66556008)(36756003)(44832011)(26005)(186003)(2906002)(30864003)(508600001)(316002)(86362001)(7416002)(5660300002)(38350700002)(38100700002)(8936002)(2616005)(4326008)(52116002)(8676002)(6666004)(6506007)(6486002)(6512007)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fnF+wLTnvLWDttPlKy3LvmUbRacMXTz0VBhpX97asWbJ2mjzvah6Av03vizO?=
 =?us-ascii?Q?sfC4G1M+N/OO3hTJZRzRl7F1cNG2eWFGqaZrAS0dCqETmKxyeIDxDFAZotkj?=
 =?us-ascii?Q?EoK4BAfVSR0lbffKmXtrg+R+nxdg+/zFWH+iLFXHBo244AUIfEnbVYwYdqFX?=
 =?us-ascii?Q?WxFc2IMd7AhV+vgww15qzuiARKdy1P9fQnfiW7W+XxH2q3CS+CbpO9NLrZcx?=
 =?us-ascii?Q?8deeLN6W6j165Sk3AjDri5rxvVeJARn6AnVnWtId44qOfXeKq9pg/NEjPQml?=
 =?us-ascii?Q?d8ep+KhoC6tAMUjYWlAs01jDlEKo4I38Wt7AdKtGDzQ7/x+WXMXA2odvtAHT?=
 =?us-ascii?Q?KPeiJWsZeto/AibremxOaf5dQH03yNbI7uwDwiZS7NfbHCItfoAia02p8xpT?=
 =?us-ascii?Q?K5XQ1bkdf0vR295Re/zr8gDmN162eElfwTYU5WZjBX17AI0EJpvrpi/VoIta?=
 =?us-ascii?Q?xCrC5xap1rdHdRiE6TaO8K2PNXExz6B3TvZpQ/uDO/oQcwO/tHBTHob7XR0l?=
 =?us-ascii?Q?HP7VzQhI9QBgGe1Y68xVyKGYIVZoYKJ7Iyd2V6OMISNBU6D/rx9ZjjOhTV6M?=
 =?us-ascii?Q?mv+gxnvz6E37BsezGuc0CdIsf0/eH2ZeBWFr220P/VkInc01AmeFkgT77gGA?=
 =?us-ascii?Q?Zamju5lnY0zJsoUEyaupcc877EbOPx3DEZV8XGdnZvtvOfwIPEYbpEjsBQt9?=
 =?us-ascii?Q?M3qpWFUzC4LibXZFAR4cgQeqxQcdghbFIGAw68ZAPV6gfTeZ1ByEBLTG/VKL?=
 =?us-ascii?Q?s7D02IBCRRrnQMPLy949xvwkv0BSGLmjrZJrSgkWCpZGJM02FQLfHDU3MpSP?=
 =?us-ascii?Q?kGasHD9ntfMQdT0PGSRu4VjaTzjG3DsMAklP/joo93prDl2QbxWh7qEpnKj2?=
 =?us-ascii?Q?LJfZP1pWtr/ZwOc+eJGfvL+E3COLnVsR5E9gUqEyyxF/51sPwy71F+L8GJKv?=
 =?us-ascii?Q?wxH0kKFL1sCjKE3yCq9taCbztJHODVrME7bxY1Wzv5CocYNTYYa18o6imjuq?=
 =?us-ascii?Q?5h1Ym8NJc/zjDv9aaKMg8/+l/UEQQv7imKDZ4dSwxqpmE8KJSS3zqtR9QYnY?=
 =?us-ascii?Q?1eV1TQRS81A0Eki5DnLdOLmnbH1NIBpGFrSBEBWIimZF9x2GSiIDbMD+8e3m?=
 =?us-ascii?Q?lkh0H4aLZdjQinZzOjJyFkQZI7+eXJNSadd4G8pwgfu22y06JZW3eppk0sh3?=
 =?us-ascii?Q?LxYUC0rNJZNZpw9/oSle5L22pk8ZdNSD4aNKE5NftU/F1+TwQuUj1Hhh1u+P?=
 =?us-ascii?Q?YKPkIDsNfhMIPGEs61rhLBbUXOti8gbdzpQrv2Xwpn0erl7G9cOhaiOVN93U?=
 =?us-ascii?Q?kJlKpfg9GIG2pxJTUFh+FDohrnvPSiWc9GF794ygh8aMVqr5FBtPl59fYs0J?=
 =?us-ascii?Q?iYrVSwKW1FJy1lsqR6GyZ63vbW5rrtOd7Hf3S3o9vfKZTk4b/bgvZur0lMQ8?=
 =?us-ascii?Q?88BRXq87m+j0Au59/Kbv4SQ478xH554FTDtAwyOJ0pA43hkju2Ag4ER0MuTo?=
 =?us-ascii?Q?AYXLEjNfxC3i0Dg06WL+Y3DR3OtGVS4NbR1pYl382GalY1GbztPN1iifUfDr?=
 =?us-ascii?Q?VyNcDrgU+nlURq/KYaqVMT73TCjfPU4UPqO8iMHos0oBYFZdMucHA9QQqri9?=
 =?us-ascii?Q?VHuA9UE8OQkmm5PfUnnc+rk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909eb00b-8cb0-4e50-f237-08d9f5010da6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:11:52.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSkaivbN13bAm7T3XDeUb4ETohcQ40I0ZDj9AsL1Rpe03FW6O9F0lEf+SA0ZX2NgUnGh58N8ZjoepYPdtJGmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This consists of video encoder implementation plus encoder controls.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/amphion/venc.c | 1365 +++++++++++++++++++++++++
 1 file changed, 1365 insertions(+)
 create mode 100644 drivers/media/platform/amphion/venc.c

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
new file mode 100644
index 000000000000..3b96d6f91e6e
--- /dev/null
+++ b/drivers/media/platform/amphion/venc.c
@@ -0,0 +1,1365 @@
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
+#include <linux/delay.h>
+#include <linux/videodev2.h>
+#include <linux/ktime.h>
+#include <linux/rational.h>
+#include <linux/vmalloc.h>
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
+#define VENC_OUTPUT_ENABLE	BIT(0)
+#define VENC_CAPTURE_ENABLE	BIT(1)
+#define VENC_ENABLE_MASK	(VENC_OUTPUT_ENABLE | VENC_CAPTURE_ENABLE)
+#define VENC_MAX_BUF_CNT	8
+
+struct venc_t {
+	struct vpu_encode_params params;
+	u32 request_key_frame;
+	u32 input_ready;
+	u32 cpb_size;
+	bool bitrate_change;
+
+	struct vpu_buffer enc[VENC_MAX_BUF_CNT];
+	struct vpu_buffer ref[VENC_MAX_BUF_CNT];
+	struct vpu_buffer act[VENC_MAX_BUF_CNT];
+	struct list_head frames;
+	u32 frame_count;
+	u32 encode_count;
+	u32 ready_count;
+	u32 enable;
+	u32 stopped;
+
+	u32 skipped_count;
+	u32 skipped_bytes;
+
+	wait_queue_head_t wq;
+};
+
+struct venc_frame_t {
+	struct list_head list;
+	struct vpu_enc_pic_info info;
+	u32 bytesused;
+	s64 timestamp;
+};
+
+static const struct vpu_format venc_formats[] = {
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12M,
+		.num_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_H264,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},
+	{0, 0, 0, 0},
+};
+
+static int venc_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, "amphion-vpu", sizeof(cap->driver));
+	strscpy(cap->card, "amphion vpu encoder", sizeof(cap->card));
+	strscpy(cap->bus_info, "platform: amphion-vpu", sizeof(cap->bus_info));
+
+	return 0;
+}
+
+static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_format *fmt;
+
+	memset(f->reserved, 0, sizeof(f->reserved));
+	fmt = vpu_helper_enum_format(inst, f->type, f->index);
+	if (!fmt)
+		return -EINVAL;
+
+	f->pixelformat = fmt->pixfmt;
+	f->flags = fmt->flags;
+
+	return 0;
+}
+
+static int venc_enum_framesizes(struct file *file, void *fh, struct v4l2_frmsizeenum *fsize)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_core_resources *res;
+
+	if (!fsize || fsize->index)
+		return -EINVAL;
+
+	if (!vpu_helper_find_format(inst, 0, fsize->pixel_format))
+		return -EINVAL;
+
+	res = vpu_get_resource(inst);
+	if (!res)
+		return -EINVAL;
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise.max_width = res->max_width;
+	fsize->stepwise.max_height = res->max_height;
+	fsize->stepwise.min_width = res->min_width;
+	fsize->stepwise.min_height = res->min_height;
+	fsize->stepwise.step_width = res->step_width;
+	fsize->stepwise.step_height = res->step_height;
+
+	return 0;
+}
+
+static int venc_enum_frameintervals(struct file *file, void *fh, struct v4l2_frmivalenum *fival)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_core_resources *res;
+
+	if (!fival || fival->index)
+		return -EINVAL;
+
+	if (!vpu_helper_find_format(inst, 0, fival->pixel_format))
+		return -EINVAL;
+
+	if (!fival->width || !fival->height)
+		return -EINVAL;
+
+	res = vpu_get_resource(inst);
+	if (!res)
+		return -EINVAL;
+	if (fival->width < res->min_width || fival->width > res->max_width ||
+	    fival->height < res->min_height || fival->height > res->max_height)
+		return -EINVAL;
+
+	fival->type = V4L2_FRMIVAL_TYPE_CONTINUOUS;
+	fival->stepwise.min.numerator = 1;
+	fival->stepwise.min.denominator = USHRT_MAX;
+	fival->stepwise.max.numerator = USHRT_MAX;
+	fival->stepwise.max.denominator = 1;
+	fival->stepwise.step.numerator = 1;
+	fival->stepwise.step.denominator = 1;
+
+	return 0;
+}
+
+static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
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
+	f->fmt.pix_mp.colorspace = venc->params.color.primaries;
+	f->fmt.pix_mp.xfer_func = venc->params.color.transfer;
+	f->fmt.pix_mp.ycbcr_enc = venc->params.color.matrix;
+	f->fmt.pix_mp.quantization = venc->params.color.full_range;
+
+	return 0;
+}
+
+static int venc_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+
+	vpu_try_fmt_common(inst, f);
+
+	return 0;
+}
+
+static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_format *fmt;
+	struct vpu_format *cur_fmt;
+	struct vb2_queue *q;
+	struct venc_t *venc = inst->priv;
+	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
+	int i;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
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
+
+	cur_fmt->pixfmt = fmt->pixfmt;
+	cur_fmt->num_planes = fmt->num_planes;
+	cur_fmt->flags = fmt->flags;
+	cur_fmt->width = pix_mp->width;
+	cur_fmt->height = pix_mp->height;
+	for (i = 0; i < fmt->num_planes; i++) {
+		cur_fmt->sizeimage[i] = pix_mp->plane_fmt[i].sizeimage;
+		cur_fmt->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
+	}
+
+	if (pix_mp->field != V4L2_FIELD_ANY)
+		cur_fmt->field = pix_mp->field;
+
+	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
+		venc->params.input_format = cur_fmt->pixfmt;
+		venc->params.src_stride = cur_fmt->bytesperline[0];
+		venc->params.src_width = cur_fmt->width;
+		venc->params.src_height = cur_fmt->height;
+		venc->params.crop.left = 0;
+		venc->params.crop.top = 0;
+		venc->params.crop.width = cur_fmt->width;
+		venc->params.crop.height = cur_fmt->height;
+	} else {
+		venc->params.codec_format = cur_fmt->pixfmt;
+		venc->params.out_width = cur_fmt->width;
+		venc->params.out_height = cur_fmt->height;
+	}
+
+	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
+		if (!vpu_color_check_primaries(pix_mp->colorspace)) {
+			venc->params.color.primaries = pix_mp->colorspace;
+			vpu_color_get_default(venc->params.color.primaries,
+					      &venc->params.color.transfer,
+					      &venc->params.color.matrix,
+					      &venc->params.color.full_range);
+		}
+		if (!vpu_color_check_transfers(pix_mp->xfer_func))
+			venc->params.color.transfer = pix_mp->xfer_func;
+		if (!vpu_color_check_matrix(pix_mp->ycbcr_enc))
+			venc->params.color.matrix = pix_mp->ycbcr_enc;
+		if (!vpu_color_check_full_range(pix_mp->quantization))
+			venc->params.color.full_range = pix_mp->quantization;
+	}
+
+	pix_mp->colorspace = venc->params.color.primaries;
+	pix_mp->xfer_func = venc->params.color.transfer;
+	pix_mp->ycbcr_enc = venc->params.color.matrix;
+	pix_mp->quantization = venc->params.color.full_range;
+
+	return 0;
+}
+
+static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
+	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+
+	if (!parm)
+		return -EINVAL;
+
+	if (!vpu_helper_check_type(inst, parm->type))
+		return -EINVAL;
+
+	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	parm->parm.capture.readbuffers = 0;
+	timeperframe->numerator = venc->params.frame_rate.numerator;
+	timeperframe->denominator = venc->params.frame_rate.denominator;
+
+	return 0;
+}
+
+static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
+	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+	unsigned long n, d;
+
+	if (!parm)
+		return -EINVAL;
+
+	if (!vpu_helper_check_type(inst, parm->type))
+		return -EINVAL;
+
+	if (!timeperframe->numerator)
+		timeperframe->numerator = venc->params.frame_rate.numerator;
+	if (!timeperframe->denominator)
+		timeperframe->denominator = venc->params.frame_rate.denominator;
+
+	venc->params.frame_rate.numerator = timeperframe->numerator;
+	venc->params.frame_rate.denominator = timeperframe->denominator;
+
+	rational_best_approximation(venc->params.frame_rate.numerator,
+				    venc->params.frame_rate.denominator,
+				    venc->params.frame_rate.numerator,
+				    venc->params.frame_rate.denominator,
+				    &n, &d);
+	venc->params.frame_rate.numerator = n;
+	venc->params.frame_rate.denominator = d;
+
+	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	memset(parm->parm.capture.reserved, 0, sizeof(parm->parm.capture.reserved));
+
+	return 0;
+}
+
+static int venc_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc = inst->priv;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->out_format.width;
+		s->r.height = inst->out_format.height;
+		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r = venc->params.crop;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int venc_valid_crop(struct venc_t *venc, const struct vpu_core_resources *res)
+{
+	struct v4l2_rect *rect = NULL;
+	u32 min_width;
+	u32 min_height;
+	u32 src_width;
+	u32 src_height;
+
+	rect = &venc->params.crop;
+	min_width = res->min_width;
+	min_height = res->min_height;
+	src_width = venc->params.src_width;
+	src_height = venc->params.src_height;
+
+	if (rect->width == 0 || rect->height == 0)
+		return -EINVAL;
+	if (rect->left > src_width - min_width || rect->top > src_height - min_height)
+		return -EINVAL;
+
+	rect->width = min(rect->width, src_width - rect->left);
+	rect->width = max_t(u32, rect->width, min_width);
+
+	rect->height = min(rect->height, src_height - rect->top);
+	rect->height = max_t(u32, rect->height, min_height);
+
+	return 0;
+}
+
+static int venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
+{
+	struct vpu_inst *inst = to_inst(file);
+	const struct vpu_core_resources *res;
+	struct venc_t *venc = inst->priv;
+
+	res = vpu_get_resource(inst);
+	if (!res)
+		return -EINVAL;
+
+	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		return -EINVAL;
+	if (s->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	venc->params.crop.left = ALIGN(s->r.left, res->step_width);
+	venc->params.crop.top = ALIGN(s->r.top, res->step_height);
+	venc->params.crop.width = ALIGN(s->r.width, res->step_width);
+	venc->params.crop.height = ALIGN(s->r.height, res->step_height);
+	if (venc_valid_crop(venc, res)) {
+		venc->params.crop.left = 0;
+		venc->params.crop.top = 0;
+		venc->params.crop.width = venc->params.src_width;
+		venc->params.crop.height = venc->params.src_height;
+	}
+
+	inst->crop = venc->params.crop;
+
+	return 0;
+}
+
+static int venc_drain(struct vpu_inst *inst)
+{
+	struct venc_t *venc = inst->priv;
+	int ret;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+	if (inst->state != VPU_CODEC_STATE_DRAIN)
+		return 0;
+
+	if (v4l2_m2m_num_src_bufs_ready(inst->fh.m2m_ctx))
+		return 0;
+
+	if (!venc->input_ready)
+		return 0;
+
+	venc->input_ready = false;
+	vpu_trace(inst->dev, "[%d]\n", inst->id);
+	ret = vpu_session_stop(inst);
+	if (ret)
+		return ret;
+	inst->state = VPU_CODEC_STATE_STOP;
+	wake_up_all(&venc->wq);
+
+	return 0;
+}
+
+static int venc_request_eos(struct vpu_inst *inst)
+{
+	inst->state = VPU_CODEC_STATE_DRAIN;
+	venc_drain(inst);
+
+	return 0;
+}
+
+static int venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
+{
+	struct vpu_inst *inst = to_inst(file);
+	int ret;
+
+	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
+	if (ret)
+		return ret;
+
+	vpu_inst_lock(inst);
+	if (cmd->cmd == V4L2_ENC_CMD_STOP) {
+		if (inst->state == VPU_CODEC_STATE_DEINIT)
+			vpu_set_last_buffer_dequeued(inst);
+		else
+			venc_request_eos(inst);
+	}
+	vpu_inst_unlock(inst);
+
+	return 0;
+}
+
+static int venc_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
+{
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		return v4l2_event_subscribe(fh, sub, 0, NULL);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct v4l2_ioctl_ops venc_ioctl_ops = {
+	.vidioc_querycap               = venc_querycap,
+	.vidioc_enum_fmt_vid_cap       = venc_enum_fmt,
+	.vidioc_enum_fmt_vid_out       = venc_enum_fmt,
+	.vidioc_enum_framesizes        = venc_enum_framesizes,
+	.vidioc_enum_frameintervals    = venc_enum_frameintervals,
+	.vidioc_g_fmt_vid_cap_mplane   = venc_g_fmt,
+	.vidioc_g_fmt_vid_out_mplane   = venc_g_fmt,
+	.vidioc_try_fmt_vid_cap_mplane = venc_try_fmt,
+	.vidioc_try_fmt_vid_out_mplane = venc_try_fmt,
+	.vidioc_s_fmt_vid_cap_mplane   = venc_s_fmt,
+	.vidioc_s_fmt_vid_out_mplane   = venc_s_fmt,
+	.vidioc_g_parm                 = venc_g_parm,
+	.vidioc_s_parm                 = venc_s_parm,
+	.vidioc_g_selection            = venc_g_selection,
+	.vidioc_s_selection            = venc_s_selection,
+	.vidioc_try_encoder_cmd        = v4l2_m2m_ioctl_try_encoder_cmd,
+	.vidioc_encoder_cmd            = venc_encoder_cmd,
+	.vidioc_subscribe_event        = venc_subscribe_event,
+	.vidioc_unsubscribe_event      = v4l2_event_unsubscribe,
+	.vidioc_reqbufs                = v4l2_m2m_ioctl_reqbufs,
+	.vidioc_querybuf               = v4l2_m2m_ioctl_querybuf,
+	.vidioc_create_bufs	       = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_prepare_buf	       = v4l2_m2m_ioctl_prepare_buf,
+	.vidioc_qbuf                   = v4l2_m2m_ioctl_qbuf,
+	.vidioc_expbuf                 = v4l2_m2m_ioctl_expbuf,
+	.vidioc_dqbuf                  = v4l2_m2m_ioctl_dqbuf,
+	.vidioc_streamon               = v4l2_m2m_ioctl_streamon,
+	.vidioc_streamoff              = v4l2_m2m_ioctl_streamoff,
+};
+
+static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct vpu_inst *inst = ctrl_to_inst(ctrl);
+	struct venc_t *venc = inst->priv;
+	int ret = 0;
+
+	vpu_inst_lock(inst);
+	switch (ctrl->id) {
+	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
+		venc->params.profile = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
+		venc->params.level = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
+		venc->params.rc_enable = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
+		venc->params.rc_mode = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_BITRATE:
+		if (ctrl->val != venc->params.bitrate)
+			venc->bitrate_change = true;
+		venc->params.bitrate = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:
+		venc->params.bitrate_max = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_GOP_SIZE:
+		venc->params.gop_length = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_B_FRAMES:
+		venc->params.bframes = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP:
+		venc->params.i_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP:
+		venc->params.p_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP:
+		venc->params.b_frame_qp = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
+		venc->request_key_frame = 1;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE:
+		venc->cpb_size = ctrl->val * 1024;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE:
+		venc->params.sar.enable = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC:
+		venc->params.sar.idc = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_WIDTH:
+		venc->params.sar.width = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_HEIGHT:
+		venc->params.sar.height = ctrl->val;
+		break;
+	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	vpu_inst_unlock(inst);
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops venc_ctrl_ops = {
+	.s_ctrl = venc_op_s_ctrl,
+	.g_volatile_ctrl = vpu_helper_g_volatile_ctrl,
+};
+
+static int venc_ctrl_init(struct vpu_inst *inst)
+{
+	struct v4l2_ctrl *ctrl;
+	int ret;
+
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 20);
+	if (ret)
+		return ret;
+
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+			       V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+			       ~((1 << V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
+				 (1 << V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
+				 (1 << V4L2_MPEG_VIDEO_H264_PROFILE_HIGH)),
+			       V4L2_MPEG_VIDEO_H264_PROFILE_HIGH);
+
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_H264_LEVEL,
+			       V4L2_MPEG_VIDEO_H264_LEVEL_5_1,
+			       0x0,
+			       V4L2_MPEG_VIDEO_H264_LEVEL_4_0);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE, 0, 1, 1, 1);
+
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
+			       V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
+			       ~((1 << V4L2_MPEG_VIDEO_BITRATE_MODE_VBR) |
+				 (1 << V4L2_MPEG_VIDEO_BITRATE_MODE_CBR)),
+			       V4L2_MPEG_VIDEO_BITRATE_MODE_CBR);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_BITRATE,
+			  BITRATE_MIN,
+			  BITRATE_MAX,
+			  BITRATE_STEP,
+			  BITRATE_DEFAULT);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_BITRATE_PEAK,
+			  BITRATE_MIN, BITRATE_MAX,
+			  BITRATE_STEP,
+			  BITRATE_DEFAULT_PEAK);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_GOP_SIZE, 0, (1 << 16) - 1, 1, 30);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_B_FRAMES, 0, 4, 1, 0);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP, 1, 51, 1, 26);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP, 1, 51, 1, 28);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP, 1, 51, 1, 30);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+				 V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+				 V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 2);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE, 64, 10240, 1, 1024);
+
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE, 0, 1, 1, 1);
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC,
+			       V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED,
+			       0x0,
+			       V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_1x1);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_WIDTH,
+			  0, USHRT_MAX, 1, 1);
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_H264_VUI_EXT_SAR_HEIGHT,
+			  0, USHRT_MAX, 1, 1);
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_HEADER_MODE,
+			       V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
+			       ~(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
+			       V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME);
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
+static bool venc_check_ready(struct vpu_inst *inst, unsigned int type)
+{
+	struct venc_t *venc = inst->priv;
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		if (vpu_helper_get_free_space(inst) < venc->cpb_size)
+			return false;
+		return venc->input_ready;
+	}
+
+	if (list_empty(&venc->frames))
+		return false;
+	return true;
+}
+
+static u32 venc_get_enable_mask(u32 type)
+{
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		return VENC_OUTPUT_ENABLE;
+	else
+		return VENC_CAPTURE_ENABLE;
+}
+
+static void venc_set_enable(struct venc_t *venc, u32 type, int enable)
+{
+	u32 mask = venc_get_enable_mask(type);
+
+	if (enable)
+		venc->enable |= mask;
+	else
+		venc->enable &= ~mask;
+}
+
+static u32 venc_get_enable(struct venc_t *venc, u32 type)
+{
+	return venc->enable & venc_get_enable_mask(type);
+}
+
+static void venc_input_done(struct vpu_inst *inst)
+{
+	struct venc_t *venc = inst->priv;
+
+	vpu_inst_lock(inst);
+	venc->input_ready = true;
+	vpu_process_output_buffer(inst);
+	if (inst->state == VPU_CODEC_STATE_DRAIN)
+		venc_drain(inst);
+	vpu_inst_unlock(inst);
+}
+
+/*
+ * It's hardware limitation, that there may be several bytes
+ * redundant data at the beginning of frame.
+ * For android platform, the redundant data may cause cts test fail
+ * So driver will strip them
+ */
+static int venc_precheck_encoded_frame(struct vpu_inst *inst, struct venc_frame_t *frame)
+{
+	struct venc_t *venc;
+	int skipped;
+
+	if (!inst || !frame || !frame->bytesused)
+		return -EINVAL;
+
+	venc = inst->priv;
+	skipped = vpu_helper_find_startcode(&inst->stream_buffer,
+					    inst->cap_format.pixfmt,
+					    frame->info.wptr - inst->stream_buffer.phys,
+					    frame->bytesused);
+	if (skipped > 0) {
+		frame->bytesused -= skipped;
+		frame->info.wptr = vpu_helper_step_walk(&inst->stream_buffer,
+							frame->info.wptr, skipped);
+		venc->skipped_bytes += skipped;
+		venc->skipped_count++;
+	}
+
+	return 0;
+}
+
+static int venc_get_one_encoded_frame(struct vpu_inst *inst,
+				      struct venc_frame_t *frame,
+				      struct vb2_v4l2_buffer *vbuf)
+{
+	struct venc_t *venc = inst->priv;
+
+	if (!vbuf)
+		return -EAGAIN;
+
+	if (!venc_get_enable(inst->priv, vbuf->vb2_buf.type)) {
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+		return 0;
+	}
+	if (frame->bytesused > vbuf->vb2_buf.planes[0].length) {
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+		return -ENOMEM;
+	}
+
+	venc_precheck_encoded_frame(inst, frame);
+
+	if (frame->bytesused) {
+		u32 rptr = frame->info.wptr;
+		void *dst = vb2_plane_vaddr(&vbuf->vb2_buf, 0);
+
+		vpu_helper_copy_from_stream_buffer(&inst->stream_buffer,
+						   &rptr, frame->bytesused, dst);
+		vpu_iface_update_stream_buffer(inst, rptr, 0);
+	}
+	vb2_set_plane_payload(&vbuf->vb2_buf, 0, frame->bytesused);
+	vbuf->sequence = frame->info.frame_id;
+	vbuf->vb2_buf.timestamp = frame->info.timestamp;
+	vbuf->field = inst->cap_format.field;
+	vbuf->flags |= frame->info.pic_type;
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
+	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, frame->info.timestamp);
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+	venc->ready_count++;
+
+	if (vbuf->flags & V4L2_BUF_FLAG_KEYFRAME)
+		dev_dbg(inst->dev, "[%d][%d]key frame\n", inst->id, frame->info.frame_id);
+
+	return 0;
+}
+
+static int venc_get_encoded_frames(struct vpu_inst *inst)
+{
+	struct venc_t *venc;
+	struct venc_frame_t *frame;
+	struct venc_frame_t *tmp;
+
+	if (!inst || !inst->priv || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	venc = inst->priv;
+	list_for_each_entry_safe(frame, tmp, &venc->frames, list) {
+		if (venc_get_one_encoded_frame(inst, frame,
+					       v4l2_m2m_dst_buf_remove(inst->fh.m2m_ctx)))
+			break;
+		list_del_init(&frame->list);
+		vfree(frame);
+	}
+
+	return 0;
+}
+
+static int venc_frame_encoded(struct vpu_inst *inst, void *arg)
+{
+	struct vpu_enc_pic_info *info = arg;
+	struct venc_frame_t *frame;
+	struct venc_t *venc;
+	int ret = 0;
+
+	if (!inst || !info)
+		return -EINVAL;
+	venc = inst->priv;
+	frame = vzalloc(sizeof(*frame));
+	if (!frame)
+		return -ENOMEM;
+
+	memcpy(&frame->info, info, sizeof(frame->info));
+	frame->bytesused = info->frame_size;
+
+	vpu_inst_lock(inst);
+	list_add_tail(&frame->list, &venc->frames);
+	venc->encode_count++;
+	venc_get_encoded_frames(inst);
+	vpu_inst_unlock(inst);
+
+	return ret;
+}
+
+static void venc_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
+{
+	struct vb2_v4l2_buffer *vbuf;
+
+	if (!inst || !frame || !inst->fh.m2m_ctx)
+		return;
+
+	vpu_inst_lock(inst);
+	if (!venc_get_enable(inst->priv, frame->type))
+		goto exit;
+	vbuf = vpu_find_buf_by_sequence(inst, frame->type, frame->sequence);
+	if (!vbuf) {
+		dev_err(inst->dev, "[%d] can't find buf: type %d, sequence %d\n",
+			inst->id, frame->type, frame->sequence);
+		goto exit;
+	}
+
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
+	if (V4L2_TYPE_IS_OUTPUT(frame->type))
+		v4l2_m2m_src_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
+	else
+		v4l2_m2m_dst_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
+	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+exit:
+	vpu_inst_unlock(inst);
+}
+
+static void venc_set_last_buffer_dequeued(struct vpu_inst *inst)
+{
+	struct venc_t *venc = inst->priv;
+
+	if (venc->stopped && list_empty(&venc->frames))
+		vpu_set_last_buffer_dequeued(inst);
+}
+
+static void venc_stop_done(struct vpu_inst *inst)
+{
+	struct venc_t *venc = inst->priv;
+
+	vpu_inst_lock(inst);
+	venc->stopped = true;
+	venc_set_last_buffer_dequeued(inst);
+	vpu_inst_unlock(inst);
+
+	wake_up_all(&venc->wq);
+}
+
+static void venc_event_notify(struct vpu_inst *inst, u32 event, void *data)
+{
+}
+
+static void venc_release(struct vpu_inst *inst)
+{
+}
+
+static void venc_cleanup(struct vpu_inst *inst)
+{
+	struct venc_t *venc;
+
+	if (!inst)
+		return;
+
+	venc = inst->priv;
+	if (venc)
+		vfree(venc);
+	inst->priv = NULL;
+	vfree(inst);
+}
+
+static int venc_start_session(struct vpu_inst *inst, u32 type)
+{
+	struct venc_t *venc = inst->priv;
+	int stream_buffer_size;
+	int ret;
+
+	venc_set_enable(venc, type, 1);
+	if ((venc->enable & VENC_ENABLE_MASK) != VENC_ENABLE_MASK)
+		return 0;
+
+	vpu_iface_init_instance(inst);
+	stream_buffer_size = vpu_iface_get_stream_buffer_size(inst->core);
+	if (stream_buffer_size > 0) {
+		inst->stream_buffer.length = max_t(u32, stream_buffer_size, venc->cpb_size * 3);
+		ret = vpu_alloc_dma(inst->core, &inst->stream_buffer);
+		if (ret)
+			goto error;
+
+		inst->use_stream_buffer = true;
+		vpu_iface_config_stream_buffer(inst, &inst->stream_buffer);
+	}
+
+	ret = vpu_iface_set_encode_params(inst, &venc->params, 0);
+	if (ret)
+		goto error;
+	ret = vpu_session_configure_codec(inst);
+	if (ret)
+		goto error;
+
+	inst->state = VPU_CODEC_STATE_CONFIGURED;
+	/*vpu_iface_config_memory_resource*/
+
+	/*config enc expert mode parameter*/
+	ret = vpu_iface_set_encode_params(inst, &venc->params, 1);
+	if (ret)
+		goto error;
+
+	ret = vpu_session_start(inst);
+	if (ret)
+		goto error;
+	inst->state = VPU_CODEC_STATE_STARTED;
+
+	venc->bitrate_change = false;
+	venc->input_ready = true;
+	venc->frame_count = 0;
+	venc->encode_count = 0;
+	venc->ready_count = 0;
+	venc->stopped = false;
+	vpu_process_output_buffer(inst);
+	if (venc->frame_count == 0)
+		dev_err(inst->dev, "[%d] there is no input when starting\n", inst->id);
+
+	return 0;
+error:
+	venc_set_enable(venc, type, 0);
+	inst->state = VPU_CODEC_STATE_DEINIT;
+
+	vpu_free_dma(&inst->stream_buffer);
+	return ret;
+}
+
+static void venc_cleanup_mem_resource(struct vpu_inst *inst)
+{
+	struct venc_t *venc;
+	u32 i;
+
+	venc = inst->priv;
+
+	for (i = 0; i < ARRAY_SIZE(venc->enc); i++)
+		vpu_free_dma(&venc->enc[i]);
+	for (i = 0; i < ARRAY_SIZE(venc->ref); i++)
+		vpu_free_dma(&venc->ref[i]);
+	for (i = 0; i < ARRAY_SIZE(venc->act); i++)
+		vpu_free_dma(&venc->act[i]);
+}
+
+static void venc_request_mem_resource(struct vpu_inst *inst,
+				      u32 enc_frame_size,
+				      u32 enc_frame_num,
+				      u32 ref_frame_size,
+				      u32 ref_frame_num,
+				      u32 act_frame_size,
+				      u32 act_frame_num)
+{
+	struct venc_t *venc;
+	u32 i;
+	int ret;
+
+	venc = inst->priv;
+	if (enc_frame_num > ARRAY_SIZE(venc->enc)) {
+		dev_err(inst->dev, "[%d] enc num(%d) is out of range\n", inst->id, enc_frame_num);
+		return;
+	}
+	if (ref_frame_num > ARRAY_SIZE(venc->ref)) {
+		dev_err(inst->dev, "[%d] ref num(%d) is out of range\n", inst->id, ref_frame_num);
+		return;
+	}
+	if (act_frame_num > ARRAY_SIZE(venc->act)) {
+		dev_err(inst->dev, "[%d] act num(%d) is out of range\n", inst->id, act_frame_num);
+		return;
+	}
+
+	for (i = 0; i < enc_frame_num; i++) {
+		venc->enc[i].length = enc_frame_size;
+		ret = vpu_alloc_dma(inst->core, &venc->enc[i]);
+		if (ret) {
+			venc_cleanup_mem_resource(inst);
+			return;
+		}
+	}
+	for (i = 0; i < ref_frame_num; i++) {
+		venc->ref[i].length = ref_frame_size;
+		ret = vpu_alloc_dma(inst->core, &venc->ref[i]);
+		if (ret) {
+			venc_cleanup_mem_resource(inst);
+			return;
+		}
+	}
+	if (act_frame_num != 1 || act_frame_size > inst->act.length) {
+		venc_cleanup_mem_resource(inst);
+		return;
+	}
+	venc->act[0].length = act_frame_size;
+	venc->act[0].phys = inst->act.phys;
+	venc->act[0].virt = inst->act.virt;
+
+	for (i = 0; i < enc_frame_num; i++)
+		vpu_iface_config_memory_resource(inst, MEM_RES_ENC, i, &venc->enc[i]);
+	for (i = 0; i < ref_frame_num; i++)
+		vpu_iface_config_memory_resource(inst, MEM_RES_REF, i, &venc->ref[i]);
+	for (i = 0; i < act_frame_num; i++)
+		vpu_iface_config_memory_resource(inst, MEM_RES_ACT, i, &venc->act[i]);
+}
+
+static void venc_cleanup_frames(struct venc_t *venc)
+{
+	struct venc_frame_t *frame;
+	struct venc_frame_t *tmp;
+
+	list_for_each_entry_safe(frame, tmp, &venc->frames, list) {
+		list_del_init(&frame->list);
+		vfree(frame);
+	}
+}
+
+static int venc_stop_session(struct vpu_inst *inst, u32 type)
+{
+	struct venc_t *venc = inst->priv;
+
+	venc_set_enable(venc, type, 0);
+	if (venc->enable & VENC_ENABLE_MASK)
+		return 0;
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return 0;
+
+	if (inst->state != VPU_CODEC_STATE_STOP)
+		venc_request_eos(inst);
+
+	call_vop(inst, wait_prepare);
+	if (!wait_event_timeout(venc->wq, venc->stopped, VPU_TIMEOUT)) {
+		set_bit(inst->id, &inst->core->hang_mask);
+		vpu_session_debug(inst);
+	}
+	call_vop(inst, wait_finish);
+
+	inst->state = VPU_CODEC_STATE_DEINIT;
+	venc_cleanup_frames(inst->priv);
+	vpu_free_dma(&inst->stream_buffer);
+	venc_cleanup_mem_resource(inst);
+
+	return 0;
+}
+
+static int venc_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct venc_t *venc = inst->priv;
+	struct vb2_v4l2_buffer *vbuf;
+	u32 flags;
+
+	if (inst->state == VPU_CODEC_STATE_DEINIT)
+		return -EINVAL;
+
+	vbuf = to_vb2_v4l2_buffer(vb);
+	if (inst->state == VPU_CODEC_STATE_STARTED)
+		inst->state = VPU_CODEC_STATE_ACTIVE;
+
+	flags = vbuf->flags;
+	if (venc->request_key_frame) {
+		vbuf->flags |= V4L2_BUF_FLAG_KEYFRAME;
+		venc->request_key_frame = 0;
+	}
+	if (venc->bitrate_change) {
+		vpu_session_update_parameters(inst, &venc->params);
+		venc->bitrate_change = false;
+	}
+	dev_dbg(inst->dev, "[%d][INPUT  TS]%32lld\n", inst->id, vb->timestamp);
+	vpu_iface_input_frame(inst, vb);
+	vbuf->flags = flags;
+	venc->input_ready = false;
+	venc->frame_count++;
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
+
+	return 0;
+}
+
+static int venc_process_capture(struct vpu_inst *inst, struct vb2_buffer *vb)
+{
+	struct venc_t *venc;
+	struct venc_frame_t *frame = NULL;
+	struct vb2_v4l2_buffer *vbuf;
+	int ret;
+
+	if (!inst || !inst->fh.m2m_ctx)
+		return -EINVAL;
+
+	venc = inst->priv;
+	if (list_empty(&venc->frames))
+		return -EINVAL;
+
+	frame = list_first_entry(&venc->frames, struct venc_frame_t, list);
+	vbuf = to_vb2_v4l2_buffer(vb);
+	v4l2_m2m_dst_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
+	ret = venc_get_one_encoded_frame(inst, frame, vbuf);
+	if (ret)
+		return ret;
+
+	list_del_init(&frame->list);
+	vfree(frame);
+	return 0;
+}
+
+static void venc_on_queue_empty(struct vpu_inst *inst, u32 type)
+{
+	struct venc_t *venc = inst->priv;
+
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		return;
+
+	if (venc->stopped)
+		venc_set_last_buffer_dequeued(inst);
+}
+
+static int venc_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i)
+{
+	struct venc_t *venc = inst->priv;
+	int num = -1;
+
+	switch (i) {
+	case 0:
+		num = scnprintf(str, size, "profile = %d\n", venc->params.profile);
+		break;
+	case 1:
+		num = scnprintf(str, size, "level = %d\n", venc->params.level);
+		break;
+	case 2:
+		num = scnprintf(str, size, "fps = %d/%d\n",
+				venc->params.frame_rate.numerator,
+				venc->params.frame_rate.denominator);
+		break;
+	case 3:
+		num = scnprintf(str, size, "%d x %d -> %d x %d\n",
+				venc->params.src_width,
+				venc->params.src_height,
+				venc->params.out_width,
+				venc->params.out_height);
+		break;
+	case 4:
+		num = scnprintf(str, size, "(%d, %d)  %d x %d\n",
+				venc->params.crop.left,
+				venc->params.crop.top,
+				venc->params.crop.width,
+				venc->params.crop.height);
+		break;
+	case 5:
+		num = scnprintf(str, size,
+				"enable = 0x%x, input = %d, encode = %d, ready = %d, stopped = %d\n",
+				venc->enable,
+				venc->frame_count, venc->encode_count,
+				venc->ready_count,
+				venc->stopped);
+		break;
+	case 6:
+		num = scnprintf(str, size, "gop = %d\n", venc->params.gop_length);
+		break;
+	case 7:
+		num = scnprintf(str, size, "bframes = %d\n", venc->params.bframes);
+		break;
+	case 8:
+		num = scnprintf(str, size, "rc: %s, mode = %d, bitrate = %d(%d), qp = %d\n",
+				venc->params.rc_enable ? "enable" : "disable",
+				venc->params.rc_mode,
+				venc->params.bitrate,
+				venc->params.bitrate_max,
+				venc->params.i_frame_qp);
+		break;
+	case 9:
+		num = scnprintf(str, size, "sar: enable = %d, idc = %d, %d x %d\n",
+				venc->params.sar.enable,
+				venc->params.sar.idc,
+				venc->params.sar.width,
+				venc->params.sar.height);
+
+		break;
+	case 10:
+		num = scnprintf(str, size,
+				"colorspace: primaries = %d, transfer = %d, matrix = %d, full_range = %d\n",
+				venc->params.color.primaries,
+				venc->params.color.transfer,
+				venc->params.color.matrix,
+				venc->params.color.full_range);
+		break;
+	case 11:
+		num = scnprintf(str, size, "skipped: count = %d, bytes = %d\n",
+				venc->skipped_count, venc->skipped_bytes);
+		break;
+	default:
+		break;
+	}
+
+	return num;
+}
+
+static struct vpu_inst_ops venc_inst_ops = {
+	.ctrl_init = venc_ctrl_init,
+	.check_ready = venc_check_ready,
+	.input_done = venc_input_done,
+	.get_one_frame = venc_frame_encoded,
+	.buf_done = venc_buf_done,
+	.stop_done = venc_stop_done,
+	.event_notify = venc_event_notify,
+	.release = venc_release,
+	.cleanup = venc_cleanup,
+	.start = venc_start_session,
+	.mem_request = venc_request_mem_resource,
+	.stop = venc_stop_session,
+	.process_output = venc_process_output,
+	.process_capture = venc_process_capture,
+	.on_queue_empty = venc_on_queue_empty,
+	.get_debug_info = venc_get_debug_info,
+	.wait_prepare = vpu_inst_unlock,
+	.wait_finish = vpu_inst_lock,
+};
+
+static void venc_init(struct file *file)
+{
+	struct vpu_inst *inst = to_inst(file);
+	struct venc_t *venc;
+	struct v4l2_format f;
+	struct v4l2_streamparm parm;
+
+	venc = inst->priv;
+	venc->params.qp_min = 1;
+	venc->params.qp_max = 51;
+	venc->params.qp_min_i = 1;
+	venc->params.qp_max_i = 51;
+	venc->params.bitrate_min = BITRATE_MIN;
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_NV12M;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f.fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
+	venc_s_fmt(file, &inst->fh, &f);
+
+	memset(&f, 0, sizeof(f));
+	f.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
+	f.fmt.pix_mp.width = 1280;
+	f.fmt.pix_mp.height = 720;
+	f.fmt.pix_mp.field = V4L2_FIELD_NONE;
+	venc_s_fmt(file, &inst->fh, &f);
+
+	memset(&parm, 0, sizeof(parm));
+	parm.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+	parm.parm.capture.timeperframe.numerator = 1;
+	parm.parm.capture.timeperframe.denominator = 30;
+	venc_s_parm(file, &inst->fh, &parm);
+}
+
+static int venc_open(struct file *file)
+{
+	struct vpu_inst *inst;
+	struct venc_t *venc;
+	int ret;
+
+	inst = vzalloc(sizeof(*inst));
+	if (!inst)
+		return -ENOMEM;
+
+	venc = vzalloc(sizeof(*venc));
+	if (!venc) {
+		vfree(inst);
+		return -ENOMEM;
+	}
+
+	inst->ops = &venc_inst_ops;
+	inst->formats = venc_formats;
+	inst->type = VPU_CORE_TYPE_ENC;
+	inst->priv = venc;
+	INIT_LIST_HEAD(&venc->frames);
+	init_waitqueue_head(&venc->wq);
+
+	ret = vpu_v4l2_open(file, inst);
+	if (ret)
+		return ret;
+
+	venc_init(file);
+
+	return 0;
+}
+
+static const struct v4l2_file_operations venc_fops = {
+	.owner = THIS_MODULE,
+	.open = venc_open,
+	.release = vpu_v4l2_close,
+	.unlocked_ioctl = video_ioctl2,
+	.poll = v4l2_m2m_fop_poll,
+	.mmap = v4l2_m2m_fop_mmap,
+};
+
+const struct v4l2_ioctl_ops *venc_get_ioctl_ops(void)
+{
+	return &venc_ioctl_ops;
+}
+
+const struct v4l2_file_operations *venc_get_fops(void)
+{
+	return &venc_fops;
+}
-- 
2.33.0

