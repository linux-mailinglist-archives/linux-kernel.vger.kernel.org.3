Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966B94A719B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbiBBNdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiBBNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:32:59 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB6BC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:32:59 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 23so60959265ybf.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49C1ROc5LMrtI2IRPZaBsdDysSCIk+RUi4xq89kMC0Q=;
        b=ZUn4b/U/47chAtjr/MNZgInDUsb0hDXxHL7scO2+BXDqZ/qh4kyY8LfduGP0y8qrUM
         B+crmPB+2dqAT7UNK+hLLr52fLpJqU7vDGbUhpEe9iQUzEhcKq3ZbJMUc58jWxkBqarE
         1Dr2MaC+DBWZj3cdUGlD4Z7UWv+bTW1WPHvH+aMPgF03x3ernz3nxhCxcyBEhTSUyyYA
         D5GL0fBA7KU3yB372PGQN3Tz0FXOP0aAK8wDmoAB3XK5d3v+AJgf/moxXK3ednbT+CzQ
         lCVzgt7v5Yjr4Iqjuhw16UIE7IBG/1fxDUP/wY7sf9I7N8f3TDg2NSmWNRX1SU0x/tH2
         h+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49C1ROc5LMrtI2IRPZaBsdDysSCIk+RUi4xq89kMC0Q=;
        b=C5TID2K6cwVzUtqbVj4201y9fa5DWAv3iRx5x+2T46+lsDiX5pp6SwqNlUD2n/rm/i
         hoA00QDpdSAGudVooV/u8AriX6rdGueqWA4A6RFKZ+qmR0EPsACiFxcPYJMndYU1Eq3h
         vGs3AMIsvOtChsCeqCZ8lB+XtUp4Efhl1JDF1dbzDIjzICFZ4rzAh1iagtvzdU7Fz9Xg
         tnVtlT8VaSEi57vTb9KUXXh3ucYEEXP5F3o06mOEjbSpcHGZReZV+1UZbYOvbhpoG29b
         d5C+bab/+3x+1ZWXEm0wqy68OB8EQ8QlBX0wcw9CQ3ch4WB3ZwFqok0FDXu0C1/u8F2R
         bCjQ==
X-Gm-Message-State: AOAM530Sd5SUkQLjP8SrzzaRO4thztu6tezIyoAS8Z33g7rq3ss7hb4K
        h5qMjymivBKM6+qxpwNKJiFnRiATtGLwseNHdziBGA==
X-Google-Smtp-Source: ABdhPJzJyAQCcoB843YoDkZz7uho1finq6gZDC6Xle9/4bH7LFjvRLQxaJM13r6PFlV2ohOkBWRZcH+x7+2cHuVtJlc=
X-Received: by 2002:a25:8f8e:: with SMTP id u14mr30612352ybl.495.1643808778816;
 Wed, 02 Feb 2022 05:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20220131160254.43211-1-songmuchun@bytedance.com>
 <20220131160254.43211-3-songmuchun@bytedance.com> <9fa0211a-aee2-22fb-d076-0464a4d8524c@oracle.com>
In-Reply-To: <9fa0211a-aee2-22fb-d076-0464a4d8524c@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 2 Feb 2022 21:32:20 +0800
Message-ID: <CAMZfGtULga8fC=i2n2jPHNjr5-45DTQjJqJ6FeZmy9qi91bXtw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: fix missing cache flush for all tail pages of
 compound page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Lars Persson <lars.persson@axis.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 7:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/31/22 08:02, Muchun Song wrote:
> > The D-cache maintenance inside move_to_new_page() only consider one page,
> > there is still D-cache maintenance issue for tail pages of compound page
> > (e.g. THP or HugeTLB).  THP migration is only enabled on x86_64, ARM64
> > and powerpc, while powerpc and arm64 need to maintain the consistency
> > between I-Cache and D-Cache, which depends on flush_dcache_page() to
> > maintain the consistency between I-Cache and D-Cache.  In theory, the
> > issue can be found on arm64 and powerpc.  HugeTLB migration is enabled
> > on arm, arm64, mips, parisc, powerpc, riscv, s390 and sh, while arm
> > has handled the compound page cache flush in flush_dcache_page(), but
> > most others do not.  In theory, the issue exists on many architectures.
> > Fix this by not using flush_dcache_folio() since it is not backportable.
> >
> > Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> > Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > ---
> >  mm/migrate.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index c9296d63878d..c418e8d92b9c 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage, struct page *page,
> >               if (!PageMappingFlags(page))
> >                       page->mapping = NULL;
> >
> > -             if (likely(!is_zone_device_page(newpage)))
> > -                     flush_dcache_page(newpage);
> > +             if (likely(!is_zone_device_page(newpage))) {
> > +                     int i, nr = compound_nr(newpage);
> >
> > +                     for (i = 0; i < nr; i++)
> > +                             flush_dcache_page(newpage + i);
> > +             }
>
> As you have already noted elsewhere, the arm64 version of flush_dcache_page
> seems to handle this and flush the entire compound_page.  Is this going to
> flush the entire compound page compound_nr times?
>

Not flush cache compound_nr times but set PG_dcache_clean
on page->flags compound_nr times.  The definition of
flush_dcache_page() on arm64 is as follows.

void flush_dcache_page(struct page *page)
{
        if (test_bit(PG_dcache_clean, &page->flags))
                clear_bit(PG_dcache_clean, &page->flags);
}

So I have a plan to improve this, e.g. implement flush_dcache_folio()
on arm64 and replace those multiple dcache flush with
flush_dcache_folio().

void flush_dcache_folio(struct folio *folio)
{
       if (test_bit(PG_dcache_clean, &folio->flags))
               clear_bit(PG_dcache_clean, &folio->flags);
}

Thanks.
