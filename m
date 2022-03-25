Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35F4E6D10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354728AbiCYESD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348284AbiCYER7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:17:59 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBCC6255;
        Thu, 24 Mar 2022 21:16:25 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nXbN6-0003Na-0k; Fri, 25 Mar 2022 15:16:21 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Mar 2022 16:16:20 +1200
Date:   Fri, 25 Mar 2022 16:16:19 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     QintaoShen <unSimple1993@163.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, unSimple1993@163.com
Subject: Re: [PATCH v1] crypto: stm32: Check for NULL return of
 kmalloc_array()
Message-ID: <Yj1CE0IPS+JB9V8I@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648114692-11175-1-git-send-email-unSimple1993@163.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QintaoShen <unSimple1993@163.com> wrote:
> As the potential failure of memory allocation, kmalloc_array() may return
> NULL and lead to NULL pointer dereference because of the usage of 'rctx->hw_context'.
> 
> Therefore, it is better to check the return value of kmalloc_array().
> 
> Signed-off-by: QintaoShen <unSimple1993@163.com>
> ---
> drivers/crypto/stm32/stm32-hash.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
> index d33006d..f1a1a13 100644
> --- a/drivers/crypto/stm32/stm32-hash.c
> +++ b/drivers/crypto/stm32/stm32-hash.c
> @@ -970,7 +970,8 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
>        rctx->hw_context = kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
>                                         sizeof(u32),
>                                         GFP_KERNEL);
> -
> +       if (!rctx->hw_context)
> +               return -ENOMEM;

This patch introduces a runtime PM imbalance.  Please fix.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
