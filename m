Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA124F1BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381857AbiDDVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379041AbiDDQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:23:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DA5BC0B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:21:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c15so13579610ljr.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSjPy3nGUVZuHRzOUz/UszBOtl2V7S/yzI9P7KRgl08=;
        b=HT3V6nbpnDpfDTKzKnyd3jCoZaWwLF+bSGbOHokpeV/VvSEORsMHvGZW/9HQi0/7Ox
         LqVOzNucmEEn3FWgzl4veF9IGo13mhSYpKxHnakDzMIuUAmctXkMYt3FnGVq+e5Qf77+
         EDk3VKZQZKZk3Xznf/HZXc+7I5eqagDWebo+q9RWadNJSpe8YaDZvP02A5OUwKwRrldI
         uAZc0JQU8T70xON49+6b5rF4vx4OKY2Wrto17BRYlh8C8c0xtyrLQ9jP5Otaiv0Q6WIY
         Xgo/HgpqoSe+dXth94omVmmfFQ0yjfbe0cKVZFmeccyTXHJECOE8/fl+pRTqhS0w7r94
         LH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSjPy3nGUVZuHRzOUz/UszBOtl2V7S/yzI9P7KRgl08=;
        b=ICwsq/wONwKfu9zkvEajIgGL3e/Eae07JqXN5qlBOlTHjSU+CZD1PgoWa76Pw8p+Oz
         xnm/kB4Lox6//pCkaPO9j/1G+Y3JzL3xZxAGUAgu7XDSUPvKx9Iqmf6r7N+mYSMx8jOI
         +3K8eX/4B+DB/GJuegwNgMuK8XhA2MEOQrXjAHF0tZVHjDCunclvG1mbdXOwO1OuQEdb
         rKSDrVpZywCtRovD+/P/XAwyOwNFtyn0RAh2s2nRehAQT9rUjeiXl4fsNCjFrRqkzTRz
         +aDgH7gOmCfoGbQzNLx/pn9ftBGy2803bNNYrZqjWqAqnjq5oplZcTL6m0Oi5uReYIe/
         a29w==
X-Gm-Message-State: AOAM5305r4tMqjqZzdGBV63LPVUeNSAspEyekiQewiVEnKp931wxj50b
        IuugWDS+QrTWEWlbEuYSdhM=
X-Google-Smtp-Source: ABdhPJyyjkuETwqhDr1WVuvE7FvEc0DZAx9rddAx8mSnRsJnPnd1aCoRVc11fSMUqzv02rxS6jXnDA==
X-Received: by 2002:a05:651c:a0d:b0:24b:12da:335a with SMTP id k13-20020a05651c0a0d00b0024b12da335amr206367ljq.397.1649089300445;
        Mon, 04 Apr 2022 09:21:40 -0700 (PDT)
Received: from localhost.localdomain (dzx1kfyjwg96s--vr8cxy-3.rev.dnainternet.fi. [2001:14ba:a4ea:8200:f22f:74ff:fe2e:e0a6])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e8857000000b00249a15d93b8sm1090291ljj.125.2022.04.04.09.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:21:39 -0700 (PDT)
From:   Jan Varho <jan.varho@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jan Varho <jan.varho@gmail.com>
Subject: [PATCH v2] random: fix add_hwgenerator_randomness entropy accounting
Date:   Mon,  4 Apr 2022 19:20:40 +0300
Message-Id: <20220404162039.961926-1-jan.varho@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YksMxDLxPZtuYlFm@zx2c4.com>
References: <YksMxDLxPZtuYlFm@zx2c4.com>
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

add_hwgenerator_randomness tries to only use the required amound of input
for fast init, but credits all the entropy if even a byte was left over.

Fix by not crediting entropy when using the input for fast init.

Signed-off-by: Jan Varho <jan.varho@gmail.com>
---
 drivers/char/random.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1d8242969751..4d77de688016 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -437,11 +437,8 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
  * This shouldn't be set by functions like add_device_randomness(),
  * where we can't trust the buffer passed to it is guaranteed to be
  * unpredictable (so it might not have any entropy at all).
- *
- * Returns the number of bytes processed from input, which is bounded
- * by CRNG_INIT_CNT_THRESH if account is true.
  */
-static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
+static void crng_pre_init_inject(const void *input, size_t len, bool account)
 {
 	static int crng_init_cnt = 0;
 	struct blake2s_state hash;
@@ -452,18 +449,15 @@ static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
 	spin_lock_irqsave(&base_crng.lock, flags);
 	if (crng_init != 0) {
 		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return 0;
+		return;
 	}
 
-	if (account)
-		len = min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
-
 	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
 	blake2s_update(&hash, input, len);
 	blake2s_final(&hash, base_crng.key);
 
 	if (account) {
-		crng_init_cnt += len;
+		crng_init_cnt = min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
 		if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 			++base_crng.generation;
 			crng_init = 1;
@@ -474,8 +468,6 @@ static size_t crng_pre_init_inject(const void *input, size_t len, bool account)
 
 	if (crng_init == 1)
 		pr_notice("fast init done\n");
-
-	return len;
 }
 
 static void _get_random_bytes(void *buf, size_t nbytes)
@@ -1141,12 +1133,9 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
 	if (unlikely(crng_init == 0 && entropy < POOL_MIN_BITS)) {
-		size_t ret = crng_pre_init_inject(buffer, count, true);
-		mix_pool_bytes(buffer, ret);
-		count -= ret;
-		buffer += ret;
-		if (!count || crng_init == 0)
-			return;
+		crng_pre_init_inject(buffer, count, true);
+		mix_pool_bytes(buffer, count);
+		return;
 	}
 
 	/*
-- 
2.25.1

