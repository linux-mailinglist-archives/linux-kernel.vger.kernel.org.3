Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD9500933
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiDNJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbiDNJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:03:41 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10069.outbound.protection.outlook.com [40.107.1.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D740311146;
        Thu, 14 Apr 2022 02:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWMKuSKcpoZirL/K4UgQ3Tp9ehFwqN2ZlV3wbct/VeCaSjcbgAxJRyMuXwKpNULjib+7ajZkuvYht6KXYMbgmjPaNSqIOsZdyjbuSz+1iA3XOHMexUNcch7c3cDbmgPpj0F6xiMvTxN8drGsBHHDeOnKvtVEiIbrNpT/qBF75Nqi/pEB9+A8es6U2vPnTQv38K+6OzcRMV3OiCrj1z+TD7tZijlcZVy/1vsyER+sxR8h4YqiNL6ooMdZ2wCTvyMaY2PPJ39o2xT69t22HOkcS5YyuZgIipXN9aryRtp/T7Rkg4ZmehST+WSnlfnavwg4aZQZ8h6YeBiU4NwJuNJLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bekbt61buxMplQ5Q0eevV5Ix/Ch+zmQox+vaxzEZks=;
 b=FdX2U+6DbWh8A1BZXFalWtYTSD99XQwC1oBLTfF5jtc7PPaJjFLFHVnMSPhC4xn8oDLgaAaN40WHogclOIMP02sCxl2thzF6TJFJEIb63gSTitEp7cRdGs4lXlJj6RAJHsjPy/uV6CRIPFeWYFMkYwASvlw7y1q856qMS4to+EeVU7Zjgv/sb9lrvueH00Ozh2y4G1mQwKFOAcvj47xLjiHABDnXA6kgRvlJgZ1u38jrSjYRZ7vu8p0l5IaAQsPb6y/G5jdEx3wyc/vUeEkNpTzHkjUyYd1sA619e5P00sJgUsgNwOD91Y5hh8VcgBq0PkrC5l9JGcj7vJAQjTiEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bekbt61buxMplQ5Q0eevV5Ix/Ch+zmQox+vaxzEZks=;
 b=Wqby0vNNkLhhQg3Fg3dYykVO+Q8FJ/e7MJsbWfD2ixvSOaf3kqSYAOYaR95gb7zENrY4AAvpk0Pdj6GVRSichYYo7pNexAVzL3Krcm3sZHYhBSTr10s+lkKVwzf98VS7h3mB0IO8FjlJxj/LgnwuaTkHDGS0I/gY4ob1DCAd7Uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 09:01:11 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 09:01:11 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] media: amphion: decoder copy timestamp from output to capture
