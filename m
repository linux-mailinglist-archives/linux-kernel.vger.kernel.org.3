Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70D4C4F81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiBYUUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiBYUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:20:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E911DAC7F;
        Fri, 25 Feb 2022 12:19:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6463F618C7;
        Fri, 25 Feb 2022 20:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEB6C340E7;
        Fri, 25 Feb 2022 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645820365;
        bh=fbarxrQUlsGe8CHhhQ16VAA753AXYK0Ur+BWrj3mZkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o274dGRVGX/tJ1WwuE2TkQfm7QzqdhkLhorTR7EB994GBGz0wFONL4gtzbY6qjLLQ
         s5txAR554G8DMgeCqOG8eRI+w2sTXZTm550FIy1nscfmx0f0ZDpb0NK6+DxjRvAmZW
         h6HT/5G55SYCPa+aSM6XxPTTqyOdlT6g+dSfK2CstoiHNu8aCUZ4WALuLiHBGIVqEK
         sIEc6tRoUFSeJ6OKQHvQ3CdlvsDTaftxGgvOwmk1vUauEZ9xMYptl2P9VtI9sL+WMa
         h6FqDJsqiH7eJfHB5xIGdBOQILQTKdJrp58O3M/S1LSVZSUkb9ULn6V+QNcfR7ZRiA
         13fkzGrlUmMpA==
Date:   Fri, 25 Feb 2022 12:19:24 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: drbg: check the return value of
 crypto_shash_init()
Message-ID: <Yhk5zA/APtZoJhpT@sol.localdomain>
References: <20220225074623.17276-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225074623.17276-1-baijiaju1990@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:46:23PM -0800, Jia-Ju Bai wrote:
> Then function crypto_shash_init() in drbg_kcapi_hash() can fail, but
> there is no check of its return value. To fix this bug, its return value
> should be checked with new error handling code.
> 
> Fixes: 541af946fe13 ("crypto: drbg - SP800-90A Deterministic Random Bit Generator")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  crypto/drbg.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 177983b6ae38..51feb9538701 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -1725,8 +1725,11 @@ static int drbg_kcapi_hash(struct drbg_state *drbg, unsigned char *outval,
>  {
>  	struct sdesc *sdesc = (struct sdesc *)drbg->priv_data;
>  	struct drbg_string *input = NULL;
> +	int ret = 0;
>  
> -	crypto_shash_init(&sdesc->shash);
> +	ret = crypto_shash_init(&sdesc->shash);
> +	if (ret)
> +		return ret;
>  	list_for_each_entry(input, in, list)
>  		crypto_shash_update(&sdesc->shash, input->buf, input->len);
>  	return crypto_shash_final(&sdesc->shash, outval);

What about the call to crypto_shash_update() right below it?

- Eric
