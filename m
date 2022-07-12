Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4167D571FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiGLPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGLPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:45:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDA9C08E1;
        Tue, 12 Jul 2022 08:45:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e15so10646686edj.2;
        Tue, 12 Jul 2022 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/Odg1sihGKTXAswGd97F0WSR+SxhfCI4ZHjZFl5WTI=;
        b=GKkMtyNwA3AUceejasIeFoYEtVaVn4xX+Jgy6JJ/Bhmo2niK5wru/fENw4PzA9yYzh
         CZMGK7FoeuHA8qcUzYJPrSwcC7xxkCl1TGNMWi5P+FsIGqL8Ch0P7A+520GpKp76/P1N
         N6+Nt1l4fAv4H2BnlHz6hk+9KWrclKV2WjtaiRKWX+OQnuhCv2lkpTD3+oN2Br3h69pd
         SoKeZOsnDm/ZYLFSk5VTHckCpQdO39EaNcon6/mnwNnKhuPNJo6zGS36skoFxxg2v6Em
         /NoKv2YmhPuusaLfjWOUe0CQFnB6Rgej9AaZsG1l8UiWGZph0hnRXLiKWnqhBM6fSU5S
         rceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/Odg1sihGKTXAswGd97F0WSR+SxhfCI4ZHjZFl5WTI=;
        b=EtMzDNPpLx/SrSPowhMOVbFt1ICwAmMB/C8ASmOgb+KDl/qygFbjVKHvZBsTIfRGxa
         6+1zNW+R9CkccnzT9VMFBJVOAIoZOyJ7v0Gahv5Vby3+MIKX5a6uQqkEg/6MaD0t3ddh
         ioQw59EraXONpkH6YX8OxIpFQ3/vD9WteJyxhznBxGnCblhRSA7LDytDJLMsIIyAQ7e3
         sS/QA8angKSP/LXnsnQoggG+Q2qiJuv8Uc/p0DIEdDzZckUSDsC9uZCJh7Xu6Ex6RrqK
         PIbyDXpbo/NlEcCw8yjIfM7Fg4RX4eT3zOVaMBQ8/kG/yrt3i5OiDQLWY2mZzkNHlj87
         A3vw==
X-Gm-Message-State: AJIora9dpVGddW3SQga3SojDmsMV3QOIwko/uMZB9Zv8/Es5EAlz44bz
        opDQzjw7T86yBKa207s0mR9PWayoD5M=
X-Google-Smtp-Source: AGRyM1vzDIYYarVp9yz7WWwp1ttRsZeXo5LffHnmyAaDmqakNd+eO/CH3VinTckAj75EYKUX4Yizmg==
X-Received: by 2002:a05:6402:643:b0:43a:77a6:acd with SMTP id u3-20020a056402064300b0043a77a60acdmr33077527edx.173.1657640706079;
        Tue, 12 Jul 2022 08:45:06 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id f10-20020a1709064dca00b006fef557bb7asm3932125ejw.80.2022.07.12.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:45:05 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] blk-cgroup: Use atomic{,64}_try_cmpxchg
Date:   Tue, 12 Jul 2022 17:44:55 +0200
Message-Id: <20220712154455.66868-1-ubizjak@gmail.com>
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

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
in blkcg_unuse_delay, blkcg_set_delay and blkcg_clear_delay and
atomic64_try_cmpxchg in blkcg_scale_delay.  x86 CMPXCHG instruction
returns success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg).

Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails, enabling further code simplifications.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
v2: Split patch from the original big patch
    Use while instead of do-while loop
---
 block/blk-cgroup.c |  2 +-
 block/blk-cgroup.h | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

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
index d4de0a35e066..d2724d1dd7c9 100644
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
+	while (old && !atomic_try_cmpxchg(&blkg->use_delay, &old, old - 1))
+		;
 
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
 
-- 
2.35.3

