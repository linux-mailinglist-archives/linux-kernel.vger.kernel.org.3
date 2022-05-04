Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC951A5C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353548AbiEDQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245372AbiEDQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36464220E8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DE06173B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED16C385A5;
        Wed,  4 May 2022 16:41:35 +0000 (UTC)
Date:   Wed, 4 May 2022 17:41:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        alex.popov@linux.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 01/13] arm64: stackleak: fix current_top_of_stack()
Message-ID: <YnKsvNtIlE6cZEOa@arm.com>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427173128.2603085-2-mark.rutland@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:31:16PM +0100, Mark Rutland wrote:
> Due to some historical confusion, arm64's current_top_of_stack() isn't
> what the stackleak code expects. This could in theory result in a number
> of problems, and practically results in an unnecessary performance hit.
> We can avoid this by aligning the arm64 implementation with the x86
> implementation.
> 
> The arm64 implementation of current_top_of_stack() was added
> specifically for stackleak in commit:
> 
>   0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> 
> This was intended to be equivalent to the x86 implementation, but the
> implementation, semantics, and performance characteristics differ
> wildly:
> 
> * On x86, current_top_of_stack() returns the top of the current task's
>   task stack, regardless of which stack is in active use.
> 
>   The implementation accesses a percpu variable which the x86 entry code
>   maintains, and returns the location immediately above the pt_regs on
>   the task stack (above which x86 has some padding).
> 
> * On arm64 current_top_of_stack() returns the top of the stack in active
>   use (i.e. the one which is currently being used).
> 
>   The implementation checks the SP against a number of
>   potentially-accessible stacks, and will BUG() if no stack is found.
> 
> The core stackleak_erase() code determines the upper bound of stack to
> erase with:
> 
> | if (on_thread_stack())
> |         boundary = current_stack_pointer;
> | else
> |         boundary = current_top_of_stack();
> 
> On arm64 stackleak_erase() is always called on a task stack, and
> on_thread_stack() should always be true. On x86, stackleak_erase() is
> mostly called on a trampoline stack, and is sometimes called on a task
> stack.
> 
> Currently, this results in a lot of unnecessary code being generated for
> arm64 for the impossible !on_thread_stack() case. Some of this is
> inlined, bloating stackleak_erase(), while portions of this are left
> out-of-line and permitted to be instrumented (which would be a
> functional problem if that code were reachable).
> 
> As a first step towards improving this, this patch aligns arm64's
> implementation of current_top_of_stack() with x86's, always returning
> the top of the current task's stack. With GCC 11.1.0 this results in the
> bulk of the unnecessary code being removed, including all of the
> out-of-line instrumentable code.
> 
> While I don't believe there's a functional problem in practice I've
> marked this as a fix since the semantic was clearly wrong, the fix
> itself is simple, and other code might rely upon this in future.
> 
> Fixes: 0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Popov <alex.popov@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will@kernel.org>

I thought this was queued already but I couldn't find it in -next. So:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
