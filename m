Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741B5AD07B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiIEKrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbiIEKrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:47:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC7D64C60C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:46:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86F7D6E;
        Mon,  5 Sep 2022 03:47:05 -0700 (PDT)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E80E3F7B4;
        Mon,  5 Sep 2022 03:46:57 -0700 (PDT)
Message-ID: <696a1a53-87b5-7517-3c05-82217c8eb190@arm.com>
Date:   Mon, 5 Sep 2022 11:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] arm64: Remove d-cache clean operation at
 preserve_boot_args().
Content-Language: en-GB
To:     Jeungwoo Yoo <casionwoo@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220904193020.65556-1-casionwoo@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220904193020.65556-1-casionwoo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-04 20:30, Jeungwoo Yoo wrote:
> Kernel expects only the clean operation as a booting requirement in
> arm64 architecture [1], therefore, the kernel has to invalidate any
> cache entries after accessing a memory in the booting time (before
> enabling D-cache and MMU) not to overwrite the memory with the stale
> cache entry.
> 
> Same applied in preserve_boot_args(), kernel saves boot arguments into
> 'boot_args' and invalidates the corresponding cache entry. However,
> according to the 'dcache_inval_poc()' implementation, the cache entry
> will be not only invalidated but also cleaned. That means if there is a
> stale cache entry corresponding to the address of the 'boot_args', the
> saved boot arguments in 'boot_args' will be overwritten by the stale
> cache entry. Therefore, it uses 'dv ivac' instruction directly instead
> of calling 'dcache_inval_poc()'.

You've already said in the first paragraph that we expect these 
locations to be clean. Clean lines are not written back, so your 
reasoning here is spurious. If boot_args has somehow become dirtied such 
that the clean operation *would* write back to memory, that can only 
mean one of two things: either the kernel image was not cleaned per the 
boot protocol, in which case there's every chance that other things will 
also go wrong elsewhere and there's not much we can do, or the prior 
stores hit in the cache (either unexpectedly or because the MMU was left 
on), in which case we almost certainly *would* want writeback here anyway.

> The address of the 'boot_args' is aligned to the cache line size and the
> size of 'boot_args' is 32 byte (8 byte * 4), therefore, a single
> invalidate operation is enough to invalidate the cache line belonging to
> the 'boot_args'.

The architecture allows the CWG to be as small as 2 words, so this is 
clearly untrue.

Thanks,
Robin.

> Sometimes clean operation is required not to lose any contents in the
> cache entry but not the target of the invalidation. However, in this
> case, there is no valid cache entries at a very early booting stage and
> preserve_boot_args() is not called by any other (non-primary) CPUs.
> Therefore, this invalidation operation will not introduce any problems.
> 
> [1] in Documentation/arm64/booting.rst:
> The address range corresponding to the loaded kernel image must be
> cleaned to the PoC.
> 
> Co-developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> 
> Co-developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> 
> Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> ---
>   arch/arm64/kernel/head.S | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index cefe6a73ee54..916227666b07 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -121,9 +121,7 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
>   
>   	dmb	sy				// needed before dc ivac with
>   						// MMU off
> -
> -	add	x1, x0, #0x20			// 4 x 8 bytes
> -	b	dcache_inval_poc		// tail call
> +	dc	ivac, x0			// Invalidate potentially stale cache line
>   SYM_CODE_END(preserve_boot_args)
>   
>   SYM_FUNC_START_LOCAL(clear_page_tables)
