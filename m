Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358574673B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351259AbhLCJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:15:30 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:36013 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243758AbhLCJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:15:29 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 55EE2C00A6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:57:59 +0000 (UTC)
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2B4DDFF80F;
        Fri,  3 Dec 2021 08:57:35 +0000 (UTC)
Message-ID: <bdb6b231-2b1d-61c9-35a6-d5545bd667c6@ghiti.fr>
Date:   Fri, 3 Dec 2021 09:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 3/5] riscv: mm: init: remove _pt_ops and use pt_ops
 directly
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211203050317.2102-1-jszhang@kernel.org>
 <20211203050317.2102-4-jszhang@kernel.org>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <20211203050317.2102-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 06:03, Jisheng Zhang wrote:
> Except "pt_ops", other global vars when CONFIG_XIP_KERNEL=y is defined
> as below:
>
> |foo_type foo;
> |#ifdef CONFIG_XIP_KERNEL
> |#define foo	(*(foo_type *)XIP_FIXUP(&foo))
> |#endif
>
> Follow the same way for pt_ops to unify the style and to simplify code.


_dtb_early_pa and _dtb_early_va have the same 'issue' too. I thought 
there was a reason for those variables to be declared this way but I 
can't find it :)


>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/mm/init.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index bd445ac778a8..4d4fcd7ef1a9 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -227,12 +227,10 @@ static void __init setup_bootmem(void)
>   }
>   
>   #ifdef CONFIG_MMU
> -static struct pt_alloc_ops _pt_ops __initdata;
> +static struct pt_alloc_ops pt_ops __initdata;
>   
>   #ifdef CONFIG_XIP_KERNEL
> -#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
> -#else
> -#define pt_ops _pt_ops
> +#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
>   #endif
>   
>   unsigned long riscv_pfn_base __ro_after_init;
