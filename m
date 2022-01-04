Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08DC4846AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiADRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:08:53 -0500
Received: from foss.arm.com ([217.140.110.172]:33912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbiADRIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:08:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D40B913A1;
        Tue,  4 Jan 2022 09:08:51 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.9.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0ACF3F774;
        Tue,  4 Jan 2022 09:08:49 -0800 (PST)
Date:   Tue, 4 Jan 2022 17:08:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] arm64: Support dynamic preemption v3
Message-ID: <YdR/HnklL9y2Go9u@FVFF77S0Q05N>
References: <20211220140142.922323-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:01:37PM +0100, Frederic Weisbecker wrote:
> Hi,
> 
> I haven't seen much comments on the static key based version from Mark
> so I don't know which direction we'll eventually take.

Sorry; I had planned to rework that according to your comments, but I hadn't
had a sufficient block of time to do so. I still intend to do that by
v5.17-rc1.

> I still hope we can focus on a unified static call based implementation,
> considering there are other users waiting on arm64 static calls.

The only other user that I am aware of is in tracing, purely as a workaround
for clang CFI having awful performance for modules, and CFI and static calls do
not play well together to begin with due to the way function addresses get
rewritten. I'd rather fix CFI than bodge around it, and that leaves no other
users...

My opinion is that the current shape of the static call API is ill-suited for
arm64 (e.g. due to branch range limitations and so on), and so I'd rather avoid
static calls on arm64. One reason I went for the static-call based trampoline
was that it was functionally equivalent to building the out-of-line static call
trampolines, but was architecture neutral, so I'd rather get that working for
everyone.

Thanks,
Mark.

> So here is a rebase against the latest tip:sched/core and arm64 static
> call proposal.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	preempt/arm-v4
> 
> HEAD: 6fc1c7e3d83c4e06b019b041894d9bb25f37ac6c
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (3):
>       sched/preempt: Prepare for supporting !CONFIG_GENERIC_ENTRY dynamic preemption
>       arm64: Implement IRQ exit preemption static call for dynamic preemption
>       arm64: Implement HAVE_PREEMPT_DYNAMIC
> 
> Ard Biesheuvel (2):
>       static_call: Use non-function types to refer to the trampolines
>       arm64: implement support for static call trampolines
> 
> 
>  arch/Kconfig                         |  1 -
>  arch/arm64/Kconfig                   |  3 ++
>  arch/arm64/include/asm/preempt.h     | 23 ++++++++++-
>  arch/arm64/include/asm/static_call.h | 40 +++++++++++++++++++
>  arch/arm64/kernel/entry-common.c     | 15 +++++--
>  arch/arm64/kernel/patching.c         | 77 ++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/vmlinux.lds.S      |  1 +
>  include/linux/entry-common.h         |  3 +-
>  include/linux/static_call.h          |  4 +-
>  include/linux/static_call_types.h    | 11 ++++--
>  kernel/sched/core.c                  |  6 ++-
>  11 files changed, 168 insertions(+), 16 deletions(-)
