Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466EB49790D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiAXGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiAXGwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:52:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD4C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 22:52:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id b5so1071096qtq.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 22:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GlZoPqVPMm8RdzMvl6/ibZbcFUKUURz2grmYcIEKsF4=;
        b=ZnJmo/tGKN055rn72N6Zih24GuRsdF9ySmWk98JFId85TRPI5Bo9Srp8Qxam3fQDJ6
         YiXimDvmxFLI1p++IhektBbDyPa2EWiUfXtpmMofib54Sydmebg3t4cC0F/5BW+QJ0Oc
         tV/9k73B48lKBzA8SQgkdLXkTb996NKgNDB/8FZtZjyXDFrWBpx4huqJZEZJqAWTMl6P
         nlrie6WPWp18Xh/L6vXTe0v4PD8PLltO6P02OvmujPoGWFHMbaD2LOXBd6MN11/HrVJe
         93qlce16WxMHl9IPGvqYYia9EbJbOaj9Duq96QoWdHpu8cCH9XqGNow2mOquYLhD4L50
         +7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GlZoPqVPMm8RdzMvl6/ibZbcFUKUURz2grmYcIEKsF4=;
        b=YHQb9nzCWyxUfEYwQ8uSFkf4ZS4NQwM5neN+/FOETcM/pJ11wosKAGGQdRm4dK4wQW
         fPIAEH+iCSiOZDoEil81v63GHqx4lBZBWo0m1emmArwFIpw3akdk0Zke0+WrlfkEpV5x
         Jf5ELWwgV+mpU6nngmEtgh5verEQ9svGOStB7OJozXZAeMG0lEzmMjn28E2nUxWw28Of
         kzJ3mMy8nLlgwPnSZVm7Z1U9AKSre2gUYo3eCz94mH0yc1jOT3yGd9fABC5ZUE+2DZia
         2G4dnB7OQKAmQ3Re4T9DYVuShikWZW80Es67BsOORC4fLQaHZwc7eJdUrM45vXnmJyua
         OvTA==
X-Gm-Message-State: AOAM531A8xwbGBoV9uommEFiAyo2nmZNr1GcTgGvlhvRviycIWnowRIv
        0ZcCjdWxD89X78V/LWlkujKhgA+8wG8VnQ==
X-Google-Smtp-Source: ABdhPJyvKmnM6+ruVpjumUaaLZD1vF5Eeom7w0xuDWFc3jn9+iR8DqsytCpYes98PVSOcgbIsPFcAA==
X-Received: by 2002:a05:622a:3ca:: with SMTP id k10mr5412768qtx.506.1643007120064;
        Sun, 23 Jan 2022 22:52:00 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f5sm4241152qkp.40.2022.01.23.22.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 22:51:59 -0800 (PST)
Date:   Sun, 23 Jan 2022 22:51:57 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
In-Reply-To: <YepAgBz4EUXc/jrM@xz-m1.local>
Message-ID: <56e33192-965d-691a-afc-f77f5856afd@google.com>
References: <20211115134951.85286-1-peterx@redhat.com> <20211115134951.85286-2-peterx@redhat.com> <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com> <Yd7VEXI+/Lu8MVOo@xz-m1.local> <Yd7W6ndSPkXQjurY@xz-m1.local> <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
 <Yek6PaW8fAXY4Bft@xz-m1.local> <YeokbrpCdAGAYHEl@xz-m1.local> <YepAgBz4EUXc/jrM@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022, Peter Xu wrote:
> 
> Oh, one more thing..
> 
> When reading the history and also your explanations above, I figured one thing
> that may not be right for a long time, on zero page handling of zapping.
> 
> If to quote your comment above, we should keep the zero page entries too if
> zap_details.zap_mapping is specified.  However it's not true for a long time, I
> guess starting from when vm_normal_page() returns NULL for zero pfns.  I also
> have a very strong feeling that in the old world the "page*" is non-NULL for
> zero pages here.
> 
> So... I'm boldly thinking whether we should also need another fix upon the zero
> page handling here too, probably before this whole patchset (so it'll be the
> 1st patch, it should directly apply to master) because if I'm right on above it
> can be seen as another separate bug fix:
> 
> ---8<---
> diff --git a/mm/memory.c b/mm/memory.c
> index f306e698a1e3..9b8348746e0b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1320,11 +1320,18 @@ struct zap_details {
>  static inline bool
>  zap_skip_check_mapping(struct zap_details *details, struct page *page)
>  {
> -       if (!details || !page)
> +       /* No detail pointer or no zap_mapping pointer, zap all */
> +       if (!details || !details->zap_mapping)
>                 return false;
>  
> -       return details->zap_mapping &&
> -               (details->zap_mapping != page_rmapping(page));
> +       /*
> +        * For example, the zero page.  If the user wants to keep the private
> +        * pages, zero page should also be in count.
> +        */
> +       if (!page)
> +               return true;
> +
> +       return details->zap_mapping != page_rmapping(page);
>  }
>  
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> ---8<---
> 
> page can be NULL for e.g. PFNMAP and when error occured too above.  I assume we
> don't need to bother with them (e.g., I don't think PFNMAP or MIXED should
> specify even_cows=false at all, because there's no page cache layer), though.
> Mostly it's about how we should handle zero page right.

I have not understood the above.

I don't know of any problem that needs fixing with the zero page:
how do you suppose the zero page gets into a truncatable or hole-punchable
mapping?  We use it for read faults in anonymous mappings.  And I told the
story of how once-upon-a-time it could get inserted into any mapping by
reading from /dev/zero, but that odd case was dropped years ago.  And I
am open to (even encouraging) a change to make use of zero page for read
faults of holes in shmem: but that's potential future work, which would
require some changes elsewhere (though perhaps none here: the zero page
could never be used for the result of a COW).

Please explain the zero page problem you hope to fix here.

Hugh
