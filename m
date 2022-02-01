Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8884A63CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiBAS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiBAS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:29:18 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E46C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:29:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id s13so57060999ejy.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP4EyjDtTGrvqxHN8nh2Bmr+7fmCKpgGCdhP+Ipwfsg=;
        b=FUjdGPY4Ibsu65A439Yis7dUvvuwYlClwb5wZgWyq39fVGm/NmY1aPpgO/gFbvwBjR
         1SFwi3Kh13NLNUZKTfd3KlVnDAAbb+VMn1fIw5nbQL0jFvl8qZdPwKkR+vLPo/GBliMI
         +8RU0Tw01+QIBdtCAoM2jdCX8Uih78tme0h+5Pk5xBoDUG//1mTksXqtf0Qgq1eva+87
         IKAU6Ud5m8r2oQR+RH+vxmUGc1DIJVdBc7onXmqD3hl9PKAVC4Lkixj+wDwpUHPcIzpd
         yId0zwrAnRHZgUgrXjVOSx6ehJmR2V9mQ83A5hQB+KOARf33cNzMKUb+7pzpT641uXD8
         JYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP4EyjDtTGrvqxHN8nh2Bmr+7fmCKpgGCdhP+Ipwfsg=;
        b=B0LQlZVGSPlUNAkulzgDz54prSpZpcFuFfZ/7yUjxKi/uOVSl+1lFzZHlPlvrsEPTn
         o6JcYBgLLiKHqWO4GY5JfDvrVC68yeavk5IZ8b+SfoUECH7DFfBawWq7CDh9m1Wu4N0u
         /dNj3vWgm5t7yAjYYPpwae7o/PDlsQxDXaWKeLd/vkS+Dgq9tyjiFVNECDmgBsIcwDfQ
         05iL2I6N4NrzWBqySmLj9RzPO8isHu450+vsi0JjWuWCGRfivVqVuN04eJem3qHowb9O
         UX2BsJ/owz9TsD2RZ6EWFD/GWQI0tsQqY+X3cyxcbVzt/M/NNf12iiLOJRo9IfptsW0o
         Rb5Q==
X-Gm-Message-State: AOAM5309PwlvJMJ0T+KRZn/l6NAjU/hYKCYCEo+wRB7iI+ev6nNhj0Q+
        2nwld6jyXh0u0SVTEkJnpyfdmxzyYsnHTUgEQzo=
X-Google-Smtp-Source: ABdhPJxU/84XvZQ2ewaxgmwpeK/Cyc1itnMi82MZRRgGbpt/sYzB0aTy3ZLCYM8RlPaQ/yY/vhM7B7mLw/FQ0/BRIKQ=
X-Received: by 2002:a17:906:30c9:: with SMTP id b9mr22577198ejb.377.1643740157151;
 Tue, 01 Feb 2022 10:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20220130013042.1906881-1-willy@infradead.org>
In-Reply-To: <20220130013042.1906881-1-willy@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Feb 2022 10:29:05 -0800
Message-ID: <CAHbLzkrMNo4f=ATeHV=yADjW1yCbmE6jCAC=puhG-=_5j0jymg@mail.gmail.com>
Subject: Re: [PATCH] mm/hwpoison: Check the subpage, not the head page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 5:30 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Hardware poison is tracked on a per-page basis, not on the head page.

Looks correct to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

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
>                 /* Update high watermark before we lower rss */
>                 update_hiwater_rss(mm);
>
> -               if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
> +               if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
>                         pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>                         if (PageHuge(page)) {
>                                 hugetlb_count_sub(compound_nr(page), mm);
> @@ -1873,7 +1873,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>                          * memory are supported.
>                          */
>                         subpage = page;
> -               } else if (PageHWPoison(page)) {
> +               } else if (PageHWPoison(subpage)) {
>                         pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>                         if (PageHuge(page)) {
>                                 hugetlb_count_sub(compound_nr(page), mm);
> --
> 2.34.1
>
>
