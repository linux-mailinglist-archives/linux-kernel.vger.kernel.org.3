Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0551D2B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389772AbiEFIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389779AbiEFIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:01:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCC67D24
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651823887; x=1683359887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=emskee1MS2atxZwDugagn6nvmxLCXv6rnE07I1H2Bok=;
  b=ILNLMI5g78P4dKNFiiS+76xZfaXgyIE3a+BNfgrXuPJ+gfKn3oiJzDHE
   oeFqvnE9DLy35YUOuKcRR9EkD6i0FyqpbgUR9FIBiK/IG7/LWt1YsyDxx
   xHCTzjnprrCQ7It20a9hZGq5LHmKU3Nt7KU94aTvg6ZurE689BEvxeTh0
   2xvlM3mNM9GjN0XcNmP15jnopZgskonJiQkaUZjuA1Z63ruuy6SNJ0sHE
   +ApnboYa6Ns78KKXyQKtD3fIdB4aqRkOUopU7Bmwn3VRYfM5hb18zFHZl
   K8NRoUDrjNkH0wvevr6CWhHtuvLljaXop69faHcnLMyVQ5mb0Nq+tHUxX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331374186"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331374186"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:58:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735471694"
Received: from tkinch-mobl.ger.corp.intel.com (HELO [10.213.192.122]) ([10.213.192.122])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:58:03 -0700
Message-ID: <31ca292e-813c-4484-ee6e-5895f26c53d2@linux.intel.com>
Date:   Fri, 6 May 2022 08:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] drm/i915/gt: Fix build error without CONFIG_PM
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, andi.shyti@linux.intel.com,
        matthew.auld@intel.com, andrzej.hajda@intel.com,
        lucas.demarchi@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220506032652.1856-1-yuehaibing@huawei.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220506032652.1856-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/05/2022 04:26, YueHaibing wrote:
> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘act_freq_mhz_show’:
> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:276:20: error: implicit declaration of function ‘sysfs_gt_attribute_r_max_func’ [-Werror=implicit-function-declaration]
>    276 |  u32 actual_freq = sysfs_gt_attribute_r_max_func(dev, attr,
>        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Move sysfs_gt_attribute_* macros out of #ifdef block to fix this.
> 
> Fixes: 56a709cf7746 ("drm/i915/gt: Create per-tile RPS sysfs interfaces")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Thanks for the fix, will merge.

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
> index 26cbfa6477d1..e92990d514b2 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
> @@ -17,7 +17,6 @@
>   #include "intel_rc6.h"
>   #include "intel_rps.h"
>   
> -#ifdef CONFIG_PM
>   enum intel_gt_sysfs_op {
>   	INTEL_GT_SYSFS_MIN = 0,
>   	INTEL_GT_SYSFS_MAX,
> @@ -92,6 +91,7 @@ sysfs_gt_attribute_r_func(struct device *dev, struct device_attribute *attr,
>   #define sysfs_gt_attribute_r_max_func(d, a, f) \
>   		sysfs_gt_attribute_r_func(d, a, f, INTEL_GT_SYSFS_MAX)
>   
> +#ifdef CONFIG_PM
>   static u32 get_residency(struct intel_gt *gt, i915_reg_t reg)
>   {
>   	intel_wakeref_t wakeref;
