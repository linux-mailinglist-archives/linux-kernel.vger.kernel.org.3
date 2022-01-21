Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB790495F36
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380454AbiAUMo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:44:26 -0500
Received: from foss.arm.com ([217.140.110.172]:51012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380431AbiAUMoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:44:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 196AA1FB;
        Fri, 21 Jan 2022 04:44:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB1F53F766;
        Fri, 21 Jan 2022 04:44:12 -0800 (PST)
Date:   Fri, 21 Jan 2022 12:44:05 +0000
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
Message-ID: <Yeqqle7lERyreSLi@FVFF77S0Q05N>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-5-mark.rutland@arm.com>
 <20220120164455.GA15464@C02TD0UTHF1T.local>
 <a2b628b4-907c-4e15-df91-18c0db099228@redhat.com>
 <20220120171551.GB15464@C02TD0UTHF1T.local>
 <f7413789-f6f2-612e-2323-bf35afdb8a02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7413789-f6f2-612e-2323-bf35afdb8a02@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:29:25PM +0100, Paolo Bonzini wrote:
> On 1/20/22 18:15, Mark Rutland wrote:
> > As above, we'll also need the guest_state_{enter,exit}() calls
> > surrounding this (e.g. before that local_irq_enable() at the start of
> > kvm_mips_handle_exit(),
> 
> Oh, indeed.  And there is also an interrupt-enabled area similar to s390's,
> in both vcpu_run and the exception handler entry point (which falls through
> to the exit handler created by kvm_mips_build_exit).  For example:
> 
>         /* Setup status register for running guest in UM */
>         uasm_i_ori(&p, V1, V1, ST0_EXL | KSU_USER | ST0_IE);
>         UASM_i_LA(&p, AT, ~(ST0_CU0 | ST0_MX | ST0_SX | ST0_UX));
>         uasm_i_and(&p, V1, V1, AT);
>         uasm_i_mtc0(&p, V1, C0_STATUS);
>         uasm_i_ehb(&p);
> 
> I'd rather get rid altogether of the EQS for MIPS.

Ok; I'm not immediately sure how to do that without invasive changes around the
context tracking bits.

Did you have a specific approach in mind, or was that just a general statement?

> > and that needs to happen in noinstr code, etc.
> 
> There are bigger problems with instrumentation, because the
> runtime-generated code as far as I can tell is not noinstr.

The generated sequences themselves are not a problem -- they're not
compiler-instrumented, and kprobes will reject them since they live in a
kzalloc()'d buffer which is outside of kernel text.

Those call tlbmiss_handler_setup_pgd(), but that itself is runtime-generated,
and AFAICT doesn't call anything. It is placed within the kernel text, but it
could be blacklisted from kprobes.

Have I missed something there?

Thanks,
Mark.
