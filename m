Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4C526F80
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiENGzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiENGzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 02:55:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B407338BA;
        Fri, 13 May 2022 23:55:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id a191so9447883pge.2;
        Fri, 13 May 2022 23:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zOmGf1ccVAK4isyF2N1QPhxu8ttnCjPEceo5MAOX1E8=;
        b=d6GY+QWIQylunW7afqlanJIbicpQLieydeeCnPZTlzxfEDdCecOO6wjWVKoJOygHTE
         81Au0oxxrvIyrm6J9U42ajQSnEjdTS0xYUtu3sO8g0EzVTf19uYvnWkq182wkfEFEn1F
         lMQZsQPXrWsuLw/DWMqWUy6/Sj4h3bEBvDRUswY3W9tkkc3K4z5FDHmkBj1jbXZORTDg
         jeQFy0amvU9I5cnHmbwLlZ2/JS18e1VsRFqXi6Tzkt9N8pb2TE60DCTjsl74+l/GXYIa
         3XalRToc5gE1hEPQquOEO9s5UL9jJn8IlUFP9KOsKe/pStlqBP15gW4/CicFDaKmWSNS
         +0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=zOmGf1ccVAK4isyF2N1QPhxu8ttnCjPEceo5MAOX1E8=;
        b=MPG0q1EX3DR5nt9M0FUWsluYp74MgM5U/YPbFEVg6hl+ia28bYMrq3pwo+ILze5Jej
         VCxrW0H4FZzdHORpoZ9/1aFj1F1lcpZsNS1kH812Pkrxvp4PEFGqlpD9v4Jk1fX3sBiP
         U1ejy0floUMBsitzKeMwyPwR0PZS7hYLSGjcAZJoGUIgE58mUwaAiNp5+7T6F6gkvUy0
         i/ipzhr33l8DTDCrqSy4LmGhCho41VYiHizRkCtoUQhHQ4hNhXmJslNvBu+IJJSyG9Cp
         VUFANiGkBBDQVlwuyBmUzKGyeMFvr7VsbV3VbbTMKMT1AeQppuPkNhE/YSCJWsc9QElt
         mJLg==
X-Gm-Message-State: AOAM531TAykMwVqSTEbLkvpLRz9lZUO4VQSghfG1ZlSDEAFcfMXIe/e9
        fRAHDZv8FY8PaxdeRqOStTlHupinEOI=
X-Google-Smtp-Source: ABdhPJz3h9N61qWSfC1798sywI7gqZOFXjOGoYV/pP4fprOW104tK7cUvZgrT8A0QF4A8jKHbyl3zQ==
X-Received: by 2002:a65:6e9a:0:b0:382:1804:35c8 with SMTP id bm26-20020a656e9a000000b00382180435c8mr6980301pgb.584.1652511347854;
        Fri, 13 May 2022 23:55:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:5607])
        by smtp.gmail.com with ESMTPSA id z15-20020aa79f8f000000b0050dc762818dsm1670983pfr.103.2022.05.13.23.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 23:55:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 May 2022 20:55:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH block/for-5.19] blk-iolatency: Fix inflight count imbalances
 and IO hangs on offline
Message-ID: <Yn9ScX6Nx2qIiQQi@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iolatency needs to track the number of inflight IOs per cgroup. As this
tracking can be expensive, it is disabled when no cgroup has iolatency
configured for the device. To ensure that the inflight counters stay
balanced, iolatency_set_limit() freezes the request_queue while manipulating
the enabled counter, which ensures that no IO is in flight and thus all
counters are zero.

Unfortunately, iolatency_set_limit() isn't the only place where the enabled
counter is manipulated. iolatency_pd_offline() can also dec the counter and
trigger disabling. As this disabling happens without freezing the q, this
can easily happen while some IOs are in flight and thus leak the counts.

This can be easily demonstrated by turning on iolatency on an one empty
cgroup while IOs are in flight in other cgroups and then removing the
cgroup. Note that iolatency shouldn't have been enabled elsewhere in the
system to ensure that removing the cgroup disables iolatency for the whole
device.

The following keeps flipping on and off iolatency on sda:

  echo +io > /sys/fs/cgroup/cgroup.subtree_control
  while true; do
      mkdir -p /sys/fs/cgroup/test
      echo '8:0 target=100000' > /sys/fs/cgroup/test/io.latency
      sleep 1
      rmdir /sys/fs/cgroup/test
      sleep 1
  done

and there's concurrent fio generating direct rand reads:

  fio --name test --filename=/dev/sda --direct=1 --rw=randread \
      --runtime=600 --time_based --iodepth=256 --numjobs=4 --bs=4k

