Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7B535A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbiE0H2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiE0H2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:28:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE17BA557;
        Fri, 27 May 2022 00:28:43 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8bwX1YVHz1JBsg;
        Fri, 27 May 2022 15:27:08 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:28:41 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:28:40 +0800
From:   keliu <liuke94@huawei.com>
To:     <axboe@kernel.dk>, <idryomov@gmail.com>,
        <dongsheng.yang@easystack.cn>, <mst@redhat.com>,
        <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>, <kch@nvidia.com>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ceph-devel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: block: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:50:10 +0000
Message-ID: <20220527075010.2475520-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 drivers/block/rbd.c           | 4 ++--
 drivers/block/virtio_blk.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c441a4972064..a189f6ba3496 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1724,7 +1724,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	dev = nullb->dev;
 
-	ida_simple_remove(&nullb_indexes, nullb->index);
+	ida_free(&nullb_indexes, nullb->index);
 
 	list_del_init(&nullb->list);
 
@@ -2044,7 +2044,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
 	mutex_lock(&lock);
-	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	nullb->index = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	dev->index = nullb->index;
 	mutex_unlock(&lock);
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b844432bad20..6508085d3dd5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5280,7 +5280,7 @@ static void rbd_dev_release(struct device *dev)
 
 	if (need_put) {
 		destroy_workqueue(rbd_dev->task_wq);
-		ida_simple_remove(&rbd_dev_id_ida, rbd_dev->dev_id);
+		ida_free(&rbd_dev_id_ida, rbd_dev->dev_id);
 	}
 
 	rbd_dev_free(rbd_dev);
@@ -5381,7 +5381,7 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	return rbd_dev;
 
 fail_dev_id:
-	ida_simple_remove(&rbd_dev_id_ida, rbd_dev->dev_id);
+	ida_free(&rbd_dev_id_ida, rbd_dev->dev_id);
 fail_rbd_dev:
 	rbd_dev_free(rbd_dev);
 	return NULL;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a8bcf3f664af..d8f4e98a80a7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -415,7 +415,7 @@ static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
 
-	ida_simple_remove(&vd_index_ida, vblk->index);
+	ida_free(&vd_index_ida, vblk->index);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
 }
@@ -917,7 +917,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
-	ida_simple_remove(&vd_index_ida, index);
+	ida_free(&vd_index_ida, index);
 out:
 	return err;
 }
-- 
2.25.1

