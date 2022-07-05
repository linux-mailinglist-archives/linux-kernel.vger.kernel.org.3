Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD0566842
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiGEKkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiGEKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:45 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62B3E15727;
        Tue,  5 Jul 2022 03:40:44 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fz0-0002Jv-03; Tue, 05 Jul 2022 12:40:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 095BEC0230; Tue,  5 Jul 2022 12:24:43 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:24:42 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Loongson64: Fix section mismatch warning
Message-ID: <20220705102442.GG9951@alpha.franken.de>
References: <1656313633-1713-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656313633-1713-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 03:07:13PM +0800, Tiezhu Yang wrote:
> prom_init_numa_memory() is annotated __init and not used by any module,
> thus don't export it.
> 
> Remove not needed EXPORT_SYMBOL for prom_init_numa_memory() to fix the
> following section mismatch warning:
> 
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
> WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference
> from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
> The symbol prom_init_numa_memory is exported and annotated __init
> Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.
> 
> This is build on Linux 5.19-rc4.
> 
> Fixes: 6fbde6b492df ("MIPS: Loongson64: Move files to the top-level directory")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2: update the commit message and add Fixes tag
> 
>  arch/mips/loongson64/numa.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> index 69a5331..8f61e93 100644
> --- a/arch/mips/loongson64/numa.c
> +++ b/arch/mips/loongson64/numa.c
> @@ -196,7 +196,6 @@ void __init prom_init_numa_memory(void)
>  	pr_info("CP0_PageGrain: CP0 5.1 (0x%x)\n", read_c0_pagegrain());
>  	prom_meminit();
>  }
> -EXPORT_SYMBOL(prom_init_numa_memory);
>  
>  pg_data_t * __init arch_alloc_nodedata(int nid)
>  {
> -- 
> 2.1.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
