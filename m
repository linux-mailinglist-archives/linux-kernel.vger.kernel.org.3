Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94CA51F375
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiEIE1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiEIEZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:25:38 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A0D5CC4
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:21:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ebf4b91212so131045507b3.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6o0Uik995yzG1w7JVfse+kra98IPXYjJG5F2pF4TKic=;
        b=ibOLlh6RmQZhKqv5XJlMc42zd3sWvBubvis7myJG8no9Bt38MZNP0xbMqAG1gF2ezX
         psJSukaKCqEVHp+UYj5aXqiSfOY5XMiX/fLWC02wqgRI5Uy6olX273yoYu9pAPfeQbzw
         AxmG4bh5uzuEhLqb+EzlH/Hd0XNWy0CO1afEhbVbLDgsQzJYSN7vKxjkoCjj9b/25AgH
         iUwPCzN7kaWrP/xrB90CtwgjBKwoyV+GWskNsX1TveNBrwfvGUEq0/Gf4wAcCkkBmgi0
         38Rtl7xMSgpDcDNkgtcqoxJRnKMFbowcI+2TsF+8zs7BIGyTOGD0OU3hfvEyOAJVLs7O
         l42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6o0Uik995yzG1w7JVfse+kra98IPXYjJG5F2pF4TKic=;
        b=oF/O/+xOADqZwFAsxyInf1TsIbeadobHEJfhrS9sxRUaXmZSG6qt65/nB6GqiC1MXl
         +eZ4OlLZ/kimMogpUhSDQdWJ3KM2b2k9yqfV4r2CIjFGIbFeDrz9HE1Vj5obYwG8cnw2
         TjOnq8CAfsbdZMxrhwe30wODOV0xIS5gtJSndK83MC2a0rtOHHSkhXvDtfKbndJEL30k
         fT3cP7Y2t3cJDTDR56P8WynAJHTXf5WIV9YGhVr+NsH1cHYe9EYvOM7eMYXN1Zb0liKc
         9WONoFw/UNINbh9+7PtZM7g/F3ptT3PqC6i46MkHulxx19/Zf0SuODSHapQemCYXbAcy
         HfWA==
X-Gm-Message-State: AOAM532auXGDYWhtJpo5CuRXNGym4lSLpbMvffMJlZBsxSxG4/OHfzwa
        qErigM6dkcXFzZ3q5qf9RepXH4MTQCk/sGeQ7+jCxw==
X-Google-Smtp-Source: ABdhPJySu0XRvPOatCo+tSO/VW8eZMm17WuYTUg2UQ1vOofroZ5K5T8cW9N/OFNOyWr+XrYq2AJaaEu7OFtCGaZODvI=
X-Received: by 2002:a81:7b05:0:b0:2f4:e45a:b06e with SMTP id
 w5-20020a817b05000000b002f4e45ab06emr12223967ywc.458.1652070103623; Sun, 08
 May 2022 21:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220425132723.34824-1-linmiaohe@huawei.com> <20220425132723.34824-4-linmiaohe@huawei.com>
 <YmvNqWhC0uBwJ2yF@FVFYT0MHHV2J.usts.net> <09ccdbac-c267-15de-0d81-57e211dea6d2@huawei.com>
In-Reply-To: <09ccdbac-c267-15de-0d81-57e211dea6d2@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 9 May 2022 12:21:06 +0800
Message-ID: <CAMZfGtVeFj_qh6e7DzNnN7jdXwXhBwqxPCwnq26V2ziHDxTiFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm/migration: return errno when isolate_huge_page failed
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Huang Ying <ying.huang@intel.com>,
        Christoph Hellwig <hch@lst.de>, dhowells@redhat.com,
        Christoph Lameter <cl@linux.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 11:24 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/4/29 19:36, Muchun Song wrote:
> > On Mon, Apr 25, 2022 at 09:27:22PM +0800, Miaohe Lin wrote:
> >> We might fail to isolate huge page due to e.g. the page is under migration
> >> which cleared HPageMigratable. So we should return -EBUSY in this case
> >> rather than always return 1 which could confuse the user. Also we make
> >> the prototype of isolate_huge_page consistent with isolate_lru_page to
> >> improve the readability.
> >>
> >> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
> >> Suggested-by: Huang Ying <ying.huang@intel.com>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  include/linux/hugetlb.h |  6 +++---
> >>  mm/gup.c                |  2 +-
> >>  mm/hugetlb.c            | 11 +++++------
> >>  mm/memory-failure.c     |  2 +-
> >>  mm/mempolicy.c          |  2 +-
> >>  mm/migrate.c            |  5 +++--
> >>  6 files changed, 14 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> >> index 04f0186b089b..306d6ef3fa22 100644
> >> --- a/include/linux/hugetlb.h
> >> +++ b/include/linux/hugetlb.h
> >> @@ -170,7 +170,7 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
> >>                                              vm_flags_t vm_flags);
> >>  long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
> >>                                              long freed);
> >> -bool isolate_huge_page(struct page *page, struct list_head *list);
> >> +int isolate_huge_page(struct page *page, struct list_head *list);
> >>  int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
> >>  int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
> >>  void putback_active_hugepage(struct page *page);
> >> @@ -376,9 +376,9 @@ static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
> >>      return NULL;
> >>  }
> >>
> >> -static inline bool isolate_huge_page(struct page *page, struct list_head *list)
> >> +static inline int isolate_huge_page(struct page *page, struct list_head *list)
> >
> > Since you already touched all the call sites, how about renaming this
> > to hugetlb_isolate()? I've always felt that huge_page is not a
> > straightforward and clear name since we also have another type of
> > huge page (THP).  I think hugetlb is more specific.
> >
>
> Sorry for late respond. This suggestion looks good to me. But is isolate_hugetlb more suitable?
> This could make it more consistent with isolate_lru_page? What do you think?
>

There is also a function named folio_isolate_lru(). My initial consideration was
making it consistent with folio_isolate_lru(). isolate_hugetlb looks good to me
as well.

Thanks.
