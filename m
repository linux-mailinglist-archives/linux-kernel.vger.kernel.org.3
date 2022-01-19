Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153CB493BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355084AbiASOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:15:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60550 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354883AbiASOPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:15:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55828612D9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B380C340E5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:15:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="L+fbt2h7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642601747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZrYuktG/405OOazhE1/qm93iPkP3fHeV2cc5NX3Mzc=;
        b=L+fbt2h7Joe6mU+pvPhFnqvMRRIuRvta5NWy4Ns3KL/QX8Jy+GCTtB/7Ajt9Hn+ilBDWdc
        5vG8OqvtQRz7dqvVog6t3va5GVutOzEi9lpKXAtAR3zRT8SGaQ354rCoOS6kVqKf6w7N9V
        YwIhN7GSLWkA7sLS3vGbLR+rVoF3iqI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 673b86c9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jan 2022 14:15:47 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id m1so7844353ybo.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:15:47 -0800 (PST)
X-Gm-Message-State: AOAM532pQi7CjsimpeczDkoe/Df4FHpOdizpKbq1CgObiUR6nFsLl2n1
        bUcMy4teyuu/RTwISBN5K/yH8B8ppB1m2ua91x4=
X-Google-Smtp-Source: ABdhPJwNuRAg44VMkX8yfdKO+i0A10NNRrzlwM/nHNiJgJwrSB5vM02pu6v+3H0PvI8r/TcBgSGEu5r8PX+4VRHyt7M=
X-Received: by 2002:a25:e90a:: with SMTP id n10mr13825308ybd.245.1642601746930;
 Wed, 19 Jan 2022 06:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20220118164906.402468-1-Jason@zx2c4.com> <CAHk-=wj-DoruDmbAojOJ=VtpZG6piwbRJXO1N1Uq6uX7Q4UVoA@mail.gmail.com>
In-Reply-To: <CAHk-=wj-DoruDmbAojOJ=VtpZG6piwbRJXO1N1Uq6uX7Q4UVoA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 15:15:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9oRZ+JNENWJBDCLrgdtLWWoCh9eRRN9g9AGZGY8P5C1LQ@mail.gmail.com>
Message-ID: <CAHmME9oRZ+JNENWJBDCLrgdtLWWoCh9eRRN9g9AGZGY8P5C1LQ@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator fixes for 5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

On Wed, Jan 19, 2022 at 9:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 18, 2022 at 6:49 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > 1) Some Kconfig changes resulted in BIG_KEYS being unselectable, which Justin
> >    sent a patch to fix.
>
> Ugh. I think the old "don't ask" model was the correct one, and
> BIG_KEYS is probably broken (ie it should just select whatever crypto
> it wants, not depend on people having selected it).

Yea, I agree entirely there. Fixing that was my first inclination,
until I was told to just fix what I broke directly and leave future
changes to Herbert's tree. In general, the lib/crypto stuff is
terribly broken, an unholy mix of cross dependencies between the
cryptoapi and the library code, with little clean separation between
things. My zinc "rewrite" project aimed to fix this all, but alas. So
with everything still held together with bubblegum and scotch tape,
we're still seeing the fallout from the cruft in various ways, this
being one of them. This morning it looks like another thing has been
unearthed, regarding an interaction between a subtle Clang CFI bug and
weak symbols, so unless the compiler people tell me, "oh, let us just
fix that in our experimental CFI implementation", which they may well
might, I may be sending you another patch at some point. Hopefully for
5.18, we can make some headway for actually fixing some of this stuff
up the proper way.

> On a tangential note - looking at the resulting config file, I do note
> that 'CRYPTO_LIB_POLY1305_RSIZE' should probably depend on
> CRYPTO_LIB_POLY1305, because right now that sily thing gets set
> whether POLY1305 is enabled or not.
>
> That was true before too, of course - not related to this pull except
> in the "this caused me to look at the end result" sense.

Noted, thanks.

Jason
