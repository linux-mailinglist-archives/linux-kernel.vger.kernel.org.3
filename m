Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78F152E076
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbiESXUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbiESXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613DFEAD1D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03D2D618D2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF79CC385AA;
        Thu, 19 May 2022 23:20:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fv+vl/SR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653002425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M+UbgKwSOe0tOcJKIsaoHJi5BUYtEoMuT9eIw2+sXfw=;
        b=fv+vl/SRSQ6z3qEQC7enGRiuo8bIl+Ctd8TE2JRxSeuGlQYG8fh4BzdEztmxIHy58hoWME
        sBVpE0CSGH5HfsX47LbjwWOEsdQknc/L5xTe8WE+LxRk2Ny8A96eIz8QouFcFcEwI6F+wp
        8oC6RLsphUy+JFN7DvozVt3iG2C8QIQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 738f85f4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 19 May 2022 23:20:25 +0000 (UTC)
Date:   Fri, 20 May 2022 01:20:23 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] random: convert to using fops->read_iter()
Message-ID: <YobQt1Fbae0KtEFw@zx2c4.com>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <20220519193133.194138-2-axboe@kernel.dk>
 <YobOxLKnRDyYChXS@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YobOxLKnRDyYChXS@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:12:04AM +0200, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 01:31:32PM -0600, Jens Axboe wrote:
> >  	for (;;) {
> >  		chacha20_block(chacha_state, output);
> >  		if (unlikely(chacha_state[12] == 0))
> >  			++chacha_state[13];
> >  
> >  		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
> > -		left = copy_to_user(ubuf, output, block_len);
> > -		if (left) {
> > -			ret += block_len - left;
> > +		block_len = copy_to_iter(output, block_len, to);
> > +		if (!block_len)
> >  			break;
> > -		}
> >  
> > -		ubuf += block_len;
> >  		ret += block_len;
> >  		len -= block_len;
> > -		if (!len)
> > -			break;
> >  
> >  		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
> >  		if (ret % PAGE_SIZE == 0) {
> >  			if (signal_pending(current))
> >  				break;
> >  			cond_resched();
> >  		}
> >  	}
> 
> This isn't quite the same, is it? Before, it would immediately break out
> of the loop on any short copy. Now, it will only break out on a zero
> copy, which means it's possible that ret % PAGE_SIZE == 0, and there'll
> be an unnecessary cond_resched() before copy_to_iter() runs again and
> then breaks.

Maybe something like the below would do the trick?


static ssize_t get_random_bytes_user(struct iov_iter *to)
{
	size_t block_len, copied, ret = 0, len = iov_iter_count(to);
	u32 chacha_state[CHACHA_STATE_WORDS];
	u8 output[CHACHA_BLOCK_SIZE];

	if (!len)
		return 0;

	/*
	 * Immediately overwrite the ChaCha key at index 4 with random
	 * bytes, in case userspace causes copy_to_user() below to sleep
	 * forever, so that we still retain forward secrecy in that case.
	 */
	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);
	/*
	 * However, if we're doing a read of len <= 32, we don't need to
	 * use chacha_state after, so we can simply return those bytes to
	 * the user directly.
	 */
	if (len <= CHACHA_KEY_SIZE) {
		ret = copy_to_iter(&chacha_state[4], len, to);
		goto out_zero_chacha;
	}

	for (;;) {
		chacha20_block(chacha_state, output);
		if (unlikely(chacha_state[12] == 0))
			++chacha_state[13];

		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
		copied = copy_to_iter(output, block_len, to);
		ret += copied;
		if (block_len != copied)
			break;
		len -= copied;

		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
		if (ret % PAGE_SIZE == 0) {
			if (signal_pending(current))
				break;
			cond_resched();
		}
	}

	memzero_explicit(output, sizeof(output));
out_zero_chacha:
	memzero_explicit(chacha_state, sizeof(chacha_state));
	return ret ? ret : -EFAULT;
}
