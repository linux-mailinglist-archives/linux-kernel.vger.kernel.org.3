Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB518526B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384110AbiEMUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384091AbiEMUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B21514C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m136-20020a25268e000000b0064b233e03d1so8195588ybm.14
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6CD2+63H+3oTXjdPkyITKV8H4giwswt8mB7LxNoXRYo=;
        b=r5EVvXQzvk5eeQ4XlSJKfwGgANH0BdQwZRjaHHspPEGd/UcpZ1b+p/8Op17mjXBG5B
         UcgVZwJ5FSAz4mYqsfTlF1djzNN482V8ywnJZCKUyxH5fcayYMuZVx/xzzsow1u428aP
         rY9zVOEl97Yhu+WgmabAaI95fvlWhW0amOdHtf0P1RgSPXUqo7yujhe5u0jcwXtfAUoN
         pbARbf7Xgsr9e+APQ8y7txcpe+VK39r8ASkwIWJO4920xmEhxFC4hL1jGf8cUEw0pymm
         1Z+FrPtkUzeQHNNBxxbR4A9JRHS4ZuRIlKi1sF+NHM3jSvYeGoE9PrWzK49N5G2jhpQd
         vRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6CD2+63H+3oTXjdPkyITKV8H4giwswt8mB7LxNoXRYo=;
        b=fJW1oKh6vuU5qbImMgh3eRNoDy+hWzZRyLuLz3tjXV5LWzbJqui//J3Se9QiQCnqUs
         S0hwSfj5Sou3RVSWCQxdQMq1HWAeYIFNeVW9kLujLkJMUy9c3SNKuvhGpWzB9oiNlrJ6
         OZ07d2JpigcS845zDd1EV2PC5XUfsz9MVpxjzT5gADe7BMlCGQsK4kZ8Xf6Gr+b/KzKI
         /P+ul1VcNuE4rmw6360XfvnZUiEp8tQ9yNTaVrGlgXZChfgLiWM1Lh1GHVXEQFfZi83g
         vB3B0WfqDs6/qctEhTDNZIQv8RlDZ08pwTx8qm3GSgvZQ8ne625BU27um6FONc7eHbTj
         ZY5Q==
X-Gm-Message-State: AOAM530TorvE5CMKMyEOB6MDc1Y8BvA/mhEEH6UvVD05lHJFtb1nCHzC
        uKMJUQonogoj+FyuNBhtO0RJ8dWeyVlebj68Ux+th0efUzQnffNq+bEJl4urNyjcCba+PvLBfxT
        OHV+aWZxzjr+5uJCIBkn2WicgEgUGYVcVOyyHiGylK/Dd0TddeNejNvn5ZK08AiFPHTWTESDwp/
        0NrjRoXYD2vA==
X-Google-Smtp-Source: ABdhPJyWzTcZ6z5vhWY6N9lWbzhGW/eIh1xUAaFPidwLygala9vxOMwfoNufG+ccSq0CvYF/3FNqw512rdJUpKJ4V4U=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a81:7746:0:b0:2fe:b79e:dd21 with SMTP
 id s67-20020a817746000000b002feb79edd21mr4376368ywc.97.1652473321844; Fri, 13
 May 2022 13:22:01 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:38 -0700
Message-Id: <20220513202159.1550547-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5033; h=from:subject;
 bh=QQHZw+nNC3sat5hCbK/dHVOrwEpFv/dcBv8rUGfmodE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3izuj6onoCVuVAqVb7kGKi7/2NqgwMnFWBknHE
 pazR+TaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694gAKCRBMtfaEi7xW7nTvC/
 0YeKprfOIH2lFwOEA0eV7IhrhzJnfzOacgxhF8m4gP3pX12d+c0mbY6LaI2TeqHUzmQ/qQVJCbUzed
 qYGHRtsqq5a1hWR34gMu84GY/VOmXf4HVNCY9Mr0EXKJGFRCORkGxwj5VgShEctPN7xlpzWhj9FSYQ
 TQpw7TbpV4gvBIzmJ6HlBPMeXAjn8Rw2OsKEmUTiLuTeHD8JNqWopZZiMLs7NptwBdLB5oirOM4hTH
 fPZ7LcF8aoBKDxQDK583B3fZQ39VGvUEKZSYsiEoGgMQ5ZGbwk84gmyuFzhwCztm16peP2twyeVgD3
 WAlgpVrY79VA3j63rGjXh0dj9nAhe6vyQJMm13fOSGcAs1+kYBAxIlFIVhdqoHnLUgXqNMkb7KTzy4
 wnCKrZHKvkMRSI4wZR6WdCSPkDWfq5GZMeziUruqhuc5vWqbSN21sjy3udNEPn/iebzu6GOUi6i5cv
 Vl4j8vDNBqAfPbc0owmH9iQAna1UfIaw1ochzhxveFUDI=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 00/21] KCFI support
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
having to hardcode type hashes. Patch 7 adds helper macros for
annotating functions, and patches 9 and 17 add annotations.