while monitoring with the following drgn script:

  while True:
    for css in css_for_each_descendant_pre(prog['blkcg_root'].css.address_of_()):
        for pos in hlist_for_each(container_of(css, 'struct blkcg', 'css').blkg_list):
            blkg = container_of(pos, 'struct blkcg_gq', 'blkcg_node')
            pd = blkg.pd[prog['blkcg_policy_iolatency'].plid]
            if pd.value_() == 0:
                continue
            iolat = container_of(pd, 'struct iolatency_grp', 'pd')
            inflight = iolat.rq_wait.inflight.counter.value_()
            if inflight:
                print(f'inflight={inflight} {disk_name(blkg.q.disk).decode("utf-8")} '
                      f'{cgroup_path(css.cgroup).decode("utf-8")}')
    time.sleep(1)

The monitoring output looks like the following:

  inflight=1 sda /user.slice
  inflight=1 sda /user.slice
  ...
  inflight=14 sda /user.slice
  inflight=13 sda /user.slice
  inflight=17 sda /user.slice
  inflight=15 sda /user.slice
  inflight=18 sda /user.slice
  inflight=17 sda /user.slice
  inflight=20 sda /user.slice
  inflight=19 sda /user.slice <- fio stopped, inflight stuck at 19
  inflight=19 sda /user.slice
  inflight=19 sda /user.slice

If a cgroup with stuck inflight ends up getting throttled, the throttled IOs
will never get issued as there's no completion event to wake it up leading
to an indefinite hang.

This patch fixes the bug by unifying enable handling into a work item which
is automatically kicked off from iolatency_set_min_lat_nsec() which is
called from both iolatency_set_limit() and iolatency_pd_offline() paths.
Punting to a work item is necessary as iolatency_pd_offline() is called
under spinlocks while freezing a request_queue requires a sleepable context.

This also simplifies the code reducing LOC sans the comments and avoids the
unnecessary freezes which were happening whenever a cgroup's latency target
is newly set or cleared.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Liu Bo <bo.liu@linux.alibaba.com>
Fixes: 8c772a9bfc7c ("blk-iolatency: fix IO hang due to negative inflight counter")
Cc: stable@vger.kernel.org # v5.0+
---
 block/blk-iolatency.c |  122 ++++++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 58 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2f33932e72e36..e8df72f4b244e 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -87,7 +87,17 @@ struct iolatency_grp;
 struct blk_iolatency {
 	struct rq_qos rqos;
 	struct timer_list timer;
-	atomic_t enabled;
+
+	/*
+	 * ->enabled is the master enable switch gating the throttling logic and
+	 * inflight tracking. The number of cgroups which have iolat enabled is
+	 * tracked in ->enable_cnt, and ->enable is flipped on/off accordingly
+	 * from ->enable_work with the request_queue frozen. For details, See
+	 * blkiolatency_enable_work_fn().
+	 */
+	bool enabled;
+	atomic_t enable_cnt;
+	struct work_struct enable_work;
 };
 
 static inline struct blk_iolatency *BLKIOLATENCY(struct rq_qos *rqos)
@@ -95,11 +105,6 @@ static inline struct blk_iolatency *BLKIOLATENCY(struct rq_qos *rqos)
 	return container_of(rqos, struct blk_iolatency, rqos);
 }
 
-static inline bool blk_iolatency_enabled(struct blk_iolatency *blkiolat)
-{
-	return atomic_read(&blkiolat->enabled) > 0;
-}
-
 struct child_latency_info {
 	spinlock_t lock;
 
@@ -464,7 +469,7 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 	struct blkcg_gq *blkg = bio->bi_blkg;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 
-	if (!blk_iolatency_enabled(blkiolat))
+	if (!blkiolat->enabled)
 		return;
 
 	while (blkg && blkg->parent) {
@@ -594,7 +599,6 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	u64 window_start;
 	u64 now;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
-	bool enabled = false;
 	int inflight = 0;
 
 	blkg = bio->bi_blkg;
@@ -605,8 +609,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!iolat)
 		return;
 
-	enabled = blk_iolatency_enabled(iolat->blkiolat);
-	if (!enabled)
+	if (!iolat->blkiolat->enabled)
 		return;
 
 	now = ktime_to_ns(ktime_get());
@@ -645,6 +648,7 @@ static void blkcg_iolatency_exit(struct rq_qos *rqos)
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
 
 	del_timer_sync(&blkiolat->timer);
+	flush_work(&blkiolat->enable_work);
 	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iolatency);
 	kfree(blkiolat);
 }
@@ -716,6 +720,44 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 	rcu_read_unlock();
 }
 
