Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CADE4E81C7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiCZP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 11:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiCZP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:28:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5641267FB8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=O0VtKc6WFSc1XrR9kHmafS5p3UXLmcpn777jxh7QGhc=; b=vcuVNITPHCsWJxpOyPR297SHAC
        oRKWbyDe095B17oyKxNNeo1BOBChEdD1BsOPujPNpltKPDL6S1ksRVAtp8dhbVv/6D35OTx0d++8b
        PUtF4NgtHPsB8VnFcOFpHRsEJZ5LbOoie+5pcWP1vvFXqMdMQY72RckwGjkRftDb2uDbJdLybzb7y
        dMvah4F9Bhu1v2l5/Lm43tfub6y2nIwL2MzlF6S1EHmAHA8Pc+vjcxHp9SBIMOqJ5U7OsvyTHcA2U
        dDnkMNi6F1N4ri88STR8B+fRrt7KLNAcU4Py9DP575oVf43sS4xPfw42Shj7aCKT1KnwxGjIY/B2l
        07gIeIvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nY8JU-00FLFg-U0; Sat, 26 Mar 2022 15:26:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 977B59861FE; Sat, 26 Mar 2022 16:26:46 +0100 (CET)
Date:   Sat, 26 Mar 2022 16:26:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        alexei.starovoitov@gmail.com, christophe.leroy@csgroup.eu
Subject: [GIT PULL] x86/core for 5.18
Message-ID: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, my first pull request in like forever, so please bear with me.

Boris talked me through it, so hopefully it isn't entirely insane :-)

There's two small conflicts, for which I've added a resolution, just in
case that's needed, I know you like to see and do these things yourself.

---

