Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739450D3B3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiDXQ4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiDXQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:56:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7131238
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:53:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g19so22449618lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jglWAKRkI0cPF7sxIMVbMR7zt7h0C3kJ96kO8VwqGDI=;
        b=GYowuHqr7FB76QyplNtwwt3lky81k7Ou35ecYplCgAko4aBaXhy/MXAyl2x4Cu/MW6
         A4pRF0w0ewJckI7S8ELGwOHTFDh7jbReEQ26VnrDMV4qu3juRSwbpBdXChSHPNYzJmNd
         EHpOi7Mjq2QTjAF+XObk/nyy30OuCFJhSKdBQ+Y8I1flgab/G8K3uMsZzQcobPMA9HKV
         1kEJq9DMHRJL81nG7xqc1Ivq+c1M0Okte8Uf5RWCZA2JcJ3d4RyX0YkMLopKdkYqryTY
         TAmhz+4UYcJcT+l9p8zKrD1SrCQXsuNIOFI0RDhK9P6wTsNSdnQFTWRDH+NAyQ9FHB/3
         E/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jglWAKRkI0cPF7sxIMVbMR7zt7h0C3kJ96kO8VwqGDI=;
        b=22W+T9z80+IdE++CD0Q0VVB4MSv9z8c17WOc9Xzwd0L1lui2eDO2NaB1Q6hVgoy/to
         Kpdcp6jTnNypzhpKxA+bVFr+Y7AHdnhHNEGEu3D9NK1xaZk7FVzHvz6wmOlR0Iy+HTWN
         dCbt4YHbztfaoYQWj4PgDMWbygBAmyWWNoEiJeaXvwnA+e9jDvCT+nMVaed12cdDDgjg
         0FVzgPlzrgXN98i9moA7soVGP4Hvgw17pxBzvlDdIE7Mh/Vo02a7pVgYPoWh3rx7MFhU
         Sn5cqxHPi+jeT5JdnSdkR+1BMXnlI1vTBPggoPGdhIXPyqgD4Myg4Q8QgZWMGXvrCRzA
         ynnA==
X-Gm-Message-State: AOAM531LpWDH/IWGQ5+aw7NKCsNj5eU2Dsl1MrTlMe3xbOcvtyCfmzm2
        V8cBLEfji2B0G6sAceroqLs=
X-Google-Smtp-Source: ABdhPJwFreSpU5cEMVZzTUFm4eZzNyKMvOqf9D+S7BUgoISlXctBt6KVfUUcLTPNUQsOQOiq0aeg4w==
X-Received: by 2002:a05:6512:ac9:b0:470:e6d0:1bd8 with SMTP id n9-20020a0565120ac900b00470e6d01bd8mr10000761lfu.614.1650819212650;
        Sun, 24 Apr 2022 09:53:32 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id f18-20020a193812000000b00471f8573c96sm649350lfa.241.2022.04.24.09.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 09:53:32 -0700 (PDT)
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
Date:   Sun, 24 Apr 2022 19:53:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmQsFb36UEH9BUnN@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.04.22 19:40, Christoph Hellwig wrote:


Hello Christoph

> Please split this into one patch that creates grant-dma-ops, and another
> that sets up the virtio restricted access helpers.


Sounds reasonable, will do:

1. grant-dma-ops.c with config XEN_GRANT_DMA_OPS

2. arch_has_restricted_virtio_memory_access() with config XEN_VIRTIO


