Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9B56B365
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiGHHUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiGHHUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:20:31 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC041796BE;
        Fri,  8 Jul 2022 00:20:30 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o9iHW-00Fqwz-9l; Fri, 08 Jul 2022 17:20:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jul 2022 15:20:06 +0800
Date:   Fri, 8 Jul 2022 15:20:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simo Sorce <simo@redhat.com>
Subject: Re: [PATCH v3] crypto: fips - make proc files report fips module
 name and version
Message-ID: <YsfappxjOaj99WEV@gondor.apana.org.au>
References: <20220620131618.952133-1-vdronov@redhat.com>
 <20220627195144.976741-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627195144.976741-1-vdronov@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:51:44PM +0200, Vladis Dronov wrote:
>
> diff --git a/crypto/fips.c b/crypto/fips.c
> index 7b1d8caee669..d820f83cb878 100644
> --- a/crypto/fips.c
> +++ b/crypto/fips.c
> @@ -30,13 +30,37 @@ static int fips_enable(char *str)
>  
>  __setup("fips=", fips_enable);
>  
> +#define FIPS_MODULE_NAME CONFIG_CRYPTO_FIPS_NAME
> +#ifdef CONFIG_CRYPTO_FIPS_CUSTOM_VERSION
> +#define FIPS_MODULE_VERSION CONFIG_CRYPTO_FIPS_VERSION
> +#else
> +#define FIPS_MODULE_VERSION UTS_RELEASE
> +#endif
> +
> +static char fips_name[] = FIPS_MODULE_NAME;
> +static char fips_version[] = FIPS_MODULE_VERSION;

This doesn't compile for me because you need to include
generated/utsrelease.h.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
