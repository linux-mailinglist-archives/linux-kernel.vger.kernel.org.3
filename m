Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C36557F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiFWPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFWPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:54:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F22E9CA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:54:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q15so11280159wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b6TeUlcCs6MuTTByuNY1DhHnN3DzVLpNcbuJntwSQ4w=;
        b=KkSim4Xk+vmdbg0nopY18B4Nh/FRfqjeb82oHWGUHtQxhiYycvqB7YiQPoTxWvEXY+
         QDKe5D8+QIWBHwEWs405efVJVAWExLeV6iB+IsaELQhvV5DZl80mUoDDfd6gFlfAjVXB
         693ru+Su1EgsrqVYUE9qm/3l8CP7bZXpwyE64HPCwU1ApdLFdQFFHrF02oge0Jo17eTg
         xhbsKYpuknJfleXUI8OaxWQOtzPVO/fxMb5dla11/mD55GAq3K6jg07iGYRX2R3sMTkb
         +9M6Wvd7pdJHKCdVnt4YWAWN7iki08Dtmo+2L4F86xJOmnDUEuMY1QXIkcr6+8DUMr1F
         QsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6TeUlcCs6MuTTByuNY1DhHnN3DzVLpNcbuJntwSQ4w=;
        b=zfLvBtKKJns5Pagd4fxNF++/8tp+bT5TkUHvwmsxnt9J5EX+VnwCUE89KPJn4uDMES
         ARolbAUP44SJ6FpQCamjG3VCYWRA6PwnN33VDYxnzMd/BuWx8dL/u3Dm4JZSnyfdPo/M
         BoFMSLTdFy3iP29b1DkHWAm3NF2n7ysaWAguqmjA6qGF42YfCj5XyRMSsNXZv0h61hQD
         +BDA7hWaE2x8aclm1YmG9JJq2lK9yeNIn7+DBCY2CArZX9sIqCa/+NmQmlegRp2dH47W
         d1Is0fTlWrbk9ikWWBPYJnHcuxk41tO43McTv+6td+uVjRNL4w98RG5NWjFH/2kOLlGF
         mrDw==
X-Gm-Message-State: AJIora/QEJ6wwnh8emk3Bw0DAhdrHBMao7Cq3JPtGQkIPTwiswYrWcOl
        2z24Ba7l7YNPc7QHVvvNtBnPww==
X-Google-Smtp-Source: AGRyM1s0TVHALXKxcEBwaa0UpHjyTBAwVkxC6eZYVqMxirN9A83B5naVywT0RSzorILmoeGLiMOzqw==
X-Received: by 2002:a7b:c012:0:b0:39c:529a:7590 with SMTP id c18-20020a7bc012000000b0039c529a7590mr5080933wmb.6.1655999639565;
        Thu, 23 Jun 2022 08:53:59 -0700 (PDT)
Received: from OPPO-A74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm20650830wrr.3.2022.06.23.08.53.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:53:59 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 5/8] block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
Date:   Thu, 23 Jun 2022 17:53:32 +0200
Message-Id: <20220623155335.6147-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220623155335.6147-1-paolo.valente@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit, for the commit that will use independent
access ranges. The latter retrieves the number of ranges, that is the
number of actuators. That number is assumed to be equal at most to
a constant BFQ_MAX_ACTUATORS. Such a constant is defined in this
preparatory icommit. In particular, this commit uses BFQ_MAX_ACTUATORS
in place of the placeholder BFQ_NUM_ACTUATORS, which was introduced in
a previous commit.

The actual commit that uses independet access ranges will then
replace BFQ_MAX_ACTUATORS with the actual number of actuators, where
appropriate.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c |  8 ++++----
 block/bfq-iosched.h | 48 ++++++++++++++++++++++-----------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 6462e8de44db..c5866f57b3aa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -764,7 +764,7 @@ static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 	struct bfq_entity *entity;
 	unsigned int act_idx;
 
-	for (act_idx = 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
 		struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0, act_idx);
 		struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1, act_idx);
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index acc2282cf196..99c305df6cce 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -689,7 +689,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 		limit = (limit * depth) >> bfqd->full_depth_shift;
 	}
 
