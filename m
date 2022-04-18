Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B34505E26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiDRSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiDRSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D72E688
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F6DD60B31
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3DFC385A7;
        Mon, 18 Apr 2022 18:53:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jOy4ozo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650307983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGB8JANzTrrTLdiNNodqbUVslJZrL8FXNfw8HQ2tzf0=;
        b=jOy4ozo1PmlxkgwO+tPLqEmeJwXLzqoXbSxMx8nQPt8gBy8423eWQ+X3N5R75NQd8LKAom
        2vHXtxJ/eQUwJKfEydh9y4rpV2fXyRynFSKfkS7kzT2N4GG105CykE67R58H8pQX1LUCDM
        EvK5ymtbG7030ZOIqG6ayZufO1JIFFk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 611ba2c0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 18 Apr 2022 18:53:03 +0000 (UTC)
Date:   Mon, 18 Apr 2022 20:53:01 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] random: use memmove instead of memcpy for remaining 32
 bytes
Message-ID: <Yl2zjQ7fC2/hs1OI@zx2c4.com>
References: <20220413235649.97640-1-Jason@zx2c4.com>
 <Yl2xP+jGy6pEfwg9@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yl2xP+jGy6pEfwg9@sol.localdomain>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On Mon, Apr 18, 2022 at 11:43:11AM -0700, Eric Biggers wrote:
> On Thu, Apr 14, 2022 at 01:56:49AM +0200, Jason A. Donenfeld wrote:
> > In order to immediately overwrite the old key on the stack, before
> > servicing a userspace request for bytes, we use the remaining 32 bytes
> > of block 0 as the key. This means moving indices 8,9,a,b,c,d,e,f ->
> > 4,5,6,7,8,9,a,b. Since 4 < 8, for the kernel implementations of
> > memcpy(), this doesn't actually appear to be a problem in practice. But
> > relying on that characteristic seems a bit brittle. So let's change that
> > to a proper memmove(), which is the by-the-books way of handling
> > overlapping memory copies.
> > 
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/char/random.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 6b01b2be9dd4..3a293f919af9 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -333,7 +333,7 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
> >  	chacha20_block(chacha_state, first_block);
> >  
> >  	memcpy(key, first_block, CHACHA_KEY_SIZE);
> > -	memcpy(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
> > +	memmove(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
> >  	memzero_explicit(first_block, sizeof(first_block));
> >  }
> 
> first_block is on the stack, so this is never an overlapping copy.

Oh, grrr, yes you're right. I clearly over thought this into non-sense.
Will revert.

> 
> It would be more important to document the fact that random_data can point into
> chacha_state, as this is not obvious.

Good idea. I'll do that.

Jason
