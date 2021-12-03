Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562C9467356
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379233AbhLCIml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:42:41 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43661 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbhLCImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:42:40 -0500
Received: (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7A40A24000C;
        Fri,  3 Dec 2021 08:39:13 +0000 (UTC)
Message-ID: <ffc2e8f2-83f1-2dcb-b046-0b11cb010157@ghiti.fr>
Date:   Fri, 3 Dec 2021 09:39:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 4/5] riscv: mm: init: try IS_ENABLED(CONFIG_XIP_KERNEL)
 instead of #ifdef
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211203050317.2102-1-jszhang@kernel.org>
 <20211203050317.2102-5-jszhang@kernel.org>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <20211203050317.2102-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 06:03, Jisheng Zhang wrote:
> Try our best to replace the conditional compilation using
> "#ifdef CONFIG_XIP_KERNEL" with "IS_ENABLED(CONFIG_XIP_KERNEL)", to
> simplify the code and to increase compile coverage.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/mm/init.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4d4fcd7ef1a9..4a9e3f429042 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -161,13 +161,13 @@ early_param("mem", early_mem);
>   static void __init setup_bootmem(void)
>   {
>   	phys_addr_t vmlinux_end = __pa_symbol(&_end);
> -	phys_addr_t vmlinux_start = __pa_symbol(&_start);
>   	phys_addr_t __maybe_unused max_mapped_addr;
> -	phys_addr_t phys_ram_end;
> +	phys_addr_t phys_ram_end, vmlinux_start;
>   
> -#ifdef CONFIG_XIP_KERNEL
> -	vmlinux_start = __pa_symbol(&_sdata);
> -#endif
> +	if (IS_ENABLED(CONFIG_XIP_KERNEL))
> +		vmlinux_start = __pa_symbol(&_sdata);
> +	else
> +		vmlinux_start = __pa_symbol(&_start);
>   
>   	memblock_enforce_memory_limit(memory_limit);
>   
> @@ -183,11 +183,9 @@ static void __init setup_bootmem(void)
>   	 */
>   	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>   
> -
>   	phys_ram_end = memblock_end_of_DRAM();
> -#ifndef CONFIG_XIP_KERNEL
> -	phys_ram_base = memblock_start_of_DRAM();
> -#endif
> +	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> +		phys_ram_base = memblock_start_of_DRAM();
>   	/*
>   	 * memblock allocator is not aware of the fact that last 4K bytes of
>   	 * the addressable memory can not be mapped because of IS_ERR_VALUE


Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex

