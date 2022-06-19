Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49676550C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiFSQiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiFSQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF5CE35
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71C87611F5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D473C34114;
        Sun, 19 Jun 2022 16:38:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l8HVtv/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655656695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=diU71W5Zji0OS8EHkoXJCM/nSY6sddKrHCgUQM6n1Ss=;
        b=l8HVtv/yBPyyRv8U2jBpTmIJn0N0hrCeEpBQX9DGo+LLMA0LQ0mX+HKwnx5pYFtdrIICfq
        qN3lpwwHoQUiS9z5t+kU3LoveSq80F57uB2pFpEv7giFWeOlfVfJ+BC20/JWUcKBjOFWir
        cI76+BIIMB7fLH4k+Spo4vDHj6nrzMg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd65de9b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 19 Jun 2022 16:38:14 +0000 (UTC)
Date:   Sun, 19 Jun 2022 18:38:11 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for 5.19-rc3
Message-ID: <Yq9Q84H6HIfkJpoR@zx2c4.com>
References: <165564429738.1413209.17302088152547038708.tglx@xen13>
 <165564429887.1413209.8729918730024457105.tglx@xen13>
 <CAHk-=wgfrUdWBXA-Jx7ZC1x3wwsomou0L6niGgpRS2Hd5rQxyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfrUdWBXA-Jx7ZC1x3wwsomou0L6niGgpRS2Hd5rQxyg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Jun 19, 2022 at 09:50:32AM -0500, Linus Torvalds wrote:
> On Sun, Jun 19, 2022 at 8:12 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > A RT fix for lockdep. lockdep invokes prandom_u32() to create cookies. This
> > worked until prandom_u32() was switched to the real random generator, which
> > takes a spinlock for extraction, which does not work on RT when invoked
> > from atomic contexts. lockdep has no requirement for real random numbers
> > and it turns out sched_clock() is good enough to create the cookie. That
> > works everywhere and is faster.
> 
> So this is obviously fine and works ok, but I do think it highlights
> that maybe that prandom change was a bad bad idea.
> 
> Even outside of RT, you might end up getting nasty locks within locks.
> Not a deadlock, but a "this was just pointless".

This was initially my concern too, which I expressed to Sebastian, but
he made the point that this area here is rather "special". Actually,
randomness isn't really required here. A counter would have worked, but
Peter thought that sched_clock() would be faster than incrementing a
counter. And if it did want some sort of max period generator that's not
sequential, there's still the deterministic prandom_u32_state()
function.

Anyway, if it turns out that this is terrible, and we're running into
issues all over the place, I'll start looking for more comprehensive
solutions. But as long as very special cases are fairly few and rare, it
seems like it's going to be okay. I guess we'll see. For now, I'm
undeterred.

Jason
