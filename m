Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6547F11F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbhLXU4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:56:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbhLXU4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:56:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3942BB8234A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 20:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4577DC36AE5;
        Fri, 24 Dec 2021 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640379404;
        bh=MSzL8BX281RUQPjX6tmbREkMRBM9dD7XbKS/YGZyVic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFerkcZaMhP3pZmML9KmSsRisL9cEZvKkbjQg8M2WyCqz1QbXbgy6927ORFBWDIk7
         MgBSGa3GwxIMXw2Fg7NW4OL6aTBBM4mFPzQ9+NlBYd4Hp6R9/rOcnU3VX/lRhZaGTy
         1YvmtjLNKABVk7L61/r8dGkJwvTXf3MLfmNQAYRdA9BJg8mtUfuAwN1xpbYHpzAECq
         6luqg3ScUs1XxtT2Nb975PcsWdp2hCf0iei6vOtbzKQL4SiYHrygjWYhmehTawdsrf
         mQxW+uzXMiWQGp3oHCygUbliqmnULVdvcCqIPocxqB4VHCwYN+QD/phZ3YWzehghLp
         +6BUz5aBA1MpQ==
Date:   Fri, 24 Dec 2021 14:56:37 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Message-ID: <YcY0BR8cfviTkUqj@quark>
References: <20211223141113.1240679-1-Jason@zx2c4.com>
 <20211223141113.1240679-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223141113.1240679-2-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 03:11:13PM +0100, Jason A. Donenfeld wrote:
> This commit addresses one of the lower hanging fruits of the RNG: its
> usage of SHA1.
> 
> BLAKE2s is generally faster, and certainly more secure, than SHA1, which
> has [1] been [2] really [3] very [4] broken [5]. Additionally, the
> current construction in the RNG doesn't use the full SHA1 function, as
> specified, and allows overwriting the IV with RDRAND output in an
> undocumented way, even in the case when RDRAND isn't set to "trusted",
> which means potential malicious IV choices. And its short length means
> that keeping only half of it secret when feeding back into the mixer
> gives us only 2^80 bits of forward secrecy. In other words, not only is
> the choice of hash function dated, but the use of it isn't really great
> either.
> 
> This commit aims to fix both of these issues while also keeping the
> general structure and semantics as close to the original as possible.
> Specifically:
> 
>    a) Rather than overwriting the hash IV with RDRAND, we put it into
>       BLAKE2's documented "salt" and "personal" fields, which were
>       specifically created for this type of usage.
>    b) Since this function feeds the full hash result back into the
>       entropy collector, we only return from it half the length of the
>       hash, just as it was done before. This increases the
>       construction's forward secrecy from 2^80 to a much more
>       comfortable 2^128.
>    c) Rather than using the raw "sha1_transform" function alone, we
>       instead use the full proper BLAKE2s function, with finalization.
> 
> This also has the advantage of supplying 16 bytes at a time rather than
> SHA1's 10 bytes, which, in addition to having a faster compression
> function to begin with, means faster extraction in general. On an Intel
> i7-11850H, this commit makes initial seeding around 131% faster.
> 
> BLAKE2s itself has the nice property of internally being based on the
> ChaCha permutation, which the RNG is already using for expansion, so
> there shouldn't be any issue with newness, funkiness, or surprising CPU
> behavior, since it's based on something already in use.
> 
> [1] https://eprint.iacr.org/2005/010.pdf
> [2] https://www.iacr.org/archive/crypto2005/36210017/36210017.pdf
> [3] https://eprint.iacr.org/2015/967.pdf
> [4] https://shattered.io/static/shattered.pdf
> [5] https://www.usenix.org/system/files/sec20-leurent.pdf
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Looks good.  I had thought about replacing this with SHA-256, but BLAKE2s is
arguably a better choice here.  You can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

A couple comments about the new development process though:

It seems that you're applying patches to
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git, but that git
repository isn't listed in the MAINTAINERS file entry.  Can you add it?

Also, this patch was only sent to linux-kernel, not to linux-crypto, so I only
found it because I happened to see it in the above git repository, then dig it
up from lore.kernel.org.  How about Cc'ing all random.c patches to linux-crypto,
and putting that in the MAINTAINERS file entry?

- Eric
