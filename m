Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D0949AD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442955AbiAYHMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442568AbiAYHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:09:21 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0860C0619C4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:02:35 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k17so3274050ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dME7WGjycfCPYxmjYIqrFH1YXeqs+InmpqysLjTPlzM=;
        b=amYBEOB2sMOECjGPhfMEQ/UEOLKvNfub12ZZk6Kgde8UISLhPq4P1tKSS/hAze0p9j
         nQK8P40wup1JaOHr9cpNR8PdlxRSiqyf6zbqlpbP8jTRjj+5Zxjq5qC1BYhFd6XGobq1
         wvuQK1Y6HWvKRFS7JckDgPpQ/KCUvYBDwejHVepaDsKNPpdRwME7gDaIlm1ibJY4Uv71
         EucJgwOtoNl1GoJUoH5SWV70wr2EDE9STpBxi2NGfryDM7a3IXoulow8sGajQVJoYgzD
         CZbXO6nmX+RyjSa3++7xyC348NY/OUAYAfSdoUbPmrUMNKmTpbpA9sBTihbzEsH+87xS
         KtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dME7WGjycfCPYxmjYIqrFH1YXeqs+InmpqysLjTPlzM=;
        b=7rC4WMHRWf5DrVmtYH1GpLarE3SltRJkx0Ow32zfJvaFHvuDk8PgfognNsVTkOpnG4
         jlD4lKwaDT/2zyQqrr41as83b+IHIuYWTXZ74kZvFDIckVLH0iJXtzbJlxZ7Oc0h807j
         p4JmNbP8K+9E/o2S32CxGUdgocsTPQ0FrY67/rtd0flEGBdEmRvfpH5qaqh6NVU/m9oy
         Atf/DYegvMInJSmcdhkEWVTytmAMlJpunZc/12ikLEApqmPY/dHjSdXRxMxO3CfTAGFk
         HgLtFPx5r4L+v3rdCOm2tjV9dk4ULcm0UN96WmIT6rda1SBw2r5Um0hRo8DxYTao7ZwY
         H7Rg==
X-Gm-Message-State: AOAM530WPECWn4pEl3sHa2+whjdBD+1W9kVpgNJaVjzTpSr4F0KtlONw
        RAOwbBgNAea86dbSoV4cC+5KfwOKV+K0sgZGFemOhw==
X-Google-Smtp-Source: ABdhPJxNPvQ168PEeWD7QNNQOJuXjSDRCMLiP0b4oKX2jpsdp1/k4rOpI6Ja8FztN3a3gYj8rhYa9MlsOo7okUFG6wg=
X-Received: by 2002:a05:6902:100c:: with SMTP id w12mr12601077ybt.317.1643090555052;
 Mon, 24 Jan 2022 22:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com> <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
 <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com> <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
 <7D7EB27F-DEA7-41AA-B24E-B61A2A1A5F07@nvidia.com>
In-Reply-To: <7D7EB27F-DEA7-41AA-B24E-B61A2A1A5F07@nvidia.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 25 Jan 2022 14:01:59 +0800
Message-ID: <CAMZfGtVCUbTa6xv2R9x+_a5_dK4ZLUX8ECNkF8mkJgEy4kdnfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of THP
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Lars Persson <lars.persson@axis.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:42 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 24 Jan 2022, at 20:55, Muchun Song wrote:
>
> > On Tue, Jan 25, 2022 at 3:22 AM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 24 Jan 2022, at 13:11, David Rientjes wrote:
> >>
> >>> On Mon, 24 Jan 2022, Muchun Song wrote:
> >>>
> >>>> The D-cache maintenance inside move_to_new_page() only consider one =
page,
> >>>> there is still D-cache maintenance issue for tail pages of THP. Fix =
this
> >>>> by not using flush_dcache_folio() since it is not backportable.
> >>>>
> >>>
> >>> The mention of being backportable suggests that we should backport th=
is,
> >>> likely to 4.14+.  So should it be marked as stable?
> >>
> >> Hmm, after more digging, I am not sure if the bug exists. For THP migr=
ation,
> >> flush_cache_range() is used in remove_migration_pmd(). The flush_dcach=
e_page()
> >> was added by Lars Persson (cc=E2=80=99d) to solve the data corruption =
on MIPS[1],
> >> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM64.
> >
> > I only mention the THP case. After some more thinking, I think the Huge=
TLB
> > should also be considered, Right? The HugeTLB is enabled on arm, arm64,
> > mips, parisc, powerpc, riscv, s390 and sh.
> >
>
> +Mike for HugeTLB
>
> If HugeTLB page migration also misses flush_dcache_page() on its tail pag=
es,
> you will need a different patch for the commit introducing hugetlb page m=
igration.

Agree. I think arm (see the following commit) has handled this issue, while=
 most
others do not.

  commit 0b19f93351dd ("ARM: mm: Add support for flushing HugeTLB pages.")

But I do not have any real devices to test if this issue exists on other ar=
chs.
In theory, it exists.

>
> >>
> >> To make code more consistent, I guess flush_cache_range() in remove_mi=
gration_pmd()
> >> can be removed, since it is superseded by the flush_dcache_page() belo=
w.
> >
> > From my point of view, flush_cache_range() in remove_migration_pmd() is
> > a wrong usage, which cannot replace flush_dcache_page(). I think the co=
mmit
> > c2cc499c5bcf ("mm compaction: fix of improper cache flush in migration =
code")
> > , which is similar to the situation here, can offer more infos.
> >
>
> Thanks for the information. That helps. But remove_migration_pmd() did no=
t cause
> any issue at the commit pointed by Fixes but at the commit which enabled =
THP
> migration on IBM and ARM64, whichever came first.
>
> IIUC, there will be different versions of the fix targeting different sta=
ble
> trees:
>
> 1. pre-4.14, THP migration did not exist: you will need to fix the use of
> flush_dcache_page() at that time for HugeTLB page migration. Both flushin=
g
> dcache page for all subpages and moving flush_dcache_page from
> remove_migration_pte() to move_to_new_page(). 4.9 and 4.4 are affected.
> But EOL of 4.4 is next month, so you might skip it.
>
> 2. 4.14 to before device public page is removed: your current fix will no=
t
> apply directly, but the for loop works. flush_cache_range() in
> remove_migration_pmd() should be removed, since it is dead code based on
> the commit you mentioned. It might not be worth the effort to find when
> IBM and ARM64 enable THP migration.
>
> 3. after device public page is removed: your current fix will apply clean=
ly
> and the removal of flush_cache_range() in remove_migration_pmd() should
> be added.
>
> Let me know if it makes sense.

Make sense.

Thanks.
