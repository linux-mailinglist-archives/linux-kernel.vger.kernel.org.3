Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4516857B3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiGTJb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiGTJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:31:17 -0400
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3452C54CBE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:31:16 -0700 (PDT)
X-QQ-mid: bizesmtp65t1658309470tox533d0
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 20 Jul 2022 17:31:09 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000020
X-QQ-FEAT: Zf2po6e9he4aYUlcKXg5HBZNLlmaErk3YUM5+bv5OQWzmDN/KBJPtIJFWpNwH
        TC+d2e+s/YjkDXMlwS34CVe5t8Nee/Mrt7dYdXGIJ1B9/1H2LdjrYJY6mr56iQeKjhAZs5E
        x4hCvPOdpSxR/8HkZXMgCTVL7sbr112w42FcGHHrCvlMZx350X6mGPDvc7EkprPI4J0cJYO
        oqTfw7EcNflNCDvuI/ATkVfsXqelXU9yJ58xzA83Y+b4I/qeX0JvWMpcpPD6jthLiL8fGDO
        iMsq8nfR9lMm6HHsIjhN4fWxlg4mMj9tp5NDzPduvGQpQLuGsUuI/KLxMqmjDuv63KPpCj1
        EW0ir0vPJPupkTpTwPOG4Mni8+PdpHzFPsnOcEe7HcbO+kZemuIgQi90q2khjGH01goGm8c
        gETk3gXg1rnSYA0D8pSnPQ==
X-QQ-GoodBg: 1
From:   Wang You <wangyoua@uniontech.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangyoua@uniontech.com,
        wangxiaohua@uniontech.com
Subject: [PATCH 2/2] block/mq-deadline: Prioritize first request
Date:   Wed, 20 Jul 2022 17:30:48 +0800
Message-Id: <20220720093048.225944-3-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220720093048.225944-1-wangyoua@uniontech.com>
References: <20220720093048.225944-1-wangyoua@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function deadline_head_request can select the request located at
the head from the sector red-black tree of the mq-deadline scheduler,
dispatch such a request may cause the disk access address to return
to the head, so as to prevent it from swinging back and forth.

- The presence of the scheduler batching requests may reduce or
  even eliminate its ability to fuse and sort, so I sometimes set
  it to 1.

- This pathc may exacerbate the risk of expire, I don't know if
  a more absolute expire detection is necessary.

- Tested some disks (mainly rotational disks and some SSDs) with
  the fio tool (using sync, direct, etc. parameters), the results
  show that they increase the disk's small sector sequential read
  and write performance, does this imply that changing
  nr_sched_batch is reasonable?

The test hardware is:
Kunpeng-920, HW-SAS3508+(MG04ACA400N * 2), RAID0.

The test command is:
fio -ioengine=psync -lockmem=1G -buffered=0 -time_based=1 -direct=1
-iodepth=1 -thread -bs=512B -size=110g -numjobs=16 -runtime=300
-group_reporting -name=read -filename=/dev/sdb14
-ioscheduler=mq-deadline -rw=read[,write,rw]

The following is the test data:
origin/master:
read iops: 152421       write iops: 136959      rw iops: 54593,54581

nr_sched_batch = 1:
read iops: 166449       write iops: 139477      rw iops: 55363,55355

nr_sched_batch = 1, use deadline_head_request:
read iops: 171177       write iops: 184431      rw iops: 56178,56169

Signed-off-by: Wang You <wangyoua@uniontech.com>
---
 block/mq-deadline.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a9e835e816c..e155f49d7a70 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -344,6 +344,35 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	return rq;
 }
 
+static inline struct request *
+deadline_head_request(struct deadline_data *dd, struct dd_per_prio *per_prio, int data_dir)
+{
+	struct rb_node *node = rb_first(&per_prio->sort_list[data_dir]);
+	struct request *rq;
+	unsigned long flags;
+
+	if (!node)
+		return NULL;
+
+	rq = rb_entry_rq(node);
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+		return rq;
+
+	/*
+	 * Look for a write request that can be dispatched, that is one with
+	 * an unlocked target zone.
+	 */
+	spin_lock_irqsave(&dd->zone_lock, flags);
+	while (rq) {
+		if (blk_req_can_dispatch_to_zone(rq))
+			break;
+		rq = deadline_latter_request(rq);
+	}
+	spin_unlock_irqrestore(&dd->zone_lock, flags);
+
+	return rq;
+}
+
 /*
  * Returns true if and only if @rq started after @latest_start where
  * @latest_start is in jiffies.
@@ -429,13 +458,20 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 * we are not running a batch, find best request for selected data_dir
 	 */
 	next_rq = deadline_next_request(dd, per_prio, data_dir);
-	if (deadline_check_fifo(per_prio, data_dir) || !next_rq) {
+	if (deadline_check_fifo(per_prio, data_dir)) {
 		/*
 		 * A deadline has expired, the last request was in the other
-		 * direction, or we have run out of higher-sectored requests.
-		 * Start again from the request with the earliest expiry time.
+		 * direction. Start again from the request with the earliest
+		 * expiry time.
 		 */
 		rq = deadline_fifo_request(dd, per_prio, data_dir);
+	} else if (!next_rq) {
+		/*
+		 * There is no operation expired, and we have run out of
+		 * higher-sectored requests. Look for the sector at the head
+		 * which may reduce disk seek consumption.
+		 */
+		rq = deadline_head_request(dd, per_prio, data_dir);
 	} else {
 		/*
 		 * The last req was the same dir and we have a next request in
-- 
2.27.0



