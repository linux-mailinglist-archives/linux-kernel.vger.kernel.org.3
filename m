Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2793E4CBCBC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiCCLeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiCCLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B2C17C41C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=70PB+gohs3vvhilxSPQL+ZUS62bvu2VmKloA41Gxyvo=; b=gWTROi0gIbGX5YjGiGtGBLCnmE
        yj1a9BpXKpEHp1pXfjT4GKVnsGbFtmHf28l4LyFZDptuofCEKFdbCLYsG4L3zlPnuUiXj00aWq8/y
        q6N2aUWE7X046RC0/9Md4yVbVsZR/Jv6MZWYkq7uJIRZqYmvwLdCFAAkNLILftf+J+HV9JCbNnPYU
        87vb+Zjw3eyrmC9l3lVzWsUQJgwzVT8Dl8MUhvoK/wsjVsHytj1LbkEZrcEbgY6xUBL6XOAqYDqq4
        K8VU3NNQD1/YPSc/llF/hnHo5YdvAhtl60jg9/GzuliAYlTeGxi+CTRTIaIDgLamsj+lwgYSnifZU
        6bHh+JYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjef-00BaGd-Rk; Thu, 03 Mar 2022 11:29:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C92B30027B;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 116D530009594; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112321.422525803@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 00/39] x86: Kernel IBT
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, another week, another series.

Since last time:

 - fixed and tested kexec (redgecomb)
 - s/4*HAS_KERNEL_IBT/ENDBR_INSN_SIZE/ (jpoimboe)
 - re-arranged Xen patches to avoid churn (andyhpp)
 - folded IBT_SEAL Kconfig and objtool options (jpoimboe)
 - dropped direct call/jmp rewrite from objtool (jpoimboe)
 - dropped UD1 poison (jpoimboe)
 - fixed kprobe selftests (masami,naveen)
 - fixed ftrace selftests (rostedt)
 - simplified CET/INT3 selftests (jpoimboe)
 - boot time msg on IBT (kees)
 - objtool WARN_FUNC sym+off fallback (jpoimboe)
 - picked up tags for unchanged patches
 - probably more

Supposedly clang-14-rc2 will work on this series, I'll validate the moment the
Debian package gets updated.

Patches go on top of tip/master + arm64/for-next/linkage. Also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

Enjoy!

---
 arch/powerpc/include/asm/livepatch.h        |  10 -
 arch/powerpc/kernel/kprobes.c               |  34 +--
 arch/um/kernel/um_arch.c                    |   4 +
 arch/x86/Kconfig                            |  27 +++
 arch/x86/Makefile                           |   7 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S   |   3 +
 arch/x86/entry/entry_64.S                   |  27 ++-
 arch/x86/entry/entry_64_compat.S            |   5 +
 arch/x86/include/asm/alternative.h          |   1 +
 arch/x86/include/asm/cpu.h                  |   4 +
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/efi.h                  |   9 +-
 arch/x86/include/asm/ibt.h                  |  92 ++++++++
 arch/x86/include/asm/idtentry.h             |  25 +-
 arch/x86/include/asm/irqflags.h             |   5 -
 arch/x86/include/asm/linkage.h              |  39 ++++
 arch/x86/include/asm/msr-index.h            |  20 +-
 arch/x86/include/asm/paravirt.h             |   1 +
 arch/x86/include/asm/paravirt_types.h       |   1 -
 arch/x86/include/asm/qspinlock_paravirt.h   |   3 +
 arch/x86/include/asm/segment.h              |   5 +-
 arch/x86/include/asm/setup.h                |   3 +-
 arch/x86/include/asm/text-patching.h        |  30 ++-
 arch/x86/include/asm/traps.h                |   2 +
 arch/x86/include/uapi/asm/processor-flags.h |   2 +
 arch/x86/kernel/alternative.c               |  57 ++++-
 arch/x86/kernel/apm_32.c                    |   7 +
 arch/x86/kernel/cpu/bugs.c                  |  13 ++
 arch/x86/kernel/cpu/common.c                |  59 ++++-
 arch/x86/kernel/ftrace.c                    |   9 +-
 arch/x86/kernel/ftrace_64.S                 |  23 +-
 arch/x86/kernel/head_64.S                   |  14 +-
 arch/x86/kernel/idt.c                       |   9 +-
 arch/x86/kernel/kprobes/core.c              |  29 ++-
 arch/x86/kernel/kvm.c                       |   3 +-
 arch/x86/kernel/machine_kexec_64.c          |   2 +
 arch/x86/kernel/module.c                    |  21 +-
 arch/x86/kernel/paravirt.c                  |  29 +--
 arch/x86/kernel/relocate_kernel_64.S        |  10 +
 arch/x86/kernel/traps.c                     |  61 +++++
 arch/x86/kernel/vmlinux.lds.S               |   9 +
 arch/x86/kvm/emulate.c                      |   6 +-
 arch/x86/lib/error-inject.c                 |   2 +
 arch/x86/lib/retpoline.S                    |   1 +
 arch/x86/net/bpf_jit_comp.c                 |  16 +-
 arch/x86/xen/enlighten_pv.c                 |  10 +-
 arch/x86/xen/xen-asm.S                      |  10 +
 arch/x86/xen/xen-head.S                     |   8 +-
 include/asm-generic/vmlinux.lds.h           |   4 +
 include/linux/cfi.h                         |  11 +-
 include/linux/kprobes.h                     |   3 +-
 include/linux/objtool.h                     |  16 ++
 kernel/bpf/trampoline.c                     |  20 +-
 kernel/kprobes.c                            |  66 ++++--
 kernel/livepatch/patch.c                    |  19 +-
 kernel/trace/ftrace.c                       |  34 ++-
 samples/ftrace/ftrace-direct-modify.c       |   5 +
 samples/ftrace/ftrace-direct-multi-modify.c |  10 +-
 samples/ftrace/ftrace-direct-multi.c        |   5 +-
 samples/ftrace/ftrace-direct-too.c          |   3 +
 samples/ftrace/ftrace-direct.c              |   3 +
 scripts/Makefile.build                      |  44 +---
 scripts/Makefile.lib                        |  56 +++++
 scripts/Makefile.modfinal                   |   1 +
 scripts/link-vmlinux.sh                     |  12 +-
 tools/objtool/arch/x86/decode.c             |  34 ++-
 tools/objtool/builtin-check.c               |   8 +-
 tools/objtool/check.c                       | 346 +++++++++++++++++++++++++++-
 tools/objtool/elf.c                         |   3 +
 tools/objtool/include/objtool/arch.h        |   1 +
 tools/objtool/include/objtool/builtin.h     |   3 +-
 tools/objtool/include/objtool/check.h       |  14 +-
 tools/objtool/include/objtool/objtool.h     |   4 +
 tools/objtool/include/objtool/warn.h        |   2 +
 tools/objtool/objtool.c                     |   1 +
 75 files changed, 1254 insertions(+), 242 deletions(-)

