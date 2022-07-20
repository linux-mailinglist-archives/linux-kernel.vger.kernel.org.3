Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A657B8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiGTO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiGTO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:56:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1514D07
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658328966; x=1689864966;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=aHHAbzPH1DfQsTAzc1XuagfKrZHIiMeOqjMPd7BSof0=;
  b=M+Cq3VY2U10/+53rHf68ZmzH/p6xtOphGJqnkcXExc7uXhIBrbVa17F5
   XvOvfijDT0DBAW6MIBWoVAEDkNNQLTUu0UHwWEvl1zm0ceWqoPFyy9YhI
   Avxmmp3Qsyj7SxxzZS+MeY1PSYBhxhAQ8NvLRnpQ/i8x15BbrdVZ6EWTv
   PvobwNE0Y6ooAG9Ibr8ctE2sDvDxbrIxl93PPCiuNjXec3SegiwzcwRkB
   EQt7F6b4eicWziDZMWSXuYO6KvHgcs/KvXacPUSwkLpGb2xjck2VjNp6l
   3qrERcBTO++c55B9oC3X8qsxIyHeTymfbcVhnTQNYA4L8X6KpOdMrIu9k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285562703"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="285562703"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 07:56:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="844069252"
Received: from cberteau-mobl1.amr.corp.intel.com (HELO [10.251.5.148]) ([10.251.5.148])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 07:56:04 -0700
Message-ID: <40131b10-7bff-6672-2f2d-179fdd65c430@linux.intel.com>
Date:   Wed, 20 Jul 2022 07:56:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
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
 <1f320d34-c467-38fa-17b1-d0c7cde7b0d0@linux.intel.com>
 <20220719215534.obolreae5dxdk223@black.fi.intel.com>
Content-Language: en-US
In-Reply-To: <20220719215534.obolreae5dxdk223@black.fi.intel.com>
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

Hi Kirill,

On 7/19/22 2:55 PM, Kirill A. Shutemov wrote:
> On Tue, Jul 19, 2022 at 10:10:20AM -0700, Sathyanarayanan Kuppuswamy wrote:
>>>> +static struct shmem_priv intel_shmem = {
>>>> +       .init  = intel_shmem_init,
>>>> +       .alloc = intel_shmem_alloc,
>>>> +       .free  = intel_shmem_free,
>>>> +};
>>>
>>> Hm. What is Intel-specific here. Looks like a generic thing, no?
>>>
>>> Maybe just drop all vendor stuff. CC_ATTR_MEM_ENCRYPT should be enough.
>>
>> I thought that not all CC vendors would want to use DMA APIs for shared
>> buffer allocation. So adding a vendor layer would give them a way to implement
>> their own model.
> 
> set_memory_decrypted() is gated by CC_ATTR_MEM_ENCRYPT and it is the only
> requirement for functionality AFAICS.

Makes sense. I think CC_ATTR_GUEST_MEM_ENCRYPT is the better check here. It
force enables the SWIOTLB usage.

diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c816acf78b6a..96fc4ec4497f 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -3,6 +3,6 @@ CFLAGS_REMOVE_core.o    = -pg
 KASAN_SANITIZE_core.o  := n
 CFLAGS_core.o          += -fno-stack-protector
 
-obj-y += core.o
+obj-y += core.o mem.o
 
 obj-$(CONFIG_INTEL_TDX_GUEST)  += tdx/
diff --git a/arch/x86/coco/mem.c b/arch/x86/coco/mem.c
new file mode 100644
index 000000000000..ef76a8accc1e
--- /dev/null
+++ b/arch/x86/coco/mem.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Confidential Computing Decrypted Memory Allocator
+ *
+ * Copyright (C) 2022 Intel Corporation, Inc.
+ *
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt)     "cc/mem: " fmt
+
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/cc_platform.h>
+#include <linux/set_memory.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/coco.h>
+#include <asm/processor.h>
+
+#define CC_MEM_DRIVER          "ccmem"
+
+struct platform_device *mem_pdev;
+dma_addr_t handle;
+
+/* Allocate decrypted memory of given size */
+void *cc_decrypted_alloc(size_t size, gfp_t gfp)
+{
+       if (!mem_pdev)
+               return NULL;
+
+       return dma_alloc_coherent(&mem_pdev->dev, size, &handle, gfp);
+}
+
+/* Free given decrypted memory */
+void cc_decrypted_free(void *addr, size_t size)
+{
+       if (!mem_pdev)
+               return;
+
+       dma_free_coherent(&mem_pdev->dev, size, addr, handle);
+}
+
+static int cc_mem_probe(struct platform_device *pdev)
+{
+       if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64)))
+               return -EIO;
+
+       mem_pdev = pdev;
+
+       return 0;
+}
+
+static struct platform_driver cc_mem_driver = {
+       .probe  = cc_mem_probe,
+       .driver = {
+               .name = CC_MEM_DRIVER,
+       },
+};
+
+static int __init cc_mem_init(void)
+{
+       struct platform_device *pdev;
+       int ret;
+
+       if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+               return -ENODEV;
+
+       ret =  platform_driver_register(&cc_mem_driver);
+       if (ret)
+               return ret;
+
+       pdev = platform_device_register_simple(CC_MEM_DRIVER, -1, NULL, 0);
+       if (IS_ERR(pdev)) {
+               platform_driver_unregister(&cc_mem_driver);
+               return PTR_ERR(pdev);
+       }
+
+       return 0;
+}
+device_initcall(cc_mem_init);
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..9d616d9e3405 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -17,6 +17,8 @@ void cc_set_mask(u64 mask);
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void *cc_decrypted_alloc(size_t size, gfp_t gfp);
+void cc_decrypted_free(void *addr, size_t size);
 #else
 static inline u64 cc_mkenc(u64 val)
 {
@@ -27,6 +29,10 @@ static inline u64 cc_mkdec(u64 val)
 {
        return val;
 }
+
+void *cc_decrypted_alloc(size_t size, gfp_t gfp) { return NULL; }
+void cc_decrypted_free(void *addr, size_t size) { }
+
 #endif
 
 #endif /* _ASM_X86_COCO_H 



> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
