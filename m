Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0A57A4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiGSRK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiGSRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:10:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA41D0CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658250621; x=1689786621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cSyEJqLNRqlYOJiLaILL+k1mpqfDvTEP+nXOa+4KBig=;
  b=Rx6uKvDoTNrqjaAUfnSpwK5eoTmD0GfEb3vZ3gYcCRGdzExIqNA/ZHiR
   KeD0BngUXC84EOk352CvFSy1arr191GorFflv5QcPpBgTfnMjaLr5gv/y
   zSNrDs22vfWvvGfczsBEAahX5ZVKpC6sL71iXIj4wRc3Hm1dP3uMQbxMq
   19XVYRc3KGJYus9x3AiMX1MJ3pbhevj/zK2ilieRFI1Jp+gvIvxZR+skR
   sqsOlEpc7OsrClYlzQb9L5SnKnYgIazHuuzYRIrkq/BKJp6QRxEoRoiGf
   QCFC5f3d8wgHfbiXXDDeEudGT+yDwjZfWh54wAOQ3z57JXN3pQg6oyKPs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="285299553"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="285299553"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:10:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="572933025"
Received: from shaunaks-mobl.amr.corp.intel.com (HELO [10.252.133.129]) ([10.252.133.129])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:10:20 -0700
Message-ID: <1f320d34-c467-38fa-17b1-d0c7cde7b0d0@linux.intel.com>
Date:   Tue, 19 Jul 2022 10:10:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
 <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
 <fe896ec7-cfce-e8ce-240d-88cca47f8996@intel.com>
 <6b84f9058ce5e60fdf3e4abd075a2b8f591ccffc.camel@intel.com>
 <20220705152910.rq2ga25gnw7kuvt5@box.shutemov.name>
 <5804d4a8-8c5f-5352-8eed-4962e0adca1c@linux.intel.com>
 <20220719161354.27cak6zy3uws3fvm@black.fi.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220719161354.27cak6zy3uws3fvm@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/22 9:13 AM, Kirill A. Shutemov wrote:
> On Mon, Jul 18, 2022 at 07:22:52AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Dave,
>>
>> On 7/5/22 8:29 AM, Kirill A. Shutemov wrote:
>>>>> I still don't like the idea of using the DMA API itself.  But, maybe we
>>>>> need some common infrastructure that the DMA API and this code use which
>>>>> says, "get me some pages that I can safely make shared".
>>>> Right.  For instance any KVM PV feature would require shared memory, and DMA API
>>>> normally doesn't fit (taking 'struct kvm_steal_time' as example).
>>>>
>>>> Maybe we can reserve a CMA for this purpose.
>>> CMA for couple low traffic users sounds like an overkill. It will create
>>> an separate pool just for them.
>>>
>>> I think the best way is to add an dummy device and couple of helpers
>>> around DMA API that would allow to tap into swiotlb.
>>>
>>> Maybe hide it inside CC infrastructure. Like cc_decrypted_alloc() and
>>> cc_decrypted_free().
>>
>> I also think creating a generic device in the CC layer, and using it to allocate
>> memory via DMA APIs is a better approach for this issue. Following is the sample
>> implementation to give you an idea on how it looks. Please let me know
>> your comments.
>>
>> cc_shmem_alloc/free() APIs can be used by CC users to allocate and
>> free shared memory.
> 
> We usually use 'decrypted' term in kernel. cc_decrypted_alloc()/_free().

Fine with me. I will use it.

> 
>> Other vendors can define their own shared memory allocation and free
>> logic via struct shmem_priv alloc/free/init hooks.
>>
>> --- a/arch/x86/coco/Makefile
>> +++ b/arch/x86/coco/Makefile
>> @@ -3,6 +3,6 @@ CFLAGS_REMOVE_core.o    = -pg
>>  KASAN_SANITIZE_core.o  := n
>>  CFLAGS_core.o          += -fno-stack-protector
>>  
>> -obj-y += core.o
>> +obj-y += core.o shmem.o
> 
> Rename shmem.o -> mem.o ?

Ok.

