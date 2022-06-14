Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7BF54B7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbiFNRh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiFNRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:37:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666240929
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:37:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y32so15074323lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2SzfmoDL2dLQibAHg1HMX34jSgQpXLHSJTa0hnPPaZo=;
        b=SPvqs3hDB616FYLgmmYbcC/RzSpxhzSna6CANMui7kGP2YMHcZRHNsR150910Qvz5w
         SY8K9ZCSiBxBxrOvcixWZL6RlN9kw9vi2vsuias536X/21wF4rBf9vqTwoSQAw1FD0Ae
         S13Ioxwln8cWZm/7sApzduWIszW1ahHhPAAYnUy9YruYu8w0bjyuon0tHjFSuC21BeW7
         Lpstp63hj5YjFYvuRNZavdwHb+t6MgfiV2h5POW19XOu4qCsXPqcjINoSkeFMPtu4SXc
         k3LW+zDQ8ij9M2tJMMIEZCaQ4qdVqoGE9nOfUbcjvB7tvgp6Jil3GBF00RGhhP2N+Ucu
         dhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2SzfmoDL2dLQibAHg1HMX34jSgQpXLHSJTa0hnPPaZo=;
        b=TUUFWvTL5gHFxdBFM8MolqAU5JUeH7RwCALoGia5PSxusutCYnL0ffVP5MrxcwS9Tx
         IAQS95QbxWVzdOxjpdkikjFgcAqEctrSN3zxaLFSvyhbDTm3vA/otQqcMTtwLATYJQox
         EzXK1iiLXn6GVPHIkTkmm8wKbQvUAHhQ/lE4uVGBW+S+GlCzwK11f5Zj3r2Z2kuKKXlp
         YPfqYQZ07VSZhxyiI7+yTcLqMTpyGk8oG0s2cTAXJJfv5tBpEbYdNgwBKkkx7k74ls4T
         OO4AtLdkrqHheE5H0/ENW+Ee3DQvFOOmf7ldye3iBIXxwEuEUhuVL+lfQ9VgSxKXq5Gz
         5TzA==
X-Gm-Message-State: AOAM532mIr01fZPTYgpQ3VnLmELArVzWSKbpSqAgKaSQp6G20nH4Mqyv
        59HMR6ahJWCtu2h0FmE+KP0=
X-Google-Smtp-Source: ABdhPJzxjBAaNRz4M4+MxpOtWuRn0k5C1JJPGEjGF8I1hMgfqpcL1XgchfmaGegl5ccHS2Im0c1cQg==
X-Received: by 2002:ac2:4f11:0:b0:479:3554:79d with SMTP id k17-20020ac24f11000000b004793554079dmr3746472lfr.417.1655228233606;
        Tue, 14 Jun 2022 10:37:13 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id v22-20020a2e9256000000b002554b7b9a16sm1426680ljg.73.2022.06.14.10.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:37:13 -0700 (PDT)
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
 <00c14b91-4cf2-179c-749d-593db853e42e@gmail.com>
 <alpine.DEB.2.22.394.2206101709210.756493@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <a51dec23-c543-b571-8047-59f39abb0bee@gmail.com>
Date:   Tue, 14 Jun 2022 20:37:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2206101709210.756493@ubuntu-linux-20-04-desktop>
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


On 11.06.22 03:12, Stefano Stabellini wrote:


Hello Stefano


