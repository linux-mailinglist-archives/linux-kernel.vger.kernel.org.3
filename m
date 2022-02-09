Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9284AF0F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiBIMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiBIMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:15 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9255C07684B;
        Wed,  9 Feb 2022 03:16:32 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B5DD820140A;
        Wed,  9 Feb 2022 08:30:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 12E7780554; Wed,  9 Feb 2022 09:23:09 +0100 (CET)
Date:   Wed, 9 Feb 2022 09:23:09 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, ebiggers@kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 4/9] random: ensure early RDSEED goes through mixer on
 init
Message-ID: <YgN57QP5xH9ebrH/@owl.dominikbrodowski.net>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-5-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Feb 09, 2022 at 02:19:14AM +0100 schrieb Jason A. Donenfeld:
> Continuing the reasoning of "random: use RDSEED instead of RDRAND in
> entropy extraction" from this series, at init time we also don't want to
> be xoring RDSEED directly into the crng. Instead it's safer to put it
> into our entropy collector and then re-extract it, so that it goes
> through a hash function with preimage resistance.

Any reason why you re-order

> +	mix_pool_bytes(utsname(), sizeof(*(utsname())));
>  	mix_pool_bytes(&now, sizeof(now));

? It shouldn't matter, but it's an additional change I see no rationale for.

Also, AFAICS, we now only call rdseed 8 times (to mix into the input pool
directly and to update the primary pool indirectly) instead of 8 times (for
the input pool) and 12 times (for initializing the primary pool). That's
still 64 bytes, and we use that to seed 48 bytes, we're still on the safe
side. So feel free to add my

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
