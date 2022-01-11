Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624DB48B3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbiAKR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:28:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36690 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbiAKR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:28:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60B0421763;
        Tue, 11 Jan 2022 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641922130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jc+f3cdhEyzSdxRIqkk6GE0n+MAVJ8bj27A6pGukZ54=;
        b=O2/NbSBftvI0XF+/PidP0B+6+dyWth8akJeFtzj/WJbO2nriyvufXpXRLLWrFAwNRC8Y5i
        QrmUOW8UEYyE5IoQB5CjI7a31u5DttDrbDmVSrSkU2auUIHFj3nFa+sQk6nz7vhJ4tyjOL
        rQUI6s2Ejr9QEfev6SN1qnVmdE2zNJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641922130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jc+f3cdhEyzSdxRIqkk6GE0n+MAVJ8bj27A6pGukZ54=;
        b=xUSdpmdx+gjvclnmlxYFspsY2CQKFF7BKdvM7+Y9dF3qsCsVqvF7jc6nedbrWV2B9kKXc1
        b9mvfg8k0DVBjXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 459EE13AE7;
        Tue, 11 Jan 2022 17:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RwKMD1K+3WFTUQAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 11 Jan 2022 17:28:50 +0000
Date:   Tue, 11 Jan 2022 18:28:58 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/core for v5.17
Message-ID: <Yd2+Wqrl0ax2JQjg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the perf/core pile for v5.17 which deals with the perf <-> kvm
side of things this time around.

Thx.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_core_for_v5.17_rc1

for you to fetch changes up to a9f4a6e92b3b319296fb078da2615f618f6cd80c:

  perf: Drop guest callback (un)register stubs (2021-11-17 14:49:12 +0100)

----------------------------------------------------------------
Peter Zijlstra says:

"Cleanup of the perf/kvm interaction."

----------------------------------------------------------------
Like Xu (1):
      perf/core: Rework guest callbacks to prepare for static_call support

Sean Christopherson (16):
      perf: Protect perf_guest_cbs with RCU
      KVM: x86: Register perf callbacks after calling vendor's hardware_setup()
      KVM: x86: Register Processor Trace interrupt hook iff PT enabled in guest
      perf: Stop pretending that perf can handle multiple guest callbacks
      perf: Drop dead and useless guest "support" from arm, csky, nds32 and riscv
      perf: Add wrappers for invoking guest callbacks
      perf: Force architectures to opt-in to guest callbacks
      perf/core: Use static_call to optimize perf_guest_info_callbacks
      KVM: x86: Drop current_vcpu for kvm_running_vcpu + kvm_arch_vcpu variable
      KVM: x86: More precisely identify NMI from guest when handling PMI
      KVM: Move x86's perf guest info callbacks to generic KVM
      KVM: x86: Move Intel Processor Trace interrupt handler to vmx.c
      KVM: arm64: Convert to the generic perf callbacks
      KVM: arm64: Hide kvm_arm_pmu_available behind CONFIG_HW_PERF_EVENTS=y
      KVM: arm64: Drop perf.c and fold its tiny bits of code into arm.c
      perf: Drop guest callback (un)register stubs

 arch/arm/kernel/perf_callchain.c   | 28 +++---------------
 arch/arm64/include/asm/kvm_host.h  | 11 +++++--
 arch/arm64/kernel/image-vars.h     |  2 ++
 arch/arm64/kernel/perf_callchain.c | 13 +++++----
 arch/arm64/kvm/Kconfig             |  1 +
 arch/arm64/kvm/Makefile            |  2 +-
 arch/arm64/kvm/arm.c               | 10 +++++--
 arch/arm64/kvm/perf.c              | 59 --------------------------------------
 arch/arm64/kvm/pmu-emul.c          |  2 ++
 arch/csky/kernel/perf_callchain.c  | 10 -------
 arch/nds32/kernel/perf_event_cpu.c | 29 +++----------------
 arch/riscv/kernel/perf_callchain.c | 10 -------
 arch/x86/events/core.c             | 13 +++++----
 arch/x86/events/intel/core.c       |  5 +---
 arch/x86/include/asm/kvm_host.h    |  7 +++--
 arch/x86/kvm/Kconfig               |  1 +
 arch/x86/kvm/pmu.c                 |  2 +-
 arch/x86/kvm/svm/svm.c             |  2 +-
 arch/x86/kvm/vmx/vmx.c             | 25 +++++++++++++++-
 arch/x86/kvm/x86.c                 | 58 +++++++------------------------------
 arch/x86/kvm/x86.h                 | 17 ++++++++---
 arch/x86/xen/Kconfig               |  1 +
 arch/x86/xen/pmu.c                 | 32 +++++++++------------
 include/kvm/arm_pmu.h              | 19 +++++++-----
 include/linux/kvm_host.h           | 10 +++++++
 include/linux/perf_event.h         | 44 ++++++++++++++++++++--------
 init/Kconfig                       |  4 +++
 kernel/events/core.c               | 41 ++++++++++++++++++--------
 virt/kvm/kvm_main.c                | 44 ++++++++++++++++++++++++++++
 29 files changed, 246 insertions(+), 256 deletions(-)
 delete mode 100644 arch/arm64/kvm/perf.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
