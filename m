Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B557DC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiGVISE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:18:02 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A4D87C3B;
        Fri, 22 Jul 2022 01:17:59 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oEnr6-003GmK-Il; Fri, 22 Jul 2022 18:17:54 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jul 2022 16:17:52 +0800
Date:   Fri, 22 Jul 2022 16:17:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, javier.martin@vista-silicon.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH] crypto: sahara - don't sleep when in softirq
Message-ID: <YtpdMKbmddCFcNhX@gondor.apana.org.au>
References: <20220713033550.118409-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713033550.118409-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:35:50AM +0800, Zhengchao Shao wrote:
> Function of sahara_aes_crypt maybe could be called by function
> of crypto_skcipher_encrypt during the rx softirq, so it is not
> allowed to use mutex lock. This patch is not yet tested.
> 
> Fixes: c0c3c89ae347 ("crypto: sahara - replace tasklets with kthread")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/crypto/sahara.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
> index 457084b344c1..867107b4ed30 100644
> --- a/drivers/crypto/sahara.c
> +++ b/drivers/crypto/sahara.c
> @@ -26,7 +26,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>

Shouldn't this be replaced with spinlock.h?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
