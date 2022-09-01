Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235265A917E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiIAIC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiIAICy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:02:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92045121428
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21A52B81619
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F50CC433C1;
        Thu,  1 Sep 2022 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662019369;
        bh=8TSBzYjw7mSc7yWeMsk9HL6g+Ac5v57wecczsgyg+qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epZq/1X4bSwAzF/qwZ8C4CqMUZbqFRmrTLuY768JGLsmXCmnyRZM4vtqsHFvcKruH
         bkox3CNkp1Au1KWz/snYmhEBBAmcUcX0e6lJn7f91Kbr7WFCKCmccGnp64m5W2+Hit
         NYxCN11xcNzrtW0ESG38zfUSvEOAPPCi60fxI7hRme+OLbFAMjw5/vkjtKD4j1xxm0
         qLSGO/6qYw+eMmENTZI01uncrkL+zznKjHdWo+vx979Tv/0ps045VSu+4KYnyaGKGe
         VScwdUa9MJS+ZMran7Q/fX2T4WFp2TInm0RBl7bJ85Wr7LqbaGnunrnxYoaOrtGJBK
         oUosqd7IB5d9g==
Date:   Thu, 1 Sep 2022 11:02:35 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     shaoqin.huang@intel.com
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] memblock test: Add test to memblock_add() 129th
 region
Message-ID: <YxBnG4xYh/eIJ/ZT@kernel.org>
References: <20220830014925.162718-1-shaoqin.huang@intel.com>
 <20220830014925.162718-2-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830014925.162718-2-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:49:17AM +0800, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> Add 129th region into the memblock, and this will trigger the
> memblock_double_array() function, this needs valid memory regions. So
> using dummy_physical_memory_init() to allocate a valid memory region, and
> fake the other memory region, so it make sure the memblock_double_array()
> will always choose the valid memory region that is allocated by the
> dummy_physical_memory_init(). So memblock_double_array() must success.
> 
> Another thing should be done is to restore the memory.regions after
> memblock_double_array(), due to now the memory.regions is pointing to a
> memory region allocated by dummy_physical_memory_init(). And it will
> affect the subsequent tests if we don't restore the memory region. So
> simply record the origin region, and restore it after the test.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>  tools/testing/memblock/tests/basic_api.c | 82 ++++++++++++++++++++++++
>  tools/testing/memblock/tests/common.c    |  7 +-
>  tools/testing/memblock/tests/common.h    |  3 +
>  3 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index 66f46f261e66..c8e201156cdc 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -326,6 +326,87 @@ static int memblock_add_twice_check(void)
>  	return 0;
>  }
>  
> +/*
> + * A test that tries to add the 129th memory block.
> + * Expect to trigger memblock_double_array() to double the
> + * memblock.memory.max, find a new valid memory as
> + * memory.regions.
> + */
> +static int memblock_add_many_check(void)
> +{
> +	int i;
> +	void *orig_region;
> +	struct region r = {
> +		.base = SZ_16K,
> +		.size = MEM_SIZE,
> +	};
> +	phys_addr_t memory_base = SZ_128K;
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_allow_resize();
> +
> +	/*
> +	 * Add one valid memory region, this will be choosed to be the memory
> +	 * that new memory.regions occupied.
> +	 */
> +	dummy_physical_memory_init();
> +	memblock_add((phys_addr_t)get_memory_block_base(), MEM_SIZE);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, MEM_SIZE);
> +
> +	for (i = 1; i < INIT_MEMBLOCK_REGIONS; i++) {
> +		/* Add some fakes memory region to fulfill the memblock. */
> +		memblock_add(memory_base, MEM_SIZE);

I would rather prefer to memblock_add() ranges from the simulated memory
created in dummy_physical_memory_init(). 16K will be probably too small,
but I don't see problem with increasing MEM_SIZE.

> +
> +		ASSERT_EQ(memblock.memory.cnt, i + 1);
> +		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
> +
> +		/* Keep the gap so these memory region will not be merged. */
> +		memory_base += MEM_SIZE * 2;
> +	}
> +
> +	orig_region = memblock.memory.regions;
> +
> +	/* This adds the 129 memory_region, and makes it double array. */
> +	memblock_add((phys_addr_t)memory_base, MEM_SIZE);

memory_base is already phys_addr_t, isn't it?

> +
> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	/* This is the size used by new memory.regions. Check it. */
> +	ASSERT_EQ(memblock.reserved.total_size, PAGE_ALIGN(INIT_MEMBLOCK_REGIONS * 2 *
> +						sizeof(struct memblock_region)));
> +

Can you please elaborate what does the following sequence test?

> +	/* The base is very small, so it should be insert to the first region. */
> +	memblock_add(r.base, r.size);
> +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
> +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> +
> +	dummy_physical_memory_cleanup();
> +
> +	/*
> +	 * The current memory.regions is occupying a range of memory that
> +	 * allocated from dummy_physical_memory_init(). After free the memory,
> +	 * we must not use it. So restore the origin memory region to make sure
> +	 * the tests can run as normal and not affected by the double array.
> +	 */
> +	memblock.memory.regions = orig_region;
> +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>  static int memblock_add_checks(void)
>  {
>  	prefix_reset();
> @@ -339,6 +420,7 @@ static int memblock_add_checks(void)
>  	memblock_add_overlap_bottom_check();
>  	memblock_add_within_check();
>  	memblock_add_twice_check();
> +	memblock_add_many_check();
>  
>  	prefix_pop();
>  
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index 76a8ad818f3a..96fabd96ff31 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -5,8 +5,6 @@
>  #include <linux/memory_hotplug.h>
>  #include <linux/build_bug.h>
>  
> -#define INIT_MEMBLOCK_REGIONS			128
> -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>  #define PREFIXES_MAX				15
>  #define DELIM					": "
>  
> @@ -77,6 +75,11 @@ void dummy_physical_memory_cleanup(void)
>  	free(memory_block.base);
>  }
>  
> +void *get_memory_block_base(void)
> +{
> +	return memory_block.base;
> +}
> +
>  static void usage(const char *prog)
>  {
>  	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index d396e5423a8e..d56af621c543 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -11,6 +11,8 @@
>  #include <../selftests/kselftest.h>
>  
>  #define MEM_SIZE SZ_16K
> +#define INIT_MEMBLOCK_REGIONS			128
> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>  
>  /**
>   * ASSERT_EQ():
> @@ -73,6 +75,7 @@ void reset_memblock_attributes(void);
>  void setup_memblock(void);
>  void dummy_physical_memory_init(void);
>  void dummy_physical_memory_cleanup(void);
> +void *get_memory_block_base(void);

Let's make it 

phys_addr_t dummy_physical_memory_base(void);

>  void parse_args(int argc, char **argv);
>  
>  void test_fail(void);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
