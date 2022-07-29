Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D369584EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiG2KWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiG2KWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:22:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7AE77579
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DFC61DBE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A05C433D6;
        Fri, 29 Jul 2022 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659090131;
        bh=B8NcFnOEWKtmalLApsbLKFTVYQmqhwn1RH+WJYhOgi8=;
        h=Date:From:To:Cc:Subject:From;
        b=NGnwgtTQmNgLOpS2HXYETZsDxUS7Qophh57KjJLdwvaI1ZFR5TVBjq12WEOWZJs99
         goBzJa+PbbpUTidI2U1G6DdoUtSpTaeHLKW0HH9ELy4LY6WvsWb/3HBcklzPKHjJkh
         MFUynFS3Ux2JNc6rqT3+Jeuf7xtKdwNKUnKaqEO0D6fQPdxgycvk+ew0wZwc5li1P/
         15HkXIPyPgogxq80GjKjU5bKWtPtMeSUyRsRoEw5paqOhz946TZ5p+KwbryCcX98BD
         V4ilsXQttBb++JqlzSA9Ets3jwlcFXI9NXWC8vqxeYNfmmM2Pj56Q0AdDFzDeAXVIR
         4c5Uv2NzQeL4g==
Date:   Fri, 29 Jul 2022 11:22:06 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Subject: [GIT PULL] arm64 updates for 5.20
Message-ID: <20220729102205.GA24050@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this crop of arm64 updates for the upcoming 5.20 merge
window. There's the usual summary in the tag, but highlights include a
major rework of our kPTI page-table rewriting code (which makes it both
more maintainable and considerably faster in the cases where it is
required) as well as significant changes to our early boot code to
reduce the need for data cache maintenance and greatly simplify the
KASLR relocation dance.

There are a few minor logistical points to note:

  - The for-next/stacktrace branch is shared with the KVM tree, so
    you'll see that one coming in there as well where it is used as a
    basis to implement the hypervisor unwinder.

  - We have some tweaks to the generic ioremap() code which means we can
    move to using it on both ARM and arm64. All of these changes sit on
    the for-next/ioremap branch which is included here.

  - Our fixes to lockdep in NMI context touch the x86 Kconfig trivially,
    as we extract TRACE_IRQFLAGS_NMI_SUPPORT to make it usable for other
    architectures.

  - We have some fixes to the core KASAN code when using the Memory
    Tagging Extension, so that the setting of the tag is correctly
    ordered against updating the 'struct page'.

Cheers,

Will

--->8

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 892f7237b3ffb090f1b1f1e55fe7c50664405aed:

  arm64: Delay initialisation of cpuinfo_arm64::reg_{zcr,smcr} (2022-07-25 11:02:11 +0100)

----------------------------------------------------------------
arm64 updates for 5.20

- Remove unused generic cpuidle support (replaced by PSCI version)

- Fix documentation describing the kernel virtual address space

- Handling of some new CPU errata in Arm implementations

- Rework of our exception table code in preparation for handling
  machine checks (i.e. RAS errors) more gracefully

- Switch over to the generic implementation of ioremap()

- Fix lockdep tracking in NMI context

- Instrument our memory barrier macros for KCSAN

- Rework of the kPTI G->nG page-table repainting so that the MMU remains
  enabled and the boot time is no longer slowed to a crawl for systems
  which require the late remapping

- Enable support for direct swapping of 2MiB transparent huge-pages on
  systems without MTE

- Fix handling of MTE tags with allocating new pages with HW KASAN

- Expose the SMIDR register to userspace via sysfs

- Continued rework of the stack unwinder, particularly improving the
  behaviour under KASAN

- More repainting of our system register definitions to match the
  architectural terminology

- Improvements to the layout of the vDSO objects

- Support for allocating additional bits of HWCAP2 and exposing
  FEAT_EBF16 to userspace on CPUs that support it

- Considerable rework and optimisation of our early boot code to reduce
  the need for cache maintenance and avoid jumping in and out of the
  kernel when handling relocation under KASLR

- Support for disabling SVE and SME support on the kernel command-line

- Support for the Hisilicon HNS3 PMU

- Miscellanous cleanups, trivial updates and minor fixes

----------------------------------------------------------------
Alexandru Elisei (1):
      arm64: cpufeature: Allow different PMU versions in ID_DFR0_EL1

Andre Mueller (1):
      Documentation/arm64: update memory layout table.

Andrey Konovalov (2):
      arm64: kasan: do not instrument stacktrace.c
      arm64: stacktrace: use non-atomic __set_bit

