Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDC4A878A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351795AbiBCPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351806AbiBCPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:19:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC83C061749
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JubVW6L5I/oihcd7EvRehLP90WpN/OdP8an7CGcf4Fg=; b=bhxVJaUVl9+20YoeMhbPx/Ti1Z
        tco5qjym0K5TEZxv0+zYQVOkXL6etkFMiS4CNqYzIFVCxB57iunTOFwiZklveFN/VH72wcRgjRMbm
        0S/ZT7oRcua/0tPaFvyN33V1PE+v4Il/rT76ARoGi74foqRik63V8G8uRs7ioWWHCmGdwM6kD0WKD
        hqrUyp0e2iqBGvOZfIZ9d6fzZZGaTgmNTKAn/sjq93rO86RsXSSIEDwqEbExnYJgfBELURKum0tWf
        cnItgvVkK7h/pvAC9he1tPDGzEbEPZzY3TM4hvnp6CyU37QwJH8/9hXUnRRqJUgU+wSuOczVvlwvi
        ztpVpezw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFdsv-00295Z-1R; Thu, 03 Feb 2022 15:18:57 +0000
Date:   Thu, 3 Feb 2022 15:18:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/4] mm/gup: clean up follow_pfn_pte() slightly
Message-ID: <YfvyYWfXuWgRlVaC@casper.infradead.org>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-3-jhubbard@nvidia.com>
 <20220203135352.55f35pztwmdx2rhk@quack3.lan>
 <20220203150123.GB8034@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203150123.GB8034@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:01:23AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 03, 2022 at 02:53:52PM +0100, Jan Kara wrote:
> > On Thu 03-02-22 01:32:30, John Hubbard wrote:
> > > Regardless of any FOLL_* flags, get_user_pages() and its variants should
> > > handle PFN-only entries by stopping early, if the caller expected
> > > **pages to be filled in.
> > > 
> > > This makes for a more reliable API, as compared to the previous approach
> > > of skipping over such entries (and thus leaving them silently
> > > unwritten).
> > > 
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > >  mm/gup.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 65575ae3602f..cad3f28492e3 100644
> > > +++ b/mm/gup.c
> > > @@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
> > >  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> > >  		pte_t *pte, unsigned int flags)
> > >  {
> > > -	/* No page to get reference */
> > > -	if (flags & (FOLL_GET | FOLL_PIN))
> > > -		return -EFAULT;
> > > -
> > >  	if (flags & FOLL_TOUCH) {
> > >  		pte_t entry = *pte;
> > >  
> > 
> > This will also modify the error code returned from follow_page(). 
> 
> Er, but isn't that the whole point of this entire design? It is what
> the commit that added it says:
> 
> commit 1027e4436b6a5c413c95d95e50d0f26348a602ac
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Fri Sep 4 15:47:55 2015 -0700
> 
>     mm: make GUP handle pfn mapping unless FOLL_GET is requested
>     
>     With DAX, pfn mapping becoming more common.  The patch adjusts GUP code to
>     cover pfn mapping for cases when we don't need struct page to proceed.
>     
>     To make it possible, let's change follow_page() code to return -EEXIST
>     error code if proper page table entry exists, but no corresponding struct
>     page.  __get_user_page() would ignore the error code and move to the next
>     page frame.
>     
>     The immediate effect of the change is working MAP_POPULATE and mlock() on
>     DAX mappings.
> 
> > A quick audit shows that at least the user in mm/migrate.c will
> > propagate this error code to userspace and I'm not sure the change
> > in error code will not break something... EEXIST is a bit strange
> > error code to get from move_pages(2).
> 
> That makes sense, maybe move_pages should squash the return codes to
> EEXIST?

I think EFAULT is the closest:
              This  is  a  zero  page  or the memory area is not mapped by the
              process.

EBUSY implies it can be tried again later.