Date:   Thu, 14 Apr 2022 17:00:29 +0800
Message-Id: <1fd290193c6c49cee4911abb2ebc22e41817528c.1649753693.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753692.git.ming.qian@nxp.com>
References: <cover.1649753692.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8746e8ab-a440-478c-1863-08da1df55277
X-MS-TrafficTypeDiagnostic: AM7PR04MB6885:EE_
X-Microsoft-Antispam-PRVS: <AM7PR04MB6885EF364A8861948E768499E7EF9@AM7PR04MB6885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAd5jIIadRbKhv7II/O0xqg3cNXLbhDCWETBl8wwRy+maHxfBH0kbIqJLuwSFNkMItHxoMVIw1EreLFZcmUIwY6YAWUgQOtPIbnoeXdHclCoig1Q7DNK6IxCRGU7EsZcEN1oTY29OKmaljeFU21yV5JVVlFghL1tRlVRApTrLvItzGFw+MHNbq651IOs+8qGkp5o2U/D+WNU7kPfL29gKrfH5q7MHsI0zuQCed6nDeKbULCdleH4XVq2waR0NKdUuNCEW30xTm2HA8imb8dbWP1cfbhTZ/gFtfC9zyZKLNsZiK+JKBr5tP4F3qvSIV3OvHjq0bE8p9RgQjHEPV5eSUT2+v5fs5rTFPgl+g8qluQnOayIL2d8hV4km3FIsDDnqvCCMkFaHpFKengWsI7SbC/g0ucLixyHFeJFsaLz10ZAyEg99dgYhdLeoMYfTY9KCywAIuPDp7H1zrFMMeu5EAPduVirfopZ8PvpRPu/btKjoAu9pFWI7DUizYjLNR+d0PqF6moYFnQs4gddIgKBT2czxa4U2LlOhfRIR5EEaseTkaio7O+KU5hJ/0RKXWcvLdGsYFXQtPzCYo3W3UNkURDQf2uCfXh3MxdQzZUbWHSogxT1FBbT3g+oh1W0bWJxmGbBsD2NXUAlL7JTSoZHZ9mSH0ZiFSCU9ECPoVct8e4agwOf3Ba4h6hrNxuBliY0bZZH9uoPhBQSLIa3BT6G2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2616005)(83380400001)(5660300002)(66556008)(8676002)(52116002)(86362001)(186003)(26005)(7416002)(66946007)(4326008)(36756003)(2906002)(8936002)(44832011)(6486002)(6666004)(508600001)(6506007)(6512007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B4kIqaX6fzObOug4nZVQ4GcqbA+bHSrK3BiZXR4rMNg6TqOOewq5LpPKREYc?=
 =?us-ascii?Q?aP1+ohquAWNBywmgPx78+oPYv+DeAs4I1L/u3zHavhi8e7aeYyi95gja1m5l?=
 =?us-ascii?Q?tAiEd+OD6FxMe03IWvDjD91kW+8+jXrCuIK+Zvb/HTOcUlePa6mKJ1kSrq0R?=
 =?us-ascii?Q?mYwXUMynMFmYWfmI4gJS37E+X8exAflu7qhVLjBdLkIVVWMR/dxXdgUmitoy?=
 =?us-ascii?Q?O2Xn7FQIVePl7ENfmmyfII3MQmA35DayE9Y3VrG9cE6tBqp4LVXNQX4lHlJc?=
 =?us-ascii?Q?W3ShbyDuHAQFBKevsfcbzbqHrsImpTaBFDPZj42D14+kiE7j7eA/A8da/p5p?=
 =?us-ascii?Q?Fdguk84CUvd1lq7Gnf6ICmMtHm3X1qOo1abSfy74+nEhPpM9gPvT+Vu4ukEA?=
 =?us-ascii?Q?f88ZTJnOSgVVbW6dqGmPI6kWvm/CcbcQHZnUrfmFUeOgjTP2jTRr+IjUx2F8?=
 =?us-ascii?Q?kM0areoAONT3SUMHCw7kIb7EPMoMmLJcyXdx0OuIzmcCzwL0IQ6Opm+MBYVl?=
 =?us-ascii?Q?pVM53zAd/tHk+S/zHej+knkdXMVXDuFUvI15Z/VnOo6VhgVd2SDX1g6J79Nx?=
 =?us-ascii?Q?QdiDL7NghbhCaHruHKFa/T0ndZXV5i7FtlXeFpOXBJmHFzxpqkvqGcfOCuIs?=
 =?us-ascii?Q?1TfCUZ9VDFLmlT7Oq4vRoO4YlFxEl2I4AzYta4dRZfN5B8p/WK74Z5dyfppK?=
 =?us-ascii?Q?/8DW3qmQbNfWHvjpOVtSExUxxWKG6VNPpM47g0YG3zPfjkKsjx9GVT15Tp/7?=
 =?us-ascii?Q?babxUgJQ1klCly/K4vtO9JxlXa2ZtLWNCSJ1gheT48xieEqBL+CJYuXDFdv1?=
 =?us-ascii?Q?1u268azILnzZCY4QBc2VAhjwblKJ5NpTUfxySzlfDb9kpC5PtZzCw+4ofOU1?=
 =?us-ascii?Q?tFi8vU0nG6XZpybvZcS9JBMDkA/+xe1bTxOVdwW0Rh7JEAAipphYKM+Dv5zD?=
 =?us-ascii?Q?8NIgVu06MvHdgLEGscJSPeNguOGBvvRYpXzDIxiU4+dLo/P9FTLbySrJwWzj?=
 =?us-ascii?Q?6WrMwNl290NJzgn+4IYpISrALgg8f8RsgH/Ci1ql9qSgy+rAJK+Ycxh1MDIa?=
 =?us-ascii?Q?R4/eoB+3Ykwmcm2w+INT6VkhdXDr+uONImkiWDiErmeTkoBxWxL+JEopLZy7?=
 =?us-ascii?Q?u+Pd9/n3wDob9ELgozlGdjfdZ9Wu/Z8fCor7hJ8BHesY9Sp8LM7HhfFR9opv?=
 =?us-ascii?Q?rSvEp57pk0ZlvjcQb/Ir7tHzjZsJulYOlk7Lw8D+2ttJKABTolWzp/h2YOXp?=
 =?us-ascii?Q?hDiACndHWnFauI4Qc87r9ResESXltznQKERdSsJv6Leva+s7QcaBvqCQObpg?=
 =?us-ascii?Q?EoChG3nlLzAdo4y/T8yAkIXE+wnqWO0JRfr6qAcDrJDusta8TDpwrjJ3wSpW?=
 =?us-ascii?Q?MgLdcffk5BpNGWBbmwPIZJHaNrKAyz0bkoihQOyCU9pMdU1lRom80lGkYFFm?=
 =?us-ascii?Q?qMKiJ/DFjsIRbzq2q+5YbpKmFRLMUwRoyiDwxlLhOc4owuuoU5jY8KEjFdDu?=
 =?us-ascii?Q?UxsnIBkXi4pe01StO7UpStTRhj/1CBDxJ+50xsvjX73UduklWde3n8cpikX4?=
 =?us-ascii?Q?gCetzd9Zuq6EAtAYSiB93r+UtxljwmRn3+9yOA5+P9DRKoGj+AEkH3NiSSEl?=
 =?us-ascii?Q?Ksagz+1ku0WEB7OQcdM9IlMOvN83sJkPbfo4KxO8UZB5vcYDGOUFdKt3pHG9?=
 =?us-ascii?Q?FkKIY/lDv7Zhw3aiiINp4bME4+sQXLwMU+z1QIbTQWh1Bu7k94L4vudsNz3n?=
 =?us-ascii?Q?99uoi7niDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8746e8ab-a440-478c-1863-08da1df55277
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:01:11.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5q2+uhleAsmA2OI3wS5vn4ISNfTFM2dyCmquLvk28NPwS458tGy1rGLemEcg0mIicCOubf7ABu0l8FoP3BTuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy the timestamp using the helper function
V4L2_BUF_FLAG_TIMESTAMP_COPY

To implement this, driver will keep the output buffer until it's
decoded, in previous, driver will return the output buffer immediately
after copying data to stream buffer.

After that, there is no need to make a workaround for poll function.
driver can use v4l2_m2m_fop_poll directly.
Also, driver don't need to keep a input threshold
as the buffer count is up to only 32.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c     | 89 ++++++++++-------------
 drivers/media/platform/amphion/vpu_v4l2.c | 13 ++++
 drivers/media/platform/amphion/vpu_v4l2.h |  1 +
 3 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 8f8dfd6ce2c6..09628dd0c855 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -26,8 +26,8 @@
 #include "vpu_cmds.h"
 #include "vpu_rpc.h"
 
-#define VDEC_FRAME_DEPTH		256
 #define VDEC_MIN_BUFFER_CAP		8
+#define VDEC_MIN_BUFFER_OUT		8
 
 struct vdec_fs_info {
 	char name[8];
@@ -63,8 +63,6 @@ struct vdec_t {
 	bool is_source_changed;
 	u32 source_change;
 	u32 drain;
-	u32 ts_pre_count;
-	u32 frame_depth;
 };
 
 static const struct vpu_format vdec_formats[] = {
@@ -470,7 +468,7 @@ static int vdec_drain(struct vpu_inst *inst)
 	if (!vdec->drain)
 		return 0;
 
-	if (v4l2_m2m_num_src_bufs_ready(inst->fh.m2m_ctx))
+	if (!vpu_is_source_empty(inst))
 		return 0;
 
 	if (!vdec->params.frame_count) {
@@ -589,11 +587,8 @@ static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
 {
 	struct vdec_t *vdec = inst->priv;
 
-	if (V4L2_TYPE_IS_OUTPUT(type)) {
-		if (vdec->ts_pre_count >= vdec->frame_depth)
-			return false;
+	if (V4L2_TYPE_IS_OUTPUT(type))
 		return true;
-	}
 
 	if (vdec->req_frame_count)
 		return true;
@@ -601,12 +596,34 @@ static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
 	return false;
 }
 
+static struct vb2_v4l2_buffer *vdec_get_src_buffer(struct vpu_inst *inst, u32 count)
+{
+	struct vb2_v4l2_buffer *src_buf;
+	enum vb2_buffer_state state;
+	u32 i;
+
+	for (i = 1; i < count; i++) {
+		src_buf = v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx);
+		if (!src_buf || vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_IDLE)
+			return NULL;
+		if (vpu_get_buffer_state(src_buf) == VPU_BUF_STATE_DECODED)
+			state = VB2_BUF_STATE_DONE;
+		else
+			state = VB2_BUF_STATE_ERROR;
+		vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
+		v4l2_m2m_buf_done(src_buf, state);
+	}
+
+	return v4l2_m2m_next_src_buf(inst->fh.m2m_ctx);
+}
+
 static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
 {
 	struct vdec_t *vdec = inst->priv;
 	struct vpu_dec_pic_info *info = arg;
 	struct vpu_vb2_buffer *vpu_buf;
 	struct vb2_v4l2_buffer *vbuf;
+	struct vb2_v4l2_buffer *src_buf;
 	int ret = 0;
 
 	if (!info || info->id >= ARRAY_SIZE(vdec->slots))
@@ -620,14 +637,21 @@ static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
 		goto exit;
 	}
 	vbuf = &vpu_buf->m2m_buf.vb;
+	src_buf = vdec_get_src_buffer(inst, info->consumed_count);
+	if (src_buf) {
+		v4l2_m2m_buf_copy_metadata(src_buf, vbuf, true);
+		if (info->consumed_count) {
+			v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx);
+			vpu_set_buffer_state(src_buf, VPU_BUF_STATE_IDLE);
+			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+		} else {
+			vpu_set_buffer_state(src_buf, VPU_BUF_STATE_DECODED);
+		}
+	}
 	if (vpu_get_buffer_state(vbuf) == VPU_BUF_STATE_DECODED)
 		dev_info(inst->dev, "[%d] buf[%d] has been decoded\n", inst->id, info->id);
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_DECODED);
 	vdec->decoded_frame_count++;
-	if (vdec->ts_pre_count >= info->consumed_count)
-		vdec->ts_pre_count -= info->consumed_count;
-	else
-		vdec->ts_pre_count = 0;
 exit:
 	vpu_inst_unlock(inst);
 
@@ -683,10 +707,9 @@ static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *frame)
 	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
 	vb2_set_plane_payload(&vbuf->vb2_buf, 0, inst->cap_format.sizeimage[0]);
 	vb2_set_plane_payload(&vbuf->vb2_buf, 1, inst->cap_format.sizeimage[1]);
