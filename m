Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4115048DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiDQSYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiDQSX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:23:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81835FD0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:21:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bj36so8845444ljb.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HOTM5tpBYxAb1qtW2MCOB1TQN7ARlsIhllyek+NnKb0=;
        b=klCT/uoPzTl1EgjzQV3oH8Ani6TzcUI1aYpYynSRvEWYqqRCk3Jj1LNk9ZktsbF/i0
         n79fletwteCSJ30Z6u4+dfPXavKY08Xjlm1NUblBXiD8OA12dG6srB9dGE4bVEElY6g9
         4K8EhnEM8U1dhftqZ1vSaxBWtKzg9B7x69yu8AYA9Mue/OVMjGlby7Ap+keAnbYqbh5U
         ub6OC4DabnVDsPmAtDwGqfRCBpkvrzHF1wOACQujG7M5asYiz+MCzcYR2kWvwu2cd9lz
         NeeXAttlwuEvJoxWGwiGpaucZkJrCsbhO9PFumUrgQ8VQLHuB4JwS6zWIvO8/Ah12NSu
         x50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HOTM5tpBYxAb1qtW2MCOB1TQN7ARlsIhllyek+NnKb0=;
        b=0I/qDviXH327JrRtaJcVRxWLfaPYeAs6cLCW/XLypIkwO9Xlg7sLfdjPxByiglp1hg
         L/jJh0sSIV/J8ROC98TG04OxIEqDJ5vhkplVEuu+pi/BSWcf8hX4AbAYuKIZ5q6R1bb/
         q+PnG2jFGeZ0X/foCBHBQ1PF98VrSwCbspniOehMRyku5lzZIA0mPtPahCTlgay8dT07
         pWM0MzOPXvuCJvyUkDKpuNjURYf5ywtP6dubaqqY+fbilsLRM8Dn2RoOxofD2jH2TcwG
         T7VyFQxni8rXhFZyqL7uxhlhe+DTa78I0SC5lrN7cWItmYUY3ah33tj/lzg0g0EKKtC/
         hVqQ==
X-Gm-Message-State: AOAM531ex5ZOuKq7BWIoFHBsl0HSbit8LISEJmBLEYE3JkxiNkoeCvSR
        QoqxoTwDGdivf3BPCKHHBo4=
X-Google-Smtp-Source: ABdhPJzQLr3slVx6P9rGKBRO6Z1L/UfXVkwFnZZYoGy4MSWTfhkB82YDTfnCzZbU0/6f7UzpkBAJ7A==
X-Received: by 2002:a05:651c:54c:b0:249:9d06:24ef with SMTP id q12-20020a05651c054c00b002499d0624efmr5069689ljp.331.1650219680786;
        Sun, 17 Apr 2022 11:21:20 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e3c11000000b0024d5c9b8d8csm913188lja.67.2022.04.17.11.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 11:21:20 -0700 (PDT)
Subject: Re: [RFC PATCH 4/6] virtio: Various updates to xen-virtio DMA ops
 layer
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-5-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151302350.915916@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <84f5264c-6b98-6d56-b7ca-61c19dc502ca@gmail.com>
Date:   Sun, 17 Apr 2022 21:21:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2204151302350.915916@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.04.22 01:02, Stefano Stabellini wrote:

Hello Stefano


