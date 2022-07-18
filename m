Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A2578540
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiGROW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiGROW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:22:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476A13D44
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658154174; x=1689690174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ek3UKLT6f1jtkJiz9AwJ8w7ToM4rhqOKSRVPk3hlKyY=;
  b=HsLyot1/cy/d4nSN+WFJg4x6nhlea0cngu4GUITGeGKsYbWv0xCCXE+6
   sDSK2V9mf3LxEgMpV+KvZdhmO9dlXIH8O93TWclg/i/QxDS1oSPbdJGaV
   slkxxHQu42Fioh+VfXy8kNk5OpOuZLgTL4UN5lB3yq6MGpjEEJoCiO3FT
   jcgzjSfj5vBCyTCD4p6ENP9U3LVJv68ScQVdl23sbN82XzpovpUiFcdRg
   7nl2o9cRsErlR3EjCHbmwFoUIbQn7jroja3+47TXb7UnbwjuqubdSFE6Y
   97vV9kFpIW58es9EKzhD8YuViqDBVBJufajs9kR/jYRMIha0pb4blmELA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="350194156"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="350194156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 07:22:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="924360865"
Received: from bezenwak-mobl.amr.corp.intel.com (HELO [10.209.117.154]) ([10.209.117.154])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 07:22:52 -0700
Message-ID: <5804d4a8-8c5f-5352-8eed-4962e0adca1c@linux.intel.com>
Date:   Mon, 18 Jul 2022 07:22:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220705152910.rq2ga25gnw7kuvt5@box.shutemov.name>
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

Hi Dave,

On 7/5/22 8:29 AM, Kirill A. Shutemov wrote:
>>> I still don't like the idea of using the DMA API itself.  But, maybe we
>>> need some common infrastructure that the DMA API and this code use which
>>> says, "get me some pages that I can safely make shared".
>> Right.  For instance any KVM PV feature would require shared memory, and DMA API
>> normally doesn't fit (taking 'struct kvm_steal_time' as example).
>>
>> Maybe we can reserve a CMA for this purpose.
> CMA for couple low traffic users sounds like an overkill. It will create
> an separate pool just for them.
> 
> I think the best way is to add an dummy device and couple of helpers
> around DMA API that would allow to tap into swiotlb.
> 
> Maybe hide it inside CC infrastructure. Like cc_decrypted_alloc() and
> cc_decrypted_free().

I also think creating a generic device in the CC layer, and using it to allocate
memory via DMA APIs is a better approach for this issue. Following is the sample
implementation to give you an idea on how it looks. Please let me know
your comments.

cc_shmem_alloc/free() APIs can be used by CC users to allocate and
free shared memory.

Other vendors can define their own shared memory allocation and free
logic via struct shmem_priv alloc/free/init hooks.

--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -3,6 +3,6 @@ CFLAGS_REMOVE_core.o    = -pg
 KASAN_SANITIZE_core.o  := n
 CFLAGS_core.o          += -fno-stack-protector
 
-obj-y += core.o
+obj-y += core.o shmem.o
 
 obj-$(CONFIG_INTEL_TDX_GUEST)  += tdx/
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f881484..62fe68d1f60a 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
-static enum cc_vendor vendor __ro_after_init;
+enum cc_vendor vendor __ro_after_init;
 static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -23,6 +23,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
        case CC_ATTR_HOTPLUG_DISABLED:
        case CC_ATTR_GUEST_MEM_ENCRYPT:
        case CC_ATTR_MEM_ENCRYPT:
+       case CC_ATTR_SHMEM:
                return true;
        default:
                return false;
@@ -134,6 +135,11 @@ __init void cc_set_vendor(enum cc_vendor v)
        vendor = v;
 }
 
