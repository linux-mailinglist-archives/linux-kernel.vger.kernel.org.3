Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8F5A8101
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiHaPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEBD7C194
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F38DF61052
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED7BC433D6;
        Wed, 31 Aug 2022 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661958955;
        bh=R7EXO46M5qFjicJi09WHTFPA6AYwOQpIYMdt1O//+is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7d+iH2Jp76tnUZZGZp3y/mCdP/BiWmflvKS3gpSbmCixTlU6JB5bqnoGhzIxyidD
         9V+fTsZPtR/2ToNv8QUi3bkRbT4wVlJwvcv0H1qv0on/gTLgc+bsxtgRFt6DDUuGQ8
         W3b3Ir2JGMVSACG/ClcYLL62Kz0xh1hfY9CPKAMvKr6iPJBUqpZXEvGbuTWN1JbWq2
         roanbd7pZkUtIoa3+37iP0a14uunDZQ876Zw97wa/R6aqeR2lfTRIhSrQJArL/BnxN
         DVPNKl2jIifkZMmYEyAfxuoFbCqmwFtP7nYNRcO/MQZRHUxa3fp7ZFzrJcl5Avuat8
         Lqy3xEUurPBtw==
Date:   Wed, 31 Aug 2022 18:15:41 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <Yw97HVSRW4+pkemb@kernel.org>
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 02:05:31AM -0700, Rebecca Mckeever wrote:
> Add functions setup_numa_memblock_generic() and setup_numa_memblock()
> for setting up a memory layout with multiple NUMA nodes in a previously
> allocated dummy physical memory. These functions can be used in place of
> setup_memblock() in tests that need to simulate a NUMA system.
> 
> setup_numa_memblock_generic():
> - allows for setting up a custom memory layout by specifying the amount
>   of memory in each node, the number of nodes, and a factor that will be
>   used to scale the memory in each node
> 
> setup_numa_memblock():
> - allows for setting up a default memory layout
> 
> Introduce constant MEM_FACTOR, which is used to scale the default memory
> layout based on MEM_SIZE.
> 
> Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> 16 NUMA nodes.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  .../testing/memblock/scripts/Makefile.include |  2 +-
>  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
>  tools/testing/memblock/tests/common.h         |  9 ++++-
>  3 files changed, 47 insertions(+), 2 deletions(-)

...
  
> +/**
> + * setup_numa_memblock_generic:
> + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> + * dummy physical memory.
> + * @nodes: an array containing the amount of memory in each node
> + * @node_cnt: the size of @nodes
> + * @factor: a factor that will be used to scale the memory in each node
> + *
> + * The nids will be set to 0 through node_cnt - 1.
> + */
> +void setup_numa_memblock_generic(const phys_addr_t nodes[],
> +				 int node_cnt, int factor)

I only had time for a quick look and it seems this function is never used
on its own.
Let's fold it into setup_numa_memblock() for now.

> +{
> +	phys_addr_t base;
> +	int flags;
> +
> +	reset_memblock_regions();
> +	base = (phys_addr_t)memory_block.base;
> +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> +
> +	for (int i = 0; i < node_cnt; i++) {
> +		phys_addr_t size = factor * nodes[i];
> +
> +		memblock_add_node(base, size, i, flags);
> +		base += size;
> +	}
> +	fill_memblock();
> +}
> +
> +void setup_numa_memblock(void)
> +{
> +	setup_numa_memblock_generic(node_sizes, NUMA_NODES, MEM_FACTOR);
> +}
> +

-- 
Sincerely yours,
Mike.
