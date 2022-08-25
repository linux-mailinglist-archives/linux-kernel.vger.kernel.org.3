Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C925A0BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiHYIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiHYIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:50:14 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD98F941;
        Thu, 25 Aug 2022 01:50:12 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oR8Yt-00Exl6-EM; Thu, 25 Aug 2022 18:50:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 25 Aug 2022 16:50:03 +0800
Date:   Thu, 25 Aug 2022 16:50:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] crypto: api - Fix IS_ERR() vs NULL check
Message-ID: <Ywc3u9ObRCpxQsK0@gondor.apana.org.au>
References: <20220825084138.1881954-1-cuigaosheng1@huawei.com>
 <20220825084138.1881954-2-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825084138.1881954-2-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:41:37PM +0800, Gaosheng Cui wrote:
> The crypto_alloc_test_larval() will return null if manager is disabled,
> it may not return error pointers, so using IS_ERR_OR_NULL()
> to check the return value to fix this.
> 
> The __crypto_register_alg() will return null if manager is disabled,
> it may not return error pointers, so using IS_ERR_OR_NULL()
> to check the return value to fix this.
> 
> Fixes: cad439fc040e ("crypto: api - Do not create test larvals if manager is disabled")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  crypto/algapi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index 5c69ff8e8fa5..5a080b8aaa11 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -283,7 +283,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
>  	}
>  
>  	larval = crypto_alloc_test_larval(alg);
> -	if (IS_ERR(larval))
> +	if (IS_ERR_OR_NULL(larval))
>  		goto out;

A NULL indicates success, why are you jumping to the error path?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
