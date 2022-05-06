Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A97151D2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389820AbiEFIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbiEFIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:12:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016F3340EB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651824535; x=1683360535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UomkzKLap10+6cV2j8PZE1NwHs8rrur9oxMPmv8zByM=;
  b=Ahvt5x/YzkvkdoYTuXPRAdjgkNBww6GPDjP+LgkfEPad+/xG6Q4Db5PA
   uFxKcpRxyihbVdvRNFF6jcjppacCsxj8acjHnIMEfsfTZW+3GzR19uWVi
   mPzkBVrGe6+abVuT9iJYMnglf8iMAlXdcQMe8r5ma2zxhplhH12hjNg0P
   fnXG6YIXBdWBow0S+TGv1Rq5fFo6wd+dMWw8Wf9kY15d3QwaBMrhkfhK8
   Is/JqvbOqcXmhRVyU0xtD3LNY4zAEHRoEZTlFLzDDlCwugLxu8aOnJfUH
   tpKbaEoa/Xo0FFD8/d240tg7yi6wdQGRrttaGrgOYF9338Kx36C1ZFHRr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="250385906"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250385906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:08:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585845577"
Received: from blaesing-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.218.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 01:08:49 -0700
Date:   Fri, 6 May 2022 10:08:46 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, andi.shyti@linux.intel.com,
        matthew.auld@intel.com, andrzej.hajda@intel.com,
        lucas.demarchi@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/i915/gt: Fix build error without CONFIG_PM
Message-ID: <YnTXjmbqBjPxxaFS@intel.intel>
References: <20220506032652.1856-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506032652.1856-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

On Fri, May 06, 2022 at 11:26:52AM +0800, YueHaibing wrote:
> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘act_freq_mhz_show’:
> drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:276:20: error: implicit declaration of function ‘sysfs_gt_attribute_r_max_func’ [-Werror=implicit-function-declaration]
>   276 |  u32 actual_freq = sysfs_gt_attribute_r_max_func(dev, attr,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Move sysfs_gt_attribute_* macros out of #ifdef block to fix this.
> 
> Fixes: 56a709cf7746 ("drm/i915/gt: Create per-tile RPS sysfs interfaces")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

> ---
>  drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
> index 26cbfa6477d1..e92990d514b2 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
> @@ -17,7 +17,6 @@
>  #include "intel_rc6.h"
>  #include "intel_rps.h"
>  
> -#ifdef CONFIG_PM
>  enum intel_gt_sysfs_op {
>  	INTEL_GT_SYSFS_MIN = 0,
>  	INTEL_GT_SYSFS_MAX,
> @@ -92,6 +91,7 @@ sysfs_gt_attribute_r_func(struct device *dev, struct device_attribute *attr,
>  #define sysfs_gt_attribute_r_max_func(d, a, f) \
>  		sysfs_gt_attribute_r_func(d, a, f, INTEL_GT_SYSFS_MAX)
>  
> +#ifdef CONFIG_PM
>  static u32 get_residency(struct intel_gt *gt, i915_reg_t reg)
>  {
>  	intel_wakeref_t wakeref;
> -- 
> 2.17.1
