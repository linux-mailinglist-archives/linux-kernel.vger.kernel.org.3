Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A845A80F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiHaPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiHaPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:12:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4A7D5DD8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A939B81FA0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4E2C433C1;
        Wed, 31 Aug 2022 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661958746;
        bh=LN5ft900VWcZqbmOX1GAJNvSpMmYcn2WjpWnuStpoSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDmEfym11ZKNej3wZ6h1qUB+Mq8zW3YIH3w7dqMB7ehFABHcEG+IDKG+0UMFqGMNw
         br5L75qpluKqzbUqVcAc65WA8SgJF1+zQeyljTHkA7SmWQ+Ax3r0FD70LUUmKX7CHH
         sC2vM656DB9mIQsIaSqb+8HzZjEkGxkc/A7MgnI5hSqtYST6kVnXowTZ3hNjGVhQ1B
         N3AWZghne/xW12qPVwbNr+YWtlVmBZ0DHGD2yVDuJydEwdm1m51zoi//uko3p4Vt6I
         +Dm16SYMUAtWnTGirGGqyVTEzKsnFn7ZC8xx+hpNopaRa04/54T1yPlPwM6+5wgVVn
         wXbVoBlnMexgQ==
Date:   Wed, 31 Aug 2022 18:12:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <Yw96SgMopn3SrWS7@kernel.org>
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
 <329ab669-620c-ba9e-3c57-9cb90d55b942@redhat.com>
 <20220831034909.GA16092@sophie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831034909.GA16092@sophie>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:49:09PM -0500, Rebecca Mckeever wrote:
> On Tue, Aug 30, 2022 at 01:17:56PM +0200, David Hildenbrand wrote:
> > On 19.08.22 11:05, Rebecca Mckeever wrote:
> > > Add functions setup_numa_memblock_generic() and setup_numa_memblock()
> > > for setting up a memory layout with multiple NUMA nodes in a previously
> > > allocated dummy physical memory. These functions can be used in place of
> > > setup_memblock() in tests that need to simulate a NUMA system.
> > > 
> > > setup_numa_memblock_generic():
> > > - allows for setting up a custom memory layout by specifying the amount
> > >   of memory in each node, the number of nodes, and a factor that will be
> > >   used to scale the memory in each node
> > > 
> > > setup_numa_memblock():
> > > - allows for setting up a default memory layout
> > > 
> > > Introduce constant MEM_FACTOR, which is used to scale the default memory
> > > layout based on MEM_SIZE.
> > > 
> > > Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> > > 16 NUMA nodes.
> > > 
> > > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > > ---
> > >  .../testing/memblock/scripts/Makefile.include |  2 +-
> > >  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
> > >  tools/testing/memblock/tests/common.h         |  9 ++++-
> > >  3 files changed, 47 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> > > index aa6d82d56a23..998281723590 100644
> > > --- a/tools/testing/memblock/scripts/Makefile.include
> > > +++ b/tools/testing/memblock/scripts/Makefile.include
> > > @@ -3,7 +3,7 @@
> > >  
> > >  # Simulate CONFIG_NUMA=y
> > >  ifeq ($(NUMA), 1)
> > > -	CFLAGS += -D CONFIG_NUMA
> > > +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
> > >  endif
> > >  
> > >  # Use 32 bit physical addresses.
> > > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > > index eec6901081af..15d8767dc70c 100644
> > > --- a/tools/testing/memblock/tests/common.c
> > > +++ b/tools/testing/memblock/tests/common.c
> > > @@ -34,6 +34,10 @@ static const char * const help_opts[] = {
> > >  
> > >  static int verbose;
> > >  
> > > +static const phys_addr_t node_sizes[] = {
> > > +	SZ_4K, SZ_1K, SZ_2K, SZ_2K, SZ_1K, SZ_1K, SZ_4K, SZ_1K
> > > +};
> > > +
> > >  /* sets global variable returned by movable_node_is_enabled() stub */
> > >  bool movable_node_enabled;
> > >  
> > > @@ -72,6 +76,40 @@ void setup_memblock(void)
> > >  	fill_memblock();
> > >  }
> > >  
> > > +/**
> > > + * setup_numa_memblock_generic:
> > > + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> > > + * dummy physical memory.
> > > + * @nodes: an array containing the amount of memory in each node
> > > + * @node_cnt: the size of @nodes
> > > + * @factor: a factor that will be used to scale the memory in each node
> > > + *
> > > + * The nids will be set to 0 through node_cnt - 1.
> > > + */
> > > +void setup_numa_memblock_generic(const phys_addr_t nodes[],
> > > +				 int node_cnt, int factor)
> > > +{
> > > +	phys_addr_t base;
> > > +	int flags;
> > > +
> > > +	reset_memblock_regions();
> > > +	base = (phys_addr_t)memory_block.base;
> > > +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> > > +
> > > +	for (int i = 0; i < node_cnt; i++) {
> > > +		phys_addr_t size = factor * nodes[i];
> > 
> > I'm a bit lost why we need the factor if we already provide sizes in the
> > array.
> > 
> > Can you enlighten me? :)
> > 
> > Why can't we just stick to the sizes in the array?
> > 
> Without the factor, some of the tests will break if we increase MEM_SIZE
> in the future (which we may need to do). I could rewrite them so that the
> factor is not needed, but I thought the code would be over-complicated if
> I did.

What if we make nodes[] to represent the fraction of the memory rather than
a node size? Then the factor won't be required.

> Thanks,
> Rebecca

-- 
Sincerely yours,
Mike.
