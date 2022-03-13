Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B54D7203
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiCMBCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiCMBCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:02:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6C6D97C;
        Sat, 12 Mar 2022 17:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E5760DC6;
        Sun, 13 Mar 2022 01:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF102C340EB;
        Sun, 13 Mar 2022 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647133254;
        bh=7qM5BLIgTa++H7Yqcfmig2+BtWFIZIZHME5XOXxVHcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+JCVrxcrUWC6IWWIpxemxMKGK4v2nbDrgark4ooq5Rkkpx6JY4YSzbD88NBkr4+n
         H7NLwS0hsWHUZuKjyr/Mc0dZil0ItdX+/6Pj9Xq4Gsk1bxwPuCnOxrIY9gopvPEP1H
         NW8pHxPMazID3k5F0jdhm2g2cntv6K3aWXSM9u0Y7SwbV2R4/cLO2904SEaB5+4Ted
         b5iE3sN6Pqd+BPf/6BHTeJRpkWtlTtbxHHYqjzcaQvvKgac4Y25qoLIf6TnAaCGK61
         GVmISHpXqEx1pQ4VxxnUIn2guWzVVRcN773J/nAWBvVkoSdmbvheTzyfispe62cMaS
         G6manFUN5VMRA==
Date:   Sat, 12 Mar 2022 17:00:53 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: reseed more often immediately after booting
Message-ID: <Yi1CRQ1rdQTxilCc@sol.localdomain>
References: <20220309152653.1244096-1-Jason@zx2c4.com>
 <20220309191850.1508953-1-Jason@zx2c4.com>
 <YimFHeXgw9jfevWq@sol.localdomain>
 <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
 <Yiz4KBqaxURu/6mZ@sol.localdomain>
 <CAHmME9qWp56dBEgXGUPhpPJRBsS0Sq8rZkPHLAHVcLuks+aK8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qWp56dBEgXGUPhpPJRBsS0Sq8rZkPHLAHVcLuks+aK8w@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 05:35:08PM -0700, Jason A. Donenfeld wrote:
> Hey Eric,
> 
> On Sat, Mar 12, 2022 at 12:44 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > I don't think it's strange.  Maybe it seems strange because of how you wrote it
> > ('interval = (5U << fls(uptime / 5)) * HZ'), where the reseed interval suddenly
> > jumps from X to 2*X seconds.  The version I suggested is 'interval = max(5,
> > uptime / 2) * HZ', which is smoother.  It's simply saying that the reseed
> > interval increases as the uptime increases, which seems to be what we want.
> > (Bounded by [5*HZ, CRNG_RESEED_INTERVAL], of course.)
> > What you have now is still better than the status quo, but I'm not sure it's the
> > best way.
> 
> To be clear, I'm not opposed to your suggestion. I just don't
> understand it... yet. I've been playing around with this python script
> to try to "see" what it's doing:
> 
> ```
> #!/usr/bin/env python3
> import sys
> 
> stride = int(sys.argv[1])
> 
> lastyes = 0
> 
> def e(x):
>     return max(5, x / 2)
> 
> def f(x):
>     global lastyes
>     if lastyes + e(x) - x < 0:
>         lastyes = x
>         return True
>     return False
> 
> li = 0
> for i in range(0, 300, stride):
>     if f(i):
>         print(i, i - li)
>         li = i
> ```
> 
> And I can sort of see that for constant calls, it doubles the
> frequency as you'd expect. But I still don't see how this is related
> to system uptime in some definite way. The reason for having a
> heuristic like this in the first place is that we are assuming that
> there's some (inverse) correlation between the need for entropy and
> the system boot time, and another correlation between the availability
> of entropy and the system boot time. I'm just not "getting" how your
> formula correlates to that. I'm not saying it's wrong, but just that I
> might be a bit slow in grasping the relation. Can you give some more
> details on what's happening? I'll continue to stare at it and poke
> around with my python script of course, but if you could help that'd
> be appreciated.

It's just increasing the reseed interval linearly with the uptime, with constant
factor 0.5.  So if the last reseed happened at uptime=t, then the next reseed
will happen on the first request made with uptime >= 2*t.

> 
> Alternatively, I had mentioned and then dismissed the timer approach
> earlier, but actually maybe that'd be not as bad as I originally
> thought? Just having a timer run at 5,10,20,40,80,160 or something
> like that? Do you share my original allergy to that idea, or might
> that actually be an okay way forward?

That seems strictly worse than what you have now (though still better than the
status quo, of course).  The only motivation I can see is if we'd want to avoid
reseeds during the requests themselves for performance reasons.  It seems that
that's not really an issue, though?

- Eric
