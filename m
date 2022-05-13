Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F70D526017
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378979AbiEMKJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350059AbiEMKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:09:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86566B09B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652436550; x=1683972550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5i3oSmoCYG0z99aFLyfO1/Lffb6G3ID6DMGfB1vnRWE=;
  b=Hzwtz6Au5ZteRNGz8p1ybV3hyIc3qYJnYFQ7+k/iD6lOffXQsyafwzrk
   XcZm1qPYpciB72tr+qZGLYsIFuYc2DECSpGmRXLPePqr0BIFJuvvRQd/s
   sFGNnkBQKj3RQ551F98QT1vL4NbVGlbJ5FUamwwOhrjV3viAf1YhtDqzE
   DTHB5K6epK5vLXtyCAxlXnTpvD9o0TjVer4w/EBwl3xZmTyYGxi7xQsVj
   HX1IwFpferGM37SoxGqorMg8VQrVyMMt+tYeNiX98vatKhy9vebQqnAT2
   0vUHDvopyMixGFfMMsHcwf5RxDGk6jaSP32ugAUEC6W7G+MRGHklS2HAr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257815399"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="257815399"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 03:08:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="554167026"
Received: from cpazx-mobl.ger.corp.intel.com (HELO [10.213.209.239]) ([10.213.209.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 03:08:52 -0700
Message-ID: <d7fc4f81-1a04-3633-5d6b-ebc35acb5c4a@linux.intel.com>
Date:   Fri, 13 May 2022 11:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/i915: Fix CFI violation with show_dynamic_id()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
References: <20220512211704.3158759-1-nathan@kernel.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220512211704.3158759-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/05/2022 22:17, Nathan Chancellor wrote:
> When an attribute group is created with sysfs_create_group(), the
> ->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
> callback to kobj_attr_show(). kobj_attr_show() uses container_of() to
> get the ->show() callback from the attribute it was passed, meaning the
> ->show() callback needs to be the same type as the ->show() callback in
> 'struct kobj_attribute'.
> 
> However, show_dynamic_id() has the type of the ->show() callback in
> 'struct device_attribute', which causes a CFI violation when opening the
> 'id' sysfs node under drm/card0/metrics. This happens to work because
> the layout of 'struct kobj_attribute' and 'struct device_attribute' are
> the same, so the container_of() cast happens to allow the ->show()
> callback to still work.
> 
> Change the type of show_dynamic_id() to match the ->show() callback in
> 'struct kobj_attributes' and update the type of sysfs_metric_id to
> match, which resolves the CFI violation.
> 
> Fixes: f89823c21224 ("drm/i915/perf: Implement I915_PERF_ADD/REMOVE_CONFIG interface")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Merged to drm-intel-gt-next, thanks for the fix and reviews!

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/i915/i915_perf.c       | 4 ++--
>   drivers/gpu/drm/i915/i915_perf_types.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 0a9c3fcc09b1..1577ab6754db 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4050,8 +4050,8 @@ static struct i915_oa_reg *alloc_oa_regs(struct i915_perf *perf,
>   	return ERR_PTR(err);
>   }
>   
> -static ssize_t show_dynamic_id(struct device *dev,
> -			       struct device_attribute *attr,
> +static ssize_t show_dynamic_id(struct kobject *kobj,
> +			       struct kobj_attribute *attr,
>   			       char *buf)
>   {
>   	struct i915_oa_config *oa_config =
> diff --git a/drivers/gpu/drm/i915/i915_perf_types.h b/drivers/gpu/drm/i915/i915_perf_types.h
> index 473a3c0544bb..05cb9a335a97 100644
> --- a/drivers/gpu/drm/i915/i915_perf_types.h
> +++ b/drivers/gpu/drm/i915/i915_perf_types.h
> @@ -55,7 +55,7 @@ struct i915_oa_config {
>   
>   	struct attribute_group sysfs_metric;
>   	struct attribute *attrs[2];
> -	struct device_attribute sysfs_metric_id;
> +	struct kobj_attribute sysfs_metric_id;
>   
>   	struct kref ref;
>   	struct rcu_head rcu;
> 
> base-commit: 7ecc3cc8a7b39f08eee9aea7b718187583342a70
