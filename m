Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD59447A973
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhLTMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLTMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:23:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A82BC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:23:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso12744325pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 04:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsgIL1tDtOBFrpOspcS2K2I6OHy7UCaW1Rph+orChAs=;
        b=GXO6ig5L1U27xWqp0VUQcsmGEsk1G6nBK9/KrDH8zpUWvR3CW7T0qExr2heJCnrv1t
         jScBMnJKJJ2/C6tYDb8SGcwXPvpsSGJw8gxyr7+3dQhQsbcq+p7Xzs4lpxbSH4sijvjS
         R/PFxmtcMKd+wWEo2Abytjo5M+aSqSHLE8zuwshbmsMyzyWLS7veie4rECCRN6ghCS6K
         V5o8ogAULtggJ451Y+vTfVj9MsraxHGhQj0DQzNPHva2kJ9Q85g6ISvo+IosDkciaNJr
         KEuc6Jv1lIOHHo0XJ9sRYkyhjLDdBn88p1e5nXBrfOKWX8hjdcX8f6GF2ygSSwMHj53P
         YP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsgIL1tDtOBFrpOspcS2K2I6OHy7UCaW1Rph+orChAs=;
        b=zAZEdIR+LCESi3Ea2/awM82jb21TYvxOgs9JUlG+9dpuGLkJOSx24+8HXfMo1QlDVG
         VkBCEXvZYCUC1FCY/yTCKclZnmgm9UEgp2DRVe3QNnz7mnwNdEuy6VwU7EEtq8FIaSc+
         ngtfFhr5SZeWngXPCQeVFFECvTgqsWoDrxUkJlxLmpkP0Czw9PU4bArUqWME+Z5EZJlY
         zaHXN6Fn303Nk/vxTi9uBpB8pIQsrEpy08Ij2TkuYjKMB0P4braFlPqXk7D/6bqKAZQ6
         CW75yoEISgJI6SZSFNq2l1zgf6IbsoC/xUXmq/ZtiZy/HUBzF3NHP2mC71ZopatPU1oL
         FGQg==
X-Gm-Message-State: AOAM530S1Iq3CPuWCC+kSMuCNFVtLvOCkj8ZFjNv1yieMn8KxVxXFLHP
        QRsPj2aaC0HsiJ7z6GAj3nDnui47LA4k
X-Google-Smtp-Source: ABdhPJzHl5RE3y85EcZXnrvWRI5P8OiaYQAkte8wCBy6l7L9SzAGXn28+KrNbDnNbqw7JaJIOr7zSw==
X-Received: by 2002:a17:902:c60b:b0:149:2afe:489f with SMTP id r11-20020a170902c60b00b001492afe489fmr109271plr.104.1640002991024;
        Mon, 20 Dec 2021 04:23:11 -0800 (PST)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s4sm12994731pjg.54.2021.12.20.04.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 04:23:10 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: Don't use workqueue to handle recv work
Date:   Mon, 20 Dec 2021 20:22:41 +0800
Message-Id: <20211220122241.150-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rescuer thread might take over the works queued on
the workqueue when the worker thread creation timed out.
If this happens, we have no chance to create multiple
recv threads which causes I/O hung on this nbd device.

To fix it, this tries to create kthreads directly to
handle the recv work instead of using workqueue.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/nbd.c | 95 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5a1f98494ddd..e572d1dc20b4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -63,7 +63,6 @@ struct nbd_sock {
 };
 
 struct recv_thread_args {
-	struct work_struct work;
 	struct nbd_device *nbd;
 	int index;
 };
@@ -97,6 +96,7 @@ struct nbd_config {
 
 	atomic_t recv_threads;
 	wait_queue_head_t recv_wq;
+	spinlock_t recv_lock;
 	unsigned int blksize_bits;
 	loff_t bytesize;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -118,7 +118,6 @@ struct nbd_device {
 	struct nbd_config *config;
 	struct mutex config_lock;
 	struct gendisk *disk;
-	struct workqueue_struct *recv_workq;
 	struct work_struct remove_work;
 
 	struct list_head list;
@@ -260,7 +259,6 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	mutex_lock(&nbd_index_mutex);
 	idr_remove(&nbd_index_idr, nbd->index);
 	mutex_unlock(&nbd_index_mutex);
-	destroy_workqueue(nbd->recv_workq);
 	kfree(nbd);
 }
 
@@ -818,11 +816,19 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	return ret ? ERR_PTR(ret) : cmd;
 }
 
-static void recv_work(struct work_struct *work)
+static void flush_recv_works(struct nbd_device *nbd)
 {
-	struct recv_thread_args *args = container_of(work,
-						     struct recv_thread_args,
-						     work);
+	wait_event(nbd->config->recv_wq,
+		   atomic_read(&nbd->config->recv_threads) == 0);
+
+	/* Make sure recv threads have no reference to nbd->config */
+	spin_lock(&nbd->config->recv_lock);
+	spin_unlock(&nbd->config->recv_lock);
+}
+
+static int recv_work(void *data)
+{
+	struct recv_thread_args *args = (struct recv_thread_args *)data;
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
 	struct request_queue *q = nbd->disk->queue;
@@ -866,9 +872,14 @@ static void recv_work(struct work_struct *work)
 	mutex_unlock(&nsock->tx_lock);
 
 	nbd_config_put(nbd);
+
+	spin_lock(&config->recv_lock);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
+	spin_unlock(&config->recv_lock);
 	kfree(args);
+
+	return 0;
 }
 
 static bool nbd_clear_req(struct request *req, void *data, bool reserved)
@@ -1176,6 +1187,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
+		struct task_struct *worker;
 
 		if (!nsock->dead)
 			continue;
