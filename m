Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0A554996
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbiFVKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiFVKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:50:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B83BA75
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655895009; x=1687431009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+q3LyYRSG8Prlp1Z2KGKSmSZST1o9tVZI3vEN0EE3rk=;
  b=Ngyd+7SERj6l/66cTa98Af0KVSSGIlJaHEbrYBAnukz82OeaHJ7at7J5
   t+5bpS5aQjJ8v/jmvYGDE0MoxP9YXmSlgpilvYKmsFa1UwIkksp0aAby1
   1je5OTgSrpa9M2fOdOaA2g/AZ4AuPFmZrBdEvzZ8Q/uAuP3axuKX5Fqi8
   DYoaSrhGa47d9rsEbfyWU6g1DQHr4dUcZnihlyq5GuDnJU6wr92fvwGc6
   4N7HshlV48VYozbtVdsY7Ksc19cUEvZOs5a64r+qOUI9LAfn4JyIT2zoo
   zZeWCx7jqxySN8XOZvaXl6A6249/V2d0UANr0USXu+kBI9qpj4we6ZUQZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269103710"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="269103710"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:50:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="690440303"
Received: from wterliko-mobl.ger.corp.intel.com (HELO [10.249.254.201]) ([10.249.254.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:50:06 -0700
Message-ID: <453f12ce-e982-0d53-37e4-7e72f1538838@linux.intel.com>
Date:   Wed, 22 Jun 2022 12:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 03/10] drm/i915/ttm: only trust snooping for dgfx when
 deciding default cache_level
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
 <20220621200058.3536182-4-bob.beckett@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20220621200058.3536182-4-bob.beckett@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/22 22:00, Robert Beckett wrote:
> By default i915_ttm_cache_level() decides I915_CACHE_LLC if HAS_SNOOP.
> This is divergent from existing backends code which only considers
> HAS_LLC.
> Testing shows that trusting snooping on gen5- is unreliable and bsw via
> ggtt mappings, so limit DGFX for now and maintain previous behaviour.
Yeah, IIRC Matthew mentioned that HAS_SNOOP() can be overridden in 
various ways, but not on DGFX, (at least not for DG1). So this looks 
correct to me.
>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


> ---
>   drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> index 4c1de0b4a10f..40249fa28a7a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> @@ -46,7 +46,9 @@ static enum i915_cache_level
>   i915_ttm_cache_level(struct drm_i915_private *i915, struct ttm_resource *res,
>   		     struct ttm_tt *ttm)
>   {
> -	return ((HAS_LLC(i915) || HAS_SNOOP(i915)) &&
> +	bool can_snoop = HAS_SNOOP(i915) && IS_DGFX(i915);
> +
> +	return ((HAS_LLC(i915) || can_snoop) &&
>   		!i915_ttm_gtt_binds_lmem(res) &&
>   		ttm->caching == ttm_cached) ? I915_CACHE_LLC :
>   		I915_CACHE_NONE;