-	vbuf->vb2_buf.timestamp = frame->timestamp;
 	vbuf->field = inst->cap_format.field;
 	vbuf->sequence = sequence;
-	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, frame->timestamp);
+	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, vbuf->vb2_buf.timestamp);
 
 	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
 	vpu_inst_lock(inst);
@@ -708,7 +731,6 @@ static void vdec_stop_done(struct vpu_inst *inst)
 	vdec->fixed_fmt = false;
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
-	vdec->ts_pre_count = 0;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1244,18 +1266,14 @@ static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer *vb)
 	if (free_space < vb2_get_plane_payload(vb, 0) + 0x40000)
 		return -ENOMEM;
 
+	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
 	ret = vpu_iface_input_frame(inst, vb);
 	if (ret < 0)
 		return -ENOMEM;
 
 	dev_dbg(inst->dev, "[%d][INPUT  TS]%32lld\n", inst->id, vb->timestamp);
-	vdec->ts_pre_count++;
 	vdec->params.frame_count++;
 
-	v4l2_m2m_src_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
-	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
-	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
-
 	if (vdec->drain)
 		vdec_drain(inst);
 
@@ -1318,7 +1336,6 @@ static void vdec_abort(struct vpu_inst *inst)
 		  vdec->sequence);
 	vdec->params.end_flag = 0;
 	vdec->drain = 0;
