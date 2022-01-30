Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2366F4A39AF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356434AbiA3VEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:04:48 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:51612 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiA3VEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:04:41 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 19B112013FC;
        Sun, 30 Jan 2022 21:04:40 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 0194280807; Sun, 30 Jan 2022 22:03:22 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/2] random: only call crng_finalize_init() for primary_crng
Date:   Sun, 30 Jan 2022 22:03:20 +0100
Message-Id: <20220130210320.3997-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130210320.3997-1-linux@dominikbrodowski.net>
References: <20220130210320.3997-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crng_finalize_init() returns instantly if it is called for another pool
than primary_crng. The test whether crng_finalize_init() is still required
can be moved to the relevant caller in crng_reseed(), and
crng_need_final_init can be reset to false if crng_finalize_init() is
called with workqueues ready. Then, no previous callsite will call
crng_finalize_init() unless it is needed, and we can get rid of the
superfluous function parameter. 

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d332054bbbb6..7ed910c23858 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -800,10 +800,8 @@ static void __init crng_initialize_primary(void)
 	primary_crng.init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
-static void crng_finalize_init(struct crng_state *crng)
+static void crng_finalize_init(void)
 {
-	if (crng != &primary_crng || crng_init >= 2)
-		return;
 	if (!system_wq) {
 		/* We can't call numa_crng_init until we have workqueues,
 		 * so mark this for processing later. */
@@ -814,6 +812,7 @@ static void crng_finalize_init(struct crng_state *crng)
 	invalidate_batched_entropy();
 	numa_crng_init();
 	crng_init = 2;
+	crng_need_final_init = false;
 	process_random_ready_list();
 	wake_up_interruptible(&crng_init_wait);
 	kill_fasync(&fasync, SIGIO, POLL_IN);
@@ -980,7 +979,8 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 	memzero_explicit(&buf, sizeof(buf));
 	WRITE_ONCE(crng->init_time, jiffies);
 	spin_unlock_irqrestore(&crng->lock, flags);
-	crng_finalize_init(crng);
+	if (crng == &primary_crng && crng_init < 2)
+		crng_finalize_init();
 }
 
 static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE])
@@ -1697,7 +1697,7 @@ int __init rand_initialize(void)
 {
 	init_std_data();
 	if (crng_need_final_init)
-		crng_finalize_init(&primary_crng);
+		crng_finalize_init();
 	crng_initialize_primary();
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
-- 
2.35.1

