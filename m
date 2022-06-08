Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3329543B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiFHSMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiFHSMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:12:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD125C66
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:12:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e5so4484064wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vs8aNdWJ8iRamP5ksY+ZLfOeMGxldxBLBkpCKBVJgx0=;
        b=NpHi/hmApW89ypZglQsthe0FNCSYUduJalRn0hoBp/sZoaE7V/zou7LM6qyj7Jos6s
         K3qyyISpbYEuR50b6lm4sREXXOkKp5DQ58NFECl880IGBBI5XSvpiAkGSGP73tDPs+r1
         ojKvHib9YN45gExt7ak3Fz4N2yT4hbrbf7I1LahGSfMZhUBm3iTVgHQ5Ml1wdGkzENrE
         rnjUrQTg/Mje5hvAEMB8L0e9UL8D1WLUI06e09RUtPUsVZqPoPOBrX0w7XQyAIbqArcw
         kkCtjsNIO99V3LUWPbqvPDJP7ngGKlltaZVN/DwrjzFehRuQi7xjXUnZFPKNWPJZSIcK
         D/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vs8aNdWJ8iRamP5ksY+ZLfOeMGxldxBLBkpCKBVJgx0=;
        b=EEfhCm+e6TkYYGO9OOqAM7cISjtWVaOpi9OIYOtmiy/lpc973iS2Y/8G/mmmSlBPdO
         2Itx0r8NmpglQxRcsOpAf3ZX6E7G0b1z38hIxR/ATk34wK6ivGPwc8W1Aoo0hqzzlNfj
         HSAS3F2TyZ9EliFpiQ87SAMU7JVZEWcxX9e7IA7U2wCN2cxzhBf6/w2Po5H9mrSPOCEe
         at+9HHVWHxkTiDaGW92MooB82YwTJseP/OR0fFjiueaOJLjUNg1EXo4E/uAIy0r/sYuZ
         nrxEsRDvQN1YYgTn9L/URTrXlm9w6maa6FWjBEOU9tT7zvfhoDYqCPuP+RGXPbgFFcSi
         RjKQ==
X-Gm-Message-State: AOAM53233iGOln9DgGy5nMF8gM/u1QE5WLGsFBoINR5vx7xU3fhlnP1h
        UezjQUDnZHACYsJ4zgWExU8=
X-Google-Smtp-Source: ABdhPJz1i5kXRJ6WYRxpkMhq5FtRMZvrnoAPxdmuXKaqhaKa1neVILqztXvNAA6DJ6qS3iTMNBW89Q==
X-Received: by 2002:a7b:c205:0:b0:39c:506d:e294 with SMTP id x5-20020a7bc205000000b0039c506de294mr438462wmi.159.1654711946336;
        Wed, 08 Jun 2022 11:12:26 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d6a83000000b0020cfed0bb7fsm21866895wru.53.2022.06.08.11.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 11:12:25 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] xen/unpopulated-alloc: Introduce helpers for DMA
 allocations
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com>
 <1652810658-27810-2-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2206031420430.2783803@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <00c14b91-4cf2-179c-749d-593db853e42e@gmail.com>
Date:   Wed, 8 Jun 2022 21:12:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2206031420430.2783803@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.06.22 00:52, Stefano Stabellini wrote:


Hello Stefano

Thank you for having a look and sorry for the late response.

