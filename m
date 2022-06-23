Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504CF5571F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiFWEq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346854AbiFWEaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB704193DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60D6CB81EA9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C43C3411B;
        Thu, 23 Jun 2022 04:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655958616;
        bh=BRzBBPQDISUXKF+dnmQg2f3fvozeO32ObTg7nkiAODQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXZTdYzVr2Q7l6G/qlSK6u+AzSzuCRT7AQWH3j3L5I/Ptp48zwtTLhadr6M1LJ2Ty
         45ie0oNY8A/F6bFiR191pc51+P5v3vqfxj2rJDQxmrNQot6KbxIFRiidRYGuv7D5L6
         DLyH+3EM0UWs7g6PLjcGWuddTrDiA8nl0lD2KcQAHkLJbJ+6vChANKeF6DCgniDP4o
         IyEIv33MkdEjdXyleuuNn1VjSJQ48aUjM9h5PDT1CpA054qAXJAARoPkq3E6aAdGAf
         AUZ0pFamtyr1fcHAeF4gQZO/NtcLCV2TcqXiUof384g6QiJfN9f+Vn09mn5bEAKP36
         0xWyzdv3Gk15g==
Date:   Wed, 22 Jun 2022 23:30:10 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YrPsUrJ5R5UaIGBS@kernel.org>
References: <cover.1655889641.git.remckee0@gmail.com>
 <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:29:07AM -0500, Rebecca Mckeever wrote:
> Add and use functions for printing verbose testing output.
> 
> If the Memblock simulator was compiled with VERBOSE=1:
>   prefix_push() appends the given string to a prefix string that will be
>     printed in the test functions.
>   prefix_pop() removes the last prefix from the prefix string.
>   prefix_reset() clears the prefix string.
>   test_fail() prints a message after a test fails containing the test
>     number of the failing test and the prefix.
>   test_pass() prints a message after a test passes containing its test
>     number and the prefix.
>   test_print() prints the given formatted output string.
> 
> If the Memblock simulator was not compiled with VERBOSE=1, these
> functions do nothing.
> 
> Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
> If the assert condition fails, these macros call test_fail() before
> executing assert().
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
>  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
>  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
>  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
>  tools/testing/memblock/tests/common.c         |  58 +++
>  tools/testing/memblock/tests/common.h         |  54 +++
>  6 files changed, 880 insertions(+), 344 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> index d1aa7e15c18d..96df033d4300 100644
> --- a/tools/testing/memblock/tests/alloc_api.c
> +++ b/tools/testing/memblock/tests/alloc_api.c

...

