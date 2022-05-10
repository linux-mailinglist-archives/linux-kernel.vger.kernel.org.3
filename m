Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C552142B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiEJLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiEJLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:50:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 565EF235C04
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:46:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CDC11FB;
        Tue, 10 May 2022 04:46:54 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60163F66F;
        Tue, 10 May 2022 04:46:52 -0700 (PDT)
Date:   Tue, 10 May 2022 12:46:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
Message-ID: <YnpQqBwYjlVffJk8@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-4-mark.rutland@arm.com>
 <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 09:17:01PM +0300, Alexander Popov wrote:
> On 27.04.2022 20:31, Mark Rutland wrote:
> > In __stackleak_erase() we check that the `erase_low` value derived from
> > `current->lowest_stack` is above the lowest legitimate stack pointer
> > value, but this is already enforced by stackleak_track_stack() when
> > recording the lowest stack value.
> > 
> > Remove the redundant check.
> > 
> > There should be no functional change as a result of this patch.
> 
> Mark, I can't agree here. I think this check is important.
> The performance profit from dropping it is less than the confidence decrease :)
> 
> With this check, if the 'lowest_stack' value is corrupted, stackleak doesn't
> overwrite some wrong kernel memory, but simply clears the whole thread
> stack, which is safe behavior.

If you feel strongly about it, I can restore the check, but I struggle to
believe that it's worthwhile. The `lowest_stack` value lives in the
task_struct, and if you have the power to corrupt that you have the power to do
much more interesting things.

If we do restore it, I'd like to add a big fat comment explaining the
rationale (i.e. that it only matter if someone could corrupt
`current->lowest_stack`, as otherwise that's guarnateed to be within bounds).

Thanks,
Mark.

> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Popov <alex.popov@linux.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >   kernel/stackleak.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> > index 753eab797a04d..f7a0f8cf73c37 100644
> > --- a/kernel/stackleak.c
> > +++ b/kernel/stackleak.c
> > @@ -78,10 +78,6 @@ static __always_inline void __stackleak_erase(void)
> >   	unsigned int poison_count = 0;
> >   	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
> > -	/* Check that 'lowest_stack' value is sane */
> > -	if (unlikely(kstack_ptr - boundary >= THREAD_SIZE))
> > -		kstack_ptr = boundary;
> > -
> >   	/* Search for the poison value in the kernel stack */
> >   	while (kstack_ptr > boundary && poison_count <= depth) {
> >   		if (*(unsigned long *)kstack_ptr == STACKLEAK_POISON)
> 
