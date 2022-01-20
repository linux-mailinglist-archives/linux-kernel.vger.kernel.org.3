Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE8494F11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiATNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:33:49 -0500
Received: from foss.arm.com ([217.140.110.172]:38304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbiATNdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:33:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2391B1FB;
        Thu, 20 Jan 2022 05:33:47 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4B873F774;
        Thu, 20 Jan 2022 05:33:41 -0800 (PST)
Date:   Thu, 20 Jan 2022 13:33:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: Re: [PATCH v2 4/7] kvm/mips: rework guest entry logic
Message-ID: <20220120133322.GA13904@C02TD0UTHF1T.local>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-5-mark.rutland@arm.com>
 <cbb6a332-f230-ff5e-ce64-5dbbd6df02b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbb6a332-f230-ff5e-ce64-5dbbd6df02b5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:10:22PM +0100, Paolo Bonzini wrote:
> On 1/19/22 11:58, Mark Rutland wrote:
> > +	 * TODO: is there a barrier which ensures that pending interrupts are
> > +	 * recognised? Currently this just hopes that the CPU takes any pending
> > +	 * interrupts between the enable and disable.
> > +	 */
> > +	local_irq_enable();
> > +	local_irq_disable();
> 
> It's okay, there is irq_enable_hazard() but it's automatically included in
> arch_local_irq_enable().

As with the riscv case, I'm not sure whether that ensures that a pending
IRQ is actually recognized and taken.

Since there's also an irq_disable_hazard() it looks like that's there to
ensure the IRQ mask is updated in program order, rather than
guaranteeing that a pending IRQ is necessarily taken while IRQs are
unmasked.

In practice, I suspect it probably does, but it'd be good if someone
from the MIPS side could say something either way.

Thanks,
Mark.
