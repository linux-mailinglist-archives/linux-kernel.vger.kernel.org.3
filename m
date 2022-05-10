Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7852140E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiEJLoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiEJLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:44:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D566624EA05
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:40:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB23A11FB;
        Tue, 10 May 2022 04:40:22 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37DCC3F66F;
        Tue, 10 May 2022 04:40:21 -0700 (PDT)
Date:   Tue, 10 May 2022 12:40:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 02/13] stackleak: move skip_erasing() check earlier
Message-ID: <YnpPIZ/yotlPKwiA@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-3-mark.rutland@arm.com>
 <51cea283-3cc7-2361-413c-d1bd8ac845bb@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cea283-3cc7-2361-413c-d1bd8ac845bb@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 08:44:56PM +0300, Alexander Popov wrote:
> On 27.04.2022 20:31, Mark Rutland wrote:
> > In stackleak_erase() we check skip_erasing() after accessing some fields
> > from current. As generating the address of current uses asm which
> > hazards with the static branch asm, this work is always performed, even
> > when the static branch is patched to jump to the return a the end of the
> > function.
> 
> Nice find!
> 
> > This patch avoids this redundant work by moving the skip_erasing() check
> > earlier.
> > 
> > To avoid complicating initialization within stackleak_erase(), the body
> > of the function is split out into a __stackleak_erase() helper, with the
> > check left in a wrapper function. The __stackleak_erase() helper is
> > marked __always_inline to ensure that this is inlined into
> > stackleak_erase() and not instrumented.

[...]

> > diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> > index ddb5a7f48d69e..753eab797a04d 100644
> > --- a/kernel/stackleak.c
> > +++ b/kernel/stackleak.c
> > @@ -70,7 +70,7 @@ late_initcall(stackleak_sysctls_init);
> >   #define skip_erasing()	false
> >   #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
> > -asmlinkage void noinstr stackleak_erase(void)
> > +static __always_inline void __stackleak_erase(void)
> 
> Are you sure that __stackleak_erase() doesn't need asmlinkage and noinstr as well?

I am certain it needs neither.

It's static and never called from asm, so it doesn't need `asmlinkage`.

It's marked `__always_inline`, so it will always be inlined into its caller (or
if the compiler cannot inline it, will result in a compiler error).

That's important to get good codegen (especially with the on/off stack variants
later in the series), and when inlined into its caller the compiler will treat
it as part of its caller for code generation, so the caller's `noinstr` takes
effect.

Thanks,
Mark.

> 
> >   {
> >   	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
> >   	unsigned long kstack_ptr = current->lowest_stack;
> > @@ -78,9 +78,6 @@ asmlinkage void noinstr stackleak_erase(void)
> >   	unsigned int poison_count = 0;
> >   	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> > -	if (skip_erasing())
> > -		return;
> > -
> >   	/* Check that 'lowest_stack' value is sane */
> >   	if (unlikely(kstack_ptr - boundary >= THREAD_SIZE))
> >   		kstack_ptr = boundary;
> > @@ -125,6 +122,14 @@ asmlinkage void noinstr stackleak_erase(void)
> >   	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
> >   }
> > +asmlinkage void noinstr stackleak_erase(void)
> > +{
> > +	if (skip_erasing())
> > +		return;
> > +
> > +	__stackleak_erase();
> > +}
> > +
> >   void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
> >   {
> >   	unsigned long sp = current_stack_pointer;
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
