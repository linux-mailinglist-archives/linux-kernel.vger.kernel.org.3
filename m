Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3253FB2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiFGK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbiFGK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7626AB7DF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19368B81ED9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15ECC385A5;
        Tue,  7 Jun 2022 10:28:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NuORGd8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654597692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFatu6W8SBbcaoaZKbQzjLqPuGtYylAXIKGYFtoTLpA=;
        b=NuORGd8LUwfWLNMSn60llHi61VATl0SnqQDJuJEw68mvN6UJ7SgvesMijkmSG/s634trIC
        JFlTzx2wJxqSBfvF+V+hxXfKbrDAcTMZpv4xLSoupQvJl5xmGo9Zyg0y0UAWuVtTBc2pzW
        KP/vGrfkeX3b+iRZRcKxOceq0qbIRp4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1e7bee8b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 10:28:12 +0000 (UTC)
Date:   Tue, 7 Jun 2022 12:28:08 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] random: do not use jump labels before they are
 initialized
Message-ID: <Yp8oOH+9V336LrLk@zx2c4.com>
References: <20220607100210.683136-1-Jason@zx2c4.com>
 <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 12:13:29PM +0200, Ard Biesheuvel wrote:
> Hi Jason,
> 
> On Tue, 7 Jun 2022 at 12:04, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > [ I would like to pursue fixing this more directly first before actually
> >   merging this, but I thought I'd send this to the list now anyway as a
> >   the "backup" plan. If I can't figure out how to make headway on the
> >   main plan in the next few days, it'll be easy to just do this. ]
> >
> 
> What more direct fix did you have in mind here?

A non-broken version of https://lore.kernel.org/lkml/20220603121543.360283-1-Jason@zx2c4.com/

As I mentioned in https://lore.kernel.org/lkml/Yp8kQrBgE3WVqqC5@zx2c4.com/ ,

    I would like a few days to see if there's some trivial way of not
    needing that on arm32. If it turns out to be easy, then I'd prefer the
    direct fix akin to the arm64 one. If it turns out to be not easy, then
    I'll merge the backup commit.

> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 4862d4d3ec49..f9a020ec08b9 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -650,7 +650,8 @@ static void __cold _credit_init_bits(size_t bits)
> >
> >         if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
> >                 crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
> > -               execute_in_process_context(crng_set_ready, &set_ready);
> > +               if (static_key_initialized)
> > +                       execute_in_process_context(crng_set_ready, &set_ready);
> 
> Can we just drop this entirely, and rely on the hunk below to set the
> static key? What justifies having two code paths that set the static
> key in different ways on different architectures?

No, we can't. The hunk below (A) is called from init/main.c some time after
jump_label_init(). The hunk above (B) is called whenever we reach the
256-bit mark.

The order is (B)(A) on machines that get seeded from efi or device tree.
The order is (A)(B) on all other machines, which reach the 256-bit mark
at "some point"... could be after a second, a minute, whenever enough
estimated entropy has been accounted.

Jason
