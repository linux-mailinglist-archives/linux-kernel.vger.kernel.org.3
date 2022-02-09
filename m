Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57D4AFDE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiBIT6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:58:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiBIT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:58:35 -0500
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 11:58:33 PST
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5364EE0497B4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:58:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99663CE228E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A0EC340E7;
        Wed,  9 Feb 2022 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644436710;
        bh=Jys0zUIlLh9UgNKBmxECnOEy0ha/NfM8jGt9IxYZ7lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQIVjvCsY26YgzmSVRipVZOe2gtM14cZc5P1IB6wgrysXbK0j0qsZmMWSfqQrZas/
         KLwLwlq53LoM8ldljADwKtwXOy222owFug5NYZb8KUhNS96m1VweiIsrcV3jbWNqUp
         wMt4opnpTe4NGAQiCK7MO3t/qsojBI5akm23J5LNaRZUstss2sEne51Y3lg5MWoICj
         9oW2vjbf4jpIRs+rMJJPfp1UADQPB1dSYKgyJBYwvtqYF5X6qyiHpe2PhFLW8mR0PY
         RwKtkXhHVitKx3FEyGj+3k35rQg6ur5dWdanQyBnFRQCvZe8gSAfUqMPQvRs5Mjy6p
         CBzDxEnK10NOA==
Date:   Wed, 9 Feb 2022 20:58:27 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 0/7] arm64 / sched/preempt: support PREEMPT_DYNAMIC
 with static keys
Message-ID: <20220209195827.GB557593@lothringen>
References: <20220209153535.818830-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209153535.818830-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:35:28PM +0000, Mark Rutland wrote:
> This series enables PREEMPT_DYNAMIC on arm64. To do so, it adds a new
> mechanism allowing the preemption functions to be enabled/disabled using
> static keys rather than static calls, with architectures selecting
> whether they use static calls or static keys.
> 
> With non-inline static calls, each function call results in a call to
> the (out-of-line) trampoline which either tail-calls its associated
> callee or performs an early return.
> 
> The key idea is that where we're only enabling/disabling a single
> callee, we can inline this trampoline into the start of the callee,
> using a static key to decide whether to return early, and leaving the
> remaining codegen to the compiler. The overhead should be similar to
> (and likely lower than) using a static call trampoline. Since most
> codegen is up to the compiler, we sidestep a number of implementation
> pain-points (e.g. things like CFI should "just work" as well as they do
> for any other functions).
> 
> The bulk of the diffstat for kernel/sched/core.c is shuffling the
> PREEMPT_DYNAMIC code later in the file, and the actual additions are
> fairly trivial.
> 
> I've given this very light build+boot testing so far.
> 
> Since v1 [1]:
> * Rework Kconfig text to be clearer
> * Rework arm64 entry code
> * Clarify commit messages.
> 
> Since v2 [2]:
> * Add missing includes
> * Always provide prototype for preempt_schedule()
> * Always provide prototype for preempt_schedule_notrace()
> * Fix __cond_resched() to default to disabled
> * Fix might_resched() to default to disabled
> * Clarify example in commit message

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