>
>> +
>> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>> +int arch_has_restricted_virtio_memory_access(void)
>> +{
>> +	return (xen_has_restricted_virtio_memory_access() ||
>> +			cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
>> +}
> So instead of hardcoding Xen here, this seems like a candidate for
> another cc_platform_has flag.


I have a limited knowledge of x86 and Xen on x86.

Would the Xen specific bits fit into Confidential Computing Platform 
checks? I will let Juergen/Boris comment on this.


>
>> +config XEN_VIRTIO
>> +	bool "Xen virtio support"
>> +	default n
> n is the default default, so no need to specify it.

ok, will drop


>
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/******************************************************************************
> The all * line is not the usual kernel style, I'd suggest to drop it.

ok, will drop


>
>> +static struct page *xen_grant_dma_alloc_pages(struct device *dev, size_t size,
>> +					      dma_addr_t *dma_handle,
>> +					      enum dma_data_direction dir,
>> +					      gfp_t gfp)
>> +{
>> +	WARN_ONCE(1, "xen_grant_dma_alloc_pages size %zu\n", size);
>> +	return NULL;
>> +}
>> +
>> +static void xen_grant_dma_free_pages(struct device *dev, size_t size,
>> +				     struct page *vaddr, dma_addr_t dma_handle,
>> +				     enum dma_data_direction dir)
>> +{
>> +	WARN_ONCE(1, "xen_grant_dma_free_pages size %zu\n", size);
>> +}
> Please just wire this up to the same implementation as .alloc and .free.

I got it, will implement


>
>> +	spin_lock(&xen_grant_dma_lock);
>> +	list_add(&data->list, &xen_grant_dma_devices);
>> +	spin_unlock(&xen_grant_dma_lock);
> Hmm, having to do this device lookup for every DMA operation is going
> to suck. It might make sense to add a private field (e.g. as a union
> with the iommu field) in struct device instead.


I was thinking about it, but decided to not alter common struct device 
for adding Xen specific field, but haven't managed to think of a better 
idea than just using that brute lookup ...


>
> But if not you probably want to switch to a more efficient data
> structure like the xarray at least.

... I think, this is good point, thank you. I have no idea how faster it 
is going to be, but the resulting code looks simple (if of course I 
correctly understood the usage of xarray)


diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index a512c0a..7ecc0b0 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -11,6 +11,7 @@
  #include <linux/dma-map-ops.h>
  #include <linux/of.h>
  #include <linux/pfn.h>
+#include <linux/xarray.h>
  #include <xen/xen.h>
  #include <xen/grant_table.h>

@@ -19,12 +20,9 @@ struct xen_grant_dma_data {
         domid_t dev_domid;
         /* Is device behaving sane? */
         bool broken;
-       struct device *dev;
-       struct list_head list;
  };

-static LIST_HEAD(xen_grant_dma_devices);
-static DEFINE_SPINLOCK(xen_grant_dma_lock);
+static DEFINE_XARRAY(xen_grant_dma_devices);

  #define XEN_GRANT_DMA_ADDR_OFF (1ULL << 63)

@@ -40,21 +38,13 @@ static inline grant_ref_t dma_to_grant(dma_addr_t dma)

  static struct xen_grant_dma_data *find_xen_grant_dma_data(struct 
device *dev)
  {
-       struct xen_grant_dma_data *data = NULL;
-       bool found = false;
-
-       spin_lock(&xen_grant_dma_lock);
-
-       list_for_each_entry(data, &xen_grant_dma_devices, list) {
-               if (data->dev == dev) {
-                       found = true;
-                       break;
-               }
-       }
+       struct xen_grant_dma_data *data;

-       spin_unlock(&xen_grant_dma_lock);
+       xa_lock(&xen_grant_dma_devices);
+       data = xa_load(&xen_grant_dma_devices, (unsigned long)dev);
+       xa_unlock(&xen_grant_dma_devices);

-       return found ? data : NULL;
+       return data;
  }

  /*
@@ -310,11 +300,12 @@ void xen_grant_setup_dma_ops(struct device *dev)
                 goto err;

         data->dev_domid = dev_domid;
-       data->dev = dev;

-       spin_lock(&xen_grant_dma_lock);
-       list_add(&data->list, &xen_grant_dma_devices);
-       spin_unlock(&xen_grant_dma_lock);
+       if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev, 
data,
+                       GFP_KERNEL))) {
+               dev_err(dev, "Cannot store Xen grant DMA data\n");
+               goto err;
+       }

         dev->dma_ops = &xen_grant_dma_ops;


>
>> +EXPORT_SYMBOL_GPL(xen_grant_setup_dma_ops);
> I don't think this has any modular users, or did I miss something?

No, you didn't. Will drop here and in the next patch for 
xen_is_grant_dma_device() as well.


-- 
Regards,

Oleksandr Tyshchenko

