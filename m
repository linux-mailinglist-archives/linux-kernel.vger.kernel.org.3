Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B2A4B77B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiBOS7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:59:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiBOS7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:59:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674DCEB33E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644951571; x=1676487571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=whwP9Db5MNSBKpAGicysWN+UADdsEBzGUgWDC7WFI5w=;
  b=ibYfSP6BU852w/cFUfsBn/ugJp2Y3gA2qvc1Z20Zi5JUexhdy3sUFwX4
   GTK8/Dqtq0tEfA0YuVFrSnz4XPq8YpXLp7V0+vn2atA9xjjrXrZUKaMAX
   3RsfmNmH8TsLxJGw4D8yF1h0dNaoeYJNNx7kOwUh9kWEOnEiqNN9ZggGq
   MGnGa16Pg9kSXNDApljTIrWndAIwRm76lW6KdG6GfUcV4Lk9oLYTTGIfH
   X52tZfE3t8SqO2pcYpYNyKugWm21TZrUE9IUAzevvTN6X86bCm+CQuGxW
   1147xC9wVyaNCAry3W5abVKS07+1K/ECA0dWzZ1Q3Bk9ELcJsBwBPv+Pa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230392431"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230392431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:59:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="636072634"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 10:59:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nK320-0051ub-M8;
        Tue, 15 Feb 2022 20:58:32 +0200
Date:   Tue, 15 Feb 2022 20:58:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/1] drm/i915/selftests: Replace too verbose for-loop
 with simpler while
Message-ID: <Ygv32CptVknidyP3@smile.fi.intel.com>
References: <20220215163213.54917-1-andriy.shevchenko@linux.intel.com>
 <87o83859x2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o83859x2.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 07:14:49PM +0200, Jani Nikula wrote:
> On Tue, 15 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > It's hard to parse for-loop which has some magic calculations inside.
> > Much cleaner to use while-loop directly.
> 
> I assume you're trying to prove a point following our recent
> for-vs-while loop discussion. I really can't think of any other reason
> you'd end up looking at this file or this loop.
> 
> With the change, the loop indeed becomes simpler, but it also runs one
> iteration further than the original. Whoops.

Yeah, sorry for that, the initial condition should be d = depth - 1,
of course.

> It's a selftest. The loop's been there for five years. What are we
> trying to achieve here? So we disagree on loops, fine. Perhaps this is
> not the best use of either of our time? Please just let the for loops in
> i915 be.

Yes, I'm pretty much was sure that no-one will go and apply this anyway
(so I haven't paid too much attention), but to prove my point in the
certain discussion.

And yes, the point is for the new code, I'm not going to change existing
suboptimal and too hard to read for-loops, it will consume my time later
when I will try to understand the code.

-- 
With Best Regards,
Andy Shevchenko


