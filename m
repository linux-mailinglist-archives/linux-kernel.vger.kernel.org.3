Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BC472CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbhLMNCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:02:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:62212 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237123AbhLMNCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639400569; x=1670936569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+hkuBro1FIArmqCU4DnYmYNozBM1ig92k/dHzqugSr8=;
  b=nsKEA65CIT0kIIS3UOkwgK5wjcI3WaMVs/N/s1wTAPg2xN4UgdN+lJb/
   QSiTSCX14YqVczC3vWGvP7CbDIK6E3a7DBlh7oQzMggziNJTwN9unHzNr
   yEoIkKMPVZnEQUml259DJM35c51HN3kEwbg+6RFyPdiMoU6SOZ5XYdg1o
   cpmG6gxz96Jd5kCfGySm0hsZGZ1WsQ2F9i46rWQ90VSiSU2tYKXkNf06R
   CMDuKlKIVeKYo3TvFicpg61DkDuD5WWwkhj21tsLFV8rbwhOM866inZdd
   6NkSsBUk73GghmbsG3JLgn9NKYhj5kXVZkMFeYlGZUb1HBNeZbwBNqwhj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238949452"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238949452"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 05:02:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="463371551"
Received: from ttbuckle-mobl.ger.corp.intel.com (HELO [10.252.5.128]) ([10.252.5.128])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 05:02:46 -0800
Message-ID: <e7cad6ca-d106-c529-6f22-93a7847cd7c0@intel.com>
Date:   Mon, 13 Dec 2021 13:02:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/i915/ttm: fix large buffer population trucation
Content-Language: en-GB
To:     Robert Beckett <bob.beckett@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, Oak Zeng <oak.zeng@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20211210195005.2582884-1-bob.beckett@collabora.com>
From:   Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20211210195005.2582884-1-bob.beckett@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 19:50, Robert Beckett wrote:
> ttm->num_pages is uint32_t which was causing very large buffers to
> only populate a truncated size.
> 
> This fixes gem_create@create-clear igt test on large memory systems.
> 
> Fixes: 7ae034590cea ("drm/i915/ttm: add tt shmem backend")
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

Nice catch,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 218a9b3037c7..923cc7ad8d70 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -166,7 +166,7 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
>   	struct intel_memory_region *mr = i915->mm.regions[INTEL_MEMORY_SYSTEM];
>   	struct i915_ttm_tt *i915_tt = container_of(ttm, typeof(*i915_tt), ttm);
>   	const unsigned int max_segment = i915_sg_segment_size();
> -	const size_t size = ttm->num_pages << PAGE_SHIFT;
> +	const size_t size = (size_t)ttm->num_pages << PAGE_SHIFT;
>   	struct file *filp = i915_tt->filp;
>   	struct sgt_iter sgt_iter;
>   	struct sg_table *st;
> 
