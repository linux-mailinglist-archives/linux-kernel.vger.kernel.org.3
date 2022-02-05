Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2CA4AA7A1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbiBEIXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:23:43 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49408 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiBEIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:23:37 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 19CE0201405;
        Sat,  5 Feb 2022 08:23:34 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 718F181241; Sat,  5 Feb 2022 09:23:21 +0100 (CET)
Date:   Sat, 5 Feb 2022 09:23:21 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2 1/4] random: use computational hash for entropy
 extraction
Message-ID: <Yf4z+Rc+69siZ0/N@owl.dominikbrodowski.net>
References: <20220204135325.8327-1-Jason@zx2c4.com>
 <20220204135325.8327-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204135325.8327-2-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Feb 04, 2022 at 02:53:22PM +0100 schrieb Jason A. Donenfeld:
> The current 4096-bit LFSR used for entropy collection had a few
> desirable attributes for the context in which it was created. For
> example, the state was huge, which meant that /dev/random would be able
> to output quite a bit of accumulated entropy before blocking. It was
> also, in its time, quite fast at accumulating entropy byte-by-byte,
> which matters given the varying contexts in which mix_pool_bytes() is
> called. And its diffusion was relatively high, which meant that changes
> would ripple across several words of state rather quickly.
> 
> However, it also suffers from a few security vulnerabilities. In
> particular, inputs learned by an attacker can be undone, but more over,
> if the state of the pool leaks, its contents can be controlled and
> entirely zeroed out. I've demonstrated this attack with this SMT2
> script, <https://xn--4db.cc/5o9xO8pb>, which Boolector/CaDiCal solves in
> a matter of seconds on a single core of my laptop, resulting in little
> proof of concept C demonstrators such as <https://xn--4db.cc/jCkvvIaH/c>.
> 
> For basically all recent formal models of RNGs, these attacks represent
> a significant cryptographic flaw. But how does this manifest
> practically? If an attacker has access to the system to such a degree
> that he can learn the internal state of the RNG, arguably there are
> other lower hanging vulnerabilities -- side-channel, infoleak, or
> otherwise -- that might have higher priority. On the other hand, seed
> files are frequently used on systems that have a hard time generating
> much entropy on their own, and these seed files, being files, often leak
> or are duplicated and distributed accidentally, or are even seeded over
> the Internet intentionally, where their contents might be recorded or
> tampered with. Seen this way, an otherwise quasi-implausible
> vulnerability is a bit more practical than initially thought.
> 
> Another aspect of the current mix_pool_bytes() function is that, while
> its performance was arguably competitive for the time in which it was
> created, it's no longer considered so. This patch improves performance
> significantly: on a high-end CPU, an i7-11850H, it improves performance
> of mix_pool_bytes() by 225%, and on a low-end CPU, a Cortex-A7, it
> improves performance by 103%.
> 
> This commit replaces the LFSR of mix_pool_bytes() with a straight-
> forward cryptographic hash function, BLAKE2s, which is already in use
> for pool extraction. Universal hashing with a secret seed was considered
> too, something along the lines of <https://eprint.iacr.org/2013/338>,
> but the requirement for a secret seed makes for a chicken & egg problem.
> Instead we go with a formally proven scheme using a computational hash
> function, described in sections 5.1, 6.4, and B.1.8 of
> <https://eprint.iacr.org/2019/198>.
> 
> BLAKE2s outputs 256 bits, which should give us an appropriate amount of
> min-entropy accumulation, and a wide enough margin of collision
> resistance against active attacks. mix_pool_bytes() becomes a simple
> call to blake2s_update(), for accumulation, while the extraction step
> becomes a blake2s_final() to generate a seed, with which we can then do
> a HKDF-like or BLAKE2X-like expansion, the first part of which we fold
> back as an init key for subsequent blake2s_update()s, and the rest we
> produce to the caller. This then is provided to our CRNG like usual. In
> that expansion step, we make opportunistic use of 32 bytes of RDRAND

Why are we only using RDRAND here, and not RDSEED?

Thanks,
	Dominik