> 
>> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
>> index 49b44f881484..62fe68d1f60a 100644
>> --- a/arch/x86/coco/core.c
>> +++ b/arch/x86/coco/core.c
>> @@ -13,7 +13,7 @@
>>  #include <asm/coco.h>
>>  #include <asm/processor.h>
>>  
>> -static enum cc_vendor vendor __ro_after_init;
>> +enum cc_vendor vendor __ro_after_init;
>>  static u64 cc_mask __ro_after_init;
>>  
>>  static bool intel_cc_platform_has(enum cc_attr attr)
>> @@ -23,6 +23,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
>>         case CC_ATTR_HOTPLUG_DISABLED:
>>         case CC_ATTR_GUEST_MEM_ENCRYPT:
>>         case CC_ATTR_MEM_ENCRYPT:
>> +       case CC_ATTR_SHMEM:
>>                 return true;
>>         default:
>>                 return false;
> 
> I don't think we need a new attribute. CC_ATTR_MEM_ENCRYPT has to be
> enough.

Ok. Make sense.

> 
>> @@ -134,6 +135,11 @@ __init void cc_set_vendor(enum cc_vendor v)
>>         vendor = v;
>>  }
>>  
>> +enum cc_vendor cc_get_vendor(void)
>> +{
>> +       return vendor;
>> +}
>> +
>>  __init void cc_set_mask(u64 mask)
>>  {
>>         cc_mask = mask;
>>
>> +++ b/arch/x86/coco/shmem.c
>> @@ -0,0 +1,156 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Confidential Computing Shared Memory Allocator
>> + *
>> + * Copyright (C) 2022 Intel Corporation, Inc.
>> + *
>> + */
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt)     "CC: " fmt
>> +
>> +#include <linux/export.h>
>> +#include <linux/cma.h>
>> +#include <linux/mm.h>
>> +#include <linux/cc_platform.h>
>> +#include <linux/set_memory.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +#include <asm/coco.h>
>> +#include <asm/processor.h>
>> +
>> +#define CC_SHMEM_DRIVER                "cc-shmem"
>> +
>> +struct platform_device *shmem_pdev;
>> +
>> +struct shmem_priv
>> +{
>> +       int (*init)(struct platform_device *dev);
>> +       void* (*alloc)(size_t size, gfp_t gfp, struct shmem_priv *priv);
>> +       void (*free)(void *addr, size_t size, struct shmem_priv *priv);
>> +       struct platform_device *pdev;
>> +       void *data;
>> +};
>> +
>> +void *cc_shmem_alloc(size_t size, gfp_t gfp)
>> +{
>> +       struct shmem_priv *priv;
>> +
>> +       if (!shmem_pdev)
>> +               return NULL;
>> +
>> +       priv = platform_get_drvdata(shmem_pdev);
>> +
>> +       return priv->alloc(size, gfp, priv);
>> +}
>> +
>> +void cc_shmem_free(void *addr, size_t size)
>> +{
>> +       struct shmem_priv *priv;
>> +
>> +       if (!shmem_pdev)
>> +               return;
>> +
>> +       priv = platform_get_drvdata(shmem_pdev);
>> +
>> +       priv->free(addr, size, priv);
>> +}
>> +
>> +static int intel_shmem_init(struct platform_device *pdev)
>> +{
>> +       struct shmem_priv *priv;
>> +       dma_addr_t *handle;
>> +
>> +       handle = devm_kmalloc(&pdev->dev, sizeof(*handle), GFP_KERNEL);
>> +       if (!handle)
>> +               return -ENOMEM;
>> +
>> +       priv = platform_get_drvdata(pdev);
>> +
>> +       priv->data = handle;
>> +
>> +       return dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +}
>> +
>> +static void *intel_shmem_alloc(size_t size, gfp_t gfp, struct shmem_priv *priv)
>> +{
>> +       dma_addr_t *handle = (dma_addr_t *) priv->data;
>> +
>> +       return dma_alloc_coherent(&priv->pdev->dev, size, handle, gfp);
>> +}
>> +
>> +static void intel_shmem_free(void *addr, size_t size, struct shmem_priv *priv)
>> +{
>> +       dma_addr_t *handle = (dma_addr_t *) priv->data;
>> +
>> +       return dma_free_coherent(&priv->pdev->dev, size, addr, *handle);
>> +}
>> +
>> +static struct shmem_priv intel_shmem = {
>> +       .init  = intel_shmem_init,
>> +       .alloc = intel_shmem_alloc,
>> +       .free  = intel_shmem_free,
>> +};
> 
> Hm. What is Intel-specific here. Looks like a generic thing, no?
> 
> Maybe just drop all vendor stuff. CC_ATTR_MEM_ENCRYPT should be enough.

I thought that not all CC vendors would want to use DMA APIs for shared
buffer allocation. So adding a vendor layer would give them a way to implement
their own model.

> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
