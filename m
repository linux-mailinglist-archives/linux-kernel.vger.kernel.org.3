Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFC4C635F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiB1GvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiB1GvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:51:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966FE66FB7;
        Sun, 27 Feb 2022 22:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F28D61004;
        Mon, 28 Feb 2022 06:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9679FC340F6;
        Mon, 28 Feb 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646031043;
        bh=2vbR4V4J6Cl+G68h2G7HleCPAcHpAjpd5tVKzN3DzfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rG9vBVuLZVmRU5mV+q2sCGqqiMY4Be4m9BXjNnwq5ZHCV4KCMOXXHIf10GvlfGs6G
         A1MBytsQt+8GYtqHnZhzjV7oklq5SfV2Nug+Gzm7d73u971rZQGhJT9IizJqdmxvoP
         zGIZ82TDL5CoTklP/UufP01m8lOT2Thg+lt+a7gDa6AnPH8x6h+Q0rpPnhzCiZuhds
         KiSIGQsJEFC5tMmwCLG9BitLWcjqYbaJMtrtvh4aZAK5ZC3dlaQVu7G2RItGpGanfJ
         Krp6IEyGU4a03Ix/j/BV//Za4Gm0PLmaFF1qqx9i73jo165hv8Zc4cRIQFn5+xbvcy
         li3l6jr/LB/7g==
Date:   Mon, 28 Feb 2022 08:50:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] MIPS: Refactor early_parse_memmap() to fix
 memmap= parameter
Message-ID: <YhxwuixN+9D8mRF2@kernel.org>
References: <1646029866-6692-1-git-send-email-yangtiezhu@loongson.cn>
 <1646029866-6692-4-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646029866-6692-4-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 02:31:05PM +0800, Tiezhu Yang wrote:
> According to Documentation/admin-guide/kernel-parameters.txt,
> the kernel command-line parameter memmap= means "Force usage
> of a specific region of memory", but when add "memmap=3G@64M"
> to the command-line, kernel boot hangs in sparse_init().
> 
> In order to support memmap=limit@base, refactor the function
> early_parse_memmap() and then use memblock_mem_range_remove_map()
> to limit the memory region.
> 
> With this patch, when add "memmap=3G@64M" to the command-line,
> the kernel boots successfully, we can see the following messages:
> 
>   [    0.000000] Memory limited to 64MB-3136MB
>   ...
>   [    0.000000] Early memory node ranges
>   [    0.000000]   node   0: [mem 0x0000000004000000-0x000000000effffff]
>   [    0.000000]   node   0: [mem 0x0000000090200000-0x00000000ffffffff]
>   [    0.000000]   node   0: [mem 0x0000000120000000-0x00000001653fffff]
>   ...
>   [    0.000000] Memory: 3070816K/3147776K available (...)
> 
> When add "memmap=128M@64M nr_cpus=1 init 3" to the command-line,
> the kernel also boots successfully, we can see the following messages:
> 
>   [    0.000000] Memory limited to 64MB-192MB
>   ...
>   [    0.000000] Early memory node ranges
>   [    0.000000]   node   0: [mem 0x0000000004000000-0x000000000c1fffff]
>   ...
>   [    0.000000] Memory: 95312K/133120K available (...)
> 
> After login, the output of free command is consistent with the
> above log.
> 
> By the way, this commit only supports memmap=limit@base format,
> the other formats such as memmap=limit#base, memmap=limit$base
> and memmap=limit!base can be added if they are necessary in the
> future.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/kernel/setup.c | 42 +++++++++---------------------------------
>  1 file changed, 9 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 6b6d718..e3b1f2e 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -340,6 +340,7 @@ static void __init bootmem_init(void)
>  
>  static int usermem __initdata;
>  static phys_addr_t memory_limit;
> +static phys_addr_t memory_base;
>  
>  static int __init early_parse_mem(char *p)
>  {
> @@ -355,42 +356,17 @@ early_param("mem", early_parse_mem);
>  
>  static int __init early_parse_memmap(char *p)
>  {
> -	char *oldp;
> -	u64 start_at, mem_size;
> -
>  	if (!p)
> -		return -EINVAL;
> +		return 1;
>  
> -	if (!strncmp(p, "exactmap", 8)) {
> -		pr_err("\"memmap=exactmap\" invalid on MIPS\n");
> -		return 0;
> -	}
> +	memory_limit = memparse(p, &p) & PAGE_MASK;
> +	if (*p == '@')
> +		memory_base = memparse(p + 1, &p) & PAGE_MASK;
>  
> -	oldp = p;
> -	mem_size = memparse(p, &p);
> -	if (p == oldp)
> -		return -EINVAL;
> -
> -	if (*p == '@') {
> -		start_at = memparse(p+1, &p);
> -		memblock_add(start_at, mem_size);
> -	} else if (*p == '#') {
> -		pr_err("\"memmap=nn#ss\" (force ACPI data) invalid on MIPS\n");
> -		return -EINVAL;
> -	} else if (*p == '$') {
> -		start_at = memparse(p+1, &p);
> -		memblock_add(start_at, mem_size);
> -		memblock_reserve(start_at, mem_size);
> -	} else {
> -		pr_err("\"memmap\" invalid format!\n");
> -		return -EINVAL;

This breaks backward compatibility for systems that use memmap=X#Y and
memmap=X$Y.

For your use case it is enough to implement "memmap=exactmap" that will
drop memory provided by the firmware and only use ranges supplied in
memmap=

> -	}
> +	pr_notice("Memory limited to %lldMB-%lldMB\n",
> +		  memory_base >> 20, (memory_base + memory_limit) >> 20);
>  
> -	if (*p == '\0') {
> -		usermem = 1;
> -		return 0;
> -	} else
> -		return -EINVAL;
> +	return 0;
>  }
>  early_param("memmap", early_parse_memmap);
>  
> @@ -667,7 +643,7 @@ static void __init arch_mem_init(char **cmdline_p)
>  		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
>  
>  	/* Limit the memory. */
> -	memblock_enforce_memory_limit(memory_limit);
> +	memblock_mem_range_remove_map(memory_base, memory_limit);
>  	memblock_allow_resize();
>  
>  	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
> -- 
> 2.1.0
> 

-- 
Sincerely yours,
Mike.
