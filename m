Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15BB58530E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiG2PrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbiG2PrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:47:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D625A178
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:47:22 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659109640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bv4+WczCS/N+pAcLquU4cectt+GICbjZxHfYjibJb04=;
        b=LaJXY0Nnai6PSvLVZBnHdhsxnzrc3bBwsl7L7+kGe/NJeGy4MDDRaTRP6ogdEUopFsN/xi
        W0gAH9Mge0EU1jXmaALQvKWRleyWaoZSFQGVYwgfC5/MCLAS+RAkLyYZ/Bs0ghan3anh67
        cTnNdFhZWzLobGQ4o7/tA+o56wrF8xQOoYFm1HWC11G10PfGfzVE5DEO2bosy084qoh6Nh
        fKrfV2casrpmQ2VJHrChZCyrZnnWzwhbLFw1IJquLw/uhhI4cDM2a89zhCzG3UY40O4yiT
        7dVc98AreG/RfSjEpKPi9XpHKdgh+8qpBCb4VPGLRS6MAYWxZ0jKbJxpnEhzDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659109640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bv4+WczCS/N+pAcLquU4cectt+GICbjZxHfYjibJb04=;
        b=hyC5Z7clAWI3QXTeOt0FKj7ffrh+5nnJgemaRp/Xts4zDJwY2has+kxioRuzJOv3iWKdc0
        Pe1eaRn2ZnnGR6CA==
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2 v2] lib/vsprintf: Initialize vsprintf's pointer hash once the random core is ready.
Date:   Fri, 29 Jul 2022 17:47:16 +0200
Message-Id: <20220729154716.429964-3-bigeasy@linutronix.de>
In-Reply-To: <20220729154716.429964-1-bigeasy@linutronix.de>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk code invokes vnsprintf in order to compute the complete
string before adding it into its buffer. This happens in an IRQ-off
region which leads to a warning on PREEMPT_RT in the random code if the
format strings contains a %p for pointer printing. This happens because
the random core acquires locks which become sleeping locks on PREEMPT_RT
which must not be acquired with disabled interrupts and or preemption
disabled.
By default the pointers are hashed which requires a random value on the
first invocation (either by printk or another user which comes first.

One could argue that there is no need for printk to disable interrupts
during the vsprintf() invocation which would fix the just mentioned
problem. However printk itself can be invoked in a context with
disabled interrupts which would lead to the very same problem.

Move the initializaion of ptr_key into a worker and schedule it from
subsys_initcall(). This happens early but after the workqueue subsystem
is ready. Use get_random_bytes_wait() to retrieve the random value which
will block until random data is available.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/vsprintf.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -751,31 +751,37 @@ static int __init debug_boot_weak_hash_e
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
=20
 static bool filled_random_ptr_key;
+static siphash_key_t ptr_key __read_mostly;
+
+static void fill_ptr_key_workfn(struct work_struct *work)
+{
+	int ret;
+
+	ret =3D get_random_bytes_wait(&ptr_key, sizeof(ptr_key));
+	if (WARN_ON(ret < 0))
+		return;
+	/* Pairs with smp_rmb() before reading ptr_key. */
+	smp_wmb();
+	WRITE_ONCE(filled_random_ptr_key, true);
+}
+
+static int vsprintf_init_hashval(void)
+{
+	static DECLARE_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
+
+	queue_work(system_unbound_wq, &fill_ptr_key_work);
+	return 0;
+}
+subsys_initcall(vsprintf_init_hashval)
=20
 /* Maps a pointer to a 32 bit unique identifier. */
 static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval=
_out)
 {
-	static siphash_key_t ptr_key __read_mostly;
 	unsigned long hashval;
=20
-	if (!READ_ONCE(filled_random_ptr_key)) {
-		static bool filled =3D false;
-		static DEFINE_SPINLOCK(filling);
-		unsigned long flags;
-
-		if (!rng_is_initialized() ||
-		    !spin_trylock_irqsave(&filling, flags))
-			return -EAGAIN;
-
-		if (!filled) {
-			get_random_bytes(&ptr_key, sizeof(ptr_key));
-			/* Pairs with smp_rmb() before reading ptr_key. */
-			smp_wmb();
-			WRITE_ONCE(filled_random_ptr_key, true);
-			filled =3D true;
-		}
-		spin_unlock_irqrestore(&filling, flags);
-	}
+	if (!READ_ONCE(filled_random_ptr_key))
+		return -EBUSY;
+
 	/* Pairs with smp_wmb() after writting ptr_key. */
 	smp_rmb();
=20