> @@ -729,6 +820,12 @@ static int alloc_no_memory_check(void)
>  
>  int memblock_alloc_checks(void)
>  {
> +	static const char func_testing[] = "memblock_alloc";
> +
> +	prefix_reset();
> +	prefix_push(func_testing);
> +	test_print("Running %s tests...\n", func_testing);

Why not 

	test_print("Running memblock_alloc tests...\n");

?

(applies to other cases below)

> +
>  	reset_memblock_attributes();
>  	dummy_physical_memory_init();

...

> diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> index 963a966db461..f6eaed540427 100644
> --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> +++ b/tools/testing/memblock/tests/alloc_helpers_api.c

...

> @@ -378,6 +423,12 @@ static int alloc_from_min_addr_cap_check(void)
>  
>  int memblock_alloc_helpers_checks(void)
>  {
> +	static const char func_testing[] = "memblock_alloc_from";
> +
> +	prefix_reset();
> +	prefix_push(func_testing);
> +	test_print("Running %s tests...\n", func_testing);
> +
>  	reset_memblock_attributes();
>  	dummy_physical_memory_init();
>  
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 6390206e50e1..601f4a7ee30d 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c

...

> @@ -1150,6 +1263,12 @@ static int alloc_try_nid_low_max_check(void)
>  
>  int memblock_alloc_nid_checks(void)
>  {
> +	static const char func_testing[] = "memblock_alloc_try_nid";
> +
> +	prefix_reset();
> +	prefix_push(func_testing);
> +	test_print("Running %s tests...\n", func_testing);
> +
>  	reset_memblock_attributes();
>  	dummy_physical_memory_init();
>  
> @@ -1170,5 +1289,7 @@ int memblock_alloc_nid_checks(void)
>  
>  	dummy_physical_memory_cleanup();
>  
> +	prefix_pop();
> +
>  	return 0;
>  }
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index a7bc180316d6..f223a9a57be7 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -4,21 +4,30 @@
>  #include "basic_api.h"
>  
>  #define EXPECTED_MEMBLOCK_REGIONS			128
> +#define FUNC_ADD					"memblock_add"
> +#define FUNC_RESERVE					"memblock_reserve"
> +#define FUNC_REMOVE					"memblock_remove"
> +#define FUNC_FREE					"memblock_free"
>  
>  static int memblock_initialization_check(void)
>  {
> -	assert(memblock.memory.regions);
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> -	assert(strcmp(memblock.memory.name, "memory") == 0);
> +	prefix_push(__func__);
>  
> -	assert(memblock.reserved.regions);
> -	assert(memblock.reserved.cnt == 1);
> -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> -	assert(strcmp(memblock.reserved.name, "reserved") == 0);
> +	ASSERT_NE(memblock.memory.regions, NULL);
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> +	ASSERT_EQ(strcmp(memblock.memory.name, "memory"), 0);
>  
> -	assert(!memblock.bottom_up);
> -	assert(memblock.current_limit == MEMBLOCK_ALLOC_ANYWHERE);
> +	ASSERT_NE(memblock.reserved.regions, NULL);
> +	ASSERT_EQ(memblock.reserved.cnt, 1);
> +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> +	ASSERT_EQ(strcmp(memblock.reserved.name, "reserved"), 0);
> +
> +	ASSERT_EQ(memblock.bottom_up, false);
> +	ASSERT_EQ(memblock.current_limit, MEMBLOCK_ALLOC_ANYWHERE);
> +
> +	test_pass();
> +	prefix_pop();
>  
>  	return 0;
>  }
> @@ -40,14 +49,19 @@ static int memblock_add_simple_check(void)
>  		.size = SZ_4M
>  	};
>  
> +	prefix_push(__func__);
> +
>  	reset_memblock_regions();
>  	memblock_add(r.base, r.size);
>  
> -	assert(rgn->base == r.base);
> -	assert(rgn->size == r.size);
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, r.size);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r.size);
>  
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r.size);
> +	test_pass();
> +	prefix_pop();
>  
>  	return 0;
>  }
> @@ -69,18 +83,27 @@ static int memblock_add_node_simple_check(void)
>  		.size = SZ_16M
>  	};
>  
> +	prefix_pop();
> +	prefix_push("memblock_add_node");
> +	prefix_push(__func__);

I think there is no need to change the prefix from memblock_add to
memblock_add_node here.

ok 3 : memblock_add: memblock_add_node_simple_check: passed

provides enough information.

> +
>  	reset_memblock_regions();
>  	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);
>  
> -	assert(rgn->base == r.base);
> -	assert(rgn->size == r.size);
> +	ASSERT_EQ(rgn->base, r.base);
> +	ASSERT_EQ(rgn->size, r.size);
>  #ifdef CONFIG_NUMA
> -	assert(rgn->nid == 1);
> +	ASSERT_EQ(rgn->nid, 1);
>  #endif
> -	assert(rgn->flags == MEMBLOCK_HOTPLUG);
> +	ASSERT_EQ(rgn->flags, MEMBLOCK_HOTPLUG);
> +
> +	ASSERT_EQ(memblock.memory.cnt, 1);
> +	ASSERT_EQ(memblock.memory.total_size, r.size);
>  
> -	assert(memblock.memory.cnt == 1);
> -	assert(memblock.memory.total_size == r.size);
> +	test_pass();
> +	prefix_pop();
> +	prefix_pop();
> +	prefix_push(FUNC_ADD);
>  
>  	return 0;
>  }

-- 
Sincerely yours,
Mike.
