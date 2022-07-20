Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5157BC29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiGTQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGTQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:58:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DD6717C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658336325; x=1689872325;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BFImNK5eREkejYe/tJnP6qBOkAnpkrxpF29sYd7vAng=;
  b=eGrQlC4joRu4Twn3OsMj2EpreeppO8as7vIdaQAKLsuFtdVexBqZrUPg
   k3J8I/56IA9WRgJ8ruy4nk8ieVe+3qBSWdgdFoE4WGFGfIB6MF4GUz5np
   wE4YCLmaLWrOzgcVG7amE91UPLXM40ppWTFHQ8xhWuaCYSHSO1FOYyFzU
   irhBKvfwgZRaI5zkV9AdFPr5/Lp7hEJ04nnoHvk4Jx6jJYjUZ4oY7YVoN
   +OV48pgOLUOt6whVfX3p/Weu8nyISl9v+YBR065tVajmTgjgL8sJ2cdNk
   V74gRfahaGEouEUCHXWLoYQ0AkiS+nEUid4B0NJpDnlVPggiDvzuQX8B4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287991064"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="287991064"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 09:58:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="740356314"
Received: from cberteau-mobl1.amr.corp.intel.com (HELO [10.251.5.148]) ([10.251.5.148])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 09:58:43 -0700
Message-ID: <334a40d3-452b-4df1-a2ed-c79b87be086f@linux.intel.com>
Date:   Wed, 20 Jul 2022 09:58:42 -0700
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
References: <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
 <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
 <fe896ec7-cfce-e8ce-240d-88cca47f8996@intel.com>
 <6b84f9058ce5e60fdf3e4abd075a2b8f591ccffc.camel@intel.com>
 <20220705152910.rq2ga25gnw7kuvt5@box.shutemov.name>
 <5804d4a8-8c5f-5352-8eed-4962e0adca1c@linux.intel.com>
 <20220719161354.27cak6zy3uws3fvm@black.fi.intel.com>
 <1f320d34-c467-38fa-17b1-d0c7cde7b0d0@linux.intel.com>
 <20220719215534.obolreae5dxdk223@black.fi.intel.com>
 <40131b10-7bff-6672-2f2d-179fdd65c430@linux.intel.com>
 <20220720161751.hqztgi6vdxaif6zf@black.fi.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220720161751.hqztgi6vdxaif6zf@black.fi.intel.com>
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



On 7/20/22 9:17 AM, Kirill A. Shutemov wrote:
> On Wed, Jul 20, 2022 at 07:56:04AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> diff --git a/arch/x86/coco/mem.c b/arch/x86/coco/mem.c
>> new file mode 100644
>> index 000000000000..ef76a8accc1e
>> --- /dev/null
>> +++ b/arch/x86/coco/mem.c
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Confidential Computing Decrypted Memory Allocator
>> + *
>> + * Copyright (C) 2022 Intel Corporation, Inc.
>> + *
>> + */
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt)     "cc/mem: " fmt
>> +
>> +#include <linux/export.h>
>> +#include <linux/mm.h>
>> +#include <linux/cc_platform.h>
>> +#include <linux/set_memory.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +
>> +#include <asm/coco.h>
>> +#include <asm/processor.h>
>> +
>> +#define CC_MEM_DRIVER          "ccmem"
>> +
>> +struct platform_device *mem_pdev;
> 
> 'static'?

Agree.

> 
>> +dma_addr_t handle;
> 
> Hm. How does it work with >1 allocation a time?

It is a bug. I think we should make it as parameter to alloc/free APIs.

> 
>> +
>> +/* Allocate decrypted memory of given size */
>> +void *cc_decrypted_alloc(size_t size, gfp_t gfp)
>> +{
>> +       if (!mem_pdev)
>> +               return NULL;
>> +
>> +       return dma_alloc_coherent(&mem_pdev->dev, size, &handle, gfp);
>> +}
>> +
>> +/* Free given decrypted memory */
>> +void cc_decrypted_free(void *addr, size_t size)
>> +{
>> +       if (!mem_pdev)
>> +               return;
>> +
>> +       dma_free_coherent(&mem_pdev->dev, size, addr, handle);
>> +}
>> +
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
