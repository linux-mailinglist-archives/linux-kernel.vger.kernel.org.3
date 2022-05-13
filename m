Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27752618C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380140AbiEMMGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380131AbiEMMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:05:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A818F1EC5F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62930B82AF1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C153AC34100;
        Fri, 13 May 2022 12:05:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NyG/y0OX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652443546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4sD11ZKK6sqMEDpGj+axkoyGANeBn5FLuCNj9ojO1o=;
        b=NyG/y0OX5bQjQMUjE5kScYkp5SHw+t0sFtZBxhuzHE4G66cHL65xEjc7wM0DTyxjL13FNI
        cfxBRErq+FW9gZqQAK68tYR9GO/NquF9I4ZTv90atjtRXysN9+zO9tVAfv5mYC70SvVFab
        wVO7EFkoA1jCfM3+6heRnjGNp8xe7ko=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 45c5de57 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 12:05:46 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] random: move initialization out of reseeding hot path
Date:   Fri, 13 May 2022 14:05:43 +0200
Message-Id: <20220513120543.314127-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9pN_N_fG6k5gFB8mwrEPn1W-Zy54AmA3VSSvrkQyc3PvA@mail.gmail.com>
References: <CAHmME9pN_N_fG6k5gFB8mwrEPn1W-Zy54AmA3VSSvrkQyc3PvA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization happens once -- by way of credit_init_bits() -- and then
it never happens again. Therefore, it doesn't need to be in
crng_reseed(), which is a hot path that is called multiple times. It
also doesn't make sense to have there, as initialization activity is
better associated with initialization routines.

After the prior commit, crng_reseed() now won't be called by multiple
concurrent callers, which means that we can safely move the
"finialize_init" logic into crng_init_bits() unconditionally.

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Keep crng_init = CRNG_READY conditional to avoid dirtying cache line.

 drivers/char/random.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3646eac353b7..8cea19024936 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -265,7 +265,6 @@ static void crng_reseed(void)
 	unsigned long flags;
 	unsigned long next_gen;
 	u8 key[CHACHA_KEY_SIZE];
-	bool finalize_init = false;
 
 	extract_entropy(key, sizeof(key));
 
@@ -282,28 +281,10 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
-	if (!crng_ready()) {
+	if (!crng_ready())
 		crng_init = CRNG_READY;
-		finalize_init = true;
-	}
 	spin_unlock_irqrestore(&base_crng.lock, flags);
 	memzero_explicit(key, sizeof(key));
-	if (finalize_init) {
-		process_random_ready_list();
-		wake_up_interruptible(&crng_init_wait);
-		kill_fasync(&fasync, SIGIO, POLL_IN);
-		pr_notice("crng init done\n");
-		if (unseeded_warning.missed) {
-			pr_notice("%d get_random_xx warning(s) missed due to ratelimiting\n",
-				  unseeded_warning.missed);
-			unseeded_warning.missed = 0;
-		}
-		if (urandom_warning.missed) {
-			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
-				  urandom_warning.missed);
-			urandom_warning.missed = 0;
-		}
-	}
 }
 
 /*
@@ -835,10 +816,25 @@ static void credit_init_bits(size_t nbits)
 		new = min_t(unsigned int, POOL_BITS, orig + add);
 	} while (cmpxchg(&input_pool.init_bits, orig, new) != orig);
 
-	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS)
-		crng_reseed();
-	else if (orig < POOL_EARLY_BITS && new >= POOL_EARLY_BITS) {
+	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
+		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
+		process_random_ready_list();
+		wake_up_interruptible(&crng_init_wait);
+		kill_fasync(&fasync, SIGIO, POLL_IN);
+		pr_notice("crng init done\n");
+		if (unseeded_warning.missed) {
+			pr_notice("%d get_random_xx warning(s) missed due to ratelimiting\n",
+				  unseeded_warning.missed);
+			unseeded_warning.missed = 0;
+		}
+		if (urandom_warning.missed) {
+			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
+				  urandom_warning.missed);
+			urandom_warning.missed = 0;
+		}
+	} else if (orig < POOL_EARLY_BITS && new >= POOL_EARLY_BITS) {
 		spin_lock_irqsave(&base_crng.lock, flags);
+		/* Check if crng_init is CRNG_EMPTY, to avoid race with crng_reseed(). */
 		if (crng_init == CRNG_EMPTY) {
 			extract_entropy(base_crng.key, sizeof(base_crng.key));
 			crng_init = CRNG_EARLY;
-- 
2.35.1

