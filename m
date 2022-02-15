Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88364B7891
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiBORPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:15:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbiBORPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:15:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554111ADDB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644945305; x=1676481305;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wYSE1d1KywOXWozIw3qtjar4Hm4wpZeg71RZfiDgbYU=;
  b=RGEXUDXgJueONHOG7YvUo6EonpSK2JgzL1X+32cq+3/scplEzUKwmQ3u
   6M9Hs0vpTohM/qm5Wo8ROKt50OXUwsFj02N2UzPf5q6smxK/A679Cjx1m
   74Q8S0Vw8SJFdYmL+QU5fdTCW/peX6NkL4WHjZohIcl5bIeWnoDbCz0Ik
   OH1MN+s14ioa6MdvIluR4w/etZxf56IsuUIO5z/D9272B117wWGPt3nKe
   8m+Vd6ZMRZFfTRI+85nU9H+WYHE2/8w6FoA15FppNm+psw8fQAsaf7q0S
   tTUCMVTuE6Iiqb8kWf5wUNgrFbiSoLOcZnIvkikJMLX4R/j+ng7ii/ora
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250141893"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250141893"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 09:14:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="544392412"
Received: from ylian16-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.20.230])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 09:14:52 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/1] drm/i915/selftests: Replace too verbose for-loop
 with simpler while
In-Reply-To: <20220215163213.54917-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220215163213.54917-1-andriy.shevchenko@linux.intel.com>
Date:   Tue, 15 Feb 2022 19:14:49 +0200
Message-ID: <87o83859x2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> It's hard to parse for-loop which has some magic calculations inside.
> Much cleaner to use while-loop directly.

I assume you're trying to prove a point following our recent
for-vs-while loop discussion. I really can't think of any other reason
you'd end up looking at this file or this loop.

With the change, the loop indeed becomes simpler, but it also runs one
iteration further than the original. Whoops.

It's a selftest. The loop's been there for five years. What are we
trying to achieve here? So we disagree on loops, fine. Perhaps this is
not the best use of either of our time? Please just let the for loops in
i915 be.


BR,
Jani.

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/selftests/i915_syncmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
> index 47f4ae18a1ef..26981d1c3025 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
> @@ -36,10 +36,10 @@ __sync_print(struct i915_syncmap *p,
>  	unsigned int i, X;
>  
>  	if (depth) {
> -		unsigned int d;
> +		unsigned int d = depth;
>  
> -		for (d = 0; d < depth - 1; d++) {
> -			if (last & BIT(depth - d - 1))
> +		while (d--) {
> +			if (last & BIT(d))
>  				len = scnprintf(buf, *sz, "|   ");
>  			else
>  				len = scnprintf(buf, *sz, "    ");

-- 
Jani Nikula, Intel Open Source Graphics Center
