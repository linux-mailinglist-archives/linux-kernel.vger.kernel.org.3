Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405EF4820C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbhL3W6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:58:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34136 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhL3W6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:58:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062E16175F;
        Thu, 30 Dec 2021 22:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0DDC36AE7;
        Thu, 30 Dec 2021 22:58:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lO9j06My"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640905087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+isKFOPChYW4uT91Wd7roEwF3E6d47PP3noE5v3NGJc=;
        b=lO9j06MyGPHHgiw6OxWDdXQVCzlSrr3QyGXN5UttjRjPf0NNOKMlwst6WX3hAVcTjBL+OD
        lXGLL5Rskb1qZnshKuddGBCyveCYo38GedZU9agNTPJP86l8jdJqFqMn+uC8oj+14V8lkY
        jAZyyFKwKrOl6axLj4Hj0XZ0fTUS7vM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 57dcd41b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 22:58:07 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id m19so58521686ybf.9;
        Thu, 30 Dec 2021 14:58:07 -0800 (PST)
X-Gm-Message-State: AOAM533DsDEpQra1vPtofib6PvDOsezvCaJEFnYT1XfAd1+HOe8ugQi1
        TB3UZ76ZO/NgkkWfuLkdpUEQ1vGakyFuawZvxxY=
X-Google-Smtp-Source: ABdhPJziW9jNaXarvMd10MiFTD+8JHEfE3h6htAQtypHP+fbK7H60fHt9ZpWzzGWSg6EBYivl4W3NXapt1c04MDe7Q8=
X-Received: by 2002:a25:938d:: with SMTP id a13mr26620716ybm.457.1640905086217;
 Thu, 30 Dec 2021 14:58:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Thu, 30 Dec 2021
 14:58:05 -0800 (PST)
In-Reply-To: <Yc4vBfiN529c06kI@mit.edu>
References: <20211230165052.2698-1-Jason@zx2c4.com> <Yc4vBfiN529c06kI@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 23:58:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9reW0Hp=2s73KvFwzg94Uc5QynGDk8t7bAH=q=BRquc4A@mail.gmail.com>
Message-ID: <CAHmME9reW0Hp=2s73KvFwzg94Uc5QynGDk8t7bAH=q=BRquc4A@mail.gmail.com>
Subject: Re: [PATCH] random: avoid superfluous call to RDRAND in CRNG extraction
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On 12/30/21, Theodore Ts'o <tytso@mit.edu> wrote:
> but realistically speaking, in
> crng_init_try_arch_early(), which gets called from rand_initialize(),
> we will have already set crng->state[4..15] via RDSEED or RDRAND.
>
> So there's no point in setting crng->state[0] from RDRAND.  So if
> we're wanting to speed things up, we should just remove the
> crng->state[0] <= RDRAND entirely.

Good point, and that seems reasonable. I'll do that for v+1.

> Or if we want to improve the security of get_random_bytes() pre
> crng_ready(), then we should try to XOR RDRAND bytes into all returned
> buffer from get_random_bytes().  In other words, I'd argue that we
> should "go big, or go home".  (And if we do have some real,
> security-critical users of get_random_bytes() pre-crng_ready(), maybe
> "go big" is the right way to go.

That's a decent way of looking at it. Rather than dallying with
32bits, we may as well go all the way. Or, to compromise on
efficiency, we could just xor in 16 or 32 bytes into the key rows
prior to each extraction. Alternatively, we have fewer things to think
about with the "go home" route, and then it's just a matter of
important users using get_random_bytes_wait(), which I think I mostly
took care of through the tree a few years back.

> So I'm not sure we how desperately we *need* the 370% performance improvement

It's not necessary (aside from, like, people using sendfile to erase
NVMes or something weird?), but it appeals to me for two reasons:
- The superfluous RDRAND with only 32bits really isn't doing much, and
having it there makes the design every so slightly more confusing and
less straightforward.
- I would like to see if at some point (not now, just in the future)
it's feasible, performance wise, to replace all of prandom with
get_batched_random() and company. I was on some thread a few years ago
where a researcher pointed out one place prandom was used when
get_random_u64() should have been, and in the ensuing discussion a few
more places were found with the same issue, and then more. And then
nobody could agree on whether the performance hit was worth it for
whichever security model. And in the end I don't recall anything
really happening. If that whole discussion could magicially go away
because we make all uses secure with no performance hit, it'd be a
major win against footguns like prandom. Maybe it won't be feasible in
the end, but simplifying a design in the process of seeing seems like
decent enough motivation.

Jason
