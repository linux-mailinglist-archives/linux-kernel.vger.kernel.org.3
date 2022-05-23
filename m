Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BFF531852
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiEWQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiEWQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C808469485
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567766144C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33013C385A9;
        Mon, 23 May 2022 16:39:16 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.19-rc1
Date:   Mon, 23 May 2022 17:39:13 +0100
Message-Id: <20220523163913.43175-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the (mostly) arm64 updates below. There are a few patches
that go outside the usual paths: btrfs search_ioctl() livelock fix
(touching fs/, mm/), ftrace cleanups (arch/x86/ and kernel/ changes),
scalable matrix extensions (prctl() wiring), crashkernel 'high'
reservations for arm64 (changes to kernel/crash_core.c, drivers/of/). A
summary of the updates is in the tag.

There are no conflicts with 5.18 but, depending on the order in which
you merge the pull requests, I expect a couple that appeared in
linux-next. One of them is with the KVM tree:

https://lore.kernel.org/r/20220504143529.4060ab27@canb.auug.org.au

and a silent one with the mm tree:

https://lore.kernel.org/r/20220513171838.627ccc86@canb.auug.org.au

For the latter, I'll send Stephen's patch once the mm tree is merged.

Thanks.

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 0616ea3f1b93a99264d84f3d002ae117f6526b62:

  Merge branch 'for-next/esr-elx-64-bit' into for-next/core (2022-05-20 18:51:54 +0100)

----------------------------------------------------------------
arm64 updates for 5.19:

- Initial support for the ARMv9 Scalable Matrix Extension (SME). SME
  takes the approach used for vectors in SVE and extends this to provide
  architectural support for matrix operations. No KVM support yet, SME
  is disabled in guests.

- Support for crashkernel reservations above ZONE_DMA via the
  'crashkernel=X,high' command line option.

- btrfs search_ioctl() fix for live-lock with sub-page faults.

- arm64 perf updates: support for the Hisilicon "CPA" PMU for monitoring
  coherent I/O traffic, support for Arm's CMN-650 and CMN-700
  interconnect PMUs, minor driver fixes, kerneldoc cleanup.

- Kselftest updates for SME, BTI, MTE.

- Automatic generation of the system register macros from a 'sysreg'
  file describing the register bitfields.

- Update the type of the function argument holding the ESR_ELx register
  value to unsigned long to match the architecture register size
  (originally 32-bit but extended since ARMv8.0).

- stacktrace cleanups.

- ftrace cleanups.

- Miscellaneous updates, most notably: arm64-specific huge_ptep_get(),
  avoid executable mappings in kexec/hibernate code, drop TLB flushing
  from get_clear_flush() (and rename it to get_clear_contig()),
  ARCH_NR_GPIO bumped to 2048 for ARCH_APPLE.

----------------------------------------------------------------
Alexandru Elisei (5):
      arm64: Make ESR_ELx_xVC_IMM_MASK compatible with assembly
      arm64: compat: Do not treat syscall number as ESR_ELx for a bad syscall
      arm64: Treat ESR_ELx as a 64-bit register
      KVM: arm64: Treat ESR_EL2 as a 64-bit register
      KVM: arm64: uapi: Add kvm_debug_exit_arch.hsr_high

Andre Przywara (1):
      kselftest/arm64: bti: force static linking

Anshuman Khandual (2):
      arm64/mm: Compute PTRS_PER_[PMD|PUD] independently of PTRS_PER_PTE
      arm64/hugetlb: Drop TLB flush from get_clear_flush()

Ard Biesheuvel (2):
      arm64: lds: move special code sections out of kernel exec segment
      arm64: mm: avoid writable executable mappings in kexec/hibernate code

Baolin Wang (2):
      arm64/hugetlb: Use ptep_get() to get the pte value of a huge page
      arm64/hugetlb: Implement arm64 specific huge_ptep_get()

