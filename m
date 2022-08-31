Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888335A749B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiHaDtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHaDtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:49:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488CBA8CFF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:49:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f4so9974050qkl.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gk0iaSJZd5YzOd+2zJ3o0BDcK8HeEHtmeUyCb8yUhwg=;
        b=QyPzKIVt2x781/58vuUJd2IpLRwDNMhuuv/u/in2ftPzeonWhYG6Lgvb4rxm+lgy7h
         p7+c05xoW4aoU1QQuBsrFW+R0xTD7YyOzdcKc0eo+WcKtOYL4of2yicINzeJdsxTsICb
         c93wO3BOziIlFkfZaV39mlAiZcagm6QYzYHcVcwVOU/rAacNdOG8lA/sCpHRWay8qOpj
         UIE1n5qYGg5ANrt/9yc6EUv0t512o7Wr8HZoCcZVD8onj4D2kIqMMYGh4yWsgEVZd5do
         kU6CUtsTKDcYZLggSiamKsbJlEKbCj1YTkl6CpyM2Cz5DZPw0llUBFDcFZvTMoykmhbn
         3ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gk0iaSJZd5YzOd+2zJ3o0BDcK8HeEHtmeUyCb8yUhwg=;
        b=S7SusnGo7mj1rrTOljYX30hlb73jg0qWrYXxh2W82aSE968ToQ57kJ18wnvr7zwAuo
         Jq5KEoFY9NT2ALvOPnl3fpz3jNhP7blfQkGgfHVgKMpwRJ5yqMh6lrFukd7C9Nj9CkqJ
         S/WJWMFR1y8mVQgzsIwK0Wou9mCDXzEQjGnwqbO+flyKQVGXJAwoegPnfrixCslemmmt
         HOg/tlZNs+S4NcdVB51hYegCGui1mq5mVhpXzrBDLITcjBwMToIfJeZkzBa/joUslzw/
         2i8Mh9A8Yp8ndvs1h/EUXgsatqmeDpsMQRnMvcV8/ye51NbZDz8oWlg49obtsztvSbPg
         Vpcg==
X-Gm-Message-State: ACgBeo0VXQ4A6+YqvPEX6jK810+7DOnLLpgsHfZkAPkWbD42u5KYjeoe
        hNVLQeEx6YYYWVFrxsDi6bt5mPZNajU=
X-Google-Smtp-Source: AA6agR61z5dsBNHuUN1y8570X5NV/YX276IXuHchR3IZ3zRLEhosUC8KLcvp8jOb9LoJeGZxmDYFQg==
X-Received: by 2002:a05:620a:4502:b0:6b4:6c2f:e7b7 with SMTP id t2-20020a05620a450200b006b46c2fe7b7mr14502233qkp.11.1661917751176;
        Tue, 30 Aug 2022 20:49:11 -0700 (PDT)
Received: from sophie ([45.134.140.172])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006b893d135basm9012602qko.86.2022.08.30.20.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:49:10 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:49:09 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <20220831034909.GA16092@sophie>
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
 <329ab669-620c-ba9e-3c57-9cb90d55b942@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329ab669-620c-ba9e-3c57-9cb90d55b942@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:17:56PM +0200, David Hildenbrand wrote:
> On 19.08.22 11:05, Rebecca Mckeever wrote:
> > Add functions setup_numa_memblock_generic() and setup_numa_memblock()
> > for setting up a memory layout with multiple NUMA nodes in a previously
> > allocated dummy physical memory. These functions can be used in place of
> > setup_memblock() in tests that need to simulate a NUMA system.
> > 
> > setup_numa_memblock_generic():
> > - allows for setting up a custom memory layout by specifying the amount
> >   of memory in each node, the number of nodes, and a factor that will be
> >   used to scale the memory in each node
> > 
> > setup_numa_memblock():
> > - allows for setting up a default memory layout
> > 
> > Introduce constant MEM_FACTOR, which is used to scale the default memory
> > layout based on MEM_SIZE.
> > 
> > Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> > 16 NUMA nodes.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  .../testing/memblock/scripts/Makefile.include |  2 +-
> >  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
> >  tools/testing/memblock/tests/common.h         |  9 ++++-
> >  3 files changed, 47 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> > index aa6d82d56a23..998281723590 100644
> > --- a/tools/testing/memblock/scripts/Makefile.include
> > +++ b/tools/testing/memblock/scripts/Makefile.include
> > @@ -3,7 +3,7 @@
> >  
> >  # Simulate CONFIG_NUMA=y
> >  ifeq ($(NUMA), 1)
> > -	CFLAGS += -D CONFIG_NUMA
> > +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
> >  endif
> >  
> >  # Use 32 bit physical addresses.
> > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > index eec6901081af..15d8767dc70c 100644
> > --- a/tools/testing/memblock/tests/common.c
> > +++ b/tools/testing/memblock/tests/common.c
> > @@ -34,6 +34,10 @@ static const char * const help_opts[] = {
> >  
> >  static int verbose;
> >  
> > +static const phys_addr_t node_sizes[] = {
> > +	SZ_4K, SZ_1K, SZ_2K, SZ_2K, SZ_1K, SZ_1K, SZ_4K, SZ_1K
> > +};
> > +
> >  /* sets global variable returned by movable_node_is_enabled() stub */
> >  bool movable_node_enabled;
> >  
> > @@ -72,6 +76,40 @@ void setup_memblock(void)
> >  	fill_memblock();
> >  }
> >  
> > +/**
> > + * setup_numa_memblock_generic:
> > + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> > + * dummy physical memory.
> > + * @nodes: an array containing the amount of memory in each node
> > + * @node_cnt: the size of @nodes
> > + * @factor: a factor that will be used to scale the memory in each node
> > + *
> > + * The nids will be set to 0 through node_cnt - 1.
> > + */
> > +void setup_numa_memblock_generic(const phys_addr_t nodes[],
> > +				 int node_cnt, int factor)
> > +{
> > +	phys_addr_t base;
> > +	int flags;
> > +
> > +	reset_memblock_regions();
> > +	base = (phys_addr_t)memory_block.base;
> > +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> > +
> > +	for (int i = 0; i < node_cnt; i++) {
> > +		phys_addr_t size = factor * nodes[i];
> 
> I'm a bit lost why we need the factor if we already provide sizes in the
> array.
> 
> Can you enlighten me? :)
> 
> Why can't we just stick to the sizes in the array?
> 
Without the factor, some of the tests will break if we increase MEM_SIZE
in the future (which we may need to do). I could rewrite them so that the
factor is not needed, but I thought the code would be over-complicated if
I did.

> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
