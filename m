Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ED0576C17
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiGPFti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGPFtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:49:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD32C12F;
        Fri, 15 Jul 2022 22:49:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0B81B82F4B;
        Sat, 16 Jul 2022 05:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348A6C34114;
        Sat, 16 Jul 2022 05:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657950569;
        bh=PbYS1IT07DRr1aFDMtz48vqEJCogazv7l2o/rc3joxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4HGNNmkE4vganx+xVEu/xTnkA7nYQfR6tR36YiYjEMEREKWz6Q2eOxhQ2UPCP9iS
         v4KRmSGLU+xUdPckIPNOrHpZCVazHw5NHPJlPgirhySEF8Z6ZRGH3PJ2JSh8UYk9bo
         NICNCz5MFyU5+2RTvVSr/SKXNTHukPBWqpHSS+bbiLY23iwmlKS8kKtN4cvSb07UQD
         IW48BlilYuueBuZ5/CTo5NzXU6EBcsIyUMbrWi7XHPl/mtMlY7bU8qROcY4lvsyLIL
         pr0QoBq/P1q45Uisgwj2su/UCJVsxxWe5cfjOGXXWexNNxeJ8s0+0ZmIxcv9iSJ4h/
         FOvlrA0k6Rw5Q==
Date:   Fri, 15 Jul 2022 22:49:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: lib/arc4 - expose library interface
Message-ID: <YtJRZw105wF+PZeZ@sol.localdomain>
References: <20220714051221.22525-1-ansuelsmth@gmail.com>
 <YtDLMmwffn6p/rSV@sol.localdomain>
 <872b3792d96946b48236120a057b99bc@AcuMS.aculab.com>
 <62d1275e.1c69fb81.f16fe.51e0@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d1275e.1c69fb81.f16fe.51e0@mx.google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 04:10:49AM +0200, Christian Marangi wrote:
> On Fri, Jul 15, 2022 at 07:39:48AM +0000, David Laight wrote:
> > From: Eric Biggers
> > > Sent: 15 July 2022 03:05
> > > 
> > > On Thu, Jul 14, 2022 at 07:12:21AM +0200, Christian Marangi wrote:
> > > > Permit to compile the arc4 crypto lib without any user. This is required
> > > > by the backports project [1] that require this lib for any wireless
> > > > driver.
> > > >
> > > > [1] https://backports.wiki.kernel.org/index.php/Main_Page
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  lib/crypto/Kconfig | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> > > > index 2082af43d51f..2dfc785a7817 100644
> > > > --- a/lib/crypto/Kconfig
> > > > +++ b/lib/crypto/Kconfig
> > > > @@ -6,7 +6,11 @@ config CRYPTO_LIB_AES
> > > >  	tristate
> > > >
> > > >  config CRYPTO_LIB_ARC4
> > > > -	tristate
> > > > +	tristate "ARC4 library interface"
> > > > +	help
> > > > +	  Enable the ARC4 library interface. This interface is mainly
> > > > +	  used by wireless drivers and is required by the backports
> > > > +	  project.
> > > >
> > > >  config CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> > > >  	bool
> > > 
> > > I don't think this is appropriate for upstream, as the upstream kernel doesn't
> > > support out-of-tree code.  This is also an internal API that can change from one
> > > kernel version to the next.
> > 
> > Out-of-tree code always has to allow for arbitrary changes to
> > kernel interfaces between kernel versions.
> > So the fact that the API might change isn't relevant.
> > The continual API changes keep some of us in a job :-)
> > 
> > (It has to be said that if I needed RC4 I'd probably add a local copy.)
> >
> 
> Wonder if I can ask you some advice about the topic... I understand that
> this cannot be merged upstream.
> 
> So the correct solution would be having a copy of the arc4 lib in
> backports?
> 

In general you're going to need to change the kernel anyway, in which case you
can just patch your kernel to expose this option.

If you can't patch your kernel, then yes you'd need to have your own copy of the
arc4 lib.  Of course, that would only be a workaround for the arc4 lib.  You may
run into other things that have no workaround.  You need to accept that what
you're trying to do will sometimes be impossible without kernel changes.

- Eric