> On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> In the context of current patch do the following:
>> 1. Update code to support virtio-mmio devices
>> 2. Introduce struct xen_virtio_data and account passed virtio devices
>>     (using list) as we need to store some per-device data
>> 3. Add multi-page support for xen_virtio_dma_map(unmap)_page callbacks
>> 4. Harden code against malicious backend
>> 5. Change to use alloc_pages_exact() instead of __get_free_pages()
>> 6. Introduce locking scheme to protect mappings (I am not 100% sure
>>     whether per-device lock is really needed)
>> 7. Handle virtio device's DMA mask
>> 8. Retrieve the ID of backend domain from DT for virtio-mmio device
>>     instead of hardcoding it.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>>   arch/arm/xen/enlighten.c |  11 +++
>>   drivers/xen/Kconfig      |   2 +-
>>   drivers/xen/xen-virtio.c | 200 ++++++++++++++++++++++++++++++++++++++++++-----
>>   include/xen/xen-ops.h    |   5 ++
>>   4 files changed, 196 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>> index ec5b082..870d92f 100644
>> --- a/arch/arm/xen/enlighten.c
>> +++ b/arch/arm/xen/enlighten.c
>> @@ -409,6 +409,17 @@ int __init arch_xen_unpopulated_init(struct resource **res)
>>   }
>>   #endif
>>   
>> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>> +int arch_has_restricted_virtio_memory_access(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_XEN_HVM_VIRTIO_GRANT) && xen_hvm_domain())
>> +		return 1;
> Instead of xen_hvm_domain(), you can just use xen_domain(). Also there
> is no need for the #ifdef
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, given that:
>
> CONFIG_XEN_HVM_VIRTIO_GRANT depends on XEN_VIRTIO which selects
> ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS


Yes, but please see my comments in commit #2 regarding 
CONFIG_XEN_HVM_VIRTIO_GRANT option and 
arch_has_restricted_virtio_memory_access() on Arm.

I propose to have the following on Arm:

int arch_has_restricted_virtio_memory_access(void)
{
      return xen_has_restricted_virtio_memory_access();
}


where common xen.h contain a helper to be used by both Arm and x86:

static inline int xen_has_restricted_virtio_memory_access(void)
{
      if (IS_ENABLED(CONFIG_XEN_VIRTIO) && (xen_pv_domain() || 
xen_hvm_domain()))
          return 1;

      return 0;
}


But I would be happy with what you propose as well.


