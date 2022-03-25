Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7C4E7B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiCYT0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiCYT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:26:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A473E635C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648234706; x=1679770706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ST07gu5uVi9Q0WMMaJSNfrCmn5RgIPW07ex0MrMvoDs=;
  b=EWjvI+VyUI7XOLakPHp02yVJTNmhgK9Wr+tFKYbFnLKNEs/MmHXxMQ8M
   PECq5d+/9k/fuvWTsFVFAT+uJFIoZ/ytFnw2SvS47nS7BTiYyaTtZEND8
   SRwahG9UHsIH4BbeNQW3vUhCq9GabBi9+mKwJc2hECE6rOOkurcooqLTS
   0ctOsjiPTkyIViVbkg3BlhGLCOTrbe6HqU/aV8zAoIV5aSldDYf+JUBHY
   iYt207v3of+ftPBz8N6AD+Hb+lKU46ep1HWkkg0zykjOrnn0g2lCu9EN6
   Z+7eO47a1x5SpP/23EiF+DBKyg/sKBYZHVBLcyPjPj3MqCyr0RqmYT/Kq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258402482"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258402482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 10:53:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="617202377"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 10:53:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nXo7i-006WiB-KH;
        Fri, 25 Mar 2022 19:53:18 +0200
Date:   Fri, 25 Mar 2022 19:53:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <Yj4BjjCFGMjhzKk+@smile.fi.intel.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <Yj2qZT6gdRYpkSIR@smile.fi.intel.com>
 <CAHk-=wgaxDHAhxBkU_mVE5uw5po+qvzy4jgK8Q82rgi7XqZfiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaxDHAhxBkU_mVE5uw5po+qvzy4jgK8Q82rgi7XqZfiA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:29:21AM -0700, Linus Torvalds wrote:
> On Fri, Mar 25, 2022 at 4:42 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > What about old one? I have already complained in the early discussion that
> > `make W=1 ...` is broken by this change.
> 
> So that is REALLY D*MN EASY TO FIX.
> 
> If you use W=1, and don't want WERROR, then don't *do* that then.
> 
> End of story.
> 
> But that's on _you_. Not on the build system. If you use W=1 and
> WERROR together, you get exactly what you asked for. It might even be
> what you wanted, if you want to go through the warnings/errors as you
> encounter them, instead of building everything.
> 
> And that's why I refuse to take the completely broken "strip out one
> or the other automatically" change.
> 
> It's a perfectly valid combination to enable both.
> 
> But more importantly, -Werror is more important than W=1. So if
> anything should be disabled, it's W=1.
> 
> Side note: that would be trivial to just have in the Kconfig files if
> W=1 was just a config option.
> 
> Do something like
> 
>      config EXTRA_ERRORS
>          int "Add extra compiler errors" if EXPERT
>          depends on !WERROR
>          range 0-2
>          default 0
> 
> but note again: WERROR should be the thing that controls this and
> should be on by default, not the other way around.
> 
> If you want EXTRA_ERRORS, you should not only be CONFIG_EXPERT, you
> should also have to manually disable WERROR that *normal* people
> should have on by default.

I have got your point, thanks!

-- 
With Best Regards,
Andy Shevchenko