> On Wed, 8 Jun 2022, Oleksandr wrote:
>> 2. Drop the "page_list" entirely and use "dma_pool" for all (contiguous and
>> non-contiguous) allocations. After all, all pages are initially contiguous in
>> fill_list() as they are built from the resource. This changes behavior for all
>> users of xen_alloc_unpopulated_pages()
>>
>> Below the diff for unpopulated-alloc.c. The patch is also available at:
>>
>> https://github.com/otyshchenko1/linux/commit/7be569f113a4acbdc4bcb9b20cb3995b3151387a
>>
>>
>> diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
>> index a39f2d3..ab5c7bd 100644
>> --- a/drivers/xen/unpopulated-alloc.c
>> +++ b/drivers/xen/unpopulated-alloc.c
>> @@ -1,5 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> +#include <linux/dma-mapping.h>
>>   #include <linux/errno.h>
>> +#include <linux/genalloc.h>
>>   #include <linux/gfp.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mm.h>
>> @@ -13,8 +15,8 @@
>>   #include <xen/xen.h>
>>
>>   static DEFINE_MUTEX(list_lock);
>> -static struct page *page_list;
>> -static unsigned int list_count;
>> +
>> +static struct gen_pool *dma_pool;
>>
>>   static struct resource *target_resource;
>>
>> @@ -36,7 +38,7 @@ static int fill_list(unsigned int nr_pages)
>>          struct dev_pagemap *pgmap;
>>          struct resource *res, *tmp_res = NULL;
>>          void *vaddr;
>> -       unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
>> +       unsigned int alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
>>          struct range mhp_range;
>>          int ret;
>>
>> @@ -106,6 +108,7 @@ static int fill_list(unsigned int nr_pages)
>>            * conflict with any devices.
>>            */
>>          if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>> +               unsigned int i;
>>                  xen_pfn_t pfn = PFN_DOWN(res->start);
>>
>>                  for (i = 0; i < alloc_pages; i++) {
>> @@ -125,16 +128,17 @@ static int fill_list(unsigned int nr_pages)
>>                  goto err_memremap;
>>          }
>>
>> -       for (i = 0; i < alloc_pages; i++) {
>> -               struct page *pg = virt_to_page(vaddr + PAGE_SIZE * i);
>> -
>> -               pg->zone_device_data = page_list;
>> -               page_list = pg;
>> -               list_count++;
>> +       ret = gen_pool_add_virt(dma_pool, (unsigned long)vaddr, res->start,
>> +                       alloc_pages * PAGE_SIZE, NUMA_NO_NODE);
>> +       if (ret) {
>> +               pr_err("Cannot add memory range to the pool\n");
>> +               goto err_pool;
>>          }
>>
>>          return 0;
>>
>> +err_pool:
>> +       memunmap_pages(pgmap);
>>   err_memremap:
>>          kfree(pgmap);
>>   err_pgmap:
>> @@ -149,51 +153,49 @@ static int fill_list(unsigned int nr_pages)
>>          return ret;
>>   }
>>
>> -/**
>> - * xen_alloc_unpopulated_pages - alloc unpopulated pages
>> - * @nr_pages: Number of pages
>> - * @pages: pages returned
>> - * @return 0 on success, error otherwise
>> - */
>> -int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>> +static int alloc_unpopulated_pages(unsigned int nr_pages, struct page
>> **pages,
>> +               bool contiguous)
>>   {
>>          unsigned int i;
>>          int ret = 0;
>> +       void *vaddr;
>> +       bool filled = false;
>>
>>          /*
>>           * Fallback to default behavior if we do not have any suitable
>> resource
>>           * to allocate required region from and as the result we won't be able
>> to
>>           * construct pages.
>>           */
>> -       if (!target_resource)
>> +       if (!target_resource) {
>> +               if (contiguous)
>> +                       return -ENODEV;
>> +
>>                  return xen_alloc_ballooned_pages(nr_pages, pages);
>> +       }
>>
>>          mutex_lock(&list_lock);
>> -       if (list_count < nr_pages) {
>> -               ret = fill_list(nr_pages - list_count);
>> +
>> +       while (!(vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages *
>> PAGE_SIZE))) {
>> +               if (filled)
>> +                       ret = -ENOMEM;
>> +               else {
>> +                       ret = fill_list(nr_pages);
>> +                       filled = true;
>> +               }
>>                  if (ret)
>>                          goto out;
>>          }
>>
>>          for (i = 0; i < nr_pages; i++) {
>> -               struct page *pg = page_list;
>> -
>> -               BUG_ON(!pg);
>> -               page_list = pg->zone_device_data;
>> -               list_count--;
>> -               pages[i] = pg;
>> +               pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
>>
>>   #ifdef CONFIG_XEN_HAVE_PVMMU
>>                  if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>> -                       ret = xen_alloc_p2m_entry(page_to_pfn(pg));
>> +                       ret = xen_alloc_p2m_entry(page_to_pfn(pages[i]));
>>                          if (ret < 0) {
>> -                               unsigned int j;
>> -
>> -                               for (j = 0; j <= i; j++) {
>> - pages[j]->zone_device_data = page_list;
>> -                                       page_list = pages[j];
>> -                                       list_count++;
>> -                               }
>> +                               /* XXX Do we need to zeroed pages[i]? */
>> +                               gen_pool_free(dma_pool, (unsigned long)vaddr,
>> +                                               nr_pages * PAGE_SIZE);
>>                                  goto out;
>>                          }
>>                  }
>> @@ -204,32 +206,89 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages,
>> struct page **pages)
>>          mutex_unlock(&list_lock);
>>          return ret;
>>   }
>> -EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
>>
>> -/**
>> - * xen_free_unpopulated_pages - return unpopulated pages
>> - * @nr_pages: Number of pages
>> - * @pages: pages to return
>> - */
>> -void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>> +static void free_unpopulated_pages(unsigned int nr_pages, struct page
>> **pages,
>> +               bool contiguous)
>>   {
>> -       unsigned int i;
>> -
>>          if (!target_resource) {
>> +               if (contiguous)
>> +                       return;
>> +
>>                  xen_free_ballooned_pages(nr_pages, pages);
>>                  return;
>>          }
>>
>>          mutex_lock(&list_lock);
>> -       for (i = 0; i < nr_pages; i++) {
>> -               pages[i]->zone_device_data = page_list;
>> -               page_list = pages[i];
>> -               list_count++;
>> +
>> +       /* XXX Do we need to check the range (gen_pool_has_addr)? */
>> +       if (contiguous)
>> +               gen_pool_free(dma_pool, (unsigned long)page_to_virt(pages[0]),
>> +                               nr_pages * PAGE_SIZE);
>> +       else {
>> +               unsigned int i;
>> +
>> +               for (i = 0; i < nr_pages; i++)
>> +                       gen_pool_free(dma_pool, (unsigned
>> long)page_to_virt(pages[i]),
>> +                                       PAGE_SIZE);
>>          }
>> +
>>          mutex_unlock(&list_lock);
>>   }
>> +
>> +/**
>> + * xen_alloc_unpopulated_pages - alloc unpopulated pages
>> + * @nr_pages: Number of pages
>> + * @pages: pages returned
>> + * @return 0 on success, error otherwise
>> + */
>> +int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>> +{
>> +       return alloc_unpopulated_pages(nr_pages, pages, false);
>> +}
>> +EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
>> +
>> +/**
>> + * xen_free_unpopulated_pages - return unpopulated pages
>> + * @nr_pages: Number of pages
>> + * @pages: pages to return
>> + */
>> +void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
>> +{
>> +       free_unpopulated_pages(nr_pages, pages, false);
>> +}
>>   EXPORT_SYMBOL(xen_free_unpopulated_pages);
>>
>> +/**
>> + * xen_alloc_unpopulated_dma_pages - alloc unpopulated DMAable pages
>> + * @dev: valid struct device pointer
>> + * @nr_pages: Number of pages
>> + * @pages: pages returned
>> + * @return 0 on success, error otherwise
>> + */
>> +int xen_alloc_unpopulated_dma_pages(struct device *dev, unsigned int
>> nr_pages,
>> +               struct page **pages)
>> +{
>> +       /* XXX Handle devices which support 64-bit DMA address only for now */
>> +       if (dma_get_mask(dev) != DMA_BIT_MASK(64))
>> +               return -EINVAL;
>> +
>> +       return alloc_unpopulated_pages(nr_pages, pages, true);
>> +}
>> +EXPORT_SYMBOL(xen_alloc_unpopulated_dma_pages);
>> +
>> +/**
>> + * xen_free_unpopulated_dma_pages - return unpopulated DMAable pages
>> + * @dev: valid struct device pointer
>> + * @nr_pages: Number of pages
>> + * @pages: pages to return
>> + */
>> +void xen_free_unpopulated_dma_pages(struct device *dev, unsigned int
>> nr_pages,
>> +               struct page **pages)
>> +{
>> +       free_unpopulated_pages(nr_pages, pages, true);
>> +}
>> +EXPORT_SYMBOL(xen_free_unpopulated_dma_pages);
>> +
>>   static int __init unpopulated_init(void)
>>   {
>>          int ret;
>> @@ -237,9 +296,19 @@ static int __init unpopulated_init(void)
>>          if (!xen_domain())
>>                  return -ENODEV;
>>
>> +       dma_pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
>> +       if (!dma_pool) {
>> +               pr_err("xen:unpopulated: Cannot create DMA pool\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       gen_pool_set_algo(dma_pool, gen_pool_best_fit, NULL);
>> +
>>          ret = arch_xen_unpopulated_init(&target_resource);
>>          if (ret) {
>>                  pr_err("xen:unpopulated: Cannot initialize target
>> resource\n");
>> +               gen_pool_destroy(dma_pool);
>> +               dma_pool = NULL;
>>                  target_resource = NULL;
>>          }
>>
>> [snip]
>>
>>
>> I think, regarding on the approach we would likely need to do some renaming
>> for fill_list, page_list, list_lock, etc.
>>
>>
>> Both options work in my Arm64 based environment, not sure regarding x86.
>> Or do we have another option here?
>> I would be happy to go any route. What do you think?
> The second option (use "dma_pool" for all) looks great, thank you for
> looking into it!


ok, great


May I please clarify a few moments before starting preparing non-RFC 
version:


1. According to the discussion at "[RFC PATCH 2/2] xen/grant-table: Use 
unpopulated DMAable pages instead of real RAM ones" we decided
to stay away from the "dma" in the name, also the second option (use 
"dma_pool" for all) implies dropping the "page_list" entirely, so I am 
going to do some renaming:

- 
s/xen_alloc_unpopulated_dma_pages()/xen_alloc_unpopulated_contiguous_pages()
- s/dma_pool/unpopulated_pool
- s/list_lock/pool_lock
- s/fill_list()/fill_pool()

Any objections?


2. I don't like much the fact that in free_unpopulated_pages() we have 
to free "page by page" if contiguous is false, but unfortunately we 
cannot avoid doing that.
I noticed that many users of unpopulated pages retain initially 
allocated pages[i] array, so it passed here absolutely unmodified since 
being allocated, but there is a code (for example, 
gnttab_page_cache_shrink() in grant-table.c) that can pass pages[i] 
which contains arbitrary pages.

static void free_unpopulated_pages(unsigned int nr_pages, struct page 
**pages,
         bool contiguous)
{

[snip]

     /* XXX Do we need to check the range (gen_pool_has_addr)? */
     if (contiguous)
         gen_pool_free(dma_pool, (unsigned long)page_to_virt(pages[0]),
                 nr_pages * PAGE_SIZE);
     else {
         unsigned int i;

         for (i = 0; i < nr_pages; i++)
             gen_pool_free(dma_pool, (unsigned long)page_to_virt(pages[i]),
                     PAGE_SIZE);
     }

[snip]

}

I think, it wouldn't be a big deal for the small allocations, but for 
the big allocations it might be not optimal for the speed.

What do you think if we update some places which always require big 
allocations to allocate (and free) contiguous pages instead?
The possible candidate is 
gem_create()/xen_drm_front_gem_free_object_unlocked() in 
drivers/gpu/drm/xen/xen_drm_front_gem.c.
OTOH I realize this might be inefficient use of resources. Or better not?


3. The alloc_unpopulated_pages() might be optimized for the 
non-contiguous allocations, currently we always try to allocate a single 
chunk even if contiguous is false.

static int alloc_unpopulated_pages(unsigned int nr_pages, struct page 
**pages,
         bool contiguous)
{

[snip]

     /* XXX: Optimize for non-contiguous allocations */
     while (!(vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages * 
PAGE_SIZE))) {
         if (filled)
             ret = -ENOMEM;
         else {
             ret = fill_list(nr_pages);
             filled = true;
         }
         if (ret)
             goto out;
     }

[snip]

}


But we can allocate "page by page" for the non-contiguous allocations, 
it might be not optimal for the speed, but would be optimal for the 
resource usage. What do you think?

static int alloc_unpopulated_pages(unsigned int nr_pages, struct page 
**pages,
         bool contiguous)
{

[snip]

     if (contiguous) {
         while (!(vaddr = (void *)gen_pool_alloc(dma_pool, nr_pages * 
PAGE_SIZE))) {
             if (filled)
                 ret = -ENOMEM;
             else {
                 ret = fill_list(nr_pages);
                 filled = true;
             }
             if (ret)
                 goto out;
         }

         for (i = 0; i < nr_pages; i++)
             pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
     } else {
         if (gen_pool_avail(dma_pool) < nr_pages) {
             ret = fill_list(nr_pages - gen_pool_avail(dma_pool));
             if (ret)
                 goto out;
         }

         for (i = 0; i < nr_pages; i++) {
             vaddr = (void *)gen_pool_alloc(dma_pool, PAGE_SIZE);
             if (!vaddr) {
                 while (i--)
                     gen_pool_free(dma_pool, (unsigned 
long)page_to_virt(pages[i]),
                             PAGE_SIZE);

                 ret = -ENOMEM;
                 goto out;
             }

             pages[i] = virt_to_page(vaddr);
         }
     }

[snip]

}


Thank you.

-- 
Regards,

Oleksandr Tyshchenko

