Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31ED48FE57
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 19:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiAPSLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 13:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiAPSLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 13:11:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5643C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 10:11:31 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 128so7710812pfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmUbTZjqBInIJavSOPsGB7sguS3NLG7eeySfoArPt34=;
        b=Xd3KitxSS0Fc59xyCcCdOjDz2nPHsDQszROLzx5GXTOSNYxND4QMmpIKIIwfmpSTEX
         kwvxCEdX0gL0KhKIKxVkQCp+xfoWswctZVbeSdUkly7ZspeebaXY62+5lLuK9u9byZFu
         2NzyoCuxQnlTHpAKhNY/u0M7u3os+w2LtIxd6i3W27vG+jsDehJQrGeImPjKNeECxDd7
         vnwAJiS/2IXWN77ZHUg0MPXzVwCzjDhPY5VqnDkjs6C2UnPCNYrv6MKgb/2UyFz47Akt
         EdHO+ffGRTFs+1Q/TaJ+vyRVa8q5XQ+EBVSadIgOyb9AOdfa9s2g4+URuA9r8wOzxq+j
         dBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmUbTZjqBInIJavSOPsGB7sguS3NLG7eeySfoArPt34=;
        b=13NN1IETUBSHBwJ8uOYKSEvMAtHzS5QChvei9yoSpsMiX2gCdFmhBk6wCMy4TjHGs0
         tk8mFbRmHXphy5XsruH4o6nVKtZOjc2XICcozwFUX6OYfBPcgGqq9F3+dVnjl7IS3O9g
         PyQRcZ1p9Gs4gRn6yOJFKAPkz+2k+//4mti2V8kCrKvodJ1kEW0i/F88gDtWnqgqyAPN
         XKzP2eZi30EevyNAzKJhc9I+MIL9E7/1g/Xj5gcL8ilWSxsgCJ1K+GaT6FGvpn3lj0lr
         VAVdzUNIcNZDULQvX2XOkjlBumXwxHxzag4iS/MUus/JeGwn+IMorG5f7vXJKBCidmfo
         yRIw==
X-Gm-Message-State: AOAM530Zz99L2kV9oSMHKhxwQ4taj+OC7FiCDDvzUM2QOo7zXu0eAqIY
        mGoZzTcW/AGjmXjdywWQB2QvG9NLoi9VzOHxFvTitQ==
X-Google-Smtp-Source: ABdhPJzXoxob/X/DHCIAvQXfNmkfleCnn7lo5NMjRZpAiVrSHkykqZ8vcF4tuq0Djs8919C3EyWNG02Ij1EuYglKpBQ=
X-Received: by 2002:a63:710f:: with SMTP id m15mr15850765pgc.40.1642356691202;
 Sun, 16 Jan 2022 10:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-2-lizhijian@cn.fujitsu.com> <20220106002130.GP6467@ziepe.ca>
 <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com>
In-Reply-To: <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 16 Jan 2022 10:11:19 -0800
Message-ID: <CAPcyv4h2Cuzm_fn9fi9RqQ_iEwOwuc9qdk5x_7W=VXvsOAVPFA@mail.gmail.com>
Subject: Re: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 10:13 PM lizhijian@fujitsu.com
<lizhijian@fujitsu.com> wrote:
>
>
> Add Dan to the party :)
>
> May i know whether there is any existing APIs to check whether
> a va/page backs to a nvdimm/pmem ?
>
>
>
> On 06/01/2022 08:21, Jason Gunthorpe wrote:
> > On Tue, Dec 28, 2021 at 04:07:08PM +0800, Li Zhijian wrote:
> >> We can use it to indicate whether the registering mr is associated with
> >> a pmem/nvdimm or not.
> >>
> >> Currently, we only assign it in rxe driver, for other device/drivers,
> >> they should implement it if needed.
> >>
> >> RDMA FLUSH will support the persistence feature for a pmem/nvdimm.
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >>   drivers/infiniband/sw/rxe/rxe_mr.c | 47 ++++++++++++++++++++++++++++++
> >>   include/rdma/ib_verbs.h            |  1 +
> >>   2 files changed, 48 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> >> index 7c4cd19a9db2..bcd5e7afa475 100644
> >> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> >> @@ -162,6 +162,50 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
> >>      mr->type = IB_MR_TYPE_DMA;
> >>   }
> >>
> >> +// XXX: the logic is similar with mm/memory-failure.c
> >> +static bool page_in_dev_pagemap(struct page *page)
> >> +{
> >> +    unsigned long pfn;
> >> +    struct page *p;
> >> +    struct dev_pagemap *pgmap = NULL;
> >> +
> >> +    pfn = page_to_pfn(page);
> >> +    if (!pfn) {
> >> +            pr_err("no such pfn for page %p\n", page);
> >> +            return false;
> >> +    }
> >> +
> >> +    p = pfn_to_online_page(pfn);
> >> +    if (!p) {
> >> +            if (pfn_valid(pfn)) {
> >> +                    pgmap = get_dev_pagemap(pfn, NULL);
> >> +                    if (pgmap)
> >> +                            put_dev_pagemap(pgmap);
> >> +            }
> >> +    }
> >> +
> >> +    return !!pgmap;
> > You need to get Dan to check this out, but I'm pretty sure this should
> > be more like this:
> >
> > if (is_zone_device_page(page) && page->pgmap->type == MEMORY_DEVICE_FS_DAX)
>
> Great, i have added him.
>
>
>
> >
> >
> >> +static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
> >> +{
> >> +    struct page *page = NULL;
> >> +    char *vaddr = iova_to_vaddr(mr, iova, length);
> >> +
> >> +    if (!vaddr) {
> >> +            pr_err("not a valid iova %llu\n", iova);
> >> +            return false;
> >> +    }
> >> +
> >> +    page = virt_to_page(vaddr);
> > And obviously this isn't uniform for the entire umem, so I don't even
> > know what this is supposed to mean.
>
> My intention is to check if a memory region belongs to a nvdimm/pmem.
> The approach is like that:
> iova(user space)-+                     +-> page -> page_in_dev_pagemap()
>                   |                     |
>                   +-> va(kernel space) -+
> Since current MR's va is associated with map_set where it record the relations
> between iova and va and page. Do do you mean we should travel map_set to
> get its page ? or by any other ways.

Apologies for the delay in responding.

The Subject line of this patch is confusing, if you want to know if a
pfn is in persistent memory the only mechanism for that is:

region_intersects(addr, length, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)

...there is otherwise nothing pmem specific about the dev_pagemap
infrastructure. Yes, pmem is the primary user, but it is also used for
mapping "soft-reserved" memory (See: the EFI_MEMORY_SP) attribute, and
other users.

Can you clarify the intent? I am missing some context.
