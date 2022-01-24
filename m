Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436C1497AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiAXIvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiAXIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:51:43 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB73C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:51:43 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id o80so48962780yba.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bELfTHEk6E+Ur1KnM4vcunvX6YMOTiYgaY+wBXhSmNY=;
        b=xuzHORiZtxL4ALsbPI12Enqz7+Y7z0qaEw1VTD5rZOAhs136D3XcklFmacDAPP1Wix
         b1LezGAI1F3NQTCI3w2mzRPC+MN6bdvFBSfGz1dtd48u5S8myG1WDGav+YscfQrYNIyT
         bW4EIysGkBOF3+/+evUyYiHTyjBobHidSnKY3XRHsRzfufOk2nJE7LOgO/bNLOnPqckC
         K2NOq5CLsd2a53530xwZVi/LbOfFyuiMm7xB/ASE2pT2LN7016uNyqlOtbNmhXhU6GUt
         ztNByXTKi0m1souZOOtIvo7KOv/wq5MzYC8eEGDxp0xOL5QolSsngo80rWPP/ZmLnKM1
         fFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bELfTHEk6E+Ur1KnM4vcunvX6YMOTiYgaY+wBXhSmNY=;
        b=NMr9IaKnY9qYrvI68jQ3PBzG/j8trF4OmmzwcYy092AxTA1WtLFNeWyrdx3U1PAhEp
         UAYzt+mA/zEPD8pm04+Kinsbcnv48ffBzgCG7+PqBmMZtjc3w8r1GO4Tzri6kWG/IN32
         eGzALXPPV0f56ch4a1laZYS+sPLatPNCUVF6yelCybMCWVTpLl47rw2FU+w011uyHbld
         cHzVl1oUpVS02bDPGpFG2+gPVO6B01jeeH+EYrNMwmsPk2M+Tdd6ODNhpdQgOpcl7Kgm
         xlf56S2m3mBSYoi+a6pVl8k3KiQwsiXzdma8Rbr2EZ76E/7dKZ6BC7+1q3JEto0sL55S
         EZlA==
X-Gm-Message-State: AOAM532L3hP0nGoIkjx2D8v6ElgiBXB8XXhpWI88t4m5AWqCfMaMQQJZ
        /aV0YilOBFNfY8o3uiLOa0kL99kOhhR181UFZP4r4Q==
X-Google-Smtp-Source: ABdhPJw1vSctPW8saHhj1FGspU/fxdcO6t1LvGwNO4aTt6W6d1v0JCyqb15ZQrKh1+6SniqvhSjPXoVXuqbGSbR4L3Y=
X-Received: by 2002:a25:d107:: with SMTP id i7mr20792477ybg.495.1643014302301;
 Mon, 24 Jan 2022 00:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20220121075515.79311-1-songmuchun@bytedance.com> <Ye5WfvUdJBhZ3lME@infradead.org>
In-Reply-To: <Ye5WfvUdJBhZ3lME@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 24 Jan 2022 16:51:06 +0800
Message-ID: <CAMZfGtUab0PS7tO0ni4Z7eSKWc0UAVQO=prc-iKNj0S67qaRtw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: rmap: fix cache flush on THP pages
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
        Yang Shi <shy828301@gmail.com>, rcampbell@nvidia.com,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        zwisler@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 3:34 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 21, 2022 at 03:55:11PM +0800, Muchun Song wrote:
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index b0fd9dc19eba..65670cb805d6 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -974,7 +974,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
> >                       if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
> >                               continue;
> >
> > -                     flush_cache_page(vma, address, page_to_pfn(page));
> > +                     flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>
> Do we need a flush_cache_folio here given that we must be dealing with
> what effectively is a folio here?

I think it is a future improvement. I suspect it will be easy if
someone wants to backport this patch. If we do not want
someone to do this, I think it is better to introduce
flush_cache_folio in this patch. What do you think?

>
> Also please avoid the overly long line.
>

OK.

Thanks.
