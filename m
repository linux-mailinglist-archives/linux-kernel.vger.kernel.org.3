Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9F53D67D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiFDLFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiFDLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:05:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37B1CFC3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 04:05:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z197so3774385iof.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 04:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LXSima+rBrCZEoEdN9Res2CXy6Ed3jHKZBixDdAZll8=;
        b=PHV3GKBOOPM8zFLSgovBNQM6CEUPk3EF1YQWC5HUsvdBkhDIFswCP3TuCMSDWcFu1Y
         FIM4KoackkR4uQVpQlXCCU1ufCzd8fMioUYyRMfL+NWbEoGLjzXSfUOIcYm4J3kC19cz
         aE5aWY7B11ZW83m254oZwDglF10Vb9E5d9sqmgYeLbS2DLMnLG6exu5sheVJpj0yWmmK
         pu8EAtbA1MWZtgtMEhBNA/Z3D7d1f0OClXtiM2syAVtrQG6c0pQg/uTiGC+eeVMRjvjJ
         PqS+dNkqjIOcTzZ9dUmeEiPlfk3kE36G6GeL6y6Q4qxjSggyAHikgF8ZiwfEz6B/GphQ
         s6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LXSima+rBrCZEoEdN9Res2CXy6Ed3jHKZBixDdAZll8=;
        b=FC/ezSRcZjkFT7ZS6Yrp7k2FjOXSiXAp/9NA7JUlzCr80eWTkz/IQ+g4LJ69mCH/Ph
         qtpo78Qml8ErQhzZKx8H4WFmJ81r4Oa2ThxoVkkyqsMCfOjH3gqgDzJue8jY4egML6Nn
         ObB4Dv1IjiwBzUyuSE1j9oWTA2VcxQWTFisARhrPuUVQN2rC21k7ny1sfWLprqK9vDlO
         ynV2MkbSjuw3HfilhL0QIiXpBgmYKs6+ASkWaio97P650CezGT/umF8aLvUFouvdd8US
         8MZzlpzf05IX+fbfa3PjsMdKKFsYpOPKWOCKSwmCGqfplGyQ0EKQzeVMX1c/Iqhq5Zlw
         93KA==
X-Gm-Message-State: AOAM530zgxYrhCkTvvRYeK1ilkV1j1OlEJzNK+WIu+xkz/jYZrMRD14Y
        o4Se1zmXCT02hX7/95BEIt8=
X-Google-Smtp-Source: ABdhPJw8dV2gItyNIZtjEdzZe9cHbFcqdcv5hFTxrgCHD7joYFdZ4SGHNtdsoRG7tLNP4KFnz831Ig==
X-Received: by 2002:a05:6602:81b:b0:665:746a:f079 with SMTP id z27-20020a056602081b00b00665746af079mr6863759iow.125.1654340704769;
        Sat, 04 Jun 2022 04:05:04 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id o1-20020a056e02102100b002d3ca0d55d0sm3954868ilj.48.2022.06.04.04.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:05:03 -0700 (PDT)
