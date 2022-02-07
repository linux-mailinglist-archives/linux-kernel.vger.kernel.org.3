Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C034AC848
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiBGSHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbiBGSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:05:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D4C0401E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644257104; x=1675793104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LUCSpHgmkTYHDcVbdREI9pkjDuWTx34JSR66QVMbHsE=;
  b=PW6IEatTSPud/qsQomn/leGqXCnBIJUemXk6qntOGJdfUXAkAjJUDMLH
   VfOh01HovSq0LCcXU1ZwEYpDmS4pxmtofAiY7EHA3unylX1hpHmNrDje+
   ozOphcz9PTw4hX47ycv5xcqy7o0GgsQSgHwVbnuEDvtRvxYSpKvDOMvCM
   Tp+Msj/AW8gLepoSoyszAQbToXapK+bNwmRDgq/tC46qhTMMAGvCvVb1O
   eJCORXEJMu0kC1ycLd/fnpyR0zK0c3IhAFX+guweI/jrXIAH9s8N9Lv23
   jU0hmsZyilPg8Xfk00IOny4xeuQ7gBfHxHx4ecDnhdeqmzQ0a0IiTX+qY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248984194"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="248984194"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:05:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="600969462"
Received: from jons-linux-dev-box.fm.intel.com (HELO jons-linux-dev-box) ([10.1.27.20])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:05:03 -0800
Date:   Mon, 7 Feb 2022 09:59:07 -0800
From:   Matthew Brost <matthew.brost@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        John Harrison <John.C.Harrison@Intel.com>
Subject: Re: [kbuild] drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2376
 eb_pin_timeline() warn: inconsistent returns '&tl->mutex'.
Message-ID: <20220207175907.GA8452@jons-linux-dev-box>
References: <202202072340.xZpz7hAb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202072340.xZpz7hAb-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:59:48PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   dfd42facf1e4ada021b939b4e19c935dcdd55566
> commit: 544460c33821b44c2f0c643121303c3dc3f66ef1 drm/i915: Multi-BB execbuf
> config: i386-randconfig-m021-20220207 (https://download.01.org/0day-ci/archive/20220207/202202072340.xZpz7hAb-lkp@intel.com/config )
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate

This is fixed by the below patch:
https://patchwork.freedesktop.org/patch/msgid/20220111163929.14017-1-matthew.brost@intel.com

Matt

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2376 eb_pin_timeline() warn: inconsistent returns '&tl->mutex'.
> 
> vim +2376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> 
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2333  static int eb_pin_timeline(struct i915_execbuffer *eb, struct intel_context *ce,
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2334  			   bool throttle)
> 8f2a1057d6ec21 drivers/gpu/drm/i915/i915_gem_execbuffer.c     Chris Wilson      2019-04-25  2335  {
> e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2336  	struct intel_timeline *tl;
> 2bf541ff6d06f4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Maarten Lankhorst 2020-08-19  2337  	struct i915_request *rq = NULL;
> 8f2a1057d6ec21 drivers/gpu/drm/i915/i915_gem_execbuffer.c     Chris Wilson      2019-04-25  2338  
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2339  	/*
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2340  	 * Take a local wakeref for preparing to dispatch the execbuf as
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2341  	 * we expect to access the hardware fairly frequently in the
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2342  	 * process, and require the engine to be kept awake between accesses.
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2343  	 * Upon dispatch, we acquire another prolonged wakeref that we hold
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2344  	 * until the timeline is idle, which in turn releases the wakeref
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2345  	 * taken on the engine, and the parent device.
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2346  	 */
> e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2347  	tl = intel_context_timeline_lock(ce);
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2348  	if (IS_ERR(tl))
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2349  		return PTR_ERR(tl);
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2350  
> a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2351  	intel_context_enter(ce);
> 2bf541ff6d06f4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Maarten Lankhorst 2020-08-19  2352  	if (throttle)
> 2bf541ff6d06f4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Maarten Lankhorst 2020-08-19  2353  		rq = eb_throttle(eb, ce);
> e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2354  	intel_context_timeline_unlock(tl);
> e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2355  
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2356  	if (rq) {
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2357  		bool nonblock = eb->file->filp->f_flags & O_NONBLOCK;
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2358  		long timeout = nonblock ? 0 : MAX_SCHEDULE_TIMEOUT;
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2359  
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2360  		if (i915_request_wait(rq, I915_WAIT_INTERRUPTIBLE,
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2361  				      timeout) < 0) {
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2362  			i915_request_put(rq);
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2363  
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2364  			tl = intel_context_timeline_lock(ce);
> 
> This is mutex_lock_interruptible() so it can fail
> 
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2365  			intel_context_exit(ce);
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2366  			intel_context_timeline_unlock(tl);
> 
> Leading to an error pointer dereference.  Maybe that's why Smatch is
> complaining?  Hard to say.  Why are we calling mutex_lock if it's
> O_NONBLOCK code?
> 
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2367  
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2368  			if (nonblock)
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2369  				return -EWOULDBLOCK;
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2370  			else
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2371  				return -EINTR;
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2372  		}
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2373  		i915_request_put(rq);
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2374  	}
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2375  
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14 @2376  	return 0;
> 544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2377  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
> 
