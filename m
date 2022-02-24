Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19104C35F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiBXTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBXTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:34:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C378225591;
        Thu, 24 Feb 2022 11:34:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18FC0B828FC;
        Thu, 24 Feb 2022 19:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8469DC340E9;
        Thu, 24 Feb 2022 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645731259;
        bh=gvFTRKu89/W9c7Fwwvs6h2vdFA7hJz85BELboi7Hk6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJ32oCok0bwrTTWEmoScUk9NvPIKSLv2zpWTJ94gmv89Nhr49/AF8HNB+8dJJNE2a
         8gtRIlzpTMVQkw5mrHQwcSklq/7A7vjnz5BLPqvv5afCZCuA8/u/9XKNRJHflIEsYl
         OmYeqgI5KTynTFW8ruIp6MKxYRSt7gG4R7/1r+hhFT8+qULrPcBeOZamp956Ys4zSS
         dk6y8BQ4C+LedsDuyoevZ2a+EB/gE9e3k5k0uD48Y8Eda70ZUjWSpCxd1ZcpCI8Aq1
         68KfziGeHm29mhEwumtZ/fCfp14sT3YjMeCA6EwqkZU+2/hr8EXQl9MEI145whNlmk
         mG6NF1tJ5hHBQ==
Date:   Thu, 24 Feb 2022 11:34:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Denis Glazkov <d.glazkov@omp.ru>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PKCS#7: fix a possible memory leak when calculating the
 digest
Message-ID: <YhfduRrOnjSFab0v@sol.localdomain>
References: <20220224190838.144388-1-d.glazkov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224190838.144388-1-d.glazkov@omp.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:09:12PM +0000, Denis Glazkov wrote:
> In function `pkcs7_digest`, if there is an error allocating memory
> for the `shash_desc` structure, the public key signature digest
> remains unfreed.
> 
> Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
> ---
>  crypto/asymmetric_keys/pkcs7_verify.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
> index 0b4d07aa8811..e6f648dcc02a 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -50,7 +50,7 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
>  	ret = -ENOMEM;
>  	sig->digest = kmalloc(sig->digest_size, GFP_KERNEL);
>  	if (!sig->digest)
> -		goto error_no_desc;
> +		goto error_no_digest;
>  
>  	desc = kzalloc(desc_size, GFP_KERNEL);
>  	if (!desc)
> @@ -117,6 +117,8 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
>  error:
>  	kfree(desc);
>  error_no_desc:
> +	kfree(sig->digest);
> +error_no_digest:
>  	crypto_free_shash(tfm);
>  	kleave(" = %d", ret);
>  	return ret;
> -- 
> 2.25.1

Doesn't this introduce a double free?  public_key_signature_free() frees this
too.

- Eric
