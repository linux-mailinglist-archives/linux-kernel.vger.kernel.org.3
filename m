Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37F74D9C46
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348711AbiCONcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348694AbiCONc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:32:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D7527FA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:31:17 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2dbd8777564so202119527b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtmsmQ/2gw1Y/pirhEjotykkKVj7SlHkh+ESAiuT6AQ=;
        b=iS+6HlPy0XVq/lxHBqvNeCdXtO/YQeIIOogSh7EkTGKqgE4SZ7DW9s0k2ehFjIC/G7
         dYht0cLbK/1YmZhCYwBXxR84bcMJH2FtxUwHFGq6q3KQv3nfNjIiglPXH3Q/qHpR3DYN
         KrgRAwgBIbeJDXK/e9NljAehsKpHrq72xxZafuD043QmlhWRs+A1THQX0yh50vjddRSB
         EnjOlXcpn8ypQVskckivErvkMA8VZtI7/JOzfsxCX38IoY2mb/1qPGr5VXAapzUoP4vW
         9LvK1lY3eZutiXhO3d+eQo5/8zLnny9+96ZQxObs2uAp7RV9IVatYWpPflLypxvISnLv
         5Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtmsmQ/2gw1Y/pirhEjotykkKVj7SlHkh+ESAiuT6AQ=;
        b=1n25ZvI9fDvBrdEjRVbc2Lu5X2CELP5o3q6vK4qbyjdL9iusWsoeGOo3AnGTRPtW9B
         hxjMZFfmH0IrvFEHjjuEpN7Qgu4TKluR/cglGpymemGVIUKEVlqMLxK52sd74tSJGjK9
         6fVkdilleHKUtvpX2sSX6ypE+j8cgpCDD2QhUvQPYAsYNXYX2Z1cIRunIzVL+T6oKcpe
         YeW6qGfaNFAO212LgkKclBz9JFM3pTpm63JllPxUn98SXZghJCFUlNcYaW/qgJzzd8s9
         t7Y98Nc9fjMSnNGF+g8P9feiK7liFfZ6200YQf/5NbuwaYYbqqxRWwmf4/ytDiAsGi5d
         Zo+w==
X-Gm-Message-State: AOAM531D7/HcYJ/EADFPIAQqVE1zMOJ94Wo72lGUoxLhfHKIVw4u4jHU
        hRHhYEYJDns/ftttvzdTU4MGxsH6EV8ANn4U8T5OImMDgFjf7Q==
X-Google-Smtp-Source: ABdhPJx3VldPxFAeybLShowpLLsYaEK8Fd0JU4RVR5/Jh2rjAXJprvQ6wb29fZHBTFX9bjLmeAdtEZPNX6J+pcdsQOk=
X-Received: by 2002:a0d:e609:0:b0:2d6:b8b0:8608 with SMTP id
 p9-20020a0de609000000b002d6b8b08608mr23824993ywe.31.1647351076662; Tue, 15
 Mar 2022 06:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220315042355.362810-1-luofei@unicloud.com>
In-Reply-To: <20220315042355.362810-1-luofei@unicloud.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 15 Mar 2022 21:29:27 +0800
Message-ID: <CAMZfGtWjnhZLVmRD0BSpMbAWr_vD5BCj5s0ARfNHpHeAAGWYjA@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: fix description about atomic allocation of
 vmemmap pages when free huge page
To:     luofei <luofei@unicloud.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:24 PM luofei <luofei@unicloud.com> wrote:
>
> No matter what context update_and_free_page() is called in,
> the flag for allocating the vmemmap page is fixed
> (GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE), and no atomic
> allocation is involved, so the description of atomicity here
> is somewhat inappropriate.
>
> and the atomic parameter naming of update_and_free_page() is
> somewhat misleading.
>
> Signed-off-by: luofei <luofei@unicloud.com>
> ---
>  mm/hugetlb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f8ca7cca3c1a..239ef82b7897 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1570,8 +1570,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>
>  /*
>   * As update_and_free_page() can be called under any context, so we cannot
> - * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
> - * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
> + * use GFP_ATOMIC to allocate vmemmap pages. However, we can defer the
> + * actual freeing in a workqueue to prevent waits caused by allocating
>   * the vmemmap pages.
>   *
>   * free_hpage_workfn() locklessly retrieves the linked list of pages to be
> @@ -1617,16 +1617,14 @@ static inline void flush_free_hpage_work(struct hstate *h)
>  }
>
>  static void update_and_free_page(struct hstate *h, struct page *page,
> -                                bool atomic)
> +                                bool delay)

Hi luofei,

At least, I don't agree with this change.  The "atomic" means if the
caller is under atomic context instead of whether using atomic
GFP_MASK.  The "delay" seems to tell the caller that it can undelay
the allocation even if it is under atomic context (actually, it has no
choice).  But "atomic" can indicate the user is being asked to tell us
if it is under atomic context.

Thanks.
