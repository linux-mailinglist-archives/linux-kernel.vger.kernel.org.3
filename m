Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71955AC383
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiIDJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 05:03:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B8C481FF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 02:03:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o15-20020a17090a3d4f00b002004ed4d77eso490958pjf.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/nOdZT0dya6kDHenQdU2BmxT3CFwwxmGevkfqFbAuFY=;
        b=DjQylxg2aCtbrA/Enu4bJ9WBUJ37jX/G4ldPk0TEIGmrJzSn/zLiF+TBkfaa+cbrX5
         3rHQlye8TJ/GDmM4KVl3TCsFEEU/iFzXdTPBT0b5DvP7KbLGgJHVIjqeOvmSsslqOqAm
         Uo6DbAvaOyotLi2NAzyU42v8UyvuhP45zMHR09YVD+ISWm6pkUF9y//qdH0VDKUdBEuY
         ha9qmcpYaf3JZpVs/GCF0jTUMMQzngK8O2+fppzsCsGhyoEkY4XjtM6ZC8J9Im4tKuYf
         AjV5Yw4CeyR0jWCAuGEUnGKVqZhMAR/B721f5KUA9PNJFUx7sPeR3qe2zDNuchO3xwjI
         lQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/nOdZT0dya6kDHenQdU2BmxT3CFwwxmGevkfqFbAuFY=;
        b=wHVcRxPliLzQKmFk7aJGMCE7dIznqDkMyrazmDMsDEmaLAFqu4n99YQyp48ToUV0Jc
         oC8jKjzzXkeCPde/xSBAnQ8Kd+5nVgIAtHjg+fryobyrOzMcio3YNeWAlRDj9p30wbfh
         1Oe3wkdaYxTahwYA2y5XmjCVBXAndIoptgo1EvRKoyXk0Pk4GFJUAS9BMuGha0vdUrd0
         9i1FrFUIzuUJMBKwaKf3dcB611HPA7PptoLiG45keqCKa3EhVhHyUYmRr2QXTqZ7OS69
         KTJrrYo/fSzJYCPIFGnnI8jb1GRn772y542q2xpzPzt7XJURGegLQeFQNV7LHhT/jnON
         0mEg==
X-Gm-Message-State: ACgBeo2OejZWF7mDGjoqV9tfoqp0RzdiqY9MOpNYwXTl2UUS2m774EWL
        dAl1OBqTlHrEEz5AtlDlOGU=
X-Google-Smtp-Source: AA6agR4HqDNxujARcBBMEzZncfiL/3fOmXb4uuIXGVv8HCNSZLvLPUW0S8S4ZdHoKEUeakdbt/4WqQ==
X-Received: by 2002:a17:90a:cb07:b0:1fd:f273:dd90 with SMTP id z7-20020a17090acb0700b001fdf273dd90mr13777483pjt.95.1662282221574;
        Sun, 04 Sep 2022 02:03:41 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a34cf00b001fb35e4044bsm8191706pjf.40.2022.09.04.02.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 02:03:40 -0700 (PDT)
Date:   Sun, 4 Sep 2022 18:03:34 +0900
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxRp5uz9KSY0S9id@hyeyoo>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <YxC7Kda5g/aEqarm@hyeyoo>
 <YxGfkdvJcNJma/88@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxGfkdvJcNJma/88@feng-clx>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:15:45PM +0800, Feng Tang wrote:
> On Thu, Sep 01, 2022 at 10:01:13PM +0800, Hyeonggon Yoo wrote:
> > On Mon, Aug 29, 2022 at 03:56:15PM +0800, Feng Tang wrote:
> > > kmalloc's API family is critical for mm, with one nature that it will
> > > round up the request size to a fixed one (mostly power of 2). Say
> > > when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> > > could be allocated, so in worst case, there is around 50% memory
> > > space waste.
> > > 

[...]

> > > 
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: John Garry <john.garry@huawei.com>
> > > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >  include/linux/slab.h |  2 +
> > >  mm/slub.c            | 94 +++++++++++++++++++++++++++++++++++++-------
> > >  2 files changed, 81 insertions(+), 15 deletions(-)
> > 
> > 
> > Would you update Documentation/mm/slub.rst as well?
> > (alloc_traces part)
>  
> Sure, will do.
> 
> > [...]
> > 
> > >   */
> > >  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> > >  {
> > >  	void *freelist;
> > >  	struct slab *slab;
> > > @@ -3115,6 +3158,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >  
> > >  		if (s->flags & SLAB_STORE_USER)
> > >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > > +		set_orig_size(s, freelist, orig_size);
> > >  
> > >  		return freelist;
> > >  	}
> > > @@ -3140,6 +3184,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > >  		 */
> > >  		if (s->flags & SLAB_STORE_USER)
> > >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > > +		set_orig_size(s, freelist, orig_size);
> > > +
> > >  		return freelist;
> > >  	}
> > 
> > 
> > This patch is okay but with patch 4, init_object() initializes redzone/poison area
> > using s->object_size, and init_kmalloc_object() fixes redzone/poison area using orig_size.
> > Why not do it in init_object() in the first time?
> > 
> > Also, updating redzone/poison area after alloc_single_from_new_slab()
> > (outside list_lock, after adding slab to list) will introduce races with validation.
> > 
> > So I think doing set_orig_size()/init_kmalloc_object() in alloc_debug_processing() would make more sense.
> 
> Yes, this makes sense, and in v3, kmalloc redzone/poison setup was
> done in alloc_debug_processing() (through init_object()). When
> rebasing to v4, I met the classical problem: how to pass 'orig_size'
> parameter :)
> 
> In latest 'for-next' branch, one call path for alloc_debug_processing()
> is
>   ___slab_alloc
>     get_partial
>       get_any_partial
>         get_partial_node
>           alloc_debug_processing
> 
> Adding 'orig_size' paramter to all these function looks horrible, and
> I couldn't figure out a good way and chosed to put those ops after
> 'set_track()'

IMO adding a parameter to them isn't too horrible...
I don't see better solution than adding a parameter with current implementation.
(Yeah, the code is quite complicated...)

It won't affect performance to meaningful degree as most of
allocations will be served from cpu slab or percpu partial list. 

-- 
Thanks,
Hyeonggon
