Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36297494E73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiATM4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:56:55 -0500
Received: from foss.arm.com ([217.140.110.172]:37156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239164AbiATM4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:56:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64AD11FB;
        Thu, 20 Jan 2022 04:56:50 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 151BC3F774;
        Thu, 20 Jan 2022 04:56:44 -0800 (PST)
Date:   Thu, 20 Jan 2022 12:56:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: Re: [PATCH v2 5/7] kvm/riscv: rework guest entry logic
Message-ID: <YelcA/jl6YEfk7m4@FVFF77S0Q05N>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-6-mark.rutland@arm.com>
 <771780a3-39a7-f87e-4b5b-45cf95b3896a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771780a3-39a7-f87e-4b5b-45cf95b3896a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:18:04PM +0100, Paolo Bonzini wrote:
> On 1/19/22 11:58, Mark Rutland wrote:
> > +		 * There's no barrier which ensures that pending interrupts are
> > +		 * recognised, so we just hope that the CPU takes any pending
> > +		 * interrupts between the enable and disable.
> >   		 */
> >   		local_irq_enable();
> > +		local_irq_disable();
> 
> This should be the required architectural behavior: "a CSR access is
> performed after the execution of any prior instructions in program order
> whose behavior modifies or is modified by the CSR state and before the
> execution of any subsequent instructions in program order whose behavior
> modifies or is modified by the CSR state" (Zicsr spec, paragraph "CSR Access
> Ordering", available at
> https://www.five-embeddev.com/riscv-isa-manual/latest/csr.html#csrinsts).

I think that's necessary, but not sufficient.

IIUC that wording means that writes to the CSR state occur in program order
without requiring additional barriers to take effect. The current value of the
CSR determines whether interrupts *can* be taken, but that doesn't say that
pending interrrupts *must* be taken immediately when unmasked in the CSR.

For comparison, ARMv8 has similar wording that writes to PSTATE.I via the
DAIF/DAIFSet/DAIFClr registers occur in program order and do not require
additional barriers. However, there's also wording that to ensure that a
pending interrupt is taken, a context-synchronization-event (e.g. an ISB
instruction) is necessary. Without that, a back-to-back enable->disable will
not necessarily result in a pending interrupt being taken.

The arm64 patch in this series has references to the documentation.

I had asked Palmer about this on IRC, and he didn't seem to think the
architecture mandated this (or at least, was unsure).

Palmer, thoughts?

Thanks,
Mark.
