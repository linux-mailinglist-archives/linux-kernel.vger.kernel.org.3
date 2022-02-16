Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0144B8382
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiBPJCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:02:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiBPJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:02:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D78586E38;
        Wed, 16 Feb 2022 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645002136; x=1676538136;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mwF1U5j+drzsRrwL7zZWjzrwyGUiQkfyhUKOWPFbLPM=;
  b=KgKF8cKykpQqZ3HjSpxnJFWn/ty/XllRG4ENAYkEKT2w8eHWA6DZ8PpC
   LOObUtcrKyAqwu9TksdAxF8Jz6XmWt/eLnJNVk2Lu6EyND/EAHpYFuuaT
   nNm9fYbqpWjn6N79rGhVfl/TlYrVfDGWssjAzSo7ACtn42dKgYXXdsuMP
   Ugi6rwp42pJiAEVddYmZ7lTrCXzCFBHfIb7emeT0Ld3a4JAftatKxzavH
   pnYQbWr/HY50heNdAC1zF6k/OhyRGMr3YinCcefkzKRBm8KcaNagZySAj
   JS9iQt9pnCeLNe3sTmLsp6QzualmJ/5lc8xJLMJ6jyGf8fX+++8urOUnj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275137222"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="275137222"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:02:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="704216865"
Received: from rbilei-mobl.ger.corp.intel.com (HELO localhost) ([10.252.13.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:02:10 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] drm/i915/gt: fix unsigned integer to signed assignment
In-Reply-To: <20220216083849.91239-1-jiapeng.chong@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220216083849.91239-1-jiapeng.chong@linux.alibaba.com>
Date:   Wed, 16 Feb 2022 11:02:06 +0200
Message-ID: <87h78z5gmp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022, Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> Eliminate the follow smatch warning:
>
> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4640
> guc_create_virtual() warn: assigning (-2) to unsigned variable
> 've->base.instance'.
>
> drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:4641
> guc_create_virtual() warn: assigning (-2) to unsigned variable
> 've->base.uabi_instance'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The report seems to be valid, but I don't think this is the fix.

Where do we even check for invalid instance/uabi_instance in code?

BR,
Jani.


> ---
>  drivers/gpu/drm/i915/gt/intel_engine_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
> index 36365bdbe1ee..dc7cc06c68e7 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
> @@ -328,10 +328,10 @@ struct intel_engine_cs {
>  	intel_engine_mask_t logical_mask;
>  
>  	u8 class;
> -	u8 instance;
> +	s8 instance;
>  
>  	u16 uabi_class;
> -	u16 uabi_instance;
> +	s16 uabi_instance;
>  
>  	u32 uabi_capabilities;
>  	u32 context_size;

-- 
Jani Nikula, Intel Open Source Graphics Center
