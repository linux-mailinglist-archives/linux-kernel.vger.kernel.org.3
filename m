Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215C147CBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbhLVEPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242205AbhLVEPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:15:46 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB19C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 20:15:45 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e136so2677463ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 20:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oT+RbBLIKBM3vSkjIiPDbKf1O19T4rONwiomV1ipgfI=;
        b=QwKty6KWq5QMJhxZgV567EepaUUUIwOFMs5BeJbBS0f5BckTQ5+BTONi3lkFwADjkG
         zBGepaxWiNFeFzsK/dhoTvQmhmD0A7KpKQTS8GR7vkXVddxkLAV4l5SNA7I6sW2UKdD3
         4Xlir1PTb2U1VbwXkMBOBZrVmHnGDtLYgr0z2Q0wtLCfZUHzCtr4QZSayNKSaozRxQSM
         RquTb1SyUXkYIba4zpVA83yfbtKUkeEOiNbka8Y3pTTUlntE+ZHGH/QXIk8M0f/+8HhC
         C17peu3BWACBAwClIjy4VyE+4mhMk83kC9TX7pYzyRTsyTHnCsId2XMGhcuK0QDfpv/B
         wi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oT+RbBLIKBM3vSkjIiPDbKf1O19T4rONwiomV1ipgfI=;
        b=79yMUT7wOKVnSZrKekAHk8Wc91UZpp/BpNVfTaRJg2u9MWpJ8v1XE3icM8JZ16S8FU
         1cs0WtO9FHOWF9M5fodDRu4087t208cx76Bu9dpcmeogKB7iAcHULkM35JXwDicdMQzQ
         LEHEr0iO1H2R9OKBOsrtTfKN3Bu9yeK1979zMLad4UpeX/MvAymOApTHUbUGvhcBeszx
         oMIfSU4jXqi4JhIMAJJDnN3n+IAK8LABi8/UH5fUZ3Cb1cSsP/ZpjzcBB34i84NP/QKe
         jeZxuXeKQS2OgP/qLi7QV2hEajIrK4ztVdEr3TupD+r+SkLELXP+8DD9mIe7Y1aMzXVg
         absw==
X-Gm-Message-State: AOAM5309KFwRnHcZB5wkY/CntDpYLY2n9IlTvXmMv9JyWxKFbxhPPpSy
        ZaDoOAj2MidMZVL38oJ4B6qL0jsxUYzsbd8ZiHcC6w==
X-Google-Smtp-Source: ABdhPJxEreUxQzxG3beGM0FkO7SavVLYSkzAZUjm7CNoqM8DtvTGGhIPrrESNts0JTPFLbe8/IGM3roquR08dZOBYQw=
X-Received: by 2002:a25:e541:: with SMTP id c62mr1910542ybh.199.1640146544767;
 Tue, 21 Dec 2021 20:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20211221215336.1922823-1-shakeelb@google.com>
In-Reply-To: <20211221215336.1922823-1-shakeelb@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 22 Dec 2021 12:15:06 +0800
Message-ID: <CAMZfGtVddf8Zqk2rvbb4VXpsOB-hXxeXfkjT3GVQJGc2W_qyGg@mail.gmail.com>
Subject: Re: [PATCH] memcg: add per-memcg vmalloc stat
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 5:53 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> The kvmalloc* allocation functions can fallback to vmalloc allocations
> and more often on long running machines. In addition the kernel does
> have __GFP_ACCOUNT kvmalloc* calls. So, often on long running machines,
> the memory.stat does not tell the complete picture which type of memory
> is charged to the memcg. So add a per-memcg vmalloc stat.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  3 +++
>  include/linux/memcontrol.h              | 15 +++++++++++++++
>  mm/memcontrol.c                         |  1 +
>  mm/vmalloc.c                            |  5 +++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 82c8dc91b2be..5aa368d165da 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1314,6 +1314,9 @@ PAGE_SIZE multiple when read back.
>           sock (npn)
>                 Amount of memory used in network transmission buffers
>
> +         vmalloc (npn)
> +               Amount of memory used for vmap backed memory.
> +
>           shmem
>                 Amount of cached filesystem data that is swap-backed,
>                 such as tmpfs, shm segments, shared anonymous mmap()s
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d76dad703580..000bfad6ff69 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -33,6 +33,7 @@ enum memcg_stat_item {
>         MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
>         MEMCG_SOCK,
>         MEMCG_PERCPU_B,
> +       MEMCG_VMALLOC,
>         MEMCG_NR_STAT,
>  };
>
> @@ -944,6 +945,15 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>         local_irq_restore(flags);
>  }
>
> +static inline void mod_memcg_page_state(struct page *page,
> +                                       int idx, int val)
> +{
> +       struct mem_cgroup *memcg = page_memcg(page);
> +
> +       if (!mem_cgroup_disabled() && memcg)
> +               mod_memcg_state(memcg, idx, val);

It's not safe to access @memcg throughout mod_memcg_state() for the
kmem charged through objcg infrastructure. It's supposed to be safe
to access @memcg under rcu read lock. Otherwise, it looks good to
me.

Thanks.
