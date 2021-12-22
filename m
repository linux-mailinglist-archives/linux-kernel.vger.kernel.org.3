Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF247CCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbhLVGbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhLVGbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:31:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52200C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 22:31:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD7C618BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B83FC36AE5;
        Wed, 22 Dec 2021 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640154661;
        bh=kOC4wWHNwotDFufgc5qAmoRfDRS0MtG/Ry58g//qJNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Flhc3hMIuoPFhMzcN6pCAvjrTONovn+Ke8Dip1zDqYJ+jOtaHvAoF1u0+r20dTRUG
         iAsxEv2XH3FkRX9s4hHYKlimA3yjPIh19uVEVexjmlJTCqPGWgvGObO2ORnMmjqdbc
         pTgmoRulAbGk1Q0TP62/77ZCO7hM4j20sZ5wOC6k=
Date:   Wed, 22 Dec 2021 07:30:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH] random: use BLAKE2s instead of SHA1 in extraction
Message-ID: <YcLGIbWiMH4VudW0@kroah.com>
References: <20211221175047.341782-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221175047.341782-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 06:50:47PM +0100, Jason A. Donenfeld wrote:
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
> i7-11850H, this commit makes calls to RNDRESEEDCRNG around 28% faster.
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
> Reviewed-by: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

0-day build issues asside, this looks sane to me, nice work:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
