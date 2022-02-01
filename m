Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E550D4A614D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbiBAQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:22:50 -0500
Received: from foss.arm.com ([217.140.110.172]:50024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241080AbiBAQWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:22:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83D4D113E;
        Tue,  1 Feb 2022 08:22:44 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.8.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AA4F3F40C;
        Tue,  1 Feb 2022 08:22:39 -0800 (PST)
Date:   Tue, 1 Feb 2022 16:22:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org,
        benh@kernel.crashing.org, borntraeger@linux.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paulus@samba.org, paul.walmsley@sifive.com,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: Re: [PATCH v3 0/5] kvm: fix latent guest entry/exit bugs
Message-ID: <YfleTYWIW1sBbMNn@FVFF77S0Q05N>
References: <20220201132926.3301912-1-mark.rutland@arm.com>
 <87aa8af0-c262-ad04-58f8-da6c7882e23c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87aa8af0-c262-ad04-58f8-da6c7882e23c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 04:59:47PM +0100, Paolo Bonzini wrote:
> On 2/1/22 14:29, Mark Rutland wrote:
> > I've pushed the series (based on v5.17-rc2) to my kvm/entry-rework branch:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kvm/entry-rework
> >    git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git kvm/entry-rework
> 
> Thanks!  I cherry-picked the basic, x86 and mips patches to kvm.git's master
> branch (I did not use your branch in order to leave arm64 and riscv to the
> respective maintainers).

Since everything's dependent upon that core patch, IIUC that's going to make it
a pain for them to queue things.

How are you expecting the arm64 and riscv maintainers to queue things? Queue
their own copies of that core patch?

Thanks,
Mark.

> Paolo
> 
> > This version of the series is tagged as kvm-entry-rework-20220201.
> > 
> > [1] https://lore.kernel.org/r/20220111153539.2532246-1-mark.rutland@arm.com/
> > [2] https://lore.kernel.org/r/20220119105854.3160683-1-mark.rutland@arm.com/
> > 
> > Thanks,
> > 
> > 
> > Mark Rutland (5):
> >    kvm: add guest_state_{enter,exit}_irqoff()
> >    kvm/arm64: rework guest entry logic
> >    kvm/x86: rework guest entry logic
> >    kvm/riscv: rework guest entry logic
> >    kvm/mips: rework guest entry logic
> > 
> >   arch/arm64/kvm/arm.c     |  51 +++++++++++-------
> >   arch/mips/kvm/mips.c     |  50 +++++++++++++++--
> >   arch/riscv/kvm/vcpu.c    |  44 +++++++++------
> >   arch/x86/kvm/svm/svm.c   |   4 +-
> >   arch/x86/kvm/vmx/vmx.c   |   4 +-
> >   arch/x86/kvm/x86.c       |   4 +-
> >   arch/x86/kvm/x86.h       |  45 ----------------
> >   include/linux/kvm_host.h | 112 +++++++++++++++++++++++++++++++++++++--
> >   8 files changed, 222 insertions(+), 92 deletions(-)
> > 
> 
