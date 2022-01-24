Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB84987F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbiAXSLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbiAXSLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:11:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A2C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:11:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w190so10563782pfw.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hplmvL7wDWDjn1QFlc9u8Rz2NqKzd7tI4pOgh4hC0uk=;
        b=fJF6YWxS67b+WXJ/kZRALafhcc4hw67zf1+uP4o1aZQEKj+2cKcMa6Ka9f/8zrMVxS
         cqOnxJWlX7WzCZgMu/KyRCJ6ZVTUVUG1uFil+iuinSEImbQqTgnUK1f4MVvWX2WLE3Rb
         nZ3T5hx0L2rtQwgJOXn/nrNTnmRH7oIMhC9kltY6MuWzhNBkCCjJtdzfRKK+feGgZqk9
         un7V0NSk+TjRoF5orh4rlBUZMWeYflBdfi+PmGm15ieTqlRjAapF9/3eatTCSvNwypC/
         HlpAKm01mYc9kNVp8gakNZ1DjE1++PM6qzRarq4VXa9/0+qGYwg3aoX9W6CQvuIcSFQh
         ohxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hplmvL7wDWDjn1QFlc9u8Rz2NqKzd7tI4pOgh4hC0uk=;
        b=p93ebDIg+3X+bYCW3tYqm5Wa1qSc3722jZ7olvHg6klK1pyoy9X3owVdpBtPqW359n
         J+6CPObTF930HUACiqZY/FLEo8q1/vOEMMaFD8RRKE+2y4aEzB2Ai/L8xLY5OA/6CUGB
         MLGl86+AenOnET0dDm4K45qS/rUoKGzXDbOYBh0mrJHNGGrma1rh76abFUlFVz+ZQfky
         3+ZJN4vzsi88qgyEet72M5fD3us8KxiSxXPEij+4XPllxPBIlYverG8by6ZnL68h+AcY
         uIjwdSVIEx04faA7IialJRWLfFJPs2vBwJPMAPLu6+ejxV+CVt8V5jZ+ORgqROZlx4Ip
         Dx2Q==
X-Gm-Message-State: AOAM5313oxc60TSWmo5w0wFdWS8rAXwsewOIWFJvXUqtPMchfnoszcaz
        dxROCiLG2LnHGL8V3rQoo4qmfQ==
X-Google-Smtp-Source: ABdhPJzA+Y6+DamPb2TvXy85bCHzGMXiad6+zP/iBggpho3e8gjenXre/Iao0V1J9Sm3JKEKSjW36w==
X-Received: by 2002:a63:33cd:: with SMTP id z196mr12457613pgz.78.1643047862575;
        Mon, 24 Jan 2022 10:11:02 -0800 (PST)
Received: from [2620:15c:29:204:1f99:bd65:fcbb:146c] ([2620:15c:29:204:1f99:bd65:fcbb:146c])
        by smtp.gmail.com with ESMTPSA id t17sm17288302pfg.207.2022.01.24.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:11:01 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:11:00 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages
 of THP
In-Reply-To: <20220124051752.83281-2-songmuchun@bytedance.com>
Message-ID: <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com> <20220124051752.83281-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022, Muchun Song wrote:

> The D-cache maintenance inside move_to_new_page() only consider one page,
> there is still D-cache maintenance issue for tail pages of THP. Fix this
> by not using flush_dcache_folio() since it is not backportable.
> 

The mention of being backportable suggests that we should backport this, 
likely to 4.14+.  So should it be marked as stable?

That aside, should there be a follow-up patch that converts to using 
flush_dcache_folio()?

> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> Changes in v2:
>  - Using a for loop instead of the folio variant for backportable.
> 
>  mm/migrate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c9296d63878d..c418e8d92b9c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage, struct page *page,
>  		if (!PageMappingFlags(page))
>  			page->mapping = NULL;
>  
> -		if (likely(!is_zone_device_page(newpage)))
> -			flush_dcache_page(newpage);
> +		if (likely(!is_zone_device_page(newpage))) {
> +			int i, nr = compound_nr(newpage);
>  
> +			for (i = 0; i < nr; i++)
> +				flush_dcache_page(newpage + i);
> +		}
>  	}
>  out:
>  	return rc;
> -- 
> 2.11.0
> 
> 
> 
