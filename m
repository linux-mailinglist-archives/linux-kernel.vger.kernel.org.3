Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB26F4650DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbhLAPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:08:44 -0500
Received: from foss.arm.com ([217.140.110.172]:39198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350271AbhLAPI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C496C143B;
        Wed,  1 Dec 2021 07:05:05 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935EA3F766;
        Wed,  1 Dec 2021 07:05:04 -0800 (PST)
Date:   Wed, 1 Dec 2021 15:05:01 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joey.gouly@arm.com
Subject: Re: [PATCH v2] arm64: Enable KCSAN
Message-ID: <YaePHV30QNTyav1P@FVFF77S0Q05N>
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
 <YadiUPpJ0gADbiHQ@FVFF77S0Q05N>
 <YadpsjyfdozccsOT@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YadpsjyfdozccsOT@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:25:22PM +0100, Marco Elver wrote:
> On Wed, Dec 01, 2021 at 11:53AM +0000, Mark Rutland wrote:
> [...]
> > * In the past clang did not have an attribute to suppress tsan instrumenation
> >   and would instrument noinstr regions. I'm not sure when clang gained the
> >   relevant attribute to supress this, but we will need to depend on this
> >   existing, either based on the clang version or with a test for the attribute.
> > 
> >   (If we're lucky, clang 12.0.0 is sufficient, and we solve BTI and this in one
> >   go).
> > 
> >   I *think* GCC always had an attribute, but I'm not certain.
> > 
> >   Marco, is there an existing dependency somewhere for this to work on x86? I
> >   thought there was an objtool pass to NOP this out, but I couldn't find it in
> >   mainline. If x86 is implicitly depending on a sufficiently recent version of
> >   clang, we add something to the common KCSAN Kconfig for ARCH_WANTS_NO_INSTR?
> 
> Apologies for the confusion w.r.t. attributes and which sanitizers on
> which compilers respect which attributes. I think you may be confusing
> things with KCOV (see 540540d06e9d9). I think the various 'select
> ARCH_HAS_KCOV' may need adjusting, that is true.
> 
> But KCOV != KCSAN, and for KCSAN the story is different. Since the first
> version of KCSAN in 5.8, we've had a working __no_kcsan (aka
> __no_sanitize_thread) with all versions of Clang and GCC that support
> KCSAN (see HAVE_KCSAN_COMPILER).

My memory was hazy; I recalled that KCOV was broken in that way, and thought
KCSAN was similarly affected because of the objtool patches.

I'm glad to hear that's not the case!

Since I'm a bit paranoid about this, I'd still like to check that the supported
version (clang 12+, and whatever GCC versions are relevant), but that should
just be a matter of eyeballing the object code, and I'm happy to go do that as
a review step.

> The recent discussion was for CONFIG_KCSAN_WEAK_MEMORY [1], because
> Clang's no_sanitize("thread") would still instrument builtin atomics and
> __tsan_func_{entry,exit}, which only that mode would start inserting
> instrumentation for. That's not in mainline yet.
> 
> [1] https://lkml.kernel.org/r/20211130114433.2580590-1-elver@google.com
> 
> It is true that v1 and v2 of that series would have caused issues on
> arm64, but after our discussion last week and tried a little harder and
> v3 does the right thing for all architectures now and __no_kcsan will
> disable all instrumentation (even for barriers).

Nice; thanks for attacking that! :)

> So the attribute and noinstr story should not need anything else, and
> the new KCSAN_WEAK_MEMORY has all right Kconfig dependencies in place
> when it lands in mainline.
> 
> > * There are some latent issues with some code (e.g. alternatives, patching, insn)
> >   code being instrumentable even though this is unsound, and depending on
> >   compiler choices this can happen to be fine or can result in boot-time
> >   failures (I saw lockups when I started trying to add KCSAN for arm64).
> > 
> >   While this isn't just a KCSAN problem, fixing that requires some fairly
> >   significant rework to a bunch of code, and until that's done we're on very
> >   shaky ground. So I'd like to make KCSAN depend on EXPERT for now.
> 
> I take it you mean arm64 should do 'select HAVE_ARCH_KCSAN if EXPERT'. I
> certainly don't mind, but usually folks interested in running debug
> tools won't be stopped by a dependency on EXPERT. You could do 'select
> HAVE_ARCH_KCSAN if BROKEN' which is more likely to prevent usage while
> things are still likely to be broken on arm64.

TBH, I've gone back-and-forth on this and I'm also happy to go without if
people don't like it.

I had wanted this because I had previously hit issues, but the problem is
admittedly not unique to KCSAN. If we do encounter boot time failures in
practice we can mark it as BROKEN and go from there.

Maybe it would be sufficient to have some Kconfig text noting there are
currently some potential soundness issues with instrumentation, just to give
people a heads-up. The EXPERT dependency was just a way to make people think
twice.

Thanks,
Mark
