Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8756B04E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiGHB66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiGHB65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43E5073C;
        Thu,  7 Jul 2022 18:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 080976206B;
        Fri,  8 Jul 2022 01:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D984C3411E;
        Fri,  8 Jul 2022 01:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657245535;
        bh=581nZoa/QIS5ELgdL9caPtn7qbYWWd0p4FNJ0ipmNjQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X1yaLQ54EiXjodlehEyd/W8jwBqIH53CYezd6bkaw1qmmASUEHdkJXiAPxr3evVQd
         MbFp1QAFV1vKv2jeXS8a4cW6QBFlxzR6zo/ci4K9gSLFe1Rt0D0YKMsoZtZ8LnZHI0
         PNdzm4zBXN8JkHlapB8rTYvFktdiv8pkJdNmmfGdpXVoJUGHSoPUlOB236wciz7LtN
         G6BDp1Md0/IOoN0BxdTIZLxpU6j79g7GoLIL4i3j4GqhmbeVf7F9zIXs/t11kgfP/o
         p0RsJ6sJrjWsgjEfsRa7YhCfwmp7RkD0nUozJ9pGJrquWPYNmetvPLlgMAFTjTqcPG
         J/hKWkQnWowpw==
Message-ID: <d14f6884-348b-252a-5d37-707e71284b2d@kernel.org>
Date:   Fri, 8 Jul 2022 11:58:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MIPS: vdso: Utilize __pa() for gic_pfn
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707202759.1224809-1-f.fainelli@gmail.com>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20220707202759.1224809-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/22 06:27, Florian Fainelli wrote:
> The GIC user offset is mapped into every process' virtual address and is
> therefore part of the hot-path of arch_setup_additional_pages(). Utilize
> __pa() such that we are more optimal even when CONFIG_DEBUG_VIRTUAL is
> enabled, and while at it utilize PFN_DOWN() instead of open-coding the
> right shift by PAGE_SHIFT.
> 
> Reported-by: Greg Ungerer <gerg@kernel.org>
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Fixes the issue of warnings on every process start with CONFIG_DEBUG_VIRTUAL
enabled for me. Thanks. So if you want:

Acked-by: Greg Ungerer <gerg@kernel.org>
Tested-by: Greg Ungerer <gerg@kernel.org>

Regards
Greg



> ---
>   arch/mips/kernel/vdso.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 3d0cf471f2fe..b2cc2c2dd4bf 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -159,7 +159,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>   	/* Map GIC user page. */
>   	if (gic_size) {
>   		gic_base = (unsigned long)mips_gic_base + MIPS_GIC_USER_OFS;
> -		gic_pfn = virt_to_phys((void *)gic_base) >> PAGE_SHIFT;
> +		gic_pfn = PFN_DOWN(__pa(gic_base));
>   
>   		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
>   					 pgprot_noncached(vma->vm_page_prot));
