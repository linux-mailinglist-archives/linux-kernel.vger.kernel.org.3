Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F94D1069
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbiCHGn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiCHGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:43:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F09F2194
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646721751; x=1678257751;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uSsImSiLVihQQavFgt4SR/ATlWWTNVvroUOjnmSFYKI=;
  b=j8o71MSurSxvdHLa0gBGE8K7T5xAqkG8A+qfpnF5BS/mw+Q5OFZFRvw2
   LOKPOMUSVP15d1kAVbDV8P+F/6J6qSbHYbBDP+4WJnLTPDqnFNlYuTBh8
   nqryZ4oeydGKpzcjbsAw7nexW1aP+QGqPz6kb11xI0qOp/vLMN+aSLT3x
   FSP21nOmgThZ0NLQFkj0BOjeWEtRMHbQgHWBws/jEIOmCOu6grTs3gPmN
   YCBC293D8z8c+F9lCmATIolPFcOsamz+V9tRVtSxtLKGOG5TRmq9I5Z/q
   ui/oxdvJqn76HUBTGCtWLS0Q5c8NAECAyREbi1JDQ7oy8dNjgstf6riU6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254336735"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254336735"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 22:42:30 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="711428389"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.195]) ([10.254.209.195])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 22:42:27 -0800
Message-ID: <2cde656d-ad3e-6371-1647-489963ab3c33@linux.intel.com>
Date:   Tue, 8 Mar 2022 14:42:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     baolu.lu@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] agp/intel: Use per device iommu check
Content-Language: en-US
To:     David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Myers <ncm@cantrip.org>
References: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
 <20220211030531.2398789-2-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220211030531.2398789-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/11 11:05, Lu Baolu wrote:
> The IOMMU subsystem has already provided an interface to query whether
> the IOMMU hardware is enabled for a specific device. This changes the
> check from Intel specific intel_iommu_gfx_mapped (globally exported by
> the Intel IOMMU driver) to probing the presence of IOMMU on a specific
> device using the generic device_iommu_mapped().
> 
> This follows commit cca084692394a ("drm/i915: Use per device iommu check")
> which converted drm/i915 driver to use device_iommu_mapped().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/char/agp/intel-gtt.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
> index c53cc9868cd8..9631cbc7002e 100644
> --- a/drivers/char/agp/intel-gtt.c
> +++ b/drivers/char/agp/intel-gtt.c
> @@ -20,7 +20,7 @@
>   #include <linux/kernel.h>
>   #include <linux/pagemap.h>
>   #include <linux/agp_backend.h>
> -#include <linux/intel-iommu.h>
> +#include <linux/iommu.h>
>   #include <linux/delay.h>
>   #include <asm/smp.h>
>   #include "agp.h"
> @@ -573,18 +573,15 @@ static void intel_gtt_cleanup(void)
>    */
>   static inline int needs_ilk_vtd_wa(void)
>   {
> -#ifdef CONFIG_INTEL_IOMMU
>   	const unsigned short gpu_devid = intel_private.pcidev->device;
>   
> -	/* Query intel_iommu to see if we need the workaround. Presumably that
> -	 * was loaded first.
> +	/*
> +	 * Query iommu subsystem to see if we need the workaround. Presumably
> +	 * that was loaded first.
>   	 */
> -	if ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
> -	     gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
> -	     intel_iommu_gfx_mapped)
> -		return 1;
> -#endif
> -	return 0;
> +	return ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
> +		 gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
> +		device_iommu_mapped(&intel_private.pcidev->dev));
>   }
>   
>   static bool intel_gtt_can_wc(void)

A gentle ping ...:-)

Best regards,
baolu
