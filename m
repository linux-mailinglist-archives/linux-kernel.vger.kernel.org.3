Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9E481DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhL3POs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbhL3POg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:14:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECE2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:14:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16D8CCE1B46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 15:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5416C36AE9;
        Thu, 30 Dec 2021 15:14:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LF4M46wN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640877270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdbA0Hsu5ryhLBoli668XmIwiPO+05SUxB0kHmOmCZk=;
        b=LF4M46wN+worctF6fW47I7Ip5bTj/DQHGoInxO1aoVpwGQMgZ55W07JwkCMwhy9DsXHDeW
        qVGmjwr6SopoR/7CRufuvnEKG/SO4iTlkX80KBCky0JYVnefJyzRtqb1SGzlLKo+uxLT5W
        vm9ABG8gM4jdNC+oUXpKeDA7LmxK6D8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21538bc9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 15:14:30 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: use IS_ENABLED(CONFIG_NUMA) instead of ifdefs
Date:   Thu, 30 Dec 2021 16:14:10 +0100
Message-Id: <20211230151410.618383-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9ppDKOSMeMFjMr1XAt8_8kSSUpUWS1vL2yeZjb27=ePhw@mail.gmail.com>
References: <CAHmME9ppDKOSMeMFjMr1XAt8_8kSSUpUWS1vL2yeZjb27=ePhw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than an awkward combination of ifdefs and __maybe_unused, we can
ensure more source gets parsed, regardless of the configuration, by
using IS_ENABLED for the CONFIG_NUMA conditional code. This makes things
cleaner and easier to follow.

I've confirmed that on !CONFIG_NUMA, we don't wind up with excess code
by accident; the generated object file is the same.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9b5eb6cf82ce..54086e9da05b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -759,7 +759,6 @@ static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
 
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 
-#ifdef CONFIG_NUMA
 /*
  * Hack to deal with crazy userspace progams when they are all trying
  * to access /dev/urandom in parallel.  The programs are almost
@@ -767,7 +766,6 @@ static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
  * their brain damage.
  */
 static struct crng_state **crng_node_pool __read_mostly;
-#endif
 
 static void invalidate_batched_entropy(void);
 static void numa_crng_init(void);
@@ -815,7 +813,7 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 	return arch_init;
 }
 
-static void __maybe_unused crng_initialize_secondary(struct crng_state *crng)
+static void crng_initialize_secondary(struct crng_state *crng)
 {
 	chacha_init_consts(crng->state);
 	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
@@ -866,7 +864,6 @@ static void crng_finalize_init(struct crng_state *crng)
 	}
 }
 
-#ifdef CONFIG_NUMA
 static void do_numa_crng_init(struct work_struct *work)
 {
 	int i;
@@ -893,29 +890,24 @@ static DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
 
 static void numa_crng_init(void)
 {
-	schedule_work(&numa_crng_init_work);
+	if (IS_ENABLED(CONFIG_NUMA))
+		schedule_work(&numa_crng_init_work);
 }
 
 static struct crng_state *select_crng(void)
 {
-	struct crng_state **pool;
-	int nid = numa_node_id();
-
-	/* pairs with cmpxchg_release() in do_numa_crng_init() */
-	pool = READ_ONCE(crng_node_pool);
-	if (pool && pool[nid])
-		return pool[nid];
+	if (IS_ENABLED(CONFIG_NUMA)) {
+		struct crng_state **pool;
+		int nid = numa_node_id();
 
-	return &primary_crng;
-}
-#else
-static void numa_crng_init(void) {}
+		/* pairs with cmpxchg_release() in do_numa_crng_init() */
+		pool = READ_ONCE(crng_node_pool);
+		if (pool && pool[nid])
+			return pool[nid];
+	}
 
-static struct crng_state *select_crng(void)
-{
 	return &primary_crng;
 }
-#endif
 
 /*
  * crng_fast_load() can be called by code in the interrupt service
-- 
2.34.1

