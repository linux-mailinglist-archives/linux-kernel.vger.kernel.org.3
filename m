Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5E4A5BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiBAMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:10:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59102 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiBAMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:10:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C98AA21108;
        Tue,  1 Feb 2022 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643717434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKH9Cd4KxNwtN05OHDJZkzoPCUu13WUSs8b5mcRqsKw=;
        b=pCEujgIEzHwYjWnbttnsPevqyMCQKHr9J8DaAmKKCSzj7PhVQJd1dK9zsceeidGflrDfwe
        SSrvzHT0zsx/lO/HsVYjIRN6P2mmwQyW7Djb+uyQYBJ959rN9i6iXo9AaQhwlDBymeDHdU
        xt0KXf7C5d3Sm1ERVqPO0n6DzJCjl54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643717434;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKH9Cd4KxNwtN05OHDJZkzoPCUu13WUSs8b5mcRqsKw=;
        b=fSiw33LXjg/ip7UkjrjaPuFZBEVd2/Ryk73tLHKBPy8JNJ47fH88XV6tPYmojemtaZksCt
        F8gv98nHZ/EHb4Bw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9E3C3A3B83;
        Tue,  1 Feb 2022 12:10:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 46DBEA05B1; Tue,  1 Feb 2022 13:10:34 +0100 (CET)
Date:   Tue, 1 Feb 2022 13:10:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 3/4] mm/gup: remove unused pin_user_pages_locked()
Message-ID: <20220201121034.4jyyymqlvfx2grfy@quack3.lan>
References: <20220201101108.306062-1-jhubbard@nvidia.com>
 <20220201101108.306062-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201101108.306062-4-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-02-22 02:11:07, John Hubbard wrote:
> This routine was used for a short while, but then the calling code was
> refactored and the only caller was removed.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/mm.h |  2 --
>  mm/gup.c           | 29 -----------------------------
>  2 files changed, 31 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 213cc569b192..80c540c17d83 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1918,8 +1918,6 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    struct vm_area_struct **vmas);
>  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages, int *locked);
> -long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -		    unsigned int gup_flags, struct page **pages, int *locked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  		    struct page **pages, unsigned int gup_flags);
>  long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> diff --git a/mm/gup.c b/mm/gup.c
> index 8633bca12eab..58d01a96ab30 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3120,32 +3120,3 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
>  }
>  EXPORT_SYMBOL(pin_user_pages_unlocked);
> -
> -/*
> - * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
> - * Behavior is the same, except that this one sets FOLL_PIN and rejects
> - * FOLL_GET.
> - */
> -long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
> -			   unsigned int gup_flags, struct page **pages,
> -			   int *locked)
> -{
> -	/*
> -	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
> -	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> -	 * vmas.  As there are no users of this flag in this call we simply
> -	 * disallow this option for now.
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> -		return -EINVAL;
> -
> -	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
> -		return -EINVAL;
> -
> -	gup_flags |= FOLL_PIN;
> -	return __get_user_pages_locked(current->mm, start, nr_pages,
> -				       pages, NULL, locked,
> -				       gup_flags | FOLL_TOUCH);
> -}
> -EXPORT_SYMBOL(pin_user_pages_locked);
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