Catalin Marinas (8):
      mm: Add fault_in_subpage_writeable() to probe at sub-page granularity
      arm64: Add support for user sub-page fault probing
      btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page faults
      Merge branch 'for-next/sme' into for-next/sysreg-gen
      Merge branches 'for-next/sme', 'for-next/stacktrace', 'for-next/fault-in-subpage', 'for-next/misc', 'for-next/ftrace' and 'for-next/crashkernel', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/sysreg-gen' into for-next/core
      Merge branch 'for-next/kselftest' into for-next/core
      Merge branch 'for-next/esr-elx-64-bit' into for-next/core

Chen Zhou (2):
      arm64: kdump: Reimplement crashkernel=X
      of: fdt: Add memory for devices by DT property "linux,usable-memory-range"

Chengming Zhou (2):
      ftrace: cleanup ftrace_graph_caller enable and disable
      arm64/ftrace: Make function graph use ftrace directly

Geert Uytterhoeven (1):
      arm64/sve: Move sve_free() into SVE code section

Guo Zhengkui (1):
      kselftest/arm64: fix array_size.cocci warning

Hector Martin (1):
      arm64: Set ARCH_NR_GPIO to 2048 for ARCH_APPLE

Juerg Haefliger (2):
      arm64: Kconfig: Fix indentation and add comments
      arm64: Kconfig.platforms: Add comments

Kefeng Wang (1):
      arm64: mm: Cleanup useless parameters in zone_sizes_init()

Linu Cherian (1):
      arm64: Declare non global symbols as static

Madhavan T. Venkataraman (4):
      arm64: stacktrace: remove NULL task check from unwind_frame()
      arm64: stacktrace: rename unwinder functions
      arm64: stacktrace: rename stackframe to unwind_state
      arm64: stacktrace: align with common naming

