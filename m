Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686DC4FAB9F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 05:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiDJDX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 23:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiDJDXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 23:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30BA5D1B3;
        Sat,  9 Apr 2022 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YkPaG8q5LhgyEQ1dMfrtkegiJRbt/UFMJzWcJK1aI8U=; b=UPKCGUNXO09SfZJmC/AKsPQ7Aa
        ZL0+iHRlZun9Hbm4gPecKcvxnmWB4w6MaLARvlkSIU5koWwdtVUceZayWiS8MkhJjhDIOfI50/k7p
        yvWc20VpLlwfryuKmMA3r1QXM4ycVS27tgxmfn92UUcH2cqz+2Ktx9h/EI/tMXtxIMlOJ9m5L8wAr
        hs8FbeCd6lw3sXkU+PpLXQjlUV7XtPgGjZL+j429/Oxk7vgTZSQ5hblk9v/Kkdk/WpEdgbAg5g/5x
        M4p73WaM0xDGiHCFAskz0a+FWnt2o51z6Li1QcGal+XgrWu36d+6FzBCImcFb4LriQ0UFsII9v8Zl
        vb+a/huw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndO8R-00BC0P-HT; Sun, 10 Apr 2022 03:21:07 +0000
Date:   Sun, 10 Apr 2022 04:21:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org
Subject: Re: [PATCH] Documentation/vm: Extend "Temporary Virtual Mappings" in
 highmem.rst
Message-ID: <YlJNI7c9pwq5R0RB@casper.infradead.org>
References: <20220409184907.25122-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409184907.25122-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 08:49:07PM +0200, Fabio M. De Francesco wrote:
> @@ -52,25 +52,65 @@ Temporary Virtual Mappings
>  
>  The kernel contains several ways of creating temporary mappings:
>  
> -* vmap().  This can be used to make a long duration mapping of multiple
> -  physical pages into a contiguous virtual space.  It needs global
> -  synchronization to unmap.
> +* vmap().  This can be used to make a long duration mapping of multiple physical
> +  pages into a contiguous virtual space. It needs global synchronization to unmap.

Did you change any words here?  If so, I can't see them.  Please don't
gratuitously reformat paragraphs; it obscures the real changes.  Also,
75 characters is a good limit for line length, and you're well past
that.  If in doubt, use `fmt`.

> -* kmap().  This permits a short duration mapping of a single page.  It needs
> -  global synchronization, but is amortized somewhat.  It is also prone to
> -  deadlocks when using in a nested fashion, and so it is not recommended for
> -  new code.
> +* kmap().  This can be used to make long duration mapping of a single page with

kmap() really isn't for long duration.  But the pointer returned from
kmap() is valid across all CPUs, unlike kmap_local() or kmap_atomic().

> +  no restrictions on preemption or migration. It comes with an overhead as mapping
> +  space is restricted and protected by a global lock for synchronization. When
> +  mapping is no more needed, page must be released with kunmap().

kunmap() doesn't release the page, it releases the address that the
page was mapped to.

> +  Mapping changes must be propagated across all the CPUs. kmap() also requires
> +  global TLB invalidation when the kmap's pool wraps and it might block when the
> +  mapping space is fully utilized until a slot becomes available. Therefore,
> +  kmap() is only callable from preemptible context.
>  
> +  All the above work is necessary if a mapping must last for a relatively long
> +  time but the bulk of high-memory mappings in the kernel are short-lived and
> +  only used in one place.
> +
> +  This means that the cost of kmap() is mostly wasted in such cases; therefore,
> +  newer code is discouraged from using kmap().
>  
> -* kmap_atomic().  This permits a very short duration mapping of a single
> -  page.  Since the mapping is restricted to the CPU that issued it, it
> -  performs well, but the issuing task is therefore required to stay on that
> -  CPU until it has finished, lest some other task displace its mappings.
> +* kmap_atomic().  This permits a very short duration mapping of a single page.
> +  Since the mapping is restricted to the CPU that issued it, it performs well,
> +  but the issuing task is therefore required to stay on that CPU until it has
> +  finished, lest some other task displace its mappings.
>  
> -  kmap_atomic() may also be used by interrupt contexts, since it is does not
> -  sleep and the caller may not sleep until after kunmap_atomic() is called.
> +  kmap_atomic() may also be used by interrupt contexts, since it is does not
> +  sleep and the caller too can not sleep until after kunmap_atomic() is called.
> +  Each call of kmap_atomic() in the kernel creates a non-preemptible section and
> +  disable pagefaults.
> +
> +  This could be a source of unwanted latency, so it should be only used if it is
> +  absolutely required, otherwise the corresponding kmap_local_*() variant should
> +  be used if it is feasible (see below).
> +
> +  On 64-bit systems, calls to kmap() and kmap_atomic() have no real work to do
> +  because a 64-bit address space is more than sufficient to address all the
> +  physical memory, so all of physical memory appears in the direct mapping.
> +
> -  It may be assumed that k[un]map_atomic() won't fail.
> +  It is assumed that k[un]map_atomic() won't fail.
> +
> +* kmap_local_*().  These provide a set of functions similar to kmap_atomic() and
> +  are used to require short term mappings. They can be invoked from any context
> +  (including interrupts).
> +
> +  The mapping can only be used in the context which acquired it, it is per thread,
> +  CPU local (i.e., migration from one CPU to another is disabled - this is why
> +  they are called "local"), but they don't disable preemption. It's valid to take
> +  pagefaults in a local kmap region, unless the context in which the local mapping
> +  is acquired does not allow it for other reasons.
> +
> +  If a task holding local kmaps is preempted, the maps are removed on context
> +  switch and restored when the task comes back on the CPU. As the maps are strictly
> +  CPU local, it is guaranteed that the task stays on the CPU and that the CPU
> +  cannot be unplugged until the local kmaps are released.
> +
> +  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a certain
> +  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and kunmap_local.*()
> +  invocations have to be strictly ordered because the map implementation is stack
> +  based.

I think the original layout of all this is flawed.  We should start by
describing the interface we want people to use first -- kmap_local*(),
then say "But if you can't use that, there's kmap_atomic()" and "If
you can't use kmap_atomic(), you can use kmap()".  And vmap() should
go right at the end because it's entirely different from the kmap()
family.  I even question if it should be in this document, but it's not
really documented anywhere else.

Also, you should probably cc the person who is listed as the author
of the document, don't you think?
