Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898EA49D6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiA0AmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiA0AmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:42:09 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5294C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:42:08 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id y8so1203158qtn.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bnqZcSOUBs5sY/5j7CBOSOw5Sx0eF1Hfwywx6M39Fnk=;
        b=mwO1LpNsfyjAmMoxGx2V/hsh5Pk5fKxYt6rJWfdiUHvdLJXyE1faV5ABM29QqZXJmn
         wZOkSDB47mLo9b2uQsv0TqF5wl40KzkCGV8y0pG3jOz872t4MiER/jSEyltK/r39N9mz
         RmHrCZJvKZCHQ8lEQqchQ8dp2P9ScqiMUsCYvvcbsGfkWjGTqcvFnh9Jg8Wlc2VDIXp5
         8GwifcIsd4oKqlFJpJEiD9Rgq/GSa8UNJICOlW89CtACQNLVrHQadmNhd/ZYHD7MGUH3
         ox9zQNTz8MnGal7j2HPVp9kT7H91AjYVUk26Tefjt6wcBLQUllWusU70nLQiY67pwi/0
         aiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnqZcSOUBs5sY/5j7CBOSOw5Sx0eF1Hfwywx6M39Fnk=;
        b=Ekl0+C0uTgHDAQlM3OGOCwabSearsFlzzdbGt4oVV0Y+uwQ+d6BuaHGTMfHu0ynjDh
         wfib63PkycE/c02dTl5DejO7XjA/9l8jDIS3fYFIy11o6Yyg11vSoNDf26uxK8iMXjBN
         su6eRtm4PaRSmhxiTz0algvamoZehH1V30Nrncrqj35uoxp1VbnzvSl1lzSfmt1a3SuI
         EnPyPHBJYVt/XJUQVhRt/RVKfHfeRQekPLr/7TbBzLdOd0m+53DdfMPMMoHfpf69eZaY
         bqdmLoA2rS9nx/QQQuPPaHydNv/qW18WSrxoLA5DuRfoyBjM2mNJLXz6xGXjjXUWLiMF
         GONQ==
X-Gm-Message-State: AOAM530oOlLmlIVv2GnwdaCwsAeyHGX40ibdZq2ZOfKj1KBVZVzg2WQE
        oomxxJOh1BdWnjL/eqwnXl6ZS6EPqm1ZjQ==
X-Google-Smtp-Source: ABdhPJx2URkyBLEcA/QFr2E6yt/ZE6AVVxwQTugVCTs7LL4aFX7UBjXrwHKGyBHnIxIBAjH+kbwNfg==
X-Received: by 2002:a05:622a:199c:: with SMTP id u28mr982324qtc.221.1643244128025;
        Wed, 26 Jan 2022 16:42:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t22sm535796qkp.8.2022.01.26.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:42:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nCsrW-0065us-IN; Wed, 26 Jan 2022 20:42:06 -0400
Date:   Wed, 26 Jan 2022 20:42:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Message-ID: <20220127004206.GP8034@ziepe.ca>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:15:02PM -0800, John Hubbard wrote:

> > We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP handle pfn
> > mapping unless FOLL_GET is requested") which seems very reasonable.  It could
> > be that when we reworked GUP with FOLL_PIN we could have overlooked that
> > special path in commit 3faa52c03f44 ("mm/gup: track FOLL_PIN pages"), even if
> > that commit rightfully touched up follow_devmap_pud() on checking FOLL_PIN when
> > it needs to return an -EEXIST.

It sounds like this commit was all about changing the behavior of
follow_page()

It feels like that is another ill-fated holdover from the effort to
make pageless DAX that doesn't exist anymore.

Can we safely drop it now?

Regardless..

> > diff --git a/mm/gup.c b/mm/gup.c
> > index f0af462ac1e2..8ebc04058e97 100644
> > +++ b/mm/gup.c
> > @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> >   		pte_t *pte, unsigned int flags)
> >   {
> >   	/* No page to get reference */
> > -	if (flags & FOLL_GET)
> > +	if (flags & (FOLL_GET | FOLL_PIN))
> >   		return -EFAULT;
> 
> Yes. This clearly fixes the problem that the patch describes, and also
> clearly matches up with the Fixes tag. So that's correct.

It is a really confusing though, why not just always return -EEXIST
here?

The caller will always see the error code and refrain from trying to
pin it and unwind upwards, just the same as -EFAULT. 

We shouldn't need to test the flags at this point at all.

> >   	if (flags & FOLL_TOUCH) {
> > @@ -1181,7 +1181,13 @@ static long __get_user_pages(struct mm_struct *mm,
> >   			/*
> >   			 * Proper page table entry exists, but no corresponding
> >   			 * struct page.
> > +			 *
> > +			 * Warn if we jumped over even with a valid **pages.
> > +			 * It shouldn't trigger in practise, but when there's
> > +			 * buggy returns on -EEXIST we'll warn before returning
> > +			 * an invalid page pointer in the array.
> >   			 */
> > +			WARN_ON_ONCE(pages);
> 
> Here, however, I think we need to consider this a little more carefully,
> and attempt to actually fix up this case. It is never going to be OK
> here, to return a **pages array that has these little landmines of
> potentially uninitialized pointers. And so continuing on *at all* seems
> very wrong.

Indeed, it should just be like this:

@@ -1182,6 +1182,10 @@ static long __get_user_pages(struct mm_struct *mm,
                         * Proper page table entry exists, but no corresponding
                         * struct page.
                         */
+                       if (pages) {
+                               page = ERR_PTR(-EFAULT);
+                               goto out;
+                       }
                        goto next_page;
                } else if (IS_ERR(page)) {
                        ret = PTR_ERR(page);

Jason
