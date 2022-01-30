Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C294A39AE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356395AbiA3VEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:04:42 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:51610 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiA3VEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:04:41 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1FF21201400;
        Sun, 30 Jan 2022 21:04:40 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 6AEA88073B; Sun, 30 Jan 2022 22:03:21 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     tytso@mit.edu, Jason@zx2c4.com
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/2] random: access primary_pool directly rather than through pointer
Date:   Sun, 30 Jan 2022 22:03:19 +0100
Message-Id: <20220130210320.3997-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both crng_initialize_primary() and crng_init_try_arch_early() are
only called for the primary_pool. Accessing it directly instead of
through a function parameter simplifies the code.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 68613f0b6887..d332054bbbb6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -762,7 +762,7 @@ static bool crng_init_try_arch(struct crng_state *crng)
 	return arch_init;
 }
 
-static bool __init crng_init_try_arch_early(struct crng_state *crng)
+static bool __init crng_init_try_arch_early(void)
 {
 	int i;
 	bool arch_init = true;
@@ -774,7 +774,7 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 			rv = random_get_entropy();
 			arch_init = false;
 		}
-		crng->state[i] ^= rv;
+		primary_crng.state[i] ^= rv;
 	}
 
 	return arch_init;
@@ -788,16 +788,16 @@ static void crng_initialize_secondary(struct crng_state *crng)
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
-static void __init crng_initialize_primary(struct crng_state *crng)
+static void __init crng_initialize_primary(void)
 {
-	_extract_entropy(&crng->state[4], sizeof(u32) * 12);
-	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
+	_extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
+	if (crng_init_try_arch_early() && trust_cpu && crng_init < 2) {
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
-	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
+	primary_crng.init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
 static void crng_finalize_init(struct crng_state *crng)
@@ -1698,7 +1698,7 @@ int __init rand_initialize(void)
 	init_std_data();
 	if (crng_need_final_init)
 		crng_finalize_init(&primary_crng);
-	crng_initialize_primary(&primary_crng);
+	crng_initialize_primary();
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
-- 
2.35.1

