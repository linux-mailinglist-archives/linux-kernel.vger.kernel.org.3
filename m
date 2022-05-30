Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3695F538888
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiE3VOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiE3VOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:14:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1398985AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:14:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so361487pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eNXFxnoABD+DlJyv7EOStHP7h7XQJhNVHIMmf8yztUg=;
        b=XUHEtNIqbQt5VF4ySm2C8zptGsGm1VPpPtLyqcEYn+mr55JxjaOdtwXzd20IlQGcJP
         f69Cg83gWWe6DMQ7pAL14vCfafzgb9RoyU5eJ4CMqEC0gOzcypmp8KwhUBJKC7vztQ39
         HQpDOO99sS2wDaaFerLs0VEk3OHqwKBO1nbBqaC/XwsFEmdd1k5+jBVGanSv/I/OwTb8
         RhXilo9vs0jEm8EDJiXVxMCQ+3G+KPhYIejZlsZ+hd83H++v2BK9Q827LzHQVxq/a0f5
         Urc+GEuTayCUDTpBwa/6t/3U7eQcJk/KTfAr/Xp80SNFf6L0EbkdFWBRafq25kx4ycsU
         8/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=eNXFxnoABD+DlJyv7EOStHP7h7XQJhNVHIMmf8yztUg=;
        b=hDkN/9HXjyaNpMRzGSqfnZhWrii1oDWbCAgL/u5Oy6jL+fvmN/u0zqxco0l5cKyJOt
         JjRf7mqENgjKf/ZMw6SprurMySLW3lLVA4T0HsMvCcV8CnvbrfrT+4EE89h5cegGPHd1
         L51SculkVs73B0zHZBECvCzpw/opQSj+eXdHl+uZ+aYawXyozEEkgbRPcH3bHdNqqi1m
         54kBOttYcEH0BlzAi+y0+knjlZTwfXqaYiJonwnz1EmFPwgoKwafrWFZPsNaEHvnJSxp
         rqbhCdVdCDayvCP8yetsT6f8IlHLL0Sf399RNP2M4r9OahsxguvakB9wCI5C/TIc1wF+
         SqCg==
X-Gm-Message-State: AOAM533FoPNmX+SsuIJiBrkPvtzxWueg2e6ArWUX3iptuu/dNVALnsij
        tXg7lrusopn+NkTEVjcGMemhBw==
X-Google-Smtp-Source: ABdhPJw9E6wUF4yv1K04ZTwWFrEFHleLoS9FhDHWS5CcWx8kW4fq0wUXpaI0qaWQLbS90dyKpUkfQA==
X-Received: by 2002:a17:90b:4aca:b0:1e2:7339:8c55 with SMTP id mh10-20020a17090b4aca00b001e273398c55mr21133438pjb.187.1653945287876;
        Mon, 30 May 2022 14:14:47 -0700 (PDT)
Received: from [2620:15c:29:204:c052:818:52bf:5f90] ([2620:15c:29:204:c052:818:52bf:5f90])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902868c00b0015e8d4eb26csm8694825plo.182.2022.05.30.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 14:14:47 -0700 (PDT)
Date:   Mon, 30 May 2022 14:14:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
In-Reply-To: <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
Message-ID: <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com> <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal>
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

On Sun, 29 May 2022, Hyeonggon Yoo wrote:

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

This is a good point, it would be useful to gather some benchmarks for 
workloads that are known to thrash some caches and would hit this path 
such as netperf TCP_RR.
