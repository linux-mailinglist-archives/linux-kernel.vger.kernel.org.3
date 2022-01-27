Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0A49D7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiA0Bzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiA0Bzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:55:47 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC0EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:55:47 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id k31so4203548ybj.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pCzSr1pxSHStbedQqWV8IS3GpdlR5HJSIOSBxezrsL0=;
        b=YEp7nmbZ3BbEnkC+L3jNGAIFZUS3kgbdPBQxDQOEbMuIC42eCd2+qdl2RC8UVDtfig
         BlGadNbT5oU0+tXZhoOYMltdaoOX9PANrkf0hsiwhNz0TXfhFt+EU5fgeUaJFeQrNm73
         4ii8JQ3/qTger9rf9Jn/qBX6rwGVHbf0Kiuo9KELqPpOB5Bo/ZqL8R94lIB/7Igf7ruT
         IneJm07gj37xs6LBLuASdVaGM1aEXetqE+kh+F0Yy7/cFppmvdW8Fze8ixg9YT7nVXV7
         61bL+71OT3+eZaxcTt7WLwOW3bXjzUKSBFy/Lic8KzPz33iO+0m+HfROqnxuSTTBzNVU
         GDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCzSr1pxSHStbedQqWV8IS3GpdlR5HJSIOSBxezrsL0=;
        b=FCuKFPdM5zBTVl6G6+7qj5aerc9oKoveTm2yk5rMbJhFHrBzoalXmIRjjLQ5rE9wyc
         3RnKQo3Inw8mX6WrW8myjQKxQ29DYAdrLO7JIpbzPY6C8sSSNCbUchaVwrfvuJYf5jGC
         2uI5NcExRceYmNRq1Nl73+rW/1uM1NXzxLg97n3Nzk09tySLBIeQcw6uJiCLBSDedXHA
         gKHmVHSpqBuk/pTRBCTocNy3kWVlVGBFUORbfAW3Tkg5tjd5HBLJRgyYqIQNti83PIq8
         EGwKPePAp8BiR0vNSaPSHBaQY6n4nedxjfhm8DKZL0u+eKHfqmfNRamA5MgaQijh5+y3
         RTaQ==
X-Gm-Message-State: AOAM533Dubxaq05UbG7P+4zhxABskmUbCB8Q0c/aM5BYmEFM3w0y9qci
        aviILSYdbmduPH8Xc6U0hHor9RRjNKVIR8dx6A8MTA==
X-Google-Smtp-Source: ABdhPJxsXfXuluvzm/L52nsec6SGhEoc9dHPnWpinpYIc9f/fmkx0H/kz7AQv5P5G7xCNepXdvJ32rtgV+D75U8le5s=
X-Received: by 2002:a25:c983:: with SMTP id z125mr2742733ybf.132.1643248546483;
 Wed, 26 Jan 2022 17:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com> <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
 <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com> <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
 <7D7EB27F-DEA7-41AA-B24E-B61A2A1A5F07@nvidia.com> <CAMZfGtVCUbTa6xv2R9x+_a5_dK4ZLUX8ECNkF8mkJgEy4kdnfQ@mail.gmail.com>
 <039a9107-756e-bc0a-6e72-fbe08408de38@oracle.com> <CAMZfGtXigcVQincXZ6kdNRY7GRwR6E=RD3-pGaiymv87ynoOqQ@mail.gmail.com>
 <3ca19dec-5ded-02ab-184c-89aba4052aca@oracle.com>
