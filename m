Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C024948C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiATHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:43:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34134 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235850AbiATHnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:43:20 -0500
X-UUID: 2050324cb93c4a8380e2bc7685820fff-20220120
X-UUID: 2050324cb93c4a8380e2bc7685820fff-20220120
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 73705492; Thu, 20 Jan 2022 15:43:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Jan 2022 15:43:15 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Jan 2022 15:43:14 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        mtk18742 <moudy.ho@mediatek.com>
Subject: [PATCH v1, 1/1] soc: mediatek: cmdq: add cmdq_pkt_poll_addr function
Date:   Thu, 20 Jan 2022 15:43:11 +0800
Message-ID: <20220120074311.2243-2-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120074311.2243-1-yongqiang.niu@mediatek.com>
References: <20220120074311.2243-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mtk18742 <moudy.ho@mediatek.com>

add cmdq_pkt_poll_addr function in cmdq helper functions

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c   | 39 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
 include/linux/soc/mediatek/mtk-cmdq.h    |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 3c8e4212d941..6c5cfb284140 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -344,6 +344,45 @@ int cmdq_pkt_set_event(struct cmdq_pkt *pkt, u16 event)
 }
 EXPORT_SYMBOL(cmdq_pkt_set_event);
 
+s32 cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, u32 value, u32 addr, u32 mask, u8 reg_gpr)
+{
+	struct cmdq_instruction inst = { {0} };
+
+	s32 err;
+
+	if (mask != 0xffffffff) {
+		inst.op = CMDQ_CODE_MASK;
+		inst.mask = ~mask;
+		err = cmdq_pkt_append_command(pkt, inst);
+		if (err != 0)
+			return err;
+
+		addr = addr | 0x1;
+	}
+
+	/* Move extra handle APB address to GPR */
+	inst.op = CMDQ_CODE_MOVE;
+	inst.value = addr;
+	inst.sop = reg_gpr;
+	inst.dst_t = 1;
+	err = cmdq_pkt_append_command(pkt, inst);
+	if (err != 0)
+		pr_err("%s fail append command move addr to reg err:%d",
+			__func__, err);
+
+	inst.op = CMDQ_CODE_POLL;
+	inst.value = value;
+	inst.sop = reg_gpr;
+	inst.dst_t = 1;
+	err = cmdq_pkt_append_command(pkt, inst);
+	if (err != 0)
+		pr_err("%s fail append command poll err:%d",
+			__func__, err);
+
+	return err;
+}
+EXPORT_SYMBOL(cmdq_pkt_poll_addr);
+
 int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
 		  u16 offset, u32 value)
 {
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 44365aab043c..a27329fd7c7f 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -54,6 +54,7 @@
  */
 enum cmdq_code {
 	CMDQ_CODE_MASK = 0x02,
+	CMDQ_CODE_MOVE = 0x02,
 	CMDQ_CODE_WRITE = 0x04,
 	CMDQ_CODE_POLL = 0x08,
 	CMDQ_CODE_JUMP = 0x10,
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index ac6b5f3cba95..28dc5ce0ff03 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -280,4 +280,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
 int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
 			 void *data);
 
+s32 cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, u32 value, u32 addr, u32 mask, u8 reg_gpr);
+
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.25.1

