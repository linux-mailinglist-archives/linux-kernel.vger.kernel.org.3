Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E185C4D709A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiCLTpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiCLTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:45:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F71F1D0F;
        Sat, 12 Mar 2022 11:44:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F302B8009F;
        Sat, 12 Mar 2022 19:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08EDC340EB;
        Sat, 12 Mar 2022 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647114282;
        bh=QoeCE1AMflsi0jNLsirge94ZLm5l276p10BwoRsSZA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+NH3Rz2tqPYL+F2PTyuS4ZRNoR+wQvhcO3nUx6iU1kqLi8WKRXorsTbSDY7VAoDJ
         melaWzpJdzqwBui3FvTKDpQvCF8QUwuOd3jX81wr4fx1ldJcbB2DqOWl78GOybAzgb
         masvm5pV6CI920SZ8V91Zp0MI2xS2FG+QziS5PmGK09RdZAhMJbpZyTRn1MF6gRHBU
         I/ULSKkT/FZ85co3HG6+Icvl6loZkSXerAqwTYkfp/4x0Zhyos4EGlkJxoFjq772Rk
         uCXLNSnjf3E/YFVnszuBKl3O6st5V1kmBfKLyjSibbROUGPprIlLcmqc2cuDFcxY1h
         0dbbg+FglIthw==
Date:   Sat, 12 Mar 2022 11:44:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: reseed more often immediately after booting
Message-ID: <Yiz4KBqaxURu/6mZ@sol.localdomain>
References: <20220309152653.1244096-1-Jason@zx2c4.com>
 <20220309191850.1508953-1-Jason@zx2c4.com>
 <YimFHeXgw9jfevWq@sol.localdomain>
 <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:59:05PM -0700, Jason A. Donenfeld wrote:
> > However, one thing that seems a bit odd is that this method can result in two
> > reseeds with very little time in between.  For example, if no one is using the
> > RNG from second 40-78, but then it is used in seconds 79-80, then it will be
> > reseeded at both seconds 79 and 80 if there is entropy available.
> 
> I've been sort of going back and forth on this. I think the idea is
> that there are two relative time measurements. The ordinary one we use
> is time since last reseeding. But at boot, we're trying to account for
> the fact that entropy is coming in relative to the init process of the
> system, which means we need it to be relative to boot time rather than
> relative to the last reseeding. As you point out, this is a little
> wonky with how things are now, because we only ever reseed on usage.
> To get closer to what I have in mind, we could reseed in a timer, so
> that it hits it exactly on the 5,10,20,40,etc dot. But that seems a
> bit cumbersome and maybe unnecessary. The effect of the behavior of
> this v1 you pointed out is:
> 
> - We might reseed at 79, and then fail to reseed at 80. Consequence:
> we lose 1 second of entropy that could have made it for that try.
> - We might reseed at 79, and then also reseed at 80 too. Consequence:
> that's a fairly quick refresh, but on the other hand, we're still
> requiring 256 bit credits, so maybe not so bad, and if we've got so
> much entropy coming in during that small period of time, maybe it
> really isn't a concern.
> 
> So I'm not sure either of these cases really matter that much.
> 
> > Perhaps the condition should still be:
> >
> >         time_after(jiffies, READ_ONCE(base_crng.birth) + interval);
> >
> > ... as it is in the non-early case, but where 'interval' is a function of
> > 'uptime' rather than always CRNG_RESEED_INTERVAL?  Maybe something like:
> >
> >         interval = CRNG_RESEED_INTERVAL;
> >         if (uptime < 2 * CRNG_RESEED_INTERVAL / HZ)
> >                 interval = max(5, uptime / 2) * HZ;
> 
> I'd experimented with things like that, for example making it exponential:
> 
>   static bool early_boot = true;
>   unsigned long interval = CRNG_RESEED_INTERVAL;
> 
>   if (unlikely(READ_ONCE(early_boot))) {
>     unsigned int uptime = min_t(u64, INT_MAX, ktime_get_seconds());
>     if (uptime >= CRNG_RESEED_INTERVAL / HZ)
>       WRITE_ONCE(early_boot, false);
>     else
>       interval = (5U << fls(uptime / 5)) * HZ;
>   }
>   return time_after(jiffies, READ_ONCE(base_crng.birth) + interval);
> 
> But the whole thing of combining relative-to-last-reseed with
> relative-to-boottime seems really strange. I'm not quite sure what
> that's supposed to represent, whereas what I have in v1 is
> "exponentially increasing intervals from boottime" which is fairly
> easy to understand.

I don't think it's strange.  Maybe it seems strange because of how you wrote it
('interval = (5U << fls(uptime / 5)) * HZ'), where the reseed interval suddenly
jumps from X to 2*X seconds.  The version I suggested is 'interval = max(5,
uptime / 2) * HZ', which is smoother.  It's simply saying that the reseed
interval increases as the uptime increases, which seems to be what we want.
(Bounded by [5*HZ, CRNG_RESEED_INTERVAL], of course.)

Your current patch interacts badly with how crng_reseed() is a no-op if fewer
than 256 entropy bits are available.  Suppose that random bytes are requested at
seconds 10 and 15, and at second 10 there are 200 entropy bits available and at
second 15 there are 256.  With your current patch, the CRNG wouldn't be reseeded
before either request, since the no-op reseed at second 10 would consume the
only attempt for the whole interval of 10-19.  I.e. the request at second 10
would actually be preventing the CRNG from being reseeded when it should be.

Using an interval since the actual last reseed time (base_crng.birth) avoids
this quirk, as well the one I mentioned before where two reseeds can be done
with very little time in between.

What you have now is still better than the status quo, but I'm not sure it's the
best way.

- Eric