@@ -1185,6 +1197,14 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 			mutex_unlock(&nsock->tx_lock);
 			continue;
 		}
+		worker = kthread_create(recv_work, args, "knbd%d.%d-recv",
+					nbd->index, i);
+		if (!worker) {
+			sockfd_put(sock);
+			kfree(args);
+			return -ENOMEM;
+		}
+
 		sk_set_memalloc(sock->sk);
 		if (nbd->tag_set.timeout)
 			sock->sk->sk_sndtimeo = nbd->tag_set.timeout;
@@ -1194,7 +1214,6 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		nsock->fallback_index = -1;
 		nsock->sock = sock;
 		nsock->dead = false;
-		INIT_WORK(&args->work, recv_work);
 		args->index = i;
 		args->nbd = nbd;
 		nsock->cookie++;
@@ -1206,7 +1225,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		/* We take the tx_mutex in an error path in the recv_work, so we
 		 * need to queue_work outside of the tx_mutex.
 		 */
-		queue_work(nbd->recv_workq, &args->work);
+		wake_up_process(worker);
 
 		atomic_inc(&config->live_connections);
 		wake_up(&config->conn_wait);
@@ -1359,34 +1378,42 @@ static int nbd_start_device(struct nbd_device *nbd)
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
 		struct recv_thread_args *args;
+		struct task_struct *worker;
 
 		args = kzalloc(sizeof(*args), GFP_KERNEL);
-		if (!args) {
-			sock_shutdown(nbd);
-			/*
-			 * If num_connections is m (2 < m),
-			 * and NO.1 ~ NO.n(1 < n < m) kzallocs are successful.
-			 * But NO.(n + 1) failed. We still have n recv threads.
-			 * So, add flush_workqueue here to prevent recv threads
-			 * dropping the last config_refs and trying to destroy
-			 * the workqueue from inside the workqueue.
-			 */
-			if (i)
-				flush_workqueue(nbd->recv_workq);
-			return -ENOMEM;
+		if (!args)
+			goto err;
+
+		worker = kthread_create(recv_work, args, "knbd%d.%d-recv",
+					nbd->index, i);
+		if (!worker) {
+			kfree(args);
+			goto err;
 		}
+
 		sk_set_memalloc(config->socks[i]->sock->sk);
 		if (nbd->tag_set.timeout)
 			config->socks[i]->sock->sk->sk_sndtimeo =
 				nbd->tag_set.timeout;
 		atomic_inc(&config->recv_threads);
 		refcount_inc(&nbd->config_refs);
-		INIT_WORK(&args->work, recv_work);
 		args->nbd = nbd;
 		args->index = i;
-		queue_work(nbd->recv_workq, &args->work);
+		wake_up_process(worker);
 	}
 	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
+err:
+	sock_shutdown(nbd);
+	/*
+	 * If num_connections is m (2 < m),
+	 * and NO.1 ~ NO.n(1 < n < m) connections are successful.
+	 * But NO.(n + 1) failed. We still have n recv threads.
+	 * So, add flush_recv_works here to prevent recv threads
+	 * dropping the last config_refs.
+	 */
+	flush_recv_works(nbd);
+
+	return -ENOMEM;
 }
 
 static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *bdev)
@@ -1405,7 +1432,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 					 atomic_read(&config->recv_threads) == 0);
 	if (ret)
 		sock_shutdown(nbd);
-	flush_workqueue(nbd->recv_workq);
+	flush_recv_works(nbd);
 
 	mutex_lock(&nbd->config_lock);
 	nbd_bdev_reset(bdev);
@@ -1525,6 +1552,7 @@ static struct nbd_config *nbd_alloc_config(void)
 	atomic_set(&config->recv_threads, 0);
 	init_waitqueue_head(&config->recv_wq);
 	init_waitqueue_head(&config->conn_wait);
+	spin_lock_init(&config->recv_lock);
 	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
 	atomic_set(&config->live_connections, 0);
 	try_module_get(THIS_MODULE);
@@ -1769,15 +1797,6 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	}
 	nbd->disk = disk;
 
-	nbd->recv_workq = alloc_workqueue("nbd%d-recv",
-					  WQ_MEM_RECLAIM | WQ_HIGHPRI |
-					  WQ_UNBOUND, 0, nbd->index);
-	if (!nbd->recv_workq) {
-		dev_err(disk_to_dev(nbd->disk), "Could not allocate knbd recv work queue.\n");
-		err = -ENOMEM;
-		goto out_err_disk;
-	}
-
 	/*
 	 * Tell the block layer that we are not a rotational device
 	 */
@@ -1808,7 +1827,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	disk->first_minor = index << part_shift;
 	if (disk->first_minor < index || disk->first_minor > MINORMASK) {
 		err = -EINVAL;
-		goto out_free_work;
+		goto out_err_disk;
 	}
 
 	disk->minors = 1 << part_shift;
@@ -1817,7 +1836,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	sprintf(disk->disk_name, "nbd%d", index);
 	err = add_disk(disk);
 	if (err)
-		goto out_free_work;
+		goto out_err_disk;
 
 	/*
 	 * Now publish the device.
@@ -1826,8 +1845,6 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	nbd_total_devices++;
 	return nbd;
 
-out_free_work:
-	destroy_workqueue(nbd->recv_workq);
 out_err_disk:
 	blk_cleanup_disk(disk);
 out_free_idr:
@@ -2086,7 +2103,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	 * Make sure recv thread has finished, we can safely call nbd_clear_que()
 	 * to cancel the inflight I/Os.
 	 */
-	flush_workqueue(nbd->recv_workq);
+	flush_recv_works(nbd);
 	nbd_clear_que(nbd);
 	nbd->task_setup = NULL;
 	mutex_unlock(&nbd->config_lock);
-- 
2.11.0

