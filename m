Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E374E3CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiCVKrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiCVKrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:47:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705112752;
        Tue, 22 Mar 2022 03:45:45 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN7Pd2v2vz684m2;
        Tue, 22 Mar 2022 18:43:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 22 Mar 2022 11:45:43 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:45:39 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hch@lst.de>, <ming.lei@redhat.com>,
        <hare@suse.de>
CC:     <chenxiang66@hisilicon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>,
        <beanhuo@micron.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 01/11] blk-mq: Add blk_mq_init_queue_ops()
Date:   Tue, 22 Mar 2022 18:39:35 +0800
Message-ID: <1647945585-197349-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API to allocate a request queue which accepts a custom set of
blk_mq_ops for that request queue.

The reason which we may want custom ops is for queuing requests which we
don't want to go through the normal queuing path.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq.c         | 23 +++++++++++++++++------
 drivers/md/dm-rq.c     |  2 +-
 include/linux/blk-mq.h |  5 ++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3bf3358a3bb..8ea3447339ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3858,7 +3858,7 @@ void blk_mq_release(struct request_queue *q)
 }
 
 static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
-		void *queuedata)
+		void *queuedata, const struct blk_mq_ops *ops)
 {
 	struct request_queue *q;
 	int ret;
@@ -3867,27 +3867,35 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	if (!q)
 		return ERR_PTR(-ENOMEM);
 	q->queuedata = queuedata;
-	ret = blk_mq_init_allocated_queue(set, q);
+	ret = blk_mq_init_allocated_queue(set, q, ops);
 	if (ret) {
 		blk_cleanup_queue(q);
 		return ERR_PTR(ret);
 	}
+
 	return q;
 }
 
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 {
-	return blk_mq_init_queue_data(set, NULL);
+	return blk_mq_init_queue_data(set, NULL, NULL);
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
+struct request_queue *blk_mq_init_queue_ops(struct blk_mq_tag_set *set,
+					    const struct blk_mq_ops *custom_ops)
+{
+	return blk_mq_init_queue_data(set, NULL, custom_ops);
+}
+EXPORT_SYMBOL(blk_mq_init_queue_ops);
+
 struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 		struct lock_class_key *lkclass)
 {
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_mq_init_queue_data(set, queuedata);
+	q = blk_mq_init_queue_data(set, queuedata, NULL);
 	if (IS_ERR(q))
 		return ERR_CAST(q);
 
@@ -4010,13 +4018,16 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 }
 
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
-		struct request_queue *q)
+		struct request_queue *q, const struct blk_mq_ops *custom_ops)
 {
 	WARN_ON_ONCE(blk_queue_has_srcu(q) !=
 			!!(set->flags & BLK_MQ_F_BLOCKING));
 
 	/* mark the queue as mq asap */
-	q->mq_ops = set->ops;
+	if (custom_ops)
+		q->mq_ops = custom_ops;
+	else
+		q->mq_ops = set->ops;
 
 	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
 					     blk_mq_poll_stats_bkt,
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 3907950a0ddc..9d93f72a3eec 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -560,7 +560,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	if (err)
 		goto out_kfree_tag_set;
 
-	err = blk_mq_init_allocated_queue(md->tag_set, md->queue);
+	err = blk_mq_init_allocated_queue(md->tag_set, md->queue, NULL);
 	if (err)
 		goto out_tag_set;
 	return 0;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d319ffa59354..e12d17c86c52 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -688,8 +688,11 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 	__blk_mq_alloc_disk(set, queuedata, &__key);			\
 })
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
+struct request_queue *blk_mq_init_queue_ops(struct blk_mq_tag_set *,
+		const struct blk_mq_ops *custom_ops);
+
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
-		struct request_queue *q);
+		struct request_queue *q, const struct blk_mq_ops *custom_ops);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
-- 
2.26.2

