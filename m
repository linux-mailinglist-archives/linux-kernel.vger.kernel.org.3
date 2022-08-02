Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69D5877A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiHBHPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiHBHPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:15:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55693B944
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB1E6B8188A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FBFC433D6;
        Tue,  2 Aug 2022 07:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659424537;
        bh=OU7TGxK68vWv69y0xszAk63+oYqYivbkurLi5vKI8cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p83QkmjC4ZQZkA01ck97y9rqOZvhlDghckiMuN8M/OI+xpgEma8PuxR2UofjCDu+3
         XWE6jvnf3DSKOVqRilDj3rE4MBaxEdh68WxeBsEW5Bw5JNpZ6Pg+7CVVzWI/W/0fXZ
         a4ZTht5McBmrNY+PGtx40hIvYKt8CVtlwiS0OvZIPEanWCt5TxAwdiB4HmLZAw4V1T
         DO88B1M8XZLcc2feUJrK+MpidqdL6J2Up3QgUUJoiWwcCuRcQheOLRac7a7B0M0vM6
         NYrtx9KsaROennEEqeLtPB48UrpKv8+EHsBpb2gNxvWNgIUtL5PI0HDtvFaZGxv8HE
         Ip7P3qio7MfZw==
Date:   Tue, 2 Aug 2022 10:15:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     shaoqin.huang@intel.com
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock test: Add test to memblock_add() 129th region
Message-ID: <YujPDHym0Ly8sxqP@kernel.org>
References: <20220801064901.980558-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801064901.980558-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 02:48:36PM +0800, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> Add 129th region into the memblock, and this will trigger the
> memblock_double_array() function, this needs valid memory regions. So
> using dummy_physical_memory_init() to allocate some valid memory, when
> memblock_double_array() choose a new memory region from memory.regions,
> it will always choose a valid memory region if we add all valid memory
> region, so the memblock_double_array() must success.
> 
> Another thing should be done is to restore the memory.regions after
> memblock_double_array(), due to now the memory.regions is pointing to a
> memory region allocated by dummy_physical_memory_init(). And it will
> affect the subsequent tests if we don't restore the memory region. So
> Simply record the origin region, and restore it after the test.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
> Changelog:
> ----------
> v2:
>   - Use ASSERT_EQ() to replace assert().
>   - Not to expose memory_block, and add a function get_memory_block_base() to
>   get the memory_block.base.
>   - Add two functions for common usage, and now it has been used by this patch
>   to allocate many valid memory regions and free them at the end.
> 
>  tools/testing/memblock/tests/basic_api.c | 54 ++++++++++++++++++++++++
>  tools/testing/memblock/tests/common.c    | 38 +++++++++++++++--
>  tools/testing/memblock/tests/common.h    |  6 +++
>  3 files changed, 95 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index 66f46f261e66..46948d5a975e 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -326,6 +326,59 @@ static int memblock_add_twice_check(void)
>  	return 0;
>  }
>  
> +static int memblock_add_many_check(void)
> +{
> +	void *base[INIT_MEMBLOCK_REGIONS + 1];
> +	void *orig_region;
> +	struct region r = {
> +		.base = SZ_16K,
> +		.size = MEM_SIZE,
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_allow_resize();
> +
> +	dummy_physical_memory_many_init(base, INIT_MEMBLOCK_REGIONS);

Why do we need this?

dummy_physical_memory_init() allocates the "physical" memory, so to trigger
memblock_double_array() it's enough to memblock_add() 129 non-intersecting
chunks in the range [memory_block.base, memory_block.base + MEM_SIZE].
If MEM_SIZE of 16k won't be enough, it can be increased.

> +
> +	orig_region = memblock.memory.regions;
> +
> +	/* This adds the 129 memory_region, and makes it double array. */
> +	dummy_physical_memory_init();
> +	append_memblock();
> +	base[INIT_MEMBLOCK_REGIONS] = get_memory_block_base();
> +
> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> +
> +	/* The base is very small, so it should be insert to the first region. */
> +	memblock_add(r.base, r.size);
> +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
> +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
> +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> +
> +	/* Free these allocated memory. */
> +	dummy_physical_memory_many_cleanup(base, INIT_MEMBLOCK_REGIONS + 1);
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
> @@ -339,6 +392,7 @@ static int memblock_add_checks(void)
>  	memblock_add_overlap_bottom_check();
>  	memblock_add_within_check();
>  	memblock_add_twice_check();
> +	memblock_add_many_check();
>  
>  	prefix_pop();
>  
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index e43b2676af81..960b3ce07696 100644
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
> @@ -58,10 +56,20 @@ void reset_memblock_attributes(void)
>  	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
>  }
>  
> +void *get_memory_block_base(void)
> +{
> +	return memory_block.base;
> +}
> +
> +void append_memblock(void)
> +{
> +	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
> +}
> +
>  void setup_memblock(void)
>  {
>  	reset_memblock_regions();
> -	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
> +	append_memblock();
>  }
>  
>  void dummy_physical_memory_init(void)
> @@ -75,6 +83,30 @@ void dummy_physical_memory_cleanup(void)
>  	free(memory_block.base);
>  }
>  
> +void dummy_physical_memory_many_init(void *base[], int cnt)
> +{
> +	int i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		dummy_physical_memory_init();
> +		append_memblock();
> +		base[i] = memory_block.base;
> +
> +		ASSERT_EQ(memblock.memory.cnt, i + 1);
> +		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
> +	}
> +}
> +
> +void dummy_physical_memory_many_cleanup(void *base[], int cnt)
> +{
> +	int i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		memory_block.base = base[i];
> +		dummy_physical_memory_cleanup();
> +	}
> +}
> +
>  static void usage(const char *prog)
>  {
>  	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index 3e7f23d341d7..848900aa8db6 100644
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
> @@ -68,8 +70,12 @@ struct region {
>  void reset_memblock_regions(void);
>  void reset_memblock_attributes(void);
>  void setup_memblock(void);
> +void append_memblock(void);
> +void *get_memory_block_base(void);
>  void dummy_physical_memory_init(void);
>  void dummy_physical_memory_cleanup(void);
> +void dummy_physical_memory_many_init(void *base[], int cnt);
> +void dummy_physical_memory_many_cleanup(void *base[], int cnt);
>  void parse_args(int argc, char **argv);
>  
>  void test_fail(void);
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
