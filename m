Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055585035D0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiDPJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiDPJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 05:57:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C367F6590
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 02:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 732FFB81D0A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 09:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11875C385A3;
        Sat, 16 Apr 2022 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650102887;
        bh=75R1UEWugAKgPowTPgnhtbX6VQG5h2cX089a+YURiW0=;
        h=From:To:Cc:Subject:Date:From;
        b=quZSnKZVkLtXwXwETZFSIhf4J0rdmTRUIKssNt7xjoj5sN0AFweRpLak+xhRVU8bN
         USFxXVHXNWMMSBaWVHFLHjY/yYSt93Yx3Nw8JIomYwAWjVC8Y+f4vcvtHA1rNPCypk
         2D8sjl7ijL0Qwcd9DQtOXu5mQiAfKP4wPpX7hZxfcha7QvFsunNUtDXW2Tak24AGtK
         iEKBvWZ57C133dG2b5ne90IQM+7+tngMLJq0Mes0XGvN81V0LIwhFYgotVRmf4dMJw
         Di1bDxJEtDyrsYYArUCzd7w4PyRA6JnjDrlkP9If91yGUgX+chxhZYpfOC/In92rOp
         6H4+K+0PJIG8g==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [RESEND PATCH] soc: mediatek: cmdq: Use mailbox rx_callback instead of cmdq_task_cb
Date:   Sat, 16 Apr 2022 17:54:28 +0800
Message-Id: <1650102868-26219-1-git-send-email-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
the proprietary one. Client has changed to use the standard callback
machanism and sync dma buffer in client driver, so remove the proprietary
callback in cmdq helper.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +------------------------
 include/linux/soc/mediatek/mtk-cmdq.h  |  5 +----
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 3c8e421..c1837a4 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -425,34 +425,11 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_finalize);
 
-static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
-{
-	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data.data;
-	struct cmdq_task_cb *cb = &pkt->cb;
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
-				pkt->cmd_buf_size, DMA_TO_DEVICE);
-	if (cb->cb) {
-		data.data = cb->data;
-		cb->cb(data);
-	}
-}
-
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
-			 void *data)
+int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
 {
 	int err;
 	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
 
-	pkt->cb.cb = cb;
-	pkt->cb.data = data;
-	pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
-	pkt->async_cb.data = pkt;
-
-	dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
-				   pkt->cmd_buf_size, DMA_TO_DEVICE);
-
 	err = mbox_send_message(client->chan, pkt);
 	if (err < 0)
 		return err;
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index ac6b5f3..2b498f4 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -268,8 +268,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
  * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
  *                          packet and call back at the end of done packet
  * @pkt:	the CMDQ packet
- * @cb:		called at the end of done packet
- * @data:	this data will pass back to cb
  *
  * Return: 0 for success; else the error code is returned
  *
@@ -277,7 +275,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
  * at the end of done packet. Note that this is an ASYNC function. When the
  * function returned, it may or may not be finished.
  */
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
-			 void *data);
+int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
 
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.7.4

