Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099104DCDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiCQSkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiCQSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:40:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F62128DD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647542335; x=1679078335;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=DJR+wvnHR5rivdMFlGEb+X104rJMQMUf5HMSzvneSh0=;
  b=ldog9jI5RhVhIuDODOxQVfXrX9CRB9LsU8g0f+Zl9oJA8/sWV0zOBjPA
   NYIh/Uuogi79BYG/wCcjlAvhN9pVjeZGtbZjfJZ+W9qyTzPMS5wK7+jh8
   JzAZ4P7Y8FDMX4Q63lB+FxbkxcDpwuz1pmEipmoGh3m/S0ogbudmErk1R
   B8KWTtuonn7Pp7iu1L8eUvAvuLX/1wflnC6jdCSDSFdIGbvNOAZOKwT5M
   LttcnLTV2fy9cTyVUEokEd7O/itb55319W/m1O5+siBxa6FCei4ZY3ab2
   AoL/p/hxxBVR7lti8Xjfc0dI8HmX83dXx8BVi6doxNaJHW+qH7+NgL4QI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236896176"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236896176"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:38:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581400848"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:38:54 -0700
Message-ID: <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
Date:   Thu, 17 Mar 2022 11:38:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
References: <20220317090415.GE735@xsang-OptiPlex-9020>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
In-Reply-To: <20220317090415.GE735@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 02:04, kernel test robot wrote:
> FYI, we noticed a -13.2% regression of will-it-scale.per_thread_ops due to commit:
...
> commit: 6035152d8eebe16a5bb60398d3e05dc7799067b0 ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
...
>      24.77 ±  2%      +8.1       32.86 ±  3%  perf-profile.self.cycles-pp.llist_add_batch


tl;dr: This commit made the tlb_is_not_lazy() check happen earlier.
That earlier check can miss threads _going_ lazy because if mmap_lock
contention.  Fewer lazy threads means more IPIs and lower performance.

===

There's a lot of noise in that profile, but I filtered most of it out.
The main thing is that, somehow the llist_add() in
smp_call_function_many_cond() got more expensive.  Either we're doing
more of them or the cacheline is bouncing around more.

Turns out that we're sending *more* IPIs with this patch applied than
without.  That shouldn't happen since the old code did the same exact
logical check:

	if (cond_func && !cond_func(cpu, info))
        	continue;

and the new code does:

	if (tlb_is_not_lazy(cpu))
		...

where cond_func==tlb_is_not_lazy.

So, what's the difference?  Timing.  With the old scheme, if a CPU
enters lazy mode between native_flush_tlb_others() and
the loop in smp_call_function_many_cond(), it won't get an IPI and won't
need to do the llist_add().

I stuck some printk()s in there and can confirm that the
earlier-calculated mask always seems to have more bits set, at least
when running will-it-scale tests that induce TLB flush IPIs.

I was kinda surprised that there were so many threads going idle with a
cpu-eating micro like this.  But, it makes sense since they're
contending on mmap_lock.  Basically, since TLB-flushing operations like
mmap() hold mmap_lock for write they tend to *force* other threads into
idle.  Idle threads are lazy and they tend to _become_ lazy around the
time that the flushing starts.

This new "early lazy check" behavior could theoretically work both ways.
 If threads tended to be waking up from idle when TLB flushes were being
sent, this would tend to reduce the number of IPIs.  But, since they
tend to be going to sleep it increases the number of IPIs.

Anybody have a better theory?  I think we should probably revert the commit.
