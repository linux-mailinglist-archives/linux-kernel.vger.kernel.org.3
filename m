Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826EB547DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiFMDTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiFMDTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:19:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D001FA52
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:19:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j7so4464371pjn.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=egrU8RsjHIRm43M/aC907vcBMj4PwC5iUGqpoMehifQ=;
        b=U5cVALfpRPrBSMeTCRobBDq50nUnnH+QOaW6MukQugDqXhIx/0UupubDPK1E3y3iNL
         pfp/V+sUHxfXexmZUMwf6HLqx3jqPGRAFpHV3OiH+ICKTw86UPGhqB35hzAgTB4GD3b5
         5w8+cSuC8CRemyHZWtmV3Juvicd/adKr7v0GZr6aYmbl3Eda4guq87yE6n1VdDADSXAy
         CgiP/Fh7AMSBh3KvpsAoae7x7bcifYY6Bw+HJOClmUo8hSUM9v8tpvALWmzI3emZ3T1i
         TtGGg23536uSPr87O14KzOY8iiDpMXEoj53BXLBrUvRqV9lNfHdxskR2POJhlxUZINyh
         3rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egrU8RsjHIRm43M/aC907vcBMj4PwC5iUGqpoMehifQ=;
        b=J706wlo2C6F61z2dAQO/wvjPwEgfb0nlkb8YQYud6JfGSLyr4U+i+FSZgK0AbLqyrM
         sBltIxH5a+BFSq1lts2C8fbHKbsKUqvTmnkNtti2ieay/oWH6PY0DcWO/6HC1qyOci2X
         6MCZ9OTjkYzBmuT487kqtJNDSke2PZ5Hq56fwsSIIGrjHdpqK0/MBJ3Ge9NuDATywHYW
         IdY6Zqwo0IJShUiWtc5L0OUMIE4joMm3FZCIhEA6MnhiS7aR2HtS8suu6HCR644IiSf7
         9ViCGeLvQEvocb0xUkffSAYHm3M7YcaRQNk+eRPORd2ypl1DtZgSfwI0RibtsYnWy3S/
         fH+A==
X-Gm-Message-State: AOAM533lnNg2vbbJDdTicXsXwU9UaObOHxL8JZfKNpEnMVKZ4Vg+Yns1
        fCa1w9My+XNj0MoSY7OvftlV3Q==
X-Google-Smtp-Source: ABdhPJyTo54edL8cKqlW6GL2iq0Dn0gjG6KDpcfbJZgLCfVVENlJn4NULWF5+ZUsh3GANFVnkX4FCA==
X-Received: by 2002:a17:90a:778c:b0:1df:56a5:8474 with SMTP id v12-20020a17090a778c00b001df56a58474mr13414903pjk.63.1655090387796;
        Sun, 12 Jun 2022 20:19:47 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902ed8b00b00163f8ddf160sm3780111plj.161.2022.06.12.20.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 20:19:47 -0700 (PDT)
Date:   Mon, 13 Jun 2022 11:19:44 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: add missing TID updates on slab deactivation
Message-ID: <Yqas0HtsUi72JZzG@FVFYT0MHHV2J.usts.net>
References: <20220608182205.2945720-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608182205.2945720-1-jannh@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 08:22:05PM +0200, Jann Horn wrote:
> The fastpath in slab_alloc_node() assumes that c->slab is stable as long as
> the TID stays the same. However, two places in __slab_alloc() currently
> don't update the TID when deactivating the CPU slab.
> 
> If multiple operations race the right way, this could lead to an object
> getting lost; or, in an even more unlikely situation, it could even lead to
> an object being freed onto the wrong slab's freelist, messing up the
> `inuse` counter and eventually causing a page to be freed to the page
> allocator while it still contains slab objects.
> 
> (I haven't actually tested these cases though, this is just based on
> looking at the code. Writing testcases for this stuff seems like it'd be
> a pain...)
> 
> The race leading to state inconsistency is (all operations on the same CPU
> and kmem_cache):
> 
>  - task A: begin do_slab_free():
>     - read TID
>     - read pcpu freelist (==NULL)
>     - check `slab == c->slab` (true)
>  - [PREEMPT A->B]
>  - task B: begin slab_alloc_node():
>     - fastpath fails (`c->freelist` is NULL)
>     - enter __slab_alloc()
>     - slub_get_cpu_ptr() (disables preemption)
>     - enter ___slab_alloc()
>     - take local_lock_irqsave()
>     - read c->freelist as NULL
>     - get_freelist() returns NULL
>     - write `c->slab = NULL`
>     - drop local_unlock_irqrestore()
>     - goto new_slab
>     - slub_percpu_partial() is NULL
>     - get_partial() returns NULL
>     - slub_put_cpu_ptr() (enables preemption)
>  - [PREEMPT B->A]
>  - task A: finish do_slab_free():
>     - this_cpu_cmpxchg_double() succeeds()
>     - [CORRUPT STATE: c->slab==NULL, c->freelist!=NULL]
> 
> 
> From there, the object on c->freelist will get lost if task B is allowed to
> continue from here: It will proceed to the retry_load_slab label,
> set c->slab, then jump to load_freelist, which clobbers c->freelist.
> 
> 
> But if we instead continue as follows, we get worse corruption:
> 
>  - task A: run __slab_free() on object from other struct slab:
>     - CPU_PARTIAL_FREE case (slab was on no list, is now on pcpu partial)
>  - task A: run slab_alloc_node() with NUMA node constraint:
>     - fastpath fails (c->slab is NULL)
>     - call __slab_alloc()
>     - slub_get_cpu_ptr() (disables preemption)
>     - enter ___slab_alloc()
>     - c->slab is NULL: goto new_slab
>     - slub_percpu_partial() is non-NULL
>     - set c->slab to slub_percpu_partial(c)
>     - [CORRUPT STATE: c->slab points to slab-1, c->freelist has objects
>       from slab-2]
>     - goto redo
>     - node_match() fails
>     - goto deactivate_slab
>     - existing c->freelist is passed into deactivate_slab()
>     - inuse count of slab-1 is decremented to account for object from
>       slab-2
> 
> At this point, the inuse count of slab-1 is 1 lower than it should be.
> This means that if we free all allocated objects in slab-1 except for one,
> SLUB will think that slab-1 is completely unused, and may free its page,
> leading to use-after-free.
> 
> Fixes: c17dda40a6a4e ("slub: Separate out kmem_cache_cpu processing from deactivate_slab")
> Fixes: 03e404af26dc2 ("slub: fast release on full slab")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
