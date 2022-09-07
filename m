Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F705AFD8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIGHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIGHaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:30:00 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A6E20BEB;
        Wed,  7 Sep 2022 00:29:48 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 43D922013FE;
        Wed,  7 Sep 2022 07:29:46 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
        id 13E5AA00BF; Wed,  7 Sep 2022 08:54:10 +0200 (CEST)
Date:   Wed, 7 Sep 2022 08:54:10 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Jason@zx2c4.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random / hw_random: core: start hwrng kthread also for
 untrusted sources
Message-ID: <YxhAEmtVcdvIkX6Q@shine.dominikbrodowski.net>
References: <20220904080247.7890-1-linux@dominikbrodowski.net>
 <Yxg7WQ1UuskDrBVj@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxg7WQ1UuskDrBVj@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Sep 07, 2022 at 02:34:01PM +0800 schrieb Herbert Xu:
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> >
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 79d7d4e4e582..b360ed4ece03 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -867,9 +867,9 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
> > 
> >        /*
> >         * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
> > -        * we're not yet initialized.
> > +        * we're not yet initialized or this source isn't trusted.
> >         */
> > -       if (!kthread_should_stop() && crng_ready())
> > +       if (!kthread_should_stop() && (crng_ready() || !entropy))
> >                schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
> > }
> > EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> 
> Couldn't you split this bit out?

I could, but this would need to get merged before the patch to the hwrng
core gets applied. What do you (and Jason) prefer?

Thanks,
	Dominik
