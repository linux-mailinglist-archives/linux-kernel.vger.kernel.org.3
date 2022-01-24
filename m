Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830BB497B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbiAXJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242418AbiAXJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:08:15 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37DBC061401
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:08:14 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i62so2682023ybg.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mo+uj8+53Ax7tIU91723WHax5XvtDO7oGefV09g/Eiw=;
        b=Lag6Tc/VjcamDe0m5xYuMi0i4GEJpQqzDv2xv15qjoOeqbVWxK+nR+z87z3/Uds7yJ
         xVMZsrEWXOp0quH66zVcVy5D9zyeeMNJ8MBFrQnj3VltAmEoKjttsv3dlG98dSbynjqk
         PFnaOxWJQVmTUr0iugE5+mXiRzDIDnlGpq+Atf0UWF/05kXEtP98JOBc8mLU8YHEPRFF
         F4B6lwfKhGX8rPNJo3AwlCueRsN7Pt4RrmA0biTfkV0Baij7u6nDkDnXHHN+LcrqhAqH
         CShC3LlIw2tHICgexcSbDwofHLOvSY3OXjtQdxIIJaw/jzgvcxhEH1G/dQIPzOMr2C70
         ai4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mo+uj8+53Ax7tIU91723WHax5XvtDO7oGefV09g/Eiw=;
        b=SL2E/xcOnCA6wT3CKMvQcUwUnaCqX00o/vD81Zfs8os8l7EfoUvVT/qBxFvYsIGsZ3
         47SWmPcU1AWROyVQ9obn3IrrlHlIyyt6kYgeHM4FeF51xu/nr4c9MyJ0mokTPrZtIFic
         b9fhxzdRpRo+acpFtfG09lWNddvSYQ4gNKBpj+z14vFGALH7bo8MwAX0YkDV8hL1/6YG
         kEl3PMoe4KTOMLsNOq/kAvZ4Dr3abmgagXjjZkRDNutvX4fFCpFTb0hMj/P/QzuwIB5V
         JRN14eGVnllALvNNPOvTRR+8A46Rpflr2Jt/TMxsdjF5kNxvGvK4PaTYpG9F6JMQErzp
         RGsw==
X-Gm-Message-State: AOAM5324yAOkkFhQSvMLeO8mp2P0JbKpHqsSBDj0xf963sG17w/TE+Zs
        2BaWsb6kw8VWe21ld2uoNSabWazIRB9KlbMVjM/3pw==
X-Google-Smtp-Source: ABdhPJxR2sNnK1U8ZMv0TLocVVFDh5rCZxvNsQJUvLgq5oQIsKgHQM/iDQMQSKuzKm7osYadMtzCvSPfXA2+9Ul2f20=
X-Received: by 2002:a05:6902:100c:: with SMTP id w12mr6231737ybt.317.1643015294113;
 Mon, 24 Jan 2022 01:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20220121075515.79311-1-songmuchun@bytedance.com>
 <20220121075515.79311-4-songmuchun@bytedance.com> <Ye5YNbBbVymwfPB0@infradead.org>
In-Reply-To: <Ye5YNbBbVymwfPB0@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 24 Jan 2022 17:07:38 +0800
Message-ID: <CAMZfGtUb+xF9nFd21g8tagjRTCYg7R=HOVmXvVZhbtx8im3FDQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] dax: fix missing writeprotect the pte entry
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

On Mon, Jan 24, 2022 at 3:41 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 21, 2022 at 03:55:14PM +0800, Muchun Song wrote:
> > Reuse some infrastructure of page_mkclean_one() to let DAX can handle
> > similar case to fix this issue.
>
> Can you split out some of the infrastructure changes into proper
> well-documented preparation patches?

Will do. I'll introduce page_vma_mkclean_one in a prepared patch
and then fix the DAX issue in a separate patch. Thanks for your
suggestions.

>
> > +     pgoff_t pgoff_end = pgoff_start + npfn - 1;
> >
> >       i_mmap_lock_read(mapping);
> > -     vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
> > -             struct mmu_notifier_range range;
> > -             unsigned long address;
> > -
> > +     vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff_start, pgoff_end) {
>
> Please avoid the overly long lines here.  Just using start and end
> might be an easy option.
>

Will do.

Thanks.
