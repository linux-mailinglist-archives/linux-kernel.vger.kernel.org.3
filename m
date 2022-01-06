Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41B486A33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiAFSzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:55:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45984 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbiAFSzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:55:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C03561DC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB2DC36AEB;
        Thu,  6 Jan 2022 18:55:03 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.17
Date:   Thu,  6 Jan 2022 18:55:01 +0000
Message-Id: <20220106185501.1480075-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates for 5.17. A patch from Peter Z making
ARCH_STACKWALK independent of STACKTRACE touches x86, s390 and riscv.
The perf changes also touch kernel/events/core.c and arch/x86/events/.

I generated the diffstat manually by merging against current mainline
(75acfdb6fd92), otherwise it's all over the place since I had to merge
the arm64 for-next/fixes (based on -rc1) for a BTI fix dependency into
for-next/core (based on -rc3).

Thanks,
Catalin

The following changes since commit 35b6b28e69985eafb20b3b2c7bd6eca452b56b53:

  arm64: ftrace: add missing BTIs (2021-12-02 10:18:32 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 945409a6ef442cfe5f2f14e5626d4306d53100f0:

  Merge branches 'for-next/misc', 'for-next/cache-ops-dzp', 'for-next/stacktrace', 'for-next/xor-neon', 'for-next/kasan', 'for-next/armv8_7-fp', 'for-next/atomics', 'for-next/bti', 'for-next/sve', 'for-next/kselftest' and 'for-next/kcsan', remote-tracking branch 'arm64/for-next/perf' into for-next/core (2022-01-05 18:14:32 +0000)

----------------------------------------------------------------
arm64 updates for 5.17:

- KCSAN enabled for arm64.

- Additional kselftests to exercise the syscall ABI w.r.t. SVE/FPSIMD.

- Some more SVE clean-ups and refactoring in preparation for SME support
  (scalable matrix extensions).

- BTI clean-ups (SYM_FUNC macros etc.)

- arm64 atomics clean-up and codegen improvements.

- HWCAPs for FEAT_AFP (alternate floating point behaviour) and
  FEAT_RPRESS (increased precision of reciprocal estimate and reciprocal
  square root estimate).

- Use SHA3 instructions to speed-up XOR.

- arm64 unwind code refactoring/unification.

- Avoid DC (data cache maintenance) instructions when DCZID_EL0.DZP == 1
  (potentially set by a hypervisor; user-space already does this).

- Perf updates for arm64: support for CI-700, HiSilicon PCIe PMU,
  Marvell CN10K LLC-TAD PMU, miscellaneous clean-ups.

- Other fixes and clean-ups; highlights: fix the handling of erratum
  1418040, correct the calculation of the nomap region boundaries,
  introduce io_stop_wc() mapped to the new DGH instruction (data
  gathering hint).

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/xor: use EOR3 instructions when available

Bhaskara Budiredla (2):
      drivers: perf: Add LLC-TAD perf counter support
      dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings

Catalin Marinas (3):
      Merge 'arm64/for-next/fixes' into for-next/bti
      arm64: Ensure that the 'bti' macro is defined where linkage.h is included
      Merge branches 'for-next/misc', 'for-next/cache-ops-dzp', 'for-next/stacktrace', 'for-next/xor-neon', 'for-next/kasan', 'for-next/armv8_7-fp', 'for-next/atomics', 'for-next/bti', 'for-next/sve', 'for-next/kselftest' and 'for-next/kcsan', remote-tracking branch 'arm64/for-next/perf' into for-next/core

D Scott Phillips (1):
      arm64: errata: Fix exec handling in erratum 1418040 workaround

Dan Carpenter (1):
      drivers: perf: marvell_cn10k: fix an IS_ERR() vs NULL check

Florian Fainelli (1):
      arm64: entry: Use SDEI event constants

Guilherme G. Piccoli (1):
      arm64: Unhash early pointer print plus improve comment

Huacai Chen (1):
      arm64: Use correct method to calculate nomap region boundaries

Jean-Philippe Brucker (2):
      dt-bindings: Add Arm SMMUv3 PMCG binding
      perf/smmuv3: Add devicetree support

Jisheng Zhang (1):
      arm64: extable: remove unused ex_handler_t definition

Joey Gouly (3):
      arm64: cpufeature: add HWCAP for FEAT_AFP
      arm64: add ID_AA64ISAR2_EL1 sys register
      arm64: cpufeature: add HWCAP for FEAT_RPRES

Kees Cook (1):
      arm64: Drop outdated links in comments

Kefeng Wang (1):
      arm64: Enable KCSAN

Madhavan T. Venkataraman (5):
      arm64: Make perf_callchain_kernel() use arch_stack_walk()
      arm64: Make __get_wchan() use arch_stack_walk()
      arm64: Make return_address() use arch_stack_walk()
      arm64: Make profile_pc() use arch_stack_walk()
      arm64: Make dump_backtrace() use arch_stack_walk()

Mark Brown (12):
      arm64/kvm: Fix bitrotted comment for SVE handling in handle_exit.c
      arm64: Add macro version of the BTI instruction
      arm64: Unconditionally override SYM_FUNC macros
      arm64: Use BTI C directly and unconditionally
      arm64/sve: Make sysctl interface for SVE reusable by SME
      arm64/sve: Generalise vector length configuration prctl() for SME
      arm64/sve: Minor clarification of ABI documentation
      kselftest/arm64: Parameterise ptrace vector length information
      kselftest/arm64: Allow signal tests to trigger from a function
      kselftest/arm64: Add a test program to exercise the syscall ABI
      arm64/fp: Add comments documenting the usage of state restore functions
      kselftest/arm64: Add pidbench for floating point syscall cases

Mark Rutland (11):
      arm64: Add comment for stack_info::kr_cur
      arm64: Mark __switch_to() as __sched
      arm64: Make some stacktrace functions private
      arm64: mm: use die_kernel_fault() in do_mem_abort()
      arm64: mm: log potential KASAN shadow alias
      arm64: atomics: format whitespace consistently
      arm64: atomics lse: define SUBs in terms of ADDs
      arm64: atomics: lse: define ANDs in terms of ANDNOTs
      arm64: atomics: lse: improve constraints for simple ops
      arm64: atomics: lse: define RETURN ops in terms of FETCH ops
      arm64: remove __dma_*_area() aliases

Peter Zijlstra (1):
      arch: Make ARCH_STACKWALK independent of STACKTRACE

Qi Liu (2):
      docs: perf: Add description for HiSilicon PCIe PMU driver
      drivers/perf: hisi: Add driver for HiSilicon PCIe PMU

Raphael Gault (1):
      Documentation: arm64: Document PMU counters access from userspace

Reiji Watanabe (2):
      arm64: clear_page() shouldn't use DC ZVA when DCZID_EL0.DZP == 1
      arm64: mte: DC {GVA,GZVA} shouldn't be used when DCZID_EL0.DZP == 1

Rob Herring (5):
      arm64: Simplify checking for populated DT
      x86: perf: Move RDPMC event flag to a common definition
      perf: Add a counter for number of user access events in context
      arm64: perf: Add userspace counter access disable switch
      arm64: perf: Enable PMU counter userspace access for perf event

Robin Murphy (17):
      perf/arm-cmn: Fix CPU hotplug unregistration
      perf/arm-cmn: Account for NUMA affinity
      perf/arm-cmn: Drop compile-test restriction
      perf/arm-cmn: Refactor node ID handling
      perf/arm-cmn: Streamline node iteration
      perf/arm-cmn: Refactor DTM handling
      perf/arm-cmn: Optimise DTM counter reads
      perf/arm-cmn: Optimise DTC counter accesses
      perf/arm-cmn: Move group validation data off-stack
      perf/arm-cmn: Demarcate CMN-600 specifics
      perf/arm-cmn: Support new IP features
      dt-bindings: perf: arm-cmn: Add CI-700
      perf/arm-cmn: Add CI-700 Support
      perf/arm-cmn: Add debugfs topology info
      perf/smmuv3: Synthesize IIDR from CoreSight ID registers
      arm64: perf: Simplify registration boilerplate
      arm64: perf: Support new DT compatibles

Rongwei Wang (1):
      arm64: kexec: reduce calls to page_address()

Thierry Reding (1):
      arm64: perf: Support Denver and Carmel PMUs

Will Deacon (8):
      Merge branch 'for-next/perf-cmn' into for-next/perf
      Merge branch 'for-next/perf-cn10k' into for-next/perf
      Merge branch 'for-next/perf-hisi' into for-next/perf
      Merge branch 'for-next/perf-smmu' into for-next/perf
      Merge branch 'for-next/perf-user-counter-access' into for-next/perf
      Merge branch 'for-next/perf-cpu' into for-next/perf
      perf/smmuv3: Fix unused variable warning when CONFIG_OF=n
      arm64: perf: Don't register user access sysctl handler multiple times

Xiongfeng Wang (1):
      asm-generic: introduce io_stop_wc() and add implementation for ARM64

Yanteng Si (1):
      docs/arm64: delete a space from tagged-address-abi

Yunfeng Ye (2):
      arm64: mm: Rename asid2idx() to ctxid2asid()
      arm64: mm: Use asid feature macro for cheanup

 Documentation/admin-guide/perf/hisi-pcie-pmu.rst   |  106 ++
 Documentation/admin-guide/sysctl/kernel.rst        |   11 +
 Documentation/arm64/cpu-feature-registers.rst      |   17 +
 Documentation/arm64/elf_hwcaps.rst                 |    8 +
 Documentation/arm64/perf.rst                       |   78 +-
 Documentation/arm64/sve.rst                        |    2 +-
 Documentation/arm64/tagged-address-abi.rst         |    2 +-
 .../devicetree/bindings/perf/arm,cmn.yaml          |   21 +-
 .../devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml |   70 ++
 .../bindings/perf/marvell-cn10k-tad.yaml           |   63 ++
 Documentation/memory-barriers.txt                  |    8 +
 MAINTAINERS                                        |    2 +
 arch/arm64/Kconfig                                 |    8 +
 arch/arm64/Makefile                                |    5 +
 arch/arm64/crypto/aes-modes.S                      |   10 +-
 arch/arm64/include/asm/assembler.h                 |   10 +
 arch/arm64/include/asm/atomic_ll_sc.h              |   86 +-
 arch/arm64/include/asm/atomic_lse.h                |  270 ++---
 arch/arm64/include/asm/barrier.h                   |    9 +
 arch/arm64/include/asm/cpu.h                       |    1 +
 arch/arm64/include/asm/fpsimd.h                    |    6 +-
 arch/arm64/include/asm/hwcap.h                     |    2 +
 arch/arm64/include/asm/linkage.h                   |   35 +-
 arch/arm64/include/asm/mte-kasan.h                 |    8 +-
 arch/arm64/include/asm/stacktrace.h                |   10 +-
 arch/arm64/include/asm/sysreg.h                    |   16 +
 arch/arm64/include/uapi/asm/hwcap.h                |    2 +
 arch/arm64/kernel/acpi.c                           |   35 +-
 arch/arm64/kernel/cpufeature.c                     |   13 +
 arch/arm64/kernel/cpuinfo.c                        |    3 +
 arch/arm64/kernel/entry-ftrace.S                   |    8 +-
 arch/arm64/kernel/entry.S                          |    6 +-
 arch/arm64/kernel/fpsimd.c                         |   69 +-
 arch/arm64/kernel/hibernate.c                      |    4 -
 arch/arm64/kernel/machine_kexec.c                  |    6 +-
 arch/arm64/kernel/perf_callchain.c                 |   15 +-
 arch/arm64/kernel/perf_event.c                     |  252 +++--
 arch/arm64/kernel/process.c                        |   84 +-
 arch/arm64/kernel/ptrace.c                         |    4 +-
 arch/arm64/kernel/return_address.c                 |    8 +-
 arch/arm64/kernel/setup.c                          |   13 +-
 arch/arm64/kernel/stacktrace.c                     |   60 +-
 arch/arm64/kernel/time.c                           |   25 +-
 arch/arm64/kernel/vdso/Makefile                    |    1 +
 arch/arm64/kvm/handle_exit.c                       |    5 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                   |    1 +
 arch/arm64/kvm/reset.c                             |    8 +-
 arch/arm64/kvm/sys_regs.c                          |    2 +-
 arch/arm64/lib/clear_page.S                        |   10 +
 arch/arm64/lib/kasan_sw_tags.S                     |    4 +-
 arch/arm64/lib/mte.S                               |    8 +-
 arch/arm64/lib/xor-neon.c                          |  147 ++-
 arch/arm64/mm/cache.S                              |   24 +-
 arch/arm64/mm/context.c                            |   22 +-
 arch/arm64/mm/extable.c                            |    3 -
 arch/arm64/mm/fault.c                              |    9 +-
 arch/powerpc/kernel/Makefile                       |    3 +-
 arch/riscv/kernel/stacktrace.c                     |    4 -
 arch/s390/kernel/Makefile                          |    3 +-
 arch/x86/events/core.c                             |   10 +-
 arch/x86/events/perf_event.h                       |    2 +-
 arch/x86/kernel/Makefile                           |    2 +-
 drivers/perf/Kconfig                               |    9 +-
 drivers/perf/Makefile                              |    1 +
 drivers/perf/arm-cmn.c                             | 1111 +++++++++++++-------
 drivers/perf/arm_smmuv3_pmu.c                      |   68 +-
 drivers/perf/hisilicon/Kconfig                     |    9 +
 drivers/perf/hisilicon/Makefile                    |    2 +
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |  948 +++++++++++++++++
 drivers/perf/marvell_cn10k_tad_pmu.c               |  429 ++++++++
 include/asm-generic/barrier.h                      |   11 +
 include/linux/cpuhotplug.h                         |    1 +
 include/linux/perf_event.h                         |   10 +
 include/linux/stacktrace.h                         |   35 +-
 kernel/events/core.c                               |    4 +
 kernel/kcsan/Makefile                              |    1 +
 tools/testing/selftests/arm64/Makefile             |    2 +-
 tools/testing/selftests/arm64/abi/.gitignore       |    1 +
 tools/testing/selftests/arm64/abi/Makefile         |    8 +
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  |  240 +++++
 tools/testing/selftests/arm64/abi/syscall-abi.c    |  318 ++++++
 tools/testing/selftests/arm64/fp/.gitignore        |    1 +
 tools/testing/selftests/arm64/fp/Makefile          |    4 +-
 tools/testing/selftests/arm64/fp/fp-pidbench.S     |   71 ++
 tools/testing/selftests/arm64/fp/sve-ptrace.c      |  219 ++--
 .../selftests/arm64/signal/test_signals_utils.c    |   12 +-
 86 files changed, 4184 insertions(+), 1070 deletions(-)
