Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FDA4AA7A0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbiBEIXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:23:39 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49406 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiBEIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:23:37 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B00022013AF;
        Sat,  5 Feb 2022 08:23:34 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D016580719; Sat,  5 Feb 2022 08:18:30 +0100 (CET)
Date:   Sat, 5 Feb 2022 08:18:30 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/4] random: simplify entropy debiting
Message-ID: <Yf4kxrXKcRLxOo+E@owl.dominikbrodowski.net>
References: <20220204135325.8327-1-Jason@zx2c4.com>
 <20220204135325.8327-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204135325.8327-3-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Feb 04, 2022 at 02:53:23PM +0100 schrieb Jason A. Donenfeld:
> Our pool is 256 bits, and we only ever use all of it or don't use it at
> all, which is decided by whether or not it has 128 bits in it. So we can

	"has at least"

> drastically simplify the accounting and cmpxchg loop to do exactly this.
> While we're at it, we move the minimum bit size into a constant so it
> can be shared between the two places where it matters.
> 
> The reason we want any of this is for the case in which an attacker has
> compromised the current state, and then bruteforces small amounts of
> entropy added to it. By demanding a particular minimum amount of entropy
> be present before reseeding, we make that bruteforcing difficult.
> 
> Note that this rationale no longer includes anything about /dev/random
> blocking at the right moment, since /dev/random no longer blocks (except
> for at ~boot), but rather uses the crng. In a former life, /dev/random
> was different and therefore required a more nuanced account(), but this
> is no longer.
> 
> Behaviorally, nothing changes here. This is just a simplification of
> the code.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
