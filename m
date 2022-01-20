Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98B49466E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358479AbiATE0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358478AbiATEZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:25:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC53C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a5so4260258pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bUsgaMBDfG4yraE8r8249vlbvccsa1/qhnf6WMP62oE=;
        b=nwqLfBerlXM/t3wu+MTn1pHkmv8eg8hwR6iGEhBbOp6h/SP9Gq+xYYPjoNj9y1BH/2
         6tH9vhty116CXXrQ9xuVtpDYmq985JCfRvYXGfA2kzq4n8I7POihddsMTwF/ITo2ri7p
         uC88OSZgdgY5IQUqg9dI4ObizFha8W/zuRLqTNr1WJ0fBT4Y5zz2Hq4yBgyeR16Y65rI
         E2aUsz1peNhVNdoDxIrkOk8/NGjASdoIpY1tOz/bNdsA72yWbalq5SiRCQzXuBaEYrSM
         mPJo3MZFtmHi6+kF7fIE1kFc0b06QvruVQxmqQqqO+KEnmYhwnKw0wD9/WihCOp5QPvA
         XzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bUsgaMBDfG4yraE8r8249vlbvccsa1/qhnf6WMP62oE=;
        b=GJYv6qNU/XPojBub/v+E1+c7BUhSQdE9opf/175ov4xG8wM3nFh+XbFgmQ9mV1hccE
         4fbEIPCPfI3AaIMmPdjyCOHP/+/qbGuz0zB9HIFWSIgB2tlhsdhBKhPwRXJJ4Nm79d4J
         3sWNHkfgacDo4/mEBKNydLhDOb32SHQni0VHQ+2h25a4OTbPChj0Hbp/o2iGgd+qfqhe
         hcmnb93COhGPdarMqG2KpMw+P39mmDV/mUZw6Bmm2yuCi5TfhhgKYvwf6WCViLe1cC1K
         8GRk0tzhQHXmvG0i29vIel+WTyaXiYbW/QQJkf55OmiELG5BYjJIofHO6EYo3hk8WUz+
         7qLg==
X-Gm-Message-State: AOAM531RBTBr2VlTcnlKiCfxYFd03fkYQqBAjdit6el93v/LJuqqpeXs
        eSAkBr1OxKP8VBJl5Yi8ao4=
X-Google-Smtp-Source: ABdhPJzH/JS2rSkDY8jH2Gdz8RB5tDOsyzr+lLveNQLhx0bZybiHHX0Y4Petll4cbI7OKBSjLe5tIA==
X-Received: by 2002:a63:82c2:: with SMTP id w185mr24283737pgd.264.1642652756888;
        Wed, 19 Jan 2022 20:25:56 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b370:1e12:5bf4:801f])
        by smtp.gmail.com with ESMTPSA id c2sm968852pgi.55.2022.01.19.20.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 20:25:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 19 Jan 2022 20:25:54 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YejkUlnnYeED1pC5@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YefX1t4owjlx/m5I@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:20:22AM +0100, Michal Hocko wrote:
> On Tue 18-01-22 16:12:54, Minchan Kim wrote:
> > On Mon, Jan 17, 2022 at 02:47:06PM +0100, Michal Hocko wrote:
> > > On Thu 30-12-21 11:36:27, Minchan Kim wrote:
> > > > lru_cache_disable involves IPIs to drain pagevec of each core,
> > > > which sometimes takes quite long time to complete depending
> > > > on cpu's business, which makes allocation too slow up to
> > > > sveral hundredth milliseconds. Furthermore, the repeated draining
> > > > in the alloc_contig_range makes thing worse considering caller
> > > > of alloc_contig_range usually tries multiple times in the loop.
> > > >
> > > > This patch makes the lru_cache_disable aware of the fact the
> > > > pagevec was already disabled. With that, user of alloc_contig_range
> > > > can disable the lru cache in advance in their context during the
> > > > repeated trial so they can avoid the multiple costly draining
> > > > in cma allocation.
> > > 
> > > Do you have any numbers on any improvements?
> > 
> > The LRU draining consumed above 50% overhead for the 20M CMA alloc.
> 
> This doesn't say much about the improvement itself.

The improvement is various depending on system state since it's
timing sensitive. Let me try to get it.

>  
> > > Now to the change. I do not like this much to be honest. LRU cache
> > > disabling is a complex synchronization scheme implemented in
> > > __lru_add_drain_all now you are stacking another level on top of that.
> > > 
> > > More fundamentally though. I am not sure I understand the problem TBH.
> > 
> > The problem is that kinds of IPI using normal prority workqueue to drain
> > takes much time depending on the system CPU business.
> 
> How does this patch address that problem? The IPI has to happen at some
> point as we need to sync up with pcp caches.

True but the goal is to minimize the IPI overhead. Pleas look at
alloc_contig_range and what happens if it fails with -EBUSY.
The caller usually try again and then alloc_contig_range calls
the drain again. In our workload, it keeps repeated until the
allocation succeeded and the IPI keeps calling. Totally wasted.

> 
> > > What prevents you from calling lru_cache_disable at the cma level in the
> > > first place?
> > 
> > You meant moving the call from alloc_contig_range to caller layer?
> 
> Yes.
> 
> > So, virtio_mem_fake_online, too? It could and make sense from
> > performance perspective since upper layer usually calls the
> > alloc_contig_range multiple times on retrial loop.
> > 
> > Havid said, semantically, not good in that why upper layer should
> > know how alloc_contig_range works(LRU disable is too low level stuff)
> > internally but I chose the performance here.
> > 
> > There is an example why the stacking is needed.
> > cma_alloc also can be called from outside.
> > A usecase is try to call
> > 
> >     lru_cache_disable
> >     for (order = 10; order >= 0; order) {
> >         page = cma_alloc(1<<order)
> >         if (page)
> >             break;
> >     }
> >     lru_cacne_enable
> > 
> > Here, putting the disable lru outside of cma_alloc is
> > much better than inside. That's why I put it outside.
> 
> What does prevent you from calling lru_cache_{disable,enable} this way
> with the existing implementation? AFAICS calls can be nested just fine.
> Or am I missing something?

It just increases more IPI calls since we drain the lru cache
both upper layer and lower layer. That's I'd like to avoid
in this patch. Just disable lru cache one time for entire
allocation path.
