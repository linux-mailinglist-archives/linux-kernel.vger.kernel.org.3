Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DFF48358A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiACR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:26:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58518 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiACR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:26:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A5776118F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 17:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882ADC36AED
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 17:26:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mCFy7wTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641230812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ixG3K0VqFW+/w9u92E25Dj3Tibd0n4kLzMuSOVvn1kg=;
        b=mCFy7wTxWpafM7F3f32ZHpRD/i+CZBFjoNJ8d2udSm1LElECkrR+N4+7w9UmA/h51uMys0
        XvH1lltwVLBdnYyJPwshaQHzHtJ3Y5zxPYap5HHT+FeZ2sY8GjOeAPY+ziPcF58I78mg7M
        vtrz2iL8w10HVuiqcE9fozoLNghjT/4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 76506462 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 3 Jan 2022 17:26:51 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id w184so81078203ybg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 09:26:51 -0800 (PST)
X-Gm-Message-State: AOAM530NImtk2OakvsuLcps2HTTcvt92t0f5ruWnEKzKqeZueWFaXLKT
        cVDgtdY/vuAPkqBg5FJjIV1wM8ppbSMCEPu5X7E=
X-Google-Smtp-Source: ABdhPJyUvYDcQaDiQiN0OAMVIeg+O4BHvmo7C3Y53vsOI14B2TKapVW4TkQGKJGsHcNpvbjt3oy/UH5qxpzL+7r+zyg=
X-Received: by 2002:a05:6902:150d:: with SMTP id q13mr16409745ybu.113.1641230810742;
 Mon, 03 Jan 2022 09:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20220103160002.1068356-1-Jason@zx2c4.com> <YdMsMZU/PL7o2j5f@mit.edu>
In-Reply-To: <YdMsMZU/PL7o2j5f@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 3 Jan 2022 18:26:39 +0100
X-Gmail-Original-Message-ID: <CAHmME9qJtA2BGjXUn2WQVFUNr3OdAo__BS-nVst5mhYhfsA8GA@mail.gmail.com>
Message-ID: <CAHmME9qJtA2BGjXUn2WQVFUNr3OdAo__BS-nVst5mhYhfsA8GA@mail.gmail.com>
Subject: Re: [PATCH] random: reseed in RNDRESEEDCRNG for the !crng_ready() case
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 6:02 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jan 03, 2022 at 05:00:02PM +0100, Jason A. Donenfeld wrote:
> > Userspace often wants to seed the RNG from disk, without knowing how
> > much entropy is really in that file. In that case, userspace says
> > there's no entropy, so none is credited. If this happens in the
> > crng_init==1 state -- common at early boot time when such seed files are
> > used -- then that seed file will be written into the pool, but it won't
> > actually help the quality of /dev/urandom reads. Instead, it'll sit
> > around until something does credit sufficient amounts of entropy, at
> > which point, the RNG is seeded and initialized.
> >
> > Rather than let those seed file bits sit around unused until "sometime
> > later", userspaces that call RNDRESEEDCRNG can expect, with this commit,
> > for those seed bits to be put to use *somehow*. This is accomplished by
> > extracting from the input pool on RNDRESEEDCRNG, xoring 32 bytes into
> > the current crng state.
>
> I think this is fine, but the RNDRESEEDRNG ioctl is rarely used by
> userspace.  From a Google search I see that jitterentropy uses it, but
> in most setups it won't be called.
>
> So something we could do to improve things is to add some code to
> random_write() so that in the case where crng_init is 1, we take half
> of the bytes or CHACHA_KEY_SIZE bytes, whichever is less, and pass
> those bytes to crng_fast_load().  (We'll have to copy it to a bounce
> buffer since the passed in pointer is __user, and memzero_explicit it
> after calling crng_fast_load.)
>
> This will divert some part of the seed file to partially initialize
> the CRNG.  It won't fully initialize the CRNG, but that's fine, since
> it's possible that the seed file has been compromised --- or is a
> fixed value if the seed file is from coming a VM image file.  So
> having at least half of the entropy used to initialize CRNG up to
> crng_init=1 is coming from interrupt timing seems like a good thing.

Yea, doing things in RNDADDENTROPY or random_write is a possibility,
and then userspace doesn't need to adopt new strange things. In
looking at this, though, and combined with the attitude of the
crng_init_cnt=0 commit from last hour, I'm beginning to think that
trying to cater toward crng_init<2 usage is an exercise in madness. We
provide getrandom(..., 0)'s blocking mode for users who want things to
be real. If you're not doing this (or can't due to old kernels), you
should probably Know What You're Doing and adjust accordingly. To that
end, I'm not convinced this patch or similar ideas of making
crng_init=1 mode more useful really has much of a future.

However, it does seem like userspaces who know what they're doing
*can* take necessary countermeasures for the seeding use case that
Jann originally identified as being potentially problematic. To that
end, I submitted a PR to systemd:
https://github.com/systemd/systemd/pull/21986 . We'll see what they
think.

Jason
