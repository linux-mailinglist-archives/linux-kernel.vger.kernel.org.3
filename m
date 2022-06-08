Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAC65424C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiFHGFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbiFHF5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DE0D213AE4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654661949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjie14sl+UUWdfLUeHqpm3M+18uxVtV8OsIS9/gQLdg=;
        b=J+botJCGuUPgC08bPQFnQMD+vAZTZTfRpNlN+q1/dB88vFlTxQIEMVQQQt7DmcUKcNZfkd
        CxNorDHOrhes/4Y9Gq1sl45iKN9CIZEIlWhpiNgfx43LW86jqD4wEMXkZOEIBN14lzJTIj
        iuSvY5MlT6BcbnRivRal9QWZSp20ux8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-vLs6zPBvNQGuXCS4wHjl9Q-1; Wed, 08 Jun 2022 00:19:05 -0400
X-MC-Unique: vLs6zPBvNQGuXCS4wHjl9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 645143C02B6D;
        Wed,  8 Jun 2022 04:19:05 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1357440CF8E8;
        Wed,  8 Jun 2022 04:19:03 +0000 (UTC)
Date:   Wed, 8 Jun 2022 12:18:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v5 4/6] mm: ioremap: Add ioremap/iounmap_allowed()
Message-ID: <YqAjM9+4jjWXbQty@MiWiFi-R3L-srv>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
 <20220607125027.44946-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607125027.44946-5-wangkefeng.wang@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/22 at 08:50pm, Kefeng Wang wrote:
> Add special hook for architecture to verify addr, size or prot
> when ioremap() or iounmap(), which will make the generic ioremap
> more useful.
> 
>   ioremap_allowed() return a bool,
>     - true means continue to remap
>     - false means skip remap and return directly
>   iounmap_allowed() return a bool,
>     - true means continue to vunmap
>     - false code means skip vunmap and return directly
> 
> Meanwhile, only vunmap the address when it is in vmalloc area
> as the generic ioremap only returns vmalloc addresses.

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/asm-generic/io.h | 26 ++++++++++++++++++++++++++
>  mm/ioremap.c             | 11 ++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index b76379628a02..db5b890eaff7 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -964,6 +964,32 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> +/*
> + * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> + * ioremap_allowed() return a bool,
> + *   - true means continue to remap
> + *   - false means skip remap and return directly
> + * iounmap_allowed() return a bool,
> + *   - true means continue to vunmap
> + *   - false means skip vunmap and return directly
> + */
> +#ifndef ioremap_allowed
> +#define ioremap_allowed ioremap_allowed
> +static inline bool ioremap_allowed(phys_addr_t phys_addr, size_t size,
> +				   unsigned long prot)
> +{
> +	return true;
> +}
> +#endif
> +
> +#ifndef iounmap_allowed
> +#define iounmap_allowed iounmap_allowed
> +static inline bool iounmap_allowed(void *addr)
> +{
> +	return true;
> +}
> +#endif
> +
>  void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  			   unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index e1d008e8f87f..8652426282cc 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -28,6 +28,9 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> +	if (!ioremap_allowed(phys_addr, size, prot))
> +		return NULL;
> +
>  	area = get_vm_area_caller(size, VM_IOREMAP,
>  			__builtin_return_address(0));
>  	if (!area)
> @@ -47,6 +50,12 @@ EXPORT_SYMBOL(ioremap_prot);
>  
>  void iounmap(volatile void __iomem *addr)
>  {
> -	vunmap((void *)((unsigned long)addr & PAGE_MASK));
> +	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
> +
> +	if (!iounmap_allowed(vaddr))
> +		return;
> +
> +	if (is_vmalloc_addr(vaddr))
> +		vunmap(vaddr);
>  }
>  EXPORT_SYMBOL(iounmap);
> -- 
> 2.35.3
> 
> 