In-Reply-To: <3ca19dec-5ded-02ab-184c-89aba4052aca@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 27 Jan 2022 09:55:08 +0800
Message-ID: <CAMZfGtVR2-PA9xxt4RJcSAKjr9Lq2+VF=JOAL3AgfnanEUw22A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of THP
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Lars Persson <lars.persson@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 7:27 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> On 1/25/22 19:29, Muchun Song wrote:
> > On Wed, Jan 26, 2022 at 5:24 AM Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
> >>
> >> On 1/24/22 22:01, Muchun Song wrote:
> >>> On Tue, Jan 25, 2022 at 10:42 AM Zi Yan <ziy@nvidia.com> wrote:
> >>>>
> >>>> On 24 Jan 2022, at 20:55, Muchun Song wrote:
> >>>>
> >>>>> On Tue, Jan 25, 2022 at 3:22 AM Zi Yan <ziy@nvidia.com> wrote:
> >>>>>>
> >>>>>> On 24 Jan 2022, at 13:11, David Rientjes wrote:
> >>>>>>
> >>>>>>> On Mon, 24 Jan 2022, Muchun Song wrote:
> >>>>>>>
> >>>>>>>> The D-cache maintenance inside move_to_new_page() only consider =
one page,
> >>>>>>>> there is still D-cache maintenance issue for tail pages of THP. =
Fix this
> >>>>>>>> by not using flush_dcache_folio() since it is not backportable.
> >>>>>>>>
> >>>>>>>
> >>>>>>> The mention of being backportable suggests that we should backpor=
t this,
> >>>>>>> likely to 4.14+.  So should it be marked as stable?
> >>>>>>
> >>>>>> Hmm, after more digging, I am not sure if the bug exists. For THP =
migration,
> >>>>>> flush_cache_range() is used in remove_migration_pmd(). The flush_d=
cache_page()
> >>>>>> was added by Lars Persson (cc=E2=80=99d) to solve the data corrupt=
ion on MIPS[1],
> >>>>>> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and AR=
M64.
> >>>>>
> >>>>> I only mention the THP case. After some more thinking, I think the =
HugeTLB
> >>>>> should also be considered, Right? The HugeTLB is enabled on arm, ar=
m64,
> >>>>> mips, parisc, powerpc, riscv, s390 and sh.
> >>>>>
> >>>>
> >>>> +Mike for HugeTLB
> >>>>
> >>>> If HugeTLB page migration also misses flush_dcache_page() on its tai=
l pages,
> >>>> you will need a different patch for the commit introducing hugetlb p=
age migration.
> >>>
> >>> Agree. I think arm (see the following commit) has handled this issue,=
 while most
> >>> others do not.
> >>>
> >>>   commit 0b19f93351dd ("ARM: mm: Add support for flushing HugeTLB pag=
es.")
> >>>
> >>> But I do not have any real devices to test if this issue exists on ot=
her archs.
> >>> In theory, it exists.
> >>>
> >>
> >> Thanks for adding me to the discussion.
> >>
> >> I agree that this issue exists at least in theory for hugetlb pages as=
 well.
> >> This made me look at other places with similar code for hugetlb.  i.e.
> >> Allocating a new page, copying data to new page and then establishing =
a
> >> mapping (pte) to the new page.
> >
> > Hi Mike,
> >
> > Thanks for looking at this.
> >
> >>
> >> - hugetlb_cow calls copy_user_huge_page() which ends up calling
> >>   copy_user_highpage that includes dcache flushing of the target for s=
ome
> >>   architectures, but not all.
> >
> > copy_user_page() inside copy_user_highpage() is already considering
> > the cache maintenance on different architectures, which is documented
> > in Documentation/core-api/cachetlb.rst. So there are no problems in thi=
s
> > case.
> >
>
> Thanks!  That cleared up some of my confusion.
>
>
> >> - userfaultfd calls copy_huge_page_from_user which does not appear to =
do
> >>   any dcache flushing for the target page.
> >
> > Right. The new page should be flushed before setting up the mapping
> > to the user space.
> >
> >> Do you think these code paths have the same potential issue?
> >
> > The latter does have the issue, the former does not. The fixes may
> > look like the following:
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a1baa198519a..828240aee3f9 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5819,6 +5819,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *ds=
t_mm,
> >                         goto out;
> >                 }
> >                 folio_copy(page_folio(page), page_folio(*pagep));
> > +               flush_dcache_folio(page_folio(page));
> >                 put_page(*pagep);
> >                 *pagep =3D NULL;
> >         }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e8ce066be5f2..ff6f48cdcc48 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5400,6 +5400,7 @@ long copy_huge_page_from_user(struct page *dst_pa=
ge,
> >                         kunmap(subpage);
> >                 else
> >                         kunmap_atomic(page_kaddr);
> > +               flush_dcache_page(subpage);
> >
> >                 ret_val -=3D (PAGE_SIZE - rc);
> >                 if (rc)
> >
>
> That looks good to me.  Do you plan to include this in the next version
> of this series?

Yes, will do.

Thanks.
