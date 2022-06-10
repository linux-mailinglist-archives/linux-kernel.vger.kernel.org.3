Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0046545B47
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbiFJEsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243195AbiFJEs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:48:27 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B7F3464A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:48:24 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25A4mHXp068524;
        Fri, 10 Jun 2022 13:48:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Fri, 10 Jun 2022 13:48:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25A4mGB9068501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Jun 2022 13:48:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ad924306-d15c-9f1e-13dc-eaf674878022@I-love.SAKURA.ne.jp>
Date:   Fri, 10 Jun 2022 13:48:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] rapidio/tsi721: avoid flush_scheduled_work() usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local wq in order to avoid flush_scheduled_work() usage.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
using a macro") for background.

Is allocating one workqueue for each "struct tsi721_device" too much,
given that "struct tsi721_device" has only pw_work and idb_work? If yes,
we could use module_init()/module_exit() for creating/destroying per a
module workqueue.

 drivers/rapidio/devices/tsi721.c | 19 ++++++++++++++-----
 drivers/rapidio/devices/tsi721.h |  3 +++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index b3134744fb55..a2e4969e2122 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -282,7 +282,7 @@ tsi721_pw_handler(struct tsi721_device *priv)
 	iowrite32(TSI721_RIO_PW_RX_STAT_PW_DISC | TSI721_RIO_PW_RX_STAT_PW_VAL,
 		  priv->regs + TSI721_RIO_PW_RX_STAT);
 
-	schedule_work(&priv->pw_work);
+	queue_work(priv->wq, &priv->pw_work);
 
 	return 0;
 }
@@ -373,7 +373,7 @@ tsi721_dbell_handler(struct tsi721_device *priv)
 	iowrite32(regval,
 		priv->regs + TSI721_SR_CHINTE(IDB_QUEUE));
 
-	schedule_work(&priv->idb_work);
+	queue_work(priv->wq, &priv->idb_work);
 
 	return 0;
 }
@@ -443,7 +443,7 @@ static void tsi721_db_dpc(struct work_struct *work)
 
 	wr_ptr = ioread32(priv->regs + TSI721_IDQ_WP(IDB_QUEUE)) % IDB_QSIZE;
 	if (wr_ptr != rd_ptr)
-		schedule_work(&priv->idb_work);
+		queue_work(priv->wq, &priv->idb_work);
 }
 
 /**
@@ -2743,10 +2743,16 @@ static int tsi721_probe(struct pci_dev *pdev,
 		goto err_exit;
 	}
 
+	priv->wq = alloc_workqueue("tsi721_wq", 0, 0);
+	if (!priv->wq) {
+		err = -ENOMEM;
+		goto err_clean;
+	}
+
 	err = pci_enable_device(pdev);
 	if (err) {
 		tsi_err(&pdev->dev, "Failed to enable PCI device");
-		goto err_clean;
+		goto err_free_wq;
 	}
 
 	priv->pdev = pdev;
@@ -2927,6 +2933,8 @@ static int tsi721_probe(struct pci_dev *pdev,
 	pci_clear_master(pdev);
 err_disable_pdev:
 	pci_disable_device(pdev);
+err_free_wq:
+	destroy_workqueue(priv->wq);
 err_clean:
 	kfree(priv);
 err_exit:
@@ -2941,7 +2949,7 @@ static void tsi721_remove(struct pci_dev *pdev)
 
 	tsi721_disable_ints(priv);
 	tsi721_free_irq(priv);
-	flush_scheduled_work();
+	flush_workqueue(priv->wq);
 	rio_unregister_mport(&priv->mport);
 
 	tsi721_unregister_dma(priv);
@@ -2964,6 +2972,7 @@ static void tsi721_remove(struct pci_dev *pdev)
 	pci_clear_master(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
+	destroy_workqueue(priv->wq);
 	kfree(priv);
 	tsi_debug(EXIT, &pdev->dev, "exit");
 }
diff --git a/drivers/rapidio/devices/tsi721.h b/drivers/rapidio/devices/tsi721.h
index 4f996ce62725..57a38d24ed8f 100644
--- a/drivers/rapidio/devices/tsi721.h
+++ b/drivers/rapidio/devices/tsi721.h
@@ -908,6 +908,9 @@ struct tsi721_device {
 	struct tsi721_obw_bar p2r_bar[2];
 	struct tsi721_ob_win  ob_win[TSI721_OBWIN_NUM];
 	int		obwin_cnt;
+
+	/* Workqueue for processing works in this struct. */
+	struct workqueue_struct *wq;
 };
 
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
-- 
2.18.4
