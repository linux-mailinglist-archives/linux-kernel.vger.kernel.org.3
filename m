Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7113E4A70B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiBBMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:23:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbiBBMXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:23:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C898B830B2;
        Wed,  2 Feb 2022 12:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A3AC004E1;
        Wed,  2 Feb 2022 12:23:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l8b6PN2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643804613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGEzqHTDCMG8mI3TmhK6JduZrlIkNoEeX3AHXuvfN00=;
        b=l8b6PN2YTOt5a6ONR2PcsjguyoljXFj8sF/NfE9DiuT/S9/WNEFzPQs+EIcDCnMkhG6Q7X
        bgKdPug0C85/4dubUin9/YA9GfW9n1jbfcHsyMs/Zc3E/MMmqQkKm4RrSKqdlKk5WgRmjo
        SZEG31O0LpahrNXjSfOOUOjBuXGYbHs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 92887216 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 2 Feb 2022 12:23:33 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id i62so60328290ybg.5;
        Wed, 02 Feb 2022 04:23:33 -0800 (PST)
X-Gm-Message-State: AOAM530M2e5oAt0vMZSQxlGOzhu9z1KCQlbHFuOAH9u0dxY5/KnuPSZv
        RxPrZlIkRtRQ5jbdRVptrPUov1PbsReUL6RveU0=
X-Google-Smtp-Source: ABdhPJy3DoJDwZfwHAMG8lESNaJ7LhGJU3bDGnZiU3LXFymHywyLCT8c3UU4mtIKpEgG5Fd3wUiRYvU/+kHHT8Eq2Nw=
X-Received: by 2002:a05:6902:726:: with SMTP id l6mr3477287ybt.115.1643804611659;
 Wed, 02 Feb 2022 04:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20220201161342.154666-1-Jason@zx2c4.com> <1920812.EuvsCRJjSr@tauon.chronox.de>
In-Reply-To: <1920812.EuvsCRJjSr@tauon.chronox.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 2 Feb 2022 13:23:21 +0100
X-Gmail-Original-Message-ID: <CAHmME9ouMHtTQxB1WHq3H+nfbg27OFaJtw78E5epCJsiHt3sHg@mail.gmail.com>
Message-ID: <CAHmME9ouMHtTQxB1WHq3H+nfbg27OFaJtw78E5epCJsiHt3sHg@mail.gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
To:     Stephan Mueller <smueller@chronox.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

It's like this for a few reasons:

- Primarily, we want to feed 32 bytes back in after finalization (in
this case as a PRF key), just as the code does before this patch, and
return 32 bytes to the caller, and we don't want those to be relatable
to each other after the seed is erased from the stack.
- Actually, your statement isn't correct: _extract_entropy is called
for 48 bytes at ~boot time, with the extra 16 bytes affecting the
block and nonce positions of the chacha state. I'm not sure this is
very sensible to do -- it really is not adding anything -- but I'd
like to avoid changing multiple things at once, when these are better
discussed and done separately. (I have a separate patch for something
along those lines.)
- Similarly, I'd like to avoid changing the general idea of what
_extract_entropy does (the underscore version has never accounted for
entropy counts), deferring anything like that, should it become
necessary, to an additional patch, where again it can be discussed
separately.
- By deferring the RDRAND addition to the second phase, we avoid a
potential compression call while the input pool lock is held, reducing
our critical section.
- HKDF-like constructions are well studied and understood in the model
we're working in, so it forms a natural and somewhat boring fit for
doing what we want to do.

Regards,
Jason