> On Tue, 17 May 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Add ability to allocate unpopulated DMAable (contiguous) pages
>> suitable for grant mapping into. This is going to be used by gnttab
>> code (see gnttab_dma_alloc_pages()).
>>
>> TODO: There is a code duplication in fill_dma_pool(). Also pool
>> oparations likely need to be protected by the lock.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>>   drivers/xen/unpopulated-alloc.c | 167 ++++++++++++++++++++++++++++++++++++++++
>>   include/xen/xen.h               |  15 ++++
>>   2 files changed, 182 insertions(+)
>>
>> diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
>> index a39f2d3..bca0198 100644
>> --- a/drivers/xen/unpopulated-alloc.c
>> +++ b/drivers/xen/unpopulated-alloc.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <linux/errno.h>
>> +#include <linux/genalloc.h>
>>   #include <linux/gfp.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mm.h>
>> @@ -16,6 +17,8 @@ static DEFINE_MUTEX(list_lock);
>>   static struct page *page_list;
>>   static unsigned int list_count;
>>   
>> +static struct gen_pool *dma_pool;
>> +
>>   static struct resource *target_resource;
>>   
>>   /*
>> @@ -230,6 +233,161 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>>   }
>>   EXPORT_SYMBOL(xen_free_unpopulated_pages);
>>   
>> +static int fill_dma_pool(unsigned int nr_pages)
>> +{
> I think we shouldn't need to add this function at all as we should be
> able to reuse fill_list even for contiguous pages. fill_list could
> always call gen_pool_add_virt before returning.


First of all, I agree that fill_dma_pool() has a lot in common with 
fill_list(), so we indeed can avoid code duplication (this was mentioned 
in TODO).
I am not quite sure regarding "to always call gen_pool_add_virt before 
returning" (does this mean that the same pages will be in the 
"page_list" and "dma_pool" simultaneously?),
but I completely agree that we can reuse fill_list() for contiguous 
pages as well slightly updating it.

Please see below.


>
>
>> +	struct dev_pagemap *pgmap;
>> +	struct resource *res, *tmp_res = NULL;
>> +	void *vaddr;
>> +	unsigned int alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
>> +	struct range mhp_range;
>> +	int ret;
>> +
>> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
>> +	if (!res)
>> +		return -ENOMEM;
>> +
>> +	res->name = "Xen DMA pool";
>> +	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>> +
>> +	mhp_range = mhp_get_pluggable_range(true);
>> +
>> +	ret = allocate_resource(target_resource, res,
>> +				alloc_pages * PAGE_SIZE, mhp_range.start, mhp_range.end,
>> +				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
>> +	if (ret < 0) {
>> +		pr_err("Cannot allocate new IOMEM resource\n");
>> +		goto err_resource;
>> +	}
>> +
>> +	/*
>> +	 * Reserve the region previously allocated from Xen resource to avoid
>> +	 * re-using it by someone else.
>> +	 */
>> +	if (target_resource != &iomem_resource) {
>> +		tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
>> +		if (!res) {
>> +			ret = -ENOMEM;
>> +			goto err_insert;
>> +		}
>> +
>> +		tmp_res->name = res->name;
>> +		tmp_res->start = res->start;
>> +		tmp_res->end = res->end;
>> +		tmp_res->flags = res->flags;
>> +
>> +		ret = request_resource(&iomem_resource, tmp_res);
>> +		if (ret < 0) {
>> +			pr_err("Cannot request resource %pR (%d)\n", tmp_res, ret);
>> +			kfree(tmp_res);
>> +			goto err_insert;
>> +		}
>> +	}
>> +
>> +	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>> +	if (!pgmap) {
>> +		ret = -ENOMEM;
>> +		goto err_pgmap;
>> +	}
>> +
>> +	pgmap->type = MEMORY_DEVICE_GENERIC;
>> +	pgmap->range = (struct range) {
>> +		.start = res->start,
>> +		.end = res->end,
>> +	};
>> +	pgmap->nr_range = 1;
>> +	pgmap->owner = res;
>> +
>> +	vaddr = memremap_pages(pgmap, NUMA_NO_NODE);
>> +	if (IS_ERR(vaddr)) {
>> +		pr_err("Cannot remap memory range\n");
>> +		ret = PTR_ERR(vaddr);
>> +		goto err_memremap;
>> +	}
>> +
>> +	ret = gen_pool_add_virt(dma_pool, (unsigned long)vaddr, res->start,
>> +			alloc_pages * PAGE_SIZE, NUMA_NO_NODE);
>> +	if (ret)
>> +		goto err_pool;
>> +
>> +	return 0;
>> +
>> +err_pool:
>> +	memunmap_pages(pgmap);
>> +err_memremap:
>> +	kfree(pgmap);
>> +err_pgmap:
>> +	if (tmp_res) {
>> +		release_resource(tmp_res);
>> +		kfree(tmp_res);
>> +	}
>> +err_insert:
>> +	release_resource(res);
>> +err_resource:
>> +	kfree(res);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * xen_alloc_unpopulated_dma_pages - alloc unpopulated DMAable pages
>> + * @dev: valid struct device pointer
>> + * @nr_pages: Number of pages
>> + * @pages: pages returned
>> + * @return 0 on success, error otherwise
>> + */
>> +int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
>> +		struct page **pages)
>> +{
>> +	void *vaddr;
>> +	bool filled = false;
>> +	unsigned int i;
>> +	int ret;
>
> Also probably it might be better if xen_alloc_unpopulated_pages and
> xen_alloc_unpopulated_dma_pages shared the implementation. Something
> along these lines:
>
> int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
> {
>      return _xen_alloc_unpopulated_pages(nr_pages, pages, false);
> }
>
> int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
> 		struct page **pages)
> {
>      return _xen_alloc_unpopulated_pages(nr_pages, pages, true);
> }

