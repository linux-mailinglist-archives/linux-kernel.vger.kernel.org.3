Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662FC4D3C70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiCIV4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiCIV4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:56:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39911C7F7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:55:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so3506155pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fPg1ReAlI/OxffQjTQJbSAN97su7fVq3uGIZ7B9a6Y=;
        b=dfcw9olikZDzL0RqPH+JgDmeVPHx6RrEQgbK9G8tLLiJYTYE85J0XqT81GfAmLNWFl
         b9/bZ/TcOIfxVYS8OfhwgIOMAsiPjoWXhMrmIpZP72BFomKtuYs+x9l0dW6Kx5UJSNCz
         JQ5kvdiOEx/TBkgfi4X3qkrC08wFIEK+9wCR2r0/Db2rvYLO77FTE2WfcQ+v3svao1TL
         o1a8cBeHW82aobG4iLL25DXnLf2yl1vZ8GFkqCFz4JHYnPrlQCYqa5/y5WbmgOyVUfdv
         MiPwfKOOmtv9gHLAz6hoqJl3Awx2cWS/21hU9TXW/eu4K6QgXKnJGTxHBrNHJjwcdd11
         YF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fPg1ReAlI/OxffQjTQJbSAN97su7fVq3uGIZ7B9a6Y=;
        b=hLkfrGLA2/i5dgobU0ncH2RQ/U0i9ifFVnC5ZK5EVYZm3F+vVBipd+yJNhW8U8Buo4
         E2wMK57e9lJd0gT8JcgMYdVtXvjtSNUVMCfCQgPAfAKjI8/yMWltIKosoPCGXZ8+T1ed
         OQWgz5HEtmNBSCxgdR8+0WeGFsA3K34N0atQgc84RdNSIOpTg5qGCYheIlUwzC7tn11y
         Mhqjmo2sv6PX7jiRFIjXznahXv9Pu+SytmA5EvxHCZWWlBtvgO1STHNNuWIWuZyZ3PzI
         yXi8gWSM/9H4srae78PuxnEyk7cVap/3GDQE4XEpqeJzaik4EED5r2vRGllskM/JpWee
         waJw==
X-Gm-Message-State: AOAM532bnx4cyTtAwjLZ7WFtPwh6a70Z5Se+RrJz9uNQ2iVfi/xYDVlW
        63MGm4SdsoZicL5l4FR/dWfioA7giMiEmz21kUc=
X-Google-Smtp-Source: ABdhPJw/uu83dqkESnkZ3J+RbKaZtxKKPVYcVYk7dSEOud/wim9hdUDZdD6zA1MdcVglmVbO0KXqa4XIAcnxXqcCSJ0=
X-Received: by 2002:a17:90a:7181:b0:1bf:a024:ab61 with SMTP id
 i1-20020a17090a718100b001bfa024ab61mr1637893pjk.200.1646862942135; Wed, 09
 Mar 2022 13:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
In-Reply-To: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Mar 2022 13:55:30 -0800
Message-ID: <CAHbLzkrmHS+nPbw1YZj-rE-ECgRr2nD40d-ZbxPvf05o-rmNcA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 1:15 AM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> There is a race condition between memory_failure_hugetlb() and hugetlb
> free/demotion, which causes setting PageHWPoison flag on the wrong page
> (which was a hugetlb when memory_failrue() was called, but was removed
> or demoted when memory_failure_hugetlb() is called).  This results in
> killing wrong processes.  So set PageHWPoison flag with holding page lock,
>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ac6492e36978..fe25eee8f9d6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1494,24 +1494,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>         int res;
>         unsigned long page_flags;
>
> -       if (TestSetPageHWPoison(head)) {
> -               pr_err("Memory failure: %#lx: already hardware poisoned\n",
> -                      pfn);
> -               res = -EHWPOISON;
> -               if (flags & MF_ACTION_REQUIRED)
> -                       res = kill_accessing_process(current, page_to_pfn(head), flags);
> -               return res;
> -       }
> -
> -       num_poisoned_pages_inc();
> -
>         if (!(flags & MF_COUNT_INCREASED)) {
>                 res = get_hwpoison_page(p, flags);

I'm not an expert of hugetlb, I may be wrong. I'm wondering how this
could solve the race? Is the below race still possible?

__get_hwpoison_page()
  head = compound_head(page)

hugetlb demotion (1G --> 2M)
  get_hwpoison_huge_page(head, &hugetlb);


Then the head may point to a 2M page, but the hwpoisoned subpage is
not in that 2M range?


>                 if (!res) {
>                         lock_page(head);
>                         if (hwpoison_filter(p)) {
> -                               if (TestClearPageHWPoison(head))
> -                                       num_poisoned_pages_dec();
>                                 unlock_page(head);
>                                 return -EOPNOTSUPP;
>                         }
> @@ -1544,13 +1531,16 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>         page_flags = head->flags;
>
>         if (hwpoison_filter(p)) {
> -               if (TestClearPageHWPoison(head))
> -                       num_poisoned_pages_dec();
>                 put_page(p);
>                 res = -EOPNOTSUPP;
>                 goto out;
>         }
>
> +       if (TestSetPageHWPoison(head))

And I don't think "head" is still the head you expected if the race
happened. I think we need to re-retrieve the head once the page
refcount is bumped and locked.

> +               goto already_hwpoisoned;
> +
> +       num_poisoned_pages_inc();
> +
>         /*
>          * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>          * simply disable it. In order to make it work properly, we need
> @@ -1576,6 +1566,13 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  out:
>         unlock_page(head);
>         return res;
> +already_hwpoisoned:
> +       unlock_page(head);
> +       pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
> +       res = -EHWPOISON;
> +       if (flags & MF_ACTION_REQUIRED)
> +               res = kill_accessing_process(current, page_to_pfn(head), flags);
> +       return res;
>  }
>
>  static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> --
> 2.25.1
>
