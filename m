Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41E2480134
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbhL0Pyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:54:39 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37976 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240427AbhL0PwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:52:21 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BRFqHSM026768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 10:52:17 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 28C7C15C33A3; Mon, 27 Dec 2021 10:52:17 -0500 (EST)
Date:   Mon, 27 Dec 2021 10:52:17 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Message-ID: <YcnhMS4Pgetififz@mit.edu>
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

Looks good, thanks for the work!

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
