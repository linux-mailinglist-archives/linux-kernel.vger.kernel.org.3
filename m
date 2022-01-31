Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8884A518C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380682AbiAaVh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358076AbiAaVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:37:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF4C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:37:27 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id k25so46922146ejp.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eAtHYfw+/lT8OWoIpphlqOzT4nSqWECsjs9ahLjkbw=;
        b=s/Bxs4zdolC7/C0cnjeR6DBgNzcmI/HhxGvzNgg0QUH7B/R3JRWVYyUi4i8NRwgwtb
         bOfBerN+MxfcWU7s+3cir8msw2qpYcRdcmcEebZA5uXNeY0HWy6osbR7Xxi2tMHNdchL
         Z1pof6grX5bhk0/Mi4cp6PgYhHh7Tk7TrWFD7qYu4rDrcV9HWdLB9FdfNIcshtDy/ONa
         VZ48tGWZptTW8mYOyiB2+Rage6XmCIksZ3ZczLQcrmhAMPImixlcU4L7W0e+Fm7ppo2+
         EvTMwGq26okhfqJ7wGne5ZshpXZIlDNQZZQmbIR/GFAb6j8SHP1pAYC+pAfemPaOYHHy
         kOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eAtHYfw+/lT8OWoIpphlqOzT4nSqWECsjs9ahLjkbw=;
        b=Dpm6Wm8w6p7Aq5vaX5FRC7uOC4U1ZJfwAfhlEl3Lw4dNapYTCOzR8rd0rmdL52/Odr
         ykkVY5jDG/Rn/Pztntp+tofFLEcr6JgyQtCnXWvfvZynaBvQhj2mvBTgY6jnqR75FBja
         jmyyZV9NPY/DtFCS3lMcA2CmurXdlI8OJpcUc9NtKOYiZNQ3XRVpsF9UqdW+iR28rmKb
         UF2OtcduzrLnd5pEl1N69NIhdi+S/xfUQocwQQWp7kAmzvngMyVf4JY/aUDKBoGzQ6O3
         W0Bq50r9kc+6JRXJKMT4yk2wy9h4YCiv8/NUs94yed3AGzQt9hSUcql1BecBhsoLD8wg
         rekw==
X-Gm-Message-State: AOAM531AXNqPtIhsv+Ql07CLuJgt2pMy4vMoLhtzZUvhK3C+4XajdZjr
        g87qMCR/XyfyTzr6N5zWPdzzmuAvOB3mA9rVKuCAiQ==
X-Google-Smtp-Source: ABdhPJyAJ8VRWefS1wIU5l6oqnj1HmOvBTN0xWCGW1WwFsJFSSfT9GVPhOVM+FX4T8PVHaSxwhNSU5D3rp1VONSQZT0=
X-Received: by 2002:a17:907:608f:: with SMTP id ht15mr18617793ejc.484.1643665045448;
 Mon, 31 Jan 2022 13:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20220131203504.3458775-1-willmcvicker@google.com> <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
In-Reply-To: <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Mon, 31 Jan 2022 13:37:09 -0800
Message-ID: <CABYd82ZhWBUMHaa8aDRe=bwrR=J623kS89C-wpvGXc=KWJUw-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mm/gup: skip pinnable check for refs==1
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Minchan Kim <minchan@google.com>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:49 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 1/31/22 12:35, Will McVicker wrote:
> > This fixes commit 54d516b1d62f ("mm/gup: small refactoring: simplify
> > try_grab_page()") which refactors try_grab_page() to call
> > try_grab_compound_head() with refs=1. The refactor commit is causing
> > pin_user_pages() to return -ENOMEM when we try to pin one user page that
> > is migratable and not in the movable zone. Previously, try_grab_page()
> > didn't check if the page was pinnable for FOLL_PIN. To match the same
> > functionality, this fix adds the check `refs > 1 &&` to skip the call to
> > is_pinnable_page().
> >
>
> That's a clear write-up of what you're seeing, what caused it, and how
> you'd like to correct it. The previous code had a loophole, and you want
> to keep that loophole. More below...
>
> > This issue is reproducible with the Pixel 6 on the 5.15 LTS kernel. Here
> > is the call stack to reproduce the -ENOMEM error:
> ...
> > Fixes: 54d516b1d62f ("mm/gup: small refactoring: simplify try_grab_page()")
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Minchan Kim <minchan@google.com>
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >   mm/gup.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index f0af462ac1e2..0509c49c46a3 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -135,7 +135,7 @@ struct page *try_grab_compound_head(struct page *page,
> >                * right zone, so fail and let the caller fall back to the slow
> >                * path.
> >                */
> > -             if (unlikely((flags & FOLL_LONGTERM) &&
> > +             if (refs > 1 && unlikely((flags & FOLL_LONGTERM) &&
> >                            !is_pinnable_page(page)))
> >                       return NULL;
> >
>
> ...but are you really sure that this is the best way to "fix" the
> problem? This trades correctness for "bug-for-bug compatibility" with
> the previous code. It says, "it's OK to violate the pinnable and
> longterm checks, as long as you do it one page at a time, rather than in
> larger chunks.
>
> Wouldn't it be better to try to fix up the calling code so that it's
> not in violation of these zone rules?
>
>
> thanks,
> --
> John Hubbard
> NVIDIA

Hi John,

Thanks for the prompt response! I'm not super familiar with what
PIN+LONGTERM conditions require, but if this was previously a bug,
then I definitely don't want to re-introduce it. Since you're
confirming that, let me sync-up with the driver owner to see how I can
fix this on the side.

Thanks!
Will
