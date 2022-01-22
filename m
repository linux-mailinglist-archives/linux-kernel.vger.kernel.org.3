Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC84969B5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiAVDxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:53:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51768 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232374AbiAVDx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:53:28 -0500
X-UUID: 274381e2b8ec4cadb9bba71608d26859-20220122
X-UUID: 274381e2b8ec4cadb9bba71608d26859-20220122
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1446934671; Sat, 22 Jan 2022 11:53:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Jan 2022 11:53:23 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Jan 2022 11:53:22 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6, 03/15] media: mtk-vcodec: get capture queue buffer size from scp
Date:   Sat, 22 Jan 2022 11:53:04 +0800
Message-ID: <20220122035316.18179-4-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122035316.18179-1-yunfei.dong@mediatek.com>
References: <20220122035316.18179-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different capture buffer format has different buffer size, need to get
real buffer size according to buffer type from scp.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/platform/mtk-vcodec/vdec_ipi_msg.h  | 36 ++++++++++++++
 .../media/platform/mtk-vcodec/vdec_vpu_if.c   | 49 +++++++++++++++++++
 .../media/platform/mtk-vcodec/vdec_vpu_if.h   | 15 ++++++
 3 files changed, 100 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h b/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
index bf54d6d9a857..47070be2a991 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
+++ b/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
@@ -20,6 +20,7 @@ enum vdec_ipi_msgid {
 	AP_IPIMSG_DEC_RESET = 0xA004,
 	AP_IPIMSG_DEC_CORE = 0xA005,
 	AP_IPIMSG_DEC_CORE_END = 0xA006,
+	AP_IPIMSG_DEC_GET_PARAM = 0xA007,
 
 	VPU_IPIMSG_DEC_INIT_ACK = 0xB000,
 	VPU_IPIMSG_DEC_START_ACK = 0xB001,
@@ -28,6 +29,7 @@ enum vdec_ipi_msgid {
 	VPU_IPIMSG_DEC_RESET_ACK = 0xB004,
 	VPU_IPIMSG_DEC_CORE_ACK = 0xB005,
 	VPU_IPIMSG_DEC_CORE_END_ACK = 0xB006,
+	VPU_IPIMSG_DEC_GET_PARAM_ACK = 0xB007,
 };
 
 /**
@@ -114,4 +116,38 @@ struct vdec_vpu_ipi_init_ack {
 	uint32_t inst_id;
 };
 
+/**
+ * struct vdec_ap_ipi_get_param - for AP_IPIMSG_DEC_GET_PARAM
+ * @msg_id	: AP_IPIMSG_DEC_GET_PARAM
+ * @inst_id     : instance ID. Used if the ABI version >= 2.
+ * @data	: picture information
+ * @param_type	: get param type
+ * @codec_type	: Codec fourcc
+ */
+struct vdec_ap_ipi_get_param {
+	u32 msg_id;
+	u32 inst_id;
+	u32 data[4];
+	u32 param_type;
+	u32 codec_type;
+};
+
+/**
+ * struct vdec_vpu_ipi_get_param_ack - for VPU_IPIMSG_DEC_GET_PARAM_ACK
+ * @msg_id	: VPU_IPIMSG_DEC_GET_PARAM_ACK
+ * @status	: VPU execution result
+ * @ap_inst_addr	: AP vcodec_vpu_inst instance address
+ * @data     : picture information from SCP.
+ * @param_type	: get param type
+ * @reserved : reserved param
+ */
+struct vdec_vpu_ipi_get_param_ack {
+	u32 msg_id;
+	s32 status;
+	u64 ap_inst_addr;
+	u32 data[4];
+	u32 param_type;
+	u32 reserved;
+};
+
 #endif
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
index 7210061c772f..35f4d5583084 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
@@ -6,6 +6,7 @@
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_util.h"
+#include "vdec_drv_if.h"
 #include "vdec_ipi_msg.h"
 #include "vdec_vpu_if.h"
 #include "mtk_vcodec_fw.h"
@@ -54,6 +55,26 @@ static void handle_init_ack_msg(const struct vdec_vpu_ipi_init_ack *msg)
 	}
 }
 
