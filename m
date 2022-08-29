Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB885A53C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiH2SIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiH2SIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:08:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7043E8A6D3;
        Mon, 29 Aug 2022 11:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E69961329;
        Mon, 29 Aug 2022 18:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49751C433D6;
        Mon, 29 Aug 2022 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661796500;
        bh=h41PGKQB9pe7pe7VyewCaeAHUyzSkkZqPJT6d53vlas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQIJM+CIH2z7ZKFBpr8qKbXq6K/s7cUzt0xjb2LDDtMydJCn1LULT+0J/eTO8Dt8o
         V2fkODXOq1xIJ/RPfEnq/dZ1aBNLyuo7G574J8g3pf+dU3RYCMii0txmwPp/KQJLr9
         iOV9M+RJyZRDF+Rh2fXBgcsUEZl0VhBMeOT/gv2TVhyCj7Jjft5DNztnpXDYd9KhHH
         Alg9PzPSmPM3eoNZ4cohMvxmlcJTtCG4dAYfPqt04Pd+PhbMOm8Uxl1s+VhqIC6VKI
         WF/pmCD6WHGwEzAU3R53YV2gGHIJ2+odLpC9gDNHngd8HVnKYJ9zVMLmeQ2vgz2FF5
         IhPc/JGj6NQ1A==
Date:   Mon, 29 Aug 2022 18:08:07 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Langley <agl@google.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <Yw0Ah5m/2HDDvCjS@gmail.com>
References: <YwgCrqutxmX0W72r@gmail.com>
 <Ywzr2d52ixYXUDWR@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ywzr2d52ixYXUDWR@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:39:53PM -0400, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Thu, Aug 25, 2022 at 11:15:58PM +0000, Eric Biggers wrote:
> > I'm wondering if people are aware of this issue, and whether anyone has any
> > thoughts on whether/where the kernel should be setting these new CPU flags.
> > There don't appear to have been any prior discussions about this.  (Thanks to
> 
> Maybe it should be set unconditionally now, until we figure out how to
> make it more granular.
> 
> In terms of granularity, I saw other folks suggesting making it per-task
> (so, presumably, a prctl() knob), and others mentioning doing it just
> for kernel crypto. For the latter, I guess the crypto API could set it
> inside of its abstractions, and the various lib/crypto APIs could set it
> at invocation time. I wonder, though, what's the cost of
> enabling/disabling it? Would we in fact need a kind of lazy-deferred
> disabling, like we have with kernel_fpu_end()? I also wonder what
> crypto-adjacent code might wind up being missed if we're going function
> by function. Like, obviously we'd set this for crypto_memneq, but what
> about potential unprotected `==` of ID numbers that could leak some info
> in various protocols? What other subtle nearby code should we be
> thinking about, that relies on constant time logic but isn't neatly
> folded inside a crypto_do_something() function?
> 

I'd much prefer it being set unconditionally by default as well, as making
everyone (both kernel and userspace) turn it on and off constantly would be a
nightmare.

Note that Intel's documentation says that CPUs before Ice Lake behave as if
DOITM is always set:

    "For Intel® Core™ family processors based on microarchitectures before Ice
    Lake and Intel Atom® family processors based on microarchitectures before
    Gracemont that do not enumerate IA32_UARCH_MISC_CTL, developers may assume
    that the instructions listed here operate as if DOITM is enabled."

(It's a bit ambiguous, as it leaves the door open to IA32_UARCH_MISC_CTL being
retroactively added to old CPUs.  But I assume that hasn't actually happened.)

So I think the logical approach is to unconditionally set DOITM by default, to
fix this CPU bug in Ice Lake and later and just bring things back to the way
they were in CPUs before Ice Lake.  With that as a baseline, we can then discuss
whether it's useful to provide ways to re-enable this CPU bug / "feature", for
people who want to get the performance boost (if one actually exists) of data
dependent timing after carefully assessing the risks.

The other way around, of making everything insecure by default, seems like a
really bad idea.

- Eric
