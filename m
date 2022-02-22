Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC09C4BFE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiBVQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiBVQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:28:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA32F15F08C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645547309; x=1677083309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yOy9wKhpTzMIgiJVor0t6E5cNveJwZO+KgH0Mq7wBMU=;
  b=j5CfSqnxFz2SIrQNNajOSp2MykmwJSTEDF7QuAdfF/wJsjMhCfbrM/Zr
   Eu1x5BMZ0H1Y3lHC0o9dG+pxVmpTS6xuq6Z4g5+fp23uaQaO44ed/fw65
   4X9fYpnD8ynCB8WB8ENWv1qKte8XDPn53IGAnOJcAaVGUuXCvD7y0ih3t
   7bb6hkpdJfJD0CmXLsxA0oZHjaWw+le5Pj91DmNt8yRLbjXO7QSNL29vY
   /lztWGhb4YIQ0kyQKH5XF/2UFwz5OagD7L/NjPezuUm/Dd/xf4iTrXeRW
   AW8HeYYJinLBQ3YkKNMNchxwLr3bk3iiZNmKzgIdz33uT+rRxIurxE2Tr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="314980015"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="314980015"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 08:28:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="508050505"
Received: from sjgillin-mobl.ger.corp.intel.com (HELO [10.213.218.63]) ([10.213.218.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 08:28:26 -0800
Message-ID: <2b3dd219-7540-6982-15d2-375255921de6@linux.intel.com>
Date:   Tue, 22 Feb 2022 16:28:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/i915: Check input parameter for NULL
Content-Language: en-US
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch,
        thomas.hellstrom@linux.intel.com,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        matthew.d.roper@intel.com, tzimmermann@suse.de,
        michal.winiarski@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1645541161-46607-1-git-send-email-lyz_cs@pku.edu.cn>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <1645541161-46607-1-git-send-email-lyz_cs@pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 22/02/2022 14:46, Yongzhi Liu wrote:
> [why]
> i915_gem_object_put_pages_phys() frees pages and standard
> pattern is to allow caller to not care if it's
> NULL or not. This will reduce burden on
> the callers to perform this check.

I don't think we want this in general, and definitely not just for phys 
objects and leaving others not handle NULL.

See comment at the call site for these vfuncs:

	/*
	 * XXX Temporary hijinx to avoid updating all backends to handle
	 * NULL pages. In the future, when we have more asynchronous
	 * get_pages backends we should be better able to handle the
	 * cancellation of the async task in a more uniform manner.
	 */
	if (!IS_ERR_OR_NULL(pages))
		obj->ops->put_pages(obj, pages);

Maarten owns this area these days so he can comment as well.

Regards,

Tvrtko

> [how]
> Fix it by adding Null check.
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_phys.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> index ca6faff..09c3dcb 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> @@ -95,8 +95,13 @@ void
>   i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
>   			       struct sg_table *pages)
>   {
> -	dma_addr_t dma = sg_dma_address(pages->sgl);
> -	void *vaddr = sg_page(pages->sgl);
> +	dma_addr_t dma;
> +	void *vaddr;
> +
> +	if (!pages)
> +		return;
> +	dma = sg_dma_address(pages->sgl);
> +	vaddr = sg_page(pages->sgl);
>   
>   	__i915_gem_object_release_shmem(obj, pages, false);
>   
