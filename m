Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A484B8389
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiBPIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:55:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiBPIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:55:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA22A159EB5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645001726; x=1676537726;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vT07H/KR5z14mAxdyha9EhAw5XBO5ie4tmnFoY3of4I=;
  b=BRmgugQC2zTZ25K4mc72Dm3B4CwILWm4hFym2ZDoMbR6jYfHjvrSt9WY
   Sjm+9uPhRtLm15jFKgEmmdJWB4Thr5NI7RP5FRJtmKtv1dr0H/cxvUIIK
   VKOLfDuyN44wutvb6xBlkzFYDVjDdSXxBFy9NIAAFyqpFi+L2fIbtDsNx
   O1FRq8wH7rdfYbGrlyQkPKywhLxBGZb+plznXOuMexpdZHmnfelC2v4gV
   8VG3R3xL2hg39fZGTLYk9P9EKsjMk/PPWVWr9VQWkc1ztYKyMYbsgH5D6
   TBCQ9j8bVAe0Ce16+2SKRQmYLEwzf80UFi/VZ70qC25vcs5c8dsKMAGtW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231182238"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="231182238"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:55:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="529345731"
Received: from rbilei-mobl.ger.corp.intel.com (HELO localhost) ([10.252.13.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:55:16 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <Ygv32CptVknidyP3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220215163213.54917-1-andriy.shevchenko@linux.intel.com>
 <87o83859x2.fsf@intel.com> <Ygv32CptVknidyP3@smile.fi.intel.com>
Date:   Wed, 16 Feb 2022 10:55:11 +0200
Message-ID: <87leyb5gy8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Feb 15, 2022 at 07:14:49PM +0200, Jani Nikula wrote:
>> On Tue, 15 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > It's hard to parse for-loop which has some magic calculations inside.
>> > Much cleaner to use while-loop directly.
>> 
>> I assume you're trying to prove a point following our recent
>> for-vs-while loop discussion. I really can't think of any other reason
>> you'd end up looking at this file or this loop.
>> 
>> With the change, the loop indeed becomes simpler, but it also runs one
>> iteration further than the original. Whoops.
>
> Yeah, sorry for that, the initial condition should be d = depth - 1,
> of course.

Well, no, the condition should be while (--i) instead to also match the
values the original loop takes. ;D

Cheers,
Jani.


>
>> It's a selftest. The loop's been there for five years. What are we
>> trying to achieve here? So we disagree on loops, fine. Perhaps this is
>> not the best use of either of our time? Please just let the for loops in
>> i915 be.
>
> Yes, I'm pretty much was sure that no-one will go and apply this anyway
> (so I haven't paid too much attention), but to prove my point in the
> certain discussion.
>
> And yes, the point is for the new code, I'm not going to change existing
> suboptimal and too hard to read for-loops, it will consume my time later
> when I will try to understand the code.

-- 
Jani Nikula, Intel Open Source Graphics Center
