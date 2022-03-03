Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20184CC6CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiCCUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCCUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:09:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFC49F14
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:08:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w3so8047711edu.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWhW+YEtKAt25AZygKvKKjc7akmRR9ol+ClTeEq3Lbo=;
        b=IhaK1MCdFibrxiiYKMWtxOQzMJqlKexiy9nkBZphPO+tGMURXU9zv4kgOB1YX/UDOu
         qpzrrPE9/7Is64Tjw6dlXCGMAF6f6T9iLHFyT9wOu9pCFt4d2pifgRFSUvgD4rCbKnzo
         /YFQZuFmiGSVbJn09/1DxaNZ6h8T3uVRsAzNegiGma6nyvPuu2BGdxdcyAGMqitMzE1t
         RaONLcn5rEW1y3b05XCvt9G4f5/zFG0Bic1zEN+ANymJXXPLNFwlNSSkH6DnPrdTCEp4
         dQ51ai1gVWIV9AXbmYGEKdQAsX+kKsXXekH8UN9lIWCnueTyFpPa35IB3T2EgGbxZRTp
         XiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWhW+YEtKAt25AZygKvKKjc7akmRR9ol+ClTeEq3Lbo=;
        b=PR/TBiudLnAleX7pA0RbAQ2VOW3Ml0VcHUSJanWwD+xs279qLl4Tql1Hjx7nOWDx74
         pFbrIqyC2VctZz3Vm50eEltB2NHF4/QlXPyIwJAGFCtjcIrD85J8x4Hjs7rPIT+ZU6+b
         pvEdaO19r6ohhAKOuXC8B5y4YuyTEm8K6yFKZ83dnePYj1S9kL6CMGYv8EA/viXp1Z5I
         K2GuQLqFGu9hIXil1DDl4Vb5cMgJ5/jc7w0fRLuuddvajnYrPz9skoFXT2opzBVksiaQ
         Lp/PE1DhhWCdjGPyJFK9CaKIcq/BwF/AtFZqsFiRkWm6/0Kwz1j8yXlbkkbfmQqwOgSz
         IinQ==
X-Gm-Message-State: AOAM530ZTdkEnfUxey/OoqBEWSXHjm1QWq6IUcKnlhnmMT6LDR6URbNl
        +XPpQbUxgKhqfSD8E8ci5qfLTOWyJkyO/b9ieeFWayrs
X-Google-Smtp-Source: ABdhPJyWpNmagaVrWTlH/Le2wXtM87/a1EcwAsrEEtw1oF/pyNGsCesh8qEHkpkjr210cmrZhee+V8LWzy9t2BTw9ls=
X-Received: by 2002:aa7:d78e:0:b0:415:d787:6226 with SMTP id
 s14-20020aa7d78e000000b00415d7876226mr5146631edq.121.1646338096463; Thu, 03
 Mar 2022 12:08:16 -0800 (PST)
MIME-Version: 1.0
References: <e02e52a1-8550-a57c-ed29-f51191ea2375@google.com>
In-Reply-To: <e02e52a1-8550-a57c-ed29-f51191ea2375@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Mar 2022 12:08:04 -0800
Message-ID: <CAHbLzkpyJJH2XMMs25eaJuZ2Z8TOO5NS84WzC+2f6k2Y1-Np5g@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm/thp: fix NR_FILE_MAPPED accounting in page_*_file_rmap()
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

