Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB945A91AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiIAIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiIAIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6A1299D3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8634461DD4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9079C433D6;
        Thu,  1 Sep 2022 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662019726;
        bh=zzhgRRnZ4VXO746UDBVKOeVre1Ydh3irZCJn6wafIdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmXCAQMmBUjayWEAO6Z5SmEScBRevRAG0OWjLFVBfv+7Q6FYSctASOkREZjKIuYB7
         ZXLRfpYpdf5DtDyc+buQySUlrKaHy/lddaFqio+5nEfAedzVrF7ckK9na/L4K7zXJ4
         7+pqMvnqfhROpF3LC4xZWT8RB/RRmBbJowFQcnyQz02AdNB3sixaxaY6748Bz6sZEE
         ciUnCTeq4iInkNv2NC21O+WT+E14LOccLQ5VbTh6HktmrfZ3NVOdMBNycFbO+dssYo
         W+glyxjmF2YoiUsVmEPMKcnKD2NQso9rXNuEqqv++TQBWD65zhrwyR00ZkqtocrRut
         U6J8/mewE/SAQ==
Date:   Thu, 1 Sep 2022 11:08:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     shaoqin.huang@intel.com
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] memblock test: Add test to memblock_reserve() 129th
 region
Message-ID: <YxBogSb3qDMoXcrc@kernel.org>
References: <20220830014925.162718-1-shaoqin.huang@intel.com>
 <20220830014925.162718-3-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830014925.162718-3-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:49:18AM +0800, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> Reserve 129th region in the memblock, and this will trigger the
> memblock_double_array() function, this needs valid memory regions. So
> using dummy_physical_memory_init() to allocate a valid memory region.
> At the same time, reserve 128 faked memory region, and make sure these
> reserved region not intersect with the valid memory region. So
> memblock_double_array() will choose the valid memory region, and it will
> success.
> 
> Also need to restore the reserved.regions after memblock_double_array(),
> to make sure the subsequent tests can run as normal.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>  tools/testing/memblock/tests/basic_api.c | 87 ++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index c8e201156cdc..d8defc9866cb 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -686,6 +686,92 @@ static int memblock_reserve_twice_check(void)
>  	return 0;
>  }
>  
> +/*
> + * A test that tries to reserve the 129th memory block.
> + * Expect to trigger memblock_double_array() to double the
> + * memblock.memory.max, find a new valid memory as
> + * reserved.regions.
> + */
> +static int memblock_reserve_many_check(void)
> +{
> +	int i;
> +	void *orig_region;
> +	struct region r = {
> +		.base = SZ_16K,
> +		.size = MEM_SIZE,
> +	};
> +	phys_addr_t memory_base = SZ_128K;
> +	phys_addr_t new_reserved_regions_size;
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_allow_resize();
> +
> +	/* Add a valid memory region used by double_array(). */
> +	dummy_physical_memory_init();
> +	memblock_add((phys_addr_t)get_memory_block_base(), MEM_SIZE);
> +
> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
> +		/* Reserve some fakes memory region to fulfill the memblock. */
> +		memblock_reserve(memory_base, MEM_SIZE);
> +
> +		ASSERT_EQ(memblock.reserved.cnt, i + 1);
> +		ASSERT_EQ(memblock.reserved.total_size, (i + 1) * MEM_SIZE);
> +
> +		/* Keep the gap so these memory region will not be merged. */
> +		memory_base += MEM_SIZE * 2;
> +	}
> +
> +	orig_region = memblock.reserved.regions;
> +
> +	/* This reserve the 129 memory_region, and makes it double array. */
> +	memblock_reserve(memory_base, MEM_SIZE);
> +
> +	/*
> +	 * This is the memory region size used by the doubled reserved.regions,
> +	 * and it has been reserved due to it has been used. The size is used to
> +	 * calculate the total_size that the memblock.reserved have now.
> +	 */
> +	new_reserved_regions_size = PAGE_ALIGN((INIT_MEMBLOCK_REGIONS * 2) *
> +					sizeof(struct memblock_region));
> +	/*
> +	 * The double_array() will find a free memory region as the new
> +	 * reserved.regions, and the used memory region will be reserved, so
> +	 * there will be one more region exist in the reserved memblock. And the
> +	 * one more reserved region's size is new_reserved_regions_size.
> +	 */
> +	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 1 + 1);

                                                   +2 would be fine ^

> +	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE +
> +						new_reserved_regions_size);
> +	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
> +

Can you please elaborate what does the below sequence check?

> +	/* The base is very small, so it should be insert to the first region. */
> +	memblock_reserve(r.base, r.size);
> +	ASSERT_EQ(memblock.reserved.regions[0].base, r.base);
> +	ASSERT_EQ(memblock.reserved.regions[0].size, r.size);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, INIT_MEMBLOCK_REGIONS + 2 + 1);
> +	ASSERT_EQ(memblock.reserved.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE +
> +						new_reserved_regions_size);
> +	ASSERT_EQ(memblock.reserved.max, INIT_MEMBLOCK_REGIONS * 2);
> +
> +	dummy_physical_memory_cleanup();
> +
> +	/*
> +	 * The current reserved.regions is occupying a range of memory that
> +	 * allocated from dummy_physical_memory_init(). After free the memory,
> +	 * we must not use it. So restore the origin memory region to make sure
> +	 * the tests can run as normal and not affected by the double array.
> +	 */
> +	memblock.reserved.regions = orig_region;
> +	memblock.reserved.cnt = INIT_MEMBLOCK_REGIONS;
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>  static int memblock_reserve_checks(void)
>  {
>  	prefix_reset();
> @@ -698,6 +784,7 @@ static int memblock_reserve_checks(void)
>  	memblock_reserve_overlap_bottom_check();
>  	memblock_reserve_within_check();
>  	memblock_reserve_twice_check();
> +	memblock_reserve_many_check();
>  
>  	prefix_pop();
>  
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
