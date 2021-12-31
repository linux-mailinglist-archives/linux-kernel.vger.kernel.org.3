Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2E48254A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhLaRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:13:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57771 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229699AbhLaRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:13:54 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BVHDnDf032136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 12:13:49 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D305F15C33A3; Fri, 31 Dec 2021 12:13:48 -0500 (EST)
Date:   Fri, 31 Dec 2021 12:13:48 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] random: avoid superfluous call to RDRAND in CRNG
 extraction
Message-ID: <Yc86TIah3w4waDEc@mit.edu>
References: <Yc56ey6QKwaYg0yi@mit.edu>
 <20211231114903.60882-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231114903.60882-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 12:49:03PM +0100, Jason A. Donenfeld wrote:
> RDRAND is not fast. RDRAND is actually quite slow. We've known this for
> a while, which is why functions like get_random_u{32,64} were converted
> to use batching of our ChaCha-based CRNG instead.
> 
> Yet CRNG extraction still includes a call to RDRAND, in the hot path of
> every call to get_random_bytes(), /dev/urandom, and getrandom(2).
> 
> This call to RDRAND here seems quite superfluous. CRNG is already
> extracting things based on a 256-bit key, based on good entropy, which
> is then reseeded periodically, updated, backtrack-mutated, and so
> forth. The CRNG extraction construction is something that we're already
> relying on to be secure and solid. If it's not, that's a serious
> problem, and it's unlikely that mixing in a measly 32 bits from RDRAND
> is going to alleviate things.
> 
> And in the case where the CRNG doesn't have enough entropy yet, we're
> already initializing the ChaCha key row with RDRAND in
> crng_init_try_arch_early().
> 
> Removing the call to RDRAND improves performance on an i7-11850H by
> 370%. In other words, the vast majority of the work done by
> extract_crng() prior to this commit was devoted to fetching 32 bits of
> RDRAND.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
