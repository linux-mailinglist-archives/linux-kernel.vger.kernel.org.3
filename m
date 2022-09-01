Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C075A929A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiIAJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiIAJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F29C62
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B25B760F9C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FFDC433D6;
        Thu,  1 Sep 2022 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662022801;
        bh=xQXM+KFCsp7k/cFeMGQmzA/8KQjICiYccwD2baH5vAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGkzXDK4eLH01R383famR2T5c++up4wDcB6+DmIqTFwt+e80P9YxA2xA3r72I9hdx
         KMsRXEZM34Ad1ok/fUpd0wVAthCoaXr1PBGdNqcZ+gxjUIWmXB5CMfhjskwvMCDmEq
         kxmvX77dIagCywHwTbqxeWe7uA86QGxYxF7YvxifD2/bZDPTU5Xld7PaF/uPzWMiXT
         2bu+9HFLz8lpWlT8H4KEB+81hcs/mXjA9IQXJfkrU22OgpfyVjU1Gdg5eDOsYV74rv
         h5Otj8UnNRItqvbSIScZlfEq9Kc+PZuPfDq+iPKEb5zaIYPYtIIPwnlxL06SoxJWxN
         4VQ2x6kVcKkjA==
Date:   Thu, 1 Sep 2022 11:59:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add top-down NUMA tests for
 memblock_alloc_try_nid*
Message-ID: <YxB0fh+YaVMq+AF+@kernel.org>
References: <cover.1661578435.git.remckee0@gmail.com>
 <d46ba668a9f3ba369f3402f107730b9629c01417.1661578435.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46ba668a9f3ba369f3402f107730b9629c01417.1661578435.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:53:00AM -0500, Rebecca Mckeever wrote:
