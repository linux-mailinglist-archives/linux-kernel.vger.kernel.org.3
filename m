Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D405C5155C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380847AbiD2UkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349590AbiD2UkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E5F83019
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f83cc145edso84212547b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MegzHCUKl9bZRKyWJryCWFanU+3QTq1uqFqNfNdcp1U=;
        b=OaqBerHn3Y/lAZochJD93816tJcalYdCONu3nn/3uzGUgV4IF7MJnz/bOWNjmzhrdW
         IYyeSBDhNs1RhFW5x04tx7/LK0XD9fFHVKHZoOgl5EbVMmYiWaE0AeqwB0XEMd50iqoG
         5ibyncxUJZ+k9aIqdL52P6MbStLnBRl5LskBuAX1503ah3mtkUhOgIe/r6DC4vmNPl2G
         6JS3ZnFI7xMPsEDgdwKVsvuRzn9XPjF9Ug+RnkuVYxb6hANjBj10txsQzkgVWiGObpkF
         Ka+faORzx0le0lOf78PdX2liqVoL1YtXY4EEyoRK7nyRtUc9tQV0nSjXJNheva95Xy/n
         3WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MegzHCUKl9bZRKyWJryCWFanU+3QTq1uqFqNfNdcp1U=;
        b=LIaI7SOLiXlIrrfHyQltGWMUVvobWbNmurZGHOgYLTUnjuFxldNaCcEWNUzTqIGxi1
         V4J4MkRA0VUb6MNsHNO5NQigzJac/YtQf+TUxdyhZ7z07dg2D4Ec0U9DLHDIrIEL/Wcz
         NyvNPEdi+eBAEYb5ZNNE/x0tjSe8bCoUxbTsi66H6FNfYI/rOJD+BbAivZOnqdywWEVr
         eRxaObkh4R0aQM9YS/ls9rTJhYdCyeYV4HpC5XL2LH5DnaH49inRTyDD94r/NxuZKbQ6
         QiD4cS1UPJaAuzorR3Ca4iIAjtqGBlbzBOZcPVmMTtnGcqaU4D/RdI1OSi5mG4lZmX38
         GyQw==
X-Gm-Message-State: AOAM531PfcHyUmwqLMlTi7EBv78g+byz4el5BFKlYFSe9Ir3I+LQOCLZ
        TQn+p1VQ5zl1blpdKgsZQUKkaJQfU412H+0EBsR9xrL+h1lMJxI9RPDCrV1nenxecLnlKC4NQTT
        bInH0SS0D3XGy3SynNS722AAmjok1OkvfOWCzPftJGn1gb+gSpipJY1bz/ovFHTsEkw9PgM29+m
        5aShDINsSE1g==
X-Google-Smtp-Source: ABdhPJyio4MtmnhBGmkLGk678vdjpsFxGW0jft/fZMlB8G4BO22hETb7+iNeMXAut+zUXIRuWmeclrXdGab3OE258eU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:37cd:0:b0:648:3b1a:97e4 with SMTP
 id e196-20020a2537cd000000b006483b1a97e4mr1272372yba.624.1651264607285; Fri,
 29 Apr 2022 13:36:47 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:23 -0700
Message-Id: <20220429203644.2868448-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7763; h=from:subject;
 bh=Y5sqA/70oYhk0R144QR9LlAfelh5tkejjJm3VYpdAzo=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExUWv4g8pmw5iLjb/OQbuGWfKBCh3Cqp9nzOMPR
 CBJsyZ6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVAAKCRBMtfaEi7xW7v8wC/
 94FDsOKFoqzKZQhC/RXtvjgtYXoam8m58rZjXy8I58uTTSsbzXNNrAQhPNNy1hRngOyjaClVhm48re
 lmh5ijp8raC0b7lrmdjYZo7yILyGkLghZ6NhgIL8Xeih8L8/RckgnhYZwEyKlVGzWV59SS9aoQyJ0p
 1wYbPUxIiac5Y89rPzMh18R/XF7D70tShHpfBT3hys9NNm70RGRq8DGrDpWLE67bDYX2UAWiDA8gyr
 JVfEMq8x+qxRoZHHHKOcP4vsO2abvLUq7aMTEHLUAW8z1Z0XOkHoxrXOw2AZGWPEFv1QeBmo+eWQf0
 ggFY+f5YbZKtnyjdly8nnUpGhZcUE21iN/xNBscr6tCDu1IAUxePnxgrLlUeuifyLki2Fqmdea0nle
 Dh9b7ql363u+Sx+GdGt2Z+sMHJHjmiZtwtpfyOkspzYxUIjShERQSJwxMJz4ywAcQIzfZj3t5zgOi3
 Zs1DXthiB5ELW9KPxHMi1qalz5qRy7Gf8xg6tHtGHoQIU=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 00/21] KCFI support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCFI is a proposed forward-edge control-flow integrity scheme for
