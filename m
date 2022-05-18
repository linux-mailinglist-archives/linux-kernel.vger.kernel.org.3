Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2452B991
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiERMNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiERMMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:12:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE614B65C;
        Wed, 18 May 2022 05:12:38 -0700 (PDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3BfW0gsMzgYD4;
        Wed, 18 May 2022 20:11:15 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 20:12:36 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 20:12:36 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 2/6] nbd: fix race between nbd_alloc_config() and module removal
Date:   Wed, 18 May 2022 20:26:14 +0800
Message-ID: <20220518122618.1702997-3-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220518122618.1702997-1-yukuai3@huawei.com>
References: <20220518122618.1702997-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nbd module is being removing, nbd_alloc_config() may be
called concurrently by nbd_genl_connect(), although try_module_get()
will return false, but nbd_alloc_config() doesn't handle it.

The race may lead to the leak of nbd_config and its related
resources (e.g, recv_workq) and oops in nbd_read_stat() due
to the unload of nbd module as shown below:

  BUG: kernel NULL pointer dereference, address: 0000000000000040
  Oops: 0000 [#1] SMP PTI
  CPU: 5 PID: 13840 Comm: kworker/u17:33 Not tainted 5.14.0+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Workqueue: knbd16-recv recv_work [nbd]
  RIP: 0010:nbd_read_stat.cold+0x130/0x1a4 [nbd]
  Call Trace:
   recv_work+0x3b/0xb0 [nbd]
   process_one_work+0x1ed/0x390
   worker_thread+0x4a/0x3d0
   kthread+0x12a/0x150
   ret_from_fork+0x22/0x30

Fixing it by checking the return value of try_module_get()
in nbd_alloc_config(). As nbd_alloc_config() may return ERR_PTR(-ENODEV),
assign nbd->config only when nbd_alloc_config() succeeds to ensure
the value of nbd->config is binary (valid or NULL).

Also adding a debug message to check the reference counter
of nbd_config during module removal.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a73e853f5833..2ee1e376d5c4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1518,15 +1518,20 @@ static struct nbd_config *nbd_alloc_config(void)
 {
 	struct nbd_config *config;
 
+	if (!try_module_get(THIS_MODULE))
+		return ERR_PTR(-ENODEV);
+
 	config = kzalloc(sizeof(struct nbd_config), GFP_NOFS);
-	if (!config)
-		return NULL;
+	if (!config) {
+		module_put(THIS_MODULE);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	atomic_set(&config->recv_threads, 0);
 	init_waitqueue_head(&config->recv_wq);
 	init_waitqueue_head(&config->conn_wait);
 	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
 	atomic_set(&config->live_connections, 0);
-	try_module_get(THIS_MODULE);
 	return config;
 }
 
@@ -1553,12 +1558,13 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
-		config = nbd->config = nbd_alloc_config();
-		if (!config) {
-			ret = -ENOMEM;
+		config = nbd_alloc_config();
+		if (IS_ERR(config)) {
+			ret = PTR_ERR(config);
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
+		nbd->config = config;
 		refcount_set(&nbd->config_refs, 1);
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
@@ -1964,13 +1970,14 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		nbd_put(nbd);
 		return -EINVAL;
 	}
-	config = nbd->config = nbd_alloc_config();
-	if (!nbd->config) {
+	config = nbd_alloc_config();
+	if (IS_ERR(config)) {
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
 		printk(KERN_ERR "nbd: couldn't allocate config\n");
-		return -ENOMEM;
+		return PTR_ERR(config);
 	}
+	nbd->config = config;
 	refcount_set(&nbd->config_refs, 1);
 	set_bit(NBD_RT_BOUND, &config->runtime_flags);
 
@@ -2543,6 +2550,9 @@ static void __exit nbd_cleanup(void)
 	while (!list_empty(&del_list)) {
 		nbd = list_first_entry(&del_list, struct nbd_device, list);
 		list_del_init(&nbd->list);
+		if (refcount_read(&nbd->config_refs))
+			printk(KERN_ERR "nbd: possibly leaking nbd_config (ref %d)\n",
+					refcount_read(&nbd->config_refs));
 		if (refcount_read(&nbd->refs) != 1)
 			printk(KERN_ERR "nbd: possibly leaking a device\n");
 		nbd_put(nbd);
-- 
2.31.1

