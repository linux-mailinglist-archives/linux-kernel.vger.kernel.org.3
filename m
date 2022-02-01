Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746824A66BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiBAVAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiBAVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:00:48 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E09C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:00:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id j24so14035017qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zh2HRwuNKx7PT7oWtqov40bxLvcOISQVIPi4Cb5Lh+c=;
        b=tnSgEux4dZPsnVaqxHway29AhA57bv5PLRRygiXqKVibwwdjETk6IvbnE3QMijL9y5
         shQga544etO5GTxQGwwQFliOrXPSARwDVLa3wEwR8Q46QKUO/wCRuprHOA9d+5ISACFz
         RmlugelKIMuCQEQjKWD2vI8qrOM02DxA4KlvEv+kbn/dpycAbP1Vm9HkHgF6RoOh0rWk
         J73VzG03L2JPTw+oW13GzI+9DpYqkOiCEN5hVWzITf+vY8Rv6Gx8vdWH2E99qFR96xoW
         dmn7PjPuHmLU/AibAkA+jJ6GcRj1IfphoPcpedD1QcBc0gHE4MgIrvf03CkfPFv9e6ZM
         uMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zh2HRwuNKx7PT7oWtqov40bxLvcOISQVIPi4Cb5Lh+c=;
        b=jPT1aN9CRzzC7jvAIIKrLvyzhvFnyzLePWNf1dQYFcGjQHxgpTqP2jZnDOve7OVhE2
         XlXEgeil0rlUYigkm06ore5ZrZKQ88Vv3V2lRA+szAhsPF0V4QnT9NQ4WQmUrdLjgBF8
         wVkkC+VtUBkvJCcB7fldtUUvIiaAKzX3tifzQCA3Mtk2Atucyu55Awo2Xtst3kLHsLFg
         Oe9mD7FhThRhe6wlT+xRNPqGKGnZ1P9bzSYmwcvgvCWybgWmnEB1WLLmrCkORlgENKdw
         COanWMMh3al2blcKTAkVY/ZhRifyPqaZ365e6lRF4X1lzXlNHb9+I8nwLhWBAiKyMhZp
         +CaA==
X-Gm-Message-State: AOAM530EQTp8I9k6uMSGa9PR8CK3P1JXLn1iEuaEl6iaqlXvaTXAhjgz
        8fnV7FOU+hlJLFAgLQUxP2RwqplL5+L3cg==
X-Google-Smtp-Source: ABdhPJyEBFUvfWptUDHA9K+9o0hQjKPVc1wTo5h0vSVMJNGBl7AeDmnGhrh9plQ4kEkKXifPZmZelA==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr18143036qkk.417.1643749247140;
        Tue, 01 Feb 2022 13:00:47 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id q8sm11532990qkl.65.2022.02.01.13.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:00:46 -0800 (PST)
Date:   Tue, 1 Feb 2022 16:00:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memcg: add per-memcg total kernel memory stat
Message-ID: <YfmffkUfDGg4g+xt@cmpxchg.org>
References: <20220201200823.3283171-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201200823.3283171-1-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yosry,

On Tue, Feb 01, 2022 at 08:08:23PM +0000, Yosry Ahmed wrote:
> Currently memcg stats show several types of kernel memory:
> kernel stack, page tables, sock, vmalloc, and slab.
> However, there are other allocations with __GFP_ACCOUNT
> (or supersets such as GFP_KERNEL_ACCOUNT) that are not accounted
> in any of those stats, a few examples are:
> - various kvm allocations (e.g. allocated pages to create vcpus)
> - io_uring
> - tmp_page in pipes during pipe_write()
> - bpf ringbuffers
> - unix sockets
> 
> Keeping track of the total kernel memory is essential for the ease of
> migration from cgroup v1 to v2 as there are large discrepancies between
> v1's kmem.usage_in_bytes and the sum of the available kernel memory stats
> in v2. Adding separate memcg stats for all __GFP_ACCOUNT kernel
> allocations is an impractical maintenance burden as there a lot of those
> all over the kernel code, with more use cases likely to show up in the
> future.

No objection, I'm just curious how it makes migration to v2 easier in
particular. Or is it just that you've used the v1 stat to track
application regressions and would like to continue doing that in v2?

> Therefore, add a "kernel" memcg stat that is analogous to kmem
> page counter, with added benefits such as using rstat infrastructure
> which aggregates stats more efficiently. Additionally, this provides a
> lighter alternative in case the legacy kmem is deprecated in the future
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  5 +++++
>  include/linux/memcontrol.h              |  1 +
>  mm/memcontrol.c                         | 24 ++++++++++++++++++------
>  3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5aa368d165da..a0027d570a7f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1317,6 +1317,11 @@ PAGE_SIZE multiple when read back.
>  	  vmalloc (npn)
>  		Amount of memory used for vmap backed memory.
>  
> +	  kernel (npn)
> +		Amount of total kernel memory, including
> +		(kernel_stack, pagetables, percpu, vmalloc, slab) in
> +		addition to other kernel memory use cases.
> +
>  	  shmem
>  		Amount of cached filesystem data that is swap-backed,
>  		such as tmpfs, shm segments, shared anonymous mmap()s
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b72d75141e12..fa51986365a4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -34,6 +34,7 @@ enum memcg_stat_item {
>  	MEMCG_SOCK,
>  	MEMCG_PERCPU_B,
>  	MEMCG_VMALLOC,
> +	MEMCG_KMEM,
>  	MEMCG_NR_STAT,
>  };
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 09d342c7cbd0..c55d7056ac98 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1376,6 +1376,7 @@ static const struct memory_stat memory_stats[] = {
>  	{ "percpu",			MEMCG_PERCPU_B			},
>  	{ "sock",			MEMCG_SOCK			},
>  	{ "vmalloc",			MEMCG_VMALLOC			},
> +	{ "kernel",			MEMCG_KMEM			},

It's a superset of percpu, sock, vmalloc etc., so please move it ahead
of them.

	anon
	file
	kernel
	kernel_stack
	pagetables
	...

and in the doc as well.

>  	{ "shmem",			NR_SHMEM			},
>  	{ "file_mapped",		NR_FILE_MAPPED			},
>  	{ "file_dirty",			NR_FILE_DIRTY			},
> @@ -2979,6 +2980,19 @@ static void memcg_free_cache_id(int id)
>  	ida_simple_remove(&memcg_cache_ida, id);
>  }
>  
> +static void mem_cgroup_kmem_record(struct mem_cgroup *memcg,
> +				   int nr_pages)

No real need for the namespace prefix since it's a static
function. How about account_kmem()? Avoids the line wrap, too.

Otherwise, looks good to me, so with those changes:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
