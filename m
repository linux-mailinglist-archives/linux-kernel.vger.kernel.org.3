Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EE4CB24E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiCBW2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiCBW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:28:44 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF96E6D90;
        Wed,  2 Mar 2022 14:27:59 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nPXRj-0005os-MI; Thu, 03 Mar 2022 09:27:48 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Mar 2022 10:27:47 +1200
Date:   Thu, 3 Mar 2022 10:27:47 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
References: <YhN76/ONC9qgIKQc@silpixa00400314>
 <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
 <Yh0y75aegqS4jIP7@silpixa00400314>
 <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
 <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+FpKuoyj3G16lK@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 03:56:36PM +0100, Greg KH wrote:
>
> > If not, then these are the patches that should be backported:
> >     7bcb2c99f8ed crypto: algapi - use common mechanism for inheriting flags
> >     2eb27c11937e crypto: algapi - add NEED_FALLBACK to INHERITED_FLAGS
> >     fbb6cda44190 crypto: algapi - introduce the flag CRYPTO_ALG_ALLOCATES_MEMORY
> >     b8aa7dc5c753 crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY
> >     cd74693870fb dm crypt: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY
> > Herbert, correct me if I'm wrong here.
> 
> These need to be manually backported as they do not apply cleanly.  Can
> you provide such a set?  Or should I just disable a specific driver here
> instead which would be easier overall?

I think the safest thing is to disable qat in stable (possibly only
when DM_CRYPT is enabled/modular).  The patches in question while
good may have too wide an effect for the stable kernel series.

Giovanni, could you send Greg a Kconfig patch to do that?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
