Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313F571EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiGLPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiGLPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:21:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34FC326D2;
        Tue, 12 Jul 2022 08:20:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sz17so14898914ejc.9;
        Tue, 12 Jul 2022 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqOmwRuXYXSLwqGNBlZZoo02pse57Zj1+1zzVfadMm4=;
        b=SxyAi9cJkpORxth8EJQCz/EuRVjPwj8CxgHaZom3oR/sgVf5/38dY++qp4PgvGHRVp
         asgtqvUkwxUsyz1Qf2bd8ueA4jEE80aM72WS9nluN95M4YVpTv88qd84H5hVMTZ43Hxb
         KCxuhGfM0iXaEwdUzzzpVRLtxzs7QaB00fW5/gQHHLBmnBEtGcAtiWbsJyZVrzZujJaY
         tzqJNylf31l0zqUhrumak5kZPwh0/tr+wqSS+XfmJvQNnR5G/9A0xyC/e+I+pvsikrly
         oCoEZkfwNF/fHTsACGBTT1oNiCDPjuaf335viE3rfM9TPjWcXvJuQAXeeYXMIuzv3BaM
         esKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqOmwRuXYXSLwqGNBlZZoo02pse57Zj1+1zzVfadMm4=;
        b=JR11L9nsQRpAG7QvaTIndJ3ve4UOjFVat7CHJcwIHvlNnUjraleaegROtN0LrTLiXy
         f/JXDEOyph7DdTacRJDl696w/k7siL1hIG6aPzcFUdbDbYeLSkJTx4jn9vOkiEyX1MuN
         1kM1KH4/mJ0TPzylpIkiCAapZdkQRliKnt7Uh4tNSeeQg+0FtT3hH/Vs4xnKT8kIaaXy
         dgsK/n/uBU6wF+SxenLK+NIkCDH9dSW76jjbVxa04grR19ACPXKiZNeNNY/y7GglOe/2
         wpMi6mOX8fsIefDx5TAMsfaXMCrRqY8w4aTHt0K6vOaDQ6xAIgTkwIWFRsx+IDI+EOGh
         +ldA==
X-Gm-Message-State: AJIora8sjtKTtvQshk/KcmUG/dDhpBZ6Ym3HE4W7qkV0vkovfwUr9n3M
        0A5fEocIncRNi5sCgcVI+ZVGTHp086A=
X-Google-Smtp-Source: AGRyM1vOwbtLoAvZNLQrepbTZ7rQvqweYLxdCv7MBf4QAsFEzBvhW4O/P3b0mQgH+BLEAs8j7coBXg==
X-Received: by 2002:a17:906:8448:b0:72b:5659:9873 with SMTP id e8-20020a170906844800b0072b56599873mr10647830ejy.117.1657639201143;
        Tue, 12 Jul 2022 08:20:01 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b00722e50e259asm3868006ejo.102.2022.07.12.08.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:20:00 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] blk-iolatency: Use atomic{,64}_try_cmpxchg
Date:   Tue, 12 Jul 2022 17:19:47 +0200
Message-Id: <20220712151947.6783-1-ubizjak@gmail.com>
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
in check_scale_change and atomic64_try_cmpxchg in blkcg_iolatency_done_bio.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after cmpxchg (and related move instruction in front of cmpxchg).

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
v2: Split patch from the original big patch
---
 block/blk-iolatency.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

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
-- 
2.35.3

