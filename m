Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5435548C34E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352929AbiALLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiALLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:38:35 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2DC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:38:35 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id m90so4187547uam.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 03:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DEEfnie0vnnwjJJqvtN1m52MNlAVFRLyqxTljyILzzU=;
        b=ELzMipdt0s8Dg3jkR89PaA4vJLjw0vvDktOsF0rEIB6Dqwm5hUOvDxSWbSMOkm7pao
         JSrYniF4ldRtdGhNUWk4gb4Tr3/2qvj2xX1ywe58nA/6b+SAK3pPCKtUaVj2d2waR/Dk
         6gkpVSIhzyYGxCAfzIAoS2teAK1zDadRItpatbGHXKHnWz0dnHryK+GbTNR//alrEf/o
         hswJzmJYkw4+FCgytrnAdZ+oMLehle4nGkINTSrt+FkvWm23dFVH9+01POpMdEy/bImf
         ydrVyYlGFmKPnoMKBcV0CPaxIZmdOKeaHEwhZUKmb74uCWHXBJOCCy3xJsdN8rtOMNHJ
         KGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEEfnie0vnnwjJJqvtN1m52MNlAVFRLyqxTljyILzzU=;
        b=TUY39dZtau/WmpbX3GFELRAdL9gdq0M1iLOa4r/MbHblG1AgQThCtXLwUBfE3xSpMA
         SlRtZOsVoMcgtGGTYRW7rEarty04GrsAdsuc73T6t8UZt11ltCSWwmn+rbZkAkGh8Cpc
         /JVvugHZAkguVqrYdk/IiJbIKRe6mIVDIr/6eirj9gtXWOz4hrLdtikhUJJfXIEawnU+
         BUftqYm9ECuN0I9k+ozHYpZx4UCzimx+YhZN1OUbX2sCfTqg/5923MoaTcZBOQNuEGpS
         HrnP5a0mL3aaBTFpzXz3ZCXCgEUoLGZ+1G4eoINCDBHEEBhqClqpmv1WVRqC92xpCsA6
         G8LA==
X-Gm-Message-State: AOAM533RBiovuC+g+JiNMwULBX/To6L6VL4XIgGvdphYlj3NyxYEWh3K
        gqaiSre4cnImVM8ddDudrdGhm30XyXBwpIzwjhg=
X-Google-Smtp-Source: ABdhPJwTLbCDe+A/QJBTG6EEDh7AA2NWzOiY4c8fw5spWCrI7u88VSJ9N0ZCc/iuculqL20fpyRLhMNdG7uE+k0Mdb4=
X-Received: by 2002:a05:6102:2923:: with SMTP id cz35mr3836997vsb.25.1641987514159;
 Wed, 12 Jan 2022 03:38:34 -0800 (PST)
MIME-Version: 1.0
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
 <CANe_+UiDXHgPOZoqT9yxLgTwkVmjA7OiXduP1R0qO2vCt=KKWQ@mail.gmail.com> <c19b1c9e-6351-6e71-d472-5ccd39885984@quicinc.com>
In-Reply-To: <c19b1c9e-6351-6e71-d472-5ccd39885984@quicinc.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Wed, 12 Jan 2022 11:38:23 +0000
Message-ID: <CANe_+Uj+ccUSaCcU_+XixuM9eJkrh3M1TOCMB5D=8rpUxUM0JA@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, vbabka@suse.cz,
        rientjes@google.com, mhocko@suse.com,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 at 15:14, Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Thanks again Mark for the review comments!!
