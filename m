Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0BD5AFC75
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIGGe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIGGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:34:19 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585139FAA5;
        Tue,  6 Sep 2022 23:34:09 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oVodN-001uT1-6i; Wed, 07 Sep 2022 16:34:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 Sep 2022 14:34:01 +0800
Date:   Wed, 7 Sep 2022 14:34:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, Jason@zx2c4.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random / hw_random: core: start hwrng kthread also for
 untrusted sources
Message-ID: <Yxg7WQ1UuskDrBVj@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904080247.7890-1-linux@dominikbrodowski.net>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 79d7d4e4e582..b360ed4ece03 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -867,9 +867,9 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
> 
>        /*
>         * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
> -        * we're not yet initialized.
> +        * we're not yet initialized or this source isn't trusted.
>         */
> -       if (!kthread_should_stop() && crng_ready())
> +       if (!kthread_should_stop() && (crng_ready() || !entropy))
>                schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
> }
> EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);

Couldn't you split this bit out?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
