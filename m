Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B693F4CA89E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbiCBO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiCBO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:57:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D6B48396;
        Wed,  2 Mar 2022 06:56:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D761E61666;
        Wed,  2 Mar 2022 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA49C004E1;
        Wed,  2 Mar 2022 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646232999;
        bh=Mi9q+LtieiMun2ocnCwKvyOxp+6VG4htF2rkds+fAQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufYPWrZbvXBD/NeSNuQz19nBhfwAGhijZ9tRMN/rue6/lWQxOHlIsLST366pfuDxm
         f7GRuQ1s+ZrXZlgePnpz4cbU0IOQMu3B4ruSuZfSBLXD3tokBdgZbhtsl033uhE7Vg
         7uF6KajeDwWHh9R2VhoS985ryxkpaiJVHTFO7um8=
Date:   Wed, 2 Mar 2022 15:56:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <Yh+FpKuoyj3G16lK@kroah.com>
References: <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
 <YhN76/ONC9qgIKQc@silpixa00400314>
 <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
 <Yh0y75aegqS4jIP7@silpixa00400314>
 <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
 <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh9ZvLHuztwQCu0d@silpixa00400314>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 11:49:16AM +0000, Giovanni Cabiddu wrote:
> Hi Greg,
> 
> On Wed, Mar 02, 2022 at 11:29:00AM +0100, Greg KH wrote:
> > On Tue, Mar 01, 2022 at 04:11:13PM +1200, Herbert Xu wrote:
> > > On Mon, Feb 28, 2022 at 05:12:20PM -0800, Linus Torvalds wrote:
> > > > 
> > > > It sounds like it was incidental and almost accidental that it fixed
> > > > that thing, and nobody realized it should perhaps be also moved to
> > > > stable.
> > > 
> > > Yes this was incidental.  The patch in question fixes an issue in
> > > OOM situations where drivers that must allocate memory on each
> > > request may lead to dead-lock so it's not really targeted at qat.
> > 
> > Ok, so what commits should I backport to kernels older than 5.10 to
> > resolve this?
> Is it possible to wait for a set that resolves the problem rather than
> backporting the patches that disables the use-case?

It's already disabled in newer kernels, so we should do so for older
ones to prevent problems and the delay in getting those potential fixes
merged some day in the future.

> I have a patchset that fixes the actual issue and we are doing an
> internal review before submission to the mailing list.
> I should be able to send a V1 out between today and tomorrow.
> 
> If not, then these are the patches that should be backported:
>     7bcb2c99f8ed crypto: algapi - use common mechanism for inheriting flags
>     2eb27c11937e crypto: algapi - add NEED_FALLBACK to INHERITED_FLAGS
>     fbb6cda44190 crypto: algapi - introduce the flag CRYPTO_ALG_ALLOCATES_MEMORY
>     b8aa7dc5c753 crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY
>     cd74693870fb dm crypt: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY
> Herbert, correct me if I'm wrong here.

These need to be manually backported as they do not apply cleanly.  Can
you provide such a set?  Or should I just disable a specific driver here
instead which would be easier overall?

thanks,

greg k-h
