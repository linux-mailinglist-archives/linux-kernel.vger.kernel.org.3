Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2406D561E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiF3Og5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiF3Ogl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:36:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFCD58FC1;
        Thu, 30 Jun 2022 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656599392; x=1688135392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wQpzAJXTo7Bhnhsk3imUJSwSv9/OyCu1er02rRF6zKA=;
  b=OOdEHLEFZ5SJXDev514ghXyhkZpYLlHGYz24gYfPWtUVC4pINjPvVI3K
   49jPUiiM+B3cQnvSiFlUGyJqBguYztEDhTdaAU7/ahzuiT0YJh8x5sD6Y
   vs7wvxZ77oCCWKXEUpai0eRiDBQmKhgBFKQxexU/wbbm/CkUG+7MpDqyW
   ZqvZKtWgQpJ9NTJmJkvFM1tFXOdxNT2eOaDOHGC3+jfx+XIb+xkUdKOxX
   X4sQJfHqiQtsbzbd8gxpXR2T8iDczy1HqpIIomXQtpics7445R6JGAbBf
   oDq++A9lv/U8S9Y8PKk/0UFpA947vDUJfffwkGyHVZSv3XtYWtwKDPSdz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="281127819"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="281127819"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:29:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="647912693"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.25.211]) ([10.213.25.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:29:44 -0700
Message-ID: <95e834e2-bd6f-efd9-28d2-9e983f9de7ae@intel.com>
Date:   Thu, 30 Jun 2022 16:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Remove __dma_fence_is_chain()
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
References: <20220628233512.439555-1-robdclark@gmail.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220628233512.439555-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.2022 01:35, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> drive-by cleanup
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_wait.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> index 319936f91ac5..667841780514 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> @@ -73,11 +73,6 @@ static void fence_set_priority(struct dma_fence *fence,
>   	rcu_read_unlock();
>   }
>   
> -static inline bool __dma_fence_is_chain(const struct dma_fence *fence)
> -{
> -	return fence->ops == &dma_fence_chain_ops;
> -}
> -
>   void i915_gem_fence_wait_priority(struct dma_fence *fence,
>   				  const struct i915_sched_attr *attr)
>   {
> @@ -93,7 +88,7 @@ void i915_gem_fence_wait_priority(struct dma_fence *fence,
>   
>   		for (i = 0; i < array->num_fences; i++)
>   			fence_set_priority(array->fences[i], attr);
> -	} else if (__dma_fence_is_chain(fence)) {
> +	} else if (dma_fence_is_chain(fence)) {
>   		struct dma_fence *iter;
>   
>   		/* The chain is ordered; if we boost the last, we boost all */

