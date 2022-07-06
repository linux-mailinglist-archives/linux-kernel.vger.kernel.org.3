Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D4568B27
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiGFOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiGFOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:25:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E60320F75
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657117549; x=1688653549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ekAnkxlyo5a77ZXv/WDjstgTFIs6FVRj0ddynjjv0EY=;
  b=bY50CIYts4ouFEvqT4pHIc+julpwyp5PBOAKv020IQ2GIgTNPipbWOPw
   Rg3O3jahh4yDyXGHW2LVu96NU3z2jp8+LR8h1QF9NAux0pPTnAlzxntM6
   9Mx+biMDYHGVvWIDOaMtGgeA93g/yKDyXsEAFwIq+MQG/8lbMvKJQty76
   8tgWwbMtkBV5rPESn+f5O/MFWyASJw2hN0FpyScy+BNOXqE3f9VWhjaaF
   lO7o8ZcVu9eZ7ePvJP/C4bEfqq2c9ylrJa6emZorZqKM9t7S8fhgVVPsa
   qDizqWwwZW9e/A+Zv3+o+E9WNpQkfxRMjI0/EIeG8isMjaKwPxD19ukGx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284881295"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="284881295"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 07:25:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="568086315"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 07:25:33 -0700
Date:   Wed, 6 Jul 2022 22:25:30 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [mm/page_alloc]  2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Message-ID: <YsWbWsN2qPbWsNWZ@xsang-OptiPlex-9020>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
 <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
 <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
 <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
 <20220706095535.GD27531@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706095535.GD27531@techsingularity.net>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Mel Gorman,

On Wed, Jul 06, 2022 at 10:55:35AM +0100, Mel Gorman wrote:
> On Tue, Jul 05, 2022 at 09:51:25PM +0800, Oliver Sang wrote:
> > Hi Andrew Morton,
> > 
> > On Sun, Jul 03, 2022 at 01:22:09PM -0700, Andrew Morton wrote:
> > > On Sun, 3 Jul 2022 17:44:30 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> > > 
> > > > FYI, we noticed the following commit (built with gcc-11):
> > > > 
> > > > commit: 2bd8eec68f740608db5ea58ecff06965228764cb ("[PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock")
> > > > url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
> > > > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> > > > patch link: https://lore.kernel.org/lkml/20220613125622.18628-8-mgorman@techsingularity.net
> > > > 
> > > 
> > > Did this test include the followup patch
> > > mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch?
> > 
> > no, we just fetched original patch set and test upon it.
> > 
> > now we applied the patch you pointed to us upon 2bd8eec68f and found the issue
> > still exist.
> > (attached dmesg FYI)
> > 
> 
> Thanks Oliver.
> 
> The trace is odd in that it hits in GUP when the page allocator is no
> longer active and the context is a syscall. First, is this definitely
> the first patch the problem occurs?
> 
> Second, it's possible for IRQs to be enabled and an IRQ delivered before
> preemption is enabled. It's not clear why that would be a problem other
> than lacking symmetry or how it could result in the reported BUG but
> might as well rule it out. This is build tested only

do you want us test below patch?
if so, should we apply it upon the patch
"mm/page_alloc: Replace local_lock with normal spinlock"
or
"mm/page_alloc: replace local_lock with normal spinlock -fix"?

> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 934d1b5a5449..d0141e51e613 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -192,14 +192,14 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  
>  #define pcpu_spin_unlock(member, ptr)					\
>  ({									\
> -	spin_unlock(&ptr->member);					\
>  	pcpu_task_unpin();						\
> +	spin_unlock(&ptr->member);					\
>  })
>  
>  #define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
>  ({									\
> -	spin_unlock_irqrestore(&ptr->member, flags);			\
>  	pcpu_task_unpin();						\
> +	spin_unlock_irqrestore(&ptr->member, flags);			\
>  })
>  
>  /* struct per_cpu_pages specific helpers. */
>  
> 
> 
