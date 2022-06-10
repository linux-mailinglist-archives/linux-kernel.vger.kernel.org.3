Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B3F54703B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349206AbiFJXfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348626AbiFJXfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:35:18 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710B289A39
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:16 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 18-20020a621512000000b0051b90b3a793so291595pfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=nsMGvakN23jGJwKQKSNiBedpAQCT/+oZZ53FMvpJmWE=;
        b=TTSPz9mn3fOB4ve10WTtYfvod1PAt6nWdPvsN17q7/4saeuWmeuexh9VhPgCkS5pDb
         f5gRy75iYIFhLPMAvisX1Oqd4oD8ZWNaqLTaxxxPtUAHP8Y0ecEOORdAZIU2C/Y/DKOm
         nyoXugVxssag43IvWS8/pjSe0TCnIP72aYUgpBBAxda48sML5/s4c6m1tYfnik1HhNkH
         VCNyyM1VHrL4JWanm+XqpeJUg/llXdoZmHhdeF0TE0Y7+EFUsgLS/sGrzW/NxnDX1ad4
         vAiGN0d/8G6ZXtGM385+MPY4pp9zuYsCQ2EiF1NaDKONdQ9rOlNd8RH6++XT6lt40Tdk
         OCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=nsMGvakN23jGJwKQKSNiBedpAQCT/+oZZ53FMvpJmWE=;
        b=0xdtNLi5Bue1I5vMXb6JftaBdYPJpgqXbiFNfazP1o6LZlwm9FBQ73gteOFDUiaPc+
         AUfE6MDsyX03C6CPg2A6/NARSyx8u0d53G7cNcNkP1XmeIZN+dMznFwyz0mJVP4SFEnI
         S4Pw3xn0rZyEakp2jaFC3Z9Jy2QEyUWzMUZseePEFNUoW3Xks9o3CBUuJ94qopFdGPHD
         flsrbVLSkp1XONQTz62nt/IcwflsahoOIc1xmORqGoa+oqVoFGagTbOKoAUUDJShypga
         fEh0vLD+rlgrNNxdqDP4OXK2zS/MLQ0objarX8LdSHnoVa3zIXPyNcYoYvFgVwgT3xEH
         AQyQ==
X-Gm-Message-State: AOAM5335B6fE1MlNJXBcQRtBWruisK4SR1yUxTHkm5tZIm5OGHPjCAlC
        GrCBP6HhuJmNeJW53VEVptamKWSHwshCEzSSLJ9UmWBWFpSfJWBwpd1WWOAlY4iUpxO546gdtE0
        Qtg9FRHK6xChdygBM8ShlgGpdWEIgCHL8docgM2XVJ86d34n2dTKj/eCfcdWrPhYnRY1qyLAbx6
        kSZ8BVnXSp7A==
X-Google-Smtp-Source: ABdhPJzdLof87FxFUwL7nMS7yP1RwHTMWgXL9tW9h4xwKDJuVFdFP6l21cUGZW05T9FvcBnHeDH2g5GB+ZU+RT5MXgw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:4b90:b0:1e8:48bd:453 with
 SMTP id lr16-20020a17090b4b9000b001e848bd0453mr2189527pjb.86.1654904115869;
 Fri, 10 Jun 2022 16:35:15 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:34:53 -0700
Message-Id: <20220610233513.1798771-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7489; h=from:subject;
 bh=nEoLqXNa3ykt1eGfRs/jvdsV+FhVXUy4vtw8erotAL0=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UswFKBhBOO2/9SIKqLIDgiaShLWcr9mJQQ6dfI
 Oi0DjR+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLAAKCRBMtfaEi7xW7svkC/
 9n4xT5mUM0FuTK43AIeV3s0iJFI/It59JH+MTCiDiGXGDCEJGkCO0pK9lGCfDDES6dL4PY8iQKF8P1
 BOif4X/nNa/ykC/ILkxWs7dG5G4iExpiA3Nw14d8c251mLZKGPU6rok5GF7k7H6mQqgv4EYYeJAUC8
 st9LzJ9EhK3bufhrAiwwIXR9RUlZVx7z3nD6z2XAyd/SSilV/Yy4QzkGO4g0qUmR+z9mkSwuvm2jnN
 4vDtRdvGzemSFp8Nj+6j3YCIQn3R+y8vX6Mrloje5lon5XoyAdVERBegFZMQo4NThZl1VPvBM+YjmW
 e9VbLTEFUMtIeF9BNXaelAZw6gwJEBTiEkz96IIkHIwrSpzCOBJP7dGNpE/clTwzd8x0O9YWDy3Gqg
 PuLh8K7ozjdJQ/y7qbtQO+Gx7dMEfOA+3GQ8o9OoKouYBVwnqdK3ohasSp2UX8/TkdMbNxl/xNgfNa
 VG+WTqSZsnFOEv2n68TsYgUcoLR74vqKYZOh9vrWUxlAI=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 00/20] KCFI support
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCFI is a proposed forward-edge control-flow integrity scheme for
Clang, which is more suitable for kernel use than the existing CFI
scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
alter function references to point to a jump table, and won't break
function address equality. The latest LLVM patch is here:

  https://reviews.llvm.org/D119296

