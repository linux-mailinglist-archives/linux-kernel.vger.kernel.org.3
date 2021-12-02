Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4520246673D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbhLBPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:55:40 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39459 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347568AbhLBPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:55:35 -0500
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 87C5EE000F;
        Thu,  2 Dec 2021 15:52:09 +0000 (UTC)
Message-ID: <baa3e6dc-cfbc-c491-384a-639867734a7f@ghiti.fr>
Date:   Thu, 2 Dec 2021 16:52:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] riscv: mm: fix wrong phys_ram_base value for RV64
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211202153641.1961-1-jszhang@kernel.org>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <20211202153641.1961-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 16:36, Jisheng Zhang wrote:
> Currently, if 64BIT and !XIP_KERNEL, the phys_ram_base is always 0,
> no matter the real start of dram reported by memblock is. The original
> patch[1] is correct, I believe it's not corrected merged due to lots
> of #ifdef in arch/riscv/mm/init.c, I plan to send a clean up series
> soon.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-July/007650.html
>
> Fixes: 6d7f91d914bc ("riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address conversion")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/mm/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 24b2b8044602..3c0649dba4ff 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -187,10 +187,10 @@ static void __init setup_bootmem(void)
>   
>   
>   	phys_ram_end = memblock_end_of_DRAM();
> -#ifndef CONFIG_64BIT
>   #ifndef CONFIG_XIP_KERNEL
>   	phys_ram_base = memblock_start_of_DRAM();
>   #endif
> +#ifndef CONFIG_64BIT
>   	/*
>   	 * memblock allocator is not aware of the fact that last 4K bytes of
>   	 * the addressable memory can not be mapped because of IS_ERR_VALUE


Good catch, you can add:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

And looking forward to your cleanup patch ;)

Thanks,

Alex