Mark Brown (85):
      arm64/sme: Provide ABI documentation for SME
      arm64/sme: System register and exception syndrome definitions
      arm64/sme: Manually encode SME instructions
      arm64/sme: Early CPU setup for SME
      arm64/sme: Basic enumeration support
      arm64/sme: Identify supported SME vector lengths at boot
      arm64/sme: Implement sysctl to set the default vector length
      arm64/sme: Implement vector length configuration prctl()s
      arm64/sme: Implement support for TPIDR2
      arm64/sme: Implement SVCR context switching
      arm64/sme: Implement streaming SVE context switching
      arm64/sme: Implement ZA context switching
      arm64/sme: Implement traps and syscall handling for SME
      arm64/sme: Disable ZA and streaming mode when handling signals
      arm64/sme: Implement streaming SVE signal handling
      arm64/sme: Implement ZA signal handling
      arm64/sme: Implement ptrace support for streaming mode SVE registers
      arm64/sme: Add ptrace support for ZA
      arm64/sme: Disable streaming mode and ZA when flushing CPU state
      arm64/sme: Save and restore streaming mode over EFI runtime calls
      KVM: arm64: Hide SME system registers from guests
      KVM: arm64: Trap SME usage in guest
      KVM: arm64: Handle SME host state when running guests
      arm64/sme: Provide Kconfig for SME
      arm64/sme: Add ID_AA64SMFR0_EL1 to __read_sysreg_by_encoding()
      kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
      kselftest/arm64: Remove assumption that tasks start FPSIMD only
      kselftest/arm64: Validate setting via FPSIMD and read via SVE regsets
      kselftest/arm64: Handle more kselftest result codes in MTE helpers
      kselftest/arm64: Log unexpected asynchronous MTE faults
      kselftest/arm64: Refactor parameter checking in mte_switch_mode()
      kselftest/arm64: Add simple test for MTE prctl
      kselftest/arm64: Add manual encodings for SME instructions
      kselftest/arm64: sme: Add SME support to vlset
      kselftest/arm64: Add tests for TPIDR2
      kselftest/arm64: Extend vector configuration API tests to cover SME
      kselftest/arm64: sme: Provide streaming mode SVE stress test
      kselftest/arm64: signal: Handle ZA signal context in core code
      kselftest/arm64: Add stress test for SME ZA context switching
      kselftest/arm64: signal: Add SME signal handling tests
      kselftest/arm64: Add streaming SVE to SVE ptrace tests
      kselftest/arm64: Add coverage for the ZA ptrace interface
      kselftest/arm64: Add SME support to syscall ABI test
      selftests/arm64: Add a testcase for handling of ZA on clone()
      selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
      selftests/arm64: Define top_srcdir for the fp tests
      selftests/arm64: Clean the fp helper libraries
      selftests/arm64: Fix O= builds for the floating point tests
      kselftest/arm64: Fix ABI header directory location
      arm64/sysreg: Introduce helpers for access to sysreg fields
      arm64/mte: Make TCF0 naming and field values more standard
      arm64/mte: Make TCF field values and naming more standard
      arm64/sysreg: Rename SCTLR_EL1_NTWE/TWI to SCTLR_EL1_nTWE/TWI
      arm64/sysreg: Define bits for previously RES1 fields in SCTLR_EL1
      arm64: Update name of ID_AA64ISAR0_EL1_ATOMIC to reflect ARM
      arm64/sysreg: Standardise ID_AA64ISAR0_EL1 macro names
      arm64/sysreg: Enable automatic generation of system register definitions
      arm64/sysreg: Generate definitions for ID_AA64ISAR0_EL1
      arm64/sysreg: Generate definitions for TTBRn_EL1
      arm64/sysreg: Generate definitions for SCTLR_EL1
      arm64/sme: More sensibly define the size for the ZA register set
      selftests/arm64: Log errors in verify_mte_pointer_validity()
      selftests/arm64: Allow zero tags in mte_switch_mode()
      selftests/arm64: Check failures to set tags in check_tags_inclusion
      selftests/arm64: Remove casts to/from void in check_tags_inclusion
      selftests/arm64: Use switch statements in mte_common_util.c
      kselftest/arm64: Explicitly build no BTI tests with BTI disabled
      arm64/fp: Make SVE and SME length register definition match architecture
      arm64/fp: Rename SVE and SME LEN field name to _WIDTH
      arm64/sme: Drop SYS_ from SMIDR_EL1 defines
      arm64/sme: Standardise bitfield names for SVCR
      arm64/sme: Remove _EL0 from name of SVCR - FIXME sysreg.h
      arm64/sysreg: Support generation of RAZ fields
      arm64/sme: Automatically generate defines for SMCR
      arm64/sme: Automatically generate SMIDR_EL1 defines
      arm64/sme: Automatically generate SMPRIMAP_EL2 definitions
      arm64/sme: Generate SMPRI_EL1 definitions
      arm64/sme: Generate defintions for SVCR
      arm64/sve: Generate ZCR definitions
      arm64/sysreg: Generate definitions for CLIDR_EL1
      arm64/sysreg: Generate definitions for CONTEXTIDR_ELx
      arm64/sysreg: Generate definitions for CPACR_ELx
      arm64/sysreg: Generate definitions for CSSELR_EL1
      arm64/sysreg: Generate definitions for DACR32_EL2
      arm64/sysreg: Generate definitions for FAR_ELx

Mark Rutland (5):
      arm64: stacktrace: delete PCS comment
      arm64: stacktrace: make struct stackframe private to stacktrace.c
      arm64: Add sysreg header generation scripting
      arm64/sysreg: improve comment for regs without fields
      arm64/sysreg: fix odd line spacing

Michal Orzel (1):
      arm64: cputype: Avoid overflow using MIDR_IMPLEMENTOR_MASK

Palmer Dabbelt (1):
      perf: RISC-V: Remove non-kernel-doc ** comments

Peter Collingbourne (1):
      arm64: document the boot requirements for MTE

Qi Liu (2):
      drivers/perf: hisi: Associate PMUs in SICL with CPUs online
      drivers/perf: hisi: Add Support for CPA PMU

Ren Yu (1):
      perf: check return value of armpmu_request_irq()

Robin Murphy (7):
      dt-bindings: perf: arm-cmn: Add CMN-650 and CMN-700
      perf/arm-cmn: Add CMN-650 support
      perf/arm-cmn: Refactor occupancy filter selector
      perf/arm-cmn: Add CMN-700 support
      perf/arm-cmn: Fix filter_sel lookup
      perf/arm-cmn: Decode CAL devices properly in debugfs
      arm64: mte: Clean up user tag accessors

