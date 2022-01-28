Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB549F1D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbiA1D0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345574AbiA1D02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643340387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JdmHo35k2NnDAQTAY3bBMftwYDeAsSLF5WxNfFc63mo=;
        b=S7N9Zu6PLeR3hJj8FVYoBLTP9oRUuyj+ufVF1m6zxDRjxSzadslQAILJzrTP44asZ7Q/Kp
        ujewsRN8kmlngqWi7RGS+6dRZ0gIBNMBBGAbk0hv8pEm7vEkftpH9V+76mn6+B4irz0R/O
        g4yEc8NdTrta3vTeidski+rDXR9uqi4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-lDnF2nt6NbGmdRaSDKoHhQ-1; Thu, 27 Jan 2022 22:26:25 -0500
X-MC-Unique: lDnF2nt6NbGmdRaSDKoHhQ-1
Received: by mail-wm1-f71.google.com with SMTP id s1-20020a1ca901000000b0034ece94dd8cso5218939wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JdmHo35k2NnDAQTAY3bBMftwYDeAsSLF5WxNfFc63mo=;
        b=xyWLqG7NmR7Nn584ZJ1FLPGA249bC8fwLY40Ot07E9ZbtBow+0dDq4z/CodMkGgUCa
         Em3StrAeCt6HuZqH0PVrASV5+D0q5IMTm0/m6USxv3e71hivwfBtcSdXkdADSY3SCuT/
         lKlWrX82xRxFVWvfFSlsTF/rAGAroJmZlB8WC5io8GhGYHr/5tm2wbVrz5A4XUQoEc20
         /o56XVWTuRVcrFpujfam0HsC7WNM1/uPOJQKY9gFFMIQe0e+gROepUOhPjdkZ/rcj4/N
         Kd18SsiaNO+hWuwt+pOMdJLEmgVPgjVTBYaPfqk3Z0ncJ4zd28jSv39Q9l2i73vie6YR
         Yeug==
X-Gm-Message-State: AOAM531ZG49g7v9pT3Eg2MIFmw0r4ZzNlBW4ZJy5affQBabFr5euJJeC
        7JeVMPeKHlEopE8BR4g1nKrW/S2U5BjZPkuE73i8Yth2tFO/S6dGdvGngbhoEvqtmHmBQuAfGQe
        4algMGteVNCj7dwJNcImbrbCh
X-Received: by 2002:adf:face:: with SMTP id a14mr5278189wrs.239.1643340384525;
        Thu, 27 Jan 2022 19:26:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvOMUzGyzomgX5YmNf5nejcfKKFk5x769uBvFTsHFVUsur7g/UKdOWCg2AW/ZKXsbX2c4q5A==
X-Received: by 2002:adf:face:: with SMTP id a14mr5278178wrs.239.1643340384217;
        Thu, 27 Jan 2022 19:26:24 -0800 (PST)
Received: from xz-m1.local ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id u15sm3603917wrn.48.2022.01.27.19.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 19:26:23 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:26:16 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Message-ID: <YfNiWHDYH0dtj9rK@xz-m1.local>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
 <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca>
 <YfNIjqPpty0YkLJP@xz-m1.local>
 <20220128023127.GR8034@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128023127.GR8034@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 10:31:27PM -0400, Jason Gunthorpe wrote:
> We don't, but that isn't the point - it is about understandability not
> utility.
> 
> There are only two call chains that involve follow_page_mask(), one
> always wants the -EEXIST and the other wants -EEXIST sometimes and
> sometimes wants to return -EFAULT for -EEXIST
> 
> The solution is not to change follow_page_mask() but to be consistent
> throughout that -EEXIST means we encountered a populated but
> non-struct page PTE and the single place that wants -EEXIST to be
> reported as -EFAULT (__get_user_pages) should make that
> transformation.

Currently -EEXIST is not defined like that.  To me, it's defined as:

  This pte is populated but there's no page struct that binds to it. Let's skip
  this pte and continue (because we've checked there's no **pages requested).

That services use cases like mlock() very well.  IMHO that's fine.

If I understand correctly, what is proposed above is actually to redefine
-EEXIST into:

  This pte is populated but there's no page struct that binds to it.

Then the caller will decide how we should react on it.

I kind of agree that the latter one looks cleaner, but I don't have extremely
strong reason to refactor it immediately.

More importantly, I still don't know what will be the side effect if we
immediately remove the two checks in follow_page_mask(), and how much changeset
we'll need to redefine -EEXIST here.

Let's discuss the two sites that returns -EEXIST one by one..