> Add tests for memblock_alloc_try_nid() and memblock_alloc_try_nid_raw()
> where the simulated physical memory is set up with multiple NUMA nodes.
> Additionally, all of these tests set nid != NUMA_NO_NODE. These tests are
> run with a top-down allocation direction.
> 
> The tested scenarios are:
> 
> Range unrestricted:
> - region can be allocated in the specific node requested:
>       + there are no previously reserved regions
>       + the requested node is partially reserved but has enough space
> - the specific node requested cannot accommodate the request, but the
>   region can be allocated in a different node:
>       + there are no previously reserved regions, but node is too small
>       + the requested node is fully reserved
>       + the requested node is partially reserved and does not have
>         enough space
> 
> Range restricted:
> - region can be allocated in the specific node requested after dropping
>   min_addr:
>       + range partially overlaps with two different nodes, where the first
>         node is the requested node
>       + range partially overlaps with two different nodes, where the
>         requested node ends before min_addr
> - region cannot be allocated in the specific node requested, but it can be
>   allocated in the requested range:
>       + range overlaps with multiple nodes along node boundaries, and the
>         requested node ends before min_addr
>       + range overlaps with multiple nodes along node boundaries, and the
>         requested node starts after max_addr
> - region cannot be allocated in the specific node requested, but it can be
>   allocated after dropping min_addr:
>       + range partially overlaps with two different nodes, where the
>         second node is the requested node
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/alloc_nid_api.c | 702 ++++++++++++++++++-
>  tools/testing/memblock/tests/alloc_nid_api.h |  16 +
>  tools/testing/memblock/tests/common.h        |  18 +
>  3 files changed, 725 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 32b3c1594fdd..e5ef93ea1ce5 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -1094,7 +1094,7 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>  	return 0;
>  }
>  
> -/* Test case wrappers */
> +/* Test case wrappers for range tests */
>  static int alloc_try_nid_simple_check(void)
>  {
>  	test_print("\tRunning %s...\n", __func__);
> @@ -1226,17 +1226,10 @@ static int alloc_try_nid_low_max_check(void)
>  	return 0;
>  }
>  
> -static int memblock_alloc_nid_checks_internal(int flags)
> +static int memblock_alloc_nid_range_checks(void)
>  {
> -	const char *func = get_memblock_alloc_try_nid_name(flags);
> -
> -	alloc_nid_test_flags = flags;
> -	prefix_reset();
> -	prefix_push(func);
> -	test_print("Running %s tests...\n", func);
> -
> -	reset_memblock_attributes();
> -	dummy_physical_memory_init();
> +	test_print("Running %s range tests...\n",
> +		   get_memblock_alloc_try_nid_name(alloc_nid_test_flags));
>  
>  	alloc_try_nid_simple_check();
>  	alloc_try_nid_misaligned_check();
> @@ -1253,6 +1246,693 @@ static int memblock_alloc_nid_checks_internal(int flags)
>  	alloc_try_nid_reserved_all_check();
>  	alloc_try_nid_low_max_check();
>  
> +	return 0;
> +}
> +
> +/*
> + * A test that tries to allocate a memory region in a specific NUMA node that
> + * has enough memory to allocate a region of the requested size.
> + * Expect to allocate an aligned region at the end of the requested node.
> + */
> +static int alloc_try_nid_top_down_numa_simple_check(void)
> +{
> +	int nid_req = 3;
> +	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
> +	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
> +	void *allocated_ptr = NULL;
> +
> +	PREFIX_PUSH();
> +
> +	phys_addr_t size;
> +	phys_addr_t min_addr;
> +	phys_addr_t max_addr;
> +
> +	setup_numa_memblock();
> +
> +	ASSERT_LE(SZ_4, req_node->size);
> +	size = req_node->size / SZ_4;
> +	min_addr = memblock_start_of_DRAM();
> +	max_addr = memblock_end_of_DRAM();
> +
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr, nid_req);
> +
> +	ASSERT_NE(allocated_ptr, NULL);
> +	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
> +
> +	ASSERT_EQ(new_rgn->size, size);
> +	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
> +	ASSERT_LE(req_node->base, new_rgn->base);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +/*
> + * A test that tries to allocate a memory region in a specific NUMA node that
> + * does not have enough memory to allocate a region of the requested size:
> + *
> + *  |   +-----+          +------------------+     |
> + *  |   | req |          |     expected     |     |
> + *  +---+-----+----------+------------------+-----+
> + *
> + *  |                             +---------+     |
> + *  |                             |   rgn   |     |
> + *  +-----------------------------+---------+-----+
> + *
> + * Expect to allocate an aligned region at the end of the last node that has
> + * enough memory (in this case, nid = 6) after falling back to NUMA_NO_NODE.
> + */
> +static int alloc_try_nid_top_down_numa_small_node_check(void)
> +{
> +	int nid_req = 1;
> +	int nid_exp = 6;
> +	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
> +	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];

AFAIU, having required and expected nodes here means very tight relation
between the NUMA layout used by setup_numa_memblock() and the test cases. 

I believe it would be clearer and less error prone if the relation were
more explicit. 

Can't say I have a great ideas how to achieve this, but maybe its worth
passing NUMA layout to setup_numa_memblock() every time, or setting the
requested and expected nid based on the NUMA layout, or maybe something
smarted than either of these.

> +	void *allocated_ptr = NULL;
> +
> +	PREFIX_PUSH();
> +
> +	phys_addr_t size;
> +	phys_addr_t min_addr;
> +	phys_addr_t max_addr;
> +
> +	setup_numa_memblock();
> +
> +	size = SZ_2K * MEM_FACTOR;
> +	min_addr = memblock_start_of_DRAM();
> +	max_addr = memblock_end_of_DRAM();
> +
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr, nid_req);
> +
> +	ASSERT_NE(allocated_ptr, NULL);
> +	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
> +
> +	ASSERT_EQ(new_rgn->size, size);
> +	ASSERT_EQ(new_rgn->base, region_end(exp_node) - size);
> +	ASSERT_LE(exp_node->base, new_rgn->base);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +

-- 
Sincerely yours,
Mike.
