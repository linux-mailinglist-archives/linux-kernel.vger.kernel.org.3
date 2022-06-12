Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE05479DB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiFLK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbiFLK7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 06:59:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9A101D7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 03:59:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y187so3179931pgd.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 03:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOvsSU9XTYiyPG05mkPxbcZK+WV8KoV3IqO1Kxkz2mQ=;
        b=S3ZlbUrRojojjIhHasyuA8Q7ueqx9964FuHucVt6WQ6gQGh+UKvKpDAvYnkaX4tBJ4
         1VjKNBYdx7iHsmu3IhV5u12mh4PITeDsIVzEfahlIBF2iGe+R3gEwChGEgcWR0VUZHfO
         EVZ8Rlb28+LTvFjHpQMlIloDJtOTwTGR525WK5gC+X1oQuNtWGGGCuScwDYo6k2p/BaY
         TiphGyY3Dq5kbEAfv8dYUlA81+/+JXrLoQiSJT1JixtX6VenU6fNpBkbjI1X314rvoeL
         INR+O5ozfQfVpUkO1dnUZlhiEd8VyfLHInwXzWCr7AybYvtKkq/EBd8wXp11C+JrJqK0
         PDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KOvsSU9XTYiyPG05mkPxbcZK+WV8KoV3IqO1Kxkz2mQ=;
        b=BBLQk3c6nNVfvLxeFjN4dq2QdIjYeIBGTJVyutaUSNPlp//eirewTu3Gor1ZrxaZbE
         +RADwpHt45+ibYuWTeYXiU8q5egfflE8jhU+IovvwnQW6FDy0Hy2gQdyMCwQpMcdA5z9
         Nr+Skz9yo5VT6nujvbqkFaYak7YVfHfiOOev7FctUBsMOaQj6ZGgEJMPNk3VvhNCPgHr
         GUoiJKZ9GOtqbkqlaoHBIWpwavQuFG4OliBUvCEBKLXwOrHKH2ViEE79NMAQgXYJBAE4
         7iSpVl8KedBtwyzp7QLQtPib/RaimTzriJMPTbCQA6uRkZFjj8yeqslaERHhmmpexEJW
         WJ0g==
X-Gm-Message-State: AOAM533+CO1KvR5OuinzbRlSJ0k0lmvPhm84k5Wvn/7GNVxI01GV+sN0
        6UhRPC7qcu6RqeMVFJYzibU=
X-Google-Smtp-Source: ABdhPJy3zhw6Y6fH1x62wnxGwYD6JRNynUl32ho21VM2s+6nnYE4swFb317ciK7XozkVIWdJnKUF/A==
X-Received: by 2002:a63:2a47:0:b0:3fe:2437:5d25 with SMTP id q68-20020a632a47000000b003fe24375d25mr22530054pgq.539.1655031582805;
        Sun, 12 Jun 2022 03:59:42 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709028ec200b001621ce92196sm2853401plo.86.2022.06.12.03.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 03:59:42 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     akpm@linux-foundation.org, alexs@kernel.org, sjhuang@iluvatar.ai,
        sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/genalloc: Set chunk size to real size which gen_pool managed.
Date:   Sun, 12 Jun 2022 18:59:37 +0800
Message-Id: <20220612105937.30862-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

The demand size (chunk->avail > size > round_down(chunk->avail)) will
lead to meaningless algo calls in gen_pool_alloc_algo_owner without the
patch, alse move the follow code:
	size = nbits << order
out of read-side critical section.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/genalloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 00fc50d0a640..1b1843613fb8 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -193,6 +193,7 @@ int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt, phys_addr_t ph
 	if (unlikely(chunk == NULL))
 		return -ENOMEM;
 
+	size = nbits << pool->min_alloc_order;
 	chunk->phys_addr = phys;
 	chunk->start_addr = virt;
 	chunk->end_addr = virt + size - 1;
@@ -293,6 +294,7 @@ unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t size,
 		return 0;
 
 	nbits = (size + (1UL << order) - 1) >> order;
+	size = nbits << order;
 	rcu_read_lock();
 	list_for_each_entry_rcu(chunk, &pool->chunks, next_chunk) {
 		if (size > atomic_long_read(&chunk->avail))
@@ -314,7 +316,6 @@ unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t size,
 		}
 
 		addr = chunk->start_addr + ((unsigned long)start_bit << order);
-		size = nbits << order;
 		atomic_long_sub(size, &chunk->avail);
 		if (owner)
 			*owner = chunk->owner;
@@ -499,6 +500,7 @@ void gen_pool_free_owner(struct gen_pool *pool, unsigned long addr, size_t size,
 		*owner = NULL;
 
 	nbits = (size + (1UL << order) - 1) >> order;
+	size = nbits << order;
 	rcu_read_lock();
 	list_for_each_entry_rcu(chunk, &pool->chunks, next_chunk) {
 		if (addr >= chunk->start_addr && addr <= chunk->end_addr) {
@@ -506,7 +508,6 @@ void gen_pool_free_owner(struct gen_pool *pool, unsigned long addr, size_t size,
 			start_bit = (addr - chunk->start_addr) >> order;
 			remain = bitmap_clear_ll(chunk->bits, start_bit, nbits);
 			BUG_ON(remain);
-			size = nbits << order;
 			atomic_long_add(size, &chunk->avail);
 			if (owner)
 				*owner = chunk->owner;
-- 
2.20.1

