Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24211507DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348077AbiDTApk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiDTApj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:45:39 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C43517A93;
        Tue, 19 Apr 2022 17:42:53 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 70D161BF206;
        Wed, 20 Apr 2022 00:42:43 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 00/11] Kernel FineIBT Support
Date:   Tue, 19 Apr 2022 17:42:30 -0700
Message-Id: <20220420004241.2093-1-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

Disclaimer: This is all in a very early/poc stage and is mostly research work
-- be advised to proceed with care and to bring a towel with you.

This patch series enables FineIBT in the kernel. FineIBT is a compiler-enhanced
forward-edge CFI scheme built on top of Intel's CET-IBT that works by setting a
hash on the caller side which is then checked at the callee side. Because IBT
requires indirect branches to land on ENDBR instructions, these hash checks
shouldn't be bypassable on the occasion of function pointer corruption. More
details on the general FineIBT design are here [1, 2].

When compared to IBT itself, FineIBT imposes a more restrictive policy that
should be more robust against control-flow hijacking attacks. When compared to
schemes like KCFI [3], it has the benefit of not depending on memory reads
(which not only might be more efficient in terms of performance and power but
also makes it compatible with XOM [4]) and brings in the benefits of IBT
regarding speculative execution hardening.

A debatable point is the fact that on FineIBT the checks are made on the callee
side. On a quick look, this seems to be cool because it allows strict
reachability refinement of more security-critical functions (like hardware
feature disabling ones) while still allowing other less critical functions to be
relaxed/coarse-grained; under caller-side checks, if one single function is
required to be relaxed, this leads into an indirect call instruction being
relaxed, then becoming a branch capable of reaching all the functions in the
executable address space, including those considered security-critical. Inputs
and opinions on this are very welcome, as there are other perspectives about
this I might be missing.

This series relies heavily on the recently upstreamed IBT support and also
respins some sorcery proposed by Peter Zijlstra in his IBT v2 series [5]. A huge
part of these is a repurpose of work originally cast by Peter.

The FineIBT enablement uses a modified clang version to emit code with the
FineIBT hash set/check operations. The modified clang is available here [6]. The
.config used for building and testing is available here [7] along with more or
less general instructions on how to build it. A tree with this series on top is
available here [8].

Key insights:
- On IBT v2, Peter proposed an optimization that uses objtool to add an offset
  to operands of direct branches targeting ENDBR instructions, skipping the need
to fetch/decode these. With FineIBT, skipping ENDBRs+hash checks is not only
desirable but needed, as a way to prevent direct calls from being considered a
violation whenever they reach a function without priorly setting the respective
hash. This series respins the approach and uses objtool to fix direct branches
targeting FineIBT hash check operations. Fixing this in objtool instead of using
the compiler is convenient because then it becomes easy to mix
FineIBT-instrumented code with binaries only augmented with regular ENDBRs (such
as currently-existing assembly).
- The same approach (identifying FineIBT hash check sequences and fixing direct
  branch targets) is also used dynamically to support module loading (fix the
relocations), text-patching (support static calls), and on BPF (support jitted
calls to core functions).
- When a direct branch into a FineIBT hash check cannot be fixed (because it is
  a short jump targeting an instruction which, once incremented with the needed
offset, becomes unreachable) the respective functionality patches the FineIBT
sequence with nops, making it a valid target that is still constrained by IBT.
- This series also fixes unmatching prototypes of certain indirect calls that
  will trigger violations on any prototype-based CFI scheme.
- Also adds test modules for both IBT and FineIBT.
- Also adds coarsecf_check attributes to specific functions, making the compiler
  emit them with regular ENDBRs instead of the FineIBT hash check. This is
useful because certain functions are called from assembly and we currently don't
have a sane scheme to set hashes in all of these (although we do it in one more
relevant spot).
- In the occasion of violations, the hash check invokes a __fineibt_handler,
  which is a function that makes it easier to debug unmatching prototypes and
such. It can be easily switched to an ud2 instruction or anything like that.
- In my tests, the above-mentioned .config runs this series smoothly, without
  any false-positive violations.

Some obvious possible improvements:
- The support should identify FineIBT sequences based on annotations, not on
  parsing the actual instructions. This would make things less hacky and more
reliable.
- Assembly coverage must be improved eventually.
- The FineIBT hash check operation can have its length reduced by replacing the
  inlined check with a call to a checker.

