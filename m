Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C915503D4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiFRJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiFRJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:49:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87F71ADBA;
        Sat, 18 Jun 2022 02:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E42DB81ACE;
        Sat, 18 Jun 2022 09:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF79C3411A;
        Sat, 18 Jun 2022 09:49:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="budd/m6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655545764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhUMuTpllhheEJ7+m65w88axtZc2wWONRf5sCgGOqdY=;
        b=budd/m6ouyfEErSl5oT0zAUj/rYDIyTvvIVeswHTWgI6muJ3Vcl3iyXL3VCEP1M/bu5dMy
        zkbXJmdxurRKI1sePxdNxjVxjOvHX9MXH2cj1VoE+zPusoycZGQVgloRt5d6imHvE26hvs
        zAITMNs8o1ESqQ8vj1liHu26tyL4iuE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d2b2e74d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 18 Jun 2022 09:49:24 +0000 (UTC)
Date:   Sat, 18 Jun 2022 11:49:22 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random Remove setting of chacha state to constant values.
Message-ID: <Yq2fohMo90Tk0A/T@zx2c4.com>
References: <CACXcFmmw8bzSr-pmTauMS7a=036eW0=1KLdwAD1MOB_fY-7VRg@mail.gmail.com>
 <Yqr+rFeixFuHzyHD@zx2c4.com>
 <CACXcFmmdrELd8CkwmBQf5-W7PkR=McjcUz9kPDzaCh=NrODKUA@mail.gmail.com>
 <Yq0QOmahm8m018NK@zx2c4.com>
 <CACXcFmma8euek8Z9T6m4jiyD1poyo3WHrLZKuN22sE20hFXNpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACXcFmma8euek8Z9T6m4jiyD1poyo3WHrLZKuN22sE20hFXNpA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 08:38:23AM +0800, Sandy Harris wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > > There is no such argument for
> > > memset(&chacha_state[12], 0, sizeof(u32) * 4);
> > > ChaCha has a counter and a nonce in those
> > > bits, so setting them to zero is a deviation.
> >
> > No. There's a new key each time. So the nonce begins at zero. And the
> > counter begins at zero as well at the beginning like usual. So it's
> > actually a rather boring by-the-books usage of chacha.
> 
> No. ChaCha has a random nonce.

Maybe you're thinking of xchacha? Generally it's not recommended to pick
nonces at random when they're only 64 bits. And it's even not great to
do for 96 bits. In this case here, it doesn't matter, because as
mentioned, the key is fresh each time. But if we're just going by the
book on how people generally use chacha, nonces are typically
sequential.

> > But the larger reason for rejecting your idea wholesale is that I'm
> > trying to enforce the property that input data goes through our hash
> > function (via mix_pool_bytes). Full stop! It's time that this
> > willy-nilly stuff ends where we're feeding in things right and left with
> > no actual design on which is ingesting what input and how it interacts.
> 
> For input data, I agree completely.
> 
> > So if you do think that a particular block of memory somewhere at some
> > point has some entropic value, then by all means call mix_pool_bytes or
> > add_device_randomness on it. But don't try to stuff it in where it
> > doesn't belong.
> 
> This is not input data but more-or-less random state. I'm not trying
> to input it, just to leave it where it belongs rather than overwriting
> it with constants.

What's the difference? If you think you've got some "more or less random
state" that would be useful input as something to influence the rng's
output, call mix_pool_bytes on it. (Also, "more or less random" is
probably not a good way to describe uninitialized stack. It's way less
random than more, and sometimes controllable.)

Sorry, but I'm just not interested in complicating the design with
handwavy things like this.

Jason
