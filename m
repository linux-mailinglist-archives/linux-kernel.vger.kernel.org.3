Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA750F206
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbiDZHUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343718AbiDZHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:20:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261458A315;
        Tue, 26 Apr 2022 00:17:09 -0700 (PDT)
Date:   Tue, 26 Apr 2022 09:17:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650957427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUsmSqjJn9cfCUqqcVGaXdkR4Xv0DD/qVI7UBf6+/eg=;
        b=NAj9DwlWgzIpw+IzXXee1OQv0/YjL5UikoTnrCyQG3kH71h0F31yCBWFBHzTgvbSv3Y1+b
        BWtEhzSlNUAHG2iohnxaCSnX9N/KN3YlLl76SCFeeRMjGpblkFde/DD7i2qdpy7KLVscuJ
        vzUib6HgVDSrlOnqiZe06QIlNGGZi3eZ8OBBcbxvdxDqh1f1Jd00L3Uk8ZrQh1Y2H98eij
        +37ppDiSt3DvyV2ohz/pyduzuO7cnXLJ1bnNb9iU2+vgmXCP9liYm9UOc0MIFI6soT+KSy
        fa6m0Jj0E6x6lKX4rxOwUNshEaFvAnWivNZrraDABnm8OqGGiF6iHWtdB7fStA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650957427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUsmSqjJn9cfCUqqcVGaXdkR4Xv0DD/qVI7UBf6+/eg=;
        b=2jWbHMnVJ4r4H0s/Qa+IFpZNTTDfDuOuwM8QrRDOsEUQeG2AdZtap0CnsUGfyiQPdFFvEp
        qvZrdXm9A4OU2uCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] Documentation/vm: Rework "Temporary Virtual
 Mappings" section
Message-ID: <YmecctAD9XXYG8CR@linutronix.de>
References: <20220425162400.11334-1-fmdefrancesco@gmail.com>
 <20220425162400.11334-5-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425162400.11334-5-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-25 18:24:00 [+0200], Fabio M. De Francesco wrote:
> index e05bf5524174..b09f1f9a81f2 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -50,26 +50,77 @@ space when they use mm context tags.
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

feasible? It should always be used. I don't see a reason why using
kmap_local_page() would not be feasible.

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
> +  kmap_local_page() always returns a valid virtual address and it is assumed
> +  that kunmap_local() will never fail.
> +
> +  If a task holding local kmaps is preempted, the maps are removed on context
> +  switch and restored when the task comes back on the CPU. As the maps are
> +  strictly CPU local, it is guaranteed that the task stays on the CPU and

Maybe "thread local" instead CPU local? Another thread on the same CPU
can not use this mapping.

> +  that the CPU cannot be unplugged until the local kmaps are released.
> +
> +  Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
> +  extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
> +  because the map implementation is stack based. See kmap_local_page () kdocs
                                                                       ^
> +  (included in the "Functions" section) for details on how to manage nested
> +  mappings.

While they can be nested I wouldn't encourage that.

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

Please add a note this function is deprecated and must not be used in
new code.

Sebastian