Sebastian Andrzej Siewior (2):
      arm64/sve: Delay freeing memory in fpsimd_flush_thread()
      arm64/sve: Make kernel FPU protection RT friendly

Shaokun Zhang (1):
      drivers/perf: arm_spe: Expose saturating counter to 16-bit

Tanmay Jagdale (1):
      perf/marvell_cn10k: Fix tad_pmu_event_init() to check pmu type first

Tong Tiangen (1):
      arm64: fix types in copy_highpage()

Valentin Schneider (1):
      arm64: mm: Make arch_faults_on_old_pte() check for migratability

Wan Jiabing (1):
      arm64/sme: Fix NULL check after kzalloc

Zhen Lei (5):
      kdump: return -ENOENT if required cmdline option does not exist
      arm64: Use insert_resource() to simplify code
      of: Support more than one crash kernel regions for kexec -s
      docs: kdump: Update the crashkernel description for arm64
      arm64: kdump: Do not allocate crash low memory if not needed

 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 Documentation/arm64/booting.rst                    |  10 +
 Documentation/arm64/elf_hwcaps.rst                 |  33 ++
 Documentation/arm64/index.rst                      |   1 +
 Documentation/arm64/sme.rst                        | 428 ++++++++++++++
 Documentation/arm64/sve.rst                        |  70 ++-
 .../devicetree/bindings/perf/arm,cmn.yaml          |   2 +
 Documentation/virt/kvm/api.rst                     |   2 +
 arch/Kconfig                                       |   7 +
 arch/arm64/Kconfig                                 | 119 ++--
 arch/arm64/Kconfig.platforms                       |   2 +-
 arch/arm64/include/asm/Kbuild                      |   1 +
 arch/arm64/include/asm/archrandom.h                |   2 +-
 arch/arm64/include/asm/cpu.h                       |   4 +
 arch/arm64/include/asm/cpufeature.h                |  24 +
 arch/arm64/include/asm/cputype.h                   |   2 +-
 arch/arm64/include/asm/debug-monitors.h            |   4 +-
 arch/arm64/include/asm/el2_setup.h                 |  64 +-
 arch/arm64/include/asm/esr.h                       |  21 +-
 arch/arm64/include/asm/exception.h                 |  29 +-
 arch/arm64/include/asm/fpsimd.h                    | 135 ++++-
 arch/arm64/include/asm/fpsimdmacros.h              |  87 +++
 arch/arm64/include/asm/ftrace.h                    |   7 +
 arch/arm64/include/asm/hugetlb.h                   |   2 +
 arch/arm64/include/asm/hwcap.h                     |   8 +
 arch/arm64/include/asm/kvm_arm.h                   |   1 +
 arch/arm64/include/asm/kvm_emulate.h               |   6 +-
 arch/arm64/include/asm/kvm_host.h                  |   6 +-
 arch/arm64/include/asm/kvm_ras.h                   |   2 +-
 arch/arm64/include/asm/mte.h                       |   1 +
 arch/arm64/include/asm/pgtable-hwdef.h             |   4 +-
 arch/arm64/include/asm/pgtable.h                   |   3 +-
 arch/arm64/include/asm/processor.h                 |  26 +-
 arch/arm64/include/asm/stacktrace.h                |  32 -
 arch/arm64/include/asm/sysreg.h                    | 181 +++---
 arch/arm64/include/asm/system_misc.h               |   4 +-
 arch/arm64/include/asm/thread_info.h               |   2 +
 arch/arm64/include/asm/traps.h                     |  12 +-
 arch/arm64/include/asm/uaccess.h                   |  15 +
 arch/arm64/include/uapi/asm/hwcap.h                |   8 +
 arch/arm64/include/uapi/asm/kvm.h                  |   2 +
 arch/arm64/include/uapi/asm/ptrace.h               |  69 ++-
 arch/arm64/include/uapi/asm/sigcontext.h           |  55 +-
 arch/arm64/kernel/cpu_errata.c                     |   2 +-
 arch/arm64/kernel/cpufeature.c                     | 179 ++++--
 arch/arm64/kernel/cpuinfo.c                        |  13 +
 arch/arm64/kernel/debug-monitors.c                 |  12 +-
 arch/arm64/kernel/entry-common.c                   |  17 +-
 arch/arm64/kernel/entry-fpsimd.S                   |  36 ++
 arch/arm64/kernel/entry-ftrace.S                   |  17 -
 arch/arm64/kernel/fpsimd.c                         | 655 ++++++++++++++++++---
 arch/arm64/kernel/ftrace.c                         |  17 +
 arch/arm64/kernel/hw_breakpoint.c                  |   4 +-
 arch/arm64/kernel/kgdb.c                           |   6 +-
 arch/arm64/kernel/machine_kexec.c                  |   9 +-
 arch/arm64/kernel/machine_kexec_file.c             |  12 +-
 arch/arm64/kernel/mte.c                            |  45 +-
 arch/arm64/kernel/probes/kprobes.c                 |   4 +-
 arch/arm64/kernel/probes/uprobes.c                 |   4 +-
 arch/arm64/kernel/process.c                        |  44 +-
 arch/arm64/kernel/ptrace.c                         | 366 ++++++++++--
 arch/arm64/kernel/setup.c                          |  17 +-
 arch/arm64/kernel/signal.c                         | 188 +++++-
 arch/arm64/kernel/stacktrace.c                     | 124 ++--
 arch/arm64/kernel/sys_compat.c                     |   2 +-
 arch/arm64/kernel/syscall.c                        |  29 +-
 arch/arm64/kernel/traps.c                          |  67 +--
 arch/arm64/kernel/vmlinux.lds.S                    |  21 +-
 arch/arm64/kvm/arm.c                               |   1 +
 arch/arm64/kvm/fpsimd.c                            |  43 +-
 arch/arm64/kvm/handle_exit.c                       |  16 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   2 +-
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h     |  28 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  30 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |   2 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c                    |   4 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |  11 +-
 arch/arm64/kvm/inject_fault.c                      |   4 +-
 arch/arm64/kvm/sys_regs.c                          |  13 +-
 arch/arm64/lib/mte.S                               |   4 +-
 arch/arm64/mm/copypage.c                           |   4 +-
 arch/arm64/mm/fault.c                              |  73 +--
 arch/arm64/mm/hugetlbpage.c                        |  46 +-
 arch/arm64/mm/init.c                               |  71 ++-
 arch/arm64/mm/trans_pgd.c                          |   2 +-
 arch/arm64/tools/Makefile                          |   8 +-
 arch/arm64/tools/cpucaps                           |   2 +
 arch/arm64/tools/gen-sysreg.awk                    | 268 +++++++++
 arch/arm64/tools/sysreg                            | 369 ++++++++++++
 arch/x86/kernel/ftrace.c                           |  17 +-
 drivers/of/fdt.c                                   |  33 +-
 drivers/of/kexec.c                                 |   9 +
 drivers/perf/arm-cmn.c                             | 609 +++++++++++++++----
 drivers/perf/arm_pmu_acpi.c                        |   4 +-
 drivers/perf/arm_spe_pmu.c                         |   3 +
 drivers/perf/hisilicon/Makefile                    |   2 +-
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c       | 409 +++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |  18 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   4 +
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |   1 +
 drivers/perf/marvell_cn10k_tad_pmu.c               |   6 +-
 drivers/perf/riscv_pmu_sbi.c                       |   8 +-
 fs/btrfs/ioctl.c                                   |   7 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/pagemap.h                            |   1 +
 include/linux/uaccess.h                            |  22 +
 include/uapi/linux/elf.h                           |   2 +
 include/uapi/linux/prctl.h                         |   9 +
 kernel/crash_core.c                                |   3 +-
 kernel/sys.c                                       |  12 +
 kernel/trace/fgraph.c                              |  18 +
 mm/gup.c                                           |  29 +
 tools/testing/selftests/arm64/Makefile             |  11 +-
 tools/testing/selftests/arm64/abi/.gitignore       |   1 +
 tools/testing/selftests/arm64/abi/Makefile         |   9 +-
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  |  79 ++-
 tools/testing/selftests/arm64/abi/syscall-abi.c    | 204 ++++++-
 tools/testing/selftests/arm64/abi/syscall-abi.h    |  15 +
 tools/testing/selftests/arm64/abi/tpidr2.c         | 298 ++++++++++
 tools/testing/selftests/arm64/bti/Makefile         |   6 +-
 tools/testing/selftests/arm64/fp/.gitignore        |   5 +
 tools/testing/selftests/arm64/fp/Makefile          |  46 +-
 tools/testing/selftests/arm64/fp/rdvl-sme.c        |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S            |  10 +
 tools/testing/selftests/arm64/fp/rdvl.h            |   1 +
 tools/testing/selftests/arm64/fp/sme-inst.h        |  51 ++
 tools/testing/selftests/arm64/fp/ssve-stress       |  59 ++
 tools/testing/selftests/arm64/fp/sve-ptrace.c      | 175 +++++-
 tools/testing/selftests/arm64/fp/sve-test.S        |  20 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c      |  10 +
 tools/testing/selftests/arm64/fp/vlset.c           |  10 +-
 tools/testing/selftests/arm64/fp/za-fork-asm.S     |  61 ++
 tools/testing/selftests/arm64/fp/za-fork.c         | 156 +++++
 tools/testing/selftests/arm64/fp/za-ptrace.c       | 356 +++++++++++
 tools/testing/selftests/arm64/fp/za-stress         |  59 ++
 tools/testing/selftests/arm64/fp/za-test.S         | 388 ++++++++++++
 tools/testing/selftests/arm64/mte/.gitignore       |   1 +
 .../selftests/arm64/mte/check_child_memory.c       |   8 +-
 tools/testing/selftests/arm64/mte/check_prctl.c    | 119 ++++
 .../selftests/arm64/mte/check_tags_inclusion.c     |  54 +-
 .../testing/selftests/arm64/mte/mte_common_util.c  |  42 +-
 .../testing/selftests/arm64/mte/mte_common_util.h  |  15 +-
 tools/testing/selftests/arm64/signal/.gitignore    |   3 +
 .../testing/selftests/arm64/signal/test_signals.h  |   4 +
 .../selftests/arm64/signal/test_signals_utils.c    |   6 +
 .../testcases/fake_sigreturn_sme_change_vl.c       |  92 +++
 .../arm64/signal/testcases/sme_trap_no_sm.c        |  38 ++
 .../signal/testcases/sme_trap_non_streaming.c      |  45 ++
 .../selftests/arm64/signal/testcases/sme_trap_za.c |  36 ++
 .../selftests/arm64/signal/testcases/sme_vl.c      |  68 +++
 .../selftests/arm64/signal/testcases/ssve_regs.c   | 135 +++++
 .../selftests/arm64/signal/testcases/testcases.c   |  36 ++
 .../selftests/arm64/signal/testcases/testcases.h   |   3 +-
 .../selftests/arm64/signal/testcases/za_regs.c     | 128 ++++
 154 files changed, 7542 insertions(+), 958 deletions(-)
 create mode 100644 Documentation/arm64/sme.rst
 create mode 100755 arch/arm64/tools/gen-sysreg.awk
 create mode 100644 arch/arm64/tools/sysreg
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.h
 create mode 100644 tools/testing/selftests/arm64/abi/tpidr2.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sme.c
 create mode 100644 tools/testing/selftests/arm64/fp/sme-inst.h
 create mode 100644 tools/testing/selftests/arm64/fp/ssve-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-fork-asm.S
 create mode 100644 tools/testing/selftests/arm64/fp/za-fork.c
 create mode 100644 tools/testing/selftests/arm64/fp/za-ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/za-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-test.S
 create mode 100644 tools/testing/selftests/arm64/mte/check_prctl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_no_sm.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_non_streaming.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/za_regs.c
