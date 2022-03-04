Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3744CCC1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiCDDN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiCDDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:13:56 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF2B2E16
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:13:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id yy13so5854004ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 19:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2tjHudClzP6uv3cMrI69fVLZFBQkgyyeXuaq1ZBH24=;
        b=ltbve/s2pob2R9jiZUzt0ic2ZBkBaxCjviP8mgn55L3q2tB/qv0r4RJ5MJA5vbCNY+
         mtqQTzfBDVmJM/+lQOzOSMDcP6RTtfR1dzvWWNf5NN4PO4urUlsqKjfUc8wZPjcImYKc
         0H8tB507WyYi9qoaaP6RfUda4jVogmrmH8vDWTsJlAANnSI2qP1sqdYtbYBu6605qRbB
         R63v+0ksDuP48x8xvfHQ5oDUXfg+iRrqCcVn+4UDFDldbHfDtHPb2AQ/XO/sVXvQ/Pc3
         U4xRQICfbK7IpQzQRRraoPRJkltkaNfMJHCcB9HE3EcAW5tdX9R54vq2s2tZyMnoSrAD
         pYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2tjHudClzP6uv3cMrI69fVLZFBQkgyyeXuaq1ZBH24=;
        b=qmQjDCyCu0y+sbeSLI+3ll50grbvzAqqD5T7nIbJcWkB3SF37CyGnVgZjwixJ4cV3F
         FVhiyPQZMO4T8eJ7P3FJeim6/3ovTtFASXg7A3rzQxJYiOd6I/+xa1BXqb6cePGPXn07
         Eh0NcF0bS1tH/Fb6nZirGxzUJNnr8YhjeIk4QVcMC8/jn4ZG6ACyBCMzEzumCyi38E/e
         1IqmXGxoouEI8fmHsbDj4mYTTpW1KS3NK5T9x35gw7Fj+qHgi90oSZbMyTz/bCiuujM7
         G32MrtCD5xGRBBKiVwRpw8do7wkqP3obzGjazLRoae+kmReOeqFsRDKG9BkSQtFOtwkT
         EJEw==
X-Gm-Message-State: AOAM5301I6qCWaXr0jfjWH7DuMDPu8zUXR0FJwkDpHmoRCKlr3yQXTEv
        7QI4Fizzv4Nk3mMiLW0LZvt5NT4RQVFDfAVXHcY=
X-Google-Smtp-Source: ABdhPJxSp4jfTsn56gIeof17rCmCcIuhSCOpE1s1ouTFdd2E1JDvbsOxDwaan29+TVCjqG9xeP322TckuYusKO7s7ak=
X-Received: by 2002:a17:906:3a4f:b0:6cf:86e0:586c with SMTP id
 a15-20020a1709063a4f00b006cf86e0586cmr29541511ejf.626.1646363587256; Thu, 03
 Mar 2022 19:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20220303222014.517033-1-shy828301@gmail.com> <78dab4e0-1d68-c54b-2463-c0a5420b07d9@huawei.com>
In-Reply-To: <78dab4e0-1d68-c54b-2463-c0a5420b07d9@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Mar 2022 19:12:55 -0800
Message-ID: <CAHbLzkpbnQyHRckoRtbZoaLvANu92MY4kEsbKudaQ8MDUA3nVg@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting PMD
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Thu, Mar 3, 2022 at 6:25 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/4 6:20, Yang Shi wrote:
> > The commit c444eb564fb1 ("mm: thp: make the THP mapcount atomic against
> > __split_huge_pmd_locked()") locked the page for PMD split to make
> > mapcount stable for reuse_swap_page(), then commit 1c2f67308af4 ("mm:
> > thp: fix MADV_REMOVE deadlock on shmem THP") reduce the scope to
> > anonymous page only.
> >
> > However COW has not used mapcount to determine if the page is shared or
> > not anymore due to the COW fixes [1] from David Hildenbrand and the
> > reuse_swap_page() was removed as well.  So PMD split doesn't have to
> > lock the page anymore.  This patch basically reverted the above two
> > commits.
> >
>
> Sounds reasonable. Since mapcount is not used to determine if we need to COW
> the page, PMD split doesn't have to lock the page anymore.
>
> > [1] https://lore.kernel.org/linux-mm/20220131162940.210846-1-david@redhat.com/
> >
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/huge_memory.c | 44 +++++---------------------------------------
> >  1 file changed, 5 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b49e1a11df2e..daaa698bd273 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2134,8 +2134,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >  {
> >       spinlock_t *ptl;
> >       struct mmu_notifier_range range;
> > -     bool do_unlock_folio = false;
> > -     pmd_t _pmd;
> >
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> >                               address & HPAGE_PMD_MASK,
> > @@ -2148,48 +2146,16 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> >        * pmd against. Otherwise we can end up replacing wrong folio.
> >        */
> >       VM_BUG_ON(freeze && !folio);
> > -     if (folio) {
> > -             VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > -             if (folio != page_folio(pmd_page(*pmd)))
> > -                     goto out;
> > -     }
> > +     if (folio && folio != page_folio(pmd_page(*pmd)))
> > +             goto out;
> >
> > -repeat:
> > -     if (pmd_trans_huge(*pmd)) {
> > -             if (!folio) {
> > -                     folio = page_folio(pmd_page(*pmd));
> > -                     /*
> > -                      * An anonymous page must be locked, to ensure that a
> > -                      * concurrent reuse_swap_page() sees stable mapcount;
> > -                      * but reuse_swap_page() is not used on shmem or file,
> > -                      * and page lock must not be taken when zap_pmd_range()
> > -                      * calls __split_huge_pmd() while i_mmap_lock is held.
> > -                      */
> > -                     if (folio_test_anon(folio)) {
> > -                             if (unlikely(!folio_trylock(folio))) {
> > -                                     folio_get(folio);
> > -                                     _pmd = *pmd;
> > -                                     spin_unlock(ptl);
> > -                                     folio_lock(folio);
> > -                                     spin_lock(ptl);
> > -                                     if (unlikely(!pmd_same(*pmd, _pmd))) {
> > -                                             folio_unlock(folio);
> > -                                             folio_put(folio);
> > -                                             folio = NULL;
> > -                                             goto repeat;
> > -                                     }
> > -                                     folio_put(folio);
> > -                             }
> > -                             do_unlock_folio = true;
> > -                     }
> > -             }
> > -     } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> > +     if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
> >               goto out;
> > +
> >       __split_huge_pmd_locked(vma, pmd, range.start, freeze);
>
> IUUC, here should be something like below:
> if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd))
>         __split_huge_pmd_locked(vma, pmd, range.start, freeze);
>
> i.e. the pmd_trans_huge case is missing in the above change. Or am I miss something ?

Yes, you are definitely right. Must have pmd_trans_huge(*pmd).

>
> Thanks for the patch. This really simplify the code and avoid the unneeded overhead.
>
> >  out:
> >       spin_unlock(ptl);
> > -     if (do_unlock_folio)
> > -             folio_unlock(folio);
> > +
> >       /*
> >        * No need to double call mmu_notifier->invalidate_range() callback.
> >        * They are 3 cases to consider inside __split_huge_pmd_locked():
> >
>