Anshuman Khandual (2):
      arm64/mm: Define defer_reserve_crashkernel()
      drivers/perf: arm_spe: Fix consistency of SYS_PMSCR_EL1.CX

Ard Biesheuvel (26):
      arm64: kpti-ng: simplify page table traversal logic
      arm64: mm: install KPTI nG mappings with MMU enabled
      arm64: entry: simplify trampoline data page
      arm64: head: move kimage_vaddr variable into C file
      arm64: mm: make vabits_actual a build time constant if possible
      arm64: head: move assignment of idmap_t0sz to C code
      arm64: head: drop idmap_ptrs_per_pgd
      arm64: head: simplify page table mapping macros (slightly)
      arm64: head: switch to map_memory macro for the extended ID map
      arm64: head: split off idmap creation code
      arm64: kernel: drop unnecessary PoC cache clean+invalidate
      arm64: head: pass ID map root table address to __enable_mmu()
      arm64: mm: provide idmap pointer to cpu_replace_ttbr1()
      arm64: head: add helper function to remap regions in early page tables
      arm64: head: cover entire kernel image in initial ID map
      arm64: head: use relative references to the RELA and RELR tables
      arm64: head: create a temporary FDT mapping in the initial ID map
      arm64: idreg-override: use early FDT mapping in ID map
      arm64: head: factor out TTBR1 assignment into a macro
      arm64: head: populate kernel page tables with MMU and caches on
      arm64: head: record CPU boot mode after enabling the MMU
      arm64: kaslr: defer initialization to initcall where permitted
      arm64: head: avoid relocating the kernel twice for KASLR
      arm64: setup: drop early FDT pointer helpers
      arm64: lds: use PROVIDE instead of conditional definitions
      arm64: mm: fix booting with 52-bit address space

Barry Song (1):
      arm64: enable THP_SWAP for arm64

Catalin Marinas (4):
      mm: kasan: Ensure the tags are visible before the tag in page->flags
      mm: kasan: Skip unpoisoning of user pages
      mm: kasan: Skip page unpoisoning only if __GFP_SKIP_KASAN_UNPOISON
      arm64: kasan: Revert "arm64: mte: reset the page tag in page->flags"

Chen Jun (1):
      perf: hisi: Extract hisi_pmu_init

Chen Zhongjin (2):
      arm64: compat: Move kuser32.S to .rodata section
      arm64: compat: Move sigreturn32.S to .rodata section

Christophe JAILLET (2):
      perf/marvell_cn10k: Remove useless license text when SPDX-License-Identifier is already used
      perf/arm-cci: Use the bitmap API to allocate bitmaps

Eric Lin (1):
      drivers/perf: riscv_pmu: Add riscv pmu pm notifier

Francis Laniel (1):
      arm64: Do not forget syscall when starting a new thread.

Gavin Shan (1):
      arm64: numa: Don't check node against MAX_NUMNODES

Guangbin Huang (2):
      drivers/perf: hisi: Add description for HNS3 PMU driver
      drivers/perf: hisi: add driver for HNS3 PMU

James Morse (2):
      arm64: errata: Add Cortex-A510 to the repeat tlbi list
      arm64: errata: Remove AES hwcap for COMPAT tasks

Jisheng Zhang (1):
      arm64: boot: add zstd support

Joey Gouly (7):
      arm64: vdso: put ELF related sections in the linker script
      arm64: vdso: enable orphan handling for VDSO
      arm64: vdso32: put ELF related sections in the linker script
      arm64: vdso32: enable orphan handling for VDSO
      arm64: vdso32: add ARM.exidx* sections
      arm64: vdso*: place got/plt sections in .rodata
      arm64/mm: use GENMASK_ULL for TTBR_BADDR_MASK_52

Julia Lawall (1):
      perf/arm-cci: fix typo in comment

Kefeng Wang (8):
      asm-generic: Add memory barrier dma_mb()
      arm64: kcsan: Support detecting more missing memory barriers
      ARM: mm: kill unused runtime hook arch_iounmap()
      mm: ioremap: Use more sensible name in ioremap_prot()
      mm: ioremap: Setup phys_addr of struct vm_struct
      mm: ioremap: Add ioremap/iounmap_allowed()
      arm64: mm: Convert to GENERIC_IOREMAP
      arm64: Add HAVE_IOREMAP_PROT support

Kristina Martsenko (1):
      arm64: trap implementation defined functionality in userspace

Liang He (1):
      perf: RISC-V: Add of_node_put() when breaking out of for_each_of_cpu_node()

