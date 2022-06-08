Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2F54284E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiFHHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiFHHiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6EEB1C2D56
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654671861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TBjmir8iDGZC/kDjtwTXCxIWSk19ldp3h7objj82UrQ=;
        b=CZvtWjpcK832gefgHb9DK8Ie4Eqi0PbffAtihs2Pqe/+w38XxOXVGw+AAMNWF7LGYEC/sz
        Obmy0m2rjqFmgdhGfwXxEDrj9PB4qz3TEE/+Qy9lDxsM+yfBx1gBDmu5m5f7EdwoCaqdSr
        8dfRArf3f9hbiAKW/wNkVHidNCdKFA0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-Mw-qPlKMMlaLY4Vq0STvZg-1; Wed, 08 Jun 2022 03:04:18 -0400
X-MC-Unique: Mw-qPlKMMlaLY4Vq0STvZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A723E1C0512E;
        Wed,  8 Jun 2022 07:04:17 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0BAF2166B26;
        Wed,  8 Jun 2022 07:04:16 +0000 (UTC)
Date:   Wed, 8 Jun 2022 15:04:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v5 2/6] mm: ioremap: Use more sensibly name in
 ioremap_prot()
Message-ID: <YqBJ69yExnm6O4n9@MiWiFi-R3L-srv>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
 <20220607125027.44946-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607125027.44946-3-wangkefeng.wang@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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
> Use more meaningful and sensibly naming phys_addr
                          ~~ sensible, typo
                          and please fix the subject too.
> instead addr in ioremap_prot().
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/asm-generic/io.h |  3 ++-
>  mm/ioremap.c             | 14 ++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 7ce93aaf69f8..b76379628a02 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -964,7 +964,8 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
>  
>  static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 5fe598ecd9b7..2d754b48d230 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -11,20 +11,21 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
>  {
>  	unsigned long offset, vaddr;
>  	phys_addr_t last_addr;
>  	struct vm_struct *area;
>  
>  	/* Disallow wrap-around or zero size */
> -	last_addr = addr + size - 1;
> -	if (!size || last_addr < addr)
> +	last_addr = phys_addr + size - 1;
> +	if (!size || last_addr < phys_addr)
>  		return NULL;
>  
>  	/* Page-align mappings */
> -	offset = addr & (~PAGE_MASK);
> -	addr -= offset;
> +	offset = phys_addr & (~PAGE_MASK);
> +	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
>  	area = get_vm_area_caller(size, VM_IOREMAP,
> @@ -33,7 +34,8 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
>  		return NULL;
>  	vaddr = (unsigned long)area->addr;
>  
> -	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
> +	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
> +			       __pgprot(prot))) {
>  		free_vm_area(area);
>  		return NULL;
>  	}
> -- 
> 2.35.3
> 
> 

