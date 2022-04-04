Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E8D4F1B97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380426AbiDDVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379208AbiDDQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:45:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177935256
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:43:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn33so13683245ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQ5TZYiieLZrQhGgELIDYF6dphl7SxhYApuhFN7PI+E=;
        b=FN285Qb7LB94UYMrR/LSfA8IBslwbrX7mdJeEbGyHX6LLfJ25Mu0UbdGhWRX9QFaR1
         rK6G7WuRAFNFQx+S37H3Kpk8qJqHFIfLTy/wsV3orK/SXhLmOqoKRKGS++qG6FFosXWj
         hiazP/9dVOTMk0GYcLPOGCcRZIIvY2A9XJPlHjixwanQiyWK9g8k3RG9mQPW72Pookyp
         fga3hMLwEXYYA/FXVS2lCkQSJuwrIFcz8mMMbaI8iFOjjNISF++Oo5zym7gH5IOqGkTi
         1La1w+aZm3S9TW1PEdnxk28MIaFf/m1mgJN1CbfrL8lgk31VU28IN2vEDFhsOdZy3TwG
         xkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQ5TZYiieLZrQhGgELIDYF6dphl7SxhYApuhFN7PI+E=;
        b=L7r+76JNCbnEScvh38XNA0sOpCInQT5RKxPtSlJe5RfTKSZl7UtKFHQWLTilw8IVni
         Hy2PdVD/DPJ+BHd/qle+XB+5EI+BnEcW5vuaEUSiO1VtQqoLdgBgrgQu3IRCagCWZ52o
         WP/7osiGaOgfbh1r2WdM+a+kzH3yEakNwXyif5b10TyAwp2WTKY2MUjGO6POGHEBpkmW
         ixssd4YUZjFekkAxPYYE+5NIeUkOCrJCd6kJYjS4SngA2e0GC7d8uaJ18Zh0vauoaRUV
         MofONXVUAADdl6KNGBmnm+EZrJKK+GevjSC9/tCcek8pUtiwTddzHGQhOCSh4Ck0cjbN
         U4Fg==
X-Gm-Message-State: AOAM531PPl1J/4EZ6WMnW/X7i46uimPDl52TLIVtQG3jrRpsQs2lgW8j
        nvdA9ElEzE0AvH+Cv1kgcmU=
X-Google-Smtp-Source: ABdhPJzqSavRXBB/4BLbjWQelCuYwV2l/ygMZ1+LJnmEBnoC4Iq7UjBbMa7adweQmtGWrDzWZvPIUA==
X-Received: by 2002:a2e:bf09:0:b0:24b:d55:ad86 with SMTP id c9-20020a2ebf09000000b0024b0d55ad86mr304454ljr.262.1649090583163;
        Mon, 04 Apr 2022 09:43:03 -0700 (PDT)
Received: from localhost.localdomain (dzx1kfyjwg96s--vr8cxy-3.rev.dnainternet.fi. [2001:14ba:a4ea:8200:f22f:74ff:fe2e:e0a6])
        by smtp.gmail.com with ESMTPSA id k9-20020a2ea289000000b0024afe447bc1sm1094677lja.128.2022.04.04.09.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:43:02 -0700 (PDT)
From:   Jan Varho <jan.varho@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jan Varho <jan.varho@gmail.com>
Subject: [PATCH v3] random: fix add_hwgenerator_randomness entropy accounting
Date:   Mon,  4 Apr 2022 19:42:30 +0300
Message-Id: <20220404164230.968514-1-jan.varho@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404162039.961926-1-jan.varho@gmail.com>
References: <20220404162039.961926-1-jan.varho@gmail.com>
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
index 1d8242969751..ee3ad2ba0942 100644
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
+		crng_init_cnt += min_t(size_t, len, CRNG_INIT_CNT_THRESH - crng_init_cnt);
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

