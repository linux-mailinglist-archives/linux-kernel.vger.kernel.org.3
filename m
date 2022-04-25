Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A1A50D66C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiDYBC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiDYBCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:02:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE0B6D4C7;
        Sun, 24 Apr 2022 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650848389; x=1682384389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Cq1Fl9CMgifsT97lU21ZUbbD/AKhEGdsuclScV7Qss=;
  b=XKRyf/xFL1MntLe6WMw3hcGQdre+DyK0y+E8CbSO9WX9pbs0ChUrMVO4
   mwSa+fPYp29RJrBwXZbLaDVo32Mn/9P5gRLUxew8zIr7A/8o/J5Fbojbr
   j29E/fM5RARJlCfyaZt8ORnYgEXJbF1UzsrLGq5RuFnVUmhku+j5C9soK
   u1lDLabNWbzFmUfcu1A+QZ89mXeeepqq5T6EL39jLHxJqPJQ7FCGQDI05
   KoFbVuS3m5sGKDO7L1lQDSaP2mV7uV5woQzZDDhpHa7AoA9Pm2admjfKX
   H7h4E1hz1WLV2RJN3sOsj+IanJ7H0tDCtjMRZI5iLUKpffWYrfx7JcujT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351553645"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="351553645"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 17:59:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="675966787"
Received: from hungyuan-mobl.amr.corp.intel.com (HELO localhost) ([10.212.88.155])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 17:59:48 -0700
Date:   Sun, 24 Apr 2022 17:59:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] Documentation/vm: Rework "Temporary Virtual Mappings"
Message-ID: <YmXyhH7wAJo274WB@iweiny-desk3>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
 <20220421180200.16901-5-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421180200.16901-5-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:02:00PM +0200, Fabio M. De Francesco wrote:
> Extend and rework the "Temporary Virtual Mappings" section of the highmem.rst
> documentation.
> 
> Despite the local kmaps were introduced by Thomas Gleixner in October 2020,
> documentation was still missing information about them. These additions rely
> largely on Gleixner's patches, Jonathan Corbet's LWN articles, comments by
> Ira Weiny and Matthew Wilcox, and in-code comments from
> ./include/linux/highmem.h.
> 
> 1) Add a paragraph to document kmap_local_page().
> 2) Reorder the list of functions by decreasing order of preference of
> use.
> 3) Rework part of the kmap() entry in list.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  Documentation/vm/highmem.rst | 71 ++++++++++++++++++++++++++++++------
>  1 file changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index e05bf5524174..960f61e7a552 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -50,26 +50,75 @@ space when they use mm context tags.
>  Temporary Virtual Mappings
>  ==========================
>  
> -The kernel contains several ways of creating temporary mappings:
> +The kernel contains several ways of creating temporary mappings. The following
> +list shows them in order of preference of use.
>  
> -* vmap().  This can be used to make a long duration mapping of multiple
> -  physical pages into a contiguous virtual space.  It needs global
> -  synchronization to unmap.
> +* kmap_local_page().  This function is used to require short term mappings.
> +  It can be invoked from any context (including interrupts) but the mappings
> +  can only be used in the context which acquired them.
> +
> +  This function should be preferred, where feasible, over all the others.
>  
> -* kmap().  This permits a short duration mapping of a single page.  It needs
> -  global synchronization, but is amortized somewhat.  It is also prone to
> -  deadlocks when using in a nested fashion, and so it is not recommended for
> -  new code.
> +  These mappings are per thread, CPU local (i.e., migration from one CPU to
> +  another is disabled - this is why they are called "local"), but they don't
> +  disable preemption. It's valid to take pagefaults in a local kmap region,
> +  unless the context in which the local mapping is acquired does not allow
> +  it for other reasons.
> +
> +  It is assumed that kmap_local_page() always returns the virtual address

kmap_local_page() does return a kernel virtual address.  Why 'assume' this?

Do you mean it returns an address in the direct map?

> +  of the mapping, therefore they won't ever fail.

I don't think that returning a virtual address has anything to do with the
assumption they will not fail.

Why do you say this?

> +
> +  If a task holding local kmaps is preempted, the maps are removed on context
> +  switch and restored when the task comes back on the CPU. As the maps are
> +  strictly CPU local, it is guaranteed that the task stays on the CPU and
> +  that the CPU cannot be unplugged until the local kmaps are released.
> +
> +  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
> +  extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
> +  because the map implementation is stack based.

I think I would reference the kmap_local_page() for more details on the
ordering because there have been some conversions I've done which were
complicated by this.

>  
>  * kmap_atomic().  This permits a very short duration mapping of a single
>    page.  Since the mapping is restricted to the CPU that issued it, it
>    performs well, but the issuing task is therefore required to stay on that
>    CPU until it has finished, lest some other task displace its mappings.
>  
> -  kmap_atomic() may also be used by interrupt contexts, since it is does not
> -  sleep and the caller may not sleep until after kunmap_atomic() is called.
> +  kmap_atomic() may also be used by interrupt contexts, since it does not
> +  sleep and the callers too may not sleep until after kunmap_atomic() is
> +  called.
> +
> +  Each call of kmap_atomic() in the kernel creates a non-preemptible section
> +  and disable pagefaults. This could be a source of unwanted latency, so it
> +  should be only used if it is absolutely required, otherwise kmap_local_page()
> +  should be used where it is feasible.
>  
> -  It may be assumed that k[un]map_atomic() won't fail.
> +  It is assumed that k[un]map_atomic() won't fail.
> +
> +* kmap().  This should be used to make short duration mapping of a single
> +  page with no restrictions on preemption or migration. It comes with an
> +  overhead as mapping space is restricted and protected by a global lock
> +  for synchronization. When mapping is no more needed, the address that
                                         ^^^^^^^^
					 no longer

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

Nice!

Ira

> +
> +  On 64-bit systems, calls to kmap_local_page(), kmap_atomic() and kmap() have
> +  no real work to do because a 64-bit address space is more than sufficient to
> +  address all the physical memory whose pages are permanently mapped.
> +
> +* vmap().  This can be used to make a long duration mapping of multiple
> +  physical pages into a contiguous virtual space.  It needs global
> +  synchronization to unmap.
>  
>  
>  Cost of Temporary Mappings
> -- 
> 2.34.1
> 
