Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105124CDC80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbiCDSbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiCDSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:31:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F081D3AE2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:30:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id bd1so8464529plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4TXeZfUVYIjCnHQMV6GLGvwrY0CWJzDnslUJHUckzkQ=;
        b=JbrcThimgiaKc5S2YQMaLPzVI7b4VpmiL4LZyRwYBbYzH35zGMw49m0tLZRCurJ9QP
         F74959iH9i2Rkb6nxh59Zu2oQp03sindhh36rPwErHSj6CBwRTlbz740QEXrOfLk7GpE
         oOUJdvhK3UCpAqWFjXQiZ4vDwG5gMQUgz2H9LKLieqiMmteTFE1ZOOhVWGZIWa3NSgZC
         qXFk0I7pPC73+c3IqozDVhvEgAr7JgDlPGG+ZEWmN5bzWPhftUdk3B+cWpwJsKLfXgjS
         WCaMdevWEJGtkqmlgREDvYSdNsedckjjpxhS07+ERSFtstRzWvWwvWOt9jS0/oC7gOSP
         xxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4TXeZfUVYIjCnHQMV6GLGvwrY0CWJzDnslUJHUckzkQ=;
        b=zw5oJKmE1u4tijcfm4Gnpf8ao22G1/NgP7SbfSrrQ4TIoXl8ziZswN1NynjaCN/tJu
         byBnHIgSoOMdez61wWoHXqRxq5xrLPwE9+jJWK3tkFjW29TgBoOklcqC9BhmBSy7WVpE
         6wLnhyI2Uo6RH50rhSskI72lncwgw6dAbcOvCvhtH5/Qh4/w1z8pfgzbl5tln54uxQJh
         PFP9dHbOq3owpB3uzGRdAEipg3nwfvc98gIK/spKzERCsPjVRK5ZgsNsnF6R9+RjsopI
         jENymKcyyLqVFoHSl3P8iWqCxEaOoRrPnanMaCKsxP8kUkXA39SmkC3NGbcRwgz7oEYo
         wgxQ==
X-Gm-Message-State: AOAM530hHdHF3sGNqBcUgH/prk0MTUcO2cO+XSS6Mhxc7yF/Xg7CX/yY
        cSGWkWzTt5ObcBYBbIjMvXXzpy6kee01RqomwzjwU4h4
X-Google-Smtp-Source: ABdhPJx6A0futcYkk5JbU5g+4xbv7vqSLzojRm+OEOU8dYMdPjKY5ewTBjlJRcXONf/pStKwe/8/5CfaySChj1JsAxk=
X-Received: by 2002:a17:90b:4f8f:b0:1bf:ac1:2016 with SMTP id
 qe15-20020a17090b4f8f00b001bf0ac12016mr10854185pjb.21.1646418647497; Fri, 04
 Mar 2022 10:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20220303222014.517033-1-shy828301@gmail.com> <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
In-Reply-To: <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Mar 2022 10:30:35 -0800
Message-ID: <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting PMD
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 9:06 PM David Hildenbrand <david@redhat.com> wrote:
>
> Hi,
>
> This probably bounces on the list due to html junk from the gmail app.
>
> What happened to
>
> https://lore.kernel.org/linux-mm/20220131162940.210846-10-david@redhat.co=
m/
>
> Included in the very series mentioned below?
>
> Was this silently dropped due to folio conversion collisions? :/

I really didn't notice you already proposed this. Maybe folio
conversion, maybe mlock cleanup, I can't tell. But anyway this patch
needs to get rebased. I will submit v2 to solve the comment, will add
your signed-off-by.

>
> Yang Shi <shy828301@gmail.com> schrieb am Do. 3. M=C3=A4rz 2022 um 23:20:
>>
>> The commit c444eb564fb1 ("mm: thp: make the THP mapcount atomic against
>> __split_huge_pmd_locked()") locked the page for PMD split to make
>> mapcount stable for reuse_swap_page(), then commit 1c2f67308af4 ("mm:
>> thp: fix MADV_REMOVE deadlock on shmem THP") reduce the scope to
>> anonymous page only.
>>
>> However COW has not used mapcount to determine if the page is shared or
>> not anymore due to the COW fixes [1] from David Hildenbrand and the
>> reuse_swap_page() was removed as well.  So PMD split doesn't have to
>> lock the page anymore.  This patch basically reverted the above two
>> commits.
>>
>> [1] https://lore.kernel.org/linux-mm/20220131162940.210846-1-david@redha=
t.com/
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>> ---
>>  mm/huge_memory.c | 44 +++++---------------------------------------
>>  1 file changed, 5 insertions(+), 39 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index b49e1a11df2e..daaa698bd273 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2134,8 +2134,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, =
pmd_t *pmd,
>>  {
>>         spinlock_t *ptl;
>>         struct mmu_notifier_range range;
>> -       bool do_unlock_folio =3D false;
>> -       pmd_t _pmd;
>>
>>         mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->v=
m_mm,
>>                                 address & HPAGE_PMD_MASK,
>> @@ -2148,48 +2146,16 @@ void __split_huge_pmd(struct vm_area_struct *vma=
, pmd_t *pmd,
>>          * pmd against. Otherwise we can end up replacing wrong folio.
>>          */
>>         VM_BUG_ON(freeze && !folio);
>> -       if (folio) {
>> -               VM_WARN_ON_ONCE(!folio_test_locked(folio));
>> -               if (folio !=3D page_folio(pmd_page(*pmd)))
>> -                       goto out;
>> -       }
>> +       if (folio && folio !=3D page_folio(pmd_page(*pmd)))
>> +               goto out;
>>
>> -repeat:
>> -       if (pmd_trans_huge(*pmd)) {
>> -               if (!folio) {
>> -                       folio =3D page_folio(pmd_page(*pmd));
>> -                       /*
>> -                        * An anonymous page must be locked, to ensure t=
hat a
>> -                        * concurrent reuse_swap_page() sees stable mapc=
ount;
>> -                        * but reuse_swap_page() is not used on shmem or=
 file,
>> -                        * and page lock must not be taken when zap_pmd_=
range()
>> -                        * calls __split_huge_pmd() while i_mmap_lock is=
 held.
>> -                        */
>> -                       if (folio_test_anon(folio)) {
>> -                               if (unlikely(!folio_trylock(folio))) {
>> -                                       folio_get(folio);
>> -                                       _pmd =3D *pmd;
>> -                                       spin_unlock(ptl);
>> -                                       folio_lock(folio);
>> -                                       spin_lock(ptl);
>> -                                       if (unlikely(!pmd_same(*pmd, _pm=
d))) {
>> -                                               folio_unlock(folio);
>> -                                               folio_put(folio);
>> -                                               folio =3D NULL;
>> -                                               goto repeat;
>> -                                       }
>> -                                       folio_put(folio);
>> -                               }
>> -                               do_unlock_folio =3D true;
>> -                       }
>> -               }
>> -       } else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
>> +       if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
>>                 goto out;
>> +
>>         __split_huge_pmd_locked(vma, pmd, range.start, freeze);
>>  out:
>>         spin_unlock(ptl);
>> -       if (do_unlock_folio)
>> -               folio_unlock(folio);
>> +
>>         /*
>>          * No need to double call mmu_notifier->invalidate_range() callb=
ack.
>>          * They are 3 cases to consider inside __split_huge_pmd_locked()=
:
>> --
>> 2.26.3
>>
