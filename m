Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFF74635C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhK3NuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhK3NuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:50:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417BC061574;
        Tue, 30 Nov 2021 05:47:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638280021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDafw5ZYQW26rsPyBDj9yTdDtGApD5T28fT5XA2pw1E=;
        b=kY/YhIatU6P6JGyQH3+/wkeL3o4bj8MayRtvaTEwYECehsRlsRt6kUSQsXrnO+3HWUPx3o
        GATTargEsSHp7NzB6fYNv0b6C93G1o1i4p4YZGXwyEzGi6JiQL4u46aJml6sWkIeyfTcBr
        XujHeXbsKJLK2RCC/J0ZRNmtQIcBLLJbvNGSsO2nMF/l/9Zwn3CZMm8l85oNvml6YxkU5V
        oJjOyjz5ml9/NzUvyLeR6sDMQM/swhaXcLpSWlPFRPkufy9Xc/1sKtIf0qAIehLW6Il65Q
        vRH+S51fC7Ijr+FO3y0KrSqYkyj8ghGtTY6/vaas2pSdADYFgdyivq7jfLCxSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638280021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDafw5ZYQW26rsPyBDj9yTdDtGApD5T28fT5XA2pw1E=;
        b=aH2thSLOdBhVEZqQILE/kh6HQ/W4QkaBo66b5pXACab+M62rkRICrkMnN/tuB9qMfwi6su
        UNmEWBW5oYXuTsDw==
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>
Subject: Re: Question WRT early IRQ/NMI entry code
In-Reply-To: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
Date:   Tue, 30 Nov 2021 14:47:01 +0100
Message-ID: <875ys9dacq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30 2021 at 12:28, Nicolas Saenz Julienne wrote:
> while going over the IRQ/NMI entry code I've found a small 'inconsistency=
':
> while in the IRQ entry path, we inform RCU of the context change *before*
> incrementing the preempt counter, the opposite happens for the NMI entry
> path. This applies to both arm64 and x86[1].
>
> Actually, rcu_nmi_enter() =E2=80=94 which is also the main RCU context sw=
itch function
> for the IRQ entry path =E2=80=94 uses the preempt counter to verify it's =
not in NMI
> context. So it would make sense to assume all callers have the same updat=
ed
> view of the preempt count, which isn't true ATM.
>
> I'm sure there an obscure/non-obvious reason for this, right?

There is.

> IRQ path:
>   -> x86_64 asm (entry_64.S)
>   -> irqentry_enter() -> rcu_irq_enter() -> *rcu_nmi_enter()*
>   -> run_irq_on_irqstack_cond() -> irq_exit_rcu() -> *preempt_count_add(H=
ARDIRQ_OFFSET)*
>   -> // Run IRQ...
>
> NMI path:
>   -> x86_64 asm (entry_64.S)
>   -> irqentry_nmi_enter() -> __nmi_enter() -> *__preempt_count_add(NMI_OF=
FSET + HARDIRQ_OFFSET)*
>                           -> *rcu_nmi_enter()*

The reason is symmetry vs. returning from interupt / exception:

 irqentry_enter()
      exit_rcu =3D false;

      if (user_mode(regs)) {
          irqentry_enter_from_user_mode(regs)
            __enter_from_user_mode(regs)
              user_exit_irqoff();       <- RCU handling for NOHZ full

      } else if (is_idle_task_current()) {
            rcu_irq_enter()
            exit_rcu =3D true;
      }

 irq_enter_rcu()
     __irq_enter_raw()
     preempt_count_add(HARDIRQ_OFFSET);

 irq_handler()

 irq_exit_rcu()
     preempt_count_sub(HARDIRQ_OFFSET);
     if (!in_interrupt() && local_softirq_pending())
     	 invoke_softirq();

 irqentry_exit(regs, exit_rcu)

     if (user_mode(regs)) {
         irqentry_exit_to_usermode(regs)
           user_enter_irqoff();     <- RCU handling for NOHZ full
     } else if (irqs_enabled(regs)) {
           if (exit_rcu) {          <- Idle task special case
               rcu_irq_exit();
           } else {
              irqentry_exit_cond_resched();
           }

     } else if (exit_rcu) {
         rcu_irq_exit();
     }

On return from interrupt HARDIRQ_OFFSET has to be removed _before_
handling soft interrupts. It's also required that the preempt count has
the original state _before_ reaching irqentry_exit() which
might schedule if the interrupt/exception hit user space or kernel space
with interrupts enabled.

So doing it symmetric makes sense.

For NMIs the above conditionals do not apply at all and we just do

    __nmi_enter()
        preempt_count_add(NMI_COUNT + HARDIRQ_COUNT);
    rcu_nmi_enter();

    handle_nmi();

    rcu_nmi_exit();
    __nmi_exit()
        preempt_count_sub(NMI_COUNT + HARDIRQ_COUNT);

The reason why preempt count is incremented before invoking
rcu_nmi_enter() is simply that RCU has to know about being in NMI
context, i.e. in_nmi() has to return the correct answer.

Thanks,

        tglx