The following changes since commit fe83f5eae432ccc8e90082d6ed506d5233547473:

  kvm/emulate: Fix SETcc emulation function offsets with SLS (2022-03-20 14:55:46 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86_core_for_5.18_rc1

for you to fetch changes up to 3986f65d4f408ce9d0a361e3226a3246a5fb701c:

  kvm/emulate: Fix SETcc emulation for ENDBR (2022-03-22 21:12:14 +0100)

----------------------------------------------------------------

Add support for Intel CET-IBT, available since Tigerlake (11th gen), which is a
coarse grained, hardware based, forward edge Control-Flow-Integrity mechanism
where any indirect CALL/JMP must target an ENDBR instruction or suffer #CP.

Additionally, since Alderlake (12th gen)/Sapphire-Rapids, speculation is
limited to 2 instructions (and typically fewer) on branch targets not starting
with ENDBR. CET-IBT also limits speculation of the next sequential instruction
after the indirect CALL/JMP [1].

CET-IBT is fundamentally incompatible with retpolines, but provides, as
described above, speculation limits itself.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/branch-history-injection.html

----------------------------------------------------------------

    # Conflicts:
    #       arch/powerpc/include/asm/livepatch.h
    #       arch/x86/net/bpf_jit_comp.c

diff --cc arch/powerpc/include/asm/livepatch.h
index 6f10de6af6e3,7b9dcd51af32..1c60094ea0cd
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@@ -14,21 -14,11 +14,11 @@@
  #ifdef CONFIG_LIVEPATCH
  static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
  {
 -	struct pt_regs *regs = ftrace_get_regs(fregs);
 -
 -	regs_set_return_ip(regs, ip);
 +	ftrace_instruction_pointer_set(fregs, ip);
  }
- 
- #define klp_get_ftrace_location klp_get_ftrace_location
- static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
- {
- 	/*
- 	 * Live patch works on PPC32 and only with -mprofile-kernel on PPC64. In
- 	 * both cases, the ftrace location is always within the first 16 bytes.
- 	 */
- 	return ftrace_location_range(faddr, faddr + 16);
- }
 +#endif /* CONFIG_LIVEPATCH */
  
 +#ifdef CONFIG_LIVEPATCH_64
  static inline void klp_init_thread_info(struct task_struct *p)
  {
  	/* + 1 to account for STACK_END_MAGIC */
diff --cc arch/x86/net/bpf_jit_comp.c
index 6efbb87f65ed,b592ea0fc150..8fe35ed11fd6
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@@ -380,7 -395,14 +391,14 @@@ int bpf_arch_text_poke(void *ip, enum b
  		/* BPF poking in modules is not supported */
  		return -EINVAL;
  
+ 	/*
+ 	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
+ 	 * with an ENDBR instruction.
+ 	 */
+ 	if (is_endbr(*(u32 *)ip))
+ 		ip += ENDBR_INSN_SIZE;
+ 
 -	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 +	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
  }
  
  #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)

----------------------------------------------------------------
Fenghua Yu (1):
      tools/objtool: Check for use of the ENQCMD instruction in the kernel

Ingo Molnar (2):
      Merge branch 'x86/pasid' into x86/core, to resolve conflicts
      Merge branch 'x86/cpu' into x86/core, to resolve conflicts

Masahiro Yamada (1):
      x86: Remove toolchain check for X32 ABI capability

Nathan Chancellor (3):
      x86/Kconfig: Do not allow CONFIG_X86_X32_ABI=y with llvm-objcopy
      x86/Kconfig: Only enable CONFIG_CC_HAS_IBT for clang >= 14.0.0
      x86/Kconfig: Only allow CONFIG_X86_KERNEL_IBT with ld.lld >= 14.0.0

Peter Zijlstra (50):
      Merge branch 'arm64/for-next/linkage'
      static_call: Avoid building empty .static_call_sites
      objtool: Add --dry-run
      objtool: Default ignore INT3 for unreachable
      objtool,efi: Update __efi64_thunk annotation
      objtool: Have WARN_FUNC fall back to sym+off
      x86/ibt: Base IBT bits
      x86/ibt: Add ANNOTATE_NOENDBR
      x86/text-patching: Make text_gen_insn() play nice with ANNOTATE_NOENDBR
      x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()
      x86/entry: Cleanup PARAVIRT
      x86/entry,xen: Early rewrite of restore_regs_and_return_to_kernel()
      x86/ibt,xen: Sprinkle the ENDBR
      x86/ibt,entry: Sprinkle ENDBR dust
      x86/linkage: Add ENDBR to SYM_FUNC_START*()
      x86/ibt,paravirt: Sprinkle ENDBR
      x86/ibt,crypto: Add ENDBR for the jump-table entries
      x86/ibt,kvm: Add ENDBR to fastops
      x86/ibt,ftrace: Search for __fentry__ location
      x86/livepatch: Validate __fentry__ location
      x86/ibt,ftrace: Make function-graph play nice
      x86/ibt,kprobes: Cure sym+0 equals fentry woes
      x86/ibt,bpf: Add ENDBR instructions to prologue and trampoline
      x86/ibt,ftrace: Add ENDBR to samples/ftrace
      x86/ibt: Add IBT feature, MSR and #CP handling
      x86/ibt,kexec: Disable CET on kexec
      x86/alternative: Simplify int3_selftest_ip
      x86/ibt: Disable IBT around firmware
      x86/ibt: Annotate text references
      x86/ibt,ftrace: Annotate ftrace code patching
      x86/ibt,sev: Annotations
      x86/ibt: Dont generate ENDBR in .discard.text
      x86/ibt: Ensure module init/exit points have references
      objtool: Rename --duplicate to --lto
      objtool: Ignore extra-symbol code
      x86: Mark stop_this_cpu() __noreturn
      exit: Mark do_group_exit() __noreturn
      x86: Mark __invalid_creds() __noreturn
      objtool: Rework ASM_REACHABLE
      x86: Annotate call_on_stack()
      x86,objtool: Move the ASM_REACHABLE annotation to objtool.h
      x86: Annotate idtentry_df()
      objtool: Read the NOENDBR annotation
      objtool: Add IBT/ENDBR decoding
      objtool: Validate IBT assumptions
      objtool: Find unused ENDBR instructions
      x86/alternative: Use .ibt_endbr_seal to seal indirect calls
      kbuild: Fixup the IBT kbuild changes
      Merge branch 'kvm/kvm-sls-fix'
      kvm/emulate: Fix SETcc emulation for ENDBR

 Documentation/ABI/stable/sysfs-devices-system-cpu  |   4 +
 Documentation/ABI/testing/sysfs-devices-system-cpu |   6 +
 Documentation/asm-annotations.rst                  |  11 +-
 Documentation/x86/sva.rst                          |  53 ++-
 arch/arm64/include/asm/linkage.h                   |  24 --
 arch/arm64/include/asm/module.lds.h                |   6 +-
 arch/arm64/kvm/hyp/nvhe/cache.S                    |   5 +-
 arch/arm64/lib/clear_page.S                        |   5 +-
 arch/arm64/lib/copy_page.S                         |   5 +-
 arch/arm64/lib/memchr.S                            |   5 +-
 arch/arm64/lib/memcmp.S                            |   6 +-
 arch/arm64/lib/memcpy.S                            |  21 +-
 arch/arm64/lib/memset.S                            |  12 +-
 arch/arm64/lib/strchr.S                            |   6 +-
 arch/arm64/lib/strcmp.S                            |   6 +-
 arch/arm64/lib/strlen.S                            |   6 +-
 arch/arm64/lib/strncmp.S                           |   6 +-
 arch/arm64/lib/strnlen.S                           |   6 +-
 arch/arm64/lib/strrchr.S                           |   5 +-
 arch/arm64/mm/cache.S                              |  35 +-
 arch/powerpc/include/asm/livepatch.h               |  10 -
 arch/powerpc/kernel/kprobes.c                      |  34 +-
 arch/um/kernel/um_arch.c                           |   4 +
 arch/x86/Kconfig                                   |  43 ++-
 arch/x86/Makefile                                  |  32 +-
 arch/x86/boot/compressed/head_32.S                 |   3 +-
 arch/x86/boot/compressed/head_64.S                 |   3 +-
 arch/x86/crypto/aesni-intel_asm.S                  |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S          |   3 +
 arch/x86/entry/entry_64.S                          |  31 +-
 arch/x86/entry/entry_64_compat.S                   |   5 +
 arch/x86/entry/syscalls/Makefile                   |   2 +-
 arch/x86/include/asm/alternative.h                 |   1 +
 arch/x86/include/asm/bug.h                         |   1 +
 arch/x86/include/asm/cpu.h                         |   4 +
 arch/x86/include/asm/cpufeatures.h                 |   7 +-
 arch/x86/include/asm/disabled-features.h           |   7 +-
 arch/x86/include/asm/efi.h                         |   9 +-
 arch/x86/include/asm/ibt.h                         | 105 ++++++
 arch/x86/include/asm/idtentry.h                    |  25 +-
 arch/x86/include/asm/irq_stack.h                   |   4 +-
 arch/x86/include/asm/irqflags.h                    |   5 -
 arch/x86/include/asm/linkage.h                     |  31 ++
 arch/x86/include/asm/msr-index.h                   |  20 +-
 arch/x86/include/asm/paravirt.h                    |   1 +
 arch/x86/include/asm/paravirt_types.h              |   1 -
 arch/x86/include/asm/processor.h                   |   4 +-
 arch/x86/include/asm/qspinlock_paravirt.h          |   3 +
 arch/x86/include/asm/segment.h                     |   5 +-
 arch/x86/include/asm/setup.h                       |   3 +-
 arch/x86/include/asm/syscall_wrapper.h             |   6 +-
 arch/x86/include/asm/text-patching.h               |  30 +-
 arch/x86/include/asm/topology.h                    |   1 +
 arch/x86/include/asm/traps.h                       |   2 +
 arch/x86/include/asm/vdso.h                        |   2 +-
 arch/x86/include/uapi/asm/processor-flags.h        |   2 +
 arch/x86/kernel/alternative.c                      |  66 +++-
 arch/x86/kernel/apm_32.c                           |   7 +
 arch/x86/kernel/cpu/amd.c                          |  35 +-
 arch/x86/kernel/cpu/common.c                       | 138 ++++++-
 arch/x86/kernel/cpu/mce/amd.c                      |   7 +-
 arch/x86/kernel/cpu/mce/core.c                     |   7 +-
 arch/x86/kernel/cpu/mce/intel.c                    |  42 ---
 arch/x86/kernel/cpu/scattered.c                    |   1 +
 arch/x86/kernel/fpu/core.c                         |   7 +
 arch/x86/kernel/ftrace.c                           |   9 +-
 arch/x86/kernel/ftrace_64.S                        |  28 +-
 arch/x86/kernel/head_64.S                          |  14 +-
 arch/x86/kernel/idt.c                              |   9 +-
 arch/x86/kernel/kprobes/core.c                     |  29 +-
 arch/x86/kernel/kvm.c                              |   3 +-
 arch/x86/kernel/machine_kexec_64.c                 |   4 +-
 arch/x86/kernel/module.c                           |   8 +-
 arch/x86/kernel/paravirt.c                         |  29 +-
 arch/x86/kernel/process.c                          |   7 +-
 arch/x86/kernel/process_64.c                       |   2 +-
 arch/x86/kernel/relocate_kernel_64.S               |  10 +
 arch/x86/kernel/traps.c                            | 130 +++++++
 arch/x86/kernel/vmlinux.lds.S                      |   9 +
 arch/x86/kvm/emulate.c                             |  16 +-
 arch/x86/lib/error-inject.c                        |   2 +
 arch/x86/lib/memcpy_64.S                           |  10 +-
 arch/x86/lib/memmove_64.S                          |   4 +-
 arch/x86/lib/memset_64.S                           |   6 +-
 arch/x86/lib/retpoline.S                           |   1 +
 arch/x86/net/bpf_jit_comp.c                        |  26 +-
 arch/x86/platform/efi/Makefile                     |   1 -
 arch/x86/platform/efi/efi_thunk_64.S               |   6 +-
 arch/x86/xen/enlighten_pv.c                        |  10 +-
 arch/x86/xen/xen-asm.S                             |  10 +
 arch/x86/xen/xen-head.S                            |   9 +-
 drivers/base/topology.c                            |  20 +-
 drivers/iommu/Kconfig                              |   6 +-
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   5 +-
 drivers/iommu/intel/Kconfig                        |   2 +-
 drivers/iommu/intel/iommu.c                        |   4 +-
 drivers/iommu/intel/svm.c                          |   9 -
 drivers/iommu/ioasid.c                             |  39 +-
 drivers/iommu/iommu-sva-lib.c                      |  39 +-
 drivers/iommu/iommu-sva-lib.h                      |   7 +-
 fs/fuse/ioctl.c                                    |   2 +-
 fs/xfs/xfs_ioctl32.c                               |   2 +-
 include/asm-generic/vmlinux.lds.h                  |   4 +
 include/linux/cfi.h                                |  11 +-
 include/linux/compiler.h                           |   7 -
 include/linux/cred.h                               |   2 +-
 include/linux/ioasid.h                             |  21 +-
 include/linux/kprobes.h                            |   3 +-
 include/linux/linkage.h                            |  67 ++--
 include/linux/mm_types.h                           |   2 +-
 include/linux/objtool.h                            |  32 ++
 include/linux/sched.h                              |   3 +
 include/linux/sched/mm.h                           |  26 ++
 include/linux/sched/task.h                         |   2 +-
 include/linux/topology.h                           |   3 +
 kernel/bpf/trampoline.c                            |  20 +-
 kernel/cred.c                                      |   2 +-
 kernel/exit.c                                      |   2 +-
 kernel/fork.c                                      |  15 +-
 kernel/kprobes.c                                   |  74 ++--
 kernel/livepatch/patch.c                           |  19 +-
 kernel/trace/ftrace.c                              |  48 ++-
 mm/init-mm.c                                       |   4 +
 samples/ftrace/ftrace-direct-modify.c              |   5 +
 samples/ftrace/ftrace-direct-multi-modify.c        |  10 +-
 samples/ftrace/ftrace-direct-multi.c               |   5 +-
 samples/ftrace/ftrace-direct-too.c                 |   3 +
 samples/ftrace/ftrace-direct.c                     |   3 +
 scripts/Makefile.build                             |  27 +-
 scripts/Makefile.lib                               |   4 +-
 scripts/link-vmlinux.sh                            |  12 +-
 scripts/mod/modpost.c                              |  12 +-
 sound/core/control_compat.c                        |  16 +-
 sound/core/pcm_compat.c                            |  20 +-
 tools/arch/x86/lib/memcpy_64.S                     |  10 +-
 tools/arch/x86/lib/memset_64.S                     |   6 +-
 tools/include/linux/objtool.h                      |  32 ++
 tools/objtool/arch/x86/decode.c                    |  43 ++-
 tools/objtool/builtin-check.c                      |   7 +-
 tools/objtool/check.c                              | 400 +++++++++++++++++++--
 tools/objtool/elf.c                                |  63 ++++
 tools/objtool/include/objtool/arch.h               |   1 +
 tools/objtool/include/objtool/builtin.h            |   3 +-
 tools/objtool/include/objtool/check.h              |  13 +-
 tools/objtool/include/objtool/elf.h                |   1 +
 tools/objtool/include/objtool/objtool.h            |   4 +
 tools/objtool/include/objtool/warn.h               |   2 +
 tools/objtool/objtool.c                            |   1 +
 tools/perf/util/include/linux/linkage.h            |  52 ++-
 150 files changed, 1947 insertions(+), 700 deletions(-)
 create mode 100644 arch/x86/include/asm/ibt.h
