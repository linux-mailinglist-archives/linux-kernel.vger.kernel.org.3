Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A615927FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiHODIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiHODH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:07:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0695E11A26
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:07:53 -0700 (PDT)
X-UUID: ef832e57d9ba46239fadc31fa103fe3d-20220815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b3BKeHNHkOmEyqFXi/2yjYXaBJc1kL89uDBD+OeJTSI=;
        b=FEkmgW+Tm+Z5rpzFAj5lHynf30gk1rKZY88eZGbiRemveQio9l99OrgUS0/lOH4vVZiFpNVuJ8tHO5/3o1z/QHPQD+2VzS1i8UWvJOrQNc+m/MI06z2I3DUo/Xoupjfb2vDcmB0cenrzhEsAaLXA24MqVRcfVQoxt47J20CRy6E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:1c166f31-b1ea-4f1f-84ec-1c9b81216976,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:5
X-CID-META: VersionHash:3d8acc9,CLOUDID:139dccae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ef832e57d9ba46239fadc31fa103fe3d-20220815
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1121502638; Mon, 15 Aug 2022 11:07:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 15 Aug 2022 11:07:47 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Aug 2022 11:07:46 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.corp-partner.google.com>,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Subject: [PATCH v1, 1/1] mailbox: mtk-cmdq: fix gce timeout issue
Date:   Mon, 15 Aug 2022 11:07:40 +0800
Message-ID: <20220815030740.28899-2-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815030740.28899-1-yongqiang.niu@mediatek.com>
References: <20220815030740.28899-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.corp-partner.google.com>

1. enable gce ddr enable(gce reigster offset 0x48, bit 16 to 18) when gce work,
and disable gce ddr enable when gce work job done
2. split cmdq clk enable/disable api, and control gce ddr enable/disable
in clk enable/disable function to make sure it could protect when cmdq
is multiple used by display and mdp

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.corp-partner.google.com>
Signed-off-by: Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 57 ++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 2578e5aaa935..64a47470f062 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -81,6 +81,8 @@ struct cmdq {
 	u8			shift_pa;
 	bool			control_by_sw;
 	u32			gce_num;
+	atomic_t		usage;
+	spinlock_t		lock;
 };
 
 struct gce_plat {
@@ -90,6 +92,46 @@ struct gce_plat {
 	u32 gce_num;
 };
 
+static s32 cmdq_clk_enable(struct cmdq *cmdq)
+{
+	s32 usage, ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmdq->lock, flags);
+
+	usage = atomic_inc_return(&cmdq->usage);
+
+	ret = clk_bulk_enable(cmdq->gce_num, cmdq->clocks);
+	if (usage <=0 || ret < 0) {
+		dev_err(cmdq->mbox.dev, "ref count %d ret %d suspend %d\n",
+			usage, ret, cmdq->suspended);
+	} else if (usage == 1) {
+		if (cmdq->control_by_sw)
+			writel((0x7 << 16) + 0x7, cmdq->base + GCE_GCTL_VALUE);
+	}
+
+	spin_unlock_irqrestore(&cmdq->lock, flags);
+
+	return ret;
+}
+
+static void cmdq_clk_disable(struct cmdq *cmdq)
+{
+	s32 usage;
+
+	usage = atomic_dec_return(&cmdq->usage);
+
+	if (usage < 0) {
+		dev_err(cmdq->mbox.dev, "ref count %d suspend %d\n",
+			usage, cmdq->suspended);
+	} else if (usage == 0) {
+		if (cmdq->control_by_sw)
+			writel(0x7, cmdq->base + GCE_GCTL_VALUE);
+	}
+
+	clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
+}
+
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 {
 	struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
@@ -271,7 +313,8 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 
 	if (list_empty(&thread->task_busy_list)) {
 		cmdq_thread_disable(cmdq, thread);
-		clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
+
+		cmdq_clk_disable(cmdq);
 	}
 }
 
@@ -360,8 +403,7 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	task->pkt = pkt;
 
 	if (list_empty(&thread->task_busy_list)) {
-		WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
-
+		WARN_ON(cmdq_clk_enable(cmdq) < 0);
 		/*
 		 * The thread reset will clear thread related register to 0,
 		 * including pc, end, priority, irq, suspend and enable. Thus
@@ -433,7 +475,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	}
 
 	cmdq_thread_disable(cmdq, thread);
-	clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
+	cmdq_clk_disable(cmdq);
 
 done:
 	/*
@@ -479,7 +521,8 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	cmdq_thread_resume(thread);
 	cmdq_thread_disable(cmdq, thread);
-	clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
+
+	cmdq_clk_disable(cmdq);
 
 out:
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
@@ -490,7 +533,8 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
 	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_ENABLE_TASK,
 				      enable, enable == 0, 1, timeout)) {
-		dev_err(cmdq->mbox.dev, "Fail to wait GCE thread 0x%x done\n",
+		dev_err(cmdq->mbox.dev,
+			"Fail to wait GCE thread 0x%x done\n",
 			(u32)(thread->base - cmdq->base));
 
 		return -EFAULT;
@@ -626,6 +670,7 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	WARN_ON(clk_bulk_prepare(cmdq->gce_num, cmdq->clocks));
 
+	spin_lock_init(&cmdq->lock);
 	cmdq_init(cmdq);
 
 	return 0;
-- 
2.25.1

