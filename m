Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9495AA354
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiIAWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiIAWxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:53:36 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA46760DA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:53:35 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-11eb44f520dso802355fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+ZQPG1GSM+Nn3h6KB6a2OhCHkqSdeVgCoGOQme1CXs4=;
        b=hK07d2O4pVl/l8Nf6xl55zgmm4/jxAJzG5Ye8/nf0IMBj3q0g0244nJGRCjWH5L1Hv
         0MTo+x0IdztSW3JQXw4LQO0R7IOqhEUwNFZKWGICp7HxXfruPgZVZ+HTeKn5D3dWwxYB
         vTTKWpfbw70wudjbmbjiCnVtLM5aPZsTMrY++mQ++M4KmMHk12h322d2EPz7mWuYePMH
         Bq4RM5OJrC4audEyz9p0KULUZERK9wCipMewwGBko5Lkm6evXlHwQQOL9OMNCOkOnxaH
         VnEpeHUPbqdhuur/BXXvM3G6rx9JEHKJK2Ucl7THv3Xmo6WQdwxaE3YIR50MTrYb4r0k
         Csag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+ZQPG1GSM+Nn3h6KB6a2OhCHkqSdeVgCoGOQme1CXs4=;
        b=j9uV8H4q7IYXqSQYIw+4CV0AMDFM9MrKAhlcudkrIpmTyd1rA5NyGbyqkk5paQsjC9
         PESrbv9cP7/21euCaf/Wa6ukpi7TfN48VwrXp/X+gr+Jd8kbX6dj7cAw2iIucEWoFxkq
         ZTUBM60kMMXIkMz0khWWbE2CCzYUGzMRVZTCz2zv07l8RnA4XZDu6a/sfMkBcT4jlMaW
         DS+07d16DSoUYfuF/S+36aAp/0zFyCui7sebjBeNEYyaCogCiMe+Efg3gQO8PVljJ6Gb
         H5XPf9JxwuF5pRRbV8fmQB1sNLjtTEt2uvHXR1UnIri+W3NSQSIwS2vgOL+8V0euztdf
         wf+Q==
X-Gm-Message-State: ACgBeo0E7VJbKDcrg11OcmYkn8ct8N+bvYBkINrpWNh3xXq9qFu12QTo
        DHobtxEhPIVFIYxQBFuqgk3JY+bkrqE=
X-Google-Smtp-Source: AA6agR6Dkqc+qHDNAoVTIoKGh4lRvx5pxpl71iU8moUMeBKZcbDIE0txx51n0LOgp44cg0XI/Az3xw==
X-Received: by 2002:a05:6870:f229:b0:114:25db:4000 with SMTP id t41-20020a056870f22900b0011425db4000mr792265oao.246.1662072814842;
        Thu, 01 Sep 2022 15:53:34 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id 188-20020a4a1dc5000000b0044565e7ab41sm125589oog.32.2022.09.01.15.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:53:34 -0700 (PDT)
Date:   Thu, 1 Sep 2022 17:53:32 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <20220901225332.GA17689@sophie>
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
 <329ab669-620c-ba9e-3c57-9cb90d55b942@redhat.com>
 <20220831034909.GA16092@sophie>
 <Yw96SgMopn3SrWS7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw96SgMopn3SrWS7@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 06:12:10PM +0300, Mike Rapoport wrote:
> On Tue, Aug 30, 2022 at 10:49:09PM -0500, Rebecca Mckeever wrote:
> > On Tue, Aug 30, 2022 at 01:17:56PM +0200, David Hildenbrand wrote:
> > > On 19.08.22 11:05, Rebecca Mckeever wrote:
> > > > Add functions setup_numa_memblock_generic() and setup_numa_memblock()
> > > > for setting up a memory layout with multiple NUMA nodes in a previously
> > > > allocated dummy physical memory. These functions can be used in place of
> > > > setup_memblock() in tests that need to simulate a NUMA system.
> > > > 
> > > > setup_numa_memblock_generic():
> > > > - allows for setting up a custom memory layout by specifying the amount
> > > >   of memory in each node, the number of nodes, and a factor that will be
> > > >   used to scale the memory in each node
> > > > 
> > > > setup_numa_memblock():
> > > > - allows for setting up a default memory layout
> > > > 
> > > > Introduce constant MEM_FACTOR, which is used to scale the default memory
> > > > layout based on MEM_SIZE.
> > > > 
> > > > Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> > > > 16 NUMA nodes.
> > > > 
> > > > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > > > ---
> > > >  .../testing/memblock/scripts/Makefile.include |  2 +-
> > > >  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
> > > >  tools/testing/memblock/tests/common.h         |  9 ++++-
> > > >  3 files changed, 47 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> > > > index aa6d82d56a23..998281723590 100644
> > > > --- a/tools/testing/memblock/scripts/Makefile.include
> > > > +++ b/tools/testing/memblock/scripts/Makefile.include
> > > > @@ -3,7 +3,7 @@
> > > >  
> > > >  # Simulate CONFIG_NUMA=y
> > > >  ifeq ($(NUMA), 1)
> > > > -	CFLAGS += -D CONFIG_NUMA
> > > > +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
> > > >  endif
> > > >  
> > > >  # Use 32 bit physical addresses.
> > > > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > > > index eec6901081af..15d8767dc70c 100644
> > > > --- a/tools/testing/memblock/tests/common.c
> > > > +++ b/tools/testing/memblock/tests/common.c
> > > > @@ -34,6 +34,10 @@ static const char * const help_opts[] = {
> > > >  
> > > >  static int verbose;
> > > >  
> > > > +static const phys_addr_t node_sizes[] = {
> > > > +	SZ_4K, SZ_1K, SZ_2K, SZ_2K, SZ_1K, SZ_1K, SZ_4K, SZ_1K
> > > > +};
> > > > +
> > > >  /* sets global variable returned by movable_node_is_enabled() stub */
> > > >  bool movable_node_enabled;
> > > >  
> > > > @@ -72,6 +76,40 @@ void setup_memblock(void)
> > > >  	fill_memblock();
> > > >  }
> > > >  
> > > > +/**
> > > > + * setup_numa_memblock_generic:
> > > > + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> > > > + * dummy physical memory.
> > > > + * @nodes: an array containing the amount of memory in each node
> > > > + * @node_cnt: the size of @nodes
> > > > + * @factor: a factor that will be used to scale the memory in each node
> > > > + *
> > > > + * The nids will be set to 0 through node_cnt - 1.
> > > > + */
> > > > +void setup_numa_memblock_generic(const phys_addr_t nodes[],
> > > > +				 int node_cnt, int factor)
> > > > +{
> > > > +	phys_addr_t base;
> > > > +	int flags;
> > > > +
> > > > +	reset_memblock_regions();
> > > > +	base = (phys_addr_t)memory_block.base;
> > > > +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> > > > +
> > > > +	for (int i = 0; i < node_cnt; i++) {
> > > > +		phys_addr_t size = factor * nodes[i];
> > > 
> > > I'm a bit lost why we need the factor if we already provide sizes in the
> > > array.
> > > 
> > > Can you enlighten me? :)
> > > 
> > > Why can't we just stick to the sizes in the array?
> > > 
> > Without the factor, some of the tests will break if we increase MEM_SIZE
> > in the future (which we may need to do). I could rewrite them so that the
> > factor is not needed, but I thought the code would be over-complicated if
> > I did.
> 
> What if we make nodes[] to represent the fraction of the memory rather than
> a node size? Then the factor won't be required.
> 
I think that will work. I'll try it.

> > Thanks,
> > Rebecca
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Rebecca
