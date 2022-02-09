Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385684AECA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiBIIhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:37:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiBIIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:36:56 -0500
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 00:36:54 PST
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8187C03649A;
        Wed,  9 Feb 2022 00:36:54 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D5DEB20142F;
        Wed,  9 Feb 2022 08:31:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id BA0348033A; Wed,  9 Feb 2022 07:18:42 +0100 (CET)
Date:   Wed, 9 Feb 2022 07:18:42 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, ebiggers@kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 1/9] random: use RDSEED instead of RDRAND in entropy
 extraction
Message-ID: <YgNcwjH/XG7o4z6Y@owl.dominikbrodowski.net>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Feb 09, 2022 at 02:19:11AM +0100 schrieb Jason A. Donenfeld:
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
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
