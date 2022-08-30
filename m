Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4E5A628A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiH3L4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH3L4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0168B32C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661860563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Elx50XoN9DppxGV5Vt9IVOHnJZPbvJDnCiSoJg+LDfA=;
        b=OK8yAc35efhUFWGJ2ZQJwsGuhvMUSqdwHRQb3BJDa7xi493Hwj5aOxlzUNydSZkCtkYS9i
        lW3xzQq9Wc1pgNZs9t6opwVU254b5RmAfDzjmFLOSj/XgM8LtQuP22wszIr2MjbVVr7aXU
        DJmKQMNTBrp+3btW5B9V5/dQWimR7So=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-DCCp-wZdPFON4wo9q_xUcg-1; Tue, 30 Aug 2022 07:56:02 -0400
X-MC-Unique: DCCp-wZdPFON4wo9q_xUcg-1
Received: by mail-wm1-f72.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso9973071wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Elx50XoN9DppxGV5Vt9IVOHnJZPbvJDnCiSoJg+LDfA=;
        b=U7/l+HRnLNC87lw5cPkG3vLVXFEPY/toVAN36ZF6ACWaGXCDF2xCVAWikaUknMBHW4
         bID/rN0lh9jiS7GGiIJKjhIXvsCL41+rx76GS240UCWN96q6//IWrpxDZWsoX41OvjlZ
         QiJlKkdjHaoLMMnSD6B3FIqPZxbm00ys6nA+eB5Eie0VxRUfHFFVo6tcirLBIcJYs43P
         4XBjPSNuoBSNDkozlSe+HaB8qnTTT6MVWY6q8ixV6t5lj/OrGPbkX9CRw5iwFddX2THM
         K2a4nQhxphiYT8VSNKurRP4VnxYyBU5aUos5Fo/sRMD9I4C37SaSFeUTFGEPFOYz5R9N
         mMXw==
X-Gm-Message-State: ACgBeo3/dgCezFStEIE626vWz/yQF3+mYI+exSp4Z2+S4fv7QXr4visF
        EuZ+PqH2kXfI/KePFyRUMOjWK6sb/2ZYPFvfd1iPAigb8CoZ/4CuYTk8gFDtKKMcd+Mb6sx8ogl
        3JZniXnka/XwnVlFKHrm8XgIS
X-Received: by 2002:adf:dd0d:0:b0:225:8759:a35a with SMTP id a13-20020adfdd0d000000b002258759a35amr9424838wrm.615.1661860561598;
        Tue, 30 Aug 2022 04:56:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4m2j8SRCyEXL+bBlTJd5xqNbeiS5J9dqK/yLRFrGsg6IMvGUI/OjzpQ6utEhh74qXtwbtAsw==
X-Received: by 2002:adf:dd0d:0:b0:225:8759:a35a with SMTP id a13-20020adfdd0d000000b002258759a35amr9424818wrm.615.1661860561212;
        Tue, 30 Aug 2022 04:56:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c15d400b003a331c6bffdsm11197314wmf.47.2022.08.30.04.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 04:56:00 -0700 (PDT)
Message-ID: <6f61b669-e89f-6615-6b80-088940221858@redhat.com>
Date:   Tue, 30 Aug 2022 13:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897864.git.remckee0@gmail.com>
 <957966f06474e3885796247ad1beaa6b3841ebd1.1660897864.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] memblock tests: add top-down NUMA tests for
 memblock_alloc_try_nid*