follow_pfn_pte() should be relatively easy.  If with the -EEXIST to -EFAULT
convertion proposed in __get_user_pages(), we could have dropped below two
lines:

---8<---
diff --git a/mm/gup.c b/mm/gup.c
index 8ebc04058e97..b3a109114968 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
                pte_t *pte, unsigned int flags)
 {
-       /* No page to get reference */
-       if (flags & (FOLL_GET | FOLL_PIN))
-               return -EFAULT;
-
        if (flags & FOLL_TOUCH) {
                pte_t entry = *pte;
---8<---

Then the convertion will make sure it behaves like before.  There is a very
slight side effect on FOLL_TOUCH above but it shouldn't be a major concern, at
least not in the vfio use case - I believe most of the guest pages should
already have the dirty bit set anyways, and since they're pinned they won't be
a good candidate for reclaims already.

IMHO the other site follow_devmap_pud() is tricker, because we can't simply
remove the two lines here:

---8<---
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..0fe2253f922c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1171,15 +1171,6 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
        if (flags & FOLL_TOUCH)
                touch_pud(vma, addr, pud, flags);
 
-       /*
-        * device mapped pages can only be returned if the
-        * caller will manage the page reference count.
-        *
-        * At least one of FOLL_GET | FOLL_PIN must be set, so assert that here:
-        */
-       if (!(flags & (FOLL_GET | FOLL_PIN)))
-               return ERR_PTR(-EEXIST);
-
        pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
        *pgmap = get_dev_pagemap(pfn, *pgmap);
        if (!*pgmap)
---8<---

Because with the old code we'll 100% return -EEXIST as long as we don't have
GET|PIN (e.g. mlock), but then later when the two lines removed we'll start to
try call get_dev_pagemap(), if it returned something we'll start to fetch the
page.

That part looks fine, __get_user_pages() will still continue but ignore the
page* returned.

But what if get_dev_pagemap() returned NULL?  Then we'll start to return
-EFAULT where we used to constantly return -EEXIST.  I'm afraid it'll stop
working for some mlock() or MAP_POPULATE case that Kirill wanted to fix before,
then it could break things.

We could definitely add more code to fix up above to make sure mlock() on huge
pud of DAX will keep working.  However I hope I have somehow clarified the
point that it's not as trivial as it looks like to change the semantics of
-EEXIST for follow_page_mask() immediately, and to fix the vfio mdev breakage
we'd better merge the oneliner fix first even if we want to rework -EEXIST.

Summary: I see no problem at all on either way, it's just that for this bug fix
it's straightforward to keep the -EEXIST definition, rather than clean it up,
because otherwise the change will grow.  Note that we will need to backport
this patch, I think it's proper we keep the changeset small and leave the
cleanups for later.

> 
> For instance, should we return -EEXIST in other cases like devmap and
> more that have PTEs present but are not returnable? It is already
> really confusing (and probably wrong) that we sometimes return NULL
> for populated PTEs. NULL causes faultin_page() to be called on
> something we already know is populated, seems like nonsense.

Could you elaborate what's the "return NULL" confusion you mentioned?

> 
> I certainly don't want to see every place like that doing some if to
> transform -EEXIST into -EFAULT.
> 
> > > Callers that want an early failure must pass in NULL for pages, it is
> > > just that simple. It has nothing to do with the FOLL flags.
> > > 
> > > A WARN_ON would be appropriate to compare the FOLL flags against the
> > > pages. eg FOLL_GET without a pages is nonsense and should be
> > > immediately aborted. On the other hand, we avoid this by construction
> > > internal to gup.c
> > 
> > We have something like that already, although it's only a VM_BUG_ON() not a
> > BUG_ON() or WARN_ON() at the entry of __get_user_pages():
> > 
> > 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
> 
> Right
> 
> > I believe this works too and I think I get your point, but as stated above it's
> > just not used yet so the path is not useful to any real code path.
> 
> It is not about useful, it is about understandable and
> consistency.. There should be clear rules about when and what errno to
> return in every case, we should trend in that direction.

I see that both you and John has a strong preference on at least the
WARN_ON_ONCE() in the patch.

Do you think it's okay I repost with only the one-liner fix, which will keep
the Fixes but drop the WARN_ON_ONCE?  Then we can leave the rest as follow up.

For my own preference, I really like to keep the patch as-is, because as I
mentioned it helps to identify issues with existing code already (it'll even
help the reader when looking at the -EEXIST handling because that's not
obvious).  But I don't strongly ask for that, I still sincerely wish the
discussion won't block the real simple bugfix.

Thanks,

-- 
Peter Xu

