Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4387E4639A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbhK3PS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244843AbhK3PQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638285187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n220DQeRFKcjbDQSKaDE8TWF6TULUWs/w7HLtkrnd5U=;
        b=g5lFePUAo1qyb3XjpAuA9ZtAhfrKH/I6EbNbmMa/aulZPdnfh3v4MtNhoqyxUCipLAZxRH
        fTNbQNO6LPL2dtgdwZlsteB22igiAHL8G+Q+KPpS6qrOfacW5Mvpzw5dy/LSAgLbnPNDNk
        iuBEmiskQf4CLKt6T/qe2PeGpjajVYI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-525-ctslu1EzO1e3dnmcdkkGjQ-1; Tue, 30 Nov 2021 10:13:06 -0500
X-MC-Unique: ctslu1EzO1e3dnmcdkkGjQ-1
Received: by mail-wm1-f70.google.com with SMTP id b142-20020a1c8094000000b0033f27b76819so7716271wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=n220DQeRFKcjbDQSKaDE8TWF6TULUWs/w7HLtkrnd5U=;
        b=d69DI+SP1o4a1gtamPMs69u7EkCB/INyiaUjNzB6851Tf1YwNsspN+1RTLBG9ceosj
         2ISNDgPE9s0tecVocwwjXQsgoW01VW+GGthQ9rzpt7XBqsMg/Djvy125fGqb9NxKttwB
         ta4wKOptP6pfjqMh37Z9RWBwVL6x8CJbgePofunR2M7PTW4x12s3guSno3ZouckD/boK
         F8g5DDNnWukqchVNh3w90UKcGGqUeMynNpOjsgFRCZCHshTBylRidNJaA/3f1daDKftU
         662nxfISMabKKlxcj4fVIyo7bFoTOqYsb99sBcvge11BxN3hlY3qowsa5J56yNw9v6Jq
         /klA==
X-Gm-Message-State: AOAM532S+VTznrQrzrqu/oppG5mo98kUGn5c4G0XPgfixJTnxlLCahGy
        jMBrk7SdizqxevM22e/tRFdlbVNOT3zZjoJr5HeCwJ7dT/gZV2cLg9pLsAsRy9QFunaV+2BcSYo
        PsmK+ndp8QP10NNkvHdPsR78s
X-Received: by 2002:a05:600c:3494:: with SMTP id a20mr5797691wmq.195.1638285185127;
        Tue, 30 Nov 2021 07:13:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzceMntcyceYvwJ8AOOl9ktzvLwje1o6ZUj2kckEPshPvcbMoDQcYIhfom6M32kPdfQm8C8oA==
X-Received: by 2002:a05:600c:3494:: with SMTP id a20mr5797664wmq.195.1638285184929;
        Tue, 30 Nov 2021 07:13:04 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id f7sm20308962wri.74.2021.11.30.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:13:04 -0800 (PST)
Message-ID: <3b724a158fa51283f60185fbf65087fc9000dcce.camel@redhat.com>
Subject: Re: Question WRT early IRQ/NMI entry code
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>
Date:   Tue, 30 Nov 2021 16:13:00 +0100
In-Reply-To: <875ys9dacq.ffs@tglx>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
         <875ys9dacq.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 14:47 +0100, Thomas Gleixner wrote:
> On Tue, Nov 30 2021 at 12:28, Nicolas Saenz Julienne wrote:
> > while going over the IRQ/NMI entry code I've found a small 'inconsistency':
> > while in the IRQ entry path, we inform RCU of the context change *before*
> > incrementing the preempt counter, the opposite happens for the NMI entry
> > path. This applies to both arm64 and x86[1].
> > 
> > Actually, rcu_nmi_enter() — which is also the main RCU context switch function
> > for the IRQ entry path — uses the preempt counter to verify it's not in NMI
> > context. So it would make sense to assume all callers have the same updated
> > view of the preempt count, which isn't true ATM.
> > 
> > I'm sure there an obscure/non-obvious reason for this, right?
> 
> There is.
> 
> > IRQ path:
> >   -> x86_64 asm (entry_64.S)
> >   -> irqentry_enter() -> rcu_irq_enter() -> *rcu_nmi_enter()*
> >   -> run_irq_on_irqstack_cond() -> irq_exit_rcu() -> *preempt_count_add(HARDIRQ_OFFSET)*
> >   -> // Run IRQ...
> > 
> > NMI path:
> >   -> x86_64 asm (entry_64.S)
> >   -> irqentry_nmi_enter() -> __nmi_enter() -> *__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET)*
> >                           -> *rcu_nmi_enter()*
> 
> The reason is symmetry vs. returning from interupt / exception:
> 
>  irqentry_enter()
>       exit_rcu = false;
> 
>       if (user_mode(regs)) {
>           irqentry_enter_from_user_mode(regs)
>             __enter_from_user_mode(regs)
>               user_exit_irqoff();       <- RCU handling for NOHZ full
> 
>       } else if (is_idle_task_current()) {
>             rcu_irq_enter()
>             exit_rcu = true;
>       }
> 
>  irq_enter_rcu()
>      __irq_enter_raw()
>      preempt_count_add(HARDIRQ_OFFSET);
> 
>  irq_handler()
> 
>  irq_exit_rcu()
>      preempt_count_sub(HARDIRQ_OFFSET);
>      if (!in_interrupt() && local_softirq_pending())
>      	 invoke_softirq();
> 
>  irqentry_exit(regs, exit_rcu)
> 
>      if (user_mode(regs)) {
>          irqentry_exit_to_usermode(regs)
>            user_enter_irqoff();     <- RCU handling for NOHZ full
>      } else if (irqs_enabled(regs)) {
>            if (exit_rcu) {          <- Idle task special case
>                rcu_irq_exit();
>            } else {
>               irqentry_exit_cond_resched();
>            }
> 
>      } else if (exit_rcu) {
>          rcu_irq_exit();
>      }
> 
> On return from interrupt HARDIRQ_OFFSET has to be removed _before_
> handling soft interrupts. It's also required that the preempt count has
> the original state _before_ reaching irqentry_exit() which
> might schedule if the interrupt/exception hit user space or kernel space
> with interrupts enabled.
> 
> So doing it symmetric makes sense.
> 
> For NMIs the above conditionals do not apply at all and we just do
> 
>     __nmi_enter()
>         preempt_count_add(NMI_COUNT + HARDIRQ_COUNT);
>     rcu_nmi_enter();
> 
>     handle_nmi();
> 
>     rcu_nmi_exit();
>     __nmi_exit()
>         preempt_count_sub(NMI_COUNT + HARDIRQ_COUNT);
> 
> The reason why preempt count is incremented before invoking
> rcu_nmi_enter() is simply that RCU has to know about being in NMI
> context, i.e. in_nmi() has to return the correct answer.
> 
> Thanks,

Thanks Thomas!

-- 
Nicolás Sáenz