In-Reply-To: <957966f06474e3885796247ad1beaa6b3841ebd1.1660897864.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.22 11:05, Rebecca Mckeever wrote:
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
> index 2c1d5035e057..a410f1318402 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -1102,7 +1102,7 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
>  	return 0;
>  }
>  
> -/* Test case wrappers */
> +/* Test case wrappers for range tests */
>  static int alloc_try_nid_simple_check(void)
>  {
>  	test_print("\tRunning %s...\n", __func__);
> @@ -1234,17 +1234,10 @@ static int alloc_try_nid_low_max_check(void)
>  	return 0;
>  }
>  
> -static int memblock_alloc_nid_checks_internal(int flags)
> +static int memblock_alloc_nid_range_checks(void)
>  {
> -	const char *func = get_func_testing(flags);
> -
> -	alloc_nid_test_flags = flags;
> -	prefix_reset();
> -	prefix_push(func);
> -	test_print("Running %s tests...\n", func);
> -
> -	reset_memblock_attributes();
> -	dummy_physical_memory_init();
> +	test_print("Running %s range tests...\n",
> +		   get_func_testing(alloc_nid_test_flags));
>  
>  	alloc_try_nid_simple_check();
>  	alloc_try_nid_misaligned_check();
> @@ -1261,6 +1254,693 @@ static int memblock_alloc_nid_checks_internal(int flags)
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

Usually we define variables in a single block. So, before the
PREFIX_PUSH(). Same applies to the other functions.

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
> +	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
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

[...]

> +
> +/*
> + * A test that tries to allocate a memory region that spans over the min_addr
> + * and max_addr range and overlaps with two different nodes, where the first
> + * node is the requested node:
> + *
> + *                                min_addr
> + *                                |           max_addr
> + *                                |           |
> + *                                v           v
> + *  |           +-----------------------+-----------+              |
> + *  |           |       requested       |   node3   |              |
> + *  +-----------+-----------------------+-----------+--------------+
> + *                                +           +
> + *  |                       +-----------+                          |
> + *  |                       |    rgn    |                          |
> + *  +-----------------------+-----------+--------------------------+
> + *
> + * Expect to drop the lower limit and allocate a cleared memory region that
> + * ends at the end of the requested node.

Interesting, allocating out-of-range is expected behavior? At least to
me that wasn't immediately clear :)

[...]

> +
> +/*
> + * A test that tries to allocate a memory region that spans over the min_addr
> + * and max_addr range and overlaps with two different nodes, where the second
> + * node is the requested node:
> + *
> + *                               min_addr
> + *                               |         max_addr
> + *                               |         |
> + *                               v         v
> + *  |      +--------------------------+---------+                |
> + *  |      |         expected         |requested|                |
> + *  +------+--------------------------+---------+----------------+
> + *                               +         +
> + *  |                       +---------+                          |
> + *  |                       |   rgn   |                          |
> + *  +-----------------------+---------+--------------------------+
> + *
> + * Expect to drop the lower limit and allocate a cleared memory region that

Does the "cleared memory region" part still apply? Or would we also end
up calling the raw variant from run_memblock_alloc_try_nid() ?

> + * ends at the end of the first node that overlaps with the range.
> + */
> +static int alloc_try_nid_top_down_numa_split_range_high_check(void)
> +{
> +	int nid_req = 3;
> +	int nid_exp = nid_req - 1;
> +	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
> +	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
> +	void *allocated_ptr = NULL;
> +
> +	PREFIX_PUSH();
> +
> +	phys_addr_t size = SZ_512;
> +	phys_addr_t min_addr;
> +	phys_addr_t max_addr;
> +	phys_addr_t exp_node_end;
> +
> +	setup_numa_memblock();
> +
> +	exp_node_end = region_end(exp_node);
> +	min_addr = exp_node_end - SZ_256;
> +	max_addr = min_addr + size;
> +
> +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> +						   min_addr, max_addr, nid_req);
> +
> +	ASSERT_NE(allocated_ptr, NULL);
> +	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
> +
> +	ASSERT_EQ(new_rgn->size, size);
> +	ASSERT_EQ(new_rgn->base, exp_node_end - size);
> +	ASSERT_LE(exp_node->base, new_rgn->base);
> +
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.reserved.total_size, size);
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}


[...]

> +int __memblock_alloc_nid_numa_checks(void)
> +{
> +	test_print("Running %s NUMA tests...\n",
> +		   get_func_testing(alloc_nid_test_flags));
> +
> +	alloc_try_nid_numa_simple_check();
> +	alloc_try_nid_numa_small_node_check();
> +	alloc_try_nid_numa_node_reserved_check();
> +	alloc_try_nid_numa_part_reserved_check();
> +	alloc_try_nid_numa_part_reserved_fallback_check();
> +	alloc_try_nid_numa_split_range_low_check();
> +	alloc_try_nid_numa_split_range_high_check();
> +
> +	alloc_try_nid_numa_no_overlap_split_check();
> +	alloc_try_nid_numa_no_overlap_low_check();
> +	alloc_try_nid_numa_no_overlap_high_check();
> +
> +	return 0;
> +}
> +
> +static int memblock_alloc_nid_checks_internal(int flags)
> +{
> +	alloc_nid_test_flags = flags;

Empty line missing

> +	prefix_reset();
> +	prefix_push(get_func_testing(flags));
> +
> +	reset_memblock_attributes();
> +	dummy_physical_memory_init();
> +
> +	memblock_alloc_nid_range_checks();
> +	memblock_alloc_nid_numa_checks();
> +
>  	dummy_physical_memory_cleanup();
>  
>  	prefix_pop();


-- 
Thanks,

David / dhildenb

