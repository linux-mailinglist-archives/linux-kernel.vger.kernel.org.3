Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF4525B83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbiEMG03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377304AbiEMG0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:20 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB02A732
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:26:08 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A81632013E2;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 903E9809CD; Fri, 13 May 2022 08:24:19 +0200 (CEST)
Date:   Fri, 13 May 2022 08:24:19 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] random: move initialization out of reseeding hot path
Message-ID: <Yn35k+yyrvgAt3tb@owl.dominikbrodowski.net>
References: <20220509121409.529788-1-Jason@zx2c4.com>
 <20220509121409.529788-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509121409.529788-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, May 09, 2022 at 02:14:09PM +0200 schrieb Jason A. Donenfeld:
> Initialization happens once -- by way of credit_init_bits() -- and then
> it never happens again. Therefore, it doesn't need to be in
> crng_reseed(), which is a hot path that is called multiple times. It
> also doesn't make sense to have there, as initialization activity is
> better associated with initialization routines.
> 
> After the prior commit, crng_reseed() now won't be called by multiple
> concurrent callers, which means that we can safely move the
> "finialize_init" logic into crng_init_bits() unconditionally.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 43 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 79409cf27a25..1598bb40376e 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -266,7 +266,6 @@ static void crng_reseed(void)
>  	unsigned long flags;
>  	unsigned long next_gen;
>  	u8 key[CHACHA_KEY_SIZE];
> -	bool finalize_init = false;
>  
>  	extract_entropy(key, sizeof(key));
>  
> @@ -283,28 +282,9 @@ static void crng_reseed(void)
>  		++next_gen;
>  	WRITE_ONCE(base_crng.generation, next_gen);
>  	WRITE_ONCE(base_crng.birth, jiffies);
> -	if (!crng_ready()) {
> -		crng_init = CRNG_READY;
> -		finalize_init = true;
> -	}
> +	crng_init = CRNG_READY;

Why unconditionally (you revert that bit in the static branch patch and make
it conditional again; so I see no reason for that here)?

Otherwise, looks good:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
