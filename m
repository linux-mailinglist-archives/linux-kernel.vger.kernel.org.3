Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C144547CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 00:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiFLWpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 18:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiFLWpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:45:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC215A3C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:45:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s135so4043957pgs.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1oIWI4/pMxhVpnGR8mWwnEUQwkLULe/4XPICVKx3jDo=;
        b=UOW0B2+g9veBuaJJesGAmSzK1rGUugRhWrD5RW7QzMjs15uB/vabAAaa+1ArjtXI5+
         wCYhNwe/NeGYXSF+DCsvGYFedmwdBuhv5XJsnOadbqloQBNC5oMOgdTuovwGUIvQdb/O
         Ve4m1lKhYyHDx6pkuMI6BUOWdxHnAE5ZmVQnZyhPBoSWVzqR3L/7Ywyt2mbMDx4Es4Vi
         6MO9PZj1YzqUY4BVoHNrGUQY9D8KevxZ6ZNB3l5YcY6KBE1AZccufF7wl4TSc5xLGf8k
         dJaTpMxuK1moJei5r0lcOcD5I7ackAqK91hbUpELC0RTnWmzijD2pmlA5UiGo/nWJSdp
         /MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1oIWI4/pMxhVpnGR8mWwnEUQwkLULe/4XPICVKx3jDo=;
        b=ATXYTD4u48DSE1d0AlEVf+nHhjhBI5MGCsmFjbSVSUMIKlf7IP6Cr9XmBETDk0jWjl
         VDYeU2rZVS3WpuB4vPR1okOrpQ7BhL1Tfy3TW1X5P2G9wh2jiFStoXkUYHhFInGXj1dI
         djO1Nj4rOrtA7Glv5lNvHII1DPOUVzRzv4vaMQJPD16+XKX2S4PwugRePM8M0UAdYEHs
         ssvqdDnVNN9avMo8egK0cR1K0G7D1lyMkUgnTuBuGLAPcq/JHYERw3zZ1DEIEyLNxm8Q
         PMORNjYSQ3jbQkRSERfX7Xv2QrVhMVf9Wzja6UWCOlujgABkY5+hgNfbQt5eKkwE+xeB
         C44g==
X-Gm-Message-State: AOAM533HKsJojuNc2lEMyaR3RnrPUxUbU1mx5HWmiGhEAnG4fueaxj9Z
        9TPvHhZD1hAW6Lfd//+3RSOpdA==
X-Google-Smtp-Source: ABdhPJyAP8xw16XX2GSBGtQvZt9bLabQmLWafEoHqcf2Pz+n5g0fWR/Cp0oESoC3dkMDpfmQImnIDQ==
X-Received: by 2002:a62:cd08:0:b0:51b:c569:cbb8 with SMTP id o8-20020a62cd08000000b0051bc569cbb8mr55896645pfg.71.1655073902690;
        Sun, 12 Jun 2022 15:45:02 -0700 (PDT)
Received: from [2620:15c:29:204:c274:b6da:d4b1:cf53] ([2620:15c:29:204:c274:b6da:d4b1:cf53])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b001677841e9c2sm3548275plk.119.2022.06.12.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 15:45:02 -0700 (PDT)
Date:   Sun, 12 Jun 2022 15:45:01 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Jann Horn <jannh@google.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: add missing TID updates on slab deactivation
In-Reply-To: <20220608182205.2945720-1-jannh@google.com>
Message-ID: <a9efec2b-a6cc-89b6-e295-995e9afdd373@google.com>
References: <20220608182205.2945720-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022, Jann Horn wrote:

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

Acked-by: David Rientjes <rientjes@google.com>
