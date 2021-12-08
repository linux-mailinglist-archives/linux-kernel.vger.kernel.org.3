Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7946CE32
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 08:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhLHHUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 02:20:01 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:21580 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhLHHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638947780;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zer9Wm6M9T/aEwxo7eP5PvBiD7v5uvhksWn/IfzxL40=;
    b=QyfBeJI1VweDUXY13rASeoy0hbsTKKJqdm/3nmecvRTh30byFQfBcwz6dHwCYoFIag
    O+TpGLunT7roiTmRnwvAfsLxDSIlwH6ZxhyIB92r0qgJwzpFL2PF4fgJLWLecfXjoT1A
    FLKwJiiAb0TuDsS7UNKDnhw5n1dDettpfUMM+74u56Qur8tyB5ZOp6QX+685EIanKIYk
    LiqTwWRGZX79gTfLHrB9MuEV+Oj7l/CEf8epvPQI47GGhKb+6coza4vnzLpUsVXEkSnL
    6BWbWhtNEjXDpj4ZoM/VW4my130PPBMjZbXqB6vB9MtUH22+PEkAf8EImgCwIYU5K2XG
    +Tlw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJPSf8yic"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.35.1 DYNA|AUTH)
    with ESMTPSA id m07e9dxB87GJ6E7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 8 Dec 2021 08:16:19 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org
Subject: Re: [PATCH 09/18] crypto: dh - implement private key generation primitive
Date:   Wed, 08 Dec 2021 08:16:18 +0100
Message-ID: <4767831.y2tiDqZFiq@tauon.chronox.de>
In-Reply-To: <87pmq7ehxg.fsf@suse.de>
References: <20211201004858.19831-1-nstange@suse.de> <25213093.1r3eYUQgxm@positron.chronox.de> <87pmq7ehxg.fsf@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Dezember 2021, 07:20:43 CET schrieb Nicolai Stange:

Hi Nicolai,

> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * 5.6.1.1.1: choose key length N such that
> >> +	 * 2 * ->max_strength <= N <= log2(q) + 1 = ->p_size * 8 - 1
> >> +	 * with q = (p - 1) / 2 for the safe-prime groups.
> >> +	 * Choose the lower bound's next power of two for N in order to
> >> +	 * avoid excessively large private keys while still
> >> +	 * maintaining some extra reserve beyond the bare minimum in
> >> +	 * most cases. Note that for each entry in safe_prime_groups[],
> >> +	 * the following holds for such N:
> >> +	 * - N >= 256, in particular it is a multiple of 2^6 = 64
> >> +	 *   bits and
> >> +	 * - N < log2(q) + 1, i.e. N respects the upper bound.
> >> +	 */
> >> +	n = roundup_pow_of_two(2 * g->max_strength);
> >> +	WARN_ON_ONCE(n & ((1u << 6) - 1));
> >> +	n >>= 6; /* Convert N into units of u64. */
> > 
> > Couldn't we pre-compute that value for each of the safeprime groups? This
> > value should be static for each of them.
> 
> Can you elaborate why this would be better? As long as the value
> calculated above is considered reasonable for every usecase, I don't see
> the advantage of storing it somewhere.

Well, I usually try to avoid using CPU resources if I have information a-
priori. And as we have only known domain parameters in this code path, I 
thought we can spare a few CPU cycles.

> 
> OTOH, calculating the value on the fly
> - enforces conformance to 5.6.1.1.1 (>= twice the sec strength)
> - and guarantees that it is a multiple of 64 bits, as required
>   by the implementation,
> whereas you'd had to examine each and every individual group's setting
> for correctness when storing precomputed values alongside the other,
> "primary" group parameters.

You are right, but when we reach this code path we only have well-known 
parameters. Hence my suggestion.

Ciao
Stephan



