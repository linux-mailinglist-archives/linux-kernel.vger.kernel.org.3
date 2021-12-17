Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860FA479483
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhLQTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhLQTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:05:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A60C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 11:05:06 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z9so11597343edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7F2aHCSe8IzO12Nz4RyfBAXoLOfk6p6JbZVcFiKHrQg=;
        b=ZjQ4/n3jpC4K+CjIh7Q22vd534RgwvYHtS9nR1P4Lv9P3PuipIG4Ky5i+x88FHfNU+
         COO7Q+1L2Wl2VME7dDHc3akKiuLmeIvlviUDhdeTrCBSljMxVDX7hZf2YhkozKnphVFk
         YaiCt3VRfbmQic5ajEaNqa5Otx58kYxFTYkgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7F2aHCSe8IzO12Nz4RyfBAXoLOfk6p6JbZVcFiKHrQg=;
        b=n+GNWCystq6OhLZPLpnE1ao2eHnJqFfsu+PHtO0JXKJiroj+uVz4QeKQaixASiBF8G
         4gYYtk4muUD3M7IHvA1uyCTa+3sq4XnaE8YB4cJV72pczahY/2LVmd87RnDTKcNA0CWT
         xH4gp4FF7T6crSrd6+HKa+EYs4EL/S9oaM8/tzkTq0+Dp8nrjSMNvmcmh6olU3QB16aI
         DZGTZOL8Rbq2bmSonvLPWhg4Htca4I5R0SiiaonHQ5BDDBZ51tzgjiotmEz7Vs+l7yhK
         OzQKaFjnNgnMo2jMyr1afScx4sBWb6RUR9jXA9a8lFZBWDXZlZ7HFTbTslJCLgIlYsER
         iA5Q==
X-Gm-Message-State: AOAM53314/21kKpULNY5M2WgZmQXfg+nWBgUxJW5dGUwFII/b4BJ7YU1
        gYdDQftDVtUVJdMn/PZEK+a/JzZaZmlJ9wJku5M=
X-Google-Smtp-Source: ABdhPJzWBOHRB9F0HTSDG7+BpP+aG/FRGwPr2cbV5BVlKypiGY/lf7fBsmcPO1hhq0ycwMWVqPUXDg==
X-Received: by 2002:a17:906:fac1:: with SMTP id lu1mr3574120ejb.171.1639767905196;
        Fri, 17 Dec 2021 11:05:05 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id qw25sm3274702ejc.185.2021.12.17.11.05.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 11:05:04 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id o29so2271594wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 11:05:03 -0800 (PST)
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr1762683wmb.152.1639767903770;
 Fri, 17 Dec 2021 11:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
In-Reply-To: <20211217113049.23850-7-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 11:04:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
Message-ID: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 3:34 AM David Hildenbrand <david@redhat.com> wrote:
>
> + * If the child takes a read-only pin on such a page (i.e., FOLL_WRITE is not
> + * set) and then unmaps the target page, we have:
> + *
> + * * page has mapcount == 1 and refcount > 1

All these games with mapcount makes me think this is still broken.

mapcount has been a horribly broken thing in the past, and I'm not
convinced it's not a broken thing now.

> +       vmf->page = vm_normal_page(vmf->vma, vmf->address, vmf->orig_pte);
> +       if (vmf->page && PageAnon(vmf->page) && !PageKsm(vmf->page) &&
> +           page_mapcount(vmf->page) > 1) {

What keeps the mapcount stable in here?

And I still believe that the whole notion that "COW should use
mapcount" is pure and utter garbage.

If we are doing a COW, we need an *exclusive* access to the page. That
is not mapcount, that is the page ref.

mapcount is insane, and I think this is making this worse again.

                Linus
