Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2419051E16E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444608AbiEFV7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357080AbiEFV6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:58:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743376FA2B;
        Fri,  6 May 2022 14:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01F4561222;
        Fri,  6 May 2022 21:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B31C385A8;
        Fri,  6 May 2022 21:55:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YGZ0vAoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651874104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+N3dtA3i5IckHEcjuT6gSmWlIcyj5yxaCQLbE6VYwY=;
        b=YGZ0vAoAPGWftMUyldlIFOgxtU85YLRLaLUI1VVgIzM5+Q8fCUTF3w/N2C6yJXjUaJE91h
        MWZ7IH+gcztxIOiA7/OP7tZjZH796oeQ/ls6y/jyX3UUoqibAwTqR4UybxexyRpSaYlnNo
        atvXpm5U9V0YLDfUvacnb0j6ON0HT0o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 919a18bd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 6 May 2022 21:55:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Filipe Manana <fdmanana@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/3] random: do not use input pool from hard IRQs
Date:   Fri,  6 May 2022 23:54:53 +0200
Message-Id: <20220506215454.1671-2-Jason@zx2c4.com>
In-Reply-To: <20220506215454.1671-1-Jason@zx2c4.com>
References: <20220506215454.1671-1-Jason@zx2c4.com>
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

Years ago, a separate fast pool was added for interrupts, so that the
cost associated with taking the input pool spinlocks and mixing into it
would be avoided in places where latency is critical. However, one
oversight was that add_input_randomness() and add_disk_randomness()
still sometimes are called directly from the interrupt handler, rather
than being deferred to a thread. This means that some unlucky interrupts
will be caught doing a blake2s_compress() call and potentially spinning
on input_pool.lock, which can also be taken by unprivileged users by
writing into /dev/urandom.

We also observe that the entropy estimation algorithm uses jiffies,
which is rather coarse. In practice what this means that
add_timer_randomness() will credit the first event called from an
interrupt, but will skip the subsequent ones. However, if this is
triggered by an interrupt, the first event will *also* hit
add_interrupt_randomness(), which does its own crediting. So in essence
we double-count these inputs. So this commit not only avoids calling the
expensive functions from hard IRQ but also avoids this double counting.

In order to fix these issues, add_timer_randomness() now checks whether
it is being called from a hard IRQ and if so, just mixes into the
per-cpu IRQ fast pool using fast_mix(), which is much faster and can be
done lock-free.  A nice consequence of this, as well, is that it means
hard IRQ context FPU support is likely no longer useful.

A downside of this, however, is that the num argument is potentially
attacker controlled, which puts a bit more pressure on the fast_mix()
sponge to do more than it's really intended to do. As a mitigating
factor, the first 96 bits of input aren't attacker controlled (a cycle
counter followed by zeros), which means it's essentially two rounds of
siphash rather than one, which is somewhat better. It's also not that
much different from add_interrupt_randomness()'s use of the irq stack
instruction pointer register.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Filipe Manana <fdmanana@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d15f2133e804..818432638c18 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1227,6 +1227,12 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned int nu
 	unsigned long entropy = random_get_entropy(), now = jiffies, flags;
 	long delta, delta2, delta3;
 
+	if (in_hardirq()) {
+		fast_mix(this_cpu_ptr(&irq_randomness)->pool,
+			 (unsigned long[2]){ entropy, num });
+		return;
+	}
+
 	spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(&entropy, sizeof(entropy));
 	_mix_pool_bytes(&num, sizeof(num));
-- 
2.35.1

