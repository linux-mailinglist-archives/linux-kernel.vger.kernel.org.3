Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7464505E08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbiDRSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347435AbiDRSqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:46:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2912E0BD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85CF5B80FD4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF31C385A1;
        Mon, 18 Apr 2022 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650307401;
        bh=QhXtV6HW37bHq/ypXUsoE1dlbqN14EBlUuW/t4cpE7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OC/wNGOzvalVALIxK6texl9lcTvpyYGxqadeKOEFG97th065yfkhU9z0X4e0Cn42j
         IC7aqRTwK52Rq+P0QiBANZ1tLpoVXv2k38P4yYTyWjT5vw7w5bWzNm1GpKWo7WkOCm
         FR7AcgfHu5xcZ2WL8kpq7NKHVSjrdsAFKLxXlDUl3pI9AGlTGfwAunOMRZQ7p+oiSs
         uSSkdu7ILlHlEIJl11h0EW78KqxHejO7i17FqzVunnnuhMYqC5lPlufhxlgWISehTQ
         R+rgKL7Ctri2WOUj5MZApxOfV7bxVV1RcozWRCzmsF45ORM+k+Rpps0s7Gx4xBvkON
         e44/9Ff500Heg==
Date:   Mon, 18 Apr 2022 11:43:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] random: use memmove instead of memcpy for remaining 32
 bytes
Message-ID: <Yl2xP+jGy6pEfwg9@sol.localdomain>
References: <20220413235649.97640-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413235649.97640-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:56:49AM +0200, Jason A. Donenfeld wrote:
> In order to immediately overwrite the old key on the stack, before
> servicing a userspace request for bytes, we use the remaining 32 bytes
> of block 0 as the key. This means moving indices 8,9,a,b,c,d,e,f ->
> 4,5,6,7,8,9,a,b. Since 4 < 8, for the kernel implementations of
> memcpy(), this doesn't actually appear to be a problem in practice. But
> relying on that characteristic seems a bit brittle. So let's change that
> to a proper memmove(), which is the by-the-books way of handling
> overlapping memory copies.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 6b01b2be9dd4..3a293f919af9 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -333,7 +333,7 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
>  	chacha20_block(chacha_state, first_block);
>  
>  	memcpy(key, first_block, CHACHA_KEY_SIZE);
> -	memcpy(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
> +	memmove(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
>  	memzero_explicit(first_block, sizeof(first_block));
>  }

first_block is on the stack, so this is never an overlapping copy.

It would be more important to document the fact that random_data can point into
chacha_state, as this is not obvious.

- Eric
