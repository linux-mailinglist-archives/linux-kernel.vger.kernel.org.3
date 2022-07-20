Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7174457BB31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiGTQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:18:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857173CBD4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658333882; x=1689869882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PD8parkOBN/qk988ED4eOf8SCsPHOxZ9nlj1lRTxuPU=;
  b=Bb1Ew+E7dO4MI7NJy4EgijUG3Wf04QF2M3aGZb4e8ThPygOuCoBVCxSn
   lldb5F0GCQtjSpfG3aw8SKMznnHCc60psJ0ghLQV1+v3tcboL2X393+rh
   vt+vJ5t1GUjBBuw+vtNIhBbq/wEFdAfyGE45nYYg8o2bFyXXtfGWOvoHn
   g94uua+oFdluHjs1AoTW9Qt1VZq4kcPvxUTG2KODigY0HTnlfGpLW4BEt
   fXaqObyoK9KHg45lH8yjlpO9k07Q2MIpxnD3tSEt4PKzjzexh9o5Kfsia
   ql1bEJQCZeHhmomHm69K0srbtUWXp+yfcZJY0aiSXhjoF+brHJJgOZWbg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="348515750"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="348515750"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 09:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="665923359"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2022 09:17:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D601A199; Wed, 20 Jul 2022 19:17:51 +0300 (EEST)
Date:   Wed, 20 Jul 2022 19:17:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Message-ID: <20220720161751.hqztgi6vdxaif6zf@black.fi.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40131b10-7bff-6672-2f2d-179fdd65c430@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 07:56:04AM -0700, Sathyanarayanan Kuppuswamy wrote:
> diff --git a/arch/x86/coco/mem.c b/arch/x86/coco/mem.c
> new file mode 100644
> index 000000000000..ef76a8accc1e
> --- /dev/null
> +++ b/arch/x86/coco/mem.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Confidential Computing Decrypted Memory Allocator
> + *
> + * Copyright (C) 2022 Intel Corporation, Inc.
> + *
> + */
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)     "cc/mem: " fmt
> +
> +#include <linux/export.h>
> +#include <linux/mm.h>
> +#include <linux/cc_platform.h>
> +#include <linux/set_memory.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <asm/coco.h>
> +#include <asm/processor.h>
> +
> +#define CC_MEM_DRIVER          "ccmem"
> +
> +struct platform_device *mem_pdev;

'static'?

> +dma_addr_t handle;

Hm. How does it work with >1 allocation a time?

> +
> +/* Allocate decrypted memory of given size */
> +void *cc_decrypted_alloc(size_t size, gfp_t gfp)
> +{
> +       if (!mem_pdev)
> +               return NULL;
> +
> +       return dma_alloc_coherent(&mem_pdev->dev, size, &handle, gfp);
> +}
> +
> +/* Free given decrypted memory */
> +void cc_decrypted_free(void *addr, size_t size)
> +{
> +       if (!mem_pdev)
> +               return;
> +
> +       dma_free_coherent(&mem_pdev->dev, size, addr, handle);
> +}
> +

-- 
 Kirill A. Shutemov
