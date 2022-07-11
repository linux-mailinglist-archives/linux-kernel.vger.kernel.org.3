Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4357D570725
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiGKPdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:33:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D7D2E9D9;
        Mon, 11 Jul 2022 08:33:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e15so6742283edj.2;
        Mon, 11 Jul 2022 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=snMnr+6CZOdexUxXxsN7jIUjz0zw5XMoOW5FYANjG28=;
        b=ju3dmdX7QUMCLGkAk+wVtXEDDqeDkMYlj1QWPHlv3jnPLz7MgIkZXa7fAf53rYaiw5
         hpTEoVUtSLnrpQ7fZt22jJBF1LnA/aNSolEkDBxX86341Xf3Id2NYRycqUyIc0X8uiOQ
         HCKKhrACyXol2PLsxcnyaMjuciqXubIrXmotTMevs8m3XMWPy1FPjQoS6DL2YslIp3IO
         4uNOFaOwmv54nz/UszyaHu+i5I4fFH/lmm4vU9kl9SJnPzKPS4J63M8sz0hzrzBPZciq
         W7OVvoHEBD+EtR9kp7O8rcBstdilXYYpaHq48ZmBjawNZj5uSibFTXfCFhMilbOSHA/F
         ZGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=snMnr+6CZOdexUxXxsN7jIUjz0zw5XMoOW5FYANjG28=;
        b=7X8uBxPvud81GfERfxRI1SaFcAHlZjRC1FwkZSLCc7Ks0MSB31WawV+0rY4M1Og0cC
         t2Zjrr1/15xOtNk9QQA50YUFs1qVXySe6FsL/F6fimE9KrNdEQG9mxCRsIusbr/LnyH2
         LLHJxAONdwVxyuB7664WJeem25pYmjVQNJj7FjXblEnCTO+Zmg2OuPeu5HBe0wEs35Ws
         1BpZqe8EJRH8r+UGVZ+rEF1GVpf3EQ/18gyGWOKSomuU7uZLxe3mjrdx97P4r2Hed2F4
         A/MSoBiiVWeOVclO6NLAzdPm89mGKLfdG9YcM9jIVpgW4yt7mU3E/3agnWzkMOCAPO01
         2TXQ==
X-Gm-Message-State: AJIora+2oM6jWXb5wqT1XEhrVjKaDMKLMwfxSPjGx1Q/DnRHGFZJSQD7
        G6hYOzlqKFhtNogjXZKtKIylpm11bCw=
X-Google-Smtp-Source: AGRyM1tggroO5y838xt0S9QPpiOiCspNsrLzADDA6iBSDLYeEuq7j9kSQtWRXpKi7DgxJtiZsvJLMA==
X-Received: by 2002:a05:6402:34d6:b0:43a:a021:929 with SMTP id w22-20020a05640234d600b0043aa0210929mr26549013edc.268.1657553589785;
        Mon, 11 Jul 2022 08:33:09 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id kx23-20020a170907775700b0072af12590fesm2737201ejc.207.2022.07.11.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 08:33:09 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Use try_cmpxchg some more