-	for (act_idx = 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
 		struct bfq_queue *bfqq =
 			bic ? bic_to_bfqq(bic, op_is_sync(op), act_idx) : NULL;
 
@@ -2673,7 +2673,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				if (bfqg->async_bfqq[i][j][k])
@@ -5432,7 +5432,7 @@ static void bfq_exit_icq(struct io_cq *icq)
 	if (bfqd)
 		spin_lock_irqsave(&bfqd->lock, flags);
 
-	for (act_idx = 0; act_idx < BFQ_NUM_ACTUATORS; act_idx++) {
+	for (act_idx = 0; act_idx < BFQ_MAX_ACTUATORS; act_idx++) {
 		if (bic->stable_merge_bfqq[act_idx])
 			bfq_put_stable_ref(bic->stable_merge_bfqq[act_idx]);
 
@@ -7003,7 +7003,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
 	int i, j, k;
 
-	for (k = 0; k < BFQ_NUM_ACTUATORS; k++) {
+	for (k = 0; k < BFQ_MAX_ACTUATORS; k++) {
 		for (i = 0; i < 2; i++)
 			for (j = 0; j < IOPRIO_NR_LEVELS; j++)
 				__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j][k]);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 8862c12e8031..2687e9a85a41 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -33,7 +33,7 @@
  */
 #define BFQ_SOFTRT_WEIGHT_FACTOR	100
 
-#define BFQ_NUM_ACTUATORS 2
+#define BFQ_MAX_ACTUATORS 32
 
 struct bfq_entity;
 
@@ -424,7 +424,7 @@ struct bfq_io_cq {
 	 * is async or sync. So there is a distinct queue for each
 	 * actuator.
 	 */
-	struct bfq_queue *bfqq[2][BFQ_NUM_ACTUATORS];
+	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
 	/* per (request_queue, blkcg) ioprio */
 	int ioprio;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
@@ -442,26 +442,26 @@ struct bfq_io_cq {
 	 * to remember their values while a queue is merged, so as to
 	 * be able to restore them in case of split.
 	 */
-	bool saved_has_short_ttime[BFQ_NUM_ACTUATORS];
+	bool saved_has_short_ttime[BFQ_MAX_ACTUATORS];
 	/*
 	 * Same purpose as the previous two fields for the I/O bound
 	 * classification of a queue.
 	 */
-	bool saved_IO_bound[BFQ_NUM_ACTUATORS];
+	bool saved_IO_bound[BFQ_MAX_ACTUATORS];
 
-	u64 saved_io_start_time[BFQ_NUM_ACTUATORS];
-	u64 saved_tot_idle_time[BFQ_NUM_ACTUATORS];
+	u64 saved_io_start_time[BFQ_MAX_ACTUATORS];
+	u64 saved_tot_idle_time[BFQ_MAX_ACTUATORS];
 
 	/*
 	 * Same purpose as the previous fields for the values of the
 	 * field keeping the queue's belonging to a large burst
 	 */
-	bool saved_in_large_burst[BFQ_NUM_ACTUATORS];
+	bool saved_in_large_burst[BFQ_MAX_ACTUATORS];
 	/*
 	 * True if the queue belonged to a burst list before its merge
 	 * with another cooperating queue.
 	 */
-	bool was_in_burst_list[BFQ_NUM_ACTUATORS];
+	bool was_in_burst_list[BFQ_MAX_ACTUATORS];
 
 	/*
 	 * Save the weight when a merge occurs, to be able
@@ -470,27 +470,27 @@ struct bfq_io_cq {
 	 * then the weight of the recycled queue could differ
 	 * from the weight of the original queue.
 	 */
-	unsigned int saved_weight[BFQ_NUM_ACTUATORS];
+	unsigned int saved_weight[BFQ_MAX_ACTUATORS];
 
 	/*
 	 * Similar to previous fields: save wr information.
 	 */
-	unsigned long saved_wr_coeff[BFQ_NUM_ACTUATORS];
-	unsigned long saved_last_wr_start_finish[BFQ_NUM_ACTUATORS];
-	unsigned long saved_service_from_wr[BFQ_NUM_ACTUATORS];
-	unsigned long saved_wr_start_at_switch_to_srt[BFQ_NUM_ACTUATORS];
-	unsigned int saved_wr_cur_max_time[BFQ_NUM_ACTUATORS];
-	struct bfq_ttime saved_ttime[BFQ_NUM_ACTUATORS];
+	unsigned long saved_wr_coeff[BFQ_MAX_ACTUATORS];
+	unsigned long saved_last_wr_start_finish[BFQ_MAX_ACTUATORS];
+	unsigned long saved_service_from_wr[BFQ_MAX_ACTUATORS];
+	unsigned long saved_wr_start_at_switch_to_srt[BFQ_MAX_ACTUATORS];
+	unsigned int saved_wr_cur_max_time[BFQ_MAX_ACTUATORS];
+	struct bfq_ttime saved_ttime[BFQ_MAX_ACTUATORS];
 
 	/* Save also injection state */
-	u64 saved_last_serv_time_ns[BFQ_NUM_ACTUATORS];
-	unsigned int saved_inject_limit[BFQ_NUM_ACTUATORS];
-	unsigned long saved_decrease_time_jif[BFQ_NUM_ACTUATORS];
+	u64 saved_last_serv_time_ns[BFQ_MAX_ACTUATORS];
+	unsigned int saved_inject_limit[BFQ_MAX_ACTUATORS];
+	unsigned long saved_decrease_time_jif[BFQ_MAX_ACTUATORS];
 
 	/* candidate queue for a stable merge (due to close creation time) */
-	struct bfq_queue *stable_merge_bfqq[BFQ_NUM_ACTUATORS];
+	struct bfq_queue *stable_merge_bfqq[BFQ_MAX_ACTUATORS];
 
-	bool stably_merged[BFQ_NUM_ACTUATORS];	/* non splittable if true */
+	bool stably_merged[BFQ_MAX_ACTUATORS];	/* non splittable if true */
 
 	unsigned int requests;	/* Number of requests this process has in flight */
 };
@@ -961,8 +961,8 @@ struct bfq_group {
 
 	void *bfqd;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
-	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct bfq_entity *my_entity;
 
@@ -978,8 +978,8 @@ struct bfq_group {
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
-	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_NUM_ACTUATORS];
-	struct bfq_queue *async_idle_bfqq[BFQ_NUM_ACTUATORS];
+	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS][BFQ_MAX_ACTUATORS];
+	struct bfq_queue *async_idle_bfqq[BFQ_MAX_ACTUATORS];
 
 	struct rb_root rq_pos_tree;
 };
-- 
2.20.1