Liu Song (1):
      arm64: correct the effect of mitigations off on kpti

Madhavan T. Venkataraman (2):
      arm64: Split unwind_init()
      arm64: Copy the task argument to unwind_state

Marc Zyngier (10):
      arm64: Rename the VHE switch to "finalise_el2"
      arm64: Save state of HCR_EL2.E2H before switch to EL1
      arm64: Allow sticky E2H when entering EL1
      arm64: Factor out checking of a feature against the override into a macro
      arm64: Allow the idreg override to deal with variable field width
      arm64: Expose a __check_override primitive for oddball features
      arm64: Add the arm64.nosme command line option
      arm64: Add the arm64.nosve command line option
      arm64: Add an override for ID_AA64SMFR0_EL1.FA64
      arm64: Delay initialisation of cpuinfo_arm64::reg_{zcr,smcr}

Mark Brown (33):
      arm64/sme: Expose SMIDR through sysfs
      arm64/signal: Clean up SVE/SME feature checking inconsistency
      arm64/cpuinfo: Remove references to reserved cache type
      arm64/idreg: Fix tab/space damage
      arm64/sysreg: Allow leading blanks on comments in sysreg file
      arm64/sysreg: Add SYS_FIELD_GET() helper
      arm64/cache: Restrict which headers are included in __ASSEMBLY__
      arm64/sysreg: Standardise naming for CTR_EL0 fields
      arm64/sysreg: Standardise naming for DCZID_EL0 field names
      arm64/mte: Standardise GMID field name definitions
      arm64/sysreg: Align pointer auth enumeration defines with architecture
      arm64/sysreg: Make BHB clear feature defines match the architecture
      arm64/sysreg: Standardise naming for WFxT defines
      arm64/sysreg: Standardise naming for ID_AA64SMFR0_EL1 enums
      arm64/sysreg: Standardise naming for ID_AA64ZFR0_EL1 fields
      arm64/sysreg: Remove defines for RPRES enumeration
      arm64/sysreg: Add _EL1 into ID_AA64ISAR1_EL1 definition names
      arm64/sysreg: Add _EL1 into ID_AA64ISAR2_EL1 definition names
      arm64/sysreg: Convert CTR_EL0 to automatic generation
      arm64/sysreg: Convert DCZID_EL0 to automatic generation
      arm64/sysreg: Convert GMID to automatic generation
      arm64/sysreg: Convert ID_AA64ISAR1_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64ISAR2_EL1 to automatic generation
      arm64/sysreg: Convert LORSA_EL1 to automatic generation
      arm64/sysreg: Convert LOREA_EL1 to automatic generation
      arm64/sysreg: Convert LORN_EL1 to automatic generation
      arm64/sysreg: Convert LORC_EL1 to automatic generation
      arm64/sysreg: Convert LORID_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64SMFR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64ZFR0_EL1 to automatic generation
      arm64/hwcap: Document allocation of upper bits of AT_HWCAP
      arm64/cpufeature: Store elf_hwcaps as a bitmap rather than unsigned long
      arm64/hwcap: Support FEAT_EBF16

Mark Rutland (6):
      arch: make TRACE_IRQFLAGS_NMI_SUPPORT generic
      arm64: select TRACE_IRQFLAGS_NMI_SUPPORT
      arm64: asm-extable: move data fields
      arm64: asm-extable: add asm uacess helpers
      arm64: head: remove __PHYS_OFFSET
      arm64: fix KASAN_INLINE

Michael Walle (2):
      cpuidle: cpuidle-arm: remove arm64 support
      arm64: cpuidle: remove generic cpuidle support

Nathan Chancellor (2):
      arm64: vdso32: Shuffle .ARM.exidx section above ELF_DETAILS
      arm64: vdso32: Add DWARF_DEBUG

Nikita Shubin (1):
      drivers/perf: riscv_pmu_sbi: perf format

Schspa Shi (1):
      arm64/fpsimd: Remove duplicate SYS_SVCR read

Tanmay Jagdale (1):
      perf/marvell_cn10k: Fix TAD PMU register offset

Tong Tiangen (4):
      arm64: extable: add new extable type EX_TYPE_KACCESS_ERR_ZERO support
      arm64: extable: make uaaccess helper use extable type EX_TYPE_UACCESS_ERR_ZERO
      arm64: extable: move _cond_extable to _cond_uaccess_extable
      arm64: extable: cleanup redundant extable type EX_TYPE_FIXUP