>
>
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
>> +#endif
>> +
>>   static void __init xen_dt_guest_init(void)
>>   {
>>   	struct device_node *xen_node;
>> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>> index fc61f7a..56afe6a 100644
>> --- a/drivers/xen/Kconfig
>> +++ b/drivers/xen/Kconfig
>> @@ -347,7 +347,7 @@ config XEN_VIRTIO
>>   
>>   config XEN_HVM_VIRTIO_GRANT
>>   	bool "Require virtio for fully virtualized guests to use grant mappings"
>> -	depends on XEN_VIRTIO && X86_64
>> +	depends on XEN_VIRTIO && (X86_64 || ARM || ARM64)
> you can remove the architectural dependencies


According to the conversation in commit #2 we are considering just a 
single XEN_VIRTIO option, but it is going to has the
same architectural dependencies: (X86_64 || ARM || ARM64)

By removing the architectural dependencies here, we will leave also 
X86_32 covered (neither XEN_HVM_VIRTIO_GRANT nor XEN_PV_VIRTIO covered 
it). I don't know whether it is ok or not.

Shall I remove dependencies anyway?


>
>
>>   	default y
>>   	help
>>   	  Require virtio for fully virtualized guests to use grant mappings.
>> diff --git a/drivers/xen/xen-virtio.c b/drivers/xen/xen-virtio.c
>> index cfd5eda..c5b2ec9 100644
>> --- a/drivers/xen/xen-virtio.c
>> +++ b/drivers/xen/xen-virtio.c
>> @@ -7,12 +7,26 @@
>>   
>>   #include <linux/module.h>
>>   #include <linux/dma-map-ops.h>
>> +#include <linux/of.h>
>>   #include <linux/pci.h>
>>   #include <linux/pfn.h>
>>   #include <linux/virtio_config.h>
>>   #include <xen/xen.h>
>>   #include <xen/grant_table.h>
>>   
>> +struct xen_virtio_data {
>> +	/* The ID of backend domain */
>> +	domid_t dev_domid;
>> +	struct device *dev;
>> +	struct list_head list;
>> +	spinlock_t lock;
>> +	/* Is device behaving sane? */
>> +	bool broken;
> If you moved "broken" after "dev_domid" we would save a few bytes for
> every allocation due to padding.

ok, will do


>
> Is data->lock only there to protect accesses to "broken"? If so, we
> might not need it, but I am not sure.


Really good question, I introduced a lock for other purpose, I was 
thinking we needed to protect grants allocation and removing, but wasn't 
100% sure about it (I wrote a remark in commit description). But looking 
into grant_table.c again I see that grant table code uses it's own lock, 
so looks like we don't need an extra lock here. I need to re-check 
regarding "broken", but likely we don't need here as well. If so, I will 
remove the lock.


>
>
>> +};
>> +
>> +static LIST_HEAD(xen_virtio_devices);
>> +static DEFINE_SPINLOCK(xen_virtio_lock);
>> +
>>   #define XEN_GRANT_ADDR_OFF	0x8000000000000000ULL
>>   
>>   static inline dma_addr_t grant_to_dma(grant_ref_t grant)
>> @@ -25,6 +39,25 @@ static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>>   	return (grant_ref_t)((dma & ~XEN_GRANT_ADDR_OFF) >> PAGE_SHIFT);
>>   }
>>   
>> +static struct xen_virtio_data *find_xen_virtio_data(struct device *dev)
>> +{
>> +	struct xen_virtio_data *data = NULL;
>> +	bool found = false;
>> +
>> +	spin_lock(&xen_virtio_lock);
>> +
>> +	list_for_each_entry( data, &xen_virtio_devices, list) {
>> +		if (data->dev == dev) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	spin_unlock(&xen_virtio_lock);
>> +
>> +	return found ? data : NULL;
>> +}
>> +
>>   /*
>>    * DMA ops for Xen virtio frontends.
>>    *
>> @@ -43,48 +76,78 @@ static void *xen_virtio_dma_alloc(struct device *dev, size_t size,
>>   				  dma_addr_t *dma_handle, gfp_t gfp,
>>   				  unsigned long attrs)
>>   {
>> -	unsigned int n_pages = PFN_UP(size);
>> -	unsigned int i;
>> +	struct xen_virtio_data *data;
>> +	unsigned int i, n_pages = PFN_UP(size);
>>   	unsigned long pfn;
>>   	grant_ref_t grant;
>> -	void *ret;
>> +	void *ret = NULL;
>>   
>> -	ret = (void *)__get_free_pages(gfp, get_order(size));
>> -	if (!ret)
>> +	data = find_xen_virtio_data(dev);
>> +	if (!data)
>>   		return NULL;
>>   
>> +	spin_lock(&data->lock);
>> +
>> +	if (unlikely(data->broken))
>> +		goto out;
>> +
>> +	ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
>> +	if (!ret)
>> +		goto out;
>> +
>>   	pfn = virt_to_pfn(ret);
>>   
>>   	if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
>> -		free_pages((unsigned long)ret, get_order(size));
>> -		return NULL;
>> +		free_pages_exact(ret, n_pages * PAGE_SIZE);
>> +		ret = NULL;
>> +		goto out;
>>   	}
>>   
>>   	for (i = 0; i < n_pages; i++) {
>> -		gnttab_grant_foreign_access_ref(grant + i, 0,
>> +		gnttab_grant_foreign_access_ref(grant + i, data->dev_domid,
>>   						pfn_to_gfn(pfn + i), 0);
>>   	}
>>   
>>   	*dma_handle = grant_to_dma(grant);
>>   
>> +out:
>> +	spin_unlock(&data->lock);
>> +
>>   	return ret;
>>   }
>>   
>>   static void xen_virtio_dma_free(struct device *dev, size_t size, void *vaddr,
>>   				dma_addr_t dma_handle, unsigned long attrs)
>>   {
>> -	unsigned int n_pages = PFN_UP(size);
>> -	unsigned int i;
>> +	struct xen_virtio_data *data;
>> +	unsigned int i, n_pages = PFN_UP(size);
>>   	grant_ref_t grant;
>>   
>> +	data = find_xen_virtio_data(dev);
>> +	if (!data)
>> +		return;
>> +
>> +	spin_lock(&data->lock);
>> +
>> +	if (unlikely(data->broken))
>> +		goto out;
>> +
>>   	grant = dma_to_grant(dma_handle);
>>   
>> -	for (i = 0; i < n_pages; i++)
>> -		gnttab_end_foreign_access_ref(grant + i);
>> +	for (i = 0; i < n_pages; i++) {
>> +		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
>> +			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
>> +			data->broken = true;
>> +			goto out;
>> +		}
>> +	}
>>   
>>   	gnttab_free_grant_reference_seq(grant, n_pages);
>>   
>> -	free_pages((unsigned long)vaddr, get_order(size));
>> +	free_pages_exact(vaddr, n_pages * PAGE_SIZE);
>> +
>> +out:
>> +	spin_unlock(&data->lock);
>>   }
>>   
>>   static struct page *xen_virtio_dma_alloc_pages(struct device *dev, size_t size,
>> @@ -108,28 +171,71 @@ static dma_addr_t xen_virtio_dma_map_page(struct device *dev, struct page *page,
>>   					  enum dma_data_direction dir,
>>   					  unsigned long attrs)
>>   {
>> +	struct xen_virtio_data *data;
>> +	unsigned int i, n_pages = PFN_UP(size);
>>   	grant_ref_t grant;
>> +	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
>> +
>> +	BUG_ON(dir == DMA_NONE);
>> +
>> +	data = find_xen_virtio_data(dev);
>> +	if (!data)
>> +		return DMA_MAPPING_ERROR;
>> +
>> +	spin_lock(&data->lock);
>>   
>> -	if (gnttab_alloc_grant_references(1, &grant))
>> -		return 0;
>> +	if (unlikely(data->broken))
>> +		goto out;
>>   
>> -	gnttab_grant_foreign_access_ref(grant, 0, xen_page_to_gfn(page),
>> -					dir == DMA_TO_DEVICE);
>> +	if (gnttab_alloc_grant_reference_seq(n_pages, &grant))
>> +		goto out;
>>   
>> -	return grant_to_dma(grant) + offset;
>> +	for (i = 0; i < n_pages; i++) {
>> +		gnttab_grant_foreign_access_ref(grant + i, data->dev_domid,
>> +				xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
>> +	}
>> +
>> +	dma_handle = grant_to_dma(grant) + offset;
>> +
>> +out:
>> +	spin_unlock(&data->lock);
>> +
>> +	return dma_handle;
>>   }
>>   
>>   static void xen_virtio_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>>   				      size_t size, enum dma_data_direction dir,
>>   				      unsigned long attrs)
>>   {
>> +	struct xen_virtio_data *data;
>> +	unsigned int i, n_pages = PFN_UP(size);
>>   	grant_ref_t grant;
>>   
>> +	BUG_ON(dir == DMA_NONE);
>> +
>> +	data = find_xen_virtio_data(dev);
>> +	if (!data)
>> +		return;
>> +
>> +	spin_lock(&data->lock);
>> +
>> +	if (unlikely(data->broken))
>> +		goto out;
>> +
>>   	grant = dma_to_grant(dma_handle);
>>   
>> -	gnttab_end_foreign_access_ref(grant);
>> +	for (i = 0; i < n_pages; i++) {
>> +		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
>> +			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
>> +			data->broken = true;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	gnttab_free_grant_reference_seq(grant, n_pages);
>>   
>> -	gnttab_free_grant_reference(grant);
>> +out:
>> +	spin_unlock(&data->lock);
>>   }
>>   
>>   static int xen_virtio_dma_map_sg(struct device *dev, struct scatterlist *sg,
>> @@ -149,7 +255,7 @@ static void xen_virtio_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>>   
>>   static int xen_virtio_dma_dma_supported(struct device *dev, u64 mask)
>>   {
>> -	return 1;
>> +	return mask == DMA_BIT_MASK(64);
>>   }
>>   
>>   static const struct dma_map_ops xen_virtio_dma_ops = {
>> @@ -166,9 +272,61 @@ static const struct dma_map_ops xen_virtio_dma_ops = {
>>   	.dma_supported = xen_virtio_dma_dma_supported,
>>   };
>>   
>> +bool xen_is_virtio_device(struct device *dev)
>> +{
>> +	/* XXX Handle only DT devices for now */
>> +	if (!dev->of_node)
>> +		return false;
>> +
>> +	if (!of_device_is_compatible(dev->of_node, "virtio,mmio"))
>> +		return false;
>> +
>> +	return of_property_read_bool(dev->of_node, "xen,dev-domid");
>> +}
>> +EXPORT_SYMBOL_GPL(xen_is_virtio_device);
>> +
>>   void xen_virtio_setup_dma_ops(struct device *dev)
>>   {
>> +	struct xen_virtio_data *data;
>> +	uint32_t dev_domid;
>> +
>> +	data = find_xen_virtio_data(dev);
>> +	if (data) {
>> +		dev_err(dev, "xen_virtio data is already created\n");
>> +		return;
>> +	}
>> +
>> +	if (dev_is_pci(dev)) {
>> +		/* XXX Leave it hard wired to dom0 for now */
>> +		dev_domid = 0;
>> +	} else if (dev->of_node) {
>> +		if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
>> +			dev_err(dev, "xen,dev-domid property is not present\n");
>> +			goto err;
>> +		}
>> +	} else
>> +		/* The ACPI case is not supported */
>> +		goto err;
> If we get here, it means that xen_is_virtio_device returned true, so the
> PCI case is actually impossible?

