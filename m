Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7152E2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbiETDLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345078AbiETDLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:11:13 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5BB24949
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gyJNEfv9R5NkPnjKqDnHIn8kUH4k3YUqrHbhdKGsrzE=; b=tySXjmW3S0IEvhnrIKacA++Lqs
        j3ECrCnVCrvbe3C/aOGrFoIr35VNcJHxfxbnDcT0tnMV4nWKrTDPvU38tALo+262hVWRseJ2guyBF
        0L+1qqyNveneqrvwjXD2PRbCDnL5e1vv22marfilyBW+sj21HAKFHytWRrdwzaQyfmyPwA327iW8r
        +bjSlblQyVeEO9wCE7p8Mpa9QylPGax1OC0ik8Jbr4sNdXYDUy4vbSpwlpU+J7cQBriN64n7+8tjv
        WOnknSxkIGX6RChreAccDiuu9P0hc1RmcSiyjuj4zRm+rUyUnVk4xNoeryqWlXK7JEsj6qShsjkVe
        v/drERsg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrt2g-00GU2d-Gm; Fri, 20 May 2022 03:11:06 +0000
Date:   Fri, 20 May 2022 03:11:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tytso@mit.edu, Jason@zx2c4.com, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] random: convert to using fops->read_iter()
Message-ID: <YocGyl8mmG84tQD4@zeniv-ca.linux.org.uk>
References: <20220519233137.20415-1-axboe@kernel.dk>
 <20220519233137.20415-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519233137.20415-2-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:31:36PM -0600, Jens Axboe wrote:

> @@ -418,25 +419,23 @@ static ssize_t get_random_bytes_user(void __user *ubuf, size_t len)
>  	 * the user directly.
>  	 */
>  	if (len <= CHACHA_KEY_SIZE) {
> -		ret = len - copy_to_user(ubuf, &chacha_state[4], len);
> +		ret = copy_to_iter(&chacha_state[4], len, to);
>  		goto out_zero_chacha;
>  	}
>  
>  	for (;;) {
> +		size_t copied;
> +
>  		chacha20_block(chacha_state, output);
>  		if (unlikely(chacha_state[12] == 0))
>  			++chacha_state[13];
>  
>  		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
> -		left = copy_to_user(ubuf, output, block_len);
> -		if (left) {
> -			ret += block_len - left;
> +		copied = copy_to_iter(output, block_len, to);
> +		ret += copied;
> +		if (copied != block_len)
>  			break;
> -		}

		copied = copy_to_iter(output, CHACHA_BLOCK_SIZE, to);
		ret += copied;
		if (copied != CHACHA_BLOCK_SIZE) {
			if (!ret)
				ret = -EFAULT;
			break;
		}
	}

>  SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags)
>  {
> +	struct iovec iov = { .iov_base = ubuf };
> +	struct iov_iter iter;

	import_single_range(READ, ubuf, len, &iov, &iter)

(note, BTW, that this'll cap len)
