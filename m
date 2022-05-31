Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E5538A42
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 05:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243731AbiEaDrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 23:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiEaDr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 23:47:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00995005E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 20:47:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e66so11662193pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1jJMGtx0v3jsSZCsWgNDKZoqTVtoaISmRh/JDCTDMjc=;
        b=YhVzx0YTquy6VctSS8wJlrQZMR1MQqkWkVpCNx3djA8KDOIjojKEz2lPixlieJZx7E
         xwny4wFTTlF4r5Z3YWo8ODawCTVA8oPW9AfNWpFUeXOCGe3VNzB1VER/DZqHxwxvMkyw
         z9lZqVa+DnqMQBQRjIBBNRnP8NkUHm1cVFAtks55DQdon7sit3ZMg87FsbsP/BPwAdDX
         Vg7FA9gSgduLNaOftEgFFeCHJ9V3WAq4FoyXSZzGXtz+avo3xLdXd28Fb2U5sgwaqJpD
         K/aAMIQwbj760kEw3bh9qiXhYwJC2ZUOzTlyvpuQhQtfW+3OJYE80ZEGVz4lWfQFcyar
         lAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1jJMGtx0v3jsSZCsWgNDKZoqTVtoaISmRh/JDCTDMjc=;
        b=08q86NJhtsbgig8jP3KnWmsuSYeDT7t98R0MYymfNxyZq4UYwJ49fqL+g14dEyE5bE
         zEXHKTpNdcbtRbos8tUT5UXzTyyekshOOhCl5Bmrbc9q9fnco1vN8Nu2F6jl4cFnNdS6
         EzPaVlumllSqXa4tXXBEXQy5eXL7R70n9nWxvwIC7+CSi+g6SqVZtZNlWdK5QIGwoSbD
         YEqUTaHfA/D9nLVOnppRC4v/OsGOh+wcm81nUlpZmWaGtHfiAfQ4AHAsvmlmb1BziHXf
         9wXzOS10EJYoDajiU0YfNRDPkIXhDQ0AsjrcsfAIbj8lSBEMhZe1HIfa4NdwQTDbkv3r
         PnFQ==
X-Gm-Message-State: AOAM531/9o9adkdbusJ8HQ2jxpKzvP0qycFALd/9jt8J3c8JdGrkrExg
        ZAAcscNA9pEkrH/p7DnzEPGXsg==
X-Google-Smtp-Source: ABdhPJyZlDnH/j1wCEQl0wod78VCucoi0E7p3+oWeEsAZ3/VplPgxgBJtwJWNuoX2wSu60y05qUwgg==
X-Received: by 2002:a05:6a00:1351:b0:518:9fa0:fbe3 with SMTP id k17-20020a056a00135100b005189fa0fbe3mr41523107pfu.45.1653968846454;
        Mon, 30 May 2022 20:47:26 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7163:3a36:783f:6d4a])
        by smtp.gmail.com with ESMTPSA id o3-20020a654583000000b003fa5b550303sm9321828pgq.68.2022.05.30.20.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 20:47:26 -0700 (PDT)
Date:   Tue, 31 May 2022 11:47:22 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
Message-ID: <YpWPykstpyt+b65x@FVFYT0MHHV2J.googleapis.com>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com>
 <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 11:37:06AM +0000, Hyeonggon Yoo wrote:
> On Sun, May 29, 2022 at 04:15:33PM +0800, Rongwei Wang wrote:
> > In use cases where allocating and freeing slab frequently, some
> > error messages, such as "Left Redzone overwritten", "First byte
> > 0xbb instead of 0xcc" would be printed when validating slabs.
> > That's because an object has been filled with SLAB_RED_INACTIVE,
> > but has not been added to slab's freelist. And between these
> > two states, the behaviour of validating slab is likely to occur.
> > 
> > Actually, it doesn't mean the slab can not work stably. But, these
> > confusing messages will disturb slab debugging more or less.
> > 
> > Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> 
> Have you observed it or it's from code inspection?
> 
> > ---
> >  mm/slub.c | 40 +++++++++++++++++-----------------------
> >  1 file changed, 17 insertions(+), 23 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ed5c2c03a47a..310e56d99116 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1374,15 +1374,12 @@ static noinline int free_debug_processing(
> >  	void *head, void *tail, int bulk_cnt,
> >  	unsigned long addr)
> >  {
> > -	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
> >  	void *object = head;
> >  	int cnt = 0;
> > -	unsigned long flags, flags2;
> > +	unsigned long flags;
> >  	int ret = 0;
> >  
> > -	spin_lock_irqsave(&n->list_lock, flags);
> > -	slab_lock(slab, &flags2);
> > -
> > +	slab_lock(slab, &flags);
> >  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> >  		if (!check_slab(s, slab))
> >  			goto out;
> > @@ -1414,8 +1411,7 @@ static noinline int free_debug_processing(
> >  		slab_err(s, slab, "Bulk freelist count(%d) invalid(%d)\n",
> >  			 bulk_cnt, cnt);
> >  
> > -	slab_unlock(slab, &flags2);
> > -	spin_unlock_irqrestore(&n->list_lock, flags);
> > +	slab_unlock(slab, &flags);
> >  	if (!ret)
> >  		slab_fix(s, "Object at 0x%p not freed", object);
> >  	return ret;
> > @@ -3304,7 +3300,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
> >  
> >  {
> >  	void *prior;
> > -	int was_frozen;
> > +	int was_frozen, to_take_off = 0;
> >  	struct slab new;
> >  	unsigned long counters;
> >  	struct kmem_cache_node *n = NULL;
> > @@ -3315,15 +3311,19 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
> >  	if (kfence_free(head))
> >  		return;
> >  
> > +	n = get_node(s, slab_nid(slab));
> > +	spin_lock_irqsave(&n->list_lock, flags);
> > +
> 
> Oh please don't do this.
> 
> SLUB free slowpath can be hit a lot depending on workload.
> 
> __slab_free() try its best not to take n->list_lock. currently takes n->list_lock
> only when the slab need to be taken from list.
> 
> Unconditionally taking n->list_lock will degrade performance.
>

I can confirm you are right. We have encountered this issue in practise.
We have deployed somen HDFS instance on a 256-CPU machine.  When there
are lots of IO requests from users, we can see lots of threads are contended
on n->list_lock.  Lots of call traces are like following:

  ffffffff810dfbb4 native_queued_spin_lock_slowpath+0x1a4
  ffffffff81780ffb _raw_spin_lock+0x1b
  ffffffff8127327e get_partial_node.isra.81+0x5e
  ffffffff812752d3 ___slab_alloc+0x2f3
  ffffffff8127559c __slab_alloc+0x1c
  ffffffff81275828 kmem_cache_alloc+0x278
  ffffffff812e9e3d alloc_buffer_head+0x1d
  ffffffff812e9f74 alloc_page_buffers+0xa4
  ffffffff812eb0e9 create_empty_buffers+0x19
  ffffffff812eb37d create_page_buffers+0x7d
  ffffffff812ed78d __block_write_begin_int+0x9d

I thought it was because there are lots of threads which consume local
CPU slab cache quickly and then both of them try to get a new slab
from node partial list.  Since there are 256 CPUs, the contention
is more competitive and easy to be visible.

Any thoughts on this issue (e.e. how to ease contention)? Comments
are welcome.

Thanks.


