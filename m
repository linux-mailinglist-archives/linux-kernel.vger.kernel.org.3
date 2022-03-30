Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9304EBE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiC3JzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiC3JzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:55:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D432C181
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:53:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 987AD23A;
        Wed, 30 Mar 2022 02:53:17 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.23.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 929F63F66F;
        Wed, 30 Mar 2022 02:53:16 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:53:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] entry: fix compile error in
 dynamic_irqentry_exit_cond_resched()
Message-ID: <YkQog3+80izN1e1q@FVFF77S0Q05N>
References: <20220330084328.1805665-1-svens@linux.ibm.com>
 <YkQdMDlIt1iHWS3U@FVFF77S0Q05N>
 <yt9dilrvztno.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yt9dilrvztno.fsf@linux.ibm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:17:15AM +0200, Sven Schnelle wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Wed, Mar 30, 2022 at 10:43:28AM +0200, Sven Schnelle wrote:
> >> kernel/entry/common.c: In function ‘dynamic_irqentry_exit_cond_resched’:
> >> kernel/entry/common.c:409:14: error: implicit declaration of
> >> function ‘static_key_unlikely’; did you mean ‘static_key_enable’?
> >> [-Werror=implicit-function-declaration]
> >>   409 |         if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> >>       |              ^~~~~~~~~~~~~~~~~~~
> >>       |              static_key_enable
> >> 
> >> static_key_unlikely() should be static_branch_unlikely().
> >> 
> >> Fixes: 99cf983cc8bca ("sched/preempt: Add PREEMPT_DYNAMIC using static keys")
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >
> > Sorry about this. FWIW:
> >
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> >
> > For context for others, this'll only show up on architectures which both use
> > the generic entry code and select CONFIG_HAVE_PREEMPT_DYNAMIC_KEY. Today, only
> > arm64 selects CONFIG_HAVE_PREEMPT_DYNAMIC_KEY, and it doesn't use the generic
> > entry code.
> >
> > Sven, I assume you're looking at wiring this up on s390 or parisc?
> 
> Yes, i'm looking whether we can use the same implementation on s390. :)
> 
> I reported it already on 03/18, but looks like that Mail was lost
> somehow:
> 
> https://www.spinics.net/lists/kernel/msg4283802.html

Ah; sorry, I didn't spot that somehow.

> I was wondering whether we can make dynamic_irqentry_exit_cond_resched()
> static, so it gets inlined. On s390 the compiler generates a branch to
> that function just to return immediately if the static key isn't enabled.
> With static it would get inlined, and therefore save one function call.
> What do you think?

I appreciate that it saves one call, but does that actually matter in practice,
given this is called only once per interrupt?

I'm not fundamentally opposed to changing it, but doing so would make it
different from all the other dynamic_*() cases which need the check to be
out-of-line to avoid bloating the callers, and it's not clear to me that we'd
gain much by doing so.

FWIW, on arm64 we had some additional conditions we have to check, so we roll
our own (out-of-line) implementation anyway. So doing something arch-specific
is also an option.

Thanks,
Mark.
