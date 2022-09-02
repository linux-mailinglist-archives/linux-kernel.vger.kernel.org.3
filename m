Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD895AA487
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiIBAhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiIBAhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:37:13 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C66717A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:37:06 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-11eab59db71so1227240fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xM433NCCdFsj/Dus8z982guFSm6mdOX0+AhxRQOZ+mQ=;
        b=nBlvj7nrHPVVIGNi93HF0NaakZvzGnxIVe7It932X+c4rUd2Jj88O9cFLEMb0aFJgN
         i3akrSqOsEfHJ/UYxuzE79m0BXm/ppqU5PlUX0FbQOYYyxyMCE/JhHHPYNOcBigzkAK7
         aX+T08h2pGs8fpER4RghbnPfpK4Mv6ojIIImZWtxMv+k2qGR4q1CUUqi7JfzefpUHI3A
         6qjPoJQXj+WRHXtFQdRd9tTCHsLPoCXBkx6bGA5I8rWfPbpl32/2G6/jlBZieuAdYfjs
         pNoXeeBxVtMKSvnPpXbYW3tuCpAB8K8BMmqRqAF7umHaQajfdBV7l1v6H9UGn6U+Ye3w
         sYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xM433NCCdFsj/Dus8z982guFSm6mdOX0+AhxRQOZ+mQ=;
        b=rBAe0UMCA+AX3q4UBoq8bMW2HA499kZCnfP35uQthR2INn3Rn2YTLbkHSqkSMxpW/t
         fysI5kmSkVAV8H9cC5qx+dSllG0HlLrcgzkdZI7mVBt1fILmkVxeepz5rr18+vjNnzhe
         nc1myNRD2VlJ4lwzKPe83Q8nGOwowx4O90yMBz7cTwfbi7405AeRqlm8r2uVPGsNI13A
         u7/OxchxPk3tDmcZC2k/5vDPfKBe+uzilzJmju0aYXpzjCKb6FeWpS6JUltW9LsfjWzu
         WluxDEyZ3eQa9VfeYkt4IxdI/M3+TXy29vwNQIQT8SObd7IjqeaR3qi/fTFzxMSIoNer
         jzCA==
X-Gm-Message-State: ACgBeo32bMdjoiFALggfThst22MYRhDrnTsiNeiEkvfYb1OxQKlVWSVb
        8Hxbpvb8rcx/zMotP6oLZO2dqvOxAMk=
X-Google-Smtp-Source: AA6agR4w24tn4ZIX/Y0E/iC+KDhcc4aQLCRBSznfH/pvuxzQ2STSLHaCFjI3AfDLko8i5rU4FnVbhA==
X-Received: by 2002:a05:6808:151f:b0:343:2cbe:ad68 with SMTP id u31-20020a056808151f00b003432cbead68mr867716oiw.254.1662079025189;
        Thu, 01 Sep 2022 17:37:05 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id m8-20020a056870058800b0011d02a3fa63sm420199oap.14.2022.09.01.17.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:37:04 -0700 (PDT)
Date:   Thu, 1 Sep 2022 19:37:03 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] memblock tests: add top-down NUMA tests for
 memblock_alloc_try_nid*
Message-ID: <20220902003703.GB18733@sophie>
References: <cover.1660897864.git.remckee0@gmail.com>
 <957966f06474e3885796247ad1beaa6b3841ebd1.1660897864.git.remckee0@gmail.com>
 <6f61b669-e89f-6615-6b80-088940221858@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f61b669-e89f-6615-6b80-088940221858@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:56:00PM +0200, David Hildenbrand wrote:
