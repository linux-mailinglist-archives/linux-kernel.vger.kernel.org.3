Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187F25432E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbiFHOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbiFHOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A030182B8B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A7A61B96
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FE7C3411E;
        Wed,  8 Jun 2022 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699292;
        bh=uBWqNSsuugL8gAJvkHPjJN0Gcc3wNBUrDVxOkLfzSW4=;
        h=From:To:Cc:Subject:Date:From;
        b=AG+HsRqm3ySG4CDH49vTyZCJ9jM/I7LkekpEtXER3zQgZq/NFypOrO6546G4Mf5gS
         ukcujXukaxbtbVCMZSsYyFeLQYHXMFWVRZS6i14mR/C9RC35XzTc5AXkecRbpuokj1
         PDELsIXkklqEdLG9Y3xdGENi2ELcIdB3FJGyUW4d7Q3B4BTqPV9Vj190KaoXTbCAfY
         3Ku2CuzrfzRQqyD4tk/HQgmuiAutQUyh033N8AGioX7sNq5WHqhO7nDThWnTwb9ie2
         ZFIH4Y4aDzZYskruz5miRu7fRM/LcIwWOl1TEjDCMzWoTgwUoR/jkGNqKZGEVCyoIs
         qQdEmKpb2Bxrg==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] mailbox: mtk-cmdq: Remove proprietary cmdq_task_cb
Date:   Wed,  8 Jun 2022 22:40:55 +0800
Message-Id: <20220608144055.27562-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rx_callback is a standard mailbox callback mechanism and could cover the
function of proprietary cmdq_task_cb, so use the standard one instead of
the proprietary one. Client driver has changed to use standard
rx_callback, so remove proprietary cmdq_task_cb.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 11 -----------
 include/linux/mailbox/mtk-cmdq-mailbox.h | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 2578e5aaa935..9465f9081515 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -192,15 +192,10 @@ static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
 
 static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
 {
-	struct cmdq_task_cb *cb = &task->pkt->async_cb;
 	struct cmdq_cb_data data;
 
 	data.sta = sta;
-	data.data = cb->data;
 	data.pkt = task->pkt;
-	if (cb->cb)
-		cb->cb(data);
-
 	mbox_chan_received_data(task->thread->chan, &data);
 
 	list_del(&task->list_entry);
@@ -448,7 +443,6 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 {
 	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
-	struct cmdq_task_cb *cb;
 	struct cmdq_cb_data data;
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task, *tmp;
@@ -465,13 +459,8 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
-		cb = &task->pkt->async_cb;
 		data.sta = -ECONNABORTED;
-		data.data = cb->data;
 		data.pkt = task->pkt;
-		if (cb->cb)
-			cb->cb(data);
-
 		mbox_chan_received_data(task->thread->chan, &data);
 		list_del(&task->list_entry);
 		kfree(task);
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index 44365aab043c..a8f0070c7aa9 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -67,24 +67,14 @@ enum cmdq_code {
 
 struct cmdq_cb_data {
 	int			sta;
-	void			*data;
 	struct cmdq_pkt		*pkt;
 };
 
-typedef void (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
-
-struct cmdq_task_cb {
-	cmdq_async_flush_cb	cb;
-	void			*data;
-};
-
 struct cmdq_pkt {
 	void			*va_base;
 	dma_addr_t		pa_base;
 	size_t			cmd_buf_size; /* command occupied size */
 	size_t			buf_size; /* real buffer size */
-	struct cmdq_task_cb	cb;
-	struct cmdq_task_cb	async_cb;
 	void			*cl;
 };
 
-- 
2.25.1

