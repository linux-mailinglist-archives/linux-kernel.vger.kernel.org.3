Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56DB4A62EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbiBARsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbiBARsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:48:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A8C061714;
        Tue,  1 Feb 2022 09:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFFA61348;
        Tue,  1 Feb 2022 17:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4242C340EB;
        Tue,  1 Feb 2022 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643737729;
        bh=JZhxyRQoCgK0/5LTcb6njVZu9njKhd60rjF5St5t79c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D46ZSZGjaoiX062AM1aeB13pjMaJRvi9+R/zlD1ieL2is5lZWPEk1J5XMc3cMgmeC
         xC5nikkgN0Eko2IKo+zP755wzoYenKTRt9Q+LIf4tYl+64C9kSxNceZLZgd2N4rxVd
         E1ZOj/T4WTMz3xrSpEqeVzre+OsMPWJ9jm/C8fvs=
Date:   Tue, 1 Feb 2022 18:48:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
Message-ID: <Yflyfk8BbGQvN3os@kroah.com>
References: <20220201161342.154666-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201161342.154666-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:13:42PM +0100, Jason A. Donenfeld wrote:
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
> function, described in section B.1.8 of <https://eprint.iacr.org/2019/198>.
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
> output, just as before. We also always reseed the crng with 32 bytes,
> unconditionally, or not at all, rather than sometimes with 16 as before,
> as we don't win anything by limiting beyond the 16 byte threshold.
> 
> Going for a hash function as an entropy collector is a conservative,
> proven approach. The result of all this is a much simpler and much less
> bespoke construction than what's there now, which not only plugs a
> vulnerability but also improves performance considerably.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Reviewed-by: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 232 ++++++++++--------------------------------
>  1 file changed, 55 insertions(+), 177 deletions(-)

Very nice work!

From a "this looks sane by reading the code" type of review here's my:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