In case of a type mismatch, KCFI always traps. To support error
handling, the compiler generates a .kcfi_traps section for x86_64,
which contains the locations of each trap, and for arm64, encodes
the necessary register information to the ESR. Patches 10 and 20 add
arch-specific error handlers.

To test this series, you'll need to compile your own Clang toolchain
with the patches linked above. You can also find the complete source
tree here:

  https://github.com/samitolvanen/llvm-project/commits/kcfi-rfc-v2

This series is also available in GitHub:

  https://github.com/samitolvanen/linux/commits/kcfi-rfc-v2

Sami Tolvanen (21):
  efi/libstub: Filter out CC_FLAGS_CFI
  arm64/vdso: Filter out CC_FLAGS_CFI
  kallsyms: Ignore __kcfi_typeid_
  cfi: Remove CONFIG_CFI_CLANG_SHADOW
  cfi: Drop __CFI_ADDRESSABLE
  cfi: Switch to -fsanitize=kcfi
  cfi: Add type helper macros
  psci: Fix the function type for psci_initcall_t
  arm64: Add types to indirect called assembly functions
  arm64: Add CFI error handling
  arm64: Drop unneeded __nocfi attributes
  treewide: Drop function_nocfi
  treewide: Drop WARN_ON_FUNCTION_MISMATCH
  treewide: Drop __cficanonical
  objtool: Don't warn about __cfi_ preambles falling through
  x86/tools/relocs: Ignore __kcfi_typeid_ relocations
  x86: Add types to indirectly called assembly functions
  x86/purgatory: Disable CFI
  x86/vdso: Disable CFI
  x86: Add support for CONFIG_CFI_CLANG
  init: Drop __nocfi from __init

 Makefile                                  |  13 +-
 arch/Kconfig                              |  21 +-
 arch/arm64/crypto/ghash-ce-core.S         |   5 +-
 arch/arm64/crypto/sm3-ce-core.S           |   3 +-
 arch/arm64/include/asm/brk-imm.h          |   6 +
 arch/arm64/include/asm/compiler.h         |  16 -
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
 arch/arm64/kernel/traps.c                 |  46 ++-
 arch/arm64/kernel/vdso/Makefile           |   3 +-
 arch/arm64/mm/proc.S                      |   5 +-
 arch/x86/Kconfig                          |   2 +
 arch/x86/crypto/blowfish-x86_64-asm_64.S  |   5 +-
 arch/x86/entry/vdso/Makefile              |   3 +-
 arch/x86/include/asm/linkage.h            |  12 +
 arch/x86/kernel/traps.c                   |  60 +++-
 arch/x86/lib/memcpy_64.S                  |   3 +-
 arch/x86/purgatory/Makefile               |   4 +
 arch/x86/tools/relocs.c                   |   1 +
 drivers/firmware/efi/libstub/Makefile     |   2 +
 drivers/firmware/psci/psci.c              |   6 +-
 drivers/misc/lkdtm/usercopy.c             |   2 +-
 include/asm-generic/bug.h                 |  16 -
 include/asm-generic/vmlinux.lds.h         |  37 +--
 include/linux/cfi.h                       |  65 ++--
 include/linux/cfi_types.h                 |  57 ++++
 include/linux/compiler-clang.h            |   6 +-
 include/linux/compiler.h                  |  16 +-
 include/linux/compiler_types.h            |   4 -
 include/linux/init.h                      |   6 +-
 include/linux/module.h                    |  10 +-
 include/linux/pci.h                       |   4 +-
 kernel/cfi.c                              | 343 ++++------------------
 kernel/kthread.c                          |   3 +-
 kernel/module.c                           |  49 +---
 kernel/workqueue.c                        |   2 +-
 scripts/kallsyms.c                        |   1 +
 scripts/module.lds.S                      |  23 +-
 tools/objtool/check.c                     |   4 +
 47 files changed, 357 insertions(+), 534 deletions(-)
 create mode 100644 include/linux/cfi_types.h

-- 
2.36.0.550.gb090851708-goog

