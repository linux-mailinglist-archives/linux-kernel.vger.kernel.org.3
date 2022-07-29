Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E58E584E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiG2KMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbiG2KMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10F6460
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFA861DD3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2A6C433C1;
        Fri, 29 Jul 2022 10:12:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ycmu0n8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659089532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ED5luaBg5A2hGM3SnsBK07s6/kNjqPfMKpcc5z6vEQ=;
        b=Ycmu0n8JWQJMtlfNPVOyJUzzq+Od+BRnwH+K0CcvnWVgocbnwD6K5hYhMLxcazUO38GTA7
        Qs1nfsrwZlxVWuUxENE8tVfDKspS4bEdmyTegQoZARPY2U1850zMU1Q2DXbM86PwHARzQR
        Q79yhvuqGFQMJ+wfkYMxXBhgK9yePiQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 38ec8c94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 29 Jul 2022 10:12:12 +0000 (UTC)
Date:   Fri, 29 Jul 2022 12:12:08 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Initialize vsprintf's pointer hash once the
 random core is ready.
Message-ID: <YuOyeJu8PPAVnXiN@zx2c4.com>
References: <YuOf6qu453dOkR+S@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuOf6qu453dOkR+S@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Jul 29, 2022 at 10:52:58AM +0200, Sebastian Andrzej Siewior wrote:
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -202,6 +202,7 @@ static void extract_entropy(void *buf, size_t len);
>  /* This extracts a new crng key from the input pool. */
>  static void crng_reseed(void)
>  {
> +	bool init_hash_pointer = false;
>  	unsigned long flags;
>  	unsigned long next_gen;
>  	u8 key[CHACHA_KEY_SIZE];
> @@ -221,10 +222,15 @@ static void crng_reseed(void)
>  		++next_gen;
>  	WRITE_ONCE(base_crng.generation, next_gen);
>  	WRITE_ONCE(base_crng.birth, jiffies);
> -	if (!static_branch_likely(&crng_is_ready))
> +	if (!static_branch_likely(&crng_is_ready)) {
>  		crng_init = CRNG_READY;
> +		init_hash_pointer = true;
> +	}
>  	spin_unlock_irqrestore(&base_crng.lock, flags);
>  	memzero_explicit(key, sizeof(key));
> +
> +	if (init_hash_pointer)
> +		vsprintf_init_hash_pointer();
>  }

Gumming up random.c with these sorts of things isn't alright. vsprintf
isn't special in any regard here.

If you can't do this from ordinary context inside of vsprintf, just
launch a workqueue to do it. This is already needed for changing
vsprintf's static branch, so just move the get_random_bytes() call into
there on RT (leaving it alone on non-RT, I guess).

Jason
