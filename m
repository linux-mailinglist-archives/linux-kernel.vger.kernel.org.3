Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2157DEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiGVJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiGVJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:51:43 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0513D74
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:51:40 -0700 (PDT)
X-QQ-mid: bizesmtp68t1658483494tbs747nq
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 17:51:33 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000020
X-QQ-FEAT: 3auutXC5AV8E3RzgBgxgTnhPlZLbjLHjhmHStedrgoyqUuafpVYdht6B4JDCO
        u6RofgjvrgbKz9de0wgfyMOyzkAv247dcjYD2hP+Oc82MkBTWp0qV56syPX2rUE56g1NBP9
        BYzBirCBEeuv5xSUAJi970KiBMj04RMMYIMLGDS8uhEXw6QtLcvSBVqEXVYn9KFbl0ntSaJ
        Mxg2eQTkyYZ+tCekIwuP7uNYMaMBqmdTe0aBB845gOJ28WQd1VIUdiBPIybPuXAxprR/7HM
        whJRqFODt0hIAfX/mcoS0BV1QdBFrU6UVc9igOXudhmkPQZjG+KyLwjTGbNiHwLihB8m2be
        c6sSXwc5RNz7WDv6FqPtpSfTQeG6q0URLbsJ+zOeMtHCWH6fXtZ8Ae2FHVRHHL1UEpJPBVA
        wVZVPA/4OxOUZWIqK65Nkajc7nIJ+S6V
X-QQ-GoodBg: 1
From:   Wang You <wangyoua@uniontech.com>
To:     axboe@kernel.dk, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangyoua@uniontech.com,
        wangxiaohua@uniontech.com
Subject: [PATCH v2 2/2] block/mq-deadline: Prioritize first request
Date:   Fri, 22 Jul 2022 17:51:20 +0800
Message-Id: <20220722095120.371212-3-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220722095120.371212-1-wangyoua@uniontech.com>
References: <20220722095120.371212-1-wangyoua@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

- Later testing on different hardware showed that the raid controller 
  probably played an important role, but the performance of a single 
  disk did not improve as expected. so I'm not sure if this patch really 
  has the desired effect.

Thanks,

Wang.

The following are all test data:

The test hardware is:
Kunpeng-920, HW-SAS3508+(MG04ACA400N * 2), RAID0.

The test command is:
fio -ioengine=psync -lockmem=1G -buffered=0 -time_based=1 -direct=1
-iodepth=1 -thread -bs=512B -size=110g -numjobs=16 -runtime=300
-group_reporting -name=read -filename=/dev/sdb14
-ioscheduler=mq-deadline -rw=read[,write,rw]

- The following is the test data:
origin/master:
read iops: 152421       write iops: 136959      rw iops: 54593,54581

nr_sched_batch = 1:
read iops: 166449       write iops: 139477      rw iops: 55363,55355

nr_sched_batch = 1, use deadline_head_request:
read iops: 171177       write iops: 184431      rw iops: 56178,56169


- The test hardware is:
Hygon C86, MG04ACA400N

The test command is:
fio -ioengine=psync -lockmem=1G -buffered=0 -time_based=1 -direct=1 -iodepth=1 
-thread -bs=512B -size=110g -numjobs=32 -runtime=300 -group_reporting 
-name=read -filename=/dev/sdc -ioscheduler=mq-deadline -rw=read[,write,rw]

The following is the test data:
origin/master:
read iops: 15463	write iops: 5949	rw iops: 574,576

nr_sched_batch = 1:
read iops: 15082	write iops: 6283	rw iops: 783,786

nr_sched_batch = 1, use deadline_head_request:
read iops: 15368	write iops: 6575	rw iops: 907,906


- The test hardware is:
Kunpeng-920, HW-SAS3508 + Samsung SSD 780, RAID0.

The test command is:
fio -ioengine=psync -lockmem=1G -buffered=0 -time_based=1 -direct=1 -iodepth=1 
-thread -bs=512B -size=110g -numjobs=16 -runtime=300 -group_reporting 
-name=read -filename=/dev/sda -ioscheduler=mq-deadline -rw=read[,write,rw]

The following is the test data:
origin/master:
read iops: 115399       write iops: 136801      rw iops: 58082,58084

nr_sched_batch = 1, use deadline_head_request:
read iops: 136473       write iops: 184646      rw iops: 56460,56454

Signed-off-by: Wang You <wangyoua@uniontech.com>
---
 block/mq-deadline.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a9e835e816c..4660dd4a16f6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -344,6 +344,36 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	return rq;
 }
 
+static inline struct request *
+deadline_head_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
+		      int data_dir)
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
@@ -429,13 +459,20 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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



