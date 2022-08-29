Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6225A5280
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiH2RCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiH2RCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:02:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781B92F65
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661792563; x=1693328563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAPL+jgR6Yio7sKF58XFUKAJssDQneDwxtVvicnJzWk=;
  b=artJv8hEQj3U6TomjM5Q83mrv8+UyyE6b01r28G2aNBPq+Eo7Sjc1nz6
   Qqh7Snlj+bqbbGq2q6QjLpt6PKwHPaVmmIXv0SNCNK8qCAt9wmaZgEbDY
   wxpxPsA5LGFyqtathU34u39L5mhUs3WpXDZ2jexOtbcjtmpVd4wSAMVB5
   t/4dqd19vGV/RjfpnLftDIlC014vvkuMBulZv4lVgPYkp073hEhC3x4Jf
   7+Fuk7c5DSAqP8f9xW0CCbra6tRbBmB8IXs63yYx9Hq1TkwtE8hv7DRRM
   uXNx7WBNYckug+fNHx8cCvKcY4oJYJ2zzkTe9Ycr/ghPImKFmKviucsA7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="356665545"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="356665545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:02:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="714944601"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:02:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oSi9Z-005cAX-0P;
        Mon, 29 Aug 2022 20:02:25 +0300
Date:   Mon, 29 Aug 2022 20:02:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 4/4] lib/cpumask: add FORCE_NR_CPUS config option
Message-ID: <YwzxIJHLH40nWcNi@smile.fi.intel.com>
References: <20220829165748.1008477-1-yury.norov@gmail.com>
 <20220829165748.1008477-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829165748.1008477-5-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:57:48AM -0700, Yury Norov wrote:
> The size of cpumasks is hard-limited by compile-time parameter NR_CPUS,
> but defined at boot-time when kernel parses ACPI/DT tables, and stored in
> nr_cpu_ids. In many practical cases, number of CPUs for a target is known
> at compile time, and can be provided with NR_CPUS.
> 
> In that case, compiler may be instructed to rely on NR_CPUS as on actual
> number of CPUs, not an upper limit. It allows to optimize many cpumask
> routines and significantly shrink size of the kernel image.
> 
> This patch adds FORCE_NR_CPUS option to teach the compiler to rely on
> NR_CPUS and enable corresponding optimizations.
> 
> If FORCE_NR_CPUS=y, kernel will not set nr_cpu_ids at boot, but only check
> that the actual number of possible CPUs is equal to NR_CPUS, and WARN if
> that doesn't hold.
> 
> The new option is especially useful in embedded applications because
> kernel configurations are unique for each SoC, the number of CPUs is
> constant and known well, and memory limitations are typically harder.
> 
> For my 4-CPU ARM64 build with NR_CPUS=4, FORCE_NR_CPUS=y saves 46KB:
>   add/remove: 3/4 grow/shrink: 46/729 up/down: 652/-46952 (-46300)

...

> +       default n

Redundant. 'n' _is_ default.

-- 
With Best Regards,
Andy Shevchenko


