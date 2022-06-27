Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706355DE11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbiF0XOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbiF0XOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:14:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E623140;
        Mon, 27 Jun 2022 16:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C656155C;
        Mon, 27 Jun 2022 23:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C99BC341C8;
        Mon, 27 Jun 2022 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656371685;
        bh=h4FR0qftIvkH2uTSynr4CWcZ4lbRTfiY9kRTXC9vhC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVumDj2bJvP3+KrO/DN9mUcf4t+RsXVIMpp/dDhtG24b3DoZqbMhF1Y0p4FNqIY5+
         m+GZjCtQzd+mmgOhqsfrrph8ROF9fIUiJYfwHg5uPSfErIvUBv8NcFeS+w+NnrO/Db
         ms4S+uoY70BrYvOdLhVZ9YQLn8elgC3OG5cM/cUuz7ZZh+jDVSNBZFU6Zz9vLQo7fc
         o2/6CRy7mwpJTsjz3r013qEeFBsXYa3FiTRF1uuodjuoLy8qHxTT1Qn0j24uVZqyc2
         y4dfsB+u8civcJn6Ur0g3rW40NiuYMyD+6ixn2LstAep8DOWmByGR9ojvRyNZqUMe9
         6oFZ2w//886pw==
Date:   Tue, 28 Jun 2022 02:14:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Eric Biggers <ebiggers@google.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] KEYS: asymmetric: enforce SM2 signature use
 pkey algo
Message-ID: <Yro54bzvRZqbmCxb@kernel.org>
References: <20220627092027.20858-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627092027.20858-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 05:20:27PM +0800, Tianjia Zhang wrote:
> The signature verification of SM2 needs to add the Za value and
> recalculate sig->digest, which requires the detection of the pkey_algo
> in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
> field in sig is attacker-controlled and should be use pkey->pkey_algo
> instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
> will also cause signature verification failure.
> 
> The software_key_determine_akcipher() already forces the algorithms
> are matched, so the SM3 algorithm is enforced in the SM2 signature,
> although this has been checked, we still avoid using any algorithm
> information in the signature as input.
> 
> Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
> Reported-by: Eric Biggers <ebiggers@google.com>
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/asymmetric_keys/public_key.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 7c9e6be35c30..3f17ee860f89 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -309,7 +309,8 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
>  	if (ret)
>  		return ret;
>  
> -	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
> +	/* SM2 signatures always use the SM3 hash algorithm */
> +	tfm = crypto_alloc_shash("sm3", 0, 0);

So, why this should not validate sig->hash_alog *to be* "sm3"?

I.e. add instead guard before crypto_alloc_hash:

        if (strncmp(sig->hash_algo, "sm3") != 0) {
                /* error */
        }
        /* continue */

>  	if (IS_ERR(tfm))
>  		return PTR_ERR(tfm);
>  
> @@ -414,8 +415,7 @@ int public_key_verify_signature(const struct public_key *pkey,
>  	if (ret)
>  		goto error_free_key;
>  
> -	if (sig->pkey_algo && strcmp(sig->pkey_algo, "sm2") == 0 &&
> -	    sig->data_size) {
> +	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
>  		ret = cert_sig_digest_update(sig, tfm);
>  		if (ret)
>  			goto error_free_key;
> -- 
> 2.24.3 (Apple Git-128)
> 

BR, Jarkko
