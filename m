Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6954B821
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350974AbiFNRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiFNRxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:53:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A827CEC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:53:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j20so10596177ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yTsZoLmlHNm+eqmO/1SbPV0SLUCIHibl+Wa6lk1x09s=;
        b=EIuc4MYa35sLsyJFFQjI4DsRq22hHvRJ4PU6NU3OlIx2hjFcPSivcyI/NcsfGo3znF
         5KlRijprlDzC+ALs8hhteISBbIWi/yRv5Mf9Y7z12Yn+R2/Ixlhj/EBi6r242RV5q1oi
         YUssvITSefEQF5gVt/xEQ7ZMOxDxrThtPRXYfqZfLFrUDPRmPoRIfVST84xjamZPPFfW
         qUDx9bZX4QzI0fuukgEKID7q8SKhSmQ3I/nqYexy96Oj220llWqy+haOL9y+Wiym3aPn
         qf1w746AEp1lwTfSaqKL5chC7x8j1tKEni2cQ54Pmu3pmx+8DCGzW/GJ3624koRjumB9
         OO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yTsZoLmlHNm+eqmO/1SbPV0SLUCIHibl+Wa6lk1x09s=;
        b=WNucRvQNzq+nvitWkmg922rJ5S3gFzZE0ApDj9kHdJ7i9FUBiuHnSWA0vfOSCZt0sY
         gy5t/CODeYujl2LXH5dric7w+sEGETWaR7mQZq3y0PnFJPNnj9cXI2qoJSATf+FXFlxK
         zkq11O/tn0GuJ/Y/p1H6270DfrV+W5jKp1M6eBJ9mFshixKGXmdyQmFzK8eSMXbLmSw6
         rFSsLssJF7sQ1VnxGQdQk8p/f0NJjdQpoYMNgIRnwAIXZHhozJgo4fa6eWhFRF14IKQg
         QCkDo/LoezE8QZE6KtcPu21dvRhylgh4feS2+BPydB9y2X94Osmp7UmovVPcWvnin+y8
         BQkQ==
X-Gm-Message-State: AJIora8tnV9HQcNMiJ0neJn1LSQk6UINffNUsVEk59eZ6TdLiDBzGx8N
        KPWOIt0BLAXEcBwxoSf/S0s=
X-Google-Smtp-Source: AGRyM1uyOZr7cu55TLCrl/2+ai7K2EuGWY9a0zMHj9AG08cuTTMBj3MaY948Wtug8LfmKsSZg/tXBA==
X-Received: by 2002:a2e:a801:0:b0:24a:ff0b:ae7a with SMTP id l1-20020a2ea801000000b0024aff0bae7amr3092816ljq.287.1655229181999;
        Tue, 14 Jun 2022 10:53:01 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id y1-20020a199141000000b0047255d2119bsm1468081lfj.202.2022.06.14.10.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:53:01 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] xen/grant-table: Use unpopulated DMAable pages
 instead of real RAM ones
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
References: <1652810658-27810-1-git-send-email-olekstysh@gmail.com>
 <1652810658-27810-3-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2206031348230.2783803@ubuntu-linux-20-04-desktop>
 <7f886dfb-2b42-bc70-d55f-14ecd8144e3e@gmail.com>
 <alpine.DEB.2.22.394.2206101644210.756493@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <1266f8cb-bbd6-d952-3108-89665ce76fec@gmail.com>
Date:   Tue, 14 Jun 2022 20:53:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2206101644210.756493@ubuntu-linux-20-04-desktop>
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


On 11.06.22 02:55, Stefano Stabellini wrote:

Hello Stefano

