Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B759E96E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiHWR1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbiHWRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:25:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7287D7B7;
        Tue, 23 Aug 2022 08:04:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r16so17346902wrm.6;
        Tue, 23 Aug 2022 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=UWD/zYOImijIaCRJjQ6Qdr+9a5CKuV8fnJ1O7aG/PXw=;
        b=dPG+yykmRC3fUMbUTYUtwPC8aaaIFXjBLd9EYlvJVTgwqkRac5HyYMpunGbqnj53tE
         26KhntFBaodTiOj4py+G3Tz+h1kFdWKbYP5vEU9iRY6PX/2yNgdPLq+ftcHST8F2WxdQ
         fSezYvRysrN2CyOqUes7OC6qMr/fWJalQGpolw0S3rRWFdWu77Rh7uBu3KG0AAL0ntdd
         VK8jo5doaPdtQ6wOiY8/tQpT2H5JrDhbx0ztqGYb4VnKxAzeUT/pNWT9OBb+cx3nFuYV
         S9HiAr1OU4T4r1fRvyE7MXY4KgV7UMVe/kq5t6O8pdNiAn52Hc+g6SFDe/Ljm6yulib+
         GwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UWD/zYOImijIaCRJjQ6Qdr+9a5CKuV8fnJ1O7aG/PXw=;
        b=Tcz7Q7Oggxq6KnvV6Ffzpb9HoIS8Q2gOwO/8LJ9uULCFte5sMWkB8A+eVj7wrRHEos
         iOZz3flL5ROwJDptp27jm3a/QSgYf+0me4yvC+fk/SxGG3g/I1cJ8quvobbGN2f8igoy
         8ArYf+Oids0b7ti9muaMwfJ+L4DrnzwYRsSyP76JlKuVIhZgPkKpKnauP2MN0tMWhb4M
         u1IzdEzG+O8AfPNdAKk3UtHzdeBsIGfHh8iUyyYVKygDic0CC2K6aV/XNMrF8Y3cB3HF
         AnCRSjLZ8QpcW/HNQtPD6KeJyiyXOpwSz2NI448Abtay0U6zlqz5Vwyzv28KHWLm7BJN
         jHtg==
X-Gm-Message-State: ACgBeo2EI0GIZm1oQTJTIpT7yO2UPujDYjdYBRfUbHM/pCqPE35CrXf9
        LUjXyYWpVxobKHbYBg6hPNC5ridxsIEcyg==
X-Google-Smtp-Source: AA6agR7/AJKDJ3fmGGjB2rFV9CtiSShlIbldfYUUc9bkFO95ho+PLDHlcvH1bMCehtEzHkEogVbHVg==
X-Received: by 2002:a5d:5010:0:b0:225:611c:55fc with SMTP id e16-20020a5d5010000000b00225611c55fcmr4283164wrt.553.1661267041437;
        Tue, 23 Aug 2022 08:04:01 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id bn26-20020a056000061a00b0021d7b41255esm14907690wrb.98.2022.08.23.08.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:04:01 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] sbitmap: Use atomic_{,long}_try_cmpxchg in sbitmap.c
Date:   Tue, 23 Aug 2022 17:03:52 +0200
Message-Id: <20220823150352.3455-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
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
when cmpxchg fails, enabling further code simplifications.

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
2.37.1

