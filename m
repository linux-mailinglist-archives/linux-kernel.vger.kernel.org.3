Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0953FE41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbiFGMFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiFGMFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B2BF5524
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6D161725
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FB0C385A5;
        Tue,  7 Jun 2022 12:05:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fLCYiTjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654603502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WX0n+99WwQCrao72endBd42T+qlG0mEcwjlgxCG5GIA=;
        b=fLCYiTjfT0In+Ev5NqH3le5amnEkT8hfhl+zT2eF1rboaPWVOVKjyJJJFNXGG/oXNGnB8c
        EhyFl3ugwhPnJMrPnYC2Qqzr4ek5ey84x7iuKQfZm8wgXext+YgTrE5yU5drFXhQogR6nD
        v/tTdqlpYge3aLZ+JuUeoYsJvzjPafI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a18ded3b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 12:05:01 +0000 (UTC)
Date:   Tue, 7 Jun 2022 14:04:57 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to
 random_init()
Message-ID: <Yp8+6Y+bEcmR1LS0@zx2c4.com>
References: <20220607111514.755009-1-Jason@zx2c4.com>
 <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Jun 07, 2022 at 01:55:37PM +0200, Ard Biesheuvel wrote:
> This is not going to work, I'm afraid - please see below.
>
> The next line says it all, really: the seed is in a firmware table
> somewhere, and only gets mapped temporarily here. Note that we cannot
> copy it either, as we are running way before we have discovered where
> RAM is to begin with.

Oh, darn. Okay. The v2 might be a bit more palpable then. It mixes
immediately, but defers crediting:

[1] https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/

> - Even if very convincing replies can be given to the previous two
> points, wouldn't it be betterr to simply revert the -stable backport
> that introduces the use of the static key, and find a robust and
> portable solution for after v5.19?

This has already been done:

[2] https://lore.kernel.org/stable/20220607084005.666059-1-Jason@zx2c4.com/

And mentioned here:

[3] https://lore.kernel.org/lkml/CAHmME9rJif3ydZuFJcSjPxkGMofZkbu2PXcHBF23OWVgGQ4c+A@mail.gmail.com/

You're on this thread.

> So could we please go back to some basic questions here;
> - Why do we need/want a static key here to begin with? Is is for performance?
> - Why do we need to enable this static key so early?

We don't need to enable it especially early. I've now sent three
different approaches for deferring it until later and you suggested one.
The first of mine is kind of ugly (checking static_key_initialized and
such at different points).  Your suggested one after that did the same
but deferred into crng_reseed(), which I'm not a fan of. My second one
is this patch, which is flawed for the reason you pointed out. But
perhaps my third one is the right amount of simple and okay? That's the
one I linked up top, [1]. Let me know what you think of that.

My motivation for not wanting to defer it is that if the arch solution
winds up being easy and straight forward (as it was for arm64), then it
would be nice to not need to clutter up random.c as a result. But if
the arch solution winds up looking fragile or problematic somehow, then
one of these solutions should do the trick. In particular [1] seems nice
enough that it doesn't really even clutter things up too much as feared.

Jason
