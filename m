Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62512562899
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiGAByy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGAByw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:54:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC81252BA;
        Thu, 30 Jun 2022 18:54:49 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LYyrF3sS4z1L8X1;
        Fri,  1 Jul 2022 09:52:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Jul
 2022 09:54:47 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH v3] crypto: hisilicon - Kunpeng916 crypto driver don't sleep when in softirq
Date:   Fri, 1 Jul 2022 09:59:54 +0800
Message-ID: <20220701015954.387310-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kunpeng916 encryption driver is used to deencrypt and decrypt
packets during the softirq, it is not allowed to use mutex lock.

Fixes: 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v2: add fixes info
v1: use spin_lock will cause soft lockup

 drivers/crypto/hisilicon/sec/sec_algs.c | 14 +++++++-------
 drivers/crypto/hisilicon/sec/sec_drv.h  |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec/sec_algs.c b/drivers/crypto/hisilicon/sec/sec_algs.c
index 0a3c8f019b02..490e1542305e 100644
--- a/drivers/crypto/hisilicon/sec/sec_algs.c
+++ b/drivers/crypto/hisilicon/sec/sec_algs.c
@@ -449,7 +449,7 @@ static void sec_skcipher_alg_callback(struct sec_bd_info *sec_resp,
 		 */
 	}
 
-	mutex_lock(&ctx->queue->queuelock);
+	spin_lock_bh(&ctx->queue->queuelock);
 	/* Put the IV in place for chained cases */
 	switch (ctx->cipher_alg) {
 	case SEC_C_AES_CBC_128:
@@ -509,7 +509,7 @@ static void sec_skcipher_alg_callback(struct sec_bd_info *sec_resp,
 			list_del(&backlog_req->backlog_head);
 		}
 	}
-	mutex_unlock(&ctx->queue->queuelock);
+	spin_unlock_bh(&ctx->queue->queuelock);
 
 	mutex_lock(&sec_req->lock);
 	list_del(&sec_req_el->head);
@@ -798,7 +798,7 @@ static int sec_alg_skcipher_crypto(struct skcipher_request *skreq,
 	 */
 
 	/* Grab a big lock for a long time to avoid concurrency issues */
-	mutex_lock(&queue->queuelock);
+	spin_lock_bh(&queue->queuelock);
 
 	/*
 	 * Can go on to queue if we have space in either:
@@ -814,15 +814,15 @@ static int sec_alg_skcipher_crypto(struct skcipher_request *skreq,
 		ret = -EBUSY;
 		if ((skreq->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 			list_add_tail(&sec_req->backlog_head, &ctx->backlog);
-			mutex_unlock(&queue->queuelock);
+			spin_unlock_bh(&queue->queuelock);
 			goto out;
 		}
 
-		mutex_unlock(&queue->queuelock);
+		spin_unlock_bh(&queue->queuelock);
 		goto err_free_elements;
 	}
 	ret = sec_send_request(sec_req, queue);
-	mutex_unlock(&queue->queuelock);
+	spin_unlock_bh(&queue->queuelock);
 	if (ret)
 		goto err_free_elements;
 
@@ -881,7 +881,7 @@ static int sec_alg_skcipher_init(struct crypto_skcipher *tfm)
 	if (IS_ERR(ctx->queue))
 		return PTR_ERR(ctx->queue);
 
-	mutex_init(&ctx->queue->queuelock);
+	spin_lock_init(&ctx->queue->queuelock);
 	ctx->queue->havesoftqueue = false;
 
 	return 0;
diff --git a/drivers/crypto/hisilicon/sec/sec_drv.h b/drivers/crypto/hisilicon/sec/sec_drv.h
index 179a8250d691..e2a50bf2234b 100644
--- a/drivers/crypto/hisilicon/sec/sec_drv.h
+++ b/drivers/crypto/hisilicon/sec/sec_drv.h
@@ -347,7 +347,7 @@ struct sec_queue {
 	DECLARE_BITMAP(unprocessed, SEC_QUEUE_LEN);
 	DECLARE_KFIFO_PTR(softqueue, typeof(struct sec_request_el *));
 	bool havesoftqueue;
-	struct mutex queuelock;
+	spinlock_t queuelock;
 	void *shadow[SEC_QUEUE_LEN];
 };
 
-- 
2.17.1

