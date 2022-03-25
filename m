Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F94E73EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359243AbiCYNI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345586AbiCYNIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:08:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF41C627B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648213612; x=1679749612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L8We6eVZdTbGQo8vbwQx+Aqb89EgG0yv9xaBvTQeVeg=;
  b=d88QWL4LDooOsEcA2ypZcbfucxLoMbedLfsEnjE4ugml9m7GHx5SExd/
   6We7+86tW0db9T9X+aUaT+oiYGYquMnqqq+9Mec6onOvIOmiy7LW0FvHK
   WN6sAAv0rbDG3hpdwosB+5Nb+YRviRgfz5ql5USF1gst/iPWv/4yYpuNF
   IuJqoxc/kcb2SVQfhIrqWDcyw5k/RVtdgY9fcKr0TG3g5dEzjkMacpBGJ
   GVmNaZrR0ZivSkdtEXBVfQRkZYDlLytfchVRcNyh1/98qGKJpDKemFY8L
   xCEVEAsIDnWVODIAESOg7owgU8pKSIMDfvZLkp2cowtxo7CFbWcbVFUUl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321823006"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="321823006"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:06:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="516539487"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:06:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nXjds-006PMQ-K0;
        Fri, 25 Mar 2022 15:06:12 +0200
Date:   Fri, 25 Mar 2022 15:06:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <Yj2+RDmBGHto4+e/@smile.fi.intel.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <Yj2qZT6gdRYpkSIR@smile.fi.intel.com>
 <20220325122336.GQ8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325122336.GQ8939@worktop.programming.kicks-ass.net>
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

On Fri, Mar 25, 2022 at 01:23:36PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 25, 2022 at 01:41:25PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 22, 2022 at 03:58:47PM -0700, Linus Torvalds wrote:
> > > On Tue, Mar 22, 2022 at 3:20 PM Borislav Petkov <bp@alien8.de> wrote:
> > > >
> > > > Ah, you say build error because you have CONFIG_WERROR=y.
> > > 
> > > EVERYBODY should have CONFIG_WERROR=y on at least x86-64 and other
> > > serious architectures, unless you have some completely random
> > > experimental (and broken) compiler.
> > > 
> > > New compiler warnings are not acceptable.
> > 
> > What about old one? I have already complained in the early discussion that
> > `make W=1 ...` is broken by this change. Enabling it without fixing
> > _existing_ warnings on W=1 is not suitable for somebody. Now, I have to
> > modify my configs to disable WERROR because of inability to built at all.
> > 
> > (Yes, I understand that I may drop W=1, but that's not the point. since I
> >  want to have clean builds of a new code on level 1 of warnings)
> 
> It would be fairly easy to make scripts/Makefile.extrawarn strip out
> -Werror when W= is used.

Hmm... I can't achieve this, because it complains about recursive variable.
What helped me is to supply in such case -Wno-error which seems overrode
the previous setting.

I'll send a patch to discuss further if needed.

-- 
With Best Regards,
Andy Shevchenko


