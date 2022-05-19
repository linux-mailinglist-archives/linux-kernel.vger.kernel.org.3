Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C152DD31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbiESSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244210AbiESSwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:52:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833766C8A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46948B8242C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F556C34100;
        Thu, 19 May 2022 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652986331;
        bh=hZUTwgstPmefXYn68fhv3dUuy+vLjWAINx3Yp8d24P4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ajpYm5ghpHHLfN9MHvfGa+lF4OCjo+Og0WWuBq4QCmTWJbC5oli7n8mhGzUSLTCyu
         EczWQRo+IKAoHhZ0s2gVn1GJDKffv4zTubfCFW7wtHpWxpMZQxvaOR1VDiXwHw2UTU
         RTxrjtt48l38rs6pPA4pa+cBz+ooIMWWvB45k1zI=
Date:   Thu, 19 May 2022 11:52:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <hch@infradead.org>, <arnd@arndb.de>, <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Message-Id: <20220519115210.a6e41d5a997921354400557e@linux-foundation.org>
In-Reply-To: <20220519082552.117736-5-wangkefeng.wang@huawei.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
        <20220519082552.117736-5-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 16:25:50 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Add special hook for architecture to verify or setup addr, size
> or prot when ioremap() or iounmap(), which will make the generic
> ioremap more useful.
> 
>   arch_ioremap() return a pointer,
>     - IS_ERR means return an error
>     - NULL means continue to remap
>     - a non-NULL, non-IS_ERR pointer is directly returned
>   arch_iounmap() return a int value,
>     - 0 means continue to vunmap
>     - error code means skip vunmap and return directly
> 
> ...
>
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -964,6 +964,30 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> +/*
> + * Arch code can implement the following two special hooks when using GENERIC_IOREMAP
> + * arch_ioremap() return a pointer,
> + *   - IS_ERR means return an error
> + *   - NULL means continue to remap
> + *   - a non-NULL, non-IS_ERR pointer is returned directly
> + * arch_iounmap() return a int,
> + *   - 0 means continue to vunmap
> + *   - error code means skip vunmap and return directly
> + */
> +#ifndef arch_ioremap
> +static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
> +{
> +	return NULL;
> +}

Maybe should do

	#define arch_ioremap arch_ioremap

here

> +#endif
> +
> +#ifndef arch_iounmap
> +static inline int arch_iounmap(void __iomem *addr)
> +{
> +	return 0;
> +}

and here.

It shouldn't matter a lot because this file has inclusion guards. 
However it seems tidier and perhaps other code will want to know
whether this was defined.  Dunno.


Otherwise, 

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Please take this patch and [2/6] and [3/6] via the appropriate arm tree.

