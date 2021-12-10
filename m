Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7988346F9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhLJEtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:49:49 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15717 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhLJEtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:49:46 -0500
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9JF12DkNzZfgs;
        Fri, 10 Dec 2021 12:43:17 +0800 (CST)
Received: from localhost.huawei.com (10.175.124.27) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 12:46:09 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <song@kernel.org>, <philipp.reisner@linbit.com>,
        <lars.ellenberg@linbit.com>, <axboe@kernel.dk>, <hare@suse.de>,
        <jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
        <mcgrof@kernel.org>, <mcroce@microsoft.com>
CC:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <drbd-dev@lists.linbit.com>,
        <linfeilong@huawei.com>
Subject: [PATCH 2/3] drdb: Fix undefined behaviour in drbd_rs_c_min_rate_throttle
Date:   Fri, 10 Dec 2021 13:17:06 +0800
Message-ID: <20211210051707.2202646-3-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210051707.2202646-1-lijinlin3@huawei.com>
References: <20211210051707.2202646-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the stat aacum of the disk is greater than INT_MAX, its
value becomes negative after casting to 'int', which may lead
to overflow after subtracting a positive number. In the same
way, when the value of rs_sect_ev is greater than INT_MAX,
overflow may also occur. These situations will lead to
undefined behavior.

Otherwise, if the stat accum of the disk is close to INT_MAX
when creating md, the initial value of rs_last_events would be
set close to INT_MAX when mddev initializes IO event counters.
'curr_events - device->rs_last_events > 64' will always false
during synchronization, which may cause resync is not throttled
even if the lower device is busy.

Fix by using atomic64_t type for rs_sect_ev, and using s64 type
for curr_events/last_events.

Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_int.h      |  4 ++--
 drivers/block/drbd/drbd_main.c     |  2 +-
 drivers/block/drbd/drbd_receiver.c | 12 ++++++------
 drivers/block/drbd/drbd_worker.c   |  4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index c1f816f896a8..d580f4071622 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1021,7 +1021,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 		submit_bio(bio);
 		/* this should not count as user activity and cause the
 		 * resync to throttle -- see drbd_rs_should_slow_down(). */
-		atomic_add(len >> 9, &device->rs_sect_ev);
+		atomic64_add(len >> 9, &device->rs_sect_ev);
 	}
 }
 
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f27d5b0f9a0b..1b71adc07e83 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -954,9 +954,9 @@ struct drbd_device {
 	struct mutex *state_mutex; /* either own_state_mutex or first_peer_device(device)->connection->cstate_mutex */
 	char congestion_reason;  /* Why we where congested... */
 	atomic_t rs_sect_in; /* for incoming resync data rate, SyncTarget */
-	atomic_t rs_sect_ev; /* for submitted resync data rate, both */
+	atomic64_t rs_sect_ev; /* for submitted resync data rate, both */
 	int rs_last_sect_ev; /* counter to compare with */
-	int rs_last_events;  /* counter of read or write "events" (unit sectors)
+	s64 rs_last_events;  /* counter of read or write "events" (unit sectors)
 			      * on the lower level device when we last looked. */
 	int c_sync_rate; /* current resync rate after syncer throttle magic */
 	struct fifo_buffer *rs_plan_s; /* correction values of resync planer (RCU, connection->conn_update) */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 53ba2dddba6e..ea057bd60541 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1974,7 +1974,7 @@ void drbd_init_set_defaults(struct drbd_device *device)
 	atomic_set(&device->local_cnt, 0);
 	atomic_set(&device->pp_in_use_by_net, 0);
 	atomic_set(&device->rs_sect_in, 0);
-	atomic_set(&device->rs_sect_ev, 0);
+	atomic64_set(&device->rs_sect_ev, 0);
 	atomic_set(&device->ap_in_flight, 0);
 	atomic_set(&device->md_io.in_use, 0);
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1f740e42e457..4b75ad3dd0cd 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2106,7 +2106,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	list_add_tail(&peer_req->w.list, &device->sync_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
-	atomic_add(pi->size >> 9, &device->rs_sect_ev);
+	atomic64_add(pi->size >> 9, &device->rs_sect_ev);
 	if (drbd_submit_peer_request(device, peer_req, REQ_OP_WRITE, 0,
 				     DRBD_FAULT_RS_WR) == 0)
 		return 0;
@@ -2792,7 +2792,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	struct gendisk *disk = device->ldev->backing_bdev->bd_disk;
 	unsigned long db, dt, dbdt;
 	unsigned int c_min_rate;
-	int curr_events;
+	s64 curr_events;
 
 	rcu_read_lock();
 	c_min_rate = rcu_dereference(device->ldev->disk_conf)->c_min_rate;
@@ -2802,8 +2802,8 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
-			atomic_read(&device->rs_sect_ev);
+	curr_events = (s64)part_stat_read_accum(disk->part0, sectors) -
+			atomic64_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
 	    || curr_events - device->rs_last_events > 64) {
@@ -3023,7 +3023,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		goto out_free_e;
 
 submit_for_resync:
-	atomic_add(size >> 9, &device->rs_sect_ev);
+	atomic64_add(size >> 9, &device->rs_sect_ev);
 
 submit:
 	update_receiver_timing_details(connection, drbd_submit_peer_request);
@@ -5019,7 +5019,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 		list_add_tail(&peer_req->w.list, &device->sync_ee);
 		spin_unlock_irq(&device->resource->req_lock);
 
-		atomic_add(pi->size >> 9, &device->rs_sect_ev);
+		atomic64_add(pi->size >> 9, &device->rs_sect_ev);
 		err = drbd_submit_peer_request(device, peer_req, op, 0, DRBD_FAULT_RS_WR);
 
 		if (err) {
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 64563bfdf0da..a4edd0a9c875 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -409,7 +409,7 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
 	list_add_tail(&peer_req->w.list, &device->read_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
-	atomic_add(size >> 9, &device->rs_sect_ev);
+	atomic64_add(size >> 9, &device->rs_sect_ev);
 	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ, 0,
 				     DRBD_FAULT_RS_RD) == 0)
 		return 0;
@@ -1679,7 +1679,7 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	struct fifo_buffer *plan;
 
 	atomic_set(&device->rs_sect_in, 0);
-	atomic_set(&device->rs_sect_ev, 0);
+	atomic64_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
 	device->rs_last_events =
 		(int)part_stat_read_accum(disk->part0, sectors);
-- 
2.27.0

