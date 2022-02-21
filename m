Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21C4BD584
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbiBUFix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:38:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344610AbiBUFic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:38:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710040A34
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:38:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B59611FB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958CDC340E9;
        Mon, 21 Feb 2022 05:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645421889;
        bh=UunvPTfP62k3zWkxuJP5PinJDGbPJsPAwtx2fRl0Ovk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8DFaEdlljCRHqVhnEaDGToZQHK2JcE51x1h2d/sb1aLfi/P+uN6tW42ybiSbIuiV
         sqQ9cafz5R0Msp6r0mpRjwLMXY9LIHD1wR2A1dNJWfaejchr+GWCjC1hpFZp1YzhhM
         3FgZGlHjkf4nL0zkfpEfm8VIhFqjCasB0On2NaaloG8oXE0PDvVa98cXqmV/Bs0/Ca
         FcMkvugieGZ7nvCvmw/6Jc7CQJp5Na6iP23F0k6IbhBp/QUErNdGW/XGSHW5THHozD
         RAqjjQbv+zIujFWRGCUQZ2QnHR43OV9DBx+TiKMIikkMUy5OZ2UtIsMRXkR76pqm70
         vrKyAv1AaTpGQ==
Date:   Sun, 20 Feb 2022 21:38:08 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/3] random: check for crng_init == 0, not crng_ready()
 in add_device_randomness()
Message-ID: <YhMlQEDbbPHGXMSc@sol.localdomain>
References: <20220212231022.679926-1-Jason@zx2c4.com>
 <20220212231022.679926-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212231022.679926-3-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 12:10:21AM +0100, Jason A. Donenfeld wrote:
> This has no real functional change, as crng_pre_init_inject() (and
> before that, crng_slow_init()) always checks for == 0, not >= 2. So
> correct the outer unlocked change to reflect that.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index a128bb947bd4..9a8e1bb9845d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1007,7 +1007,7 @@ void add_device_randomness(const void *buf, size_t size)
>  	unsigned long time = random_get_entropy() ^ jiffies;
>  	unsigned long flags;
>  
> -	if (!crng_ready() && size)
> +	if (crng_init == 0 && size)
>  		crng_pre_init_inject(buf, size, false, false);
>  
>  	spin_lock_irqsave(&input_pool.lock, flags);
> -- 
> 2.35.0
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
