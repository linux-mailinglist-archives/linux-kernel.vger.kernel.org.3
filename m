Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB8478D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhLQOPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:15:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234148AbhLQOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639750533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ohkHIXbcCmEoZRJLeZUjZIF9jP1Brmddy61OPwOb80=;
        b=dJ4MVPCgBqQRi8XLU/hNxpIhKXluP+1ucjJps/8oI4TA152smLEppxFahhfqn7PbGLRYvm
        0EyoCgLDi22vK4QxxamIxnwyRFkeBmnLvDPJnJJoHcGowZGJXJ3hAuNnjW/ueSR7QVVjnT
        RjbYvqaxHeF3GQ0bvSKW5Ls8YV0Lp6c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-Is-ZLqUqMd68hIEGfcUTCQ-1; Fri, 17 Dec 2021 09:15:31 -0500
X-MC-Unique: Is-ZLqUqMd68hIEGfcUTCQ-1
Received: by mail-wm1-f72.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so1104159wms.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 06:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8ohkHIXbcCmEoZRJLeZUjZIF9jP1Brmddy61OPwOb80=;
        b=wZ4z7GgjdjBoMmdjPifpVc23JKW6KjTFuXQvUgYxe7encS4uM0QT6bLTu/orH3Nppv
         vfbGRfmLDnQT1nKrxyp3qJswZ8kk35YECM0xoTygjSU2MHQE9nmcWcr85LNT5LDINiJ2
         c+QBglhGS4BB8VTZ7lSNCUmmYEM00wqdzRr1XIyGZ9vpFq6QocWtZNwWgC3YGYN1rjfd
         q9myI9JNHqIbVHVgCC6MkH0D2cpxdYwbPZ2EPTZBrvDV8nTIqzVZiD3ZH7+z80ZOE/yj
         FLsIwGyVJPkt3lenJ73ogCBbedXLnnWWnHG0h62RkEJIg4qMdMnrwO9nuOZLFGFCFor8
         fhFA==
X-Gm-Message-State: AOAM530iycr4otHUtb6b+F1ffPUr58at7vdbjw9jb7dNsDjoHD3NTTPg
        Xz6g5tWyjc+OzfaudX9BuDXyTyHGr8wDBdi/6wu0IwoJEMK9pzdb107nUFFmWiNExLUToksoGhI
        kZemahZi5AKf94fxJe9CtuwqV
X-Received: by 2002:a5d:6d41:: with SMTP id k1mr2755368wri.134.1639750530462;
        Fri, 17 Dec 2021 06:15:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+5OK+wHJ+oNtmr4sqDbaf0TDCwcL3mgQ2Qu1ZhPUKAGIgzAQyZaO0vxFPOl7tahX2YBbx5w==
X-Received: by 2002:a5d:6d41:: with SMTP id k1mr2755351wri.134.1639750530277;
        Fri, 17 Dec 2021 06:15:30 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3511:9200:f938:102b:34c2:d5db? ([2a0c:5a80:3511:9200:f938:102b:34c2:d5db])
        by smtp.gmail.com with ESMTPSA id m20sm11441371wmq.11.2021.12.17.06.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 06:15:30 -0800 (PST)
Message-ID: <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     maz <maz@kernel.org>, Will Deacon <will@kernel.org>,
        paulmck <paulmck@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        frederic <frederic@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Dec 2021 15:15:29 +0100
In-Reply-To: <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
         <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-17 at 13:21 +0000, Mark Rutland wrote:
> On Fri, Dec 17, 2021 at 12:51:57PM +0100, Nicolas Saenz Julienne wrote:
> > Hi All,
> 
> Hi,
> 
> > arm64's guest entry code does the following:
> > 
> > int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > {
> > 	[...]
> > 
> > 	guest_enter_irqoff();
> > 
> > 	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
> > 
> > 	[...]
> > 
> > 	local_irq_enable();
> > 
> > 	/*
> > 	 * We do local_irq_enable() before calling guest_exit() so
> > 	 * that if a timer interrupt hits while running the guest we
> > 	 * account that tick as being spent in the guest.  We enable
> > 	 * preemption after calling guest_exit() so that if we get
> > 	 * preempted we make sure ticks after that is not counted as
> > 	 * guest time.
> > 	 */
> > 	guest_exit();
> > 	[...]
> > }
> > 
> > 
> > On a nohz-full CPU, guest_{enter,exit}() delimit an RCU extended quiescent
> > state (EQS). Any interrupt happening between local_irq_enable() and
> > guest_exit() should disable that EQS. Now, AFAICT all el0 interrupt handlers
> > do the right thing if trggered in this context, but el1's won't. Is it
> > possible to hit an el1 handler (for example __el1_irq()) there?
> 
> I think you're right that the EL1 handlers can trigger here and won't exit the
> EQS.
> 
> I'm not immediately sure what we *should* do here. What does x86 do for an IRQ
> taken from a guest mode? I couldn't spot any handling of that case, but I'm not
> familiar enough with the x86 exception model to know if I'm looking in the
> right place.

Well x86 has its own private KVM guest context exit function
'kvm_guest_exit_irqoff()', which allows it to do the right thing (simplifying
things):

	local_irq_disable();
	kvm_guest_enter_irqoff() // Inform CT, enter EQS
	__vmx_kvm_run()
	kvm_guest_exit_irqoff() // Inform CT, exit EQS, task still marked with PF_VCPU

	/*
	 * Consume any pending interrupts, including the possible source of
	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
	 * An instruction is required after local_irq_enable() to fully unblock
	 * interrupts on processors that implement an interrupt shadow, the
	 * stat.exits increment will do nicely.
	 */
	local_irq_enable();
	++vcpu->stat.exits;
	local_irq_disable();

	/*
	 * Wait until after servicing IRQs to account guest time so that any
	 * ticks that occurred while running the guest are properly accounted
	 * to the guest.  Waiting until IRQs are enabled degrades the accuracy
	 * of accounting via context tracking, but the loss of accuracy is
	 * acceptable for all known use cases.
	 */
	vtime_account_guest_exit(); // current->flags &= ~PF_VCPU

So I guess we should convert to x86's scheme, and maybe create another generic
guest_{enter,exit}() flavor for virtualization schemes that run with interrupts
disabled.

> Note that the EL0 handlers *cannot* trigger for an exception taken from a
> guest. We use separate vectors while running a guest (for both VHE and nVHE
> modes), and from the main kernel's PoV we return from kvm_call_hyp_ret(). We
> can ony take IRQ from EL1 *after* that returns.
> 
> We *might* need to audit the KVM vector handlers to make sure they're not
> dependent on RCU protection (I assume they're not, but it's possible something
> has leaked into the VHE code).

IIUC in the window between local_irq_enable() and guest_exit() any driver
interrupt might trigger, isn't it?

Regards,

-- 
Nicolás Sáenz

