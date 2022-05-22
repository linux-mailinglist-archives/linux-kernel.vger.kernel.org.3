Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D28453010B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 07:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiEVFT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 01:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiEVFTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 01:19:25 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21BE403E1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:19:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i74so5715694ioa.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 22:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cowFMMuGvgfdaWA366Gk5O1CrrDkR8s9xOd2QVYAJJE=;
        b=j3FpKS+P0dtEu0+F/fZcVSLU/pzvFjnBBo1ZeVL1E/2ca+bv6K87o1DuFCfqBkbqp1
         PVvZnqp4kA2o6CyuX7SA6ug3tdl8wNSeRN7wxVpBUuGBk6YBzQ5K/3hPlubsQIxXylNe
         cNqxt9aHdWcVulro/uqFDHeAUYXA1gVUipVpaVrf9bMyTfb2byYRQ+fyZXouKnkvC/5P
         6x2Ctu6bJn+sS/ow/sZq5Jbjz19aj0/96K/XtzWO1WyTIFAlTkkeIJmqAP9T7h9sH5I/
         OiD/UvGbwprOWw0oAuatjiMYUv124rpHiYcSbfcHLSix3xeykMDiehxP0Hc3iyNmQVCZ
         k/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cowFMMuGvgfdaWA366Gk5O1CrrDkR8s9xOd2QVYAJJE=;
        b=hBbu7iSdf8QQkNrpN+6jXHcpa8AJJBu24bsguLznwLQe8/lvl7g0/NGyczo9Bs/Smv
         bJlUqW5HGKpTrSedBXktIaq49+Uqo0GdzJ+e0ZZLlgBuoMWVupipn2NNTR6e9m+RkXWJ
         OK/8BOh9VB4ELmfsXCoZut5pqDm+231+izJzt1Ob9D/J0DZgNxUYW9iAfRR/q5wZPxPt
         4AlNNLCd/eJA92kGjvM1Hn+7ClzVar4o9k+VSp1fYxyYxpYnElYWSJnu8BdMQsalp8xv
         d5ivHlZJ8AyKF78/QxG4S6qdAg8NHmsNhUdNI7RTrbvrlPZ0nzZNMC2uVZ5+zte9D6Ul
         xnOA==
X-Gm-Message-State: AOAM531LPw12TbGvdKnjeljlHtibJAZ0rGGaBT17LmdAcItSo2Q8kO5w
        yl/skj9+VYr6I+wHIalNJ8k=
X-Google-Smtp-Source: ABdhPJzFAUOqdDgsxGUTjWy1Gc3GcJIS8lWNi6HN510PDqslrTACyJeAvbPEpjCBwPHxTyFR9F3anQ==
X-Received: by 2002:a05:6638:370b:b0:32e:a6ce:edcf with SMTP id k11-20020a056638370b00b0032ea6ceedcfmr4242646jav.267.1653196763270;
        Sat, 21 May 2022 22:19:23 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id q2-20020a056638040200b0032b5316724dsm1889353jap.22.2022.05.21.22.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 22:19:22 -0700 (PDT)
Date:   Sun, 22 May 2022 05:19:20 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <YonH2AqfEFYKrUV2@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
 <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
 <YomzXwN9rvCGAZJ0@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 07:33:08AM +0300, Vasily Averin wrote:
> On 5/22/22 06:51, Hyeonggon Yoo wrote:
> > On Sat, May 21, 2022 at 09:36:54PM +0300, Vasily Averin wrote:
> >> Slab caches marked with SLAB_ACCOUNT force accounting for every
> >> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> >> Unfortunately, at the moment this flag is not visible in ftrace output,
> >> and this makes it difficult to analyze the accounted allocations.
> >>
> >> This patch adds boolean "accounted" entry into trace output,
> >> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> >> for allocations from caches marked with SLAB_ACCOUNT.
> >>
> >> Signed-off-by: Vasily Averin <vvs@openvz.org>
> >> Acked-by: Shakeel Butt <shakeelb@google.com>
> > 
> > May I ask what information do you want to collect
> > using this patch?
> 
> I analyze ftrace output to understand which allocations are accounted.
> When some userspace operation consume memory, it's important to account
> most part of memory (>2/3 of all) to avoid misuse inside memcg-limited
> contianers. Otherwise memcg-limited container can consume significant 
> portion of host memory, trigger global OOM, wake up OOM-killer and kill
> random processes on host.
> If memory consumers are accounted, it leads to memcg-OOM only. 
> 
> Now kmem tracing output looks like this:
> 
> kmem_cache_alloc:     (getname_flags.part.0+0x2c) call_site=getname_flags.part.0+0x2c ptr=0xffff8fff022e9000 bytes_req=4096 bytes_alloc=4096 gfp_flags=GFP_KERNEL accounted=false
> kmalloc:              (alloc_bprm+0x32) call_site=alloc_bprm+0x32 ptr=0xffff8fff2b408a00 bytes_req=416 bytes_alloc=512 gfp_flags=GFP_KERNEL|__GFP_ZERO accounted=false
> kmem_cache_alloc:     (mm_alloc+0x16) call_site=mm_alloc+0x16 ptr=0xffff8fff0894d500 bytes_req=1048 bytes_alloc=1088 gfp_flags=GFP_KERNEL accounted=true
> mm_page_alloc:        page=0xffffffffa4ab8d42 pfn=0x12ad72 order=1 migratetype=0 gfp_flags=GFP_USER|__GFP_ZERO|__GFP_ACCOUNT
> kmem_cache_alloc:     (vm_area_alloc+0x1a) call_site=vm_area_alloc+0x1a ptr=0xffff8fff2af27000 bytes_req=200 bytes_alloc=200 gfp_flags=GFP_KERNEL accounted=true
> 
> As you can see, without new field it is quite hard to understand, 
> is last allocation accounted.
>
> This analyze helps me to identify most important allocations for given scenario
> and enable accounting for selected allocations.
> 
> An example of this analyze you can found here:
> https://lore.kernel.org/all/d28233ee-bccb-7bc3-c2ec-461fd7f95e6a@openvz.org/
> 

Thank you for detailed explanation. Makes sense to me.

> > If we decide to do that, it would be better to print
> > something like:
> > slab_flags=SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT|SLAB_STORE_USER
> > instead of just printing 'accounted=true/false'. This patch is too
> > specific to SLAB_ACCOUNT.
> 
> Any extra output degrades performance.

No strong opinion but just a concern that maybe later someone want add
something similar like 'reclaimable=true/false', 'dma=true/false', ...
and I would prefer more general solution. (especially if we'll not
change tracepoints after release because of backward compatibility)

> For my task it's not important to know SLAB flags, I just need to understand,
> is current allocation accounted or not.

SLAB_ACCOUNT, SLAB_RECLAIM_ACCOUNT, SLAB_DMA, ... etc are SLAB flags.

'if current allocation is accounted or not' depends on SLAB_ACCOUNT
flag is set or not.

Thanks,
Hyeonggon

> > And if what you want to know is just total slab memory that is accounted,
> > what about adding something like  SlabAccounted in /proc/meminfo?
> 
> It is not enough for me. I need to have per-process allocation information.
> 
> Thank you,
> 	Vasily Averin
