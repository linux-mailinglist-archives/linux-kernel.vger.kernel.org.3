Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A005500DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383700AbiFQXhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbiFQXhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E7101C;
        Fri, 17 Jun 2022 16:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAE361D55;
        Fri, 17 Jun 2022 23:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD64C3411B;
        Fri, 17 Jun 2022 23:37:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mH1mOeyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655509051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HcY8feozlb/iCMaAqa0x3x7SwlLLCwcos88Sao/FquI=;
        b=mH1mOeyVMPct2R8r2l783spD8uc0JkMPncFYg+38d2wfNoup/6Zkfu9HU49vv9zaSekhnk
        dyy7cnoRngHab8ToVlPHHsshTFIXk4xJwyooWBPYZI/02w5YgDL6oNBlvdVyG0hyqXKOlg
        52NtrcZ6z7msBzLFdXM7K4qdGoA2bNc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1c615cb4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 17 Jun 2022 23:37:31 +0000 (UTC)
Date:   Sat, 18 Jun 2022 01:37:30 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random Remove setting of chacha state to constant values.
Message-ID: <Yq0QOmahm8m018NK@zx2c4.com>
References: <CACXcFmmw8bzSr-pmTauMS7a=036eW0=1KLdwAD1MOB_fY-7VRg@mail.gmail.com>
 <Yqr+rFeixFuHzyHD@zx2c4.com>
 <CACXcFmmdrELd8CkwmBQf5-W7PkR=McjcUz9kPDzaCh=NrODKUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACXcFmmdrELd8CkwmBQf5-W7PkR=McjcUz9kPDzaCh=NrODKUA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 07:17:00AM +0800, Sandy Harris wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> > ChaCha is a permutation that requires those constants.
> 
> No. The actual permutation does not use the constants.
> They are used in setting up the state & directly affect
> only the first round. The other 19 rounds do not use
> the constants; they operate on the more-or-less random
> state left by the previous round.

I guess. But that just seems like all the more reason to stick with the
constants in that first round, as chacha lacks round constants like
"hermetic" permutations. Better to give less control over that initial
state. Anyway, we're not going to veer off into lala land and redesign
chacha on lkml.

> There is no such argument for
> memset(&chacha_state[12], 0, sizeof(u32) * 4);
> ChaCha has a counter and a nonce in those
> bits, so setting them to zero is a deviation.

No. There's a new key each time. So the nonce begins at zero. And the
counter begins at zero as well at the beginning like usual. So it's
actually a rather boring by-the-books usage of chacha.

> Dropping the memset() and using whatever
> the existing state has there may not be ideal,
> but it is certainly better than the zeroes.

I'm not so sure about that. For starters, it means that we'll never
actually exceed the first 32 bits, and so the branch for the increment
of the next word is never true, which has some tiny value. And as for
the nonce, I'd like to reserve that for whatever interesting use comes
up in the future (like using the cpu number or something in an
interesting parallel design).

But the larger reason for rejecting your idea wholesale is that I'm
trying to enforce the property that input data goes through our hash
function (via mix_pool_bytes). Full stop! It's time that this
willy-nilly stuff ends where we're feeding in things right and left with
no actual design on which is ingesting what input and how it interacts.
So if you do think that a particular block of memory somewhere at some
point has some entropic value, then by all means call mix_pool_bytes or
add_device_randomness on it. But don't try to stuff it in where it
doesn't belong.

The type of valuable patch I'd like to encourage is this recent one from
LinusW: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac9d25557dcc9fe90ed12bfbb6db401e892ca004
This seems like the kind of thing that might really help the situation
on certain devices in a real way. More of that! Less of fake crypto.

Jason
