Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C24BA916
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbiBQTAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:00:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbiBQTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:00:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFA27CDD9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UWn3wm9TVCSHhL7UPOPCJKsvepwt2cwCUefjLexbQSU=; b=qHPwK3ECHG0Bg7ZB+29LUFCV3w
        zUZoiR9GT0XiXSfA4OFoQQwH98+mNisfSGku2M+FaCxTaCcCkA5ILvJa21UhDaBFbsvXUbHonzuTR
        aKhbxPPuTpUKe8jyhQ6dSMNlzTCoRbEA05GOM95uC8vJe9SBRJyiW27hZeqWge50TOx/PtqDLRxfs
        KYrFpcwiVweyCLuTIL/iKUi7G1yMO27h3jhB2Uj+DnQ/UVv2ffQIlsmZ/G23YaH2lJrcycfY5Mpa7
        9yA68FjdRHEC+ofOP+UYX8llkAYgQusbfVNQqUkrSk0nsZKYpWrqTPBm02SU4lNmanjzg5yuxVEoa
        ciOHg1jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKm0L-00AdqK-HS; Thu, 17 Feb 2022 18:59:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 972BC986224; Thu, 17 Feb 2022 19:59:47 +0100 (CET)
Date:   Thu, 17 Feb 2022 19:59:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v4 0/7] arm64 / sched/preempt: support PREEMPT_DYNAMIC
 with static keys
Message-ID: <20220217185947.GE23216@worktop.programming.kicks-ass.net>
References: <20220214165216.2231574-1-mark.rutland@arm.com>
 <20220217135211.GA745330@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217135211.GA745330@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:52:11PM +0100, Frederic Weisbecker wrote:
> On Mon, Feb 14, 2022 at 04:52:09PM +0000, Mark Rutland wrote:
> > This series enables PREEMPT_DYNAMIC on arm64. To do so, it adds a new
> > mechanism allowing the preemption functions to be enabled/disabled using
> > static keys rather than static calls, with architectures selecting
> > whether they use static calls or static keys.
> > 
> > With non-inline static calls, each function call results in a call to
> > the (out-of-line) trampoline which either tail-calls its associated
> > callee or performs an early return.
> > 
> > The key idea is that where we're only enabling/disabling a single
> > callee, we can inline this trampoline into the start of the callee,
> > using a static key to decide whether to return early, and leaving the
> > remaining codegen to the compiler. The overhead should be similar to
> > (and likely lower than) using a static call trampoline. Since most
> > codegen is up to the compiler, we sidestep a number of implementation
> > pain-points (e.g. things like CFI should "just work" as well as they do
> > for any other functions).
> > 
> > The bulk of the diffstat for kernel/sched/core.c is shuffling the
> > PREEMPT_DYNAMIC code later in the file, and the actual additions are
> > fairly trivial.
> > 
> > I've given this very light build+boot testing so far.
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

I'll go stick them in sched/core then... :-)
