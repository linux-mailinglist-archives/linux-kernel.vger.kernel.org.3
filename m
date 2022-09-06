Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC15AE8EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbiIFM7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiIFM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:59:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B1FE005
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00140B818B2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B4CC433C1;
        Tue,  6 Sep 2022 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662469143;
        bh=GmhdK9e8DUrMiq+p5EOCSuvFoD+OxlZWjtWgIq0h88Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjjI0op7es9gnrMilp1DkDku6DkJErFF3FXWlA14ZRGgdqM4NJOp+3gZ2EQ3PyXsA
         jaqgNRApsHwPMSKJtKwKBqSv9rmVIZURyN6eYLEzPsU5OzAWYefkJVXhpdBxyiKhoi
         SN/kE6j+Odsmkhg3YVASTh3IK5fW1znLqfijo3HjMsZuZC3Z+156cqZNzWeCRyqLLZ
         DL4Mj3RqrBshpJQPdWClw0EMUNRVCYmBz6qVe2ag2MvHA5rOITqcWHR4xtatMrfu5b
         Ks33eyD/OtOjqU3eidUQ6MOMrtcvfq46JPpyvyHMN4r1Fx+NOV8RUf2h6axUonBEEP
         K1mZglUtQIYtA==
Date:   Tue, 6 Sep 2022 15:58:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     karolinadrobnik@gmail.com, david@redhat.com, remckee0@gmail.com,
        shaoqin.huang@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] tools/testing/memblock: add double array test
Message-ID: <YxdEB+5f1wvbfjdY@kernel.org>
References: <1662102645-8272-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662102645-8272-1-git-send-email-chensong_2000@189.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Fri, Sep 02, 2022 at 03:10:45PM +0800, Song Chen wrote:
> By default, there are 128 memblock_regions in memblock.memory.regions.
> This test is trying to add the 129th region by calling memblock_add,
> expects to trigger memblock_double_array.
> 
> The test will pass if
>     memblock.memory.cnt == 129 and
>     memblock.memory.max == 256
> 
> Below is the output:
> 
> ./main -v
> Running memblock_double_array tests...
> memblock_add: [0x7fffdccdf0a0a-0x7fffdccdf080a] 0x5616cca50dc4S
> .....
> memblock_add: [0x7fffdccdf0a0a-0x7fffdccdf080a] 0x5616cca50de4S
> memblock: memory is doubled to 256 at [0x7fffdccdeeb0a-0x7fffdccdeed0a]
> ok 25 : memblock_double_array: passed

Your patch largely duplicates work by Shaoqin:

https://lore.kernel.org/all/20220902024007.58041-1-shaoqin.huang@intel.com

> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  tools/testing/memblock/tests/basic_api.c | 42 ++++++++++++++++++++++++
>  tools/testing/memblock/tests/common.c    |  5 ---
>  tools/testing/memblock/tests/common.h    |  4 +++
>  3 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index 66f46f261e66..e668ceff2f10 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -8,6 +8,7 @@
>  #define FUNC_RESERVE					"memblock_reserve"
>  #define FUNC_REMOVE					"memblock_remove"
>  #define FUNC_FREE					"memblock_free"
> +#define FUNC_DOUBLE_ARRAY			"memblock_double_array"
>  
>  static int memblock_initialization_check(void)
>  {
> @@ -1180,6 +1181,46 @@ static int memblock_free_checks(void)
>  	return 0;
>  }
>  
> +/*
> + * A simple test that adds to 129 memory blocks.
> + * Expect the region max doubled.
> + */
> +static int memblock_double_array_check(void)
> +{
> +	int i;
> +	struct memblock_region *regions = memblock.memory.regions;
> +	struct region r = {
> +		.base = 0,
> +		.size = SZ_512,
> +	};
> +
> +	prefix_reset();
> +	prefix_push(FUNC_DOUBLE_ARRAY);
> +	test_print("Running %s tests...\n", FUNC_DOUBLE_ARRAY);
> +
> +	dummy_physical_memory_init();
> +	reset_memblock_attributes();
> +	setup_memblock();
> +	memblock_allow_resize();
> +
> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
> +		r.base += SZ_1K;
> +		memblock_add(r.base, r.size);
> +	}
> +
> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> +
> +	memblock.memory.regions = regions;
> +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
> +	dummy_physical_memory_cleanup();
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +
>  int memblock_basic_checks(void)
>  {
>  	memblock_initialization_check();
> @@ -1187,6 +1228,7 @@ int memblock_basic_checks(void)
>  	memblock_reserve_checks();
>  	memblock_remove_checks();
>  	memblock_free_checks();
> +	memblock_double_array_check();
>  
>  	return 0;
>  }
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index e43b2676af81..1d295a71ad44 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -5,11 +5,6 @@
>  #include <linux/memory_hotplug.h>
>  #include <linux/build_bug.h>
>  
> -#define INIT_MEMBLOCK_REGIONS			128
> -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> -#define PREFIXES_MAX				15
> -#define DELIM					": "
> -
>  static struct test_memory memory_block;
>  static const char __maybe_unused *prefixes[PREFIXES_MAX];
>  static int __maybe_unused nr_prefixes;
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index 3e7f23d341d7..13559825ddca 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -11,6 +11,10 @@
>  #include <../selftests/kselftest.h>
>  
>  #define MEM_SIZE SZ_16K
> +#define INIT_MEMBLOCK_REGIONS			128
> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> +#define PREFIXES_MAX				15
> +#define DELIM					": "
>  
>  /**
>   * ASSERT_EQ():
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
