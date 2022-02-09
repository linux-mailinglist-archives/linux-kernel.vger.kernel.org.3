Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBAF4AFC7D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbiBIS7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbiBIS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:57:26 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E5C050CF6;
        Wed,  9 Feb 2022 10:57:24 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 850EB20140B;
        Wed,  9 Feb 2022 18:57:21 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 6EB35803D6; Wed,  9 Feb 2022 19:57:06 +0100 (CET)
Date:   Wed, 9 Feb 2022 19:57:06 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH] random: fix locking for crng_init in crng_reseed()
Message-ID: <YgQOgqWr0nwqZCh6@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crng_init is protected by primary_crng->lock. Therefore, we need
to hold this lock when increasing crng_init to 2. As we shouldn't
hold this lock for too long, only hold it for those parts which
require protection.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/random.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cc4d9d414df2..aee56032ebb4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -497,6 +497,7 @@ static void crng_slow_load(const void *cp, unsigned int len)
 
 static void crng_reseed(void)
 {
+	bool complete_init = false;
 	unsigned long flags;
 	int entropy_count;
 	unsigned long next_gen;
@@ -526,12 +527,14 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	base_crng.birth = jiffies;
-	spin_unlock_irqrestore(&base_crng.lock, flags);
-	memzero_explicit(key, sizeof(key));
-
 	if (crng_init < 2) {
 		invalidate_batched_entropy();
 		crng_init = 2;
+		complete_init = true;
+	}
+	spin_unlock_irqrestore(&base_crng.lock, flags);
+	memzero_explicit(key, sizeof(key));
+	if (complete_init) {
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
