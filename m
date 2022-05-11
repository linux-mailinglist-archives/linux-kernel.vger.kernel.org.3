Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FA5228DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiEKBSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiEKBSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:18:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA1C27CD2;
        Tue, 10 May 2022 18:18:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C44EB81F93;
        Wed, 11 May 2022 01:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F4C385DF;
        Wed, 11 May 2022 01:18:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UfMP+emF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652231895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IsOOzB19/xOUpQ76zC1Vq6dt+kY3RnA9bkLKaUoyaYU=;
        b=UfMP+emF48RhnkR0HZZ9wPYI4O4bBjfUJN8my+5k1pCyRl0c4YlekNCceRptDnpwFeNI1V
        yLKb1cs24st7czkf9YWatfofWW1ee3sF2NEsdICBbkLLh8Lod7V5ER9FSknEpy3AicTmG/
        z7Cjekv7HWSRlrJqMKghWkaTQxMmoa8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d5c8f119 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 11 May 2022 01:18:15 +0000 (UTC)
Date:   Wed, 11 May 2022 03:18:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Simo Sorce <simo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnsO1JGQm5FEkbJt@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <8f305036248cae1d158c4e567191a957a1965ad1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f305036248cae1d158c4e567191a957a1965ad1.camel@redhat.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simo,

On Tue, May 10, 2022 at 08:40:48PM -0400, Simo Sorce wrote:
> At your request teleporting here the answer I gave on a different
> thread, reinforced by some thinking.
> 
> As a user space crypto library person I think the only reasonable
> interface is something like a vDSO.
> 
> Poll() interfaces are nice and all for system programs that have full
> control of their event loop and do not have to react immediately to
> this event, however crypto libraries do not have the luxury of
> controlling the main loop of the application.
> 
> Additionally crypto libraries really need to ensure the value they
> return from their PRNG is fine, which means they do not return a value
> if the vmgenid has changed before they can reseed, or there could be
> catastrophic duplication of "random" values used in IVs or ECDSA
> Signatures or ids/cookies or whatever.
> 
> For crypto libraries it is much simpler to poll for this information 
> than using notifications of any kind given libraries are
> generally not in full control of what the process does.
> 
> This needs to be polled fast as well, because the whole point of
> initializing a PRNG in the library is that asking /dev/urandom all the
> time is too slow (due to context switches and syscall overhead), so
> anything that would require a context switch in order to pull data from
> the PRNG would not really fly.
> 
> A vDSO or similar would allow to pull the vmgenid or whatever epoch
> value in before generating the random numbers and then barrier-style
> check that the value is still unchanged before returning the random
> data to the caller. This will reduce the race condition (which simply
> cannot be completely avoided) to a very unlikely event.

It sounds like your library issue is somewhat similar to what Alex was
talking about with regards to having a hard time using poll in s2n. I'm
still waiting to hear if Amazon figured out some way that this is
possible (with, e.g., a thread). But anyway, it seems like this is
something library authors might hit.

My proposal here is made with nonce reuse in mind, for things like
session keys that use sequential nonces.

A different issue is random nonces. For these, it seems like a call to
getrandom() for each nonce is probably the best bet. But it sounds like
you're interested in a userspace RNG, akin to OpenBSD's arc4random(3). I
hope you saw these threads:

- https://lore.kernel.org/lkml/YnA5CUJKvqmXJxf2@zx2c4.com/
- https://lore.kernel.org/lkml/Yh4+9+UpanJWAIyZ@zx2c4.com/
- https://lore.kernel.org/lkml/CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com/

Each one of those touches on vDSO things quite a bit. Basically, the
motivation for doing that is for making userspace RNGs safe and
promoting their use with a variety of kernel enhancements to make that
easy. And IF we are to ship a vDSO RNG, then certainly this vmgenid
business should be exposed that way, over and above other mechanisms.
It'd make the most sense...IF we're going to ship a vDSO RNG.

So the question really is: should we ship a vDSO RNG? I could work on
designing that right. But I'm a little bit skeptical generally of the
whole userspace RNG concept. By and large they always turn out to be
less safe and more complex than the kernel one. So if we're to go that
way, I'd like to understand what the strongest arguments for it are.

Jason
