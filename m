Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BB4D0613
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiCGSOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244665AbiCGSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:14:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C62554BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:13:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DB361295
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A541C340EB;
        Mon,  7 Mar 2022 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646676791;
        bh=rZCSmb5w6EjObQAjA2q/+2HByQVaObBOrVzAVdxTAwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbSrrjiCSTm30CYM9iCXRDS++RD2YfGGbAjyd8WXPAHxEF0Hjkus9LXqh3d3dBuiz
         lsjhtQJRcsOyTONk1i3zmUfMS1jpbvC/nB4lHq44AEU+uukeJxB+anUyLdsRpcw91w
         01dtSbsmo1qEWYFhoD7jIubEcSGFrSKY2KxiiQEGoFwvypkEAdRnW2b3OD+5CJWzKE
         GF8CCjNW3JMcq6voBunZWSj0eGbCyWd6ZUy0dah3ur9vveGaUzs1gDJWrE/iRbcArX
         HYc/dFiKygm2AXXl6E2G34ba+TNRa1Qgho4JckQT/1+VMQMGx/oRnx1ZGtAgUesERY
         qtMNIRIwrUcdw==
Date:   Mon, 7 Mar 2022 20:13:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] memblock tests: Add TODO and README files
Message-ID: <YiZLL6gVQUd5v+N+@kernel.org>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
 <d5e39b9f7dcef177ebc14282727447bc21e3b38f.1646055639.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e39b9f7dcef177ebc14282727447bc21e3b38f.1646055639.git.karolinadrobnik@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:46:51PM +0100, Karolina Drobnik wrote:
> Add description of the project, its structure and how to run it.
> List what is left to implement and what the known issues are.
> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  tools/testing/memblock/README | 114 ++++++++++++++++++++++++++++++++++
>  tools/testing/memblock/TODO   |  28 +++++++++
>  2 files changed, 142 insertions(+)
>  create mode 100644 tools/testing/memblock/README
>  create mode 100644 tools/testing/memblock/TODO
> 
> diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> new file mode 100644
> index 000000000000..40c0ce50e7c2
> --- /dev/null
> +++ b/tools/testing/memblock/README
> @@ -0,0 +1,114 @@
> +=========================
> +   Memblock simulator
> +=========================
> +
> +
> +Introduction
> +---------------------

Please make shorten the underline to match section title

> +Memblock is a boot time memory allocator[1] that manages memory regions before
> +the actual memory management is initialized. Its APIs allow to register physical
> +memory regions, mark them as available or reserved, allocate a block of memory
> +within the requested range and/or in specific NUMA node, and many more.
> +
> +Because it is used so early in the booting process, testing and debugging it is
> +difficult. This test suite, usually referred as memblock simulator, is
> +an attempt at testing the memblock mechanism. It runs one monolithic test that
> +consist of a series of checks that exercise both the basic operations and
> +allocation functionalities of memblock. The main data structure of the boot time
> +memory allocator is initialized at the build time, so the checks here reuse its
> +instance throughout the duration of the test. To ensure that tests don't affect
> +each other, region arrays are reset in between.
> +
> +As this project uses the actual memblock code and has to run in user space, some
> +of the kernel definitions were stubbed in the introductory patch[2]. Most of

The patch commit sha in memblock/for-next is stable, please use that.

> +them don't match the kernel implementation, so one should consult them first
> +before making any significant changes to the project.
> +
> +
> +Usage
> +---------------------
> +
> +To run the tests, build the main target and run it:
> +
> +$ make; ./main

I'd rather use

	make && ./make

