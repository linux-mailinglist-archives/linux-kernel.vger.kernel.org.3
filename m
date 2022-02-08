Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF84AD974
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348732AbiBHNSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349825AbiBHMMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:12:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F7BC03FEC0;
        Tue,  8 Feb 2022 04:12:28 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JtMLm3sGSz67xNM;
        Tue,  8 Feb 2022 20:11:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 13:12:26 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 12:12:24 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] sbitmap: Delete old sbitmap_queue_get_shallow()
Date:   Tue, 8 Feb 2022 20:07:04 +0800
Message-ID: <1644322024-105340-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since __sbitmap_queue_get_shallow() was introduced in commit c05e66733788
("sbitmap: add sbitmap_get_shallow() operation"), it has not been used.

Delete __sbitmap_queue_get_shallow() and rename public
__sbitmap_queue_get_shallow() -> sbitmap_queue_get_shallow() as it is odd
to have public __foo but no foo at all.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 845f74e8dd7b..0fd409b8e86e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -107,7 +107,7 @@ static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 		return BLK_MQ_NO_TAG;
 
 	if (data->shallow_depth)
-		return __sbitmap_queue_get_shallow(bt, data->shallow_depth);
+		return sbitmap_queue_get_shallow(bt, data->shallow_depth);
 	else
 		return __sbitmap_queue_get(bt);
 }
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index df3b584b0f0c..dffeb8281c2d 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -135,7 +135,7 @@ struct sbitmap_queue {
 
 	/**
 	 * @min_shallow_depth: The minimum shallow depth which may be passed to
-	 * sbitmap_queue_get_shallow() or __sbitmap_queue_get_shallow().
+	 * sbitmap_queue_get_shallow()
 	 */
 	unsigned int min_shallow_depth;
 };
@@ -463,7 +463,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 					unsigned int *offset);
 
 /**
- * __sbitmap_queue_get_shallow() - Try to allocate a free bit from a &struct
+ * sbitmap_queue_get_shallow() - Try to allocate a free bit from a &struct
  * sbitmap_queue, limiting the depth used from each word, with preemption
  * already disabled.
  * @sbq: Bitmap queue to allocate from.
@@ -475,8 +475,8 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
  *
  * Return: Non-negative allocated bit number if successful, -1 otherwise.
  */
-int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
-				unsigned int shallow_depth);
+int sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
+			      unsigned int shallow_depth);
 
 /**
  * sbitmap_queue_get() - Try to allocate a free bit from a &struct
@@ -498,32 +498,6 @@ static inline int sbitmap_queue_get(struct sbitmap_queue *sbq,
 	return nr;
 }
 
-/**
- * sbitmap_queue_get_shallow() - Try to allocate a free bit from a &struct
- * sbitmap_queue, limiting the depth used from each word.
- * @sbq: Bitmap queue to allocate from.
- * @cpu: Output parameter; will contain the CPU we ran on (e.g., to be passed to
- *       sbitmap_queue_clear()).
- * @shallow_depth: The maximum number of bits to allocate from a single word.
- * See sbitmap_get_shallow().
- *
- * If you call this, make sure to call sbitmap_queue_min_shallow_depth() after
- * initializing @sbq.
- *
- * Return: Non-negative allocated bit number if successful, -1 otherwise.
- */
-static inline int sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
-					    unsigned int *cpu,
-					    unsigned int shallow_depth)
-{
-	int nr;
-
-	*cpu = get_cpu();
-	nr = __sbitmap_queue_get_shallow(sbq, shallow_depth);
-	put_cpu();
-	return nr;
-}
-
 /**
  * sbitmap_queue_min_shallow_depth() - Inform a &struct sbitmap_queue of the
  * minimum shallow depth that will be used.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index b7cb96ae4701..2eb3de18ded3 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -557,14 +557,14 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 	return 0;
 }
 
-int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
-				unsigned int shallow_depth)
+int sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
+			      unsigned int shallow_depth)
 {
 	WARN_ON_ONCE(shallow_depth < sbq->min_shallow_depth);
 
 	return sbitmap_get_shallow(&sbq->sb, shallow_depth);
 }
-EXPORT_SYMBOL_GPL(__sbitmap_queue_get_shallow);
+EXPORT_SYMBOL_GPL(sbitmap_queue_get_shallow);
 
 void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
 				     unsigned int min_shallow_depth)
-- 
2.26.2

