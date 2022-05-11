Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0C4523406
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiEKNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbiEKNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF22415C6;
        Wed, 11 May 2022 06:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 118ED61C5B;
        Wed, 11 May 2022 13:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD6C34110;
        Wed, 11 May 2022 13:19:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fMVgGYxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652275177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qElqeIMiCpt2DW2B9Regz7BOf6dIMZT/WJ4sQ3WQBvw=;
        b=fMVgGYxUFK6iCopRRRSiI6YyM7GASILDRoJjK1sZM00zDewPblcXT/pj8IsmQ5NtwL/Lps
        DB7Ob+zwrrRmKUX7/iCU5dWl+N2rOezLajdWU+PDw0BmNC7Ld36/pfmqtdgq7MsN0xJlbz
        N4GwxdOgBSoBTKl4O8llQHhS67fZPMs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bffa631a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 11 May 2022 13:19:36 +0000 (UTC)
Date:   Wed, 11 May 2022 15:19:32 +0200
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
Message-ID: <Ynu35I4KMW7gMZW3@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <8f305036248cae1d158c4e567191a957a1965ad1.camel@redhat.com>
 <YnsO1JGQm5FEkbJt@zx2c4.com>
 <f6a4a5ccb126053534bebe4b070fc1384839e919.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6a4a5ccb126053534bebe4b070fc1384839e919.camel@redhat.com>
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

On Wed, May 11, 2022 at 08:59:07AM -0400, Simo Sorce wrote:
> Hi Jason,
> 
> On Wed, 2022-05-11 at 03:18 +0200, Jason A. Donenfeld wrote:
> > My proposal here is made with nonce reuse in mind, for things like
> > session keys that use sequential nonces.
> 
> Although this makes sense the problem is that changing applications to
> do the right thing based on which situation they are in will never be
> done right or soon enough. So I would focus on a solution that makes
> the CSPRNGs in crypto libraries safe.

Please don't dismiss this. I realize you have your one single use case
in mind, but there are others, and the distinction you gave for why we
should dismiss the others to focus on yours doesn't really make any
sense. Here's why:

In my email I pointed out two places where VM forks impact crypto in bad
ways:

- Session keys, wrt nonce reuse.

- Random nonces, wrt nonce reuse.

There are other problems that arise from VM forks too. But these stand
out because they are both quite catastrophic, whether it's duplicated
ECDSA random nonces, or whether it's the same session key used with the
same sequential counter to encrypt different plaintexts with something
like AES-GCM or ChaCha20Poly1305. These are both very, very bad things.

And both things happen in:

- Libraries: crypto lib random number generators (e.g. OpenSSL), crypto
  lib session keys (e.g. any TLS library).

- Applications: application level random number generators (e.g.
  Bitcoin Core *facepalm*), application level session keys (e.g.
  OpenSSH).

So I don't think the "library vs application" distinction is really
meaningful here. Rather, things kind of fall apart all over the place
for a variety of reasons on VM fork.

> > - https://lore.kernel.org/lkml/YnA5CUJKvqmXJxf2@zx2c4.com/
> > - https://lore.kernel.org/lkml/Yh4+9+UpanJWAIyZ@zx2c4.com/
> > - https://lore.kernel.org/lkml/CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com/
> 
> 4c does sound like a decent solution, it is semantically identical to

It does, yeah, but realistically it's never going to happen. I don't
think there's a near- or medium-term chance of changing hypervisor
semantics again. That means for 4-like solutions, there's 4a and 4b.

By the way, that email of mine has inaccuracy in it. I complain about
being in irq context, but it turns out not to be the case; we're inside
of a kthread during the notification, which means we have a lot more
options on what we can do.

If 4 is the solution that appeals to you most, do you want to try your
hand at a RFC patch for it? I don't yet know if that's the best
direction to take, but the devil is kind of in the details, so it might
be interesting to see how it pans out.

Jason