> On Thu, 9 Jun 2022, Oleksandr wrote:
>> On 04.06.22 00:19, Stefano Stabellini wrote:
>> Hello Stefano
>>
>> Thank you for having a look and sorry for the late response.
>>
>>> On Tue, 17 May 2022, Oleksandr Tyshchenko wrote:
>>>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>>
>>>> Depends on CONFIG_XEN_UNPOPULATED_ALLOC. If enabled then unpopulated
>>>> DMAable (contiguous) pages will be allocated for grant mapping into
>>>> instead of ballooning out real RAM pages.
>>>>
>>>> TODO: Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages()
>>>> fails.
>>>>
>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>>> ---
>>>>    drivers/xen/grant-table.c | 27 +++++++++++++++++++++++++++
>>>>    1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
>>>> index 8ccccac..2bb4392 100644
>>>> --- a/drivers/xen/grant-table.c
>>>> +++ b/drivers/xen/grant-table.c
>>>> @@ -864,6 +864,25 @@ EXPORT_SYMBOL_GPL(gnttab_free_pages);
>>>>     */
>>>>    int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
>>>>    {
>>>> +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>>>> +	int ret;
>>> This is an alternative implementation of the same function.
>> Currently, yes.
>>
>>
>>>    If we are
>>> going to use #ifdef, then I would #ifdef the entire function, rather
>>> than just the body. Otherwise within the function body we can use
>>> IS_ENABLED.
>>
>> Good point. Note, there is one missing thing in current patch which is
>> described in TODO.
>>
>> "Fallback to real RAM pages if xen_alloc_unpopulated_dma_pages() fails."  So I
>> will likely use IS_ENABLED within the function body.
>>
>> If CONFIG_XEN_UNPOPULATED_ALLOC is enabled then gnttab_dma_alloc_pages() will
>> try to call xen_alloc_unpopulated_dma_pages() the first and if fails then
>> fallback to allocate RAM pages and balloon them out.
>>
>> One moment is not entirely clear to me. If we use fallback in
>> gnttab_dma_alloc_pages() then we must use fallback in gnttab_dma_free_pages()
>> as well, we cannot use xen_free_unpopulated_dma_pages() for real RAM pages.
>> The question is how to pass this information to the gnttab_dma_free_pages()?
>> The first idea which comes to mind is to add a flag to struct
>> gnttab_dma_alloc_args...
>   
> You can check if the page is within the mhp_range range or part of
> iomem_resource? If not, you can free it as a normal page.
>
> If we do this, then the fallback is better implemented in
> unpopulated-alloc.c because that is the one that is aware about
> page addresses.


I got your idea and agree this can work technically. Or if we finally 
decide to use the second option (use "dma_pool" for all) in the first patch
"[RFC PATCH 1/2] xen/unpopulated-alloc: Introduce helpers for DMA 
allocations" then we will likely be able to check whether a page in question
is within a "dma_pool" using gen_pool_has_addr().

I am still wondering, can we avoid the fallback implementation in 
unpopulated-alloc.c.
Because for that purpose we will need to pull more code into 
unpopulated-alloc.c (to be more precise, almost everything which 
gnttab_dma_free_pages() already has except gnttab_pages_clear_private()) 
and pass more arguments to xen_free_unpopulated_dma_pages(). Also I 
might mistake, but having a fallback split between grant-table.c (to 
allocate RAM pages in gnttab_dma_alloc_pages()) and unpopulated-alloc.c 
(to free RAM pages in xen_free_unpopulated_dma_pages()) would look a bit 
weird.

I see two possible options for the fallback implementation in grant-table.c:
1. (less preferable) by introducing new flag in struct gnttab_dma_alloc_args
2. (more preferable) by guessing unpopulated (non real RAM) page using 
is_zone_device_page(), etc


For example, with the second option the resulting code will look quite 
simple (only build tested):

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 738029d..3bda71f 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1047,6 +1047,23 @@ int gnttab_dma_alloc_pages(struct 
gnttab_dma_alloc_args *args)
         size_t size;
         int i, ret;

+       if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC)) {
+               ret = xen_alloc_unpopulated_dma_pages(args->dev, 
args->nr_pages,
+                               args->pages);
+               if (ret < 0)
+                       goto fallback;
+
+               ret = gnttab_pages_set_private(args->nr_pages, args->pages);
+               if (ret < 0)
+                       goto fail;
+
+               args->vaddr = page_to_virt(args->pages[0]);
+               args->dev_bus_addr = page_to_phys(args->pages[0]);
+
+               return ret;
+       }
+
+fallback:
         size = args->nr_pages << PAGE_SHIFT;
         if (args->coherent)
                 args->vaddr = dma_alloc_coherent(args->dev, size,
@@ -1103,6 +1120,12 @@ int gnttab_dma_free_pages(struct 
gnttab_dma_alloc_args *args)

         gnttab_pages_clear_private(args->nr_pages, args->pages);

+       if (IS_ENABLED(CONFIG_XEN_UNPOPULATED_ALLOC) &&
+                       is_zone_device_page(args->pages[0])) {
+               xen_free_unpopulated_dma_pages(args->dev, 
args->nr_pages, args->pages);
+               return 0;
+       }
+
         for (i = 0; i < args->nr_pages; i++)
                 args->frames[i] = page_to_xen_pfn(args->pages[i]);


What do you think?


>
>   
>   
>>>> +	ret = xen_alloc_unpopulated_dma_pages(args->dev, args->nr_pages,
>>>> +			args->pages);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = gnttab_pages_set_private(args->nr_pages, args->pages);
>>>> +	if (ret < 0) {
>>>> +		gnttab_dma_free_pages(args);
>>> it should xen_free_unpopulated_dma_pages ?
>> Besides calling the xen_free_unpopulated_dma_pages(), we also need to call
>> gnttab_pages_clear_private() here, this is what gnttab_dma_free_pages() is
>> doing.
>>
>> I can change to call both function instead:
>>
>>      gnttab_pages_clear_private(args->nr_pages, args->pages);
>>      xen_free_unpopulated_dma_pages(args->dev, args->nr_pages, args->pages);
>>
>> Shall I?
> No, leave it as is. I didn't realize that gnttab_pages_set_private can
> fail half-way through.


ok, thank you for the confirmation.


>
>   
>>>
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	args->vaddr = page_to_virt(args->pages[0]);
>>>> +	args->dev_bus_addr = page_to_phys(args->pages[0]);
>>> There are two things to note here.
>>>
>>> The first thing to note is that normally we would call pfn_to_bfn to
>>> retrieve the dev_bus_addr of a page because pfn_to_bfn takes into
>>> account foreign mappings. However, these are freshly allocated pages
>>> without foreign mappings, so page_to_phys/dma should be sufficient.
>> agree
>>
>>
>>>
>>> The second has to do with physical addresses and DMA addresses. The
>>> functions are called gnttab_dma_alloc_pages and
>>> xen_alloc_unpopulated_dma_pages which make you think we are retrieving a
>>> DMA address here. However, to get a DMA address we need to call
>>> page_to_dma rather than page_to_phys.
>>>
>>> page_to_dma takes into account special offsets that some devices have
>>> when accessing memory. There are real cases on ARM where the physical
>>> address != DMA address, e.g. RPi4.
>> I got it. Now I am in doubt whether it would be better to name the API:
>>
>> xen_alloc_unpopulated_cma_pages()
>>
>> or
>>
>> xen_alloc_unpopulated_contiguous_pages()
>>
>> What do you think?
> Yeah actually I think it is better to stay away from "dma" in the name.
> I like xen_alloc_unpopulated_contiguous_pages().


perfect, I will rename then, thank you for the confirmation.


>   
>   
>>> However, to call page_to_dma you need to specify as first argument the
>>> DMA-capable device that is expected to use those pages for DMA (e.g. an
>>> ethernet device or a MMC controller.) While the args->dev we have in
>>> gnttab_dma_alloc_pages is the gntdev_miscdev.
>> agree
>>
>> As I understand, at this time it is unknown for what exactly device these
>> pages are supposed to be used at the end.
>>
>> For now, it is only known that these pages to be used by userspace PV backend
>> for grant mappings.
> Yeah
>   
>
>>> So this interface cannot actually be used to allocate memory that is
>>> supposed to be DMA-able by a DMA-capable device, such as an ethernet
>>> device.
>> agree
>>
>>
>>> But I think that should be fine because the memory is meant to be used
>>> by a userspace PV backend for grant mappings. If any of those mappings
>>> end up being used for actual DMA in the kernel they should go through the
>>> drivers/xen/swiotlb-xen.c and xen_phys_to_dma should be called, which
>>> ends up calling page_to_dma as appropriate.
>>>
>>> It would be good to double-check that the above is correct and, if so,
>>> maybe add a short in-code comment about it:
>>>
>>> /*
>>>    * These are not actually DMA addresses but regular physical addresses.
>>>    * If these pages end up being used in a DMA operation then the
>>>    * swiotlb-xen functions are called and xen_phys_to_dma takes care of
>>>    * the address translations:
>>>    *
>>>    * - from gfn to bfn in case of foreign mappings
>>>    * - from physical to DMA addresses in case the two are different for a
>>>    *   given DMA-mastering device
>>>    */
>> I agree this needs to be re-checked. But, there is one moment here, if
>> userspace PV backend runs in other than Dom0 domain (non 1:1 mapped domain),
>> the xen-swiotlb seems not to be in use then? How to be in this case?
>   
> In that case, an IOMMU is required. If an IOMMU is setup correct, then
> the gfn->bfn translation is not necessary because it is done
> automatically by the IOMMU. That is because when the foreign page is
> mapped in the domain, the mapping also applies to the IOMMU pagetable.
>
> So the device is going to do DMA to "gfn" and the IOMMU will translate
> it to the right "mfn", the one corresponding to "bfn".
>
> The physical to DMA address should be done automatically by the default
> (non-swiotlb_xen) dma_ops in Linux. E.g.
> kernel/dma/direct.c:dma_direct_map_sg correctly calls
> dma_direct_map_page, which calls phys_to_dma.


Thank you for the explanation.


>   
>   
>   
>>>> +	return ret;
>>>> +#else
>>>>    	unsigned long pfn, start_pfn;
>>>>    	size_t size;
>>>>    	int i, ret;
>>>> @@ -910,6 +929,7 @@ int gnttab_dma_alloc_pages(struct
>>>> gnttab_dma_alloc_args *args)
>>>>    fail:
>>>>    	gnttab_dma_free_pages(args);
>>>>    	return ret;
>>>> +#endif
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
>>>>    @@ -919,6 +939,12 @@ EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
>>>>     */
>>>>    int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
>>>>    {
>>>> +#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
>>>> +	gnttab_pages_clear_private(args->nr_pages, args->pages);
>>>> +	xen_free_unpopulated_dma_pages(args->dev, args->nr_pages,
>>>> args->pages);
>>>> +
>>>> +	return 0;
>>>> +#else
>>>>    	size_t size;
>>>>    	int i, ret;
>>>>    @@ -946,6 +972,7 @@ int gnttab_dma_free_pages(struct
>>>> gnttab_dma_alloc_args *args)
>>>>    		dma_free_wc(args->dev, size,
>>>>    			    args->vaddr, args->dev_bus_addr);
>>>>    	return ret;
>>>> +#endif
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(gnttab_dma_free_pages);
>>>>    #endif
>>>> -- 
>>>> 2.7.4

-- 
Regards,

Oleksandr Tyshchenko