-	vdec->ts_pre_count = 0;
 	vdec->params.frame_count = 0;
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
@@ -1525,10 +1542,6 @@ static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 size, u32 i
 				vdec->drain, vdec->eos_received, vdec->source_change);
 		break;
 	case 8:
-		num = scnprintf(str, size, "ts_pre_count = %d, frame_depth = %d\n",
-				vdec->ts_pre_count, vdec->frame_depth);
-		break;
-	case 9:
 		num = scnprintf(str, size, "fps = %d/%d\n",
 				vdec->codec_info.frame_rate.numerator,
 				vdec->codec_info.frame_rate.denominator);
@@ -1562,12 +1575,8 @@ static struct vpu_inst_ops vdec_inst_ops = {
 static void vdec_init(struct file *file)
 {
 	struct vpu_inst *inst = to_inst(file);
-	struct vdec_t *vdec;
 	struct v4l2_format f;
 
-	vdec = inst->priv;
-	vdec->frame_depth = VDEC_FRAME_DEPTH;
-
 	memset(&f, 0, sizeof(f));
 	f.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
 	f.fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
@@ -1612,36 +1621,18 @@ static int vdec_open(struct file *file)
 
 	vdec->fixed_fmt = false;
 	inst->min_buffer_cap = VDEC_MIN_BUFFER_CAP;
+	inst->min_buffer_out = VDEC_MIN_BUFFER_OUT;
 	vdec_init(file);
 
 	return 0;
 }
 
-static __poll_t vdec_poll(struct file *file, poll_table *wait)
-{
-	struct vpu_inst *inst = to_inst(file);
-	struct vb2_queue *src_q, *dst_q;
-	__poll_t ret;
-
-	ret = v4l2_m2m_fop_poll(file, wait);
-	src_q = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
-	dst_q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
-	if (vb2_is_streaming(src_q) && !vb2_is_streaming(dst_q))
-		ret &= (~EPOLLERR);
-	if (!src_q->error && !dst_q->error &&
-	    (vb2_is_streaming(src_q) && list_empty(&src_q->queued_list)) &&
-	    (vb2_is_streaming(dst_q) && list_empty(&dst_q->queued_list)))
-		ret &= (~EPOLLERR);
-
-	return ret;
-}
-
 static const struct v4l2_file_operations vdec_fops = {
 	.owner = THIS_MODULE,
 	.open = vdec_open,
 	.release = vpu_v4l2_close,
 	.unlocked_ioctl = video_ioctl2,
-	.poll = vdec_poll,
+	.poll = v4l2_m2m_fop_poll,
 	.mmap = v4l2_m2m_fop_mmap,
 };
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 9c0704cd5766..cbf3315605a9 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -127,6 +127,19 @@ int vpu_set_last_buffer_dequeued(struct vpu_inst *inst)
 	return 0;
 }
 