Good catch, thank you. Yes, it is impossible on Arm for now (with 
changes in commit #6).


>
> I would rewrite these checks like this:
>
> /* XXX: ACPI and PCI unsupported for now */
> if (dev_is_pci(dev) || !dev->of_node) {
> 	goto err;
> }
> if (of_property_read_u32(dev->of_node, "xen,dev-domid", &dev_domid)) {
> 	dev_err(dev, "xen,dev-domid property is not present\n");
> 	goto err;
> }


ok, will do


>
>
>
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data) {
>> +		dev_err(dev, "Сannot allocate xen_virtio data\n");
>> +		goto err;
>> +	}
>> +	data->dev_domid = dev_domid;
>> +	data->dev = dev;
>> +	spin_lock_init(&data->lock);
>> +
>> +	spin_lock(&xen_virtio_lock);
>> +	list_add(&data->list, &xen_virtio_devices);
>> +	spin_unlock(&xen_virtio_lock);
>> +
>>   	dev->dma_ops = &xen_virtio_dma_ops;
>> +
>> +	return;
>> +
>> +err:
>> +	dev_err(dev, "Сannot set up xen_virtio DMA ops, retain platform DMA ops\n");
>>   }
>>   EXPORT_SYMBOL_GPL(xen_virtio_setup_dma_ops);
>>   
>> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
>> index ae3c1bc..fdbcb99 100644
>> --- a/include/xen/xen-ops.h
>> +++ b/include/xen/xen-ops.h
>> @@ -223,10 +223,15 @@ static inline void xen_preemptible_hcall_end(void) { }
>>   
>>   #ifdef CONFIG_XEN_VIRTIO
>>   void xen_virtio_setup_dma_ops(struct device *dev);
>> +bool xen_is_virtio_device(struct device *dev);
>>   #else
>>   static inline void xen_virtio_setup_dma_ops(struct device *dev)
>>   {
>>   }
>> +static inline bool xen_is_virtio_device(struct device *dev)
>> +{
>> +	return false;
>> +}
>>   #endif /* CONFIG_XEN_VIRTIO */
>>   
>>   #endif /* INCLUDE_XEN_OPS_H */

-- 
Regards,

Oleksandr Tyshchenko

