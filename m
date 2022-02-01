Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C251C4A57BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiBAH2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiBAH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:28:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A9C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:28:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c9so14650660plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tOvw7UNAXtv97V+S8rgpQWpicqxKq2hLd28xWMrkmOk=;
        b=TJb/79RraB59qvT/Gh3F9b5Cd5lDXtRPLsu5vSZu2WzivI+JOV3yHByfVBze/QgS4w
         W/qJ+hBgfWo62og6MVH+4TBEFupsDvQEkgJLKcyM5y2cK1OeevondHDCHPYUYlxww+6r
         Q7d3jT6d4Qj2Y5vBIJzqwsXm4ZLocuhYeh6OK8Gnvw4YsbbLXDsHZMk4M1CGagfOpqYt
         IW03zL/4VKtWPvL6rhCCR0VNzHvCYxoEXBPfnYVjSRUULwyh43LcStk2QjPWm9uUp8HE
         r/ZnfKHNk+EinBsHJqr7CosS+0p3X5FEb5PLgm6+kKZbM5/sI65HSuj5tCxL4TRMcFT9
         5wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tOvw7UNAXtv97V+S8rgpQWpicqxKq2hLd28xWMrkmOk=;
        b=bSEkaDpD8DENr5WyX5hesSGLR/bthbTtCBAH781Qpzhr7OwXryJKfZB3DDKvX33sEJ
         6YiacB6aF4k8yZhSk8d4Ws6qHahi48GeUeC0SOgukMysPpgayLthdONwcAvf4FoSgnZK
         CvNTBa9K/CcdULpoJF27kg5qCsZzUUyocuczxIX5Fw4BE5hrkSmktyLeyLs2d73J2k+V
         /KOT6cAadCR7MleFIDkd+C12knHSOF4CoQMWNRxDpewTwUgX/890W91ftQchs9bUDqg5
         Y7eWcl8N2C5fFw//mOUfj77gIigLvOtxFKMnPNjQeLVO6saywu3owMGqtsPOgWj6JKvU
         l19Q==
X-Gm-Message-State: AOAM5326fU2Rv2D9MssLxn5OIU9a0aybld8QRajT/HdvFwUQ+EiF9R50
        wc7j9dunCY6v/iYZxHcZeBQ=
X-Google-Smtp-Source: ABdhPJzyyNz3NxYxKAOmZ2BEe8KJAowjqsjU3je9zCuJdca6U8MWOvQwatfeX81B2+CjiPrNiH29sA==
X-Received: by 2002:a17:903:31c8:: with SMTP id v8mr24417666ple.76.1643700506960;
        Mon, 31 Jan 2022 23:28:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:1b1a:cadc:e9c0:fbd5])
        by smtp.gmail.com with ESMTPSA id mn2sm1538152pjb.38.2022.01.31.23.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 23:28:26 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 31 Jan 2022 23:28:24 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Will McVicker <willmcvicker@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/gup: skip pinnable check for refs==1
Message-ID: <YfjhGKCkQ6h5H5uI@google.com>
References: <20220131203504.3458775-1-willmcvicker@google.com>
 <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27e5f98a-0709-1a80-18ed-e4ccaaf39fe6@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Jan 31, 2022 at 12:49:35PM -0800, John Hubbard wrote:
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
> >   		 * right zone, so fail and let the caller fall back to the slow
> >   		 * path.
> >   		 */
> > -		if (unlikely((flags & FOLL_LONGTERM) &&
> > +		if (refs > 1 && unlikely((flags & FOLL_LONGTERM) &&
> >   			     !is_pinnable_page(page)))
> >   			return NULL;
> 
> ...but are you really sure that this is the best way to "fix" the
> problem? This trades correctness for "bug-for-bug compatibility" with
> the previous code. It says, "it's OK to violate the pinnable and
> longterm checks, as long as you do it one page at a time, rather than in
> larger chunks.
> 
> Wouldn't it be better to try to fix up the calling code so that it's
> not in violation of these zone rules?

I think the problem is before pin_user_pages can work with CMA pages
in the fallback path but now it doesn't work with CMA page. Driver
couldn't know whether it will work with CMA page or not in advance.

pin_user_pages
  __get_user_pages_locked
    follow_page_mask
      follow_page_pte    
        try_grab_page
          !is_pinnable_page(page) 
            return NULL;
        return ERR_PTR(-ENOMEM);
     return -ENOMEM without faultin_page
