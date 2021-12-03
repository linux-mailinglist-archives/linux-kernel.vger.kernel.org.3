Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A7467329
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378901AbhLCITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:19:08 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59863 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbhLCITH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:19:07 -0500
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id ECF9860017;
        Fri,  3 Dec 2021 08:15:41 +0000 (UTC)
Message-ID: <e3912496-87aa-d579-b3c1-861c13b66bec@ghiti.fr>
Date:   Fri, 3 Dec 2021 09:15:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/5] riscv: mm: init: remove unnecessary "#ifdef
 CONFIG_CRASH_DUMP"
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211203050317.2102-1-jszhang@kernel.org>
 <20211203050317.2102-2-jszhang@kernel.org>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <20211203050317.2102-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 06:03, Jisheng Zhang wrote:
> The is_kdump_kernel() returns false for !CRASH_DUMP case, so we don't
> need the #ifdef CONFIG_CRASH_DUMP for is_kdump_kernel() checking.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/mm/init.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 3c0649dba4ff..745f26a3b02e 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -790,12 +790,10 @@ static void __init reserve_crashkernel(void)
>   	 * since it doesn't make much sense and we have limited memory
>   	 * resources.
>   	 */
> -#ifdef CONFIG_CRASH_DUMP
>   	if (is_kdump_kernel()) {
>   		pr_info("crashkernel: ignoring reservation request\n");
>   		return;
>   	}
> -#endif
>   
>   	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>   				&crash_size, &crash_base);


Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex

