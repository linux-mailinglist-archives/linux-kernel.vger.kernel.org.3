Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6111E476F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhLPLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:09:57 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:41733 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhLPLJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:09:54 -0500
Received: (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 05FD820000E;
        Thu, 16 Dec 2021 11:09:50 +0000 (UTC)
Message-ID: <3387fdfb-a82f-6842-5442-c4bc98b745b6@ghiti.fr>
Date:   Thu, 16 Dec 2021 12:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 3/5] riscv: mm: init: remove _pt_ops and use pt_ops
 directly
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211206150353.731-1-jszhang@kernel.org>
 <20211206150353.731-4-jszhang@kernel.org>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <20211206150353.731-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 16:03, Jisheng Zhang wrote:
> Except "pt_ops", other global vars when CONFIG_XIP_KERNEL=y is defined
> as below:
>
> |foo_type foo;
> |#ifdef CONFIG_XIP_KERNEL
> |#define foo	(*(foo_type *)XIP_FIXUP(&foo))
> |#endif
>
> Follow the same way for pt_ops to unify the style and to simplify code.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/mm/init.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4edf5600bea9..9c5816971f40 100644
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


I tried to compile a XIP kernel with success and I noticed we can go 
even further by removing the ifdef CONFIG_XIP_KERNEL since XIP_FIXUP is 
the identity for normal kernels.

Anyway, I'll do that later:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex


>   
>   unsigned long riscv_pfn_base __ro_after_init;
