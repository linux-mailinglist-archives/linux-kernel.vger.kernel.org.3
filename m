Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E14D8F48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbiCNWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiCNWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:08:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CEC3D1EB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56886B8104A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A02C340E9;
        Mon, 14 Mar 2022 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647295652;
        bh=ucAJHFAJtcGgOsSUGBinS0ljsAlXYkexJoQVd5UzHek=;
        h=Date:From:To:Cc:Subject:From;
        b=SnHmC5PJQta6kDNsWbhIOFBN6sgfd8KvOAZR1aOuNHwvg1fJIlKa0kT3LqG6rGRM8
         EJ4FIsBbgRscL+2iGv+tNikGUi8LsqqN4To3CWBaRN6PD6Lj8+jdinVROEmEybg8WP
         xAiNOwDXWErhucjVG8zJ52+narQE55XE7tBB8C687Xkr6vYaE5nqnDbDddFbpY7x6S
         Cu0CtZUvfwU2pumCXU8Puc7xbcgNOG65MMwG8PAwr9J2clcBJ/AGF5Olz04MunDZ7r
         P9LrFzCPmuYA0guEZDUkrnGr6jDlxhnuDbxyIdZL+hp1nbcZdVnRS6kJKjOJoJstmy
         qINEiXiXRYrTQ==
Date:   Mon, 14 Mar 2022 22:07:27 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Subject: [GIT PULL] arm64 updates for 5.18
Message-ID: <20220314220726.GA5585@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I'm off for the rest of the week, so here is an early pull containing
the arm64 changes for 5.18. Summary in the tag, but there are some other
points worthy of note:

  - I had to merge in the spectre-bhb mitigations as they conflicted
    with what was already queued. These are the same commits (SHAs) as
    what you took upstream, so the pull request has ended up using that
    as a base.

  - We have a few shared branches. In particular:

      * Instruction encoder updates are shared with eBPF (Daniel
        Borkmann)

      * Symbol aliasing cleanups are shared with -tip (Peter Z)

      * Apple interrupt controller updates are shared with irqchip (Marc
        Zyngier)

    and these explain most of the changes straying outside of the usual
    directories.

  - The MTE coredump support conflicted pretty badly with the maple tree
    VMA list conversion from Liam, so we've got a funny conditional
    definition of VMA_ITERATOR() to make this easy to deal with. It's
    spent a while in -next and we'll drop it at -rc1.

Thanks, and please pull.

Will

--->8

