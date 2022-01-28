Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9A49F0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbiA1Cbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiA1Cba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:31:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4BC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:31:30 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id r14so4135128qtt.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBSO0JiP6iYifSeVX8bHYUDeIjW8UqgFRfdhyYm6FEY=;
        b=Ll1BPYztCwKN6N7nCGaA9PZyCjGwY2kDFSQFBIwBU2ZEe+PMlt0fFB0PlPPP01Jnn4
         Xs3APSXSq+JPafLMGlhxtB0OyAOZyablpPRvlxqgUf1w9iiGKMOyOjJPtfzdPdZmKklN
         gQrCFgKs+ryFNT60w3Plxsrzx0YoRqgPr9N43osfxqoo+JNih+GxOqxYnF/ISfiPuKIq
         vwsrQPTnQvx27gUit3Fv9IMt88DNub1hn/kPm8m6jUdxnPidt097ZeUxjzepOl4R02+A
         WKE2Z24x9hnyqQa/8ufwmlj/kITQo7rYeLRRCSiQ/HVvHoyOUjVN0UV1hyVATYz1QZ1Y
         e9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBSO0JiP6iYifSeVX8bHYUDeIjW8UqgFRfdhyYm6FEY=;
        b=6px6Ejq19bBobmBiSWMEUpAU+GW3NH8p4lh28u6xlFqGBStkFIcGUb7f/byCw1XE5a
         RP0m129wrpQS1R49pIJtbHpX3Z13PFPkpdpzTyD1tzogjotYSjLVrJLhlyxQN4Iw8XT4
         AcFGitXY7L7Hd98/7DR1rdoa1x5SZ4KuNDv4XWVqbeelTPi2OyZeAe9XXPZ7W5Ggpizs
         mpNIxSs5TTlVv5eho5w3TdDpl8A2GksBqZPEnPWj8u3p8yUm12R6XNolWqtRsLkG3ffi
         LqpVAjgR7EXsT/Nsbcs3qW9G6NcW6E+LQeylsRg4zZEmO9vpG93N/dhGI+NiEh/j8DH2
         0UEw==
X-Gm-Message-State: AOAM532ybmuN+tQn3daLrHGJqw4rjeixgYlYScovuZz3PhiplLEcTs3W
        GbyptSxDAT7XC9j6EEGOnlM6Jw==
X-Google-Smtp-Source: ABdhPJzcyx9s/wHO/0iOPgK//H2ExJco2Rul/11ythT7/+GThiDuJLRvCchrLXYN9n8ZnQTzLslwlw==
X-Received: by 2002:a05:622a:1a0b:: with SMTP id f11mr4849070qtb.329.1643337088807;
        Thu, 27 Jan 2022 18:31:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h9sm2465080qkn.54.2022.01.27.18.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:31:28 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nDH2t-007K8d-88; Thu, 27 Jan 2022 22:31:27 -0400
Date:   Thu, 27 Jan 2022 22:31:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Message-ID: <20220128023127.GR8034@ziepe.ca>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
 <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca>
 <YfNIjqPpty0YkLJP@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfNIjqPpty0YkLJP@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 09:36:14AM +0800, Peter Xu wrote:
> On Thu, Jan 27, 2022 at 11:25:38AM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 27, 2022 at 05:19:56PM +0800, Peter Xu wrote:
> > 
> > > > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > > > index f0af462ac1e2..8ebc04058e97 100644
> > > > > > +++ b/mm/gup.c
> > > > > > @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> > > > > >   		pte_t *pte, unsigned int flags)
> > > > > >   {
> > > > > >   	/* No page to get reference */
> > > > > > -	if (flags & FOLL_GET)
> > > > > > +	if (flags & (FOLL_GET | FOLL_PIN))
> > > > > >   		return -EFAULT;
> > > > > 
> > > > > Yes. This clearly fixes the problem that the patch describes, and also
> > > > > clearly matches up with the Fixes tag. So that's correct.
> > > > 
> > > > It is a really confusing though, why not just always return -EEXIST
> > > > here?
> > > 
> > > Because in current code GUP handles -EEXIST and -EFAULT differently?
> > 
> > That has nothing to do with here. We shouldn't be deciding what the
> > top layer does way down here. Return the correct error code for what
> > was discovered at this layer the upper loop should make the decision
> > what it should do
> > 
> > > We do early bail out on -EFAULT.  -EEXIST was first introduced in 2015 from
> > > Kirill for not failing some mlock() or mmap(MAP_POPULATE) on dax (1027e4436b6).
> > > Then in 2017 it got used again with pud-sized thp (a00cc7d9dd93d) on dax too.
> > > They seem to service the same goal and it seems to be designed that -EEXIST
> > > shouldn't fail GUP immediately.
> > 
> > It must fail GUP immeidately if there is a pages list.
> 
> Right, but my point is we don't have an user at all for follow_page_mask()
> returning -EEXIST with a **page which is non-NULL.  Or did I miss
> it?

We don't, but that isn't the point - it is about understandability not
utility.

There are only two call chains that involve follow_page_mask(), one
always wants the -EEXIST and the other wants -EEXIST sometimes and
sometimes wants to return -EFAULT for -EEXIST

The solution is not to change follow_page_mask() but to be consistent
throughout that -EEXIST means we encountered a populated but
non-struct page PTE and the single place that wants -EEXIST to be
reported as -EFAULT (__get_user_pages) should make that
transformation.

For instance, should we return -EEXIST in other cases like devmap and
more that have PTEs present but are not returnable? It is already
really confusing (and probably wrong) that we sometimes return NULL
for populated PTEs. NULL causes faultin_page() to be called on
something we already know is populated, seems like nonsense.

I certainly don't want to see every place like that doing some if to
transform -EEXIST into -EFAULT.

> > Callers that want an early failure must pass in NULL for pages, it is
> > just that simple. It has nothing to do with the FOLL flags.
> > 
> > A WARN_ON would be appropriate to compare the FOLL flags against the
> > pages. eg FOLL_GET without a pages is nonsense and should be
> > immediately aborted. On the other hand, we avoid this by construction
> > internal to gup.c
> 
> We have something like that already, although it's only a VM_BUG_ON() not a
> BUG_ON() or WARN_ON() at the entry of __get_user_pages():
> 
> 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));

Right

> I believe this works too and I think I get your point, but as stated above it's
> just not used yet so the path is not useful to any real code path.

It is not about useful, it is about understandable and
consistency.. There should be clear rules about when and what errno to
return in every case, we should trend in that direction.

Jason
