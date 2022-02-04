Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAE4A988B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358471AbiBDLmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:42:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52252 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBDLms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:42:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D4732210FB;
        Fri,  4 Feb 2022 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643974967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vTMEeuc5XcaxXNy7RhPX2Qj+TF9VsgpJldSEApLliY=;
        b=shIYF4Q81+Q7n2FnlCw4AleLDUBuS+Vp14Nlvawm65Md73a6NHXv6fnJJEfUiG5puSo6p6
        mp4KfJQ+S/RtFzk5cRI02O1Yz2kfYJPt/KVdpcd0b9YtKRLsltrTQNQ2oVReTahqXwce5X
        k5iV43fTTjE9AsKPlUnKbpC+kDzwrKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643974967;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vTMEeuc5XcaxXNy7RhPX2Qj+TF9VsgpJldSEApLliY=;
        b=tMa6OywQY7J+wtQOvfqQ0fpqhivw/YXG0qt/1HglAAN5YoEjadOBG3gKQr5zFDMLDODeNg
        aaxEu/ZqSf+W2XCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B7342A3B84;
        Fri,  4 Feb 2022 11:42:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5AA3FA05B6; Fri,  4 Feb 2022 12:42:47 +0100 (CET)
Date:   Fri, 4 Feb 2022 12:42:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/5] mm: Fix invalid page pointer returned with
 FOLL_PIN gups
Message-ID: <20220204114247.dupafq4yogate2sz@quack3.lan>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
 <20220204020010.68930-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204020010.68930-2-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-02-22 18:00:06, John Hubbard wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Alex reported invalid page pointer returned with pin_user_pages_remote() from
> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
> pinning with struct vfio_batch").
> 
> It turns out that it's not the fault of the vfio commit; however after vfio
> switches to a full page buffer to store the page pointers it starts to expose
> the problem easier.
> 
> The problem is for VM_PFNMAP vmas we should normally fail with an -EFAULT then
> vfio will carry on to handle the MMIO regions.  However when the bug triggered,
> follow_page_mask() returned -EEXIST for such a page, which will jump over the
> current page, leaving that entry in **pages untouched.  However the caller is
> not aware of it, hence the caller will reference the page as usual even if the
> pointer data can be anything.
> 
> We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP handle pfn
> mapping unless FOLL_GET is requested") which seems very reasonable.  It could
> be that when we reworked GUP with FOLL_PIN we could have overlooked that
> special path in commit 3faa52c03f44 ("mm/gup: track FOLL_PIN pages"), even if
> that commit rightfully touched up follow_devmap_pud() on checking FOLL_PIN when
> it needs to return an -EEXIST.
> 
> Attaching the Fixes to the FOLL_PIN rework commit, as it happened later than
> 1027e4436b6a.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Debugged-by: Alex Williamson <alex.williamson@redhat.com>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [jhubbard: added some tags, removed a reference to an out of tree module.]
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Makes sence. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a9d4d724aef7..80229ecf0114 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -465,7 +465,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>  		pte_t *pte, unsigned int flags)
>  {
>  	/* No page to get reference */
> -	if (flags & FOLL_GET)
> +	if (flags & (FOLL_GET | FOLL_PIN))
>  		return -EFAULT;
>  
>  	if (flags & FOLL_TOUCH) {
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