Date:   Sat, 4 Jun 2022 11:05:02 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Message-ID: <Yps8XtepKezXc2DM@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <YpWPykstpyt+b65x@FVFYT0MHHV2J.googleapis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpWPykstpyt+b65x@FVFYT0MHHV2J.googleapis.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 11:47:22AM +0800, Muchun Song wrote:
> On Sun, May 29, 2022 at 11:37:06AM +0000, Hyeonggon Yoo wrote:
> > On Sun, May 29, 2022 at 04:15:33PM +0800, Rongwei Wang wrote:
> > > In use cases where allocating and freeing slab frequently, some
> > > error messages, such as "Left Redzone overwritten", "First byte
> > > 0xbb instead of 0xcc" would be printed when validating slabs.
> > > That's because an object has been filled with SLAB_RED_INACTIVE,
> > > but has not been added to slab's freelist. And between these
> > > two states, the behaviour of validating slab is likely to occur.
> > > 
> > > Actually, it doesn't mean the slab can not work stably. But, these
> > > confusing messages will disturb slab debugging more or less.
> > > 
> > > Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> > 
> > Have you observed it or it's from code inspection?
> > 
> > > ---
> > >  mm/slub.c | 40 +++++++++++++++++-----------------------
> > >  1 file changed, 17 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index ed5c2c03a47a..310e56d99116 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1374,15 +1374,12 @@ static noinline int free_debug_processing(
> > >  	void *head, void *tail, int bulk_cnt,
> > >  	unsigned long addr)
> > >  {
> > > -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> > >  	void *object = head;
> > >  	int cnt = 0;
> > > -	unsigned long flags, flags2;
> > > +	unsigned long flags;
> > >  	int ret = 0;
> > >  
> > > -	spin_lock_irqsave(&n->list_lock, flags);
> > > -	slab_lock(slab, &flags2);
> > > -
> > > +	slab_lock(slab, &flags);
> > >  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> > >  		if (!check_slab(s, slab))
> > >  			goto out;
> > > @@ -1414,8 +1411,7 @@ static noinline int free_debug_processing(
> > >  		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
> > >  			 bulk_cnt, cnt);
> > >  
> > > -	slab_unlock(slab, &flags2);
> > > -	spin_unlock_irqrestore(&n->list_lock, flags);
> > > +	slab_unlock(slab, &flags);
> > >  	if (!ret)
> > >  		slab_fix(s, "Object at 0x%p not freed", object);
> > >  	return ret;
> > > @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
> > >  
> > >  {
> > >  	void *prior;
> > > -	int was_frozen;
> > > +	int was_frozen, to_take_off = 0;
> > >  	struct slab new;
> > >  	unsigned long counters;
> > >  	struct kmem_cache_node *n = NULL;
> > > @@ -3315,15 +3311,19 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
> > >  	if (kfence_free(head))
> > >  		return;
> > >  
> > > +	n = get_node(s, slab_nid(slab));
> > > +	spin_lock_irqsave(&n->list_lock, flags);
> > > +
> > 
> > Oh please don't do this.
> > 
> > SLUB free slowpath can be hit a lot depending on workload.
> > 
> > __slab_free() try its best not to take n->list_lock. currently takes n->list_lock
> > only when the slab need to be taken from list.
> > 
> > Unconditionally taking n->list_lock will degrade performance.
> >
> 
> I can confirm you are right. We have encountered this issue in practise.
> We have deployed somen HDFS instance on a 256-CPU machine.  When there
> are lots of IO requests from users, we can see lots of threads are contended
> on n->list_lock.  Lots of call traces are like following:
> 
>   ffffffff810dfbb4 native_queued_spin_lock_slowpath+0x1a4
>   ffffffff81780ffb _raw_spin_lock+0x1b
>   ffffffff8127327e get_partial_node.isra.81+0x5e
>   ffffffff812752d3 ___slab_alloc+0x2f3
>   ffffffff8127559c __slab_alloc+0x1c
>   ffffffff81275828 kmem_cache_alloc+0x278
>   ffffffff812e9e3d alloc_buffer_head+0x1d
>   ffffffff812e9f74 alloc_page_buffers+0xa4
>   ffffffff812eb0e9 create_empty_buffers+0x19
>   ffffffff812eb37d create_page_buffers+0x7d
>   ffffffff812ed78d __block_write_begin_int+0x9d
> 
> I thought it was because there are lots of threads which consume local
> CPU slab cache quickly and then both of them try to get a new slab
> from node partial list.  Since there are 256 CPUs, the contention
> is more competitive and easy to be visible.
> 
> Any thoughts on this issue (e.e. how to ease contention)? Comments
> are welcome.

How does increasing number of partial slabs affect your situation?
(increasing /sys/slab/<cache name>/cpu_partial)

> Thanks.
> 
> 