This RFC series replaces the current arm64 CFI implementation with
KCFI and adds support for x86_64.

KCFI requires assembly functions that are indirectly called from C
code to be annotated with type identifiers. As type information is
only available in C, the compiler emits expected type identifiers into
the symbol table, so they can be referenced from assembly without
having to hardcode type hashes. Patch 6 adds helper macros for
annotating functions, and patches 8 and 18 add annotations.

In case of a type mismatch, KCFI always traps. To support error
handling, the compiler generates a .kcfi_traps section for x86_64,
which contains the locations of each trap, and for arm64, encodes
the necessary register information to the ESR. Patches 9 and 20 add
arch-specific error handlers.

To test this series, you'll need to compile your own Clang toolchain
with the patches linked above. You can also find the complete source
tree here:

  https://github.com/samitolvanen/llvm-project/commits/kcfi-rfc-v3

This series is also available in GitHub:

  https://github.com/samitolvanen/linux/commits/kcfi-rfc-v3

---
Changes in v3:
- Merged the patches that split CC_FLAGS_CFI from CC_FLAGS_LTO.

- Dropped the psci_initcall_t patch as Mark volunteered to send a
  patch for this. Note that this patch is still needed to boot a
  CFI kernel on certain arm64 systems:
  https://lore.kernel.org/lkml/YoNhKaTT3EDukxXY@FVFF77S0Q05N/

- Added a patch to remove the now unnecessary workarounds with
  CFI+ThinLTO in kallsyms.

- Added an lkdtm patch to ensure the test actually generates an
  indirect call.

- Changed report_cfi_failure to clearly indicate if we failed to
  decode target address.

- Switched to relative offsets for .kcfi_traps.

- On x86_64, moved CFI error handling from traps.c to cfi.c, and
  as we only call memcpy indirectly w/ CONFIG_MODULES, ensured that
  the compiler emits __kcfi_typeid_memcpy also without modules.

- On x86_64, added a check for the cmpl REX prefix to handle the
  case where the compiler might not use r8-r15 registers for the
  call target.

- On the compiler side, ensured that on x86_64 calls are emitted
  immediately after the CFI check, fixed the __cfi_ preamble
  linkage, and changed the compiler to emit relative offsets in
  .kcfi_traps.

Changes in v2:
- Changed the compiler patch to encode arm64 target and type details
  in the ESR, and updated the kernel error handling patch accordingly.

- Changed the compiler patch to embed the x86_64 type hash in a valid
  instruction to avoid special casing objtool instruction decoding, and
  added a __cfi_ symbol for the preamble. Changed the kernel error
  handling and manual type annotations to match.

- Dropped the .kcfi_types section as that=E2=80=99s no longer needed by
  objtool, and changed the objtool patch to simply ignore the __cfi_
  preambles falling through.

- Dropped the .kcfi_traps section on arm64 as it=E2=80=99s no longer needed=
,
  and moved the trap look-up code behind CONFIG_ARCH_USES_CFI_TRAPS,
  which is selected only for x86_64.

- Dropped __nocfi attributes from arm64 code where CFI was disabled
  due to address space confusion issues, and added type annotations to
  relevant assembly functions.

- Dropped __nocfi from __init.

