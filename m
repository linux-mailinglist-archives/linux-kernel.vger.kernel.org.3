Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02C749B85A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiAYQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583346AbiAYQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:10:55 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D215FC061760
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:10:46 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 930DDC0005;
        Tue, 25 Jan 2022 16:10:41 +0000 (UTC)
Message-ID: <36519886-cedc-a3e3-70d2-712f8a6d3a10@ghiti.fr>
Date:   Tue, 25 Jan 2022 17:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] riscv: mm: remove the BUG_ON check of mapping the last 4K
 bytes of memory
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220125155542.3753-1-jszhang@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20220125155542.3753-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/22 16:55, Jisheng Zhang wrote:
> remove the BUG_ON check of mapping the last 4K bytes of the addressable
> memory since "this is true for every kernel actually" as pointed out
> by Alexandre.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/riscv/mm/init.c | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index cf4d018b7d66..8347d0fda8cd 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -811,14 +811,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
>   	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
>   
> -#ifdef CONFIG_64BIT
> -	/*
> -	 * The last 4K bytes of the addressable memory can not be mapped because
> -	 * of IS_ERR_VALUE macro.
> -	 */
> -	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
> -#endif


This BUG_ON seems pretty legit to me: I re-read the exchanges we had, 
and I see that I didn't notice that in your v2, you actually removed the 
BUG_ON. So that's my bad, what I meant in the first place was that the 
BUG_ON is true for 32-bit and 64-bit kernels actually.

Sorry my RB was not right on this one :(

Alex


> -
>   	pt_ops_set_early();
>   
>   	/* Setup early PGD for fixmap */
