Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357724BD49C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbiBUEOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:14:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiBUEOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:14:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375784A3E2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C625F60FFA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10283C340E9;
        Mon, 21 Feb 2022 04:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645416833;
        bh=G+Eis18y1zWCvepauh467PZlzV5JvJWkGiTP2FYEHIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuIj1QjiZtpnObcEWOW+joK3W8yJQoBHq4RZActqvRwtdm0V1D4bV/DoJx92cf2dm
         Jrad6NO32HMf0wtBIZIG6gdBxt1g5+woQAfF+vfhMVn+xXFB9OETkWmcd2Ksh8578i
         P3nGdw3tTYZLBYltAFXTsg9ua4dK2j7+xDiaSpMSRB/RZ0fy5A1vZ0NkggVvHeOq6c
         2HArAGWFYSMrsSqpmeF1A6XzLt/ypCQ9YfPjuTlkdseU2hk7u+yANNLV3khZHVJ6KE
         w0qlWDh8A4Ptbu31KaLveV/uBGNUHpjcT4Mpsxhh8j98u0IYpxPdtRuCM96tR5Tiwc
         FN9AXAKFjWVrw==
Date:   Sun, 20 Feb 2022 20:13:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: tie batched entropy generation to base_crng
 generation
Message-ID: <YhMRf1tqgB/zSvAs@sol.localdomain>
References: <CAHmME9oo5y08skaOOXg-q0T9pDs580dOotm6Wz0t96AssZr2Pw@mail.gmail.com>
 <20220210131304.97224-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210131304.97224-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:13:04PM +0100, Jason A. Donenfeld wrote:
> Now that we have an explicit base_crng generation counter, we don't need
> a separate one for batched entropy. Rather, we can just move the
> generation forward every time we change crng_init state or update the
> base_crng key.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v2 always increments the generation after extraction, as suggested by
> Dominik.
> 
>  drivers/char/random.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

One comment below:

> @@ -455,7 +453,7 @@ static size_t crng_fast_load(const void *cp, size_t len)
>  		src++; crng_init_cnt++; len--; ret++;
>  	}
>  	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
> -		invalidate_batched_entropy();
> +		++base_crng.generation;
>  		crng_init = 1;
>  	}

This is an existing issue, but why doesn't crng_slow_load() do this too?

- Eric
