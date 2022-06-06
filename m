Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6D53E748
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiFFPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiFFPO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8DFC17DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654528465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wk21lmL5uU36CD8lVe7wGCPEFaiqg58cc32bIZsmo3E=;
        b=FunaO86BuF5wR/EQZ05py0vM0j+fzF9DDskOeRlodkDD7AzWXUSTsQ7XgdLeJfxLr4E6vW
        jpfhDmyyc+vJDYGEIZSFfo8eyMzykJ54UqlWzdtG1BJGaBweq8KKoCOJV2+8+9jzEqf1f3
        fyqKHqeSuWh9uoYEYf7bkfQUprM/eq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-vs9e1VvdNA-DS8MsSeislQ-1; Mon, 06 Jun 2022 11:14:22 -0400
X-MC-Unique: vs9e1VvdNA-DS8MsSeislQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A1C1100BABB;
        Mon,  6 Jun 2022 15:14:22 +0000 (UTC)
Received: from localhost (ovpn-14-4.pek2.redhat.com [10.72.14.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 946081410DDB;
        Mon,  6 Jun 2022 15:14:21 +0000 (UTC)
Date:   Mon, 6 Jun 2022 23:14:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v4 4/6] mm: ioremap: Add ioremap/iounmap_allowed()
Message-ID: <Yp4Zyt/WJjy3Mj4Y@MiWiFi-R3L-srv>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
 <20220606074815.139265-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606074815.139265-5-wangkefeng.wang@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/22 at 03:48pm, Kefeng Wang wrote:
> Add special hook for architecture to verify addr, size or prot
> when ioremap() or iounmap(), which will make the generic ioremap
> more useful.
> 
>   ioremap_allowed() return an int,
>     - NULL means continue to remap
>     - error code means skip remap and return directly
>   iounmap_allowed() return an int,
>     - 0 means continue to vunmap
>     - error code means skip vunmap and return directly

Aren't they bool type function and better return bool value?

> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/asm-generic/io.h | 25 +++++++++++++++++++++++++
>  mm/ioremap.c             | 13 ++++++++++---
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index e6ffa2519f08..9429387a3e65 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -964,6 +964,31 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> +/*
> + * Arch code can implement the following two special hooks when using GENERIC_IOREMAP
> + * ioremap_allowed() return an int,
> + *   - 0 means continue to remap
> + *   - error code means skip remap and return directly
> + * iounmap_allowed() return an int,
> + *   - 0 means continue to vunmap
> + *   - error code means skip vunmap and return directly
> + */
> +#ifndef ioremap_allowed
> +#define ioremap_allowed ioremap_allowed
> +static inline int ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#ifndef iounmap_allowed
> +#define iounmap_allowed iounmap_allowed
> +static inline int iounmap_allowed(void __iomem *addr)
> +{
> +	return 0;
> +}
> +#endif
> +
>  void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
>  
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 7cb9996b0c12..196c93c0beb8 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -27,8 +27,10 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> -	area = get_vm_area_caller(size, VM_IOREMAP,
> -			__builtin_return_address(0));
> +	if (ioremap_allowed(phys_addr, size, prot))
> +		return NULL;
> +
> +	area = get_vm_area_caller(size, VM_IOREMAP, __builtin_return_address(0));
>  	if (!area)
>  		return NULL;
>  	vaddr = (unsigned long)area->addr;
> @@ -45,6 +47,11 @@ EXPORT_SYMBOL(ioremap_prot);
>  
>  void iounmap(volatile void __iomem *addr)
>  {
> -	vunmap((void *)((unsigned long)addr & PAGE_MASK));
> +	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
> +
> +	if (iounmap_allowed(vaddr))
> +		return;
> +
> +	vunmap((void __force *)vaddr);
>  }
>  EXPORT_SYMBOL(iounmap);
> -- 
> 2.35.3
> 
> 

