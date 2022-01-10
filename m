Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63784898B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbiAJMgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbiAJMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:36:16 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31259C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:36:15 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id u6so23198469uaq.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 04:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFOfaEvokfZV1EFTfIDgkQYCii1N7VmjLFzadFiYr08=;
        b=OWQBLpWCvBUPWP+FHu4XAALHaLD+dPwxfeKnbhpD4AHdmHJDjhuo97g+3ZspdOwYQm
         nTYlJ7DEJsS7W1UnkbxqPdomss0M8VD/H8tAzQkhtrcIZRT7uHyEva5ykUFpsiqbUsgK
         ih+VzNHukOrJQkUjXET57SmdPwz7X7gVOgS3oCUz71Evv5QVX8lSD9YYw79q12YDm5p8
         1PaohPR1UhkJcTX2SZ7VneYDxg5YRDhFYBmgHMeUSDixBNbtEub3SFIZF3Tvk2Vy34hD
         XoFs12/ioEQ9Ohy+R+wPcp2xVurTM7zp+WSGlpyXkWV7dAKnRxzrkrwes99FCLw8UYny
         L/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFOfaEvokfZV1EFTfIDgkQYCii1N7VmjLFzadFiYr08=;
        b=UxkQrlSS4/PGzhPMNbxCBh3sfy5NmL4wYSQvxsY4Usw9kvxvQIZIZKnzWnqcl8J0Rp
         pkrb4seDh89eLV3SeKlt4SGaEJK+YA3JckFRVR1BpZr9jbRPALj4EkWc2FKaqeCDxSiL
         uKLjwqJ+oPvdePNhJOtHbFDnZXBTMkjV/ZH3Un8Sj2vn0fZACZZJjX+oe5OSEruLqjb/
         eae7MhSbr8QngisS81bwTM0+HYMbx91rlfjLa2xpsBC78J7sTY7EPDatBKtoYsghZygY
         clz6zpwBC8tlo35YiM4TfMarLoI6kh3yzl8PI74ZayaIVy2dfXA5dArZIhM4VTFUijOd
         MdoQ==
X-Gm-Message-State: AOAM531BQFvMEEF+2OFTWmQEdTv4+6D7QBYqsMbO+LAQTeK6INIgcV06
        r4/32VWYpPMSTRmwVbUUvMv0FXaPWGoF62ZWFRc=
X-Google-Smtp-Source: ABdhPJyf8+4K1X40XYLX6CA6YiAMIijTYfrHswTWu60IzHY/qXu3L67uo3anH53hXnEVh7YwelBqF4tj/z+87r06yoI=
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr1997159vsf.11.1641818174323;
 Mon, 10 Jan 2022 04:36:14 -0800 (PST)
MIME-Version: 1.0
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
In-Reply-To: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Mon, 10 Jan 2022 12:36:03 +0000
Message-ID: <CANe_+UiDXHgPOZoqT9yxLgTwkVmjA7OiXduP1R0qO2vCt=KKWQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Charan Teja Reddy <quic_charante@quicinc.com>
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

On Thu, 6 Jan 2022 at 17:06, Charan Teja Reddy
<quic_charante@quicinc.com> wrote:
>
> From: Charan Teja Reddy <charante@codeaurora.org>
>
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
...
> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
> +                               loff_t end, struct list_head *list)
> +{
> +       XA_STATE(xas, &mapping->i_pages, start);
> +       struct page *page;
> +
> +       rcu_read_lock();
> +       xas_for_each(&xas, page, end) {
> +               if (xas_retry(&xas, page))
> +                       continue;
> +               if (xa_is_value(page))
> +                       continue;
> +               if (!get_page_unless_zero(page))
> +                       continue;
> +               if (isolate_lru_page(page))
> +                       continue;

Need to unwind the get_page on failure to isolate.

Should PageUnevicitable() pages (SHM_LOCK) be skipped?
(That is, does SHM_LOCK override DONTNEED?)

...
> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
> +                               loff_t end)
> +{
> +       int ret;
> +       struct page *page;
> +       LIST_HEAD(list);
> +       struct writeback_control wbc = {
> +               .sync_mode = WB_SYNC_NONE,
> +               .nr_to_write = LONG_MAX,
> +               .range_start = 0,
> +               .range_end = LLONG_MAX,
> +               .for_reclaim = 1,
> +       };
> +
> +       if (!shmem_mapping(mapping))
> +               return -EINVAL;
> +
> +       if (!total_swap_pages)
> +               return 0;
> +
> +       lru_add_drain();
> +       shmem_isolate_pages_range(mapping, start, end, &list);
> +
> +       while (!list_empty(&list)) {
> +               page = lru_to_page(&list);
> +               list_del(&page->lru);
> +               if (page_mapped(page))
> +                       goto keep;
> +               if (!trylock_page(page))
> +                       goto keep;
> +               if (unlikely(PageTransHuge(page))) {
> +                       if (split_huge_page_to_list(page, &list))
> +                               goto keep;
> +               }

I don't know the shmem code and the lifecycle of a shm-page, so
genuine questions;
When the try-lock succeeds, should there be a test for PageWriteback()
(page skipped if true)?  Also, does page->mapping need to be tested
for NULL to prevent races with deletion from the page-cache?

...
> +
> +               clear_page_dirty_for_io(page);
> +               SetPageReclaim(page);
> +               ret = shmem_writepage(page, &wbc);
> +               if (ret || PageWriteback(page)) {
> +                       if (ret)
> +                               unlock_page(page);
> +                       goto keep;
> +               }
> +
> +               if (!PageWriteback(page))
> +                       ClearPageReclaim(page);
> +
> +               /*
> +                * shmem_writepage() place the page in the swapcache.
> +                * Delete the page from the swapcache and release the
> +                * page.
> +                */
> +               __mod_node_page_state(page_pgdat(page),
> +                               NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
> +               lock_page(page);
> +               delete_from_swap_cache(page);
> +               unlock_page(page);
> +               put_page(page);
> +               continue;
> +keep:
> +               putback_lru_page(page);
> +               __mod_node_page_state(page_pgdat(page),
> +                               NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
> +       }

The putback_lru_page() drops the last reference hold this code has on
'page'.  Is it safe to use 'page' after dropping this reference?

Cheers,
Mark