> On 19.08.22 11:05, Rebecca Mckeever wrote:
> > Add tests for memblock_alloc_try_nid() and memblock_alloc_try_nid_raw()
> > where the simulated physical memory is set up with multiple NUMA nodes.
> > Additionally, all of these tests set nid != NUMA_NO_NODE. These tests are
> > run with a top-down allocation direction.
> > 
> > The tested scenarios are:
> > 
> > Range unrestricted:
> > - region can be allocated in the specific node requested:
> >       + there are no previously reserved regions
> >       + the requested node is partially reserved but has enough space
> > - the specific node requested cannot accommodate the request, but the
> >   region can be allocated in a different node:
> >       + there are no previously reserved regions, but node is too small
> >       + the requested node is fully reserved
> >       + the requested node is partially reserved and does not have
> >         enough space
> > 
> > Range restricted:
> > - region can be allocated in the specific node requested after dropping
> >   min_addr:
> >       + range partially overlaps with two different nodes, where the first
> >         node is the requested node
> >       + range partially overlaps with two different nodes, where the
> >         requested node ends before min_addr
> > - region cannot be allocated in the specific node requested, but it can be
> >   allocated in the requested range:
> >       + range overlaps with multiple nodes along node boundaries, and the
> >         requested node ends before min_addr
> >       + range overlaps with multiple nodes along node boundaries, and the
> >         requested node starts after max_addr
> > - region cannot be allocated in the specific node requested, but it can be
> >   allocated after dropping min_addr:
> >       + range partially overlaps with two different nodes, where the
> >         second node is the requested node
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  tools/testing/memblock/tests/alloc_nid_api.c | 702 ++++++++++++++++++-
> >  tools/testing/memblock/tests/alloc_nid_api.h |  16 +
> >  tools/testing/memblock/tests/common.h        |  18 +
> >  3 files changed, 725 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> > index 2c1d5035e057..a410f1318402 100644
> > --- a/tools/testing/memblock/tests/alloc_nid_api.c
> > +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> > @@ -1102,7 +1102,7 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
> >  	return 0;
> >  }
> >  
> > -/* Test case wrappers */
> > +/* Test case wrappers for range tests */
> >  static int alloc_try_nid_simple_check(void)
> >  {
> >  	test_print("\tRunning %s...\n", __func__);
> > @@ -1234,17 +1234,10 @@ static int alloc_try_nid_low_max_check(void)
> >  	return 0;
> >  }
> >  
> > -static int memblock_alloc_nid_checks_internal(int flags)
> > +static int memblock_alloc_nid_range_checks(void)
> >  {
> > -	const char *func = get_func_testing(flags);
> > -
> > -	alloc_nid_test_flags = flags;
> > -	prefix_reset();
> > -	prefix_push(func);
> > -	test_print("Running %s tests...\n", func);
> > -
> > -	reset_memblock_attributes();
> > -	dummy_physical_memory_init();
> > +	test_print("Running %s range tests...\n",
> > +		   get_func_testing(alloc_nid_test_flags));
> >  
> >  	alloc_try_nid_simple_check();
> >  	alloc_try_nid_misaligned_check();
> > @@ -1261,6 +1254,693 @@ static int memblock_alloc_nid_checks_internal(int flags)
> >  	alloc_try_nid_reserved_all_check();
> >  	alloc_try_nid_low_max_check();
> >  
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A test that tries to allocate a memory region in a specific NUMA node that
> > + * has enough memory to allocate a region of the requested size.
> > + * Expect to allocate an aligned region at the end of the requested node.
> > + */
> > +static int alloc_try_nid_top_down_numa_simple_check(void)
> > +{
> > +	int nid_req = 3;
> > +	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
> > +	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
> > +	void *allocated_ptr = NULL;
> > +
> > +	PREFIX_PUSH();
> > +
> > +	phys_addr_t size;
> > +	phys_addr_t min_addr;
> > +	phys_addr_t max_addr;
> 
> Usually we define variables in a single block. So, before the
> PREFIX_PUSH(). Same applies to the other functions.
> 
Got it.

> > +
> > +	setup_numa_memblock();
> > +
> > +	ASSERT_LE(SZ_4, req_node->size);
> > +	size = req_node->size / SZ_4;
> > +	min_addr = memblock_start_of_DRAM();
> > +	max_addr = memblock_end_of_DRAM();
> > +
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr, nid_req);
> > +
> > +	ASSERT_NE(allocated_ptr, NULL);
> > +	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
> > +
> > +	ASSERT_EQ(new_rgn->size, size);
> > +	ASSERT_EQ(new_rgn->base, region_end(req_node) - size);
> > +	ASSERT_LE(req_node->base, new_rgn->base);
> > +
> > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > +	ASSERT_EQ(memblock.reserved.total_size, size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> 
> [...]
> 
> > +
> > +/*
> > + * A test that tries to allocate a memory region that spans over the min_addr
> > + * and max_addr range and overlaps with two different nodes, where the first
> > + * node is the requested node:
> > + *
> > + *                                min_addr
> > + *                                |           max_addr
> > + *                                |           |
> > + *                                v           v
> > + *  |           +-----------------------+-----------+              |
> > + *  |           |       requested       |   node3   |              |
> > + *  +-----------+-----------------------+-----------+--------------+
> > + *                                +           +
> > + *  |                       +-----------+                          |
> > + *  |                       |    rgn    |                          |
> > + *  +-----------------------+-----------+--------------------------+
> > + *
> > + * Expect to drop the lower limit and allocate a cleared memory region that
> > + * ends at the end of the requested node.
> 
> Interesting, allocating out-of-range is expected behavior? At least to
> me that wasn't immediately clear :)
> 
Yeah, it seems that memblock avoids allocations that would overlap with
more than one node. Do you think I should explain that in the comment?

> [...]
> 
> > +
> > +/*
> > + * A test that tries to allocate a memory region that spans over the min_addr
> > + * and max_addr range and overlaps with two different nodes, where the second
> > + * node is the requested node:
> > + *
> > + *                               min_addr
> > + *                               |         max_addr
> > + *                               |         |
> > + *                               v         v
> > + *  |      +--------------------------+---------+                |
> > + *  |      |         expected         |requested|                |
> > + *  +------+--------------------------+---------+----------------+
> > + *                               +         +
> > + *  |                       +---------+                          |
> > + *  |                       |   rgn   |                          |
> > + *  +-----------------------+---------+--------------------------+
> > + *
> > + * Expect to drop the lower limit and allocate a cleared memory region that
> 
> Does the "cleared memory region" part still apply? Or would we also end
> up calling the raw variant from run_memblock_alloc_try_nid() ?
> 
No, it doesn't apply. Thanks for catching this. I should probably add
another patch to update the wording in the pre-existing tests too.

> > + * ends at the end of the first node that overlaps with the range.
> > + */
> > +static int alloc_try_nid_top_down_numa_split_range_high_check(void)
> > +{
> > +	int nid_req = 3;
> > +	int nid_exp = nid_req - 1;
> > +	struct memblock_region *new_rgn = &memblock.reserved.regions[0];
> > +	struct memblock_region *exp_node = &memblock.memory.regions[nid_exp];
> > +	void *allocated_ptr = NULL;
> > +
> > +	PREFIX_PUSH();
> > +
> > +	phys_addr_t size = SZ_512;
> > +	phys_addr_t min_addr;
> > +	phys_addr_t max_addr;
> > +	phys_addr_t exp_node_end;
> > +
> > +	setup_numa_memblock();
> > +
> > +	exp_node_end = region_end(exp_node);
> > +	min_addr = exp_node_end - SZ_256;
> > +	max_addr = min_addr + size;
> > +
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr, nid_req);
> > +
> > +	ASSERT_NE(allocated_ptr, NULL);
> > +	verify_mem_content(allocated_ptr, size, alloc_nid_test_flags);
> > +
> > +	ASSERT_EQ(new_rgn->size, size);
> > +	ASSERT_EQ(new_rgn->base, exp_node_end - size);
> > +	ASSERT_LE(exp_node->base, new_rgn->base);
> > +
> > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > +	ASSERT_EQ(memblock.reserved.total_size, size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> 
> 
> [...]
> 
> > +int __memblock_alloc_nid_numa_checks(void)
> > +{
> > +	test_print("Running %s NUMA tests...\n",
> > +		   get_func_testing(alloc_nid_test_flags));
> > +
> > +	alloc_try_nid_numa_simple_check();
> > +	alloc_try_nid_numa_small_node_check();
> > +	alloc_try_nid_numa_node_reserved_check();
> > +	alloc_try_nid_numa_part_reserved_check();
> > +	alloc_try_nid_numa_part_reserved_fallback_check();
> > +	alloc_try_nid_numa_split_range_low_check();
> > +	alloc_try_nid_numa_split_range_high_check();
> > +
> > +	alloc_try_nid_numa_no_overlap_split_check();
> > +	alloc_try_nid_numa_no_overlap_low_check();
> > +	alloc_try_nid_numa_no_overlap_high_check();
> > +
> > +	return 0;
> > +}
> > +
> > +static int memblock_alloc_nid_checks_internal(int flags)
> > +{
> > +	alloc_nid_test_flags = flags;
> 
> Empty line missing
> 
Got it.

> > +	prefix_reset();
> > +	prefix_push(get_func_testing(flags));
> > +
> > +	reset_memblock_attributes();
> > +	dummy_physical_memory_init();
> > +
> > +	memblock_alloc_nid_range_checks();
> > +	memblock_alloc_nid_numa_checks();
> > +
> >  	dummy_physical_memory_cleanup();
> >  
> >  	prefix_pop();
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
>
Thanks,
Rebecca