Clang, which is more suitable for kernel use than the existing CFI
scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
alter function references to point to a jump table, and won't break
function address equality. The latest LLVM patches are here:

  https://reviews.llvm.org/D119296
  https://reviews.llvm.org/D124211

This RFC series replaces the current arm64 CFI implementation with
KCFI and adds support for x86_64.

The proposed compiler patches add a built-in function that allows
CFI checks to be disabled for specific indirect calls. This is
necessary to prevent unnecessary checks from being emitted for
static_call trampoline calls that are later patched into direct
calls. However, as the call expression must be passed as an argument
to the built-in, this requires changing the static_call macro API to
include the call arguments. Patch 14 changes the macros to accept
arguments and patch 15 disables checks for the generated calls.

KCFI also requires assembly functions that are indirectly called
from C code to be annotated with type identifiers. As type
information is only available in C, the compiler emits expected
type identifiers into the symbol table, so they can be referenced
from assembly without having to hardcode type hashes. Patch 7 adds
helper macros for annotating functions, and patches 8 and 18 add
annotations.

In case of a type mismatch, KCFI always traps. To support error
handling, the compiler generates a .kcfi_traps section that contains
the locations of each trap. Patches 9 and 21 add arch-specific error
handlers. In addition, to support x86_64, objtool must be able to
identify KCFI type identifiers that are emitted before function
entries. The compiler generates an additional .kcfi_types section,
which points to each emitted type identifier. Patch 16 adds objtool
support.

To test this series, you'll need to compile your own Clang toolchain
with the patches linked above. You can also find the complete source
tree here:

  https://github.com/samitolvanen/llvm-project/commits/kcfi-rfc

This series is also available in GitHub:

  https://github.com/samitolvanen/linux/commits/kcfi-rfc


