Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB74AD9A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376344AbiBHNWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbiBHMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB9FCC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:15:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DB36ED1;
        Tue,  8 Feb 2022 04:15:47 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C99F93F70D;
        Tue,  8 Feb 2022 04:15:44 -0800 (PST)
Date:   Tue, 8 Feb 2022 12:15:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v2 5/7] sched/preempt: add PREEMPT_DYNAMIC using static
 keys
Message-ID: <YgJe6aij3iwvgRAS@FVFF77S0Q05N>
References: <20220204150557.434610-1-mark.rutland@arm.com>
 <20220204150557.434610-6-mark.rutland@arm.com>
 <20220207115708.GA514319@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207115708.GA514319@lothringen>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 12:57:08PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 04, 2022 at 03:05:55PM +0000, Mark Rutland wrote:
> > diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> > index dfd84c59b144..141952f4fee8 100644
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -456,13 +456,19 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
> >   */
> >  void raw_irqentry_exit_cond_resched(void);
> >  #ifdef CONFIG_PREEMPT_DYNAMIC
> > +#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> >  #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
> >  #define irqentry_exit_cond_resched_dynamic_disabled	NULL
> >  DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
> >  #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
> > -#else
> > -#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
> > +#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> > +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> 
> If CONFIG_PREEMPT && CONFIG_PREEMPT_DYNAMIC and no "preempt=" parameter is
> passed, nothing is overriden on boot. So you need to either have cond_resched
> and might_resched initially disabled (STATIC_KEY_FALSE?) or call
> sched_dynamic_update() from preempt_dynamic_init() also when CONFIG_PREEMPT=y.

Ah; good spot. I'd missed that those were initialized to RET0.

I've changed those two to DECLARE_STATIC_KEY_FALSE(), which defaults those to
disabled, e.g.

| <dynamic_cond_resched>:
|        bti     c
|        nop     // <-------- `b <dynamic_cond_resched+0x10>` when enabled
|        mov     w0, #0x0
|        ret
|        mrs     x0, sp_el0
|        ldr     x0, [x0, #8]
|        cbnz    x0, 9d8 <dynamic_cond_resched+0x8>
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      900 <preempt_schedule_common>
|        mov     w0, #0x1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Thanks,
Mark.
