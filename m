Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2005020F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbiDODoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349127AbiDODoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:44:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260502CC9F;
        Thu, 14 Apr 2022 20:41:39 -0700 (PDT)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kfhtz1knSzfYnm;
        Fri, 15 Apr 2022 11:40:59 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 11:41:37 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 11:41:36 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RESEND] blk-mq: fix possible creation failure for 'debugfs_dir'
Date:   Fri, 15 Apr 2022 11:56:07 +0800
Message-ID: <20220415035607.1836495-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'q->debugfs_dir' is created in blk_register_queue(), however, it's not
removed in blk_unregister_queue() and is delayed to blk_release_queue().
Thus it's possible that del_gendisk() is done and blk_release_queue()
is not called yet, and in the mean time blk_register_queue() is called
for the new device with the same name. In this case, kernel will
compalin about creation failure for 'debugfs_dir' like following:

debugfs: Directory 'nullb1' with parent 'block' already present!

Fix the problem by moving forward the removal of 'debgfs_dir' to
blk_unregister_queue().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb59..15fc3f0786e3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -779,11 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
-	blk_trace_shutdown(q);
-	mutex_lock(&q->debugfs_mutex);
-	debugfs_remove_recursive(q->debugfs_dir);
-	mutex_unlock(&q->debugfs_mutex);
-
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -951,5 +946,11 @@ void blk_unregister_queue(struct gendisk *disk)
 
 	mutex_unlock(&q->sysfs_dir_lock);
 
+	blk_trace_shutdown(q);
+	mutex_lock(&q->debugfs_mutex);
+	blk_mq_debugfs_unregister_hctxs(q);
+	debugfs_remove_recursive(q->debugfs_dir);
+	mutex_unlock(&q->debugfs_mutex);
+
 	kobject_put(&disk_to_dev(disk)->kobj);
 }
-- 
2.31.1

