Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021994821D5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbhLaDf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:35:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54879 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229590AbhLaDf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:35:28 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BV3ZO0M026478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 22:35:24 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0342A15C33A3; Thu, 30 Dec 2021 22:35:23 -0500 (EST)
Date:   Thu, 30 Dec 2021 22:35:23 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: avoid superfluous call to RDRAND in CRNG
 extraction
Message-ID: <Yc56ey6QKwaYg0yi@mit.edu>
References: <20211230165052.2698-1-Jason@zx2c4.com>
 <Yc4vBfiN529c06kI@mit.edu>
 <CAHmME9reW0Hp=2s73KvFwzg94Uc5QynGDk8t7bAH=q=BRquc4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9reW0Hp=2s73KvFwzg94Uc5QynGDk8t7bAH=q=BRquc4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:58:05PM +0100, Jason A. Donenfeld wrote:
> > Or if we want to improve the security of get_random_bytes() pre
> > crng_ready(), then we should try to XOR RDRAND bytes into all returned
> > buffer from get_random_bytes().  In other words, I'd argue that we
> > should "go big, or go home".  (And if we do have some real,
> > security-critical users of get_random_bytes() pre-crng_ready(), maybe
> > "go big" is the right way to go.
> 
> That's a decent way of looking at it. Rather than dallying with
> 32bits, we may as well go all the way. Or, to compromise on
> efficiency, we could just xor in 16 or 32 bytes into the key rows
> prior to each extraction. Alternatively, we have fewer things to think
> about with the "go home" route, and then it's just a matter of
> important users using get_random_bytes_wait(), which I think I mostly
> took care of through the tree a few years back.

I was too lazy to do an audit of all of the get_random_bytes() users
before I wrote my last e-mail, but I'm good with "go home" route ---
especially since actually doing that full audit to make sure we don't
have any pre-crng_ready() security-critical users of
get_random_bytes() would still be important to do on architectures
like RISC-V that don't have a RDRAND equivalent.

The challenge is here is short of making adding a
WARN_ON(!crng_ready()) to get_random_bytes(), it's hard to be sure
that some future security critical user of get_random_bytes() in early
boot won't creep back in.  And last I checked, we still have some
non-security get_random_bytes() users in early boot where the
WARN_ON() isn't going to be welcome.

> - I would like to see if at some point (not now, just in the future)
> it's feasible, performance wise, to replace all of prandom with
> get_batched_random() and company.

That's going to be challenging, I suspect.  Some of the networking
users of prandom() have some *very* strong performance constraints.
Or at least, the networking developers have some benchmarks where they
won't countenance any performance regressions.  When the prandom
implementation was added, some of the networking devs were positively
doing cycle counting to try to trim it down as much as possible....

						- Ted
