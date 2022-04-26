Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41CF50FB40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbiDZKrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349312AbiDZKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:46:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF0C8101D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:37:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A764BED1;
        Tue, 26 Apr 2022 03:37:56 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.76.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3231C3F5A1;
        Tue, 26 Apr 2022 03:37:55 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:37:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Message-ID: <YmfLe+UZ85LhshZx@FVFF77S0Q05N>
References: <20220425115603.781311-1-mark.rutland@arm.com>
 <202204251551.0CFE01DF4@keescook>
 <YmfFLOW5QyF3DKTC@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmfFLOW5QyF3DKTC@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:10:52AM +0100, Mark Rutland wrote:
> On Mon, Apr 25, 2022 at 03:54:00PM -0700, Kees Cook wrote:
> > On Mon, Apr 25, 2022 at 12:55:55PM +0100, Mark Rutland wrote:
> > > This series reworks the stackleak code. The first patch fixes some
> > > latent issues on arm64, and the subsequent patches improve the code to
> > > improve clarity and permit better code generation.
> > 
> > This looks nice; thanks! I'll put this through build testing and get it
> > applied shortly...
> 
> Thanks!
> 
> Patch 1 is liable to conflict with come other stacktrace bits that may go in
> for v5.19, so it'd be good if either that could be queued as a fix for
> v5.1-rc4, or we'll have to figure out how to deal with conflicts later.
> 
> > > While the improvement is small, I think the improvement to clarity and
> > > code generation is a win regardless.
> > 
> > Agreed. I also want to manually inspect the resulting memory just to
> > make sure things didn't accidentally regress. There's also an LKDTM test
> > for basic functionality.
> 
> I assume that's the STACKLEAK_ERASING test?
> 
> I gave that a spin, but on arm64 that test is flaky even on baseline v5.18-rc1.
> On x86_64 it seems consistent after 100s of runs. I'll go dig into that now. 

I hacked in some debug, and it looks like the sp used in the test is far above
the current lowest_sp. The test is slightly wrong since it grabs the address of
a local variable rather than using current_stack_pointer, but the offset I see
is much larger:

# echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT 
[   27.665221] lkdtm: Performing direct entry STACKLEAK_ERASING
[   27.665986] lkdtm: FAIL: lowest_stack 0xffff8000083a39e0 is lower than test sp 0xffff8000083a3c80
[   27.667530] lkdtm: FAIL: the thread stack is NOT properly erased!

That's off by 0x2a0 (AKA 672) bytes, and it seems to be consistent from run to
run.

I note that an interrupt occuring could cause similar (since on arm64 those are
taken/triaged on the task stack before moving to the irq stack, and the irq
regs alone will take 300+ bytes), but that doesn't seem to be the problem here
given this is consistent, and it appears some prior function consumed a lot of
stack.

I *think* the same irq problem would apply to x86, but maybe that initial
triage happens on a trampoline stack.

I'll dig a bit more into the arm64 side...

Thanks,
Mark.
