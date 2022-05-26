Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE2534F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiEZMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiEZMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:42:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B5566D954
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:42:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8242A1688;
        Thu, 26 May 2022 05:42:44 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D8193F70D;
        Thu, 26 May 2022 05:42:41 -0700 (PDT)
Date:   Thu, 26 May 2022 13:42:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Waiman.Long@hp.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP
 macro
Message-ID: <Yo91omfDZtTgXhyn@FVFF77S0Q05N.cambridge.arm.com>
References: <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
 <871qwgmqws.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qwgmqws.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:14:59PM +1000, Michael Ellerman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Wed, May 25, 2022 at 7:40 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> >>
> >> Use try_cmpxchg64 instead of cmpxchg64 in CMPXCHG_LOOP macro.
> >> x86 CMPXCHG instruction returns success in ZF flag, so this
> >> change saves a compare after cmpxchg (and related move instruction
> >> in front of cmpxchg). The main loop of lockref_get improves from:
> >
> > Ack on this one regardless of the 32-bit x86 question.
> >
> > HOWEVER.
> >
> > I'd like other architectures to pipe up too, because I think right now
> > x86 is the only one that implements that "arch_try_cmpxchg()" family
> > of operations natively, and I think the generic fallback for when it
> > is missing might be kind of nasty.
> >
> > Maybe it ends up generating ok code, but it's also possible that it
> > just didn't matter when it was only used in one place in the
> > scheduler.
> 
> This patch seems to generate slightly *better* code on powerpc.
> 
> I see one register-to-register move that gets shifted slightly later, so
> that it's skipped on the path that returns directly via the SUCCESS
> case.

FWIW, I see the same on arm64; a register-to-register move gets moved out of
the success path. That changes the register allocation, and resulting in one
fewer move, but otherwise the code generation is the same.

Thanks,
Mark.
