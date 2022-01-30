Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D284A3996
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 21:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356333AbiA3U6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 15:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347702AbiA3U6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 15:58:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E3CC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:58:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q63so11842369pja.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0Y2zJfEVi4pNu6D2VEzI1me9RN7QGeq2qjfX5SiFYYQ=;
        b=m6oBcQNk1Bo/QB4mFD5fF6CwPoQrnqAefkgg9zkInR37Pvr3p45/yRg1/WXWLxn4nJ
         Z7x+Qo16PS3Ra5661QKLv3f1eLNklKFXli4ArNRVXVKqe4N3qpoNdjw7sbfuJLa3R72K
         EU59mMGMhmnjaJVa86yiheKs3ro+EAgKTjkOszGGMHf+UKGOdlErUeKhtddEignp1bnG
         DfX3LS9zKKhSS2dH1P0DkMS8o6IF4g2ve3LYMP6xVMkto/SLWRno9DvrxQvv1w6peKHm
         PRhUZRP8rhh1a6I3vyDEF9GAgQPBm0EHjNwVQsbux4E394VYICW2MpG2+rQ4pHoqzUhR
         +RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0Y2zJfEVi4pNu6D2VEzI1me9RN7QGeq2qjfX5SiFYYQ=;
        b=N7z0R65SDvZb7ndFtdIl30hIiMpC0sBS0TdjNkf8cymw1HN6Z8BbUWDrRvZwCMThGw
         YDxF4t9ljod4wLqWENA5WnEfdk3kQOiMAEvPBJzHpT8p5ADnZ4yI/m0MAd9BeMbid9Hz
         RXE6J0Rwzdhbzeut6CIi5B30rTYs0Afx1GBBNwvJnQ/651ie0bMqGGrPR4+PZXOLw5ex
         pUWBX/arNtZU8yjnk6CYmD7CoCnGvO/M+39MfKdfypGHrFd1qvurOQlYfFuLYV0tdGCy
         u/4+1333/5OXYiBnnlg3ko1JlmQlNL1ms4jLOv+ac1WwIYjgQbX5p4Qe3/1aqL12xFGI
         OAaA==
X-Gm-Message-State: AOAM532Lo3+Bx+j34eXyAHn4/of5ZjTjAmA5BDM9Xsf2PDSNPl/BxehQ
        cLaj7LbW8MNFRejEFYumCCHhew==
X-Google-Smtp-Source: ABdhPJwQIi+kXbC7Wc3kLdz4gg130hIgjG9shotxm9tSWZLMlb9nsGhkbRWCi9da3/tGRxE7v2u22w==
X-Received: by 2002:a17:90b:2516:: with SMTP id ns22mr21188100pjb.242.1643576298007;
        Sun, 30 Jan 2022 12:58:18 -0800 (PST)
Received: from [2620:15c:29:204:2b97:ce13:593d:973d] ([2620:15c:29:204:2b97:ce13:593d:973d])
        by smtp.gmail.com with ESMTPSA id l13sm26870001pgs.16.2022.01.30.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 12:58:17 -0800 (PST)
Date:   Sun, 30 Jan 2022 12:58:17 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm/hwpoison: Check the subpage, not the head page
In-Reply-To: <20220130013042.1906881-1-willy@infradead.org>
Message-ID: <dcfa1ee5-1512-5e49-92c2-4a33ab59080@google.com>
References: <20220130013042.1906881-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022, Matthew Wilcox (Oracle) wrote:

> Hardware poison is tracked on a per-page basis, not on the head page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/rmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6a1e8c7f6213..09b08888120e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1553,7 +1553,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		/* Update high watermark before we lower rss */
>  		update_hiwater_rss(mm);
>  
> -		if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
> +		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
>  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>  			if (PageHuge(page)) {
>  				hugetlb_count_sub(compound_nr(page), mm);
> @@ -1873,7 +1873,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>  			 * memory are supported.
>  			 */
>  			subpage = page;
> -		} else if (PageHWPoison(page)) {
> +		} else if (PageHWPoison(subpage)) {
>  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>  			if (PageHuge(page)) {
>  				hugetlb_count_sub(compound_nr(page), mm);

This looks correct.  Correct me if I'm wrong that this is for consistency 
and cleanup and that there is no bug being fixed by this, however.

Thanks!
