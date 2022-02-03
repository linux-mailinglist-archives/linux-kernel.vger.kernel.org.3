Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560AE4A872B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351612AbiBCPB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbiBCPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:01:27 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7903C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:01:26 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id g13so2777655qvw.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rS/LGN0/YOa0OAM/80MdNEEJBLBrhqAWTkIJvDgXmcQ=;
        b=J5/OFB7pkOvdYeAJamQlMDZOqV7vskQPo1YiNSmzwJSTfJavvTf4/LPfcJQyaRXrad
         9I3w3oH1O24svZm24QtX8bPN7QIUR+tQ6ILQVb149MO4tajjQTHtGN4Y3PgPt65S1JbG
         yUijflAg8s3MjaR8endHPJwnR9VD3RKHsp9yXvxpki/ER4NlbaFXDWqcWiZUngGnITpw
         zMKMzb9yH4Xj/9R/IeavEmOOrGrsD3Rg2cDlmWhVe6deN6T78lZJ/4WjWfv0leA1VDw0
         /EkEjUxmffhHObJtWX6L3GUMwMqx6amoRcHfls/rswFInEA54A1XxhDtgYraICFwPPvA
         pACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rS/LGN0/YOa0OAM/80MdNEEJBLBrhqAWTkIJvDgXmcQ=;
        b=OgNrF+YD60MfiF34yHcF1ybD8LU9DNEY5QP2Megl4s0CZ4bCFs+oFw7BEBpoPBsfio
         13iiDz3P/9N7Jr4IRh8ELvFIvtJ/actcVB9/qDYUiYUMHwJfLwxwVUuI42XRYWUz04ML
         Js3xYvGAonSudSrOO48ajnl4G3Wfv/nQ84eFwmojp7yJfFXf3I5hqTu8rBcy+iSyFbIj
         Be65vgFujgcCS+xWGr9aRP8YZApYrK9vKFH2M3OHevx8lwG/E1TthDqkHvG/A/Jm77QI
         CdRXUFF1OAqwzEAUYV+6BA8hld9UN/kZWBLq4heWfFggBqKxSP+3ZeLzZwU4Zh3kJRQl
         ZqKQ==
X-Gm-Message-State: AOAM531ESNFrF+do0tz8w1tk7Y7Jzm+soODHuula4opjml80F0YiU8sz
        r9I0U0Kwn8xANqwD+pxeoUrUBA==
X-Google-Smtp-Source: ABdhPJwuj0w6gseoaq6YUerR8CwXsppvPjOuZlzTsVoRGzDgRs2E8JieoB+YdD5CT+WOl43dslA2mw==
X-Received: by 2002:a05:6214:21a8:: with SMTP id t8mr31297193qvc.6.1643900485579;
        Thu, 03 Feb 2022 07:01:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c78sm13372215qkg.42.2022.02.03.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:01:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nFdbv-00BFJx-NQ; Thu, 03 Feb 2022 11:01:23 -0400
Date:   Thu, 3 Feb 2022 11:01:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20220203150123.GB8034@ziepe.ca>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-3-jhubbard@nvidia.com>
 <20220203135352.55f35pztwmdx2rhk@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203135352.55f35pztwmdx2rhk@quack3.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:53:52PM +0100, Jan Kara wrote:
> On Thu 03-02-22 01:32:30, John Hubbard wrote:
> > Regardless of any FOLL_* flags, get_user_pages() and its variants should
> > handle PFN-only entries by stopping early, if the caller expected
> > **pages to be filled in.
> > 
> > This makes for a more reliable API, as compared to the previous approach
> > of skipping over such entries (and thus leaving them silently
> > unwritten).
> > 
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> >  mm/gup.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 65575ae3602f..cad3f28492e3 100644
> > +++ b/mm/gup.c
> > @@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
> >  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> >  		pte_t *pte, unsigned int flags)
> >  {
> > -	/* No page to get reference */
> > -	if (flags & (FOLL_GET | FOLL_PIN))
> > -		return -EFAULT;
> > -
> >  	if (flags & FOLL_TOUCH) {
> >  		pte_t entry = *pte;
> >  
> 
> This will also modify the error code returned from follow_page(). 

Er, but isn't that the whole point of this entire design? It is what
the commit that added it says:

commit 1027e4436b6a5c413c95d95e50d0f26348a602ac
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Fri Sep 4 15:47:55 2015 -0700

    mm: make GUP handle pfn mapping unless FOLL_GET is requested
    
    With DAX, pfn mapping becoming more common.  The patch adjusts GUP code to
    cover pfn mapping for cases when we don't need struct page to proceed.
    
    To make it possible, let's change follow_page() code to return -EEXIST
    error code if proper page table entry exists, but no corresponding struct
    page.  __get_user_page() would ignore the error code and move to the next
    page frame.
    
    The immediate effect of the change is working MAP_POPULATE and mlock() on
    DAX mappings.

> A quick audit shows that at least the user in mm/migrate.c will
> propagate this error code to userspace and I'm not sure the change
> in error code will not break something... EEXIST is a bit strange
> error code to get from move_pages(2).

That makes sense, maybe move_pages should squash the return codes to
EEXIST?

Jason