+static void handle_get_param_msg_ack(const struct vdec_vpu_ipi_get_param_ack *msg)
+{
+	struct vdec_vpu_inst *vpu = (struct vdec_vpu_inst *)
+					(unsigned long)msg->ap_inst_addr;
+
+	mtk_vcodec_debug(vpu, "+ ap_inst_addr = 0x%llx", msg->ap_inst_addr);
+
+	/* param_type is enum vdec_get_param_type */
+	switch (msg->param_type) {
+	case GET_PARAM_PIC_INFO:
+		vpu->fb_sz[0] = msg->data[0];
+		vpu->fb_sz[1] = msg->data[1];
+		break;
+	default:
+		mtk_vcodec_err(vpu, "invalid get param type=%d", msg->param_type);
+		vpu->failure = 1;
+		break;
+	}
+}
+
 /*
  * vpu_dec_ipi_handler - Handler for VPU ipi message.
  *
@@ -89,6 +110,9 @@ static void vpu_dec_ipi_handler(void *data, unsigned int len, void *priv)
 		case VPU_IPIMSG_DEC_CORE_END_ACK:
 			break;
 
+		case VPU_IPIMSG_DEC_GET_PARAM_ACK:
+			handle_get_param_msg_ack(data);
+			break;
 		default:
 			mtk_vcodec_err(vpu, "invalid msg=%X", msg->msg_id);
 			break;
@@ -217,6 +241,31 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t *data, unsigned int len)
 	return err;
 }
 
+int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint32_t *data,
+		      unsigned int len, unsigned int param_type)
+{
+	struct vdec_ap_ipi_get_param msg;
+	int err;
+
+	mtk_vcodec_debug_enter(vpu);
+
+	if (len > ARRAY_SIZE(msg.data)) {
+		mtk_vcodec_err(vpu, "invalid len = %d\n", len);
+		return -EINVAL;
+	}
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_id = AP_IPIMSG_DEC_GET_PARAM;
+	msg.inst_id = vpu->inst_id;
+	memcpy(msg.data, data, sizeof(unsigned int) * len);
+	msg.param_type = param_type;
+	msg.codec_type = vpu->codec_type;
+
+	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
+	mtk_vcodec_debug(vpu, "- ret=%d", err);
+	return err;
+}
+
 int vpu_dec_core(struct vdec_vpu_inst *vpu)
 {
 	return vcodec_send_ap_ipi(vpu, AP_IPIMSG_DEC_CORE);
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
index 4cb3c7f5a3ad..d1feba41dd39 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
+++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
@@ -28,6 +28,8 @@ struct mtk_vcodec_ctx;
  * @wq          : wait queue to wait VPU message ack
  * @handler     : ipi handler for each decoder
  * @codec_type     : use codec type to separate different codecs
+ * @capture_type    : used capture type to separate different capture format
+ * @fb_sz  : frame buffer size of each plane
  */
 struct vdec_vpu_inst {
 	int id;
@@ -42,6 +44,8 @@ struct vdec_vpu_inst {
 	wait_queue_head_t wq;
 	mtk_vcodec_ipi_handler handler;
 	unsigned int codec_type;
+	unsigned int capture_type;
+	unsigned int fb_sz[2];
 };
 
 /**
@@ -104,4 +108,15 @@ int vpu_dec_core(struct vdec_vpu_inst *vpu);
  */
 int vpu_dec_core_end(struct vdec_vpu_inst *vpu);
 
+/**
+ * vpu_dec_get_param - get param from scp
+ *
+ * @vpu : instance for vdec_vpu_inst
+ * @data: meta data to pass bitstream info to VPU decoder
+ * @len : meta data length
+ * @param_type : get param type
+ */
+int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint32_t *data,
+		      unsigned int len, unsigned int param_type);
+
 #endif
-- 
2.25.1