Sami Tolvanen (20):
  treewide: Filter out CC_FLAGS_CFI
  scripts/kallsyms: Ignore __kcfi_typeid_
  cfi: Remove CONFIG_CFI_CLANG_SHADOW
  cfi: Drop __CFI_ADDRESSABLE
  cfi: Switch to -fsanitize=3Dkcfi
  cfi: Add type helper macros
  lkdtm: Emit an indirect call for CFI tests
  arm64: Add types to indirect called assembly functions
  arm64: Add CFI error handling
  arm64: Drop unneeded __nocfi attributes
  init: Drop __nocfi from __init
  treewide: Drop function_nocfi
  treewide: Drop WARN_ON_FUNCTION_MISMATCH
  treewide: Drop __cficanonical
  objtool: Disable CFI warnings
  kallsyms: Drop CONFIG_CFI_CLANG workarounds
  x86/tools/relocs: Ignore __kcfi_typeid_ relocations
  x86: Add types to indirectly called assembly functions
  x86/purgatory: Disable CFI
  x86: Add support for CONFIG_CFI_CLANG

 Makefile                                  |  13 +-
 arch/Kconfig                              |  18 +-
 arch/arm64/crypto/ghash-ce-core.S         |   5 +-
 arch/arm64/crypto/sm3-ce-core.S           |   3 +-
 arch/arm64/include/asm/brk-imm.h          |   6 +
 arch/arm64/include/asm/ftrace.h           |   2 +-
 arch/arm64/include/asm/mmu_context.h      |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
 arch/arm64/kernel/alternative.c           |   2 +-
 arch/arm64/kernel/cpu-reset.S             |   5 +-
 arch/arm64/kernel/cpufeature.c            |   4 +-
 arch/arm64/kernel/ftrace.c                |   2 +-
 arch/arm64/kernel/machine_kexec.c         |   2 +-
 arch/arm64/kernel/psci.c                  |   2 +-
 arch/arm64/kernel/smp_spin_table.c        |   2 +-
 arch/arm64/kernel/traps.c                 |  47 ++-
 arch/arm64/kernel/vdso/Makefile           |   3 +-
 arch/arm64/mm/proc.S                      |   5 +-
 arch/x86/Kconfig                          |   2 +
 arch/x86/crypto/blowfish-x86_64-asm_64.S  |   5 +-
 arch/x86/entry/vdso/Makefile              |   3 +-
 arch/x86/include/asm/cfi.h                |  22 ++
 arch/x86/include/asm/linkage.h            |  12 +
 arch/x86/kernel/Makefile                  |   2 +
 arch/x86/kernel/cfi.c                     |  83 ++++++
 arch/x86/kernel/traps.c                   |   4 +-
 arch/x86/lib/memcpy_64.S                  |   3 +-
 arch/x86/purgatory/Makefile               |   4 +
 arch/x86/tools/relocs.c                   |   1 +
 drivers/firmware/efi/libstub/Makefile     |   2 +
 drivers/firmware/psci/psci.c              |   4 +-
 drivers/misc/lkdtm/cfi.c                  |  15 +-
 drivers/misc/lkdtm/usercopy.c             |   2 +-
 include/asm-generic/bug.h                 |  16 -
 include/asm-generic/vmlinux.lds.h         |  37 +--
 include/linux/cfi.h                       |  59 ++--
 include/linux/cfi_types.h                 |  57 ++++
 include/linux/compiler-clang.h            |  14 +-
 include/linux/compiler.h                  |  16 +-
 include/linux/compiler_types.h            |   4 -
 include/linux/init.h                      |   6 +-
 include/linux/module.h                    |  10 +-
 include/linux/pci.h                       |   4 +-
 kernel/cfi.c                              | 342 ++++------------------
 kernel/kallsyms.c                         |  17 --
 kernel/kthread.c                          |   3 +-
 kernel/module/main.c                      |  49 +---
 kernel/workqueue.c                        |   2 +-
 scripts/kallsyms.c                        |   1 +
 scripts/module.lds.S                      |  23 +-
 tools/objtool/check.c                     |   7 +-
 51 files changed, 420 insertions(+), 538 deletions(-)
 create mode 100644 arch/x86/include/asm/cfi.h
 create mode 100644 arch/x86/kernel/cfi.c
 create mode 100644 include/linux/cfi_types.h

--=20
2.36.1.476.g0c4daa206d-goog

