Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578E44822D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 09:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhLaIcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 03:32:45 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59170 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLaIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 03:32:42 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 28236200278;
        Fri, 31 Dec 2021 08:32:41 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id AEC11806B7; Fri, 31 Dec 2021 09:26:12 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2] random: early initialization of ChaCha constants
Date:   Fri, 31 Dec 2021 09:26:08 +0100
Message-Id: <20211231082608.171839-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the ChaCha constants for the primary pool were only
initialized in crng_initialize_primary(), called by rand_initialize().
However, some randomness is actually extracted from the primary pool
beforehand, e.g. by kmem_cache_create(). Therefore, statically
initialize the ChaCha constants for the primary pool.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <linux-crypto@vger.kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c   |  5 ++++-
 include/crypto/chacha.h | 15 +++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)
 
v1->v2: do not simplify crng_initialize_primary() calling convention, add CCs
v1 at https://lore.kernel.org/lkml/20211229211009.108091-6-linux@dominikbrodowski.net/

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9b5eb6cf82ce..acb908715b62 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -457,6 +457,10 @@ struct crng_state {
 
 static struct crng_state primary_crng = {
 	.lock = __SPIN_LOCK_UNLOCKED(primary_crng.lock),
+	.state[0] = CHACHA_CONSTANT_EXPA,
+	.state[1] = CHACHA_CONSTANT_ND_3,
+	.state[2] = CHACHA_CONSTANT_2_BY,
+	.state[3] = CHACHA_CONSTANT_TE_K,
 };
 
 /*
@@ -825,7 +829,6 @@ static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
 
 static void __init crng_initialize_primary(struct crng_state *crng)
 {
-	chacha_init_consts(crng->state);
 	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
 	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index dabaee698718..b3ea73b81944 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -47,12 +47,19 @@ static inline void hchacha_block(const u32 *state, u32 *out, int nrounds)
 		hchacha_block_generic(state, out, nrounds);
 }
 
+enum chacha_constants { /* expand 32-byte k */
+	CHACHA_CONSTANT_EXPA = 0x61707865U,
+	CHACHA_CONSTANT_ND_3 = 0x3320646eU,
+	CHACHA_CONSTANT_2_BY = 0x79622d32U,
+	CHACHA_CONSTANT_TE_K = 0x6b206574U
+};
+
 static inline void chacha_init_consts(u32 *state)
 {
-	state[0]  = 0x61707865; /* "expa" */
-	state[1]  = 0x3320646e; /* "nd 3" */
-	state[2]  = 0x79622d32; /* "2-by" */
-	state[3]  = 0x6b206574; /* "te k" */
+	state[0]  = CHACHA_CONSTANT_EXPA;
+	state[1]  = CHACHA_CONSTANT_ND_3;
+	state[2]  = CHACHA_CONSTANT_2_BY;
+	state[3]  = CHACHA_CONSTANT_TE_K;
 }
 
 void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv);
-- 
2.34.1

