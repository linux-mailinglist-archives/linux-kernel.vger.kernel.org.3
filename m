Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9D4D2C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiCIJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiCIJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:49:56 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FF1070A6;
        Wed,  9 Mar 2022 01:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646819338; x=1678355338;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=skqK4ekP+jaJdGJ2Qw2JrG7jPV40g1I3Zcdcj+wxnO4=;
  b=WNLJXFduBlBzfN66tKCkxZmT+AS+F9jXc8G9RvdOn8Foeed7Zp1+wdKk
   qLWUxT6zeld6flFNmNtdr1Z6nw6pv3I1DVmf3UniYjWYo4zc/ov9Jbz+M
   ZRQw6ydvHcLf6gChn30rsPBlZv/5Rda9rB1EggJg3k/5smN4XWEhdOC6+
   HStcrIJDvQCTwrvLFkm5N8iJaWRrLuHqALAjfRjUZT3QA1YywiIin8Mcj
   zUJE098pCrx3+q5k2lsc03snW/OCkoIJeJ1AEIwhJpNYuVmikbZD9y4y1
   6uyPR4zciQTLTqJM8X753rAWjS8NfZSXLyl/AnzkNzWhVmCo9/t4lmn0P
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="315652068"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="315652068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:48:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="537942978"
Received: from byrnec1x-mobl.ger.corp.intel.com (HELO localhost) ([10.252.29.235])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:48:54 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dpll: make read-only array div1_vals static const
In-Reply-To: <20220307220007.162830-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220307220007.162830-1-colin.i.king@gmail.com>
Date:   Wed, 09 Mar 2022 11:48:52 +0200
Message-ID: <87sfrrzcaj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022, Colin Ian King <colin.i.king@gmail.com> wrote:
> Don't populate the read-only array div1_vals on the stack but
> instead make it static const. Also makes the object code a little
> smaller.

Thanks, but this was just fixed in commit fe70b262e781 ("drm/i915: Move
a bunch of stuff into rodata from the stack").

BR,
Jani.

>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> index 569903d47aea..17668b58b30c 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> @@ -2759,7 +2759,7 @@ static bool icl_mg_pll_find_divisors(int clock_khz, bool is_dp, bool use_ssc,
>  				     bool is_dkl)
>  {
>  	u32 dco_min_freq, dco_max_freq;
> -	int div1_vals[] = {7, 5, 3, 2};
> +	static const int div1_vals[] = {7, 5, 3, 2};
>  	unsigned int i;
>  	int div2;

-- 
Jani Nikula, Intel Open Source Graphics Center
