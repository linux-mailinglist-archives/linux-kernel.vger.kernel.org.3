Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5F5A2246
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbiHZHuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245626AbiHZHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:50:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFDB6D54A;
        Fri, 26 Aug 2022 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661500209; x=1693036209;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lz2nlc39lwdcTUXOc/Lv9g64tJOeRWMEspIuHmIzNNU=;
  b=JkioT9tq1xRSTmdzLrjInDcipWd0S2LFk0p9kWwHl7Re4ov87KUAZzhq
   Y4lXp1691yZCaKqWbNgRzR8RDrdURmwOrmA1Mt/+hYjSIqRGncIOd7Yp8
   8L50AreM5YnQCQKUBZZQxfbUXLYN4Caxd393VxLKHJ84wz1ySFmiCXfjs
   uFDiJiJamMkrfEsFuJ1zYw2DOFn/4RxqTUAyC+PdO0Od2weUUWsINLF7Z
   gAn5kjBd761p1Z1cqgaRjhRpgXlWN18TnnjsBhs9agHnfRtyQuw0ZgI5S
   xnQZJHBME5XBOpYb/2tWxN7gxizZtRlA9+SVQ6lsmgFBI2ZsqHoZjZMSE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295230204"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295230204"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 00:50:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="639965788"
Received: from plomuzio-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.203])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 00:50:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@linux.ie>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        John Harrison <John.C.Harrison@Intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
In-Reply-To: <20220826123636.72fbea19@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220826123636.72fbea19@canb.auug.org.au>
Date:   Fri, 26 Aug 2022 10:50:00 +0300
Message-ID: <87k06vh2af.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the drm-intel tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/i915/gt/uc/intel_guc.c: In function 'intel_guc_dump_time_info':
> drivers/gpu/drm/i915/gt/uc/intel_guc.c:399:9: error: implicit declaration of function 'intel_device_info_print_runtime'; did you mean 'intel_device_info_print'? [-Werror=implicit-function-declaration]
>   399 |         intel_device_info_print_runtime(RUNTIME_INFO(gt->i915), p);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         intel_device_info_print
>
> Caused by commit
>
>   c7d3c8447b26 ("drm/i915: combine device info printing into one")
>
> interacting with commit
>
>   368d179adbac ("drm/i915/guc: Add GuC <-> kernel time stamp translation information")
>
> from the drm tree.

There's commit f0c70d41e4e8 ("drm/i915/guc: remove runtime info printing
from time stamp logging") in drm-intel-gt-next removing that line
altogether.

BR,
Jani.

>
> I have applied the following merge fix patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 26 Aug 2022 12:30:19 +1000
> Subject: [PATCH] fix up for "drm/i915/guc: Add GuC <-> kernel time stamp translation information"
>
> interacting with "drm/i915: combine device info printing into one".
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/i915/gt/uc/intel_guc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
> index ab4aacc516aa..977278d71182 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
> @@ -396,7 +396,7 @@ void intel_guc_dump_time_info(struct intel_guc *guc, struct drm_printer *p)
>  	u32 stamp = 0;
>  	u64 ktime;
>  
> -	intel_device_info_print_runtime(RUNTIME_INFO(gt->i915), p);
> +	intel_device_info_print(INTEL_INFO(gt->i915), RUNTIME_INFO(gt->i915), p);
>  
>  	with_intel_runtime_pm(&gt->i915->runtime_pm, wakeref)
>  		stamp = intel_uncore_read(gt->uncore, GUCPMTIMESTAMP);
> -- 
> 2.35.1

-- 
Jani Nikula, Intel Open Source Graphics Center
