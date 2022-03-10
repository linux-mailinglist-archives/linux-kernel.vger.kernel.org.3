Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC24D407A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiCJE6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiCJE6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:58:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89927129BA3;
        Wed,  9 Mar 2022 20:57:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3174B61896;
        Thu, 10 Mar 2022 04:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661A6C340E8;
        Thu, 10 Mar 2022 04:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646888223;
        bh=sEoNxS48+LdNVopEd+xJ9fpcww2zVEVjHJ2k8Sav3cM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/I1LSXcpG3lufHtkak42401t4aTHeoFg4tT+Sxd6/nt+NOk8DykuYdN/CYtaTzaX
         JgwPBeT51jajGF14/XeWnp2OG6PyYWS8svtUtJAxmXmp9JUxp+lUAUElVwLuhe+AKw
         siZR9Vl4zxhfQsrDN9tcqpsl48cZTrFiI+RQ7CN9OaZXicjvalC6pfouQYd3N4ppLJ
         wfG3jJlgsCqOC3iebx4SSF3ZVD2D1UlbvsAWxlJXRMqtL9vjPruFpYimoXPYbowVKZ
         L+NpnPArcGLkES9WJqEe+H50B0AFB42ttpVg+c1fpglu3LckDiBREV16QtNg3RJm6t
         MkSMEPrFFPdyw==
Date:   Wed, 9 Mar 2022 20:57:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: reseed more often immediately after booting
Message-ID: <YimFHeXgw9jfevWq@sol.localdomain>
References: <20220309152653.1244096-1-Jason@zx2c4.com>
 <20220309191850.1508953-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309191850.1508953-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, Mar 09, 2022 at 12:18:50PM -0700, Jason A. Donenfeld wrote:
> In order to chip away at the "premature first" problem, we augment our
> existing entropy accounting with increased reseedings at boot.

I'm very glad to see this; this is something that I've been concerned about.
I think this is basically the right solution until something more sophisticated
can be implemented (as you said).

A few comments below.

> The idea
> is that at boot, we're getting entropy from various places, and we're
> not very sure which of early boot entropy is good and which isn't. Even
> when we're crediting the entropy, we're still not totally certain that
> it's any good. Since boot is the one time (aside from a compromise) that
> we have zero entropy, it's important that we shephard entropy into the
> crng fairly often. At the same time, we don't want a "premature next"
> problem, whereby an attacker can brute force individual bits of added
> entropy. In lieu of going full-on Fortuna (for now), we can pick a
> simpler strategy of just reseeding more often during the first 5 minutes
> after boot. This is still bounded by the 256-bit entropy credit
> requirement, so we'll skip a reseeding if we haven't reached that, but
> in case entropy /is/ coming in, this ensures that it makes its way into
> the crng rather rapidly during these early stages. For this we start at
> 5 seconds after boot, and double that interval until it's more than 5
> minutes. After that, we then move to our normal schedule of reseeding
> not more than once per 5 minutes.

Break up the above into multiple paragraphs?

> +/*
> + * Return whether the crng seed is considered to be sufficiently
> + * old that a reseeding might be attempted. This is the case 5,
> + * 10, 20, 40, 80, and 160 seconds after boot, and after if the
> + * last reseeding was CRNG_RESEED_INTERVAL ago.
> + */
> +static bool crng_has_old_seed(void)
> +{
> +	static unsigned int next_init_secs = 5;
> +
> +	if (unlikely(next_init_secs < CRNG_RESEED_INTERVAL / HZ)) {

The read of 'next_init_secs' needs READ_ONCE(), since it can be written to
concurrently.

> +		unsigned int uptime = min_t(u64, INT_MAX, ktime_get_seconds());
> +		if (uptime >= READ_ONCE(next_init_secs)) {
> +			WRITE_ONCE(next_init_secs, 5U << fls(uptime / 5));
> +			return true;
> +		}
> +		return false;

The '5U << fls(uptime / 5)' expression is a little hard to understand, but it
appears to work as intended.

However, one thing that seems a bit odd is that this method can result in two
reseeds with very little time in between.  For example, if no one is using the
RNG from second 40-78, but then it is used in seconds 79-80, then it will be
reseeded at both seconds 79 and 80 if there is entropy available.

Perhaps the condition should still be:

	time_after(jiffies, READ_ONCE(base_crng.birth) + interval);

... as it is in the non-early case, but where 'interval' is a function of
'uptime' rather than always CRNG_RESEED_INTERVAL?  Maybe something like:

	interval = CRNG_RESEED_INTERVAL;
	if (uptime < 2 * CRNG_RESEED_INTERVAL / HZ)
		interval = max(5, uptime / 2) * HZ;

- Eric
