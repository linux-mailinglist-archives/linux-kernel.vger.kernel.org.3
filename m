Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7FE4E7273
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357309AbiCYLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiCYLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:54:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439CED444D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648209177; x=1679745177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I9fdKjDe7c5xOBuEv/szPzFWHRVEWEDrHDMgVrhEe+M=;
  b=IJ8LXtcVmaYjwRPaa9ljoQAWzSYQ7GBuURHaVJ38521TkxYRQPqOlYnA
   zwpWaTR4ejFPX/XeGpbaLCmiPRnCLcr6SnlEHbdmNET2h3a3cQZ5sa+nI
   98VkXKqLxQPRhubAIxoiJMnH3st/85RKZosEuNmoKgKNwkehazsNPLeBO
   fGjGBZnJqIZBQExIPs2ksf51wv5xTMom4dUoediBlC7u+ayeLESp0tzr2
   HfivHIz7qAlYFTMsPdMJjLuPWeovs2x+Eb6roam+5inE1dM5/se+Xf1uT
   bIOuS5WGKxRQL9yrUq/c0Z3h6+8KBrdxTWfQ5JKyUV8uNPziwlCnD0EWk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="258584529"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="258584529"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:52:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718185018"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:52:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nXiUL-006MZ1-Ri;
        Fri, 25 Mar 2022 13:52:17 +0200
Date:   Fri, 25 Mar 2022 13:52:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
Message-ID: <Yj2s8WZ4Pv1QuckE@smile.fi.intel.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic>
 <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com>
 <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:47:27AM -0700, Nathan Chancellor wrote:
> On Thu, Mar 24, 2022 at 09:31:13AM +0100, Ingo Molnar wrote:

> > --- a/arch/x86/configs/i386_defconfig
> > +++ b/arch/x86/configs/i386_defconfig

> > -# CONFIG_64BIT is not set
> 
> I don't think this is right, this is repeating the problem that was
> fixed by commit 76366050eb1b ("x86/defconfigs: Explicitly unset
> CONFIG_64BIT in i386_defconfig").
> 
> $ make ARCH=i386 savedefconfig
> 
> ?

+1 here, there are still branches in use that have i386 defconfig as
as base and making this problem again is not okay.

-- 
With Best Regards,
Andy Shevchenko


