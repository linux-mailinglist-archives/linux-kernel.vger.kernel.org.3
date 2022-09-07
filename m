Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091F05B0C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIGSWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIGSWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:22:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF05BD4F4;
        Wed,  7 Sep 2022 11:22:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b16so20952377edd.4;
        Wed, 07 Sep 2022 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=K3hjbKL0hMAbah8CKdtedPF9UIzcJCX/EMcDWUheQ5I=;
        b=LAz9BOaySYNpXHzBk9oqVbRaFX1e7MKnOVwHFNkruqzPbjXygFPBfgDe7yPTMursGO
         INhClg/kk/s+hEJ942RFgvlxaYg+7Xlv4SwFN0cK8ClRnnAuYwh69LmxeuSSmGIPcl1T
         OfdQvu3mREMNhgs2L0do4jgcjrY31drBG6B0BjtsVBw2mjxu4x5TuEj5lTX5c3Cv+aWi
         HOSCERfO0a2y7c/jfxHrdMbbLzcLOiQPLiS5Hbau5gjEyJnORgvvz1u8pbCgnXMSBt/k
         NMc9rhY6tsfIiQsBemjiEJPa6jjI+I7WY3IVT10otXxNeefNkLhWIB4ETnHI20qaLx15
         lBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=K3hjbKL0hMAbah8CKdtedPF9UIzcJCX/EMcDWUheQ5I=;
        b=MM/LcT8C9pgJD0CynTv1QYTxdaMkdnY6m1N/xa2nuasBbso1NNmc6ZzLbVBXZEuA+/
         pqdMumn7V0gqnSZri+1SPK2cAaCzW7x0uZT7qu86gg7oGtC+f0dDamANa++T6jgSuR48
         KldvKdX//tG+OSSc76hCceP5FjpneM+dPMS8qpB8kFZQC+1t4iaRnw+ciZY1XNiifajY
         l3tsL48Ku7nROhnSA29WcUTTQpJkC/spbYtrHPwQX4Wwh3GfxkrtFLd5Kd7R3Gw7lZyQ
         3585pIOvL/+dKO5Dk4SwXzUM8na2Jo9lkKNOrq5AJS/ddsCCuyL2mKFeCF8McPsZSfud
         xJuw==
X-Gm-Message-State: ACgBeo0s8glgk3ULMJSNhioRfSpdYgrhaYI2sDbmnc52mKWFbJuwIG5z
        cl881sSLWz3Tau/lXhk72Dvsv5F7c2j6tg==
X-Google-Smtp-Source: AA6agR6591Mj5dj4XAhb+eyUBu4A0Z6wwaIe5T42HHmuu/nopYFP/wfE3W7Yu0IC5pu1zXBiQI/HMQ==
X-Received: by 2002:a05:6402:11d1:b0:43e:33b:93fa with SMTP id j17-20020a05640211d100b0043e033b93famr4220558edw.419.1662574924136;
        Wed, 07 Sep 2022 11:22:04 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090653c900b0074a82932e3bsm70496ejo.77.2022.09.07.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:22:03 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RESEND] sbitmap: Use atomic_{,long}_try_cmpxchg in sbitmap.c
Date:   Wed,  7 Sep 2022 20:21:44 +0200
Message-Id: <20220907182144.3245-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Use atomic_long_try_cmpxchg instead of
atomic_long_cmpxchg (*ptr, old, new) == old in __sbitmap_queue_get_batch
and atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
in __sbq_wake_up. x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

Also, atomic_long_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications, e.g.
an extra memory read can be avoided in the loop.

No functional change intended.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 lib/sbitmap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 29eb0484215a..32392e65b98f 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -534,16 +534,16 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		if (nr + nr_tags <= map_depth) {
 			atomic_long_t *ptr = (atomic_long_t *) &map->word;
 			int map_tags = min_t(int, nr_tags, map_depth);
-			unsigned long val, ret;
+			unsigned long val;
 
 			get_mask = ((1UL << map_tags) - 1) << nr;
+			val = READ_ONCE(map->word);
 			do {
-				val = READ_ONCE(map->word);
 				if ((val & ~get_mask) != val)
 					goto next;
-				ret = atomic_long_cmpxchg(ptr, val, get_mask | val);
-			} while (ret != val);
-			get_mask = (get_mask & ~ret) >> nr;
+			} while (!atomic_long_try_cmpxchg(ptr, &val,
+							  get_mask | val));
+			get_mask = (get_mask & ~val) >> nr;
 			if (get_mask) {
 				*offset = nr + (index << sb->shift);
 				update_alloc_hint_after_get(sb, depth, hint,
@@ -612,8 +612,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 
 	wait_cnt = atomic_dec_return(&ws->wait_cnt);
 	if (wait_cnt <= 0) {
-		int ret;
-
 		wake_batch = READ_ONCE(sbq->wake_batch);
 
 		/*
@@ -628,8 +626,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 		 * atomic_cmpxhcg() race should call this function again
 		 * to wakeup a new batch on a different 'ws'.
 		 */
-		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
-		if (ret == wait_cnt) {
+		if (atomic_try_cmpxchg(&ws->wait_cnt, &wait_cnt, wake_batch)) {
 			sbq_index_atomic_inc(&sbq->wake_index);
 			wake_up_nr(&ws->wait, wake_batch);
 			return false;
-- 
2.37.2

