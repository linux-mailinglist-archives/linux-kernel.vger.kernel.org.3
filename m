Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467D95B21BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiIHPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiIHPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:12:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24210F3BC2;
        Thu,  8 Sep 2022 08:12:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bz13so23209255wrb.2;
        Thu, 08 Sep 2022 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Jp4krbitKaSk3RuEG4IHxarQ8BEhF9SZnO8KJfaZOzQ=;
        b=Tpk0PF1q6SYjUGrK3EigOTmQTwHqAb4d90j75ihUrn7+vgUOMF9frOB81lz7pFmYOG
         r+jFHHtndpaU+goPAGL25OEry8EejHkuck675GabFSu5pMIP0nS3xQvZdKF0eAZm5Z3P
         Wykiv7muRW5qszhWZfuoZo63RALITzi0v7tcJmezwhHUF4TqWjYC4kvnA1QtQXTLIr4m
         GCfzuIY2G8Y4chiyZ76kpHKUkWCrWuI8+b0JH88Fho+xeEdgCGKaClDYytyME88JvZzG
         uOQrnY3LxXThBSokwjVH8rSjmdahy0HoxdR14LBeGPGLYk/Jp9yAufJ3ce2xb3+O63v7
         ZoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Jp4krbitKaSk3RuEG4IHxarQ8BEhF9SZnO8KJfaZOzQ=;
        b=Htl803p4VWzd9vol7iEioUzE6XTG4lb5aJ9orU03Wf/vLH7YAuE37DYUmD/QgRGj3J
         WEdPjVySoHQkIv+EdaYS43je/tSBtQLyz4z3TXPagxDGXV4dGnnrf+pD4wwjW7vGorfQ
         o74XO2G+814W9sIxj/9bsV+pz07vyjyK+8XGPo0WfLpuHdcOsSdPOvSkXxQYtrjYBtVJ
         QATT6BloCUhIfbvR7ihfyVqkejWaVXb9sxrrftLVVzVq7V3AAkcgKIweD3SroWoHN3ZK
         HmSCmO+0yFms7pwReD2w0Swhe88OZ+KewnOVd8+92TfF2YB800Pmon8xkALUC6Siwbr5
         XtpQ==
X-Gm-Message-State: ACgBeo1Uq+AlqPA3Zw7SvGR6BQpAQHtDSFa+PEV9z2B2+yj4AxAoCwIv
        Crx1RQbJKyeD5yjwv4pcNYePAXwSCR9X6Q==
X-Google-Smtp-Source: AA6agR6lXVUYvGPiufbzf6DzUFL4TM9V23eLsPTLwoHkX3OEB32hrswGY0TLrfGg2/7vkjTqckEvXA==
X-Received: by 2002:a5d:650e:0:b0:228:b09e:de9a with SMTP id x14-20020a5d650e000000b00228b09ede9amr5724814wru.360.1662649929253;
        Thu, 08 Sep 2022 08:12:09 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id v37-20020a05600c4da500b003b32b07f8f5sm2027460wmp.11.2022.09.08.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:12:08 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RESEND v2] sbitmap: Use atomic_long_try_cmpxchg in __sbitmap_queue_get_batch
Date:   Thu,  8 Sep 2022 17:12:00 +0200
Message-Id: <20220908151200.9993-1-ubizjak@gmail.com>
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
atomic_long_cmpxchg (*ptr, old, new) == old in __sbitmap_queue_get_batch.
x86 CMPXCHG instruction returns success in ZF flag, so this change
saves a compare after cmpxchg (and related move instruction in front
of cmpxchg).

Also, atomic_long_cmpxchg implicitly assigns old *ptr value to "old"
when cmpxchg fails, enabling further code simplifications, e.g.
an extra memory read can be avoided in the loop.

No functional change intended.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Resend against linux-block for-6.1/block.
---
 lib/sbitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index a39b1a877366..299765a027bf 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -533,16 +533,16 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 		nr = find_first_zero_bit(&map->word, map_depth);
 		if (nr + nr_tags <= map_depth) {
 			atomic_long_t *ptr = (atomic_long_t *) &map->word;
-			unsigned long val, ret;
+			unsigned long val;
 
 			get_mask = ((1UL << nr_tags) - 1) << nr;
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
-- 
2.37.2

