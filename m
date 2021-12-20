Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9545847AAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhLTOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:04:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50020 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhLTOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:04:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1B0D60FE8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D0DC36AE7;
        Mon, 20 Dec 2021 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640009055;
        bh=nRdJrLXAXUQqjuTH6KevT/WyCCs075DkQ0KGChjv1JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCdjC4BwLnPvblWyz9yL1CZIIysDGt7qO3/okyaYkvCjzqq1yw5bNv9bi65X5Dors
         79C6mVf5N/90Ui8fu+bWwHWFHIJ7R9B/A0O16JrBLN5BS04sJMZ7Vmz1W+MG8IFxM5
         e4XtIn/I0evTyuMsfmKJ1jW0onYvz7l0aO4FXnfTPy2Tfr8TkVj8Ed1NrdVQJIO7y+
         iUuC4bci8UCDu0UK/L5zDSUmd8eDP4hRPlYl1ycViaRN7sxbrlHe+BPsOhmm5ki3HG
         fdvZcQGlxepbXf4lV972aklvxTduNqTsEQXuJNwwXDToe6+yC+rEzQXNzWh9ha8Zak
         i71xv7IvcR8qw==
Date:   Mon, 20 Dec 2021 15:04:12 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [GIT PULL] arm64: Support dynamic preemption v3
Message-ID: <20211220140412.GA918551@lothringen>
References: <20211220140142.922323-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220140142.922323-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(It's not a pull request actually, just an update).

Thanks.

On Mon, Dec 20, 2021 at 03:01:37PM +0100, Frederic Weisbecker wrote:
> Hi,
> 
> I haven't seen much comments on the static key based version from Mark
> so I don't know which direction we'll eventually take. I still hope we
> can focus on a unified static call based implementation, considering
> there are other users waiting on arm64 static calls.
> 
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
