Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01624C3EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiBYHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbiBYHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:06:37 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748E1DD0CC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 23:06:02 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5B7802013FE;
        Fri, 25 Feb 2022 07:06:01 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 5DCF8802B1; Fri, 25 Feb 2022 07:58:40 +0100 (CET)
Date:   Fri, 25 Feb 2022 07:58:40 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2] random: unify cycles_t and jiffies usage and types
Message-ID: <Yhh+IJftHEZcHdEn@owl.dominikbrodowski.net>
References: <20220224173948.34045-1-Jason@zx2c4.com>
 <20220224213030.75400-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224213030.75400-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Feb 24, 2022 at 10:30:30PM +0100 schrieb Jason A. Donenfeld:
> @@ -1016,19 +1010,26 @@ struct timer_rand_state {
>   */
>  void add_device_randomness(const void *buf, size_t size)
>  {
> -	unsigned long time = random_get_entropy() ^ jiffies;
> -	unsigned long flags;
> +	cycles_t cycles = random_get_entropy();
> +	unsigned long now = jiffies, flags;

maybe "flags, now = jiffies" is a bit more reader-friendly?

>  static void add_timer_randomness(struct timer_rand_state *state, unsigned int num)
>  {
> -	struct {
> -		long jiffies;
> -		unsigned int cycles;
> -		unsigned int num;
> -	} sample;
> +	cycles_t cycles = random_get_entropy();
> +	unsigned long now = jiffies, flags;

Same here.

> @@ -1291,10 +1289,10 @@ static void mix_interrupt_randomness(struct work_struct *work)
>  void add_interrupt_randomness(int irq)
>  {
>  	enum { MIX_INFLIGHT = 1U << 31 };
> +	cycles_t cycles = random_get_entropy();
> +	unsigned long now = jiffies;
>  	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
>  	struct pt_regs *regs = get_irq_regs();
> -	unsigned long now = jiffies;
> -	cycles_t cycles = random_get_entropy();
>  	unsigned int new_count;
>  
>  	if (cycles == 0)


Why do you change the ordering here?

Thanks,
	Dominik