I think, this makes sense, although it depends on how the resulting 
_xen_alloc_unpopulated_pages() will look like. I'd 
s/_xen_alloc_unpopulated_pages/alloc_unpopulated_pages

Please see below.


>
> static int _xen_alloc_unpopulated_pages(unsigned int nr_pages,
>          struct page **pages, bool contiguous)
> {
> 	unsigned int i;
> 	int ret = 0;
>
>      if (contiguous && !xen_feature(XENFEAT_auto_translated_physmap))
>          return -EINVAL;
>
> 	/*
> 	 * Fallback to default behavior if we do not have any suitable resource
> 	 * to allocate required region from and as the result we won't be able to
> 	 * construct pages.
> 	 */
> 	if (!target_resource) {
>          if (contiguous)
>              return -EINVAL;
> 		return xen_alloc_ballooned_pages(nr_pages, pages);
>      }
>
> 	mutex_lock(&list_lock);
> 	if (list_count < nr_pages) {
> 		ret = fill_list(nr_pages - list_count);

As I understand, this might not work if we need contiguous pages. The 
check might not be precise as "list_count" is a number of available 
pages in the list, which are not guaranteed to be contiguous, also the 
amount of pages to be added to the pool here "nr_pages - list_count" 
might not be enough to allocate contiguous region with "nr_pages" size.


> 		if (ret)
> 			goto out;
> 	}
>
>      if (contiguous) {
>          vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages * PAGE_SIZE);
>
>          for (i = 0; i < nr_pages; i++)
>              pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
>      } else {
>          for (i = 0; i < nr_pages; i++) {
>              struct page *pg = page_list;
>
>              BUG_ON(!pg);
>              page_list = pg->zone_device_data;
>              list_count--;
>              pages[i] = pg;

I think, if we keep the same pages in the "page_list" and "dma_pool" 
simultaneously we will need to reflect that here, otherwise we might end 
up reusing already allocated pages.
What I mean is if we allocate pages from "dma_pool" we will need to 
remove them from the "page_list" as well and vice versa, so this might 
add a complexity to the code. I or missed something?



According to the suggestions I see two options, both follow suggestion 
where xen_alloc(free)_unpopulated_pages() and 
xen_alloc(free)_unpopulated_dma_pages() share the implementation.

1. Keep "page_list" and "dma_pool" separately. So they don't share 
pages. Like how it was implemented in current patch but with eliminating 
both TODOs. This doesn't change behavior for all users of 
xen_alloc_unpopulated_pages().

Below the diff for unpopulated-alloc.c. The patch is also available at:

https://github.com/otyshchenko1/linux/commit/1c629abc37478c108a5f4c37ae8076b766c4d5cc


diff --git a/drivers/xen/unpopulated-alloc.c 
b/drivers/xen/unpopulated-alloc.c
index a39f2d3..c3a86c09 100644
--- a/drivers/xen/unpopulated-alloc.c
+++ b/drivers/xen/unpopulated-alloc.c
@@ -1,5 +1,7 @@
  // SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
  #include <linux/errno.h>
+#include <linux/genalloc.h>
  #include <linux/gfp.h>
  #include <linux/kernel.h>
  #include <linux/mm.h>
@@ -16,6 +18,8 @@ static DEFINE_MUTEX(list_lock);
  static struct page *page_list;
  static unsigned int list_count;

+static struct gen_pool *dma_pool;
+
  static struct resource *target_resource;

  /*
@@ -31,7 +35,7 @@ int __weak __init arch_xen_unpopulated_init(struct 
resource **res)
         return 0;
  }

-static int fill_list(unsigned int nr_pages)
+static int fill_list(unsigned int nr_pages, bool use_pool)
  {
         struct dev_pagemap *pgmap;
         struct resource *res, *tmp_res = NULL;
@@ -125,12 +129,21 @@ static int fill_list(unsigned int nr_pages)
                 goto err_memremap;
         }

-       for (i = 0; i < alloc_pages; i++) {
-               struct page *pg = virt_to_page(vaddr + PAGE_SIZE * i);
+       if (use_pool) {
+               ret = gen_pool_add_virt(dma_pool, (unsigned long)vaddr, 
res->start,
+                               alloc_pages * PAGE_SIZE, NUMA_NO_NODE);
+               if (ret) {
+                       memunmap_pages(pgmap);
+                       goto err_memremap;
+               }
+       } else {
+               for (i = 0; i < alloc_pages; i++) {
+                       struct page *pg = virt_to_page(vaddr + PAGE_SIZE 
* i);

-               pg->zone_device_data = page_list;
-               page_list = pg;
-               list_count++;
+                       pg->zone_device_data = page_list;
+                       page_list = pg;
+                       list_count++;
+               }
         }

         return 0;
@@ -149,13 +162,8 @@ static int fill_list(unsigned int nr_pages)
         return ret;
  }

-/**
- * xen_alloc_unpopulated_pages - alloc unpopulated pages
- * @nr_pages: Number of pages
- * @pages: pages returned
- * @return 0 on success, error otherwise
- */
-int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+static int alloc_unpopulated_pages(unsigned int nr_pages, struct page 
**pages,
+               bool contiguous)
  {
         unsigned int i;
         int ret = 0;
@@ -165,71 +173,167 @@ int xen_alloc_unpopulated_pages(unsigned int 
nr_pages, struct page **pages)
          * to allocate required region from and as the result we won't 
be able to
          * construct pages.
          */
-       if (!target_resource)
+       if (!target_resource) {
+               if (contiguous)
+                       return -ENODEV;
+
                 return xen_alloc_ballooned_pages(nr_pages, pages);
+       }

         mutex_lock(&list_lock);
-       if (list_count < nr_pages) {
-               ret = fill_list(nr_pages - list_count);
-               if (ret)
-                       goto out;
-       }

-       for (i = 0; i < nr_pages; i++) {
-               struct page *pg = page_list;
+       if (contiguous) {
+               void *vaddr;
+               bool filled = false;
+
+               while (!(vaddr = (void *)gen_pool_alloc(dma_pool, 
nr_pages * PAGE_SIZE))) {
+                       if (filled)
+                               ret = -ENOMEM;
+                       else {
+                               ret = fill_list(nr_pages, true);
+                               filled = true;
+                       }
+                       if (ret)
+                               goto out;
+               }

-               BUG_ON(!pg);
-               page_list = pg->zone_device_data;
-               list_count--;
-               pages[i] = pg;
+               for (i = 0; i < nr_pages; i++) {
+                       pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);

  #ifdef CONFIG_XEN_HAVE_PVMMU
-               if (!xen_feature(XENFEAT_auto_translated_physmap)) {
-                       ret = xen_alloc_p2m_entry(page_to_pfn(pg));
-                       if (ret < 0) {
-                               unsigned int j;
-
-                               for (j = 0; j <= i; j++) {
- pages[j]->zone_device_data = page_list;
-                                       page_list = pages[j];
-                                       list_count++;
+                       if (!xen_feature(XENFEAT_auto_translated_physmap)) {
+                               ret = 
xen_alloc_p2m_entry(page_to_pfn(pages[i]));
+                               if (ret < 0) {
+                                       /* XXX Do we need to zeroed 
pages[i]? */
+                                       gen_pool_free(dma_pool, 
(unsigned long)vaddr,
+                                                       nr_pages * 
PAGE_SIZE);
+                                       goto out;
                                 }
-                               goto out;
                         }
+#endif
+               }
+       } else {
+               if (list_count < nr_pages) {
+                       ret = fill_list(nr_pages - list_count, false);
+                       if (ret)
+                               goto out;
                 }
+
+               for (i = 0; i < nr_pages; i++) {
+                       struct page *pg = page_list;
+
+                       BUG_ON(!pg);
+                       page_list = pg->zone_device_data;
+                       list_count--;
+                       pages[i] = pg;
+
+#ifdef CONFIG_XEN_HAVE_PVMMU
+                       if (!xen_feature(XENFEAT_auto_translated_physmap)) {
+                               ret = xen_alloc_p2m_entry(page_to_pfn(pg));
+                               if (ret < 0) {
+                                       unsigned int j;
+
+                                       for (j = 0; j <= i; j++) {
+ pages[j]->zone_device_data = page_list;
+                                               page_list = pages[j];
+                                               list_count++;
+                                       }
+                                       goto out;
+                               }
+                       }
  #endif
+               }
         }

  out:
         mutex_unlock(&list_lock);
         return ret;
  }
-EXPORT_SYMBOL(xen_alloc_unpopulated_pages);

-/**
- * xen_free_unpopulated_pages - return unpopulated pages
- * @nr_pages: Number of pages
- * @pages: pages to return
- */
-void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+static void free_unpopulated_pages(unsigned int nr_pages, struct page 
**pages,
+               bool contiguous)
  {
-       unsigned int i;
-
         if (!target_resource) {
+               if (contiguous)
+                       return;
+
                 xen_free_ballooned_pages(nr_pages, pages);
                 return;
         }

         mutex_lock(&list_lock);
-       for (i = 0; i < nr_pages; i++) {
-               pages[i]->zone_device_data = page_list;
-               page_list = pages[i];
-               list_count++;
+
+       /* XXX Do we need to check the range (gen_pool_has_addr)? */
+       if (contiguous)
+               gen_pool_free(dma_pool, (unsigned 
long)page_to_virt(pages[0]),
+                               nr_pages * PAGE_SIZE);
+       else {
+               unsigned int i;
+
+               for (i = 0; i < nr_pages; i++) {
+                       pages[i]->zone_device_data = page_list;
+                       page_list = pages[i];
+                       list_count++;
+               }
         }
+
         mutex_unlock(&list_lock);
  }
+
+/**
+ * xen_alloc_unpopulated_pages - alloc unpopulated pages
+ * @nr_pages: Number of pages
+ * @pages: pages returned
+ * @return 0 on success, error otherwise
+ */
+int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+{
+       return alloc_unpopulated_pages(nr_pages, pages, false);
+}
+EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
+
+/**
+ * xen_free_unpopulated_pages - return unpopulated pages
+ * @nr_pages: Number of pages
+ * @pages: pages to return
+ */
+void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+{
+       free_unpopulated_pages(nr_pages, pages, false);
+}
  EXPORT_SYMBOL(xen_free_unpopulated_pages);

+/**
+ * xen_alloc_unpopulated_dma_pages - alloc unpopulated DMAable pages
+ * @dev: valid struct device pointer
+ * @nr_pages: Number of pages
+ * @pages: pages returned
+ * @return 0 on success, error otherwise
+ */
+int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int 
nr_pages,
+               struct page **pages)
+{
+       /* XXX Handle devices which support 64-bit DMA address only for 
now */
+       if (dma_get_mask(dev) != DMA_BIT_MASK(64))
+               return -EINVAL;
+
+       return alloc_unpopulated_pages(nr_pages, pages, true);
+}
+EXPORT_SYMBOL(xen_alloc_unpopulated_dma_pages);
+
+/**
+ * xen_free_unpopulated_dma_pages - return unpopulated DMAable pages
+ * @dev: valid struct device pointer
+ * @nr_pages: Number of pages
+ * @pages: pages to return
+ */
+void xen_free_unpopulated_dma_pages(struct device *dev, unsigned int 
nr_pages,
+               struct page **pages)
+{
+       free_unpopulated_pages(nr_pages, pages, true);
+}
+EXPORT_SYMBOL(xen_free_unpopulated_dma_pages);
+
  static int __init unpopulated_init(void)
  {
         int ret;
@@ -237,9 +341,19 @@ static int __init unpopulated_init(void)
         if (!xen_domain())
                 return -ENODEV;

+       dma_pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+       if (!dma_pool) {
+               pr_err("xen:unpopulated: Cannot create DMA pool\n");
+               return -ENOMEM;
+       }
+
+       gen_pool_set_algo(dma_pool, gen_pool_best_fit, NULL);
+
         ret = arch_xen_unpopulated_init(&target_resource);
         if (ret) {
                 pr_err("xen:unpopulated: Cannot initialize target 
resource\n");
+               gen_pool_destroy(dma_pool);
+               dma_pool = NULL;
                 target_resource = NULL;
         }

[snip]


2. Drop the "page_list" entirely and use "dma_pool" for all (contiguous 
and non-contiguous) allocations. After all, all pages are initially 
contiguous in fill_list() as they are built from the resource. This 
changes behavior for all users of xen_alloc_unpopulated_pages()

Below the diff for unpopulated-alloc.c. The patch is also available at:

https://github.com/otyshchenko1/linux/commit/7be569f113a4acbdc4bcb9b20cb3995b3151387a


diff --git a/drivers/xen/unpopulated-alloc.c 
b/drivers/xen/unpopulated-alloc.c
index a39f2d3..ab5c7bd 100644
--- a/drivers/xen/unpopulated-alloc.c
+++ b/drivers/xen/unpopulated-alloc.c
@@ -1,5 +1,7 @@
  // SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
  #include <linux/errno.h>
+#include <linux/genalloc.h>
  #include <linux/gfp.h>
  #include <linux/kernel.h>
  #include <linux/mm.h>
@@ -13,8 +15,8 @@
  #include <xen/xen.h>

  static DEFINE_MUTEX(list_lock);
-static struct page *page_list;
-static unsigned int list_count;
+
+static struct gen_pool *dma_pool;

  static struct resource *target_resource;

@@ -36,7 +38,7 @@ static int fill_list(unsigned int nr_pages)
         struct dev_pagemap *pgmap;
         struct resource *res, *tmp_res = NULL;
         void *vaddr;
-       unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
+       unsigned int alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
         struct range mhp_range;
         int ret;

@@ -106,6 +108,7 @@ static int fill_list(unsigned int nr_pages)
           * conflict with any devices.
           */
         if (!xen_feature(XENFEAT_auto_translated_physmap)) {
+               unsigned int i;
                 xen_pfn_t pfn = PFN_DOWN(res->start);

                 for (i = 0; i < alloc_pages; i++) {
@@ -125,16 +128,17 @@ static int fill_list(unsigned int nr_pages)
                 goto err_memremap;
         }

-       for (i = 0; i < alloc_pages; i++) {
-               struct page *pg = virt_to_page(vaddr + PAGE_SIZE * i);
-
-               pg->zone_device_data = page_list;
-               page_list = pg;
-               list_count++;
+       ret = gen_pool_add_virt(dma_pool, (unsigned long)vaddr, res->start,
+                       alloc_pages * PAGE_SIZE, NUMA_NO_NODE);
+       if (ret) {
+               pr_err("Cannot add memory range to the pool\n");
+               goto err_pool;
         }

         return 0;

+err_pool:
+       memunmap_pages(pgmap);
  err_memremap:
         kfree(pgmap);
  err_pgmap:
@@ -149,51 +153,49 @@ static int fill_list(unsigned int nr_pages)
         return ret;
  }

-/**
- * xen_alloc_unpopulated_pages - alloc unpopulated pages
- * @nr_pages: Number of pages
- * @pages: pages returned
- * @return 0 on success, error otherwise
- */
-int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+static int alloc_unpopulated_pages(unsigned int nr_pages, struct page 
**pages,
+               bool contiguous)
  {
         unsigned int i;
         int ret = 0;
+       void *vaddr;
+       bool filled = false;

         /*
          * Fallback to default behavior if we do not have any suitable 
resource
          * to allocate required region from and as the result we won't 
be able to
          * construct pages.
          */
-       if (!target_resource)
+       if (!target_resource) {
+               if (contiguous)
+                       return -ENODEV;
+
                 return xen_alloc_ballooned_pages(nr_pages, pages);
+       }

         mutex_lock(&list_lock);
-       if (list_count < nr_pages) {
-               ret = fill_list(nr_pages - list_count);
+
+       while (!(vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages * 
PAGE_SIZE))) {
+               if (filled)
+                       ret = -ENOMEM;
+               else {
+                       ret = fill_list(nr_pages);
+                       filled = true;
+               }
                 if (ret)
                         goto out;
         }

         for (i = 0; i < nr_pages; i++) {
-               struct page *pg = page_list;
-
-               BUG_ON(!pg);
-               page_list = pg->zone_device_data;
-               list_count--;
-               pages[i] = pg;
+               pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);

  #ifdef CONFIG_XEN_HAVE_PVMMU
                 if (!xen_feature(XENFEAT_auto_translated_physmap)) {
-                       ret = xen_alloc_p2m_entry(page_to_pfn(pg));
+                       ret = xen_alloc_p2m_entry(page_to_pfn(pages[i]));
                         if (ret < 0) {
-                               unsigned int j;
-
-                               for (j = 0; j <= i; j++) {
- pages[j]->zone_device_data = page_list;
-                                       page_list = pages[j];
-                                       list_count++;
-                               }
+                               /* XXX Do we need to zeroed pages[i]? */
+                               gen_pool_free(dma_pool, (unsigned 
long)vaddr,
+                                               nr_pages * PAGE_SIZE);
                                 goto out;
                         }
                 }
@@ -204,32 +206,89 @@ int xen_alloc_unpopulated_pages(unsigned int 
nr_pages, struct page **pages)
         mutex_unlock(&list_lock);
         return ret;
  }
-EXPORT_SYMBOL(xen_alloc_unpopulated_pages);

-/**
- * xen_free_unpopulated_pages - return unpopulated pages
- * @nr_pages: Number of pages
- * @pages: pages to return
- */
-void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+static void free_unpopulated_pages(unsigned int nr_pages, struct page 
**pages,
+               bool contiguous)
  {
-       unsigned int i;
-
         if (!target_resource) {
+               if (contiguous)
+                       return;
+
                 xen_free_ballooned_pages(nr_pages, pages);
                 return;
         }

         mutex_lock(&list_lock);
-       for (i = 0; i < nr_pages; i++) {
-               pages[i]->zone_device_data = page_list;
-               page_list = pages[i];
-               list_count++;
+
+       /* XXX Do we need to check the range (gen_pool_has_addr)? */
+       if (contiguous)
+               gen_pool_free(dma_pool, (unsigned 
long)page_to_virt(pages[0]),
+                               nr_pages * PAGE_SIZE);
+       else {
+               unsigned int i;
+
+               for (i = 0; i < nr_pages; i++)
+                       gen_pool_free(dma_pool, (unsigned 
long)page_to_virt(pages[i]),
+                                       PAGE_SIZE);
         }
+
         mutex_unlock(&list_lock);
  }
+
+/**
+ * xen_alloc_unpopulated_pages - alloc unpopulated pages
+ * @nr_pages: Number of pages
+ * @pages: pages returned
+ * @return 0 on success, error otherwise
+ */
+int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+{
+       return alloc_unpopulated_pages(nr_pages, pages, false);
+}
+EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
+
+/**
+ * xen_free_unpopulated_pages - return unpopulated pages
+ * @nr_pages: Number of pages
+ * @pages: pages to return
+ */
+void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+{
+       free_unpopulated_pages(nr_pages, pages, false);
+}
  EXPORT_SYMBOL(xen_free_unpopulated_pages);

+/**
+ * xen_alloc_unpopulated_dma_pages - alloc unpopulated DMAable pages
+ * @dev: valid struct device pointer
+ * @nr_pages: Number of pages
+ * @pages: pages returned
+ * @return 0 on success, error otherwise
+ */
+int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int 
nr_pages,
+               struct page **pages)
+{
+       /* XXX Handle devices which support 64-bit DMA address only for 
now */
+       if (dma_get_mask(dev) != DMA_BIT_MASK(64))
+               return -EINVAL;
+
+       return alloc_unpopulated_pages(nr_pages, pages, true);
+}
+EXPORT_SYMBOL(xen_alloc_unpopulated_dma_pages);
+
+/**
+ * xen_free_unpopulated_dma_pages - return unpopulated DMAable pages
+ * @dev: valid struct device pointer
+ * @nr_pages: Number of pages
+ * @pages: pages to return
+ */
+void xen_free_unpopulated_dma_pages(struct device *dev, unsigned int 
nr_pages,
+               struct page **pages)
+{
+       free_unpopulated_pages(nr_pages, pages, true);
+}
+EXPORT_SYMBOL(xen_free_unpopulated_dma_pages);
+
  static int __init unpopulated_init(void)
  {
         int ret;
@@ -237,9 +296,19 @@ static int __init unpopulated_init(void)
         if (!xen_domain())
                 return -ENODEV;

+       dma_pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+       if (!dma_pool) {
+               pr_err("xen:unpopulated: Cannot create DMA pool\n");
+               return -ENOMEM;
+       }
+
+       gen_pool_set_algo(dma_pool, gen_pool_best_fit, NULL);
+
         ret = arch_xen_unpopulated_init(&target_resource);
         if (ret) {
                 pr_err("xen:unpopulated: Cannot initialize target 
resource\n");
+               gen_pool_destroy(dma_pool);
+               dma_pool = NULL;
                 target_resource = NULL;
         }

[snip]


I think, regarding on the approach we would likely need to do some 
renaming for fill_list, page_list, list_lock, etc.


Both options work in my Arm64 based environment, not sure regarding x86.
Or do we have another option here?
I would be happy to go any route. What do you think?


>
>      #ifdef CONFIG_XEN_HAVE_PVMMU
>              if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>                  ret = xen_alloc_p2m_entry(page_to_pfn(pg));
>                  if (ret < 0) {
>                      unsigned int j;
>
>                      for (j = 0; j <= i; j++) {
>                          pages[j]->zone_device_data = page_list;
>                          page_list = pages[j];
>                          list_count++;
>                      }
>                      goto out;
>                  }
>              }
>      #endif
>          }
>      }
>
> out:
> 	mutex_unlock(&list_lock);
> 	return ret;
> }
>
> 	
>
>> +	if (!dma_pool)
>> +		return -ENODEV;
>> +
>> +	/* XXX Handle devices which support 64-bit DMA address only for now */
>> +	if (dma_get_mask(dev) != DMA_BIT_MASK(64))
>> +		return -EINVAL;
>> +
>> +	while (!(vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages * PAGE_SIZE))) {
>> +		if (filled)
>> +			return -ENOMEM;
>> +		else {
>> +			ret = fill_dma_pool(nr_pages);
>> +			if (ret)
>> +				return ret;
>> +
>> +			filled = true;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < nr_pages; i++)
>> +		pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(xen_alloc_unpopulated_dma_pages);
>> +
>> +/**
>> + * xen_free_unpopulated_dma_pages - return unpopulated DMAable pages
>> + * @dev: valid struct device pointer
>> + * @nr_pages: Number of pages
>> + * @pages: pages to return
>> + */
>> +void xen_free_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
>> +		struct page **pages)
>> +{
>> +	void *vaddr;
>> +
>> +	if (!dma_pool)
>> +		return;
>> +
>> +	vaddr = page_to_virt(pages[0]);
>> +
>> +	gen_pool_free(dma_pool, (unsigned long)vaddr, nr_pages * PAGE_SIZE);
>> +}
>> +EXPORT_SYMBOL(xen_free_unpopulated_dma_pages);
>> +
>>   static int __init unpopulated_init(void)
>>   {
>>   	int ret;
>> @@ -241,8 +399,17 @@ static int __init unpopulated_init(void)
>>   	if (ret) {
>>   		pr_err("xen:unpopulated: Cannot initialize target resource\n");
>>   		target_resource = NULL;
>> +		return ret;
>>   	}
>>   
>> +	dma_pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
>> +	if (!dma_pool) {
>> +		pr_err("xen:unpopulated: Cannot create DMA pool\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	gen_pool_set_algo(dma_pool, gen_pool_best_fit, NULL);
>> +
>>   	return ret;
>>   }
>>   early_initcall(unpopulated_init);
>> diff --git a/include/xen/xen.h b/include/xen/xen.h
>> index a99bab8..a6a7a59 100644
>> --- a/include/xen/xen.h
>> +++ b/include/xen/xen.h
>> @@ -52,9 +52,15 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>>   extern u64 xen_saved_max_mem_size;
>>   #endif
>>   
>> +struct device;
>> +
>>   #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>>   int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>>   void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
>> +int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
>> +		struct page **pages);
>> +void xen_free_unpopulated_dma_pages(struct device *dev, unsigned int nr_pages,
>> +		struct page **pages);
>>   #include <linux/ioport.h>
>>   int arch_xen_unpopulated_init(struct resource **res);
>>   #else
>> @@ -69,6 +75,15 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
>>   {
>>   	xen_free_ballooned_pages(nr_pages, pages);
>>   }
>> +static inline int xen_alloc_unpopulated_dma_pages(struct device *dev,
>> +		unsigned int nr_pages, struct page **pages)
>> +{
>> +	return -1;
>> +}
>> +static inline void xen_free_unpopulated_dma_pages(struct device *dev,
>> +		unsigned int nr_pages, struct page **pages)
>> +{
>> +}
>>   #endif
> Given that we have these stubs, maybe we don't need to #ifdef the so
> much code in the next patch

ok, I will analyze


-- 
Regards,

Oleksandr Tyshchenko

