Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8098C57F7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiGYBJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:09:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54EA9FD6;
        Sun, 24 Jul 2022 18:09:22 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LrhhW4WJ9zkWmb;
        Mon, 25 Jul 2022 09:06:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Jul
 2022 09:09:20 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <javier.martin@vista-silicon.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH v2] crypto: sahara - don't sleep when in softirq
Date:   Mon, 25 Jul 2022 09:13:24 +0800
Message-ID: <20220725011324.383031-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function of sahara_aes_crypt maybe could be called by function
of crypto_skcipher_encrypt during the rx softirq, so it is not
allowed to use mutex lock.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
This patch is not yet tested, compiled only.
---
 drivers/crypto/sahara.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 457084b344c1..c978d16dc609 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -26,7 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -196,7 +196,7 @@ struct sahara_dev {
 	void __iomem		*regs_base;
 	struct clk		*clk_ipg;
 	struct clk		*clk_ahb;
-	struct mutex		queue_mutex;
+	spinlock_t		queue_spinlock;
 	struct task_struct	*kthread;
 	struct completion	dma_completion;
 
@@ -642,9 +642,9 @@ static int sahara_aes_crypt(struct skcipher_request *req, unsigned long mode)
 
 	rctx->mode = mode;
 
-	mutex_lock(&dev->queue_mutex);
+	spin_lock_bh(&dev->queue_spinlock);
 	err = crypto_enqueue_request(&dev->queue, &req->base);
-	mutex_unlock(&dev->queue_mutex);
+	spin_unlock_bh(&dev->queue_spinlock);
 
 	wake_up_process(dev->kthread);
 
@@ -1043,10 +1043,10 @@ static int sahara_queue_manage(void *data)
 	do {
 		__set_current_state(TASK_INTERRUPTIBLE);
 
-		mutex_lock(&dev->queue_mutex);
+		spin_lock_bh(&dev->queue_spinlock);
 		backlog = crypto_get_backlog(&dev->queue);
 		async_req = crypto_dequeue_request(&dev->queue);
-		mutex_unlock(&dev->queue_mutex);
+		spin_unlock_bh(&dev->queue_spinlock);
 
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
@@ -1092,9 +1092,9 @@ static int sahara_sha_enqueue(struct ahash_request *req, int last)
 		rctx->first = 1;
 	}
 
-	mutex_lock(&dev->queue_mutex);
+	spin_lock_bh(&dev->queue_spinlock);
 	ret = crypto_enqueue_request(&dev->queue, &req->base);
-	mutex_unlock(&dev->queue_mutex);
+	spin_unlock_bh(&dev->queue_spinlock);
 
 	wake_up_process(dev->kthread);
 
@@ -1449,7 +1449,7 @@ static int sahara_probe(struct platform_device *pdev)
 
 	crypto_init_queue(&dev->queue, SAHARA_QUEUE_LENGTH);
 
-	mutex_init(&dev->queue_mutex);
+	spin_lock_init(&dev->queue_spinlock);
 
 	dev_ptr = dev;
 
-- 
2.17.1

