Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF9156CC92
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 06:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGJEJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 00:09:36 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE412D3B;
        Sat,  9 Jul 2022 21:09:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LgYR83wbqz6PCRP;
        Sun, 10 Jul 2022 12:08:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mn4UMpiguJUAg--.16364S5;
        Sun, 10 Jul 2022 12:09:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, asml.silence@gmail.com, osandov@fb.com,
        jack@suse.cz
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RFC v3 1/3] sbitmap: fix that same waitqueue can be woken up continuously
Date:   Sun, 10 Jul 2022 12:21:58 +0800
Message-Id: <20220710042200.20936-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220710042200.20936-1-yukuai1@huaweicloud.com>
References: <20220710042200.20936-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mn4UMpiguJUAg--.16364S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47GrW5ur4fWFWxXFyftFb_yoW8Cry7pa
        17XFyvvr4jqry2k3ykXF4UAw15GwnF9r9rGr4rG3WjvFsrKr45J3WvvFs8ur18uFsrCayr
        JF47tFW3Gr4UXFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU=
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

__sbq_wake_up		__sbq_wake_up
 sbq_wake_ptr -> assume	0
			 sbq_wake_ptr -> 0
 atomic_dec_return
			atomic_dec_return
 atomic_cmpxchg -> succeed
			 atomic_cmpxchg -> failed
			  return true

			__sbq_wake_up
			 sbq_wake_ptr
			  atomic_read(&sbq->wake_index) -> still 0
 sbq_index_atomic_inc -> inc to 1
			  if (waitqueue_active(&ws->wait))
			   if (wake_index != atomic_read(&sbq->wake_index))
			    atomic_set -> reset from 1 to 0
 wake_up_nr -> wake up first waitqueue
			    // continue to wake up in first waitqueue

Fix the problem by using atomic_cmpxchg() instead of atomic_set()
to update 'wake_index'.

Fixes: 417232880c8a ("sbitmap: Replace cmpxchg with xchg")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/sbitmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 29eb0484215a..b46fce1beb3a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -579,19 +579,24 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
 
 static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 {
-	int i, wake_index;
+	int i, wake_index, old_wake_index;
 
+again:
 	if (!atomic_read(&sbq->ws_active))
 		return NULL;
 
-	wake_index = atomic_read(&sbq->wake_index);
+	old_wake_index = wake_index = atomic_read(&sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
 		if (waitqueue_active(&ws->wait)) {
-			if (wake_index != atomic_read(&sbq->wake_index))
-				atomic_set(&sbq->wake_index, wake_index);
-			return ws;
+			if (wake_index == old_wake_index)
+				return ws;
+
+			if (atomic_cmpxchg(&sbq->wake_index, old_wake_index,
+					   wake_index) == old_wake_index)
+				return ws;
+			goto again;
 		}
 
 		wake_index = sbq_index_inc(wake_index);
-- 
2.31.1

