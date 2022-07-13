Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFBC5738E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiGMObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGMObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:31:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAB4E37180;
        Wed, 13 Jul 2022 07:31:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E22431424;
        Wed, 13 Jul 2022 07:31:21 -0700 (PDT)
Received: from [10.1.29.153] (e121487-lin.cambridge.arm.com [10.1.29.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 235633F73D;
        Wed, 13 Jul 2022 07:31:19 -0700 (PDT)
Message-ID: <eb74e1b8-af7e-21e8-658f-af6c7975264e@arm.com>
Date:   Wed, 13 Jul 2022 15:31:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] random: vary jitter iterations based on cycle counter
 speed
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220422132027.1267060-1-Jason@zx2c4.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20220422132027.1267060-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 4/22/22 14:20, Jason A. Donenfeld wrote:
> Currently, we do the jitter dance if two consecutive reads to the cycle
> counter return different values. If they do, then we consider the cycle
> counter to be fast enough that one trip through the scheduler will yield
> one "bit" of credited entropy. If those two reads return the same value,
> then we assume the cycle counter is too slow to show meaningful
> differences.
> 
> This methodology is flawed for a variety of reasons, one of which Eric
> posted a patch to fix in [1]. The issue that patch solves is that on a
> system with a slow counter, you might be [un]lucky and read the counter
> _just_ before it changes, so that the second cycle counter you read
> differs from the first, even though there's usually quite a large period
> of time in between the two. For example:
> 
> | real time | cycle counter |
> | --------- | ------------- |
> | 3         | 5             |
> | 4         | 5             |
> | 5         | 5             |
> | 6         | 5             |
> | 7         | 5             | <--- a
> | 8         | 6             | <--- b
> | 9         | 6             | <--- c
> 
> If we read the counter at (a) and compare it to (b), we might be fooled
> into thinking that it's a fast counter, when in reality it is not. The
> solution in [1] is to also compare counter (b) to counter (c), on the
> theory that if the counter is _actually_ slow, and (a)!=(b), then
> certainly (b)==(c).
> 
> This helps solve this particular issue, in one sense, but in another
> sense, it mostly functions to disallow jitter entropy on these systems,
> rather than simply taking more samples in that case.
> 
> Instead, this patch takes a different approach. Right now we assume that
> a difference in one set of consecutive samples means one "bit" of
> credited entropy per scheduler trip. We can extend this so that a
> difference in two sets of consecutive samples means one "bit" of
> credited entropy per /two/ scheduler trips, and three for three, and
> four for four. In other words, we can increase the amount of jitter
> "work" we require for each "bit", depending on how slow the cycle
> counter is.
> 
> So this patch takes whole bunch of samples, sees how many of them are
> different, and divides to find the amount of work required per "bit",
> and also requires that at least some minimum of them are different in
> order to attempt any jitter entropy.
> 
> Note that this approach is still far from perfect. It's not a real
> statistical estimate on how much these samples vary; it's not a
> real-time analysis of the relevant input data. That remains a project
> for another time. However, it does the same (partly flawed) assumptions
> as the code that's there now, so it's probably not worse than the status
> quo, and it handles the issue Eric mentioned in [1]. But, again, it's
> probably a far cry from whatever a really robust version of this would
> be.
> 
> [1] https://lore.kernel.org/lkml/20220421233152.58522-1-ebiggers@kernel.org/
>     https://lore.kernel.org/lkml/20220421192939.250680-1-ebiggers@kernel.org/
> 
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> This is an argument very much centered around the somewhat low bar of
> being "not worse than before". If you can think of ways that it doesn't
> even manage to clear that, please do pipe up.
> 
> 
>  drivers/char/random.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index bf89c6f27a19..94a2ddb53662 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1354,6 +1354,12 @@ void add_interrupt_randomness(int irq)
>  }
>  EXPORT_SYMBOL_GPL(add_interrupt_randomness);
>  
> +struct entropy_timer_state {
> +	unsigned long entropy;
> +	struct timer_list timer;
> +	unsigned int samples, samples_per_bit;
> +};
> +
>  /*
>   * Each time the timer fires, we expect that we got an unpredictable
>   * jump in the cycle counter. Even if the timer is running on another
> @@ -1367,9 +1373,14 @@ EXPORT_SYMBOL_GPL(add_interrupt_randomness);
>   *
>   * So the re-arming always happens in the entropy loop itself.
>   */
> -static void entropy_timer(struct timer_list *t)
> +static void entropy_timer(struct timer_list *timer)
>  {
> -	credit_entropy_bits(1);
> +	struct entropy_timer_state *state = container_of(timer, struct entropy_timer_state, timer);
> +
> +	if (++state->samples == state->samples_per_bit) {
> +		credit_entropy_bits(1);
> +		state->samples = 0;
> +	}
>  }
>  
>  /*
> @@ -1378,17 +1389,22 @@ static void entropy_timer(struct timer_list *t)
>   */
>  static void try_to_generate_entropy(void)
>  {
> -	struct {
> -		unsigned long entropy;
> -		struct timer_list timer;
> -	} stack;
> -
> -	stack.entropy = random_get_entropy();
> +	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = 256 };
> +	struct entropy_timer_state stack;
> +	unsigned int i, num_different = 0;
> +	unsigned long last = random_get_entropy();
>  
> -	/* Slow counter - or none. Don't even bother */
> -	if (stack.entropy == random_get_entropy())
> +	for (i = 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
> +		stack.entropy = random_get_entropy();
> +		if (stack.entropy != last)
> +			++num_different;
> +		last = stack.entropy;
> +	}
> +	stack.samples_per_bit = DIV_ROUND_UP(NUM_TRIAL_SAMPLES, num_different + 1);
> +	if (stack.samples_per_bit > MAX_SAMPLES_PER_BIT)
>  		return;
>  
> +	stack.samples = 0;
>  	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
>  	while (!crng_ready() && !signal_pending(current)) {
>  		if (!timer_pending(&stack.timer))


I've just seen on the platform with slow(ish) timer that it is now considered
as a source of entropy with samples_per_bit set to 27 (5.19-rc6 has MAX_SAMPLES_PER_BIT
set to 32). Because of that I see significant delays and I'm trying to understand what
could be wrong with my setup.

I observe one credit_init_bits(1) call (via entropy_timer()) per ~970 schedule() calls.
Is that somewhat expected? Does it make sense at all?

Cheers
Vladimir
