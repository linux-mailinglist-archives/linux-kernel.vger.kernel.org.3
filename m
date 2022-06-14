Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E954ABAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiFNIXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354764AbiFNIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:23:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6770366B7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:23:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8F6B219C6;
        Tue, 14 Jun 2022 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655195010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbDwgCDC83yfCj+TZV5PGT5Qxl3yRAG0I7V0QWxMlFU=;
        b=mWyA+fv6hMEqqk9jhMjbfNmrrAKwQHs3sYxtr5oDqtTXmKgGaDDWInlENHqOBkrCHG+Kkp
        UVy+09OTh+5DjVNgCEHaj/CCbLdWft+WBCwM3mLgbqTSiRXcl9OLA791CTtYaK9TEUoFPk
        E+74AMi8NRNZ7wP5RZP8tPU/1ImiVlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655195010;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbDwgCDC83yfCj+TZV5PGT5Qxl3yRAG0I7V0QWxMlFU=;
        b=YfZG+f4EmdutJYe9Hhx34VFeBc0JF9TFv0vjSJKz3Bijzd/yOh0Te9j/S6i4Va/tbT+JqC
        kRj75VFkEqsNI7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C41761361C;
        Tue, 14 Jun 2022 08:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KQcsL4JFqGJUHAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Jun 2022 08:23:30 +0000
Message-ID: <95a9f679-93d9-548a-fc26-985ec605e7f8@suse.cz>
Date:   Tue, 14 Jun 2022 10:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm/slub: add missing TID updates on slab deactivation
Content-Language: en-US
To:     Jann Horn <jannh@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220608182205.2945720-1-jannh@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220608182205.2945720-1-jannh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 20:22, Jann Horn wrote:
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

Hmm these are old commits, and currently oldest LTS is 4.9, so this will be
fun. Worth doublechecking if it's not recent changes that actually
introduced the bug... but seems not, AFAICS.

> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  mm/slub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index e5535020e0fdf..b97fa5e210469 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2936,6 +2936,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  	if (!freelist) {
>  		c->slab = NULL;
> +		c->tid = next_tid(c->tid);
>  		local_unlock_irqrestore(&s->cpu_slab->lock, flags);

So this immediate unlock after setting NULL is new from the 5.15 preempt-rt
changes. However even in older versions we could goto new_slab,
new_slab_objects(), new_slab(), allocate_slab(), where if
(gfpflags_allow_blocking()) local_irq_enable(); (there's no extra disabled
preemption besides the irq disable) so I'd say the bug was possible before
too, but less often?

>  		stat(s, DEACTIVATE_BYPASS);
>  		goto new_slab;
> @@ -2968,6 +2969,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	freelist = c->freelist;
>  	c->slab = NULL;
>  	c->freelist = NULL;

Previously these were part of deactivate_slab(), which does that at the very
end, but also without bumping tid.
I just wonder if it's necessary too, because IIUC the scenario you described
relies on the missing bump above. This alone doesn't cause the c->slab vs
c->freelist mismatch?
But I guess it won't hurt to just bump tid on each c->freelist assignment.
In backports we would just add it to deactivate_slab() instead.

Thanks. Applying to slab/for-5.19-rc3/fixes branch.

> +	c->tid = next_tid(c->tid);
>  	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  	deactivate_slab(s, slab, freelist);
>  
> 
> base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6

