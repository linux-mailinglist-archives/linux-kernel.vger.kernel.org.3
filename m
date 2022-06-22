Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF598554619
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiFVKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiFVKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:45:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D92FE50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655894754; x=1687430754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EnIwRYdqMUiifM9lQEkNSaL0Jx7fpMpLKv6tMUllslk=;
  b=jsKkISoriF5cm1PVtrNG0mU0NkJTXh1FxsStM9Allo/rgEZd60Ex0Cw9
   +YwEp1ZerVvh7ZKTFbaL+jF20XUf9FSOzsJepYATn/aJqn2LR1upctPZF
   9ZabHaDcpP2VGIxNf+Iw0HzV7+kiZxenmzovGlDKAABktTVoaYe/39PPr
   DRrV5wKW4xjKuoRjIJucJcUzN4c7XSF2GmLup48VS0slSL3bz5veI7s0W
   uxbe3FD+SJt2SaxE6Tkf6UCj/krjXHxZPKW2rumQtOcXfi1YgO13QcrVW
   MPN6MmDZXNJ80SXbLd/XSSVAFwt5IxQKc1BKDmKk+Z6VT4PXG6vtgeoqn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="279151134"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="279151134"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:45:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690438517"
Received: from wterliko-mobl.ger.corp.intel.com (HELO [10.249.254.201]) ([10.249.254.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:45:52 -0700
Message-ID: <783ff8b6-0128-45e1-5705-7681f314db6c@linux.intel.com>
Date:   Wed, 22 Jun 2022 12:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 02/10] drm/i915: limit ttm to dma32 for i965G[M]
Content-Language: en-US
To:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Matthew Auld <matthew.auld@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220621200058.3536182-1-bob.beckett@collabora.com>
 <20220621200058.3536182-3-bob.beckett@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20220621200058.3536182-3-bob.beckett@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/22 22:00, Robert Beckett wrote:
> i965G[M] cannot relocate objects above 4GiB.
> Ensure ttm uses dma32 on these systems.
>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

LGTM.

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


> ---
>   drivers/gpu/drm/i915/intel_region_ttm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
> index 62ff77445b01..fd2ecfdd8fa1 100644
> --- a/drivers/gpu/drm/i915/intel_region_ttm.c
> +++ b/drivers/gpu/drm/i915/intel_region_ttm.c
> @@ -32,10 +32,15 @@
>   int intel_region_ttm_device_init(struct drm_i915_private *dev_priv)
>   {
>   	struct drm_device *drm = &dev_priv->drm;
> +	bool use_dma32 = false;
> +
> +	/* i965g[m] cannot relocate objects above 4GiB. */
> +	if (IS_I965GM(dev_priv) || IS_I965G(dev_priv))
> +		use_dma32 = true;
>   
>   	return ttm_device_init(&dev_priv->bdev, i915_ttm_driver(),
>   			       drm->dev, drm->anon_inode->i_mapping,
> -			       drm->vma_offset_manager, false, false);
> +			       drm->vma_offset_manager, false, use_dma32);
>   }
>   
>   /**