+/**
+ * blkiolatency_enable_work_fn - Enable or disable iolatency on the device
+ * @work: enable_work of the blk_iolatency of interest
+ *
+ * iolatency needs to keep track of the number of in-flight IOs per cgroup. This
+ * is relatively expensive as it involves walking up the hierarchy twice for
+ * every IO. Thus, if iolatency is not enabled in any cgroup for the device, we
+ * want to disable the in-flight tracking.
+ *
+ * We have to make sure that the counting is balanced - we don't want to leak
+ * the in-flight counts by disabling accounting in the completion path while IOs
+ * are in flight. This is achieved by ensuring that no IO is in flight by
+ * freezing the queue while flipping ->enabled. As this requires a sleepable
+ * context, ->enabled flipping is punted to this work function.
+ */
+static void blkiolatency_enable_work_fn(struct work_struct *work)
+{
+	struct blk_iolatency *blkiolat = container_of(work, struct blk_iolatency,
+						      enable_work);
+	bool enabled;
+
+	/*
+	 * There can only be one instance of this function running for @blkiolat
+	 * and it's guaranteed to be executed at least once after the latest
+	 * ->enabled_cnt modification. Acting on the latest ->enable_cnt is
+	 * sufficient.
+	 *
+	 * Also, we know @blkiolat is safe to access as ->enable_work is flushed
+	 * in blkcg_iolatency_exit().
+	 */
+	enabled = atomic_read(&blkiolat->enable_cnt);
+	if (enabled != blkiolat->enabled) {
+		blk_mq_freeze_queue(blkiolat->rqos.q);
+		blkiolat->enabled = enabled;
+		blk_mq_unfreeze_queue(blkiolat->rqos.q);
+	}
+}
+
 int blk_iolatency_init(struct request_queue *q)
 {
 	struct blk_iolatency *blkiolat;
@@ -741,17 +783,15 @@ int blk_iolatency_init(struct request_queue *q)
 	}
 
 	timer_setup(&blkiolat->timer, blkiolatency_timer_fn, 0);
+	INIT_WORK(&blkiolat->enable_work, blkiolatency_enable_work_fn);
 
 	return 0;
 }
 
-/*
- * return 1 for enabling iolatency, return -1 for disabling iolatency, otherwise
- * return 0.
- */
-static int iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
+static void iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
 {
 	struct iolatency_grp *iolat = blkg_to_lat(blkg);
+	struct blk_iolatency *blkiolat = iolat->blkiolat;
 	u64 oldval = iolat->min_lat_nsec;
 
 	iolat->min_lat_nsec = val;
@@ -759,13 +799,15 @@ static int iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
 	iolat->cur_win_nsec = min_t(u64, iolat->cur_win_nsec,
 				    BLKIOLATENCY_MAX_WIN_SIZE);
 
-	if (!oldval && val)
-		return 1;
+	if (!oldval && val) {
+		if (atomic_inc_return(&blkiolat->enable_cnt) == 1)
+			schedule_work(&blkiolat->enable_work);
+	}
 	if (oldval && !val) {
 		blkcg_clear_delay(blkg);
-		return -1;
+		if (atomic_dec_return(&blkiolat->enable_cnt) == 0)
+			schedule_work(&blkiolat->enable_work);
 	}
-	return 0;
 }
 
 static void iolatency_clear_scaling(struct blkcg_gq *blkg)
@@ -797,7 +839,6 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 	u64 lat_val = 0;
 	u64 oldval;
 	int ret;
-	int enable = 0;
 
 	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, buf, &ctx);
 	if (ret)
@@ -832,41 +873,12 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 	blkg = ctx.blkg;
 	oldval = iolat->min_lat_nsec;
 
-	enable = iolatency_set_min_lat_nsec(blkg, lat_val);
-	if (enable) {
-		if (!blk_get_queue(blkg->q)) {
-			ret = -ENODEV;
-			goto out;
-		}
-
-		blkg_get(blkg);
-	}
-
-	if (oldval != iolat->min_lat_nsec) {
+	iolatency_set_min_lat_nsec(blkg, lat_val);
+	if (oldval != iolat->min_lat_nsec)
 		iolatency_clear_scaling(blkg);
-	}
-
 	ret = 0;
 out:
 	blkg_conf_finish(&ctx);
-	if (ret == 0 && enable) {
-		struct iolatency_grp *tmp = blkg_to_lat(blkg);
-		struct blk_iolatency *blkiolat = tmp->blkiolat;
-
-		blk_mq_freeze_queue(blkg->q);
-
-		if (enable == 1)
-			atomic_inc(&blkiolat->enabled);
-		else if (enable == -1)
-			atomic_dec(&blkiolat->enabled);
-		else
-			WARN_ON_ONCE(1);
-
-		blk_mq_unfreeze_queue(blkg->q);
-
-		blkg_put(blkg);
-		blk_put_queue(blkg->q);
-	}
 	return ret ?: nbytes;
 }
 
@@ -1007,14 +1019,8 @@ static void iolatency_pd_offline(struct blkg_policy_data *pd)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
-	struct blk_iolatency *blkiolat = iolat->blkiolat;
-	int ret;
 
-	ret = iolatency_set_min_lat_nsec(blkg, 0);
-	if (ret == 1)
-		atomic_inc(&blkiolat->enabled);
-	if (ret == -1)
-		atomic_dec(&blkiolat->enabled);
+	iolatency_set_min_lat_nsec(blkg, 0);
 	iolatency_clear_scaling(blkg);
 }
 
