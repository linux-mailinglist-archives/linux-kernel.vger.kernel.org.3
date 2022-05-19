Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13F852CD42
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiESHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiESHib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:38:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D16E5A08B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:38:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so4073801plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tSebtDt8YkoL4i4+zWk/Qij2Mxud3PKOTk3PTgFzbmE=;
        b=bBknZxRTg3Z97Z2ssMST7CUdiIFQdw30VIGEbDc4XILjLtZJjKy9Pv6V+eilqDLQ/V
         t7lH4/LygHCJgB9DUfDdPJanANCPEXKVSOVb1Hfy8AmKiAj8D6YLV/gEHNTVfvZnnyhs
         S5RDWRs9XbqZG15WH2zx2UWqfQsCRUc86TWLP2LOVLw6D6kVHRh+YW0B9hLibMB+QoDr
         5O2/cBeRzhsGX6H0DRMg4Sdc2C3eBXvqfsGpE1L3goVSUp66aVUsi2qKrD+CXWKkYXGT
         X4sWxF0H45W3D2hf3QuCZYT8cl1cIoxje8ULU6xC+l2XSHSn7ya1RMSpV5rK7xCouCvZ
         8Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tSebtDt8YkoL4i4+zWk/Qij2Mxud3PKOTk3PTgFzbmE=;
        b=4m5uKghrkMMYoSnZZydWlXM/8eQSUR7ElONhSN6xD9flqgu1y5z7Kz3TzjQNIONwCq
         fyGykr7h65PVb+3B4yedMQLLn2WZtJT/1uOtttWGXipc0a6I2n4NjHQaUJofMgYlj/6r
         1XiyI3uDMfwK1kzv057TsYi1GFKC9Tg/SYZBAU+YoPkDy8TX5zDDrTLNsBBAhTEDhhpp
         ZDuu3JC5dZPlSaxuZrrhDwJAuBuvPYc1IjyzJulClO1gtZBIyHoNRes3fClelldIG+JL
         0hsywB5NtseYDq0VrElzt81u51KvW7/MCXJOmyB29kGSe50oG91Ye94xu9Er3Syv4d0x
         ua2w==
X-Gm-Message-State: AOAM532B8ScDHvMALeXbZjCtfHKK2AHIUV2dowNl3k279gUyOFMJ4OHf
        GbK64VBYoNRkgiQJPYkqJa6fLg==
X-Google-Smtp-Source: ABdhPJxOt6vmYLsghe1ev3gFOkYdn1saAkpRvucrQZs0VuDOdd5NjCrqpCuiayGMwEFcrgN4u4BeyA==
X-Received: by 2002:a17:90a:17a9:b0:1df:4826:5155 with SMTP id q38-20020a17090a17a900b001df48265155mr4367272pja.201.1652945907942;
        Thu, 19 May 2022 00:38:27 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902c2d600b0015e8d4eb2easm2988165pla.308.2022.05.19.00.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:38:27 -0700 (PDT)
Date:   Thu, 19 May 2022 15:38:24 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] mm: pvmw: check possible huge PMD map by
 transhuge_vma_suitable()
Message-ID: <YoXz8JOa9MAAf0KE@FVFYT0MHHV2J.usts.net>
References: <20220513191705.457775-1-shy828301@gmail.com>
 <YoSEsa2zvqylYuZC@FVFYT0MHHV2J.usts.net>
 <CAHbLzkrXvJn6FbCNUTMi3c85nnMvOda58V2DDSb9W7_9_YTjSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrXvJn6FbCNUTMi3c85nnMvOda58V2DDSb9W7_9_YTjSg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:45:14AM -0700, Yang Shi wrote:
> On Tue, May 17, 2022 at 10:31 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Fri, May 13, 2022 at 12:17:05PM -0700, Yang Shi wrote:
> > > IIUC PVMW checks if the vma is possibly huge PMD mapped by
> > > transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".
> > >
> > > Actually pvmw->nr_pages is returned by compound_nr() or
> > > folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
> > > >= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
> > > in the first place.  But it may be not PMD mapped if the VMA is file
> > > VMA and it is not properly aligned.  The transhuge_vma_suitable()
> > > is used to do such check, so replace transparent_hugepage_active() to
> > > it, which is too heavy and overkilling.
> > >
> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Muchun Song <songmuchun@bytedance.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > > v2: * Fixed build error for !CONFIG_TRANSPARENT_HUGEPAGE
> > >     * Removed fixes tag per Willy
> > >
> > >  include/linux/huge_mm.h | 8 ++++++--
> > >  mm/page_vma_mapped.c    | 2 +-
> > >  2 files changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index fbf36bb1be22..c2826b1f4069 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -117,8 +117,10 @@ extern struct kobj_attribute shmem_enabled_attr;
> > >  extern unsigned long transparent_hugepage_flags;
> > >
> > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > -             unsigned long haddr)
> > > +             unsigned long addr)
> > >  {
> > > +     unsigned long haddr;
> > > +
> > >       /* Don't have to check pgoff for anonymous vma */
> > >       if (!vma_is_anonymous(vma)) {
> > >               if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> > > @@ -126,6 +128,8 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > >                       return false;
> > >       }
> > >
> > > +     haddr = addr & HPAGE_PMD_MASK;
> > > +
> > >       if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> > >               return false;
> > >       return true;
> > > @@ -328,7 +332,7 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> > >  }
> > >
> > >  static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> > > -             unsigned long haddr)
> > > +             unsigned long addr)
> > >  {
> > >       return false;
> > >  }
> > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > index c10f839fc410..e971a467fcdf 100644
> > > --- a/mm/page_vma_mapped.c
> > > +++ b/mm/page_vma_mapped.c
> > > @@ -243,7 +243,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > >                        * cleared *pmd but not decremented compound_mapcount().
> > >                        */
> > >                       if ((pvmw->flags & PVMW_SYNC) &&
> > > -                         transparent_hugepage_active(vma) &&
> > > +                         transhuge_vma_suitable(vma, pvmw->address) &&
> >
> > How about the following diff? Then we do not need to change
> > transhuge_vma_suitable().  All the users of transhuge_vma_suitable()
> > are already do the alignment by themselves.
> 
> Thanks for the suggestion. But TBH I don't think this is a better way.
> I did think about this before proposing v2, but I don't prefer to
> pollute the code with IS_ENABLED(CONFIG_xxx) since the definition of
> transhuge_vma_suitable() is already protected by #ifdef. Rounding the
> address in transhuge_vma_suitable() seems neater and more readable to
> me IMHO.
> 
> Some callers of transhuge_vma_suitable() do round the address before
> calling it, but the rounded address is used by other codes in the
> callers too.
>

All right.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
 
