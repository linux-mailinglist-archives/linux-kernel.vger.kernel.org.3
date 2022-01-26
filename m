Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913B049C6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiAZJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:44:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:60268 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231934AbiAZJn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643190236; x=1674726236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FqtfkDWNNeSe+gVQGRrv7zXdFjdNf4dd0UsnuMjMtq0=;
  b=AsDiqbkRW+/Neu2u0WsOiWEmytuZutr+6t8Za1la+g17HZmxkprC2zB2
   3/6awLt7BxYNdOvTf9tFCzqJzy9w89VySXXXQBYD5XDiVR/79RHRP/bKi
   H029dFRDhLnFBjHvN0BEwgRF/ER58GEJNnozJm1DWoW4MEu8sXXYOKPH8
   8QAW8zJdeERtiiTzrJu0HvA2gSPxOjCw/HCmy7q/KI5E5M5Bb+aTeliVj
   21Z8vdGgSIkdYIScdNPfQRHXKRAdT41k5e3l1fPKN8dBj3TX8OXl8SJwg
   IfmATwRpqn81pyxrPtctp8dli6HtHtmDwnjZfWqQXDH2+V+V0dP95J+TO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="245348614"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="245348614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 01:43:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="581055423"
Received: from mburchar-mobl.amr.corp.intel.com (HELO [10.212.54.252]) ([10.212.54.252])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 01:43:52 -0800
Message-ID: <e920081b-f590-7381-cf57-9f73fa846225@linux.intel.com>
Date:   Wed, 26 Jan 2022 09:43:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 17/54] gpu: drm: replace cpumask_weight with cpumask_empty
 where appropriate
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 <bab43c36-a3de-f96a-6530-4ab3a55b8ba0@linux.intel.com>
 <CAAH8bW8jcNM--D_cUtWNe7cbBjVAENq_SEapDcPjit=BB705JA@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAAH8bW8jcNM--D_cUtWNe7cbBjVAENq_SEapDcPjit=BB705JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2022 18:16, Yury Norov wrote:
> On Tue, Jan 25, 2022 at 1:28 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> On 23/01/2022 18:38, Yury Norov wrote:
>>> i915_pmu_cpu_online() calls cpumask_weight() to check if any bit of a
>>> given cpumask is set. We can do it more efficiently with cpumask_empty()
>>> because cpumask_empty() stops traversing the cpumask as soon as it finds
>>> first set bit, while cpumask_weight() counts all bits unconditionally.
>>>
>>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>>> ---
>>>    drivers/gpu/drm/i915/i915_pmu.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
>>> index ea655161793e..1894c876b31d 100644
>>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>>> @@ -1048,7 +1048,7 @@ static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>>>        GEM_BUG_ON(!pmu->base.event_init);
>>>
>>>        /* Select the first online CPU as a designated reader. */
>>> -     if (!cpumask_weight(&i915_pmu_cpumask))
>>> +     if (cpumask_empty(&i915_pmu_cpumask))
>>>                cpumask_set_cpu(cpu, &i915_pmu_cpumask);
>>>
>>>        return 0;
>>>
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> I see it's a large series which only partially appeared on our mailing
>> lists.
> 
> The series is here: https://lkml.org/lkml/2022/1/23/223
> The branch: https://github.com/norov/linux/tree/bitmap-20220123
> 
>> So for instance it hasn't got tested by our automated CI. (Not
>> that I expect any problems in this patch.)
> 
> Would be great if you give a test for the whole series, thanks!

Can't really test the whole series for you, but if you want to send just 
the i915 patch standalone to the intel-gfx mailing list, that would 
trigger the CI run and if that passes we can merge that single one.

>> What are the plans in terms of which tree will it get merged through?
> 
> For the patches that will not be merged by maintainers of corresponding
> subsystems, I'll use my bitmap branch and send it to linux-next.

Or I guess we can wait for them to trickle back to us this way.

Regards,

Tvrtko
