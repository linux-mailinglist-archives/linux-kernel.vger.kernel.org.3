Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40115B04AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiIGNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiIGNFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:05:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E837924092;
        Wed,  7 Sep 2022 06:05:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95CC0B81CE1;
        Wed,  7 Sep 2022 13:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B0FC433C1;
        Wed,  7 Sep 2022 13:05:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B/bcq3Ru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1662555925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49NOxJ822bPKwRKlaVTKItq7gIJSVwe11b7c5oiqKNY=;
        b=B/bcq3RufPZVcOE3bYtM1Cu6Nu2eQ1DnxseeoOi0D8PnXH5Pbmw0pbJ9vI9+wS4gdsAXVB
        7Cv9pk/18GyUVNqpaZ1fQsU4EOkeNBzIMqEwjMNOQ+EHo8En3zs3r9u/JxtEXjiTbR+9wh
        oYojDbW1tvT0lU1Z0FgcKe11XhiPqEQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 35c9180b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 7 Sep 2022 13:05:24 +0000 (UTC)
Date:   Wed, 7 Sep 2022 15:05:20 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random / hw_random: core: start hwrng kthread also for
 untrusted sources
Message-ID: <YxiXEJ6up6XEW8SM@zx2c4.com>
References: <20220904080247.7890-1-linux@dominikbrodowski.net>
 <Yxg7WQ1UuskDrBVj@gondor.apana.org.au>
 <YxhAEmtVcdvIkX6Q@shine.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxhAEmtVcdvIkX6Q@shine.dominikbrodowski.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 08:54:10AM +0200, Dominik Brodowski wrote:
> Am Wed, Sep 07, 2022 at 02:34:01PM +0800 schrieb Herbert Xu:
> > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > >
> > > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > > index 79d7d4e4e582..b360ed4ece03 100644
> > > --- a/drivers/char/random.c
> > > +++ b/drivers/char/random.c
> > > @@ -867,9 +867,9 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
> > > 
> > >        /*
> > >         * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
> > > -        * we're not yet initialized.
> > > +        * we're not yet initialized or this source isn't trusted.
> > >         */
> > > -       if (!kthread_should_stop() && crng_ready())
> > > +       if (!kthread_should_stop() && (crng_ready() || !entropy))
> > >                schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
> > > }
> > > EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> > 
> > Couldn't you split this bit out?
> 
> I could, but this would need to get merged before the patch to the hwrng
> core gets applied. What do you (and Jason) prefer?

Just split this out and send it to me, and I'll push it early in 6.1 so
that it makes rc1, and then Herbert can apply the hwrng part separately
whenever he sees fit.

Jason
