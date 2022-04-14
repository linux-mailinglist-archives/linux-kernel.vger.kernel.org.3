Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD05017A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358536AbiDNPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347629AbiDNOwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:52:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094FBD7ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649947293; x=1681483293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/nmAQuF8uidNgq7HJ/eFp9m+rY8zxzb44tZes2w07Zo=;
  b=UpKBXCqJf9KBli+bRNFRD1zGSrTZFxES9EAiVQNqcA7GPGlhwUtsgLdY
   Gitj/aG1M7BIC/JVSzQrvUcgqUe8y325hyuol/9mVxVC9eSlezRWWxNWN
   NGl/w33m9ttIvaYh4cgJrtwvQURw0SmvT5jBTlcBjJpUZ6pr1tdmrIbVE
   WEn/90lX7qGOo/g/UwYjz9wgy0qAPRyZDfvZLpRSJDknt4Pp29sG4aIxc
   b5+5HIo51RpxjtvaEXYoL7RT5FT67uPsJWlIPnBL+w7MUPnOg+STwtv/e
   X74ZLJjtuEJyXT5jeAjgus9NLZB1m8pae9HPy9tMw5IX1+rK6qj30fHO5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="244828908"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="244828908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:41:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="725385705"
Received: from aviljane-mobl.ger.corp.intel.com (HELO [10.249.254.86]) ([10.249.254.86])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 07:41:25 -0700
Message-ID: <94ddf51a-90ae-dee8-5d6a-45ee2cd1e584@linux.intel.com>
Date:   Thu, 14 Apr 2022 16:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 5/5] drm/i915: stolen memory use ttm backend
Content-Language: en-US
To:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matthew Auld <matthew.auld@intel.com>, linux-kernel@vger.kernel.org
References: <20220412193817.2098308-1-bob.beckett@collabora.com>
 <20220412193817.2098308-6-bob.beckett@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20220412193817.2098308-6-bob.beckett@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/12/22 21:38, Robert Beckett wrote:
> +struct ttm_resource *
> +i915_gem_stolen_reserve_range(struct drm_i915_private *i915,
> +			      resource_size_t size,
> +			      u64 start, u64 end)
>   {
> -	int ret;
> +	struct intel_memory_region *mem = i915->mm.stolen_region;
>   
> -	if (!drm_mm_initialized(&i915->mm.stolen))
> -		return -ENODEV;
> -
> -	/* WaSkipStolenMemoryFirstPage:bdw+ */
> -	if (GRAPHICS_VER(i915) >= 8 && start < 4096)
> -		start = 4096;

Did we lose this Workaround?

Need to continue reviewing this patchnext week.


Thx,

Thomas




> -
> -	mutex_lock(&i915->mm.stolen_lock);
> -	ret = drm_mm_insert_node_in_range(&i915->mm.stolen, node,
> -					  size, alignment, 0,
> -					  start, end, DRM_MM_INSERT_BEST);
> -	mutex_unlock(&i915->mm.stolen_lock);
> +	if (!mem)
> +		return ERR_PTR(-ENODEV);
> +	return intel_region_ttm_resource_alloc(mem, size, start, end, I915_BO_ALLOC_CONTIGUOUS);
> +}
>   
> -	
