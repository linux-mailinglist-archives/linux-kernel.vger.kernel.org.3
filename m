Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40A48ED54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiANPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbiANPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:46:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:46:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6D2861F48
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D814C36AEC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:46:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eqGO0i3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642175209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9D0bqxRCffUDKd8fZ9dmf4yMg4nZkDu+Wy808B9ksJ0=;
        b=eqGO0i3Ldof+wo4eEp5FXrAm3LO1aZmH6lzoEJkjPosU/jrZQdOVd5pM2XAt+OUy89WR7u
        CuPbpUYo76tM59edZLwD/UV0AZhCd6Y4K8D7E+pY3SrMm0URaJfrYPMVzJzR/cPU1rlsfj
        hpUcGEJUHixAm2JAT5y3ni0QonRikwA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7111e340 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jan 2022 15:46:49 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id h14so24910112ybe.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:46:48 -0800 (PST)
X-Gm-Message-State: AOAM531bKP28JFnEkr7HNsY9j6ieKqyefCwznV/Sg5Dm0nJDoiMcNpuA
        5vf6VzXBWS0NPEUOrC6Guf8BLDjBgTiKJ6/mY6I=
X-Google-Smtp-Source: ABdhPJxIqpYilNPe1ms5t2c2NvFFPjEjQCvp2jAjxd/VVAA+rICaKmhNrHmDNAfU+JZf8Qf01iPjq6PQHt5aIrA/WZU=
X-Received: by 2002:a25:aa4f:: with SMTP id s73mr5108345ybi.255.1642175208210;
 Fri, 14 Jan 2022 07:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20220113154413.29513-1-Jason@zx2c4.com> <20220114153305.98505-1-Jason@zx2c4.com>
 <18ec4b57aecc4fa18d8e3bb6e090af1b@AcuMS.aculab.com>
In-Reply-To: <18ec4b57aecc4fa18d8e3bb6e090af1b@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Jan 2022 16:46:37 +0100
X-Gmail-Original-Message-ID: <CAHmME9qQoHnT+ewe3Nz-ZTmCuLAtNk6=-Lzdb_puhz1ZgBHMfA@mail.gmail.com>
Message-ID: <CAHmME9qQoHnT+ewe3Nz-ZTmCuLAtNk6=-Lzdb_puhz1ZgBHMfA@mail.gmail.com>
Subject: Re: [PATCH] random: cleanup fractional entropy shift constants
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 4:39 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jason A. Donenfeld
> > Sent: 14 January 2022 15:33
> >
> > The entropy estimator is calculated in terms of 1/8 bits, which means
> > there are various constants where things are shifted by 3. Move these
> > into our pool info enum with the other relevant constants, and normalize
> > the name a bit, prepending a POOL_ like the rest. While we're at it,
> > move an English assertion about sizes into a proper BUILD_BUG_ON so
> > that the compiler can ensure this invariant.
> >
> ...
> > -#define ENTROPY_SHIFT 3
> > -#define ENTROPY_BITS() (input_pool.entropy_count >> ENTROPY_SHIFT)
> ..
> > +     POOL_ENTROPY_SHIFT = 3,
> > +#define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
>
> The rename ought to be a different patch.

I can certainly do that.
