Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A7846BAEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhLGMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhLGMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:21:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0DC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:17:48 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/M2ChV0b84nxwGqlWSubaxwPqwvibJm7C/TdpHeYlk=;
        b=ZuPsTCFk/Jf0E8M0sUld5QHP/QrmDOLISDniW6pj+EHALKU7dEYGZhr1N78QK+l9pL2jcf
        saouTnuX5OydlVUOSMMnR3Iqu9JLTETWk+amdG8pA2IzP+j8TrXLNndztyWFcjHABO9D/s
        qpgw0v29SmjvOGwr+Kg+JTUBAvU84vvdnZVzHOCKm4FGVHpFdYEErAaTBMS8BXuSJZ/xZd
        iTNr3jjRoJBlgh05FJpsATRBn58PeBsQYVQu/9eqr5fG+E2n8pTtv+9+WlcrNfMogX5Hnd
        u4s4JtMr3gwevlpILdDBvIjydznL17vUs60/fO0Lm17BignM3ji4r3zWOdBDng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638879467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/M2ChV0b84nxwGqlWSubaxwPqwvibJm7C/TdpHeYlk=;
        b=VmarUrcdO3Eq/t36tXvhU3/m2jtVt1DAP6Z6mNO9n5opbpE1XRYFw+IxTjJ7SSVuRkw8pk
        o5uxbkLc4zftrrAw==
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] random: Split add_interrupt_randomness().
Date:   Tue,  7 Dec 2021 13:17:35 +0100
Message-Id: <20211207121737.2347312-4-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-1-bigeasy@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split add_interrupt_randomness() into two parts:
- add_interrupt_randomness() which collects the entropy on the
  invocation of a hardware interrupt and it feeds into the fast_pool,
  a per-CPU variable (irq_randomness).

- process_interrupt_randomness_pool() which feeds the fast_pool/
  irq_randomness into the entropy_store if enough entropy has been
  gathered.

This is a preparations step to ease PREEMPT_RT support.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c | 47 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c8067c264a880..dfc38d87125f5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1242,29 +1242,10 @@ static __u32 get_reg(struct fast_pool *f, struct pt=
_regs *regs)
 	return *ptr;
 }
=20
-void add_interrupt_randomness(int irq)
+static void process_interrupt_randomness_pool(struct fast_pool *fast_pool)
 {
 	struct entropy_store	*r;
-	struct fast_pool	*fast_pool =3D this_cpu_ptr(&irq_randomness);
-	struct pt_regs		*regs =3D get_irq_regs();
 	unsigned long		now =3D jiffies;
-	cycles_t		cycles =3D random_get_entropy();
-	__u32			c_high, j_high;
-	__u64			ip;
-
-	if (cycles =3D=3D 0)
-		cycles =3D get_reg(fast_pool, regs);
-	c_high =3D (sizeof(cycles) > 4) ? cycles >> 32 : 0;
-	j_high =3D (sizeof(now) > 4) ? now >> 32 : 0;
-	fast_pool->pool[0] ^=3D cycles ^ j_high ^ irq;
-	fast_pool->pool[1] ^=3D now ^ c_high;
-	ip =3D regs ? instruction_pointer(regs) : _RET_IP_;
-	fast_pool->pool[2] ^=3D ip;
-	fast_pool->pool[3] ^=3D (sizeof(ip) > 4) ? ip >> 32 :
-		get_reg(fast_pool, regs);
-
-	fast_mix(fast_pool);
-	add_interrupt_bench(cycles);
=20
 	if (unlikely(crng_init =3D=3D 0)) {
 		if ((fast_pool->count >=3D 64) &&
@@ -1293,6 +1274,32 @@ void add_interrupt_randomness(int irq)
 	/* award one bit for the contents of the fast pool */
 	credit_entropy_bits(r, 1);
 }
+
+void add_interrupt_randomness(int irq)
+{
+	struct fast_pool	*fast_pool =3D this_cpu_ptr(&irq_randomness);
+	struct pt_regs		*regs =3D get_irq_regs();
+	unsigned long		now =3D jiffies;
+	cycles_t		cycles =3D random_get_entropy();
+	__u32			c_high, j_high;
+	__u64			ip;
+
+	if (cycles =3D=3D 0)
+		cycles =3D get_reg(fast_pool, regs);
+	c_high =3D (sizeof(cycles) > 4) ? cycles >> 32 : 0;
+	j_high =3D (sizeof(now) > 4) ? now >> 32 : 0;
+	fast_pool->pool[0] ^=3D cycles ^ j_high ^ irq;
+	fast_pool->pool[1] ^=3D now ^ c_high;
+	ip =3D regs ? instruction_pointer(regs) : _RET_IP_;
+	fast_pool->pool[2] ^=3D ip;
+	fast_pool->pool[3] ^=3D (sizeof(ip) > 4) ? ip >> 32 :
+		get_reg(fast_pool, regs);
+
+	fast_mix(fast_pool);
+	add_interrupt_bench(cycles);
+
+	process_interrupt_randomness_pool(fast_pool);
+}
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
=20
 #ifdef CONFIG_BLOCK
--=20
2.34.1

