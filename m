Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AD5AE8E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiIFM5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIFM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:57:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510E2638
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29C0BB80D7B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73A1C433D7;
        Tue,  6 Sep 2022 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662469048;
        bh=3nr1jQQRLOI5p0ClY1E3xRU8sx1MSZyyig/SAXrzoL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhfdkCzJl+khEuyyXzJQ02OJGmKzhU2St1n1WI1kuu02iDdjmHAaWvILnclUohaFj
         BTs55OL5DDCc3yHAb5ln5rhi4qB4Ek+jKirnTSHrcc6RMo/h8fQUKH/EQ6D2TiLTKv
         r2mLY7wPX0ifm3p7xQj7IQFnOWKtJ4HCRh0jaSNtQMQ3UD8tMjSor15OQMluCI1vxg
         OJgIxYt2gAqN9AXHx+YHMImFPpm7vJ9deph/cv7KA6tH5HjBenPuZqCBtelVGfs0BO
         qQraxqPIvWFS8gwZiRF2Jq+LBbUUDlKojp2g4ZpSQAXDOdHOqZuoIMadoyBgilzmAo
         XMJx8y5eAg72Q==
Date:   Tue, 6 Sep 2022 15:57:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     shaoqin.huang@intel.com
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] memblock test: Add test to memblock_add() 129th
 region
Message-ID: <YxdDqZgSjBKjcvYE@kernel.org>
References: <20220902024007.58041-1-shaoqin.huang@intel.com>
 <20220902024007.58041-2-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902024007.58041-2-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:39:59AM +0800, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> Add 129th region into the memblock, and this will trigger the
> memblock_double_array() function, this needs valid memory regions. So
> using dummy_physical_memory_init() to allocate some valid memory region,
> and add it into the memblock. It make sure the memblock_double_array()
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
>  tools/testing/memblock/tests/basic_api.c | 91 ++++++++++++++++++++++++
>  tools/testing/memblock/tests/common.c    | 15 +++-
>  tools/testing/memblock/tests/common.h    |  4 ++
>  3 files changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index a13a57ba0815..b9877344d3a1 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -423,6 +423,96 @@ static int memblock_add_near_max_check(void)
>  	return 0;
>  }
>  
> +/*
> + * A test that trying to add the 129th memory block.
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
> +	/* Record these allocated memory, they will be free at the end. */
> +	phys_addr_t base[INIT_MEMBLOCK_REGIONS + 1];
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_allow_resize();
> +
> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
> +		/* Add some memory region to fulfill the memblock. */
> +		dummy_physical_memory_init();
> +		base[i] = dummy_physical_memory_base();
> +		memblock_add(base[i], MEM_SIZE);

Looks like we are going in rounds.
The simulated physical memory is what dummy_physical_memory_init()
allocates. Every memblock_add() may take a range from that "physical
memory" and register it with memblock. There is no need to allocate new
chunk for every memblock_add(), just make sure that
dummy_physical_memory_init() allocates enough memory.

> +
> +		ASSERT_EQ(memblock.memory.cnt, i + 1);
> +		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
> +	}
> +
> +	orig_region = memblock.memory.regions;
> +
> +	/*
> +	 * This adds the 129 memory_region, and makes it double array. Now
> +	 * MEM_SIZE is 16K, which is enough, the doubled array will occupy 8K
> +	 * memory region, so it must success.
> +	 */
> +	dummy_physical_memory_init();
> +	base[i] = dummy_physical_memory_base();
> +	memblock_add(base[i], MEM_SIZE);
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
> +	/*
> +	 * After double array, we want to make sure the memblock.memory.regions
> +	 * is actually on a valid memory, so we try to add a memory region which

What do you mean by "actually on a valid memory"? How would
memblock_double_array() succeed otherwise?

> +	 * the base is very small, it should be insert to the first region. And
> +	 * the memory.cnt and memory.total_size will both be changed.
> +	 * Let's check it.
> +	 */
> +	memblock_add(r.base, r.size);
> +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
> +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> +
> +	/*
> +	 * Due to we dummy_physical_memory_init() many memory region in this
> +	 * test, we need to free it. Instead of expose the memory_block and
> +	 * directly modify it's base, we pass an array which record all the
> +	 * memory base that we allocated to this function, and let it to do the
> +	 * clean job.
> +	 */
> +	dummy_physical_memory_cleanup_many(base, INIT_MEMBLOCK_REGIONS + 1);
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
> @@ -438,6 +528,7 @@ static int memblock_add_checks(void)
>  	memblock_add_twice_check();
>  	memblock_add_between_check();
>  	memblock_add_near_max_check();
> +	memblock_add_many_check();
>  
>  	prefix_pop();
>  
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index eec6901081af..1fb347c5c099 100644
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
> @@ -84,6 +82,19 @@ void dummy_physical_memory_cleanup(void)
>  	free(memory_block.base);
>  }
>  
> +void dummy_physical_memory_cleanup_many(phys_addr_t *base, int cnt)
> +{
> +	for (int i = 0; i < cnt; i++) {
> +		memory_block.base = (void *)base[i];
> +		dummy_physical_memory_cleanup();
> +	}
> +}
> +
> +phys_addr_t dummy_physical_memory_base(void)
> +{
> +	return (phys_addr_t)memory_block.base;
> +}
> +
>  static void usage(const char *prog)
>  {
>  	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index 78128e109a95..310f0be2b2a2 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -11,6 +11,8 @@
>  #include <../selftests/kselftest.h>
>  
>  #define MEM_SIZE SZ_16K
> +#define INIT_MEMBLOCK_REGIONS			128
> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>  
>  enum test_flags {
>  	/* No special request. */
> @@ -104,6 +106,8 @@ void reset_memblock_attributes(void);
>  void setup_memblock(void);
>  void dummy_physical_memory_init(void);
>  void dummy_physical_memory_cleanup(void);
> +void dummy_physical_memory_cleanup_many(phys_addr_t *base, int cnt);
> +phys_addr_t dummy_physical_memory_base(void);
>  void parse_args(int argc, char **argv);
>  
>  void test_fail(void);
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
