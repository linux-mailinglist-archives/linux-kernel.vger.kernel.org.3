Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F248EF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbiANRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:32:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55486 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiANRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:31:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92F9762014
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 17:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7673C36AE9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 17:31:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B5NmME6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642181514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T3Bp3JmUxxoUPyui2Y1UKiXOczt2GYEm+0D2qnWVAJQ=;
        b=B5NmME6wGx5Fk4+V6uH7rkVvxB8dK+KosL9avbRJbo5JELs4EDk0CoWuy7zavURxhSJcmw
        JTas9sDwIj4H5rBSmUWURTrPBV6WTjb/6iY/sLQgo2HefjXdBKC6GZ/mjak1RIQKKR+e4e
        YsyB5Lv8kPK2HTaw962mbAN3q4QZ3AU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id edb58f9a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jan 2022 17:31:54 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id p187so25887030ybc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:31:53 -0800 (PST)
X-Gm-Message-State: AOAM532mVwZdQ7+gdvx6+ol2MiLLAp0xXh2Km9ZVeI/wPPzfuarLLid0
        WaIZWDXAKVW+W90ySF3N19sbkOEnwlNFOPPYRlk=
X-Google-Smtp-Source: ABdhPJzIMm77FqtMJFvH9wnDSfSWlg+vHU2bulNfd35dfy4ZW8+IyjMTUEvgtLpWqUXNnFy0OENM9DMyCibz5XFFqmQ=
X-Received: by 2002:a25:aa4f:: with SMTP id s73mr5715235ybi.255.1642181513417;
 Fri, 14 Jan 2022 09:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <20211223141113.1240679-2-Jason@zx2c4.com>
 <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
 <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
 <Yd18+iQ8zicsSPa0@zx2c4.com> <05ae373684334e6581294baa8afd3238@AcuMS.aculab.com>
In-Reply-To: <05ae373684334e6581294baa8afd3238@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Jan 2022 18:31:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9o4tyG2srPGe74n+cx9nfsU-xVe7C+mf4677ojVLVBWDg@mail.gmail.com>
Message-ID: <CAHmME9o4tyG2srPGe74n+cx9nfsU-xVe7C+mf4677ojVLVBWDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
To:     David Laight <David.Laight@aculab.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 6:27 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jason A. Donenfeld
> > Sent: 11 January 2022 12:50
> >
> > On Tue, Jan 11, 2022 at 1:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > If you're really quite concerned about m68k code size, I can probably
> > > do some things to reduce that. For example, blake2s256_hmac is only
> > > used by wireguard and it could probably be made local there. And with
> > > some trivial loop re-rolling, I can shave off another 2300 bytes. And
> > > I bet I can find a few other things too. The question is: how
> > > important is this to you?
> >
> > And with another trick (see below), another extra 1000 bytes or so
> > shaved off. Aside from moving blake2s256_hmac, I'm not really super
> > enthusiastic about making these changes, but depending on how important
> > this is to you, maybe we can make something work. There are probably
> > additional possibilities too with the code.
>
> Quite clearly whoever wrote the unrolled loops needs their head examined.
> It is extremely unlikely that a cpu has enough registers to implement it
> effeciently.

Feel free to send a patch doing this, along with benchmarks. It
doesn't seem impossible to me that re-rolling the rounds might be
better on some platforms. The question is - is it really? And if so,
which ones? And for what varieties of inputs? If you put some research
into this, please do CC me on patches.

Jason
