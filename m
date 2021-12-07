Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A2746BAEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhLGMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhLGMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:21:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32924C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:17:49 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00i0fj+CxwvnY3WPnMS3XQ9NrK3ZVRG3Ks91sLDZnzM=;
        b=KlOLM3/IR3ODzuNvBtLnPdJydDHxS13QCY8feYZ5NFHM4O3+ZYRDogWJ/hpilo4BBjuQmk
        TkjQ+IW0C7x1NYMa3B9JvIhfM3wOPKQ4xVNEdcBQ+agHsH+zbupMz0Am+lPW1ob768Fmzf
        /PoW8qsV8ahgPYCgUs0eh2culrH3QbIEOMNjCcVmayLsaBFoTym/TTPFwN1eLxjMj1Ug71
        WmUhMI/3sRjC4YGv793zMr70ZtkMek0mQJQwuhj9ytOozLlGYyoT2sljHft0rzE9UeLdj4
        /5CFR2cE5AX+Jh0qolDFmdpR0uOCrawzWMQ2MKwEFSJh8cf0StjxtNeQRMpKEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00i0fj+CxwvnY3WPnMS3XQ9NrK3ZVRG3Ks91sLDZnzM=;
        b=ICBGxwHtP+udJK7rcHH6DEa8sSvmAdVFMJevxS+39y5SE9MxlURcIRPUmSDPBeP6n6xydA
        oPeJHZCZONp472Cg==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] random: Move the fast_pool reset into the caller.
Date:   Tue,  7 Dec 2021 13:17:36 +0100
Message-Id: <20211207121737.2347312-5-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-1-bigeasy@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state of the fast_pool (number of added entropy, timestamp of last
addition) is reset after entropy has been consumed.

Move the reset of the fast_pool into the caller.
This is a preparations step to ease PREEMPT_RT support.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index dfc38d87125f5..4bcaa7886201d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1242,37 +1242,35 @@ static __u32 get_reg(struct fast_pool *f, struct pt=
_regs *regs)
 	return *ptr;
 }
=20
-static void process_interrupt_randomness_pool(struct fast_pool *fast_pool)
+static bool process_interrupt_randomness_pool(struct fast_pool *fast_pool)
 {
 	struct entropy_store	*r;
-	unsigned long		now =3D jiffies;
=20
 	if (unlikely(crng_init =3D=3D 0)) {
+		bool pool_reset =3D false;
+
 		if ((fast_pool->count >=3D 64) &&
 		    crng_fast_load((char *) fast_pool->pool,
-				   sizeof(fast_pool->pool))) {
-			fast_pool->count =3D 0;
-			fast_pool->last =3D now;
-		}
-		return;
+				   sizeof(fast_pool->pool)))
+			pool_reset =3D true;
+
+		return pool_reset;
 	}
=20
 	if ((fast_pool->count < 64) &&
-	    !time_after(now, fast_pool->last + HZ))
-		return;
+	    !time_after(jiffies, fast_pool->last + HZ))
+		return false;
=20
 	r =3D &input_pool;
 	if (!spin_trylock(&r->lock))
-		return;
+		return false;
=20
-	fast_pool->last =3D now;
 	__mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
 	spin_unlock(&r->lock);
=20
-	fast_pool->count =3D 0;
-
 	/* award one bit for the contents of the fast pool */
 	credit_entropy_bits(r, 1);
+	return true;
 }
=20
 void add_interrupt_randomness(int irq)
@@ -1298,7 +1296,10 @@ void add_interrupt_randomness(int irq)
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
=20
-	process_interrupt_randomness_pool(fast_pool);
+	if (process_interrupt_randomness_pool(fast_pool)) {
+		fast_pool->last =3D now;
+		fast_pool->count =3D 0;
+	}
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
=20
--=20
2.34.1

