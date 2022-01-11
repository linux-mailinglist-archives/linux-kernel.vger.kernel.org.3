Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D562D48B5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbiAKS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbiAKS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:26:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C8C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A03F616CE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CBEC36AE3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:26:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="agW9C9qh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641925576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1kYfHUjAsCxRvXGK+XuTmCULTH2rXDAwKQ47ISivOms=;
        b=agW9C9qhOKJ1dVzepweY3I1Y5DOpKyQ1rCrgaVlEQ5CKW74ZPiE6KSjEDJDcMbEJ2VDPTP
        J1d3ePhdUSQEZQWy3ptq0hfeZUBFqCzZYVBylPA2DfGqI6tSFOPBGQiwDMMOm4g+55xWoU
        HVWQKrTpCXXfJMr6N3mhfBQWFYA//lg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 40d254f8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jan 2022 18:26:15 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id v186so40510046ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:26:15 -0800 (PST)
X-Gm-Message-State: AOAM531r2V28TVZJ298dMN2OZfED5k7R32QxYv0zx/9yXRTDyadocGf/
        /KW3I69Ro/rua8lNpnuE+5AX6vNsXQNQixKnSdk=
X-Google-Smtp-Source: ABdhPJzCaEJl7wP5Lt4kDlZ0YsjIKabnIawxRlqOxPnw8+9FJ//LJj1EjsYyZSdxFB3vPlNV0++RM3OAyMiTHct4gww=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr7974646ybe.32.1641925574680;
 Tue, 11 Jan 2022 10:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <20211223141113.1240679-2-Jason@zx2c4.com>
 <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
 <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
 <Yd18+iQ8zicsSPa0@zx2c4.com> <caed82818cdb466aade033501f57d183@AcuMS.aculab.com>
In-Reply-To: <caed82818cdb466aade033501f57d183@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Jan 2022 19:26:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9rvRZVgy+1wr94dC8pCV-qgLSm9mk7FkqbtjM0xz=HT1w@mail.gmail.com>
Message-ID: <CAHmME9rvRZVgy+1wr94dC8pCV-qgLSm9mk7FkqbtjM0xz=HT1w@mail.gmail.com>
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

On Tue, Jan 11, 2022 at 4:47 PM David Laight <David.Laight@aculab.com> wrote:
> > -     int i;
> > +     int i, j;
>
> Use unsigned int i, j;
> Ensures the '% 4' are done as '& 3' and the divides as shifts.
> Unless the compiler manages to track the valid values that will
> even generate better code on x86-64.
> (Saves a sign extension prior to the array indexes.)

Ack.

> I think I'd look at doing [0..3] then [4..7] to save execution time.

I actually wound up making the same change to sha1 instead of blake2s
for v2 of this, and achieved pretty similar results, but I think
that's more satisfactory of a conclusion. v2 is here:
https://lore.kernel.org/linux-crypto/20220111181037.632969-1-Jason@zx2c4.com/T/#u

Jason