+bool vpu_is_source_empty(struct vpu_inst *inst)
+{
+	struct v4l2_m2m_buffer *buf = NULL;
+
+	if (!inst->fh.m2m_ctx)
+		return true;
+	v4l2_m2m_for_each_src_buf(inst->fh.m2m_ctx, buf) {
+		if (vpu_get_buffer_state(&buf->vb) == VPU_BUF_STATE_IDLE)
+			return false;
+	}
+	return true;
+}
+
 const struct vpu_format *vpu_try_fmt_common(struct vpu_inst *inst, struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/amphion/vpu_v4l2.h
index 90fa7ea67495..ad114734a017 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.h
+++ b/drivers/media/platform/amphion/vpu_v4l2.h
@@ -27,6 +27,7 @@ int vpu_notify_source_change(struct vpu_inst *inst);
 int vpu_set_last_buffer_dequeued(struct vpu_inst *inst);
 void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_buffer_state state);
 int vpu_get_num_buffers(struct vpu_inst *inst, u32 type);
+bool vpu_is_source_empty(struct vpu_inst *inst);
 
 dma_addr_t vpu_get_vb_phy_addr(struct vb2_buffer *vb, u32 plane_no);
 unsigned int vpu_get_vb_length(struct vb2_buffer *vb, u32 plane_no);
-- 
2.35.1

