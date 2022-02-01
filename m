Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BB4A5D72
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiBAN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:29:39 -0500
Received: from foss.arm.com ([217.140.110.172]:40082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233257AbiBAN3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:29:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D9D0113E;
        Tue,  1 Feb 2022 05:29:38 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DB5E3F73B;
        Tue,  1 Feb 2022 05:29:34 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        benh@kernel.crashing.org, borntraeger@linux.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, mark.rutland@arm.com, maz@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, nsaenzju@redhat.com,
        palmer@dabbelt.com, paulmck@kernel.org, paulus@samba.org,
        paul.walmsley@sifive.com, pbonzini@redhat.com, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: [PATCH v3 0/5] kvm: fix latent guest entry/exit bugs
Date:   Tue,  1 Feb 2022 13:29:21 +0000
Message-Id: <20220201132926.3301912-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several architectures have latent bugs around guest entry/exit,
including:

1) Enabling interrupts during an RCU EQS, allowing interrupt handlers to
   run without RCU watching.

2) Using (potentially) instrumented code between guest_enter() and
   guest_exit(), allowing instrumentation handlers to run without RCU
   watching.

3) Not informing lockdep and tracing about interrupt masking, or
   informing in an incorrect order (e.g. relative to entering/exiting an
   RCU EQS).

4) Unbalanced entry/exit accounting in some cases (which may or may not
   result in functional problems).

Overall, the architectures affected are:

  arm64, mips, powerpc, riscv, s390, x86

This series reworks the common code to make handling these issues
earier, and for the following architectures fixes those issues by
conversion to new helper functions:

  arm64, mips, riscv, x86

The core, arm64, and x86 patches have reviews from the relevant
maintainers, and I think those are good-to-go. I have not yet had
acks/reviews for the mips and riscv patches. I'm fairly certain the
riscv patch is correct by virtue of it being so simple, and I'm
relatively confident that the mips patch is correct (though I may have
missed additional issues), but I have no way of testing either so I've
placed them at the end of the series where they can easily be dropped if
necessary.

This series does NOT fix the following architectures, which will need
more substantial changes to architecture-specific entry logic and/or
sequencing:

  powerpc, s390

... and I assume it would be preferable to fix the common code and
simple cases now, such that those can be addressed in subsequent
follow-ups.

Since v1 [1]:
* Add arch_in_rcu_eqs()
* Convert s390
* Rename exit_to_guest_mode() -> guest_state_enter_irqoff()
* Rename enter_from_guest_mode() -> guest_state_exit_irqoff()
* Various commit message cleanups

Since v2 [2]:
* Rebase to v5.17-rc2
* Fixup mips exit handling
* Drop arch_in_rcu_eqs() & s390 patches

I've pushed the series (based on v5.17-rc2) to my kvm/entry-rework branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kvm/entry-rework
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git kvm/entry-rework

This version of the series is tagged as kvm-entry-rework-20220201.

[1] https://lore.kernel.org/r/20220111153539.2532246-1-mark.rutland@arm.com/
[2] https://lore.kernel.org/r/20220119105854.3160683-1-mark.rutland@arm.com/

Thanks,


Mark Rutland (5):
  kvm: add guest_state_{enter,exit}_irqoff()
  kvm/arm64: rework guest entry logic
  kvm/x86: rework guest entry logic
  kvm/riscv: rework guest entry logic
  kvm/mips: rework guest entry logic

 arch/arm64/kvm/arm.c     |  51 +++++++++++-------
 arch/mips/kvm/mips.c     |  50 +++++++++++++++--
 arch/riscv/kvm/vcpu.c    |  44 +++++++++------
 arch/x86/kvm/svm/svm.c   |   4 +-
 arch/x86/kvm/vmx/vmx.c   |   4 +-
 arch/x86/kvm/x86.c       |   4 +-
 arch/x86/kvm/x86.h       |  45 ----------------
 include/linux/kvm_host.h | 112 +++++++++++++++++++++++++++++++++++++--
 8 files changed, 222 insertions(+), 92 deletions(-)

-- 
2.30.2

