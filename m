Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C3A4967D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiAUW0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiAUW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:26:19 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED7C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:26:19 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p5so31422538ybd.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TKDaf4r0DbwVoPKUnbWMT12wXKfJ7AIRMgW3bK94bA=;
        b=kdExy7G0SbxV21jH79dDAEh5+1datmVn6VmRcSrAEYVxiryK99n7j9b7BhtmEKoErn
         G9LLBCCltUndr/WMjVMIed9yYxGnRzSXWFSpEB7FhhPm7lqOt3YQjrezkSZm8s/d8wfu
         DnvrJv1aEGlp/tpDO0q4FOBhdmUiG6wGLp1Cgkk7pCpkOlApiEOEgVGLhV+LQo6bBxUo
         hqHjhXQMvaLxVIvlQBgNFu/bHxRIRhK6UKtYXkwal6FbjTlqG5mEBq4vqHeHBVb6338V
         dP6cjBnVWhgYeZMMhNWicv1WjeyVWHf+iDgijwQVfeKx08q/FQTrGkBvRdAHkSKOYdFY
         AYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TKDaf4r0DbwVoPKUnbWMT12wXKfJ7AIRMgW3bK94bA=;
        b=TY5FQMFF12H1+fkI6j/QARTSVGzbN8gAbsot1miLMHweTJVMfY6M1BpsmmVvv0Elxu
         oNAx/oPhUcNsiDj5HmT3um5cV3JJXGfpX1C+o0jHYUxAWN5ZzbVJ4ZJrCkFwehZjLyL/
         d2tIlFc6W7jowdJ7H0R5RgK/Q8MwCS80vKMP8ddFo8lpCfzHbIeFjt6GINy1huRusWwa
         1aEyionJYMtXSbMytL8EdoKQn77rs5kwMzfm3HgLx8oSHYdQiKsXmmwa7KzUf/0EvF6O
         Wy04d85WngKRj/xOATL6OcGKH5a5jfv4jGXch8qhuZJmH8Njsaus5JcC1yeiFlqeS1Mf
         V1AQ==
X-Gm-Message-State: AOAM533o9hf948uPoq6DbBkSBuulqfecgpk9SYgdmym5+5SflSlc4Q8J
        I1UWfzQDL99KZpAXsIDD9ZT3j497af8rjlQoWVJz6g==
X-Google-Smtp-Source: ABdhPJxRFn5ZekQOhx4nZKJBlN2Az1DlK7aL494Zca3ycZLruWyMnjurc2t8qDev38vW3ezBDQHjUEgbncSep805xkw=
X-Received: by 2002:a25:d107:: with SMTP id i7mr8790772ybg.495.1642803978431;
 Fri, 21 Jan 2022 14:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20220121081345.80320-1-songmuchun@bytedance.com>
 <20220121081345.80320-2-songmuchun@bytedance.com> <80208467-D04B-4215-9C5A-8BDBDB365853@nvidia.com>
In-Reply-To: <80208467-D04B-4215-9C5A-8BDBDB365853@nvidia.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 22 Jan 2022 06:25:40 +0800
Message-ID: <CAMZfGtWF37O0hHTJtwCUUYuS-bdf8DxbuXhjwOepskETcOOyaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: fix missing cache flush for all tail pages of THP
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:59 PM Zi Yan <ziy@nvidia.com> wrote:
>
> On 21 Jan 2022, at 3:13, Muchun Song wrote:
>
> > The D-cache maintenance inside move_to_new_page() only consider one page,
> > there is still D-cache maintenance issue for tail pages of THP. Fix this
> > by using flush_dcache_folio().
> >
> > Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/migrate.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index c9296d63878d..daf2b3508670 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -934,8 +934,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
> >                       page->mapping = NULL;
> >
> >               if (likely(!is_zone_device_page(newpage)))
> > -                     flush_dcache_page(newpage);
> > -
> > +                     flush_dcache_folio(page_folio(newpage));
> >       }
> >  out:
> >       return rc;
> > --
> > 2.11.0
>
> Yes, the entire THP should be flushed. But it is better
> to use a for loop instead of the folio variant, so that the patch
> can be ported easily to the stable trees. The for loop can be
> converted later when the whole function is converted to use folio.
>

Agree. Will do. Thanks for your review.
