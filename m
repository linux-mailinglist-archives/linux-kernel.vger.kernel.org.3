Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B13B5647FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiGCORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiGCORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:17:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C4CCC1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:17:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g7so1995525pfb.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AiyMYj7nYwpq/c8VwgRl9hvpQQsaNas9abyoIGc2aT4=;
        b=AQs99Xvix22RcsCaca5aUgkEFvzLyOaBefzzekPwS44rxFXIwUVysG0T9DFqxEZqOi
         /IgFyVoQGNdMjwLPmgx4lenwfGoUJDBH59G6sKBvpqOP5uts3ZnGpmcF9N0d7QnfOmou
         awXh0cItJzcMWESmTsirGnOLTFkF5dl50kCmA0ks4FYJ+OVV5sRCu7Hg6QNdAGow2spE
         44e+R5fye/fRzlT1rHcZhxQZrvbByJfbxzkJ0TAOIWharek0FjhGHI/tXlxdajw+KapM
         JrlpahNvhvA1+DjRU9EOnKUlOi+qKU7acnekeeEd7BN3hXsKF2okyefdKPlJyAvReRW+
         YL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AiyMYj7nYwpq/c8VwgRl9hvpQQsaNas9abyoIGc2aT4=;
        b=P0thsJE2GR2wB5C3zHf2QUHIugIHTFsJ1a73HNjcuStXYnhK9bUXmD0GVBCX3M1P/F
         8Sm4PIsRJT7vlgIYQAEMfefGNDQAhzOM5nh0/+5EiQ97n9j/pd+quPrdlshnKuNJkvB/
         xJf+O6n60Pio1+Ho1jmXYO6G5xuDNVzKmbZmgQDnxtxf79snM/MRhkOrICDbWyURZdwk
         EyKxd+Qk2REn534XWRlGkZIA972pEv7KX28GxryAIhn5hRflKHgCBa3Nsn8DqauNq1Qq
         VdTtR3VWek9WTzR+gVjTm92cTuT4e8AmnOLNpZNOJbDTKO2d4oNKNELaWigEtJBeliGS
         YAtw==
X-Gm-Message-State: AJIora9sm76UehlvMppnHfoyo/nStxX63Wr35ePNzovkvGfKsiMuwaym
        1+IsU9LQvs0lwcAL206kIfM=
X-Google-Smtp-Source: AGRyM1uYXWzyHPGKcFPOzsJMOBubqKzUQCmu9f2M5naimbwsMlpk4L8Ey2ZM/JM4dNYI1i2/9GIETA==
X-Received: by 2002:a63:6bc1:0:b0:40d:ffa7:9dc3 with SMTP id g184-20020a636bc1000000b0040dffa79dc3mr21365831pgc.111.1656857863297;
        Sun, 03 Jul 2022 07:17:43 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-73-226-155.ap-northeast-1.compute.amazonaws.com. [35.73.226.155])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001678e9670d8sm19197078plv.2.2022.07.03.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 07:17:42 -0700 (PDT)
Date:   Sun, 3 Jul 2022 14:17:37 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v1] mm/slub: enable debugging memory wasting of kmalloc
Message-ID: <YsGlAYujuJSTBLLf@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220701135954.45045-1-feng.tang@intel.com>
 <alpine.DEB.2.22.394.2207011635040.588600@gentwo.de>
 <20220701150451.GA62281@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701150451.GA62281@shbuild999.sh.intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:04:51PM +0800, Feng Tang wrote:
> Hi Christoph,
> 
> On Fri, Jul 01, 2022 at 04:37:00PM +0200, Christoph Lameter wrote:
> > On Fri, 1 Jul 2022, Feng Tang wrote:
> > 
> > >  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> > >  {
> > 
> > It would be good to avoid expanding the basic slab handling functions for
> > kmalloc. Can we restrict the mods to the kmalloc related functions?
> 
> Yes, this is the part that concerned me. I tried but haven't figured
> a way.
> 
> I started implemting it several month ago, and stuck with several
> kmalloc APIs in a hacky way like dump_stack() when there is a waste
> over 1/4 of the object_size of the kmalloc_caches[][].
> 
> Then I found one central API which has all the needed info (object_size &
> orig_size) that we can yell about the waste :
> 
> static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
>                 gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
> 
> which I thought could be still hacky, as the existing 'alloc_traces'
> can't be resued which already has the count/call-stack info. Current
> solution leverage it at the cost of adding 'orig_size' parameters, but
> I don't know how to pass the 'waste' info through as track/location is
> in the lowest level.

If adding cost of orig_size parameter for non-debugging case is concern,
what about doing this in userspace script that makes use of kmalloc
tracepoints?

	kmalloc: call_site=tty_buffer_alloc+0x43/0x90 ptr=00000000b78761e1
	bytes_req=1056 bytes_alloc=2048 gfp_flags=GFP_ATOMIC|__GFP_NOWARN
	accounted=false

calculating sum of (bytes_alloc - bytes_req) for each call_site
may be an alternative solution.

Thanks,
Hyeonggon

> Thanks,
> Feng
> 
> 
> 