>
> On 1/10/2022 6:06 PM, Mark Hemment wrote:
> > On Thu, 6 Jan 2022 at 17:06, Charan Teja Reddy
> > <quic_charante@quicinc.com> wrote:
> >>
> >> From: Charan Teja Reddy <charante@codeaurora.org>
> >>
> >> Currently fadvise(2) is supported only for the files that doesn't
> >> associated with noop_backing_dev_info thus for the files, like shmem,
> >> fadvise results into NOP. But then there is file_operations->fadvise()
> >> that lets the file systems to implement their own fadvise
> >> implementation. Use this support to implement some of the POSIX_FADV_XXX
> >> functionality for shmem files.
> > ...
> >> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
> >> +                               loff_t end, struct list_head *list)
> >> +{
> >> +       XA_STATE(xas, &mapping->i_pages, start);
> >> +       struct page *page;
> >> +
> >> +       rcu_read_lock();
> >> +       xas_for_each(&xas, page, end) {
> >> +               if (xas_retry(&xas, page))
> >> +                       continue;
> >> +               if (xa_is_value(page))
> >> +                       continue;
> >> +               if (!get_page_unless_zero(page))
> >> +                       continue;
> >> +               if (isolate_lru_page(page))
> >> +                       continue;
> >
> > Need to unwind the get_page on failure to isolate.
>
> Will be done.
>
> >
> > Should PageUnevicitable() pages (SHM_LOCK) be skipped?
> > (That is, does SHM_LOCK override DONTNEED?)
>
>
> Should be skipped. Will be done.
>
> >
> > ...
> >> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
> >> +                               loff_t end)
> >> +{
> >> +       int ret;
> >> +       struct page *page;
> >> +       LIST_HEAD(list);
> >> +       struct writeback_control wbc = {
> >> +               .sync_mode = WB_SYNC_NONE,
> >> +               .nr_to_write = LONG_MAX,
> >> +               .range_start = 0,
> >> +               .range_end = LLONG_MAX,
> >> +               .for_reclaim = 1,
> >> +       };
> >> +
> >> +       if (!shmem_mapping(mapping))
> >> +               return -EINVAL;
> >> +
> >> +       if (!total_swap_pages)
> >> +               return 0;
> >> +
> >> +       lru_add_drain();
> >> +       shmem_isolate_pages_range(mapping, start, end, &list);
> >> +
> >> +       while (!list_empty(&list)) {
> >> +               page = lru_to_page(&list);
> >> +               list_del(&page->lru);
> >> +               if (page_mapped(page))
> >> +                       goto keep;
> >> +               if (!trylock_page(page))
> >> +                       goto keep;
> >> +               if (unlikely(PageTransHuge(page))) {
> >> +                       if (split_huge_page_to_list(page, &list))
> >> +                               goto keep;
> >> +               }
> >
> > I don't know the shmem code and the lifecycle of a shm-page, so
> > genuine questions;
> > When the try-lock succeeds, should there be a test for PageWriteback()
> > (page skipped if true)?  Also, does page->mapping need to be tested
> > for NULL to prevent races with deletion from the page-cache?
>
> I failed to envisage it. I should have considered both these conditions
> here. BTW, I am just thinking about why we shouldn't use
> reclaim_pages(page_list) function here with an extra set_page_dirty() on
> a page that is isolated? It just call the shrink_page_list() where all
> these conditions are properly handled. What is your opinion here?

Should be possible to use reclaim_pages() (I haven't look closely).
It might actually be good to use this function, as will do some
congestion throttling.  Although it will always try to unmap
pages (note: your page_mapped() test is 'unstable' as done without the
page locked), so might give behaviour you want to avoid.
Note: reclaim_pages() is already used for madvise(PAGEOUT).  The shmem
code would need to prepare page(s) to help shrink_page_list() to make
progress (see madvise.c:madvise_cold_or_pageout_pte_range()).

Taking a step back; is fadvise(DONTNEED) really needed/wanted?  Yes,
you gave a usecase (which I cut from this thread in my earlier reply),
but I'm not familiar with various shmem uses to know if this feature
is needed.  Someone else will need to answer this.

Cheers,
Mark

>
> >
> > ...
> >> +
> >> +               clear_page_dirty_for_io(page);
> >> +               SetPageReclaim(page);
> >> +               ret = shmem_writepage(page, &wbc);
> >> +               if (ret || PageWriteback(page)) {
> >> +                       if (ret)
> >> +                               unlock_page(page);
> >> +                       goto keep;
> >> +               }
> >> +
> >> +               if (!PageWriteback(page))
> >> +                       ClearPageReclaim(page);
> >> +
> >> +               /*
> >> +                * shmem_writepage() place the page in the swapcache.
> >> +                * Delete the page from the swapcache and release the
> >> +                * page.
> >> +                */
> >> +               __mod_node_page_state(page_pgdat(page),
> >> +                               NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
> >> +               lock_page(page);
> >> +               delete_from_swap_cache(page);
> >> +               unlock_page(page);
> >> +               put_page(page);
> >> +               continue;
> >> +keep:
> >> +               putback_lru_page(page);
> >> +               __mod_node_page_state(page_pgdat(page),
> >> +                               NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
> >> +       }
> >
> > The putback_lru_page() drops the last reference hold this code has on
> > 'page'.  Is it safe to use 'page' after dropping this reference?
>
> True. Will correct it in the next revision.
>
> >
> > Cheers,
> > Mark
> >
