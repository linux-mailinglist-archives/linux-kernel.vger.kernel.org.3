Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948AC523348
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbiEKMnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiEKMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:42:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E03F89A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652272976; x=1683808976;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GFhebHzBmdSTAm8X/ZQTSJF1RxXHbmrgrGWBEpfUvdY=;
  b=bwqZDJMDCIidXiSPLgz5K81TMo0TumujtP6zkCsD6Hu3Z54zFt7Scx9q
   VmvMRxHM0iiaGHUFJ7IxLW42a9rC8pRVbr/VWnhuD2seFHuWRvvOY4qXN
   JFXfj3Oq1Sy09Zz2z1SEl3NM55NGXMwTkUh+MvvrsC2L+P7pHNTRqSEcO
   GxUkuTi4IlRCn+tAik1Tko/QNPG0ARFlCKYW3MtdtAnkrHhe33PRa34QC
   nzMrzErEmdal/zLc8SZ8hTDgITuhFt0HNcVzVGC6Bkutovkt4sNW/1nEk
   ruDpacG/A4vN66Drd80x9exdzzD2/QSyhW+e9L0zQ47/697HA4HtvXfd1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="257230095"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="257230095"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 05:42:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="739204285"
Received: from mstribae-mobl1.ger.corp.intel.com (HELO [10.249.254.135]) ([10.249.254.135])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 05:42:53 -0700
Message-ID: <3ce81c514959e43f5afd7e74489dd5b89b1cd633.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] drm/i915: allow volatile buffers to use ttm pool
 allocator
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matthew Auld <matthew.auld@intel.com>, linux-kernel@vger.kernel.org
Date:   Wed, 11 May 2022 14:42:51 +0200
In-Reply-To: <20220503191316.1145124-4-bob.beckett@collabora.com>
References: <20220503191316.1145124-1-bob.beckett@collabora.com>
         <20220503191316.1145124-4-bob.beckett@collabora.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bob,

On Tue, 2022-05-03 at 19:13 +0000, Robert Beckett wrote:
> internal buffers should be shmem backed.
> if a volatile buffer is requested, allow ttm to use the pool
> allocator
> to provide volatile pages as backing
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 4c25d9b2f138..fdb3a1c18cb6 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -309,7 +309,8 @@ static struct ttm_tt *i915_ttm_tt_create(struct
> ttm_buffer_object *bo,
>                 page_flags |= TTM_TT_FLAG_ZERO_ALLOC;
>  
>         caching = i915_ttm_select_tt_caching(obj);
> -       if (i915_gem_object_is_shrinkable(obj) && caching ==
> ttm_cached) {
> +       if (i915_gem_object_is_shrinkable(obj) && caching ==
> ttm_cached &&
> +           !i915_gem_object_is_volatile(obj)) {
>                 page_flags |= TTM_TT_FLAG_EXTERNAL |
>                               TTM_TT_FLAG_EXTERNAL_MAPPABLE;
>                 i915_tt->is_shmem = true;

While this is ok, I think it also needs adjustment in the i915_ttm
shrink callback. If someone creates a volatile smem object which then
hits the shrinker, I think we might hit asserts that it's a is_shem
ttm?

In this case, the shrink callback should just i915_ttm_purge().

/Thomas


