Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0D505F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiDRVdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiDRVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:32:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63A2D1C5;
        Mon, 18 Apr 2022 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650317415; x=1681853415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1OtaZ59ChI9Oig63eTlaH2qmfVWaUwCxCZfjWbMO2Q=;
  b=ECzYLf4IobZECcu8eGdzPVJ5C4Sy3JRnEOjvJxXSlUgyMsCdtiXeTZS/
   pra8Fa3DPLe4cI8rKGuOS8IR6Esev4bAZ7B1jKPlBhKMO5Sj5rlSSFkjw
   WmaxqCA2hfew2rmGBFtkCn4aVU6Y/R5flh1KM6nDHWiCT35KNY5ZC0JI+
   ihckVcuFiTIT8xLRyIcV6oW/auRCKmk9UJhyqz0iT/Ay9WBl6wd9eXsPN
   lwEnqPKO0qdjNJUWbx3IVWjpbKsGHWlmokl95So2iG267XUIq58biEQoR
   PFwwkumIQBYlEqSEUKODNrsLKb+WiHZTkrDAgvKGC2C/lz78JvWN+7spV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263373260"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="263373260"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:30:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="592536988"
Received: from moseshab-mobl1.amr.corp.intel.com (HELO localhost) ([10.209.143.127])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:30:14 -0700
Date:   Mon, 18 Apr 2022 14:30:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Documentation/vm: Extend "Temporary Virtual
 Mappings" section
Message-ID: <Yl3YZN1ex7smhYHS@iweiny-desk3>
References: <20220415231917.25962-1-fmdefrancesco@gmail.com>
 <20220415231917.25962-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415231917.25962-2-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 01:19:16AM +0200, Fabio M. De Francesco wrote:
> Extend and rework the "Temporary Virtual Mappings" section of the highmem.rst
> documentation.
> 
> Do a partial rework of the paragraph related to kmap() and add a new paragraph
> in order to document the set of kmap_local_*() functions. Re-order paragraphs
> in decreasing order of preference of usage.
> 
> Despite the local kmaps were introduced by Thomas Gleixner in October 2020,
> documentation was still missing information about them. These additions rely
> largely on Gleixner's patches, Jonathan Corbet's LWN articles, comments by
> Ira Weiny and Matthew Wilcox, and in-code comments from
> ./include/linux/highmem.h.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  Documentation/vm/highmem.rst | 67 ++++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index 0f69a9fec34d..12dcfbee094d 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -52,24 +52,69 @@ Temporary Virtual Mappings
>  
>  The kernel contains several ways of creating temporary mappings:
>  
> -* vmap().  This can be used to make a long duration mapping of multiple
> -  physical pages into a contiguous virtual space.  It needs global
> -  synchronization to unmap.
> -
> -* kmap().  This permits a short duration mapping of a single page.  It needs
> -  global synchronization, but is amortized somewhat.  It is also prone to
> -  deadlocks when using in a nested fashion, and so it is not recommended for
> -  new code.
> +* kmap_local_*().  These provide a set of functions that are used to require
> +  short term mappings. They can be invoked from any context (including
> +  interrupts) but the mappings can only be used in the context which acquired
> +  it.
> +
> +  These mappings are per thread, CPU local (i.e., migration from one CPU to
> +  another is disabled - this is why they are called "local"), but they don't
> +  disable preemption. It's valid to take pagefaults in a local kmap region,
> +  unless the context in which the local mapping is acquired does not allow
> +  it for other reasons.
> +
> +  If a task holding local kmaps is preempted, the maps are removed on context
> +  switch and restored when the task comes back on the CPU. As the maps are
> +  strictly CPU local, it is guaranteed that the task stays on the CPU and
> +  that the CPU cannot be unplugged until the local kmaps are released.
> +
> +  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a certain

NIT: Throughout this doc why say 'kmap_local.*'?  There is only one call named
kmap_local_page().

> +  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and kunmap_local.*()
> +  invocations have to be strictly ordered because the map implementation is
> +  stack based.

This type of documentation should (and I believe is, in the kdoc of
kmap_local_page().  Why not just add this text (or enhance what is there) and
include that here?

Ah I see that patch 2/2 does add the kdocs for the functions... ah ok  :-/

Perhaps this section should focus on why to use each of the kmap calls and not
how?  Leave the how to the kdoc?  Although all this information would be nice
inside the header for programmers who are looking at using these functions.

Here is an example of how I dealt with this on a recent auxiliary bus
documentation update:

https://lore.kernel.org/lkml/20211202044305.4006853-8-ira.weiny@intel.com/

>  
>  * kmap_atomic().  This permits a very short duration mapping of a single
>    page.  Since the mapping is restricted to the CPU that issued it, it
>    performs well, but the issuing task is therefore required to stay on that
>    CPU until it has finished, lest some other task displace its mappings.
>  
> -  kmap_atomic() may also be used by interrupt contexts, since it is does not
> -  sleep and the caller may not sleep until after kunmap_atomic() is called.
> +  kmap_atomic() may also be used by interrupt contexts, since it does not
> +  sleep and the caller too can not sleep until after kunmap_atomic() is called.
> +  Each call of kmap_atomic() in the kernel creates a non-preemptible section and
> +  disable pagefaults.
> +
> +  This could be a source of unwanted latency, so it should be only used if it is
> +  absolutely required, otherwise the corresponding kmap_local_*() variant should
> +  be used if it is feasible.
> +
> +  On 64-bit systems, calls to kmap() and kmap_atomic() have no real work to do
                                 ^^^^^^^^^^^^^^^^^^^^^^^^
What about kmap_local_page()?

> +  because a 64-bit address space is more than sufficient to address all the
> +  physical memory, so all of physical memory appears in the direct mapping.
> +
> +  It is assumed that k[un]map_atomic() won't fail.
>  
> -  It may be assumed that k[un]map_atomic() won't fail.
> +* kmap().  This should be used to make short duration mapping of a single
> +  page with no restrictions on preemption or migration. It comes with an
> +  overhead as mapping space is restricted and protected by a global lock
> +  for synchronization. When mapping is no more needed, the address that
> +  the page was mapped to must be released with kunmap().
> +
> +  Mapping changes must be propagated across all the CPUs. kmap() also
> +  requires global TLB invalidation when the kmap's pool wraps and it might
> +  block when the mapping space is fully utilized until a slot becomes
> +  available. Therefore, kmap() is only callable from preemptible context.
> +
> +  All the above work is necessary if a mapping must last for a relatively
> +  long time but the bulk of high-memory mappings in the kernel are
> +  short-lived and only used in one place. This means that the cost of
> +  kmap() is mostly wasted in such cases. kmap() was not intended for long
> +  term mappings but it has morphed in that direction and its use is
> +  strongly discouraged in newer code and the set of the preceding functions
> +  should be preferred.

I like this paragraph especially the last sentence!  Nicely put!

But this is another reason I think this text in the code next to the kmap
calls.  Then it is more readily available to programmers who are looking at the
functions.

Thanks for the great work so far!
Ira

> +
> +* vmap().  This can be used to make a long duration mapping of multiple
> +  physical pages into a contiguous virtual space.  It needs global
> +  synchronization to unmap.
>  
>  
>  Using kmap_atomic
> -- 
> 2.34.1
> 