@PeterZ @JoshP

I'm a bit unaware of the details on why the objtool approach to bypass ENDBRs
was removed from the IBT series. Is this approach now sensible considering that
it is a requirement for a new/enhanced feature? If not, how extending the Linker
to emit already fixed offsets sounds like?

@Kees

I'm considering detaching the prototype fixes from this series and reworking
them to submit actual fixes (patches 10 and 11). Any specific suggestions for
these specific patches? Maybe you want to take a look and help in co-authorship
as we did with the void*-in-x86-crypto patches in the past? I guess these are
useful for whatever CFI scheme is in place.

@all

Any other major concerns, ideas, or suggestions? :)

Refs:

[1] - FineIBT:
https://www.openwall.com/lists/kernel-hardening/2021/02/11/1

[2] - FineIBT on Linux Security Summit:
https://static.sched.com/hosted_files/lssna2021/8f/LSS_FINEIBT_JOAOMOREIRA.pdf

[3] - KCFI Clang Patches:
https://reviews.llvm.org/D119296/new/

[4] - eXecute-Only Memory:
https://lpc.events/event/4/contributions/283/attachments/357/588/Touch_but_dont_look__Running_the_kernel_in_execute_only_memory-presented.pdf

[5] - IBT Patches v2:
https://lore.kernel.org/lkml/20220224145138.952963315@infradead.org/

[6] - FineIBT-capable Clang:
https://github.com/lvwr/llvm-project/tree/fineibt/kernel

[7] - Kernel .config and dummy stuff:
https://github.com/lvwr/kfineibt_testing

[8] - Linux + FineIBT:
https://github.com/lvwr/linux/tree/x86/fineibt

Joao Moreira (11):
  x86: kernel FineIBT
  kbuild: Support FineIBT build
  objtool: Support FineIBT offset fixes
  x86/module: Support FineIBT in modules
  x86/text-patching: Support FineIBT text-patching
  x86/bpf: Support FineIBT
  x86/lib: Prevent UACCESS call warning from objtool
  x86/ibt: Add CET_TEST module for IBT testing
  x86/FineIBT: Add FINEIBT_TEST module
  linux/interrupt: Fix prototype matching property
  driver/int3400_thermal: Fix prototype matching

 arch/x86/Kconfig                              |  10 +
 arch/x86/Kconfig.debug                        |  10 +
 arch/x86/Makefile                             |   3 +
 arch/x86/entry/entry_64.S                     |   1 +
 arch/x86/entry/vdso/Makefile                  |   5 +
 arch/x86/include/asm/ibt.h                    |  16 ++
 arch/x86/include/asm/setup.h                  |  12 +-
 arch/x86/include/asm/special_insns.h          |   4 +-
 arch/x86/include/asm/text-patching.h          |  92 ++++++++-
 arch/x86/kernel/Makefile                      |   3 +
 arch/x86/kernel/cet_test.c                    |  30 +++
 arch/x86/kernel/cpu/common.c                  |   2 +-
 arch/x86/kernel/fineibt.c                     | 123 ++++++++++++
 arch/x86/kernel/fineibt_test.c                |  39 ++++
 arch/x86/kernel/head64.c                      |  12 +-
 arch/x86/kernel/module.c                      |  45 ++++-
 arch/x86/kernel/smpboot.c                     |   2 +-
 arch/x86/lib/copy_mc.c                        |   2 +-
 arch/x86/net/bpf_jit_comp.c                   |  31 +++
 arch/x86/purgatory/Makefile                   |   4 +
 .../intel/int340x_thermal/int3400_thermal.c   |  10 +-
 include/linux/interrupt.h                     |   6 +-
 scripts/Makefile.build                        |   1 +
 scripts/link-vmlinux.sh                       |   8 +
 tools/objtool/arch/x86/decode.c               | 175 +++++++++++++----
 tools/objtool/arch/x86/include/arch/special.h |   2 +
 tools/objtool/builtin-check.c                 |   3 +-
 tools/objtool/check.c                         | 183 +++++++++++++++++-
 tools/objtool/include/objtool/arch.h          |   3 +
 tools/objtool/include/objtool/builtin.h       |   2 +-
 30 files changed, 767 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/kernel/cet_test.c
 create mode 100644 arch/x86/kernel/fineibt.c
 create mode 100644 arch/x86/kernel/fineibt_test.c

-- 
2.35.1