Sami Tolvanen (21):
  efi/libstub: Filter out CC_FLAGS_CFI
  arm64/vdso: Filter out CC_FLAGS_CFI
  kallsyms: Ignore __kcfi_typeid_
  cfi: Remove CONFIG_CFI_CLANG_SHADOW
  cfi: Drop __CFI_ADDRESSABLE
  cfi: Switch to -fsanitize=kcfi
  cfi: Add type helper macros
  arm64/crypto: Add types to indirect called assembly functions
  arm64: Add CFI error handling
  treewide: Drop function_nocfi
  treewide: Drop WARN_ON_FUNCTION_MISMATCH
  treewide: Drop __cficanonical
  cfi: Add the cfi_unchecked macro
  treewide: static_call: Pass call arguments to the macro
  static_call: Use cfi_unchecked
  objtool: Add support for CONFIG_CFI_CLANG
  x86/tools/relocs: Ignore __kcfi_typeid_ relocations
  x86: Add types to indirect called assembly functions
  x86/purgatory: Disable CFI
  x86/vdso: Disable CFI
  x86: Add support for CONFIG_CFI_CLANG

 Makefile                                  |  13 +-
 arch/Kconfig                              |  18 +-
 arch/arm/include/asm/paravirt.h           |   2 +-
 arch/arm64/crypto/ghash-ce-core.S         |   5 +-
 arch/arm64/crypto/sm3-ce-core.S           |   3 +-
 arch/arm64/include/asm/brk-imm.h          |   2 +
 arch/arm64/include/asm/compiler.h         |  16 -
 arch/arm64/include/asm/ftrace.h           |   2 +-
 arch/arm64/include/asm/insn.h             |   1 +
 arch/arm64/include/asm/mmu_context.h      |   2 +-
 arch/arm64/include/asm/paravirt.h         |   2 +-
 arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
 arch/arm64/kernel/cpufeature.c            |   2 +-
 arch/arm64/kernel/ftrace.c                |   2 +-
 arch/arm64/kernel/machine_kexec.c         |   2 +-
 arch/arm64/kernel/psci.c                  |   2 +-
 arch/arm64/kernel/smp_spin_table.c        |   2 +-
 arch/arm64/kernel/traps.c                 |  57 ++++
 arch/arm64/kernel/vdso/Makefile           |   3 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/crypto/aesni-intel_glue.c        |   7 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S  |   5 +-
 arch/x86/entry/vdso/Makefile              |   3 +-
 arch/x86/events/core.c                    |  40 +--
 arch/x86/include/asm/kvm_host.h           |   6 +-
 arch/x86/include/asm/linkage.h            |   7 +
 arch/x86/include/asm/paravirt.h           |   4 +-
 arch/x86/kernel/traps.c                   |  39 ++-
 arch/x86/kvm/cpuid.c                      |   2 +-
 arch/x86/kvm/hyperv.c                     |   4 +-
 arch/x86/kvm/irq.c                        |   2 +-
 arch/x86/kvm/kvm_cache_regs.h             |  10 +-
 arch/x86/kvm/lapic.c                      |  32 +-
 arch/x86/kvm/mmu.h                        |   4 +-
 arch/x86/kvm/mmu/mmu.c                    |   8 +-
 arch/x86/kvm/mmu/spte.c                   |   4 +-
 arch/x86/kvm/pmu.c                        |   4 +-
 arch/x86/kvm/trace.h                      |   4 +-
 arch/x86/kvm/x86.c                        | 326 ++++++++++-----------
 arch/x86/kvm/x86.h                        |   4 +-
 arch/x86/kvm/xen.c                        |   4 +-
 arch/x86/lib/memcpy_64.S                  |   3 +-
 arch/x86/purgatory/Makefile               |   4 +
 arch/x86/tools/relocs.c                   |   1 +
 drivers/cpufreq/amd-pstate.c              |   8 +-
 drivers/firmware/efi/libstub/Makefile     |   2 +
 drivers/firmware/psci/psci.c              |   4 +-
 drivers/misc/lkdtm/usercopy.c             |   2 +-
 include/asm-generic/bug.h                 |  16 -
 include/asm-generic/vmlinux.lds.h         |  38 +--
 include/linux/cfi.h                       |  50 ++--
 include/linux/cfi_types.h                 |  57 ++++
 include/linux/compiler-clang.h            |  10 +-
 include/linux/compiler.h                  |  16 +-
 include/linux/compiler_types.h            |   4 +-
 include/linux/entry-common.h              |   2 +-
 include/linux/init.h                      |   4 +-
 include/linux/kernel.h                    |   2 +-
 include/linux/module.h                    |   8 +-
 include/linux/pci.h                       |   4 +-
 include/linux/perf_event.h                |   6 +-
 include/linux/sched.h                     |   2 +-
 include/linux/static_call.h               |  18 +-
 include/linux/static_call_types.h         |  13 +-
 include/linux/tracepoint.h                |   2 +-
 kernel/cfi.c                              | 340 ++++------------------
 kernel/kthread.c                          |   3 +-
 kernel/module.c                           |  49 +---
 kernel/static_call_inline.c               |   2 +-
 kernel/trace/bpf_trace.c                  |   2 +-
 kernel/workqueue.c                        |   2 +-
 scripts/Makefile.build                    |   3 +-
 scripts/kallsyms.c                        |   1 +
 scripts/link-vmlinux.sh                   |   3 +
 scripts/module.lds.S                      |  24 +-
 security/keys/trusted-keys/trusted_core.c |  14 +-
 tools/include/linux/static_call_types.h   |  13 +-
 tools/objtool/arch/x86/include/arch/elf.h |   2 +
 tools/objtool/builtin-check.c             |   3 +-
 tools/objtool/check.c                     | 128 +++++++-
 tools/objtool/elf.c                       |  13 +
 tools/objtool/include/objtool/arch.h      |   1 +
 tools/objtool/include/objtool/builtin.h   |   2 +-
 tools/objtool/include/objtool/elf.h       |   2 +
 84 files changed, 748 insertions(+), 793 deletions(-)
 create mode 100644 include/linux/cfi_types.h

-- 
2.36.0.464.gb9c8b46e94-goog

