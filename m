Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6104B4966A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiAUUvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAUUvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:51:52 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9328C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 12:51:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 23so30900076ybf.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yx8Sp5yK+IdSrHNRElqCQeGwi3Mhv+uJHX0dumssPUA=;
        b=YjZAfWsIl22u4X60/fbS0dbemyatmDIkYev6n1TbCuzrDC87OZ3vL1EMl1GajyVlDf
         AelgkM6pKJ0kXs/tVKF3zcI07cEMv0w9EAYpMNi5c3CNWfYRphBxeQBYSK/rDzUD2Aoc
         O/9vGAd1++8iH81q0OyiG5sdMKU2Jii8KEkzgUDk+l8Bj9KfRDLw9nVEnd9csn9q1in7
         jIU40jwptembCj0iK/B4OXLRvkqGP5fdzwuauK1L2dBBPlFB84oZEhR3dut2uFSqfMfY
         8nRZkKg0C73kq764VJ8P9MK8Kx0P/kX0fdX46xbVvRNhonRy8dadYg8FYS9E1G/Gvfrv
         RSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yx8Sp5yK+IdSrHNRElqCQeGwi3Mhv+uJHX0dumssPUA=;
        b=o89+vz+DVESOQgwTthN30z3DS7h+KTFR/ox3Ln05dC0d2LOEGsakyESKznJNlVSxn9
         v+m5PtY8ebDI0JR1MsmZ1BoHNNKc6P671oxo4d3LcFHbll3FKcv3dTzIdoaQz515A6+v
         B5sJaQxB3X90rDfYTDBXdqbuD0sYhZAt9yBi7CBknshT/61g0IkUBRNyp3AJ/dsz74G9
         VtjuFqTXHEh3sG3J8C4m4GI3S/krzSE3JJOdVuCggIkQeOQ7a0ku7PLBqdweUkKBC+KB
         W/eRzuRNhE+WBEUxLkgnMJQvElk14AWn5I9ZVIPOQg+TILTZB0WqIayQ754fyuvmAtVz
         Mp3w==
X-Gm-Message-State: AOAM53129m+Iti1521Dsf6brAwc5HtQ8CRhaVqurI9FO5g0wnfneN5Ea
        Gr/YPD+pJ51XjsHYJayISqvsebIwry2wDp5jEqQN7K6KPVw=
X-Google-Smtp-Source: ABdhPJxkhXZrcRureYqCap4kFxTZxfwvDGSic4fyFA+HyhmO213hyixgvNMr4MNs1ShbFviWARp8lDLRAfZc4ikUV+s=
X-Received: by 2002:a25:c841:: with SMTP id y62mr8672404ybf.196.1642798311679;
 Fri, 21 Jan 2022 12:51:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
 <20220119135450.564115-1-Jason@zx2c4.com> <YesPesOhftSzp2ft@sol.localdomain> <CAHmME9ow7TxCaYYayRn9rdJJSdQ48tWQgdrW00g7mHaWvVJ+Zw@mail.gmail.com>
In-Reply-To: <CAHmME9ow7TxCaYYayRn9rdJJSdQ48tWQgdrW00g7mHaWvVJ+Zw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 21 Jan 2022 12:51:40 -0800
Message-ID: <CABCJKuf=eHuFfNjD-7FBTeft3XNTkEc4G9cDvYpMJgH_se12eg@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: avoid indirect calls to compression
 function for Clang CFI
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Jan 21, 2022 at 12:23 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Jan 21, 2022 at 8:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > There are some lines over 80 columns in this patch.
>
> I'll fix that up.
>
> > Otherwise this looks fine.  It would be really nice to fix this in clang,
> > though.
>
> I agree. I'm wondering whether it makes sense to roll with this patch,
> or to just not change anything and lean on Clang upstream to fix their
> bug. Full LTO is marked as "experimental" still. On the other hand,
> Android ships with it turned on, so how "experimental" can it really
> be? I don't have a strong read on the Clang ecosystem to know what
> makes most sense, to apply this or not. Do you have an opinion?

We'll work on fixing the compiler, but please note that it's most
likely going to take a while, so I would prefer to work around the
issue in the kernel for now.

Sami
