Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF495A9999
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiIAOBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:01:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF512A8F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:01:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z187so17535908pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YDOhtt6J+ZY/qg8xzbLdvC6nQ5IzedlQjVCL0rUnymA=;
        b=ZF3KJ3dJjxVQXTdvX7s5aMb1MKcjiyoCnPrYPQcReHISIExI4Skt+47KA5MoNm4ueM
         VOveaVDCLb8YjKi09ZcPKXoVrvsoVeCQxEpwP7875v5xmaAxf5egcyh9SWEbbbjl7u5j
         OPhXCGtSl+ZTh9i5mYR9k3cHqJg6tMVt2TqKfLeVKGCzfMYgOxBdGQbWrxJ2GSFY9klx
         MgEtFDakufk+aTo65k2+/wGWkv1FLVHqm/qgDkfdb9Xt0KRTTsUcvsdiDm+SbFou0vr8
         WNCf5HZAfCQE6eebVZgPFOaQRGRkNZc+Qc5EbzqbK8g/T9Z1e4pT9bNj/0Nh5yUjVqog
         17ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YDOhtt6J+ZY/qg8xzbLdvC6nQ5IzedlQjVCL0rUnymA=;
        b=C2e/CdlYUgEl4eP/4yx5Lwgb2bMfARnfg5GUrMzlushTzVZ/izzkmoN5BAAaVZOszI
         mhqcGxWvLLcM0weodSIeCP4buBf0QhleC2ZUouvWhnM7ZRkqLR72mth4byQw4U2w55I1
         VQVhQecSRjtMeamDCOMGVIVyuqsz5EzPJS7m74O5j0+1GRJS7Ws5wUZsDjztfA3crQ//
         V62cXTF8NFZNVD9F7XiLhtTADSN0Ch92e6/armTfjD7Pf7f0o1Pk8bbzqBzhsikNpX94
         B2Xe9IWcOC93e96Kgbgbitg5dshai3UtZ/upynSMsqD+mtZ2X8T7Te6keIz0I0caCOyY
         2WdQ==
X-Gm-Message-State: ACgBeo3PYgAzBcG0/BdWPte5FT8FWJE766QCQbLfI+3kjdZjqknuB17L
        xwiYiJZ6ZqTUgzQAO0hDr/tz7fYvPIQ=
X-Google-Smtp-Source: AA6agR5QYUk1/ouGe9PG+TcT6iWHvUWeDxUjLXZmVJCjFtZySONTbveX8s3S00IDBKelQ5H+oDD3jg==
X-Received: by 2002:a62:a512:0:b0:536:e2bd:e15e with SMTP id v18-20020a62a512000000b00536e2bde15emr32087656pfm.1.1662040881472;
        Thu, 01 Sep 2022 07:01:21 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090340c700b0017312bfca95sm13629110pld.253.2022.09.01.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:01:20 -0700 (PDT)
Date:   Thu, 1 Sep 2022 23:01:13 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxC7Kda5g/aEqarm@hyeyoo>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829075618.69069-2-feng.tang@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 03:56:15PM +0800, Feng Tang wrote:
> kmalloc's API family is critical for mm, with one nature that it will
> round up the request size to a fixed one (mostly power of 2). Say
> when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> could be allocated, so in worst case, there is around 50% memory
> space waste.
> 
> The wastage is not a big issue for requests that get allocated/freed
> quickly, but may cause problems with objects that have longer life
> time.
> 
> We've met a kernel boot OOM panic (v5.10), and from the dumped slab
> info:
> 
>     [   26.062145] kmalloc-2k            814056KB     814056KB
> 
> From debug we found there are huge number of 'struct iova_magazine',
> whose size is 1032 bytes (1024 + 8), so each allocation will waste
> 1016 bytes. Though the issue was solved by giving the right (bigger)
> size of RAM, it is still nice to optimize the size (either use a
> kmalloc friendly size or create a dedicated slab for it).
> 
> And from lkml archive, there was another crash kernel OOM case [1]
> back in 2019, which seems to be related with the similar slab waste
> situation, as the log is similar:
> 
>     [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
>     [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
>     ...
>     [    4.857565] kmalloc-2048           59164KB      59164KB
> 
> The crash kernel only has 256M memory, and 59M is pretty big here.
> (Note: the related code has been changed and optimised in recent
> kernel [2], these logs are just picked to demo the problem, also
> a patch changing its size to 1024 bytes has been merged)
> 
> So add an way to track each kmalloc's memory waste info, and
> leverage the existing SLUB debug framework (specifically
> SLUB_STORE_USER) to show its call stack of original allocation,
> so that user can evaluate the waste situation, identify some hot
> spots and optimize accordingly, for a better utilization of memory.
> 
> The waste info is integrated into existing interface:
> '/sys/kernel/debug/slab/kmalloc-xx/alloc_traces', one example of
> 'kmalloc-4k' after boot is:
> 
> 126 ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe] waste=233856/1856 age=1493302/1493830/1494358 pid=1284 cpus=32 nodes=1
>         __slab_alloc.isra.86+0x52/0x80
>         __kmalloc_node+0x143/0x350
>         ixgbe_alloc_q_vector+0xa5/0x4a0 [ixgbe]
>         ixgbe_init_interrupt_scheme+0x1a6/0x730 [ixgbe]
>         ixgbe_probe+0xc8e/0x10d0 [ixgbe]
>         local_pci_probe+0x42/0x80
>         work_for_cpu_fn+0x13/0x20
>         process_one_work+0x1c5/0x390
> 
> which means in 'kmalloc-4k' slab, there are 126 requests of
> 2240 bytes which got a 4KB space (wasting 1856 bytes each
> and 233856 bytes in total). And when system starts some real
> workload like multiple docker instances, there are more
> severe waste.
> 
> [1]. https://lkml.org/lkml/2019/8/12/266
> [2]. https://lore.kernel.org/lkml/2920df89-9975-5785-f79b-257d3052dfaf@huawei.com/
> 
> [Thanks Hyeonggon for pointing out several bugs about sorting/format]
> [Thanks Vlastimil for suggesting way to reduce memory usage of
>  orig_size and keep it only for kmalloc objects]
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/linux/slab.h |  2 +
>  mm/slub.c            | 94 +++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 81 insertions(+), 15 deletions(-)


Would you update Documentation/mm/slub.rst as well?
(alloc_traces part)

[...]

>   */
>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -			  unsigned long addr, struct kmem_cache_cpu *c)
> +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
>  {
>  	void *freelist;
>  	struct slab *slab;
> @@ -3115,6 +3158,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  		if (s->flags & SLAB_STORE_USER)
>  			set_track(s, freelist, TRACK_ALLOC, addr);
> +		set_orig_size(s, freelist, orig_size);
>  
>  		return freelist;
>  	}
> @@ -3140,6 +3184,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 */
>  		if (s->flags & SLAB_STORE_USER)
>  			set_track(s, freelist, TRACK_ALLOC, addr);
> +		set_orig_size(s, freelist, orig_size);
> +
>  		return freelist;
>  	}


This patch is okay but with patch 4, init_object() initializes redzone/poison area
using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
Why not do it in init_object() in the first time?

Also, updating redzone/poison area after alloc_single_from_new_slab()
(outside list_lock, after adding slab to list) will introduce races with validation.

So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.

I can miss something, please kindly let me know if I did ;)

Anything else looks good to me.
Thanks!

-- 
Thanks,
Hyeonggon