Date:   Mon, 11 Jul 2022 17:33:01 +0200
Message-Id: <20220711153301.2388-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use try_cmpxchg family of functions instead of cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c    |  2 +-
 block/blk-cgroup.h    | 12 ++++--------
 block/blk-core.c      |  2 +-
 block/blk-iolatency.c | 12 +++++-------
 block/blk-rq-qos.c    | 10 ++--------
 5 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 764e740b0c0f..ca99260348ff 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1696,7 +1696,7 @@ static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
 	 * everybody is happy with their IO latencies.
 	 */
 	if (time_before64(old + NSEC_PER_SEC, now) &&
-	    atomic64_cmpxchg(&blkg->delay_start, old, now) == old) {
+	    atomic64_try_cmpxchg(&blkg->delay_start, &old, now)) {
 		u64 cur = atomic64_read(&blkg->delay_nsec);
 		u64 sub = min_t(u64, blkg->last_delay, now - old);
 		int cur_use = atomic_read(&blkg->use_delay);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d4de0a35e066..0fc5009be5f9 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -430,12 +430,8 @@ static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
 	 * then check to see if we were the last delay so we can drop the
 	 * congestion count on the cgroup.
 	 */
-	while (old) {
-		int cur = atomic_cmpxchg(&blkg->use_delay, old, old - 1);
-		if (cur == old)
-			break;
-		old = cur;
-	}
+	do {
+	} while (old && !atomic_try_cmpxchg(&blkg->use_delay, &old, old - 1));
 
 	if (old == 0)
 		return 0;
@@ -458,7 +454,7 @@ static inline void blkcg_set_delay(struct blkcg_gq *blkg, u64 delay)
 	int old = atomic_read(&blkg->use_delay);
 
 	/* We only want 1 person setting the congestion count for this blkg. */
-	if (!old && atomic_cmpxchg(&blkg->use_delay, old, -1) == old)
+	if (!old && atomic_try_cmpxchg(&blkg->use_delay, &old, -1))
 		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
 
 	atomic64_set(&blkg->delay_nsec, delay);
@@ -475,7 +471,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 	int old = atomic_read(&blkg->use_delay);
 
 	/* We only want 1 person clearing the congestion count for this blkg. */
-	if (old && atomic_cmpxchg(&blkg->use_delay, old, 0) == old)
+	if (old && atomic_try_cmpxchg(&blkg->use_delay, &old, 0))
 		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
 }
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 27fb1357ad4b..628b965356db 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -987,7 +987,7 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 again:
 	stamp = READ_ONCE(part->bd_stamp);
 	if (unlikely(time_after(now, stamp))) {
-		if (likely(cmpxchg(&part->bd_stamp, stamp, now) == stamp))
+		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
 	if (part->bd_partno) {
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 9568bf8dfe82..79745c6d8e15 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -401,7 +401,6 @@ static void check_scale_change(struct iolatency_grp *iolat)
 	unsigned int cur_cookie;
 	unsigned int our_cookie = atomic_read(&iolat->scale_cookie);
 	u64 scale_lat;
-	unsigned int old;
 	int direction = 0;
 
 	if (lat_to_blkg(iolat)->parent == NULL)
@@ -422,11 +421,10 @@ static void check_scale_change(struct iolatency_grp *iolat)
 	else
 		return;
 
-	old = atomic_cmpxchg(&iolat->scale_cookie, our_cookie, cur_cookie);
-
-	/* Somebody beat us to the punch, just bail. */
-	if (old != our_cookie)
+	if (!atomic_try_cmpxchg(&iolat->scale_cookie, &our_cookie, cur_cookie)) {
+		/* Somebody beat us to the punch, just bail. */
 		return;
+	}
 
 	if (direction < 0 && iolat->min_lat_nsec) {
 		u64 samples_thresh;
@@ -633,8 +631,8 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 			window_start = atomic64_read(&iolat->window_start);
 			if (now > window_start &&
 			    (now - window_start) >= iolat->cur_win_nsec) {
-				if (atomic64_cmpxchg(&iolat->window_start,
-					     window_start, now) == window_start)
+				if (atomic64_try_cmpxchg(&iolat->window_start,
+							 &window_start, now))
 					iolatency_check_latencies(iolat, now);
 			}
 		}
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index d3a75693adbf..88f0fe7dcf54 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -10,16 +10,10 @@ static bool atomic_inc_below(atomic_t *v, unsigned int below)
 {
 	unsigned int cur = atomic_read(v);
 
-	for (;;) {
-		unsigned int old;
-
+	do {
 		if (cur >= below)
 			return false;
-		old = atomic_cmpxchg(v, cur, cur + 1);
-		if (old == cur)
-			break;
-		cur = old;
-	}
+	} while (!atomic_try_cmpxchg(v, &cur, cur + 1));
 
 	return true;
 }
-- 
2.35.3