> +
> +A successful run produces no output. It is also possible to override different
> +configuration parameters. For example, to simulate enabled NUMA, use:
> +
> +$ make NUMA=1
> +
> +For the full list of options, see `make help`.
> +
> +
> +Project structure
> +---------------------
> +
> +The project has one target, main, which calls a group of checks for basic and
> +allocation functions. Tests for each group are defined in dedicated files, as it
> +can be seen here:
> +
> +memblock
> +|-- asm       ------------------,
> +|-- lib                         |-- implement function and struct stubs
> +|-- linux     ------------------'
> +|-- scripts
> +|    |-- Makefile.include        -- handles `make` parameters
> +|-- tests
> +|    |-- alloc_api.(c|h)         -- memblock_alloc tests
> +|    |-- alloc_helpers_api.(c|h) -- memblock_alloc_from tests
> +|    |-- alloc_nid_api.(c|h)     -- memblock_alloc_try_nid tests
> +|    |-- basic_api.(c|h)         -- memblock_add/memblock_reserve/... tests
> +|    |-- common.(c|h)            -- helper functions for resetting memblock;
> +|-- main.c        --------------.   dummy physical memory definition
> +|-- Makefile                     `- test runner
> +|-- README
> +|-- TODO
> +|-- .gitignore
> +
> +
> +Simulating physical memory
> +--------------------------
> +
> +Some allocation functions clear the memory in the process, so it is required for
> +memblock to track valid memory ranges. To achieve this, the test suite registers
> +with memblock memory stored by test_memory struct. It is a small wrapper that
> +points to a block of memory allocated via malloc. For each group of allocation
> +tests, dummy physical memory is allocated, added to memblock, and then released
> +at the end of the test run. The structure of a test runner checking allocation
> +functions is as follows:
> +
> +int memblock_alloc_foo_checks(void)
> +{
> +	reset_memblock_attributes();     /* data structure reset */
> +	dummy_physical_memory_init();    /* allocate and register memory */
> +
> +	(...allocation checks...)
> +
> +	dummy_physical_memory_cleanup(); /* free the memory */
> +}
> +
> +There's no need to explicitly free the dummy memory from memblock via
> +memblock_free() call. The entry will be erased by reset_memblock_regions(),
> +called at the beginning of each test.
> +
> +
> +Known issues
> +---------------------
> +
> +1. Requesting a specific NUMA node via memblock_alloc_node() does not work as
> +   intended. Once the fix is in place, tests for this function can be added.
> +
> +2. Tests for memblock_alloc_low() can't be easily implemented. The function uses
> +   ARCH_LOW_ADDRESS_LIMIT marco, which can't be changed to point at the low
> +   memory of the memory_block.
> +
> +
> +References
> +---------------------
> +
> +1. Boot time memory management documentation page:
> +   https://www.kernel.org/doc/html/latest/core-api/boot-time-mm.html
> +
> +2. Introduce memblock simulator, lore link:
> +https://lore.kernel.org/linux-mm/cover.1643796665.git.karolinadrobnik@gmail.com/
> diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
> new file mode 100644
> index 000000000000..c25b2fdec45e
> --- /dev/null
> +++ b/tools/testing/memblock/TODO
> @@ -0,0 +1,28 @@
> +TODO
> +=====
> +
> +1. Add verbose output (e.g., what is being tested and how many tests cases are
> +   passing)
> +
> +2. Add flags to Makefile:
> +   + verbosity level
> +   + enable memblock_dbg() messages (i.e. pass "-D CONFIG_DEBUG_MEMORY_INIT"
> +     flag)
> +
> +3. Add tests trying to memblock_add() or memblock_reserve() 129th region.

s/129th/more than INIT_MEMBLOCK_REGIONS/

> +   This will trigger memblock_double_array(), make sure it succeeds.
> +   *Important:* These tests require valid memory ranges, use dummy physical
> +                memory block from common.c to implement them. It is also very
> +                likely that the current MEM_SIZE won't be enough for these
> +                test cases. Use realloc to adjust the size accordingly.
> +
> +4. Add test cases using this functions (implement them for both directions):
> +   + memblock_alloc_raw()
> +   + memblock_alloc_exact_nid_raw()
> +   + memblock_alloc_try_nid_raw()
> +
> +5. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
> +   for the new region
> +
> +6. Update comments in tests/basic_api.c to match the style used in
> +   tests/alloc_*.c
> --
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
