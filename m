Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF7A5185C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiECNow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiECNos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:44:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8AC1D30C;
        Tue,  3 May 2022 06:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84C73B81EAE;
        Tue,  3 May 2022 13:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CFCC385A4;
        Tue,  3 May 2022 13:41:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JhhZhcKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651585270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p7mWXnm8GbdgjRIQ9Al0yBRSBRXht2MCYEZpE7Y9jd4=;
        b=JhhZhcKFUNrhyY6TMHw4gMhygQ/MvjkoWAnfLWjpzVaqcn5fYzdgQqtfm6LxG0EfKaF2ij
        Fz7cI5Bh2M3sJ5dT8USFeNye/mUf0QjpNJ2Z8cNg4dBSXu33P/SQ3Vbwz+17yP+YkK6xyF
        Ax1jRH497v4VR8v5LWWXWN/SqnpdDi4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b2825271 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 3 May 2022 13:41:10 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH RFC v1] random: use static branch for crng_ready()
Date:   Tue,  3 May 2022 15:40:52 +0200
Message-Id: <20220503134052.646325-1-Jason@zx2c4.com>
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

Since crng_ready() is only false briefly during initialization and then
forever after becomes true, we don't need to evaluate it after, making
it a prime candidate for a static branch.

One complication, however, is that it changes state in a particular call
to credit_entropy_bits(), which might be made from atomic context. So
rather than changing it then, we keep around the same state variable we
had before, but the next time it's used from non-atomic context, we
change it lazily then.

This is an RFC for now because it seems a bit complicated and fiddly,
and potentially not worth the complexity. I'm interested to hear if
people have opinions about this or if there's a better way to do it.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 845f610b6611..977093022430 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -75,12 +75,13 @@
  * crng_init =  0 --> Uninitialized
  *		1 --> Initialized
  *		2 --> Initialized from input_pool
+ *		3 --> Initialized from input_pool and static key set
  *
  * crng_init is protected by base_crng->lock, and only increases
- * its value (from 0->1->2).
+ * its value (from 0->1->2->3).
  */
 static int crng_init = 0;
-#define crng_ready() (likely(crng_init > 1))
+static DEFINE_STATIC_KEY_FALSE(crng_ready_static);
 /* Various types of waiters for crng_init->2 transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
@@ -96,6 +97,17 @@ static int ratelimit_disable __read_mostly;
 module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
 MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
 
+static bool crng_ready_slowpath(void)
+{
+	if (crng_init <= 1)
+		return false;
+	if (in_atomic() || irqs_disabled() || cmpxchg(&crng_init, 2, 3) != 2)
+		return true;
+	static_branch_enable(&crng_ready_static);
+	return true;
+}
+#define crng_ready() (static_branch_likely(&crng_ready_static) || unlikely(crng_ready_slowpath()))
+
 /*
  * Returns whether or not the input pool has been seeded and thus guaranteed
  * to supply cryptographically secure random numbers. This applies to: the
-- 
2.35.1