The following changes since commit 52c9f93a9c482251cb0d224faa602ba26d462be8:

  arm64: Do not include __READ_ONCE() block in assembly files (2022-03-09 21:56:50 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 641d804157294d9b19bdfe6a2cdbd5d25939a048:

  Merge branch 'for-next/spectre-bhb' into for-next/core (2022-03-14 19:08:31 +0000)

----------------------------------------------------------------
arm64 updates for 5.18

- Support for including MTE tags in ELF coredumps

- Instruction encoder updates, including fixes to 64-bit immediate
  generation and support for the LSE atomic instructions

- Improvements to kselftests for MTE and fpsimd

- Symbol aliasing and linker script cleanups

- Reduce instruction cache maintenance performed for user mappings
  created using contiguous PTEs

- Support for the new "asymmetric" MTE mode, where stores are checked
  asynchronously but loads are checked synchronously

- Support for the latest pointer authentication algorithm ("QARMA3")

- Support for the DDR PMU present in the Marvell CN10K platform

- Support for the CPU PMU present in the Apple M1 platform

- Use the RNDR instruction for arch_get_random_{int,long}()

- Update our copy of the Arm optimised string routines for str{n}cmp()

- Fix signal frame generation for CPUs which have foolishly elected to
  avoid building in support for the fpsimd instructions

- Workaround for Marvell GICv3 erratum #38545

- Clarification to our Documentation (booting reqs. and MTE prctl())

- Miscellanous cleanups and minor fixes

----------------------------------------------------------------
Andre Przywara (1):
      arm64: booting.rst: Clarify on requiring non-secure EL2

Anshuman Khandual (3):
      arm64/mm: Consolidate TCR_EL1 fields
      arm64/hugetlb: Define __hugetlb_valid_size()
      arm64/mm: Drop use_1G_block()

Ard Biesheuvel (1):
      arm64: random: implement arch_get_random_int/_long based on RNDR

Bharat Bhushan (4):
      dt-bindings: perf: marvell: cn10k ddr performance monitor
      perf/marvell: CN10k DDR performance monitor support
      perf/marvell: cn10k DDR perfmon event overflow handling
      perf/marvell: cn10k DDR perf event core ownership

Catalin Marinas (5):
      elfcore: Replace CONFIG_{IA64, UML} checks with a new option
      elf: Introduce the ARM MTE ELF segment type
      arm64: mte: Define the number of bytes for storing the tags in a page
      arm64: mte: Dump the MTE tags in the core file
      arm64: mte: Document the core dump file format

David Engraf (1):
      arm64: signal: nofpsimd: Do not allocate fp/simd context when not available

Evgenii Stepanov (1):
      docs: sysfs-devices-system-cpu: document "asymm" value for mte_tcf_preferred

Fangrui Song (1):
      arm64: module: remove (NOLOAD) from linker script

Geert Uytterhoeven (1):
      perf: MARVELL_CN10K_TAD_PMU should depend on ARCH_THUNDER

He Ying (1):
      arm64: entry: Save some nops when CONFIG_ARM64_PSEUDO_NMI is not set

Hou Tao (2):
      arm64: move AARCH64_BREAK_FAULT into insn-def.h
      arm64: insn: add encoders for atomic operations

Huang Shijie (1):
      arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ranges

James Morse (1):
      arm64: insn: Generate 64 bit mask immediates correctly

Jianyong Wu (1):
      arm64/mm: avoid fixmap race condition when create pud mapping

Joey Gouly (10):
      kselftest/arm64: mte: user_mem: introduce tag_offset and tag_len
      kselftest/arm64: mte: user_mem: rework error handling
      kselftest/arm64: mte: user_mem: check different offsets and sizes
      kselftest/arm64: mte: user_mem: add test type enum
      kselftest/arm64: mte: user_mem: add more test types
      kselftest/arm64: mte: user_mem: test a wider range of values
      arm64: lib: Import latest version of Arm Optimized Routines' strcmp
      arm64: lib: Import latest version of Arm Optimized Routines' strncmp
      Revert "arm64: Mitigate MTE issues with str{n}cmp()"
      kasan: fix a missing header include of static_keys.h

Lad Prabhakar (1):
      perf/arm-ccn: Use platform_get_irq() to get the interrupt

Liam Howlett (1):
      arm64: Change elfcore for_each_mte_vma() to use VMA iterator

Linu Cherian (1):
      irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR

Marc Zyngier (11):
      dt-bindings: arm-pmu: Document Apple PMU compatible strings
      dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
      dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts
      irqchip/apple-aic: Parse FIQ affinities from device-tree
      irqchip/apple-aic: Wire PMU interrupts
      arm64: dts: apple: Add t8103 PMU interrupt affinities
      arm64: dts: apple: Add t8303 PMU nodes
      irqchip/apple-aic: Move PMU-specific registers to their own include file
      drivers/perf: arm_pmu: Handle 47 bit counters
      drivers/perf: Add Apple icestorm/firestorm CPU PMU driver
      arm64: Add cavium_erratum_23154_cpus missing sentinel

Mark Brown (15):
      kselftest/arm64: Remove local ARRAY_SIZE() definitions
      kselftest/arm64: Remove local definitions of MTE prctls
      arm64/mte: Clarify mode reported by PR_GET_TAGGED_ADDR_CTRL
      arm64: Define CPACR_EL1_FPEN similarly to other floating point controls
      arm64: Always use individual bits in CPACR floating point enables
      arm64: cpufeature: Always specify and use a field width for capabilities
      kselftest/arm64: signal: Allow tests to be incompatible with features
      arm64/mte: Document ABI for asymmetric mode
      arm64/mte: Add a little bit of documentation for mte_update_sctlr_user()
      arm64/mte: Add hwcap for asymmetric mode
      arm64/mte: Add userspace interface for enabling asymmetric mode
      arm64: cpufeature: Add missing .field_width for GIC system registers
      arm64: cpufeature: Warn if we attempt to read a zero width field
      kselftest/arm64: Log the PIDs of the parent and child in sve-ptrace
      arm64/mte: Remove asymmetric mode from the prctl() interface

Mark Rutland (6):
      arm64: atomics: remove redundant static branch
      linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()
      arm64: clean up symbol aliasing
      x86: clean up symbol aliasing
      linkage: remove SYM_FUNC_{START,END}_ALIAS()
      arm64: prevent instrumentation of bp hardening callbacks

Masahiro Yamada (1):
      arm64: clean up tools Makefile

Muchun Song (1):
      arm64: avoid flushing icache multiple times on contiguous HugeTLB

Peter Collingbourne (2):
      kasan: split kasan_*enabled() functions into a separate header
      arm64: mte: avoid clearing PSTATE.TCO on entry unless necessary

Rafael J. Wysocki (1):
      perf: Replace acpi_bus_get_device()

Robin Murphy (3):
      perf/arm-cmn: Make arm_cmn_debugfs static
      perf/arm-cmn: Hide XP PUB events for CMN-600
      perf/arm-cmn: Update watchpoint format

Sagar Patel (1):
      arm64: drop unused includes of <linux/personality.h>

Shaokun Zhang (2):
      arm64: perf: Expose some Armv9 common events under sysfs
      arm64: perf: Consistently make all event numbers as 16-bits

Vijay Balakrishna (1):
      arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones

Vladimir Murzin (4):
      arm64: cpufeature: Account min_field_value when cheking secondaries for PAuth
      arm64: cpufeature: Mark existing PAuth architected algorithm as QARMA5
      arm64: Add support of PAuth QARMA3 architected algorithm
      arm64: cpufeature: Remove cpu_has_fwb() check

Will Deacon (21):
      perf/marvell_cn10k: Fix unused variable warning when W=1 and CONFIG_OF=n
      Merge branch 'irq/aic-pmu' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into for-next/perf-m1
      Merge branch 'for-next/perf-m1' into for-next/perf
      Documentation: vmcoreinfo: Fix htmldocs warning
      arm64: mm: Drop 'const' from conditional arm64_dma_phys_limit definition
      perf/marvell: Fix !CONFIG_OF build for CN10K DDR PMU driver
      Merge branch 'for-next/coredump' into for-next/core
      Merge branch 'for-next/docs' into for-next/core
      Merge branch 'for-next/errata' into for-next/core
      Merge branch 'for-next/insn' into for-next/core
      Merge branch 'for-next/kselftest' into for-next/core
      Merge branch 'for-next/linkage' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/mte' into for-next/core
      Merge branch 'for-next/pauth' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/rng' into for-next/core
      Merge branch 'for-next/strings' into for-next/core
      Merge branch 'for-next/fpsimd' into for-next/core
      Merge branch 'for-next/spectre-bhb' into for-next/core

Yury Norov (1):
      perf: replace bitmap_weight with bitmap_empty where appropriate

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |   8 +
 Documentation/arm64/booting.rst                    |  10 +-
 Documentation/arm64/elf_hwcaps.rst                 |   5 +
 Documentation/arm64/memory-tagging-extension.rst   |  54 +-
 Documentation/arm64/silicon-errata.rst             |   2 +-
 Documentation/asm-annotations.rst                  |  11 +-
 Documentation/devicetree/bindings/arm/pmu.yaml     |   2 +
 .../bindings/interrupt-controller/apple,aic.yaml   |  31 +
 .../bindings/perf/marvell-cn10k-ddr.yaml           |  37 +
 arch/arm64/Kconfig                                 |   9 +-
 arch/arm64/boot/dts/apple/t8103.dtsi               |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h              |  64 ++
 arch/arm64/include/asm/arch_gicv3.h                |  23 +-
 arch/arm64/include/asm/archrandom.h                |  45 +-
 arch/arm64/include/asm/asm_pointer_auth.h          |   3 +
 arch/arm64/include/asm/assembler.h                 |   5 -
 arch/arm64/include/asm/cpufeature.h                |   4 +
 arch/arm64/include/asm/cputype.h                   |  13 +
 arch/arm64/include/asm/debug-monitors.h            |  12 -
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/insn-def.h                  |  14 +
 arch/arm64/include/asm/insn.h                      |  80 ++-
 arch/arm64/include/asm/kvm_arm.h                   |   4 +-
 arch/arm64/include/asm/kvm_hyp.h                   |   1 +
 arch/arm64/include/asm/linkage.h                   |  24 -
 arch/arm64/include/asm/lse.h                       |   6 +-
 arch/arm64/include/asm/module.lds.h                |   6 +-
 arch/arm64/include/asm/mte-def.h                   |   1 +
 arch/arm64/include/asm/mte.h                       |  22 +
 arch/arm64/include/asm/perf_event.h                | 312 +++++----
 arch/arm64/include/asm/pgtable-hwdef.h             |   2 +
 arch/arm64/include/asm/processor.h                 |   1 +
 arch/arm64/include/asm/spectre.h                   |   3 +-
 arch/arm64/include/asm/string.h                    |   2 -
 arch/arm64/include/asm/sysreg.h                    |  20 +-
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/cpu_errata.c                     |  21 +-
 arch/arm64/kernel/cpufeature.c                     | 239 ++++---
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/crash_core.c                     |   6 +
 arch/arm64/kernel/elfcore.c                        | 134 ++++
 arch/arm64/kernel/entry-common.c                   |   3 +
 arch/arm64/kernel/entry.S                          |   9 +-
 arch/arm64/kernel/idreg-override.c                 |  16 +-
 arch/arm64/kernel/mte.c                            |  36 +-
 arch/arm64/kernel/perf_event.c                     |  10 +
 arch/arm64/kernel/process.c                        |   3 +-
 arch/arm64/kernel/proton-pack.c                    |   9 +-
 arch/arm64/kernel/signal.c                         |  11 +-
 arch/arm64/kernel/sys_compat.c                     |   1 -
 arch/arm64/kernel/traps.c                          |   1 -
 arch/arm64/kvm/arm.c                               |   1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   4 +-
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h     |   5 +
 arch/arm64/kvm/hyp/nvhe/cache.S                    |   5 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |  14 +
 arch/arm64/kvm/hyp/vhe/switch.c                    |   6 +-
 arch/arm64/kvm/sys_regs.c                          |   5 +
 arch/arm64/lib/clear_page.S                        |   5 +-
 arch/arm64/lib/copy_page.S                         |   5 +-
 arch/arm64/lib/insn.c                              | 187 ++++-
 arch/arm64/lib/memchr.S                            |   5 +-
 arch/arm64/lib/memcmp.S                            |   6 +-
 arch/arm64/lib/memcpy.S                            |  21 +-
 arch/arm64/lib/memset.S                            |  12 +-
 arch/arm64/lib/mte.S                               |   4 +-
 arch/arm64/lib/strchr.S                            |   6 +-
 arch/arm64/lib/strcmp.S                            | 246 +++----
 arch/arm64/lib/strlen.S                            |   6 +-
 arch/arm64/lib/strncmp.S                           | 241 ++++---
 arch/arm64/lib/strnlen.S                           |   6 +-
 arch/arm64/lib/strrchr.S                           |   5 +-
 arch/arm64/mm/cache.S                              |  35 +-
 arch/arm64/mm/flush.c                              |   7 +
 arch/arm64/mm/hugetlbpage.c                        |  38 +-
 arch/arm64/mm/init.c                               |  36 +-
 arch/arm64/mm/mmu.c                                |  56 +-
 arch/arm64/mm/mteswap.c                            |   2 +-
 arch/arm64/mm/proc.S                               |   2 +-
 arch/arm64/net/bpf_jit.h                           |  11 +-
 arch/arm64/tools/Makefile                          |  10 +-
 arch/arm64/tools/cpucaps                           |   6 +-
 arch/ia64/Kconfig                                  |   1 +
 arch/x86/boot/compressed/head_32.S                 |   3 +-
 arch/x86/boot/compressed/head_64.S                 |   3 +-
 arch/x86/crypto/aesni-intel_asm.S                  |   4 +-
 arch/x86/lib/memcpy_64.S                           |  10 +-
 arch/x86/lib/memmove_64.S                          |   4 +-
 arch/x86/lib/memset_64.S                           |   6 +-
 arch/x86/um/Kconfig                                |   1 +
 drivers/irqchip/irq-apple-aic.c                    |  94 ++-
 drivers/perf/Kconfig                               |  16 +-
 drivers/perf/Makefile                              |   2 +
 drivers/perf/apple_m1_cpu_pmu.c                    | 584 ++++++++++++++++
 drivers/perf/arm-cci.c                             |   2 +-
 drivers/perf/arm-ccn.c                             |  10 +-
 drivers/perf/arm-cmn.c                             |  23 +-
 drivers/perf/arm_pmu.c                             |   6 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   2 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c               | 758 +++++++++++++++++++++
 drivers/perf/marvell_cn10k_tad_pmu.c               |   2 +
 drivers/perf/thunderx2_pmu.c                       |   6 +-
 drivers/perf/xgene_pmu.c                           |   8 +-
 fs/Kconfig.binfmt                                  |   3 +
 .../dt-bindings/interrupt-controller/apple-aic.h   |   2 +
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/elfcore.h                            |   4 +-
 include/linux/kasan-enabled.h                      |  35 +
 include/linux/kasan.h                              |  23 +-
 include/linux/linkage.h                            |  67 +-
 include/linux/perf/arm_pmu.h                       |   2 +
 include/uapi/linux/elf.h                           |   3 +
 tools/arch/x86/lib/memcpy_64.S                     |  10 +-
 tools/arch/x86/lib/memset_64.S                     |   6 +-
 tools/perf/util/include/linux/linkage.h            |  52 +-
 tools/testing/selftests/arm64/abi/syscall-abi.c    |   1 -
 tools/testing/selftests/arm64/fp/sve-ptrace.c      |   4 +-
 .../selftests/arm64/mte/check_gcr_el1_cswitch.c    |  11 -
 tools/testing/selftests/arm64/mte/check_user_mem.c | 193 +++++-
 .../testing/selftests/arm64/signal/test_signals.h  |   1 +
 .../selftests/arm64/signal/test_signals_utils.c    |  34 +-
 .../selftests/arm64/signal/test_signals_utils.h    |   2 +
 124 files changed, 3470 insertions(+), 891 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
 create mode 100644 arch/arm64/kernel/elfcore.c
 create mode 100644 drivers/perf/apple_m1_cpu_pmu.c
 create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c
 create mode 100644 include/linux/kasan-enabled.h
