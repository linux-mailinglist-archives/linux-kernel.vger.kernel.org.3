Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7907E495427
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbiATS0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbiATS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:26:04 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5807C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:26:03 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id r3so5279493iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VM3tBp/CA+4wTCBfmyWMTm1eADRMbsKEHQheO5QR1dg=;
        b=kjWd/gluHnZp28leoLrw9gVa9JtC0gx9dMDDSiGyx17HhEXqLHPyCYCzdGIexOoC8W
         4G7du2uwS/k0/bIytNp0rc0EgcgQAZOWNTcelWkw1KWz8v25VxHJv8bBaEu+xev52pr0
         yDCNIMUZtZFYIhSqsr8nRFoqnYiBUWRDmCSYVDp42bEEPcVGUv98j6uMJhzrhqkjmY1A
         0sUNXlpXKp9uDnK24r1+W+twtCQJHhJ0fpOGJ6Aml6R0tKZ3uJu/b/xwW1bfHrjxIUWK
         dUTOLmDhjr/FzvCK5yRQJJEgKC7rlQODvqDIN9S3XcNzqprC79Wf9xJ3mvKxxxX7Fk/p
         +KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VM3tBp/CA+4wTCBfmyWMTm1eADRMbsKEHQheO5QR1dg=;
        b=MPzDtnim++uRpeT2jVuwPf3dpaJUDLqZvml1WEZyykvh5Y1kAJUhUR8eiQe0my6QGI
         lShpb721KLgrbU0H+lcAUyyTadNUpvE0Z+MbQahkRIN2GoykDHajdv303QKf+A2sjHzj
         r9lFsxFUxzvimqx75sfTVOZNs/TuCbO0nqFbdiHNFPlBIg+5oNSLDtn0+2QieZ/9K3GK
         YrYKrcyqHDX2Zhv9XdvzwcynJv8Uf78tC6MO069nT9UQOcjz0SjBW9ZcTkOOghP+Z4EA
         xSb+pYFcE+ejyfrXOMzaUR8hBZDCnDBcmFP7RPN1K35hK4kzpLcWGJw/hz3N/uU8gFW2
         dujg==
X-Gm-Message-State: AOAM531A9lfub5Xmj9usRE9yDH2HiPcxbIN1+iXYdGUfpPWzlvfDXCCA
        Hx0FnVk2kyukXdXqkYQowWfSGE5n1zmRcDBf8U42ew==
X-Google-Smtp-Source: ABdhPJyQ3HkdPr2dC0EIXetDOosxZkhDjZaOvxxWcA/Q1gWYGTNgeHnozQdeSnPQOpPK5nbkCvbWVSiPRWzUg5y1bYI=
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr135351ilv.300.1642703163043;
 Thu, 20 Jan 2022 10:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20220120042513.1648831-1-pasha.tatashin@soleen.com> <20220120042513.1648831-4-pasha.tatashin@soleen.com>
In-Reply-To: <20220120042513.1648831-4-pasha.tatashin@soleen.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 20 Jan 2022 10:25:52 -0800
Message-ID: <CAAPL-u8g3Yuh2Z6rb8ct=mVvNtJe6bHZEiPU2hdoCJKd93H-5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/page_table_check: use unsigned long for page counters
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Greg Thelen <gthelen@google.com>,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com,
        Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 8:25 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> For the consistency, use "unsigned long" for all page counters.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/page_table_check.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 2341ac382cd5..22dd285ab8d5 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -86,8 +86,8 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
>  {
>         struct page_ext *page_ext;
>         struct page *page;
> +       unsigned long i;
>         bool anon;
> -       int i;
>
>         if (!pfn_valid(pfn))
>                 return;
> @@ -121,8 +121,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
>  {
>         struct page_ext *page_ext;
>         struct page *page;
> +       unsigned long i;
>         bool anon;
> -       int i;
>
>         if (!pfn_valid(pfn))
>                 return;
> @@ -186,10 +186,10 @@ static void pmd_clear_level(struct mm_struct *mm, unsigned long addr,
>  void __page_table_check_zero(struct page *page, unsigned int order)
>  {
>         struct page_ext *page_ext = lookup_page_ext(page);
> -       int i;
> +       unsigned long i;
>
>         BUG_ON(!page_ext);
> -       for (i = 0; i < (1 << order); i++) {
> +       for (i = 0; i < (1ul << order); i++) {
>                 struct page_table_check *ptc = get_page_table_check(page_ext);
>
>                 BUG_ON(atomic_read(&ptc->anon_map_count));
> --
> 2.34.1.703.g22d0c6ccf7-goog
>

Reviewed-by: Wei Xu <weixugc@google.com>
