Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C955B4A8591
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350914AbiBCNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:53:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbiBCNxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:53:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A187F1F3AF;
        Thu,  3 Feb 2022 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643896432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPcGj79vup/xftEUTwDECNujdK5ZRlnSHT2lp1q2f9M=;
        b=14WdU8eCrNFqgKv2TI0sjyolRoRpgevK923gOQnPYL6/lZ1M1/ySFE4j/sy1fu/aXUhxBG
        j15kJa5Kgh/XM2Gn4vwtFcwBg1Zq+589YyRJkZ3s/fSziAbl0e/2vq19ZHtwUTu2bzCq0e
        a/WF6SJw7LLOwNsu7w20LdRR194iWqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643896432;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPcGj79vup/xftEUTwDECNujdK5ZRlnSHT2lp1q2f9M=;
        b=J14NvFaplAkr+hhdnT45sk/xOh2p+jXRGapbEmn5XpIiTRt57pPiktXxBRd63Hbu0XiGme
        sG30JcQwr/UTkhCw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B376A3B81;
        Thu,  3 Feb 2022 13:53:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 31CF2A05B6; Thu,  3 Feb 2022 14:53:52 +0100 (CET)
Date:   Thu, 3 Feb 2022 14:53:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 2/4] mm/gup: clean up follow_pfn_pte() slightly
Message-ID: <20220203135352.55f35pztwmdx2rhk@quack3.lan>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203093232.572380-3-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-02-22 01:32:30, John Hubbard wrote:
> Regardless of any FOLL_* flags, get_user_pages() and its variants should
> handle PFN-only entries by stopping early, if the caller expected
> **pages to be filled in.
> 
> This makes for a more reliable API, as compared to the previous approach
> of skipping over such entries (and thus leaving them silently
> unwritten).
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 65575ae3602f..cad3f28492e3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>  		pte_t *pte, unsigned int flags)
>  {
> -	/* No page to get reference */
> -	if (flags & (FOLL_GET | FOLL_PIN))
> -		return -EFAULT;
> -
>  	if (flags & FOLL_TOUCH) {
>  		pte_t entry = *pte;
>  

This will also modify the error code returned from follow_page(). A quick
audit shows that at least the user in mm/migrate.c will propagate this
error code to userspace and I'm not sure the change in error code will not
break something... EEXIST is a bit strange error code to get from
move_pages(2).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
