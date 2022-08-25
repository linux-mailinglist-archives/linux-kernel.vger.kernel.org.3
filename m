Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A389D5A0BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiHYIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiHYIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:50:56 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE3A8306;
        Thu, 25 Aug 2022 01:50:53 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oR8Zc-00Exmc-5d; Thu, 25 Aug 2022 18:50:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 25 Aug 2022 16:50:48 +0800
Date:   Thu, 25 Aug 2022 16:50:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] crypto: crc32c - add missing Kconfig option
 select
Message-ID: <Ywc36LxM2+0eqKu2@gondor.apana.org.au>
References: <20220825084138.1881954-1-cuigaosheng1@huawei.com>
 <20220825084138.1881954-3-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825084138.1881954-3-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:41:38PM +0800, Gaosheng Cui wrote:
> The CRYPTO_CRC32C is using functions provided by CRYPTO_MANAGER,
> otherwise the following error will occur:
> 
>     EXT4-fs (mmcblk0): Cannot load crc32c driver.
> 
> So select CRYPTO_MANAGER when enable CRYPTO_CRC32C.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index b1ccf873779d..7f124604323b 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -641,6 +641,7 @@ config CRYPTO_CRC32C
>  	tristate "CRC32c CRC algorithm"
>  	select CRYPTO_HASH
>  	select CRC32
> +	select CRYPTO_MANAGER
>  	help
>  	  Castagnoli, et al Cyclic Redundancy-Check Algorithm.  Used
>  	  by iSCSI for header and data digests and by others.

Why exactly does it need CRYPTO_MANAGER?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
