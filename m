Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D854B9924
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiBQGWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:22:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBQGWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:22:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4B202051
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645078956; x=1676614956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=85rnRORCIPwIhEC1p52lDJjiYjOvcAcL42sjDvcDTfU=;
  b=mCqFAysfnWpDzTgGaB36Vf8n0sthpXT5CkudV8UTWlVpFmpgwZ1V22Om
   ULmA3cIpbztRb8cCsM7sLFgMgDTWAqSyrPr2MyC+AsdvaHvxezGmRHoiV
   FrWPMZwcknXX3nY7HbOU2UU/F48tO+7bMRW0/XAH4EKsFRCvmsP9JnmyJ
   slmWSY2MhJJ2hJD+kEzQk6yjo5cwe0lea2KimsR5m1VgIeFkDp6D1eelQ
   fgkF9Sf5Uqy+qW8ReXFznqrNTma8klSI5EM32gSfjFOfmfUz8l5WYZFia
   aSjzu0WjJp1SnX5IKioL5ggo9Fyat8A6RYRSnaLVRhA9jrJffPxXLM1xP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="231428470"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="231428470"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="529977998"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 16 Feb 2022 22:22:33 -0800
Date:   Thu, 17 Feb 2022 14:22:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20220217062232.GD8191@shbuild999.sh.intel.com>
References: <20220216082802.96054-1-feng.tang@intel.com>
 <1f0b2e18-5fad-7ef2-bbfb-d6662ecad252@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0b2e18-5fad-7ef2-bbfb-d6662ecad252@redhat.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Densy,

Thanks for the review!

On Wed, Feb 16, 2022 at 02:35:10PM +0100, Denys Vlasenko wrote:
> On 2/16/22 9:28 AM, Feng Tang wrote:
> > 0day has reported many strange performance changes (regression or
> > improvement), in which there was no obvious relation between the culprit
> > commit and the benchmark at the first look, and it causes people to doubt
> > the test itself is wrong.
> > 
> > Upon further check, many of these cases are caused by the change to the
> > alignment of kernel text or data, as whole text/data of kernel are linked
> > together, change in one domain can affect alignments of other domains.
> > 
> > To help quickly identifying if the strange performance change is caused
> > by _data_ alignment, add a debug option to force the data sections from
> > all .o files aligned on THREAD_SIZE, so that change in one domain won't
> > affect other modules' data alignment.
> > 
> > We have used this option to check some strange kernel changes [1][2][3],
> > and those performance changes were gone after enabling it, which proved
> > they are data alignment related. Besides these publicly reported cases,
> > recently there are other similar cases found by 0day, and this option
> > has been actively used by 0Day for analyzing strange performance changes.
> ...
> > +	.data : AT(ADDR(.data) - LOAD_OFFSET)
> > +#ifdef CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED
> > +	/* Use the biggest alignment of below sections */
> > +	SUBALIGN(THREAD_SIZE)
> > +#endif
> 
> "Align every input section to 4096 bytes" ?

The THREAD_SIZE depends on ARCH, and could be 16KB or more (KASAN related).

> This is way, way, WAY too much. The added padding will be very wasteful.
 
Yes, its too much. One general kernel's data section could be bumped
from 18MB to 50+ MB.

And I should make it more clear, that this is for debugging only.

> Performance differences are likely to be caused by cacheline alignment.
> Factoring in an odd hardware prefetcher grabbing an additional
> cacheline after every accessed one, I'd say alignment to 128 bytes
> (on x86) should suffice for almost any scenario. Even 64 bytes
> would almost always work fine.
 
Yep, when I started it, I tried 128 bytes for HW adjacent cacheline
prefetch consideration. But the built kernel won't boot, then I  
tried 512/1024/2048/4096 but there were still boot issue. So I 
chose the biggest alignment within data sections, considering
this is purely for analyzing/debugging purpose.

Thanks,
Feng


> The hardware prefetcher grabbing an additional cacheline was seen
> adversely affecting locking performance in a structure - developers
> thought two locks are not in the same cacheline, but because of
> this "optimization" they effectively are, and thus they bounce
> between CPUs. (1) Linker script can't help with this, since it was
> struct layout issue, not section alignment issue.
> (2) This "optimization" (unconditional fetch of next cacheline)
> might be bad enough to warrant detecting and disabling on boot.
