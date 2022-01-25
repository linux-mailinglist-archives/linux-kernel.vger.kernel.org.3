Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4548F49B058
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574338AbiAYJdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:33:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:10422 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1456409AbiAYJ27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643102939; x=1674638939;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/3uEJq4zPTSgXMeNYS74/NJZJxAc2UOZUhqwmZmqIfw=;
  b=BTGEaOqB1W/J8BzO+bDSEQhZ9eEotYEsiXr959Z4Y3GDonZuHhKreqO6
   RKkazeERMBnrziJ0G1rt6lJf2b1aMFI/4kTP0w8WwLVWfp4a49RIUrOhb
   7gTl7csQW0jxBYjtSqkvW4H4SxIUDgWxzr5ibfRu/UiH0//Fcx91qE0Ob
   ffgmcZ75+hM10VQFDGYGP5pwZAWRqyJwr79KSVqh5iF1XjOH9fo2xkOZW
   cnL82tTuTXLbEPsloXQKlbFW74IpY2onR/RwqkK911lHisAwMqYQDTVWM
   3eYK1jV2eQZ6mxFBc3GbswEY0xP3KQ0NJWE2tDMbTQE0GczJm9A3WX2Wh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246044824"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="246044824"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:28:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="532366265"
Received: from thpham-mobl1.amr.corp.intel.com (HELO [10.213.172.16]) ([10.213.172.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:28:51 -0800
Message-ID: <bab43c36-a3de-f96a-6530-4ab3a55b8ba0@linux.intel.com>
Date:   Tue, 25 Jan 2022 09:28:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 17/54] gpu: drm: replace cpumask_weight with cpumask_empty
 where appropriate
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-18-yury.norov@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220123183925.1052919-18-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/01/2022 18:38, Yury Norov wrote:
> i915_pmu_cpu_online() calls cpumask_weight() to check if any bit of a
> given cpumask is set. We can do it more efficiently with cpumask_empty()
> because cpumask_empty() stops traversing the cpumask as soon as it finds
> first set bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index ea655161793e..1894c876b31d 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -1048,7 +1048,7 @@ static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>   	GEM_BUG_ON(!pmu->base.event_init);
>   
>   	/* Select the first online CPU as a designated reader. */
> -	if (!cpumask_weight(&i915_pmu_cpumask))
> +	if (cpumask_empty(&i915_pmu_cpumask))
>   		cpumask_set_cpu(cpu, &i915_pmu_cpumask);
>   
>   	return 0;
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I see it's a large series which only partially appeared on our mailing 
lists. So for instance it hasn't got tested by our automated CI. (Not 
that I expect any problems in this patch.)

What are the plans in terms of which tree will it get merged through?

Regards,

Tvrtko