+enum cc_vendor cc_get_vendor(void)
+{
+       return vendor;
+}
+
 __init void cc_set_mask(u64 mask)
 {
        cc_mask = mask;

+++ b/arch/x86/coco/shmem.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Shared Memory Allocator
+ *
+ * Copyright (C) 2022 Intel Corporation, Inc.
+ *
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "CC: " fmt
+
+#include <linux/export.h>
+#include <linux/cma.h>
+#include <linux/mm.h>
+#include <linux/cc_platform.h>
+#include <linux/set_memory.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/coco.h>
+#include <asm/processor.h>
+
+#define CC_SHMEM_DRIVER                "cc-shmem"
+
+struct platform_device *shmem_pdev;
+
+struct shmem_priv
+{
+       int (*init)(struct platform_device *dev);
+       void* (*alloc)(size_t size, gfp_t gfp, struct shmem_priv *priv);
+       void (*free)(void *addr, size_t size, struct shmem_priv *priv);
+       struct platform_device *pdev;
+       void *data;
+};
+
+void *cc_shmem_alloc(size_t size, gfp_t gfp)
+{
+       struct shmem_priv *priv;
+
+       if (!shmem_pdev)
+               return NULL;
+
+       priv = platform_get_drvdata(shmem_pdev);
+
+       return priv->alloc(size, gfp, priv);
+}
+
+void cc_shmem_free(void *addr, size_t size)
+{
+       struct shmem_priv *priv;
+
+       if (!shmem_pdev)
+               return;
+
+       priv = platform_get_drvdata(shmem_pdev);
+
+       priv->free(addr, size, priv);
+}
+
+static int intel_shmem_init(struct platform_device *pdev)
+{
+       struct shmem_priv *priv;
+       dma_addr_t *handle;
+
+       handle = devm_kmalloc(&pdev->dev, sizeof(*handle), GFP_KERNEL);
+       if (!handle)
+               return -ENOMEM;
+
+       priv = platform_get_drvdata(pdev);
+
+       priv->data = handle;
+
+       return dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+}
+
+static void *intel_shmem_alloc(size_t size, gfp_t gfp, struct shmem_priv *priv)
+{
+       dma_addr_t *handle = (dma_addr_t *) priv->data;
+
+       return dma_alloc_coherent(&priv->pdev->dev, size, handle, gfp);
+}
+
+static void intel_shmem_free(void *addr, size_t size, struct shmem_priv *priv)
+{
+       dma_addr_t *handle = (dma_addr_t *) priv->data;
+
+       return dma_free_coherent(&priv->pdev->dev, size, addr, *handle);
+}
+
+static struct shmem_priv intel_shmem = {
+       .init  = intel_shmem_init,
+       .alloc = intel_shmem_alloc,
+       .free  = intel_shmem_free,
+};
+
+static int cc_set_drv_data(struct platform_device *pdev)
+{
+       enum cc_vendor vendor = cc_get_vendor();
+
+       switch (vendor) {
+       case CC_VENDOR_INTEL:
+               platform_set_drvdata(pdev, &intel_shmem);
+               return 0;
+       default:
+               break;
+       }
+
+       return -ENODEV;
+}
+
+static int cc_shmem_probe(struct platform_device *pdev)
+{
+       struct shmem_priv *priv;
+       void *data;
+
+       if (cc_set_drv_data(pdev))
+               return -ENODEV;
+
+       priv = platform_get_drvdata(pdev);
+
+       shmem_pdev = priv->pdev = pdev;
+
+       if (priv->init(pdev))
+               return -EIO;
+
+       return 0;
+}
+
+static struct platform_driver cc_shmem_driver = {
+       .probe  = cc_shmem_probe,
+       .driver = {
+               .name = CC_SHMEM_DRIVER,
+       },
+};
+
+static int __init cc_shmem_init(void)
+{
+       struct platform_device *pdev;
+       int ret;
+
+       if (!cc_platform_has(CC_ATTR_SHMEM))
+               return -ENODEV;
+
+       ret =  platform_driver_register(&cc_shmem_driver);
+       if (ret)
+               return ret;
+
+       pdev = platform_device_register_simple(CC_SHMEM_DRIVER, -1, NULL, 0);
+       if (IS_ERR(pdev)) {
+               platform_driver_unregister(&cc_shmem_driver);
+               return PTR_ERR(pdev);
+       }
+
+       return 0;
+}
+device_initcall(cc_shmem_init);
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..5c259135c8fc 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -12,11 +12,14 @@ enum cc_vendor {
 };
 
 void cc_set_vendor(enum cc_vendor v);
+enum cc_vendor cc_get_vendor(void);
 void cc_set_mask(u64 mask);
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void *cc_shmem_alloc(size_t size, gfp_t gfp);
+void cc_shmem_free(void *addr, size_t size);
 #else
 static inline u64 cc_mkenc(u64 val)
 {
@@ -27,6 +30,10 @@ static inline u64 cc_mkdec(u64 val)
 {
        return val;
 }
+
+void *cc_shmem_alloc(size_t size, gfp_t gfp) { return NULL; }
+void cc_shmem_free(void *addr, size_t size) { }
+
 #endif
 
 #endif /* _ASM_X86_COCO_H */
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..50e0db22056f 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -90,6 +90,17 @@ enum cc_attr {
         * Examples include TDX Guest.
         */
        CC_ATTR_HOTPLUG_DISABLED,
+
+       /**
+        * @CC_ATTR_SHMEM: CC shared memory is supported.
+        *
+        * The platform/OS is running as a guest/virtual machine
+        * can allocate shared memory using cc_shmem_{alloc/free}()
+        * APIs.
+        *
+        */
+       CC_ATTR_SHMEM,
+
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