Will Deacon (20):
      arm64: mm: Remove assembly DMA cache maintenance wrappers
      docs: perf: Include hns3-pmu.rst in toctree to fix 'htmldocs' WARNING
      Merge branch 'for-next/cpuidle' into for-next/core
      Merge branch 'for-next/docs' into for-next/core
      Merge branch 'for-next/errata' into for-next/core
      Merge branch 'for-next/extable' into for-next/core
      Merge branch 'for-next/ioremap' into for-next/core
      Merge branch 'for-next/irqflags-nmi' into for-next/core
      Merge branch 'for-next/kcsan' into for-next/core
      Merge branch 'for-next/kpti' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/mte' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/sme' into for-next/core
      Merge branch 'for-next/stacktrace' into for-next/core
      Merge branch 'for-next/sysregs' into for-next/core
      Merge branch 'for-next/vdso' into for-next/core
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/boot' into for-next/core

haibinzhang (张海斌) (1):
      arm64: fix oops in concurrently setting insn_emulation sysctls

keliu (2):
      drivers/perf: Directly use ida_alloc()/free()
      drivers/perf:Directly use ida_alloc()/free()

 Documentation/ABI/testing/sysfs-devices-system-cpu |    3 +-
 Documentation/admin-guide/kernel-parameters.txt    |    8 +-
 Documentation/admin-guide/perf/hns3-pmu.rst        |  136 ++
 Documentation/admin-guide/perf/index.rst           |    1 +
 Documentation/arm64/elf_hwcaps.rst                 |    4 +
 Documentation/arm64/memory.rst                     |   10 +-
 Documentation/arm64/silicon-errata.rst             |    6 +
 .../features/vm/ioremap_prot/arch-support.txt      |    2 +-
 Documentation/memory-barriers.txt                  |   11 +-
 Documentation/virt/kvm/arm/hyp-abi.rst             |   11 +-
 MAINTAINERS                                        |    6 +
 arch/Kconfig                                       |    3 +
 arch/arm/include/asm/io.h                          |    4 +-
 arch/arm/mm/ioremap.c                              |    9 +-
 arch/arm/mm/nommu.c                                |    9 +-
 arch/arm64/Kconfig                                 |   37 +
 arch/arm64/boot/Makefile                           |    5 +-
 arch/arm64/include/asm/asm-extable.h               |   79 +-
 arch/arm64/include/asm/asm-uaccess.h               |   12 +-
 arch/arm64/include/asm/asm_pointer_auth.h          |    4 +-
 arch/arm64/include/asm/assembler.h                 |   35 +-
 arch/arm64/include/asm/barrier.h                   |   12 +-
 arch/arm64/include/asm/cache.h                     |   41 +-
 arch/arm64/include/asm/cacheflush.h                |    7 -
 arch/arm64/include/asm/cpu.h                       |    1 +
 arch/arm64/include/asm/cpu_ops.h                   |    9 -
 arch/arm64/include/asm/cpufeature.h                |    7 +-
 arch/arm64/include/asm/cpuidle.h                   |   15 -
 arch/arm64/include/asm/el2_setup.h                 |   60 -
 arch/arm64/include/asm/fixmap.h                    |    4 +-
 arch/arm64/include/asm/hwcap.h                     |    3 +-
 arch/arm64/include/asm/io.h                        |   24 +-
 arch/arm64/include/asm/kernel-pgtable.h            |   18 +-
 arch/arm64/include/asm/memory.h                    |    9 +
 arch/arm64/include/asm/mmu_context.h               |   16 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |    3 +-
 arch/arm64/include/asm/pgtable.h                   |   16 +
 arch/arm64/include/asm/processor.h                 |    3 +-
 arch/arm64/include/asm/sysreg.h                    |  128 +-
 arch/arm64/include/asm/uaccess.h                   |   94 +-
 arch/arm64/include/asm/virt.h                      |   11 +-
 arch/arm64/include/uapi/asm/hwcap.h                |    4 +
 arch/arm64/kernel/Makefile                         |    7 +-
 arch/arm64/kernel/acpi.c                           |    2 +-
 arch/arm64/kernel/acpi_numa.c                      |    2 +-
 arch/arm64/kernel/alternative.c                    |    2 +-
 arch/arm64/kernel/armv8_deprecated.c               |    9 +-
 arch/arm64/kernel/cpu_errata.c                     |   26 +-
 arch/arm64/kernel/cpufeature.c                     |  376 +++--
 arch/arm64/kernel/cpuidle.c                        |   29 -
 arch/arm64/kernel/cpuinfo.c                        |   51 +-
 arch/arm64/kernel/entry.S                          |   53 +-
 arch/arm64/kernel/fpsimd.c                         |    1 -
 arch/arm64/kernel/head.S                           |  525 +++---
 arch/arm64/kernel/hibernate.c                      |    5 -
 arch/arm64/kernel/hyp-stub.S                       |  117 +-
 arch/arm64/kernel/idreg-override.c                 |   93 +-
 arch/arm64/kernel/image-vars.h                     |   59 +-
 arch/arm64/kernel/kaslr.c                          |  149 +-
 arch/arm64/kernel/kuser32.S                        |    1 +
 arch/arm64/kernel/mte.c                            |    9 -
 arch/arm64/kernel/pi/Makefile                      |   33 +
 arch/arm64/kernel/pi/kaslr_early.c                 |  112 ++
 arch/arm64/kernel/signal.c                         |   20 +-
 arch/arm64/kernel/sigreturn32.S                    |    1 +
 arch/arm64/kernel/sleep.S                          |    3 +-
 arch/arm64/kernel/stacktrace.c                     |   99 +-
 arch/arm64/kernel/suspend.c                        |    2 +-
 arch/arm64/kernel/traps.c                          |    6 +-
 arch/arm64/kernel/vdso/Makefile                    |    8 +-
 arch/arm64/kernel/vdso/vdso.lds.S                  |   16 +-
 arch/arm64/kernel/vdso32/Makefile                  |    1 +
 arch/arm64/kernel/vdso32/vdso.lds.S                |   27 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   22 +-
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h     |   32 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |   12 +-
 arch/arm64/kvm/sys_regs.c                          |   14 +-
 arch/arm64/lib/mte.S                               |    2 +-
 arch/arm64/mm/cache.S                              |   41 -
 arch/arm64/mm/copypage.c                           |    9 -
 arch/arm64/mm/dma-mapping.c                        |   19 +-
 arch/arm64/mm/extable.c                            |   10 +-
 arch/arm64/mm/fault.c                              |    1 -
 arch/arm64/mm/hugetlbpage.c                        |   10 -
 arch/arm64/mm/init.c                               |    4 +-
 arch/arm64/mm/ioremap.c                            |   90 +-
 arch/arm64/mm/kasan_init.c                         |    4 +-
 arch/arm64/mm/mmu.c                                |   78 +-
 arch/arm64/mm/mteswap.c                            |    9 -
 arch/arm64/mm/proc.S                               |  188 +--
 arch/arm64/tools/cpucaps                           |    2 +
 arch/arm64/tools/gen-sysreg.awk                    |    2 +-
 arch/arm64/tools/sysreg                            |  264 ++++
 arch/x86/Kconfig                                   |    1 +
 arch/x86/Kconfig.debug                             |    3 -
 drivers/cpuidle/Kconfig.arm                        |    3 +-
 drivers/perf/arm-cci.c                             |   11 +-
 drivers/perf/arm-ccn.c                             |    6 +-
 drivers/perf/arm_spe_pmu.c                         |   22 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |    6 +-
 drivers/perf/hisilicon/Kconfig                     |   10 +
 drivers/perf/hisilicon/Makefile                    |    1 +
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |   16 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |   16 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |   16 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |   16 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   18 +
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |    2 +
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      |   15 +-
 drivers/perf/hisilicon/hns3_pmu.c                  | 1671 ++++++++++++++++++++
 drivers/perf/marvell_cn10k_tad_pmu.c               |   12 +-
 drivers/perf/riscv_pmu.c                           |    4 +-
 drivers/perf/riscv_pmu_sbi.c                       |  106 +-
 include/asm-generic/barrier.h                      |    8 +
 include/asm-generic/io.h                           |   29 +-
 include/linux/cpuhotplug.h                         |    1 +
 include/linux/gfp.h                                |    2 +-
 include/linux/huge_mm.h                            |   12 +
 include/linux/perf/riscv_pmu.h                     |    4 +
 mm/ioremap.c                                       |   26 +-
 mm/kasan/common.c                                  |    3 +-
 mm/page_alloc.c                                    |   19 +-
 mm/swap_slots.c                                    |    2 +-
 123 files changed, 3971 insertions(+), 1627 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/hns3-pmu.rst
 create mode 100644 arch/arm64/kernel/pi/Makefile
 create mode 100644 arch/arm64/kernel/pi/kaslr_early.c
 create mode 100644 drivers/perf/hisilicon/hns3_pmu.c
