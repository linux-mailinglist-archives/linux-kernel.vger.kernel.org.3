Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9D4CC6D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiCCUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiCCUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:13:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693513D6E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:12:33 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q17so8087270edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcjhnNvk1HWEeyW9eNcGg5KkoFIvCyZIDJD6HTvONRQ=;
        b=YOylv/btveKLuQVvZ1kmA2nj40j6cCDUvggt8BbMmKeBkTyAOHyLgNsJRu6ROaXisM
         V2vtj7I8AOYH9YOIPGbro3VPAlBm9udiUwtqMIkRhaeYKYT5AhxzZKFLkKxBuvJFXi00
         3I81CH3usIWzaSVeByuzTMz0WYLmKdFjccG8fXNEb7wYhdtZjXOjcQBLgzRYeOTDJ9jy
         QEuEE4IGsDgZ2kLgRNL6XRzVRRCCxF4qfejNyTHUQmeD2AzIeHZIbCTB+5bJovY3yCSY
         33wVXwk9953GUG+W/cpCjMAXiwSTZ8tJ4MBfJyPVZygoa0yX2BtNMa4+zPIwinbkJX1g
         r6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcjhnNvk1HWEeyW9eNcGg5KkoFIvCyZIDJD6HTvONRQ=;
        b=uuqei9ewKqL8khJW+9d1pt841b8u3GmOYF6D67hojCUp9n3t5x0NxQFlUQAcsnSu4l
         EaRxkrFuaFw/lmjDH95DFNghKjnchRt0frmH7eQuLXNLfqY813dZIllFmtpIMtwVMyGb
         Yr8LRK0QaDB4YUlaFwVREbMJM70jbq0mFnz92V5Lgz7e+U96th0wJv10bZSk07azCqdV
         AKHvmoilZCorl+r0EG+Hqu9zS+fgyk7r0OjIHRbiV5fUryVhuwgIwUlTFrKrX9P5L8oY
         CCOc2904welB1rdTl8/o3rpnP4dD2Jy+CzbeFE5s4kPTMfBRWlCgKoTaXfY5axdNw4uR
         eBAQ==
X-Gm-Message-State: AOAM530X6CcCqC5fZ2vrpoP9ZOuNxuxVne0Jj0nRexEUlStNOLhQyj3S
        qi0suug5sQ6mVzLYrTMka2INx9l8fL47s6XZLzWswFW7
X-Google-Smtp-Source: ABdhPJwGtbxb4HK/7M1I5Bs0jN/kCcFZ97zNwP/45VWZGjZwIcedLJ6e3lYx0rKQWOemFOH50WkV7oRnSEupZ1rX0t8=
X-Received: by 2002:a05:6402:2987:b0:414:39b0:7fc1 with SMTP id
 eq7-20020a056402298700b0041439b07fc1mr15149857edb.214.1646338352492; Thu, 03
 Mar 2022 12:12:32 -0800 (PST)
MIME-Version: 1.0
References: <61c5cf99-a962-9a25-597a-53ab1bd8fbc0@google.com>
In-Reply-To: <61c5cf99-a962-9a25-597a-53ab1bd8fbc0@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Mar 2022 12:12:20 -0800
Message-ID: <CAHbLzkpt8oSsmwFPPpYMPbszNipnAE0OMHnXtMGYBDDrTyP3Cw@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm/thp: ClearPageDoubleMap in first page_add_file_rmap()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 5:50 PM Hugh Dickins <hughd@google.com> wrote:
>
> PageDoubleMap is maintained differently for anon and for shmem+file:
> the shmem+file one was never cleared, because a safe place to do so
> could not be found; so it would blight future use of the cached
> hugepage until evicted.
>
> See https://lore.kernel.org/lkml/1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com/
>
> But page_add_file_rmap() does provide a safe place to do so (though
> later than one might wish): allowing testing to return to an initial
> state without a damaging drop_caches.
>
> Fixes: 9a73f61bdb8a ("thp, mlock: do not mlock PTE-mapped file huge pages")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>
>  mm/rmap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1251,6 +1251,17 @@ void page_add_file_rmap(struct page *page,
>                 }
>                 if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
>                         goto out;
> +
> +               /*
> +                * It is racy to ClearPageDoubleMap in page_remove_file_rmap();
> +                * but page lock is held by all page_add_file_rmap() compound
> +                * callers, and SetPageDoubleMap below warns if !PageLocked:
> +                * so here is a place that DoubleMap can be safely cleared.
> +                */
> +               VM_WARN_ON_ONCE(!PageLocked(page));
> +               if (nr == nr_pages && PageDoubleMap(page))
> +                       ClearPageDoubleMap(page);

Nice idea!

Reviewed-by: Yang Shi <shy828301@gmail.com>

> +
>                 if (PageSwapBacked(page))
>                         __mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
>                                                 nr_pages);