On Wed, Mar 2, 2022 at 5:46 PM Hugh Dickins <hughd@google.com> wrote:
>
> NR_FILE_MAPPED accounting in mm/rmap.c (for /proc/meminfo "Mapped" and
> /proc/vmstat "nr_mapped" and the memcg's memory.stat "mapped_file") is
> slightly flawed for file or shmem huge pages.
>
> It is well thought out, and looks convincing, but there's a racy case
> when the careful counting in page_remove_file_rmap() (without page lock)
> gets discarded.  So that in a workload like two "make -j20" kernel builds
> under memory pressure, with cc1 on hugepage text, "Mapped" can easily
> grow by a spurious 5MB or more on each iteration, ending up implausibly
> bigger than most other numbers in /proc/meminfo.  And, hypothetically,
> might grow to the point of seriously interfering in mm/vmscan.c's
> heuristics, which do take NR_FILE_MAPPED into some consideration.
>
> Fixed by moving the __mod_lruvec_page_state() down to where it will not
> be missed before return (and I've grown a bit tired of that oft-repeated
> but-not-everywhere comment on the __ness: it gets lost in the move here).
>
> Does page_add_file_rmap() need the same change?  I suspect not, because
> page lock is held in all relevant cases, and its skipping case looks safe;
> but it's much easier to be sure, if we do make the same change.
>
> Fixes: dd78fedde4b9 ("rmap: support file thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
> If this were thought serious enough to backport (I don't feel strongly,
> but it is something I keep in my own trees), it needs a little more care
> near "out", because the mm/munlock series has removed some action there.
>
>  mm/rmap.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1238,14 +1238,14 @@ void page_add_new_anon_rmap(struct page *page,
>  void page_add_file_rmap(struct page *page,
>         struct vm_area_struct *vma, bool compound)
>  {
> -       int i, nr = 1;
> +       int i, nr = 0;
>
>         VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
>         lock_page_memcg(page);
>         if (compound && PageTransHuge(page)) {
>                 int nr_pages = thp_nr_pages(page);
>
> -               for (i = 0, nr = 0; i < nr_pages; i++) {
> +               for (i = 0; i < nr_pages; i++) {
>                         if (atomic_inc_and_test(&page[i]._mapcount))
>                                 nr++;
>                 }
> @@ -1262,11 +1262,12 @@ void page_add_file_rmap(struct page *page,
>                         VM_WARN_ON_ONCE(!PageLocked(page));
>                         SetPageDoubleMap(compound_head(page));
>                 }
> -               if (!atomic_inc_and_test(&page->_mapcount))
> -                       goto out;
> +               if (atomic_inc_and_test(&page->_mapcount))
> +                       nr++;
>         }
> -       __mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
>  out:
> +       if (nr)
> +               __mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
>         unlock_page_memcg(page);
>
>         mlock_vma_page(page, vma, compound);
> @@ -1274,7 +1275,7 @@ void page_add_file_rmap(struct page *page,
>
>  static void page_remove_file_rmap(struct page *page, bool compound)
>  {
> -       int i, nr = 1;
> +       int i, nr = 0;
>
>         VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>
> @@ -1289,12 +1290,12 @@ static void page_remove_file_rmap(struct page *page, bool compound)
>         if (compound && PageTransHuge(page)) {
>                 int nr_pages = thp_nr_pages(page);
>
> -               for (i = 0, nr = 0; i < nr_pages; i++) {
> +               for (i = 0; i < nr_pages; i++) {
>                         if (atomic_add_negative(-1, &page[i]._mapcount))
>                                 nr++;
>                 }
>                 if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
> -                       return;
> +                       goto out;
>                 if (PageSwapBacked(page))
>                         __mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
>                                                 -nr_pages);
> @@ -1302,16 +1303,12 @@ static void page_remove_file_rmap(struct page *page, bool compound)
>                         __mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
>                                                 -nr_pages);
>         } else {
> -               if (!atomic_add_negative(-1, &page->_mapcount))
> -                       return;
> +               if (atomic_add_negative(-1, &page->_mapcount))
> +                       nr++;
>         }
> -
> -       /*
> -        * We use the irq-unsafe __{inc|mod}_lruvec_page_state because
> -        * these counters are not modified in interrupt context, and
> -        * pte lock(a spinlock) is held, which implies preemption disabled.
> -        */
> -       __mod_lruvec_page_state(page, NR_FILE_MAPPED, -nr);
> +out:
> +       if (nr)
> +               __mod_lruvec_page_state(page, NR_FILE_MAPPED, -nr);
>  }
>
>  static void page_remove_anon_compound_rmap(struct page *page)
