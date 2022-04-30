Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9894E515C89
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiD3Lw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 07:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiD3LwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 07:52:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602AB75E6A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:49:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq10so9183824pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2MPzekCUKXPke9z3oTQa7Yx8/S0qu96viMfodSH2jg=;
        b=F7J5oiPv5vblGlDQr017khwTwKeA4Sci8vRMXI8CrPcCsI++3NAWIHC2DkBc9PyV9F
         w2ikILV6kPreMl9AZ/V15rX0M4ZnNfxHQsPbS9IE1qXh7Cw86gXtvp138o7G54SQMo4X
         UH/Q8zihjz2d0ni6GKVIxjlqnPyhmAtrjOJBLA2A1gxT6dwNyOKPyoQZQaOJLorp14B/
         hC1w2FG/BnHQPIKRnP8j6tA1LFY0JfXojwVDY0j8twD4E71AXtwi3fWA8tw69iYwSwvJ
         /Kipl3ifSE0CnBlsBGZm5ZSYXATLHzA+gVrjohkaBHsYsuhGO/IUae1kc//X52bO0iBU
         2BCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2MPzekCUKXPke9z3oTQa7Yx8/S0qu96viMfodSH2jg=;
        b=y5t4mnSX8CZBOy/XxHF963n9cnxlidVR2dsJ/WA1i+rTJC6xcupJYXO8DLLxTeLxky
         fyIG/dXJfsidf8dMOrlpFH12vRtcPU5S7KbijbnnBjW7SjYZCFA7nxdF0A+875vQN6oT
         dC4jDuCBUmQcGEoIGQ0taivNfBh0o9oKTuVzeSXohvmQTnk8/87dIJXXvxvzHKqn7hii
         Yc1b9TA7BAaCn6hUxXsBgIB6ZwX/RaQYAwgW7sBCErjX3KjWYUX3fCmOlufmJfjgN7Cc
         CAjd704iEayscjq7JN5UeBVXnudo1U6IkDdOlEd6X1OdFP0bEbfRGCSL8fP05B2ZHWWc
         wMXQ==
X-Gm-Message-State: AOAM533EtVXdXuri9FkUI3PiM2RZtBgT2tpsnd/mc0e/pGwpPWdOvmKw
        81ptbM/R02VZnSw6MkNfY9c=
X-Google-Smtp-Source: ABdhPJyL/eZiC28IcUv5DOLvRU4RDw2vx6fWkSWCjM7xvlgLb0sEC4Qs647FKJakoxCqxEVVY/Y7Sw==
X-Received: by 2002:a17:90b:4c88:b0:1d9:7158:876b with SMTP id my8-20020a17090b4c8800b001d97158876bmr3880850pjb.54.1651319341908;
        Sat, 30 Apr 2022 04:49:01 -0700 (PDT)
Received: from ip-172-31-27-201.ap-northeast-1.compute.internal (ec2-18-183-95-104.ap-northeast-1.compute.amazonaws.com. [18.183.95.104])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090ae20500b001da3780bfd3sm12751606pjz.0.2022.04.30.04.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2022 04:49:01 -0700 (PDT)
Date:   Sat, 30 Apr 2022 11:48:56 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/23] mm/slab_common: cleanup
 kmem_cache_alloc{,node,lru}
Message-ID: <20220430114854.GB24925@ip-172-31-27-201.ap-northeast-1.compute.internal>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-11-42.hyeyoo@gmail.com>
 <228411f0-96b9-60b4-b734-444ea39a354b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228411f0-96b9-60b4-b734-444ea39a354b@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:01:27PM +0200, Vlastimil Babka wrote:
> On 4/14/22 10:57, Hyeonggon Yoo wrote:
> > Implement only __kmem_cache_alloc_node() in slab allocators and make
> > kmem_cache_alloc{,node,lru} wrapper of it.
> > 
> > Now that kmem_cache_alloc{,node,lru} is inline function, we should
> > use _THIS_IP_ instead of _RET_IP_ for consistency.
> 
> Hm yeah looks like this actually fixes some damage of obscured actual
> __RET_IP_ by the recent addition and wrapping of __kmem_cache_alloc_lru().
> 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Some nits:
> 
> > ---
> >  include/linux/slab.h | 52 ++++++++++++++++++++++++++++++++-----
> >  mm/slab.c            | 61 +++++---------------------------------------
> >  mm/slob.c            | 27 ++++++--------------
> >  mm/slub.c            | 35 +++++--------------------
> >  4 files changed, 67 insertions(+), 108 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 143830f57a7f..1b5bdcb0fd31 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -429,9 +429,52 @@ void *__kmalloc(size_t size, gfp_t flags)
> >  	return __kmalloc_node(size, flags, NUMA_NO_NODE);
> >  }
> >  
> > -void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> > -void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> > -			   gfp_t gfpflags) __assume_slab_alignment __malloc;
> > +
> > +void *__kmem_cache_alloc_node(struct kmem_cache *s, struct list_lru *lru,
> > +			   gfp_t gfpflags, int node, unsigned long caller __maybe_unused)
> > +			    __assume_slab_alignment __malloc;
> 
> I don't think caller needs to be __maybe_unused in the declaration nor any
> of the implementations of __kmem_cache_alloc_node(), all actually pass it on?

My intention was to give hints to compilers when CONFIG_TRACING=n.
I'll check if the compiler just optimizes them without __maybe_unused.

Thanks!
