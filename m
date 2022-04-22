Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58350B448
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446156AbiDVJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445893AbiDVJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:45:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D54D53B43;
        Fri, 22 Apr 2022 02:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 91C70CE2815;
        Fri, 22 Apr 2022 09:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440B6C385A0;
        Fri, 22 Apr 2022 09:42:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Jgc6f0iq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650620526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHIIdX6sGvzIEKEIWo44H1IVABXHkB0EQjFQOYhzuVs=;
        b=Jgc6f0iqAzdn0TORE7BQt/lXm1/UJlNT8kDLcTg84Y9u1kKVPvmw+NA3Vl+D4VbEZ2oIFt
        vuX6fgO4/WfKNoCNO6nRTeL5SsUlm2NIhTBShUR2cXC35AXOXXWMt8nPXbLWgkV6DIQg8R
        eWIkdOoNLN7Z/44G0sxDJSu8Rel2Az4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5833aa0f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Apr 2022 09:42:06 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:42:04 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmJ4bJjet/QhkXZS@zx2c4.com>
References: <20220421233152.58522-1-ebiggers@kernel.org>
 <YmHraZcGnY3stnp9@zx2c4.com>
 <YmH4Mgbo9gs4tOp7@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmH4Mgbo9gs4tOp7@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Apr 21, 2022 at 05:34:58PM -0700, Eric Biggers wrote:
> On Fri, Apr 22, 2022 at 01:40:25AM +0200, Jason A. Donenfeld wrote:
> > Hi Eric,
> > 
> > Thanks. This looks better.
> > 
> > On Thu, Apr 21, 2022 at 04:31:52PM -0700, Eric Biggers wrote:
> > > Therefore, increase the number of counter comparisons from 1 to 3, to
> > > greatly reduce the rate of false positive cycle counter detections.
> > > +	for (i = 0; i < 3; i++) {
> > > +		unsigned long entropy = random_get_entropy();
> >  
> > Wondering: why do you do 3 comparisons rather than 2? What does 3 get
> > you that 2 doesn't already? I thought the only real requirement was that
> > in the event where (a)!=(b), (b) is read as meaningfully close as
> > possible to when the counter changes.
> > 
> 
> On CONFIG_PREEMPT kernels this code usually runs with preemption enabled, so I
> don't think it's guaranteed that any particular number of comparisons will be
> sufficient, since the task could get preempted for a long time between each call
> to random_get_entropy().  However, the chance of a false positive should
> decrease exponentially, and should be pretty small in the first place, so 3
> comparisons seems like a good number.

Ahh, I see. So you check three times instead of disabling
preemption/irqs, which would be awfully heavy weight. Seems like a
reasonable compromise.

By the way, I was thinking about the assumptions we're making with this
comparison ("two adjacent counters shouldn't be the same") in the
context of this idea from my first reply to you:

    static void entropy_timer(struct timer_list *t)
    {
        struct timer_state *s = container_of(...t...);
        if (++s->samples == s->samples_per_bit) {
            credit_entropy_bits(1);
            s->samples = 0;
        }
    }

A naive approach that strikes me as strictly _no worse_ than what we
currently have would be to say that right now we require every counter
to be different in order to credit everytime. If every other counter is
different, then we should credit every other time. If every third
counter is different, we should credit every third time. And so forth.
While that simple logic isn't some sort of fancy realtime FFT thing, it
also doesn't appear on its surface to be relying on assumptions that
we're not already making. I think? It has flaws -- it doesn't account
for the possibility that while the counter changes, it's way too uniform
in how it changes -- but neither does the current technique. So while
it's not the end goal of actually looking at this through some
statistical lens, it feels like an improvement on what we have now with
little complication.

If that seems convincing, what do you make of the below snippet?

Jason

------------8<--------------------------------------------------------------

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf89c6f27a19..cabba031cbaf 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1354,6 +1354,12 @@ void add_interrupt_randomness(int irq)
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
 
+struct entropy_timer_state {
+	unsigned long entropy;
+	struct timer_list timer;
+	unsigned int samples, samples_per_bit;
+};
+
 /*
  * Each time the timer fires, we expect that we got an unpredictable
  * jump in the cycle counter. Even if the timer is running on another
@@ -1367,9 +1373,14 @@ EXPORT_SYMBOL_GPL(add_interrupt_randomness);
  *
  * So the re-arming always happens in the entropy loop itself.
  */
-static void entropy_timer(struct timer_list *t)
+static void entropy_timer(struct timer_list *timer)
 {
-	credit_entropy_bits(1);
+	struct entropy_timer_state *state = container_of(timer, struct entropy_timer_state, timer);
+
+	if (++state->samples == state->samples_per_bit) {
+		credit_entropy_bits(1);
+		state->samples = 0;
+	}
 }
 
 /*
@@ -1378,16 +1389,26 @@ static void entropy_timer(struct timer_list *t)
  */
 static void try_to_generate_entropy(void)
 {
-	struct {
-		unsigned long entropy;
-		struct timer_list timer;
-	} stack;
+	enum { NUM_TRIALS = 2048, MAX_BITS_PER_SAMPLE = 256 };
+	struct entropy_timer_state stack;
+	unsigned int i, num_different = 1;
 
-	stack.entropy = random_get_entropy();
-
-	/* Slow counter - or none. Don't even bother */
-	if (stack.entropy == random_get_entropy())
+	unsigned long *trials = kmalloc_array(NUM_TRIALS, sizeof(*trials), GFP_KERNEL);
+	if (!trials)
 		return;
+	for (i = 0; i < NUM_TRIALS; ++i)
+		trials[i] = random_get_entropy();
+	for (i = 0; i < NUM_TRIALS - 1; ++i) {
+		if (trials[i] != trials[i + 1])
+			++num_different;
+	}
+	mix_pool_bytes(trials, NUM_TRIALS * sizeof(*trials));
+	kfree(trials);
+	stack.samples_per_bit = DIV_ROUND_UP(NUM_TRIALS, num_different);
+	if (stack.samples > MAX_BITS_PER_SAMPLE)
+		return;
+	stack.samples = 0;
+	stack.entropy = random_get_entropy();
 
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready() && !signal_pending(current)) {

