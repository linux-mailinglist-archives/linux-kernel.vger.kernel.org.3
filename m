Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203C150C15F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiDVWFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiDVWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:05:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049B12C8D3;
        Fri, 22 Apr 2022 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650660457; x=1682196457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ykNKyTeK2OUg9JXBqIirdWxYu+LgsMf1w5bMSCs968=;
  b=eT4ZZrpmzTYQt6/lP8bXOpH30uGpVLY3xNmmY5z4K7OG+Gtw7w2zXfGv
   gdlBpOYsi+lpSOHuLdBibvUjVQ4Xjl97+BPAtcwbvjZJtuMh8of61e1sS
   zBkjZdLNVBdCiai5tAWzsyKAUqGMkscocaRGDql+g/LZWP6GuYN/cbLx0
   WgEjPZEXMw+pdOTm8Aw5VY8hEMlfknvBu/DLTu9aMul0Y0n0Jzw6fU1nG
   4YBgdy0DhRyOIG8fX8N7bGhMWsojXbwtbqbhuPCapqcAfSbBnEjyOT7UM
   GWuQe3nvUkOapscBu6GivPRAlvsGSyRb/HKbtPXxcH2YOLFMwqGJ3ny/3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263600761"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="263600761"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 11:38:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="703659339"
Received: from hltravis-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.166.215])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 11:38:09 -0700
Date:   Fri, 22 Apr 2022 11:38:09 -0700
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
Subject: Re: [PATCH 3/4] Documentation/vm: Remove "Using kmap-atomic" from
 highmem.rst.
Message-ID: <YmL2EQhfQLMoU1WV@iweiny-desk3>
References: <20220421180200.16901-1-fmdefrancesco@gmail.com>
 <20220421180200.16901-4-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421180200.16901-4-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:01:59PM +0200, Fabio M. De Francesco wrote:
> The use of kmap_atomic() is deprecated in favor of kmap_local_page().

I'm not sure deprecated is the right word.  And I think the fact that this
documentation is stale is a better reason for the patch as is.

This series should end up indicating the desire to stop growing kmap() and
kmap_atomic() call sites and that their deprecation is on the horizon.  I've
not read the text in patch 4/4 yet.

> For
> this reason the "Using kmap_atomic" section in highmem.rst is obsolete and
> unnecessary.

A lot of the text is obsolete (and redundant) but the example code might be
useful.

Why not move the example and relevant bits into the kdoc for kmap_atomic()
which is then automatically picked up via patch 2/4.

Ira

> 
> Therefore, just remove it.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  Documentation/vm/highmem.rst | 35 -----------------------------------
>  1 file changed, 35 deletions(-)
> 
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index ccff08a8211d..e05bf5524174 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -72,41 +72,6 @@ The kernel contains several ways of creating temporary mappings:
>    It may be assumed that k[un]map_atomic() won't fail.
>  
>  
> -Using kmap_atomic
> -=================
> -
> -When and where to use kmap_atomic() is straightforward.  It is used when code
> -wants to access the contents of a page that might be allocated from high memory
> -(see __GFP_HIGHMEM), for example a page in the pagecache.  The API has two
> -functions, and they can be used in a manner similar to the following::
> -
> -	/* Find the page of interest. */
> -	struct page *page = find_get_page(mapping, offset);
> -
> -	/* Gain access to the contents of that page. */
> -	void *vaddr = kmap_atomic(page);
> -
> -	/* Do something to the contents of that page. */
> -	memset(vaddr, 0, PAGE_SIZE);
> -
> -	/* Unmap that page. */
> -	kunmap_atomic(vaddr);
> -
> -Note that the kunmap_atomic() call takes the result of the kmap_atomic() call
> -not the argument.
> -
> -If you need to map two pages because you want to copy from one page to
> -another you need to keep the kmap_atomic calls strictly nested, like::
> -
> -	vaddr1 = kmap_atomic(page1);
> -	vaddr2 = kmap_atomic(page2);
> -
> -	memcpy(vaddr1, vaddr2, PAGE_SIZE);
> -
> -	kunmap_atomic(vaddr2);
> -	kunmap_atomic(vaddr1);
> -
> -
>  Cost of Temporary Mappings
>  ==========================
>  
> -- 
> 2.34.1
> 
