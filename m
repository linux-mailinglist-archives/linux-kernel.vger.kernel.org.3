Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2894DA709
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbiCPApW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:45:19 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217833A18F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:44:06 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w16so1641051ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82AfxM9iWnmVbmHsCRPs5CDEdlL0ZgkL1CBgzMeozWA=;
        b=HjI4FtQJjPwIQM6KCfd/DEBcIiXtO+1ZVNN+7Q1olj8MlOm0y9YfuZNo+uF7xqnLSg
         eAG1N47VmWf3OsLK4bNAgem70pW6Sokraw+2xztuQMv0As9tkyKxHOwuuURFz160Yxxv
         P/OmNm2/o5y/Sdly2KmigBaKeA5hs2w4WCzTgNATocIHFiVYi2+ENnnyNAE3QGrRt4mo
         0thJPKAkX+dZxzXDKQT7Alr5nTzt1w+rBx6l1MH3V5wTVURtKmWfMyiJoh0Nl2jpIGoP
         j9EXT2uSd/aFSIsx10vtpdXtOgPKVaDwgynhpMwv0vi9mU0h7ivfTJAe0x2mgAhbm9pt
         WuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82AfxM9iWnmVbmHsCRPs5CDEdlL0ZgkL1CBgzMeozWA=;
        b=HSFJLTC9OkisM5rxCzI2RH85/d2NvPxinY3WePSrLOFtpJHtKtxapl/VslIiN2h1D7
         CBBDZ9RQiX5wVVEu17e8RopnGOJDIK2z/asjqzeD/5t2gTfAuCmYS9SHFykGWrz/spbZ
         WRv0wW6L3pAh7D1bma7GHMSCH9pBrXPa1FdW9BlKF4OcUL3wZSNsCB2kBsUxNowo+Fyn
         PT1o01NidQwV98m9iSEvUtt/330B48WkbsPBRk588hCLFS96QA0uuBMcafD9Nh6nz3+3
         O8dANj8+oXz+oGvRMTft5d+8N4GsrQhCdvGY4/ZLRAkxaVDIkfoPztbEfESWmhkHc/7P
         2nwQ==
X-Gm-Message-State: AOAM530L3lGuWraVlxm22YLmMCQE9lIF+5TTeC9+fXSzjiIXGmdmLXju
        UsFnGtZXdrwvveTE/7iUM4XSn9iF6JtfI2fMlVbdLg==
X-Google-Smtp-Source: ABdhPJwAQvb3ghxoP3pI5m1Z3v3jw3I83xYnaaMv5u9LKgogJDBAjewC7noL1WOiyI1NsyN7W0n+XT8qU92gaoiinQU=
X-Received: by 2002:a25:943:0:b0:633:883b:3e21 with SMTP id
 u3-20020a250943000000b00633883b3e21mr2284628ybm.132.1647391445249; Tue, 15
 Mar 2022 17:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220315042355.362810-1-luofei@unicloud.com> <CAMZfGtWjnhZLVmRD0BSpMbAWr_vD5BCj5s0ARfNHpHeAAGWYjA@mail.gmail.com>
 <a56e0ea8-3b11-8239-d39c-ed33e479427e@oracle.com>
In-Reply-To: <a56e0ea8-3b11-8239-d39c-ed33e479427e@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Mar 2022 08:42:14 +0800
Message-ID: <CAMZfGtUP-Uczx+fiP+28HnPjsGNSvCF5SR87war=MGzbmzBn4Q@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: fix description about atomic allocation of
 vmemmap pages when free huge page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     luofei <luofei@unicloud.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 5:16 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 3/15/22 06:29, Muchun Song wrote:
> > On Tue, Mar 15, 2022 at 12:24 PM luofei <luofei@unicloud.com> wrote:
> >>
> >> No matter what context update_and_free_page() is called in,
> >> the flag for allocating the vmemmap page is fixed
> >> (GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE), and no atomic
> >> allocation is involved, so the description of atomicity here
> >> is somewhat inappropriate.
> >>
> >> and the atomic parameter naming of update_and_free_page() is
> >> somewhat misleading.
> >>
> >> Signed-off-by: luofei <luofei@unicloud.com>
> >> ---
> >>  mm/hugetlb.c | 10 ++++------
> >>  1 file changed, 4 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index f8ca7cca3c1a..239ef82b7897 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1570,8 +1570,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
> >>
> >>  /*
> >>   * As update_and_free_page() can be called under any context, so we cannot
> >> - * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
> >> - * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
> >> + * use GFP_ATOMIC to allocate vmemmap pages. However, we can defer the
> >> + * actual freeing in a workqueue to prevent waits caused by allocating
> >>   * the vmemmap pages.
> >>   *
> >>   * free_hpage_workfn() locklessly retrieves the linked list of pages to be
> >> @@ -1617,16 +1617,14 @@ static inline void flush_free_hpage_work(struct hstate *h)
> >>  }
> >>
> >>  static void update_and_free_page(struct hstate *h, struct page *page,
> >> -                                bool atomic)
> >> +                                bool delay)
> >
> > Hi luofei,
> >
> > At least, I don't agree with this change.  The "atomic" means if the
> > caller is under atomic context instead of whether using atomic
> > GFP_MASK.  The "delay" seems to tell the caller that it can undelay
> > the allocation even if it is under atomic context (actually, it has no
> > choice).  But "atomic" can indicate the user is being asked to tell us
> > if it is under atomic context.
>
> There may be some confusion since GFP_ATOMIC is mentioned in the comments
> and GFP_ATOMIC is not used in the allocation of vmemmap pages.  IIRC,
> the use of GFP_ATOMIC was discussed at one time but dismissed because of
> undesired side effects such as dipping into "atomic reserves".
>
> How about an update to the comments as follows (sorry mailer may mess up
> formatting)?
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f8ca7cca3c1a..6a4d27e24b21 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1569,10 +1569,12 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  }
>
>  /*
> - * As update_and_free_page() can be called under any context, so we cannot
> - * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
> - * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
> - * the vmemmap pages.
> + * Freeing hugetlb pages in done in update_and_free_page().  When freeing a
> + * hugetlb page, vmemmap pages may need to be allocated.  The routine
> + * alloc_huge_page_vmemmap() can possibly sleep as it uses GFP_KERNEL.
> + * However, update_and_free_page() can be called under any context.  To
> + * avoid the possibility of sleeping in a context where sleeping is not
> + * allowed, defer the actual freeing in a workqueue where sleeping is allowed.
>   *
>   * free_hpage_workfn() locklessly retrieves the linked list of pages to be
>   * freed and frees them one-by-one. As the page->mapping pointer is going
> @@ -1616,6 +1618,10 @@ static inline void flush_free_hpage_work(struct hstate *h)
>                 flush_work(&free_hpage_work);
>  }
>
> +/*
> + * atomic == true indicates called from a context where sleeping is
> + * not allowed.
> + */
>  static void update_and_free_page(struct hstate *h, struct page *page,
>                                  bool atomic)
>  {
> @@ -1625,7 +1631,8 @@ static void update_and_free_page(struct hstate *h, struct page *page,
>         }
>
>         /*
> -        * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
> +        * Defer freeing to avoid possible sleeping when allocating
> +        * vmemmap pages.
>          *
>          * Only call schedule_work() if hpage_freelist is previously
>          * empty. Otherwise, schedule_work() had been called but the workfn
>

LGTM. Thanks Mike.
