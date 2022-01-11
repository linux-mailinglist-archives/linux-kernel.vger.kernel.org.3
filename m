Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E072F48AE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiAKNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:01:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50794 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiAKNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:01:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA2E0615E5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C27C36AF4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:00:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y4VbAUFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641906056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vNhyTvbhYcwcjZouw5facRPBQCg0Uj6EBfEZGojWW8=;
        b=Y4VbAUFwWqq09Ew7YIw3uK6RSuhuhsXo44/fGgqOiFE4tRZjNxp9PfJtKjLSmqpkoMQliY
        aXc84h+HSzOuwDpbCBvoIseG7x5uYZkVbf36jK2ByDBYvrV5eWJCHGnSFel4EfAzf+UrxT
        IexY8Q6wUk5uagFyuCdgAl0s9Yfztag=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19cb5d33 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jan 2022 13:00:56 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id p187so4511390ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:00:55 -0800 (PST)
X-Gm-Message-State: AOAM532oPGYhvomkQhSK739Q06SXAKNoOdHKxRsjAe1dflM1EDW+iHCf
        St1Q3c8ByO+K5D2iJymMzPwWPW7FxUr1Ecm4ag4=
X-Google-Smtp-Source: ABdhPJxm2gaN69Jz1T4aLeNDck2NO7Igln6r49r9nBJuTPlq56P6027rPlL8k55yn4wX94h9+nXZINYIyAs0teF2CB8=
X-Received: by 2002:a25:a0c4:: with SMTP id i4mr5901763ybm.457.1641906055073;
 Tue, 11 Jan 2022 05:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <20211223141113.1240679-2-Jason@zx2c4.com>
 <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
 <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
 <Yd18+iQ8zicsSPa0@zx2c4.com> <CAMuHMdVJSAe_uQ0yzBL9gkzhW+8Po81Eh332NFENMHCUqbw-dQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVJSAe_uQ0yzBL9gkzhW+8Po81Eh332NFENMHCUqbw-dQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Jan 2022 14:00:44 +0100
X-Gmail-Original-Message-ID: <CAHmME9pvGoPCL=KBJGa-3vZTY1Afshk0ccfGiL-zFVNHh1CjPA@mail.gmail.com>
Message-ID: <CAHmME9pvGoPCL=KBJGa-3vZTY1Afshk0ccfGiL-zFVNHh1CjPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 1:58 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Cool, much more than 1000 bytes:
>
> add/remove: 1/0 grow/shrink: 0/1 up/down: 160/-4032 (-3872)
> Function                                     old     new   delta
> blake2s_sigma                                  -     160    +160
> blake2s_compress_generic                    4448     416   -4032
> Total: Before=4227876, After=4224004, chg -0.09%
>
> I don't know what the impact is on performance, and if the compiler
> might do a good job unrolling this again when performance matters
> (i.e. if CONFIG_CC_OPTIMIZE_FOR_SIZE is not set).

Oh, wow, that's a lot indeed.

I guess the new code could be ifdef'd in a CONFIG_CC_OPTIMIZE_FOR_SIZE block?
