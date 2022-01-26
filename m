Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8649C224
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiAZDaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiAZDaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:30:24 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13516C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:30:24 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g81so67539750ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yj8bOFT13velpoWfDU2cuSAdvEHEJWwY0FpIeFHzEoI=;
        b=4oYU6dNUqbgGN0ScDndA29BevVKWSKrxlRuvf5uChM8k8GYdPoF0RgDms9jihcwd0a
         Eu7SCZDb/TL8m65JxGr3tOA2CVViyGn5vfhCEbcalEnfoAzs56sl294vJAwvdQ26MyKQ
         cz0RryADg5hQtJ7FbPNTTdmgb4ClgDQkQMSYl3TCSbmauJrAr2cGoU6TxIKWgYyfdy75
         WxMY4d4JNfdz/B9/ArkgQzD6dXTp9u387VgM0amOHQMF759XLyd9nHaf4I6vbP2CZ/oL
         9Bx0YvSsvzlLzIGEeIb38gPQC1suayuKWmNFFUQ1rAEng739gqoSboNQXS0UmAU/xBqr
         HNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yj8bOFT13velpoWfDU2cuSAdvEHEJWwY0FpIeFHzEoI=;
        b=7KJnArJgnbB/33WCjUhh9LmaA5p/T6wAqnIq3UIzZ0OC77Il4uy2Z9sGhZ5VsJTnVw
         Qqsua7705nt/3W+R2+1W9zu7rhXH1DFqo5QucdDXEasfIVO0lVUf2WY2SQuL4ggdtrAu
         tRDWj0jWKsi3HkYKLgraBaghSVHcKILb7cjcM6oSLBK652/Nj6ZUdgttMW5jpxXVc3C1
         AaVm3yQ2IV1c00aKs7B3Ta6SaHD/qGsthjAwYdw5TebNHPKLHWZFSPkdCMO+8gdh3FGX
         vCCAGEbLIgZmfTM4Ki89ECuPNlaCTBMLQivlKTtHE9ieYQGfAd9jf4oYj+mfgGy+99nA
         GiYQ==
X-Gm-Message-State: AOAM533gdBCEcIGbHzKqPNyHYEPaCbD0mMoIQayiwk0FhasAVRddDAtu
        VjMEmRNAihUKCyg/K2xl0ZTFQqkEXfb3+X7DYiRXyQ==
X-Google-Smtp-Source: ABdhPJyu2HgBCxLYWh9tJPDbWFsw0PeAfgccjCbZ1cKnBYjkmHiq8RwI4O5czsYvRSibufTvt89vUvtbytZWMZ8L99I=
X-Received: by 2002:a25:341:: with SMTP id 62mr35495944ybd.132.1643167823311;
 Tue, 25 Jan 2022 19:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com> <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
 <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com> <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
 <7D7EB27F-DEA7-41AA-B24E-B61A2A1A5F07@nvidia.com> <CAMZfGtVCUbTa6xv2R9x+_a5_dK4ZLUX8ECNkF8mkJgEy4kdnfQ@mail.gmail.com>
 <039a9107-756e-bc0a-6e72-fbe08408de38@oracle.com>
In-Reply-To: <039a9107-756e-bc0a-6e72-fbe08408de38@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 Jan 2022 11:29:47 +0800
Message-ID: <CAMZfGtXigcVQincXZ6kdNRY7GRwR6E=RD3-pGaiymv87ynoOqQ@mail.gmail.com>
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

On Wed, Jan 26, 2022 at 5:24 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> On 1/24/22 22:01, Muchun Song wrote:
> > On Tue, Jan 25, 2022 at 10:42 AM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 24 Jan 2022, at 20:55, Muchun Song wrote:
> >>
> >>> On Tue, Jan 25, 2022 at 3:22 AM Zi Yan <ziy@nvidia.com> wrote:
> >>>>
> >>>> On 24 Jan 2022, at 13:11, David Rientjes wrote:
> >>>>
> >>>>> On Mon, 24 Jan 2022, Muchun Song wrote:
> >>>>>
> >>>>>> The D-cache maintenance inside move_to_new_page() only consider on=
e page,
> >>>>>> there is still D-cache maintenance issue for tail pages of THP. Fi=
x this
> >>>>>> by not using flush_dcache_folio() since it is not backportable.
> >>>>>>
> >>>>>
> >>>>> The mention of being backportable suggests that we should backport =
this,
> >>>>> likely to 4.14+.  So should it be marked as stable?
> >>>>
> >>>> Hmm, after more digging, I am not sure if the bug exists. For THP mi=
gration,
> >>>> flush_cache_range() is used in remove_migration_pmd(). The flush_dca=
che_page()
> >>>> was added by Lars Persson (cc=E2=80=99d) to solve the data corruptio=
n on MIPS[1],
> >>>> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM6=
4.
> >>>
> >>> I only mention the THP case. After some more thinking, I think the Hu=
geTLB
> >>> should also be considered, Right? The HugeTLB is enabled on arm, arm6=
4,
> >>> mips, parisc, powerpc, riscv, s390 and sh.
> >>>
> >>
> >> +Mike for HugeTLB
> >>
> >> If HugeTLB page migration also misses flush_dcache_page() on its tail =
pages,
> >> you will need a different patch for the commit introducing hugetlb pag=
e migration.
> >
> > Agree. I think arm (see the following commit) has handled this issue, w=
hile most
> > others do not.
> >
> >   commit 0b19f93351dd ("ARM: mm: Add support for flushing HugeTLB pages=
.")
> >
> > But I do not have any real devices to test if this issue exists on othe=
r archs.
> > In theory, it exists.
> >
>
> Thanks for adding me to the discussion.
>
> I agree that this issue exists at least in theory for hugetlb pages as we=
ll.
> This made me look at other places with similar code for hugetlb.  i.e.
> Allocating a new page, copying data to new page and then establishing a
> mapping (pte) to the new page.

Hi Mike,

Thanks for looking at this.

>
> - hugetlb_cow calls copy_user_huge_page() which ends up calling
>   copy_user_highpage that includes dcache flushing of the target for some
>   architectures, but not all.

copy_user_page() inside copy_user_highpage() is already considering
the cache maintenance on different architectures, which is documented
in Documentation/core-api/cachetlb.rst. So there are no problems in this
case.

> - userfaultfd calls copy_huge_page_from_user which does not appear to do
>   any dcache flushing for the target page.

Right. The new page should be flushed before setting up the mapping
to the user space.

> Do you think these code paths have the same potential issue?

The latter does have the issue, the former does not. The fixes may
look like the following:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1baa198519a..828240aee3f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5819,6 +5819,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm=
,
                        goto out;
                }
                folio_copy(page_folio(page), page_folio(*pagep));
+               flush_dcache_folio(page_folio(page));
                put_page(*pagep);
                *pagep =3D NULL;
        }
diff --git a/mm/memory.c b/mm/memory.c
index e8ce066be5f2..ff6f48cdcc48 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5400,6 +5400,7 @@ long copy_huge_page_from_user(struct page *dst_page,
                        kunmap(subpage);
                else
                        kunmap_atomic(page_kaddr);
+               flush_dcache_page(subpage);

                ret_val -=3D (PAGE_SIZE - rc);
                if (rc)

Thanks.
