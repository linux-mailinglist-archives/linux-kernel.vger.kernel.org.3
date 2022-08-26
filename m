Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249F15A206D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiHZFp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244907AbiHZFpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB93AA8962;
        Thu, 25 Aug 2022 22:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26BA16195D;
        Fri, 26 Aug 2022 05:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E1BC433C1;
        Fri, 26 Aug 2022 05:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661492720;
        bh=dvHGkLB4gEgzNYqdU8M9Nt8MYSoE1f2P6IGT8HDsfvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OirB0Hf/pTYt+3QpWhoFleQ5R4EpQF2vuyC0ioyqByhMgAmF5ffJRfxQf6HRPMwYs
         7Kir4WgSw++gRV/kd3zECCly0eivyiTIfhea08N3QnahGLMrHoMB12IrHvxyTUh6fG
         +Rb7sU74/4R30+HbrhbJSbieTOlL5aFgfJmEznp+lL9VNtBrJAcswuQY5p2anGtkpa
         T4q3PNG3SMCqRgWbufGT/++XlzbM2g/NRMskm/nc0ZDD3fG6H2WNNFFFzt3vNOG4RH
         N5xhqsA1393sMjh9OqvjQZfEdQ7rr6hzBPVQfD+IinkpUpPKh8gwzdJUjI96/qMymz
         +MKpNqHbqsQmA==
Date:   Fri, 26 Aug 2022 08:45:13 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Message-ID: <Ywhd6emoKvWgeB9O@kernel.org>
References: <20220824190409.4286-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824190409.4286-1-denkenz@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:04:09PM -0500, Denis Kenzior wrote:
> When support for ECDSA keys was added, constraints for data & signature
> sizes were never updated.  This makes it impossible to use such keys via
> keyctl API from userspace; fix that.

Instead of "fix that" just describe the change.

> Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>
> ---
>  crypto/asymmetric_keys/public_key.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 2f8352e88860..eca5671ad3f2 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -186,8 +186,28 @@ static int software_key_query(const struct kernel_pkey_params *params,
>  
>  	len = crypto_akcipher_maxsize(tfm);
>  	info->key_size = len * 8;
> -	info->max_data_size = len;
> -	info->max_sig_size = len;
> +
> +	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
> +		/*
> +		 * ECDSA key sizes are much smaller than RSA, and thus could
> +		 * operate on (hashed) inputs that are larger than key size.
> +		 * For example SHA384-hashed input used with secp256r1
> +		 * based keys.  Set max_data_size to be at least as large as
> +		 * the largest supported hash size (SHA512)
> +		 */
> +		info->max_data_size = 64;
> +
> +		/*
> +		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
> +		 * which is actually 2 'key_size'-bit integers encoded in
> +		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> +		 */
> +		info->max_sig_size = 2 * (len + 3) + 2;
> +	} else {
> +		info->max_data_size = len;
> +		info->max_sig_size = len;
> +	}
> +
>  	info->max_enc_size = len;
>  	info->max_dec_size = len;
>  	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
> -- 
> 2.35.1
> 

The code change lgtm.

BR, Jarkko
