Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3B4AE534
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiBHXHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiBHXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B6EC061576;
        Tue,  8 Feb 2022 15:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB26BB81D15;
        Tue,  8 Feb 2022 23:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C2C340ED;
        Tue,  8 Feb 2022 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644361645;
        bh=L4k/srAhw9AuTrpWegTohSDP66SMe5MK538ECj9wpYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jl+kudIu+dYHRMx4t2Sn/sg0eij0lkiu9ywDCP6ZNX0F2MfKn1ljhD9MzmZO6zRG/
         i4YbWAFceFyncEtHV2NrbYwCQnuYS48QLaD84XlnAaVPhZqLDjjw9x/4/nmSt1Glwd
         v1UNaDtPvH7xZ7bBJG/gizvKcePFDny5hO2pzrqZatN83X8UBiZoM2B8XSSGkgNTYf
         0yYS19JccU8HNVEHhXEiFXbnIDuh20TOShCO8eJyeDANyUr7D4h+gBraxTb/HcFjqR
         uP36lHUQqQQzOIyW+CHd1gESCwOyHzxGM6tmyYSVQARlYWM/BCMrBAvqu3H7O8a/9I
         nOMmFFNASygDw==
Date:   Tue, 8 Feb 2022 15:07:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v1 1/7] random: use RDSEED instead of RDRAND in entropy
 extraction
Message-ID: <YgL3oCXDPB8dEUlU@sol.localdomain>
References: <20220208155335.378318-1-Jason@zx2c4.com>
 <20220208155335.378318-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208155335.378318-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:53:29PM +0100, Jason A. Donenfeld wrote:
> When /dev/random was directly connected with entropy extraction, without
> any expansion stage, extract_buf() was called for every 10 bytes of data
> read from /dev/random. For that reason, RDRAND was used rather than
> RDSEED. At the same time, crng_reseed() was still only called every 5
> minutes, so there RDSEED made sense.
> 
> Those olden days were also a time when the entropy collector did not use
> a cryptographic hash function, which meant most bets were off in terms
> of real preimage resistance. For that reason too it didn't matter
> _that_ much whether RDSEED was mixed in before or after entropy
> extraction; both choices were sort of bad.
> 
> But now we have a cryptographic hash function at work, and with that we
> get real preimage resistance. We also now only call extract_entropy()
> every 5 minutes, rather than every 10 bytes. This allows us to do two
> important things.
> 
> First, we can switch to using RDSEED in extract_entropy(), as Dominik
> suggested. Second, we can ensure that RDSEED input always goes into the
> cryptographic hash function with other things before being used
> directly. This eliminates a category of attacks in which the CPU knows
> the current state of the crng and knows that we're going to xor RDSEED
> into it, and so it computes a malicious RDSEED. By going through our
> hash function, it would require the CPU to compute a preimage on the
> fly, which isn't going to happen.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
