Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B372A5866E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiHAJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:34:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F18D31918
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:34:35 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:34:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659346473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQoDCMc9BqbZGAZA9Te8ocFP44ZiMrhhilMu+6xUIRw=;
        b=Dy437sk9Y7LaEXwa6nUureU3froV0yF1vgb0fqxOie5WDHMJiEhbIffSTpAqptavQkBOmt
        YRqwB0c1nCwLy8kIQLUFUkZAIfxey/5rBUYkmFtKeVsGtdRDlNPh+pnl0gubGHvFyScbOn
        P0PUFEIl4l1NhT8/lrRIaGNi+rn1jq5eQdt5A6qgz0I60swJZHGraQPUHyYN0JULQNWJ2A
        F/Lp+T8EL5oPVZ7M7FzuoJl4SOH6JkdczaLUx/xqkUtITAMAv9duuhcSc5Aeik0jDmjDRw
        EKWojDr9RA4hGPwOYexR7AeFQcIlm+XaxSbxU+lI2P1WM0fybudKark5Oj8Geg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659346473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQoDCMc9BqbZGAZA9Te8ocFP44ZiMrhhilMu+6xUIRw=;
        b=DJ/Pe49gWI7g1dfWa4+Locg0kDj7UiK2eR/gp9KFtMHQVlwwOVYw9DVrHQ1liabMI8Lhjk
        5wh8N9Th7NdyC5BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2 v3] lib/vsprintf: Initialize vsprintf's pointer hash once
 the random core is ready.
Message-ID: <YueeIgPGUJgsnsAh@linutronix.de>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de>
 <YuRtSGCfe2qxHrqT@zx2c4.com>
 <YueBnnnnvpxxjE4N@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YueBnnnnvpxxjE4N@linutronix.de>
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

Move the initialization of ptr_key into a worker and schedule it from
subsys_initcall(). This happens early but after the workqueue subsystem
is ready. Use get_random_bytes() to retrieve the random value if the RNG
core is ready, otherwise schedule a worker in two seconds and try again.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v3:
   - schedule a worker every two seconds if the RNG core is not ready.

 lib/vsprintf.c |   46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -751,31 +751,39 @@ static int __init debug_boot_weak_hash_e
 early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
=20
 static bool filled_random_ptr_key;
+static siphash_key_t ptr_key __read_mostly;
+static void fill_ptr_key_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
+
+static void fill_ptr_key_workfn(struct work_struct *work)
+{
+	if (!rng_is_initialized()) {
+		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);
+		return;
+	}
+
+	get_random_bytes(&ptr_key, sizeof(ptr_key));
+
+	/* Pairs with smp_rmb() before reading ptr_key. */
+	smp_wmb();
+	WRITE_ONCE(filled_random_ptr_key, true);
+}
+
+static int __init vsprintf_init_hashval(void)
+{
+	fill_ptr_key_workfn(NULL);
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
 	/* Pairs with smp_wmb() after writing ptr_key. */
 	smp_rmb();
=20
