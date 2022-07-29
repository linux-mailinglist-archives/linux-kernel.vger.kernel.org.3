Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C1585549
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiG2TCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbiG2TCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:02:44 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89408875B;
        Fri, 29 Jul 2022 12:02:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 784C13187FB;
        Fri, 29 Jul 2022 15:02:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fhsgQZX9os9s; Fri, 29 Jul 2022 15:02:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EFB99318A66;
        Fri, 29 Jul 2022 15:02:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EFB99318A66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121361;
        bh=LGYqiUoildEcSsSzT++oQyDq+W45yyxu+XAIWlSToUM=;
        h=From:To:Date:Message-Id;
        b=JqfY4Ck1/ZPUIyAICRx0LM3J/DDpruTo45L/kTMwBcDuKwvOvhmCvhKuG/VzywfxY
         jmJZqQgOR8V50h2KXfx5NSlhUTeH1MHPviF4GBQeQDLkuWACvoYGoGceVAQJmCHZar
         GU3hPOgvkOgNsrazue8Fb7S9JxkFgoKrhkrSqhX+PP4x4Myth5DeIvE4SQW9AD0f90
         seAVi0jKrkrpo9t/N/XmO4Xbb/oBLrDxgnKwbHk8LcLH4lpiDfpqcDoFXA1rZ/6rlE
         Slpoho3zQ9bDt7/X6ByNg4c7ioBetqOjvgw322Km7qk4/+SzO5tYNJY2QtwC6pV16h
         6FQW4Y+lMKYRw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rvmu7zo3wHO3; Fri, 29 Jul 2022 15:02:40 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 73BC63187F7;
        Fri, 29 Jul 2022 15:02:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 00/23] RSEQ node id and virtual cpu id extensions
Date:   Fri, 29 Jul 2022 15:02:02 -0400
Message-Id: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.

The NUMA node ID field allows implementing a faster getcpu(2) in libc.

The virtual cpu id allows ideal scaling (down or up) of user-space
per-cpu data structures. The virtual cpu ids allocated within a memory
space are tracked by the scheduler, which takes into account the number
of concurrently running threads, thus implicitly considering the number
of threads, the cpu affinity, the cpusets applying to those threads, and
the number of logical cores on the system.

This series is based on the v5.18.13 tag.

Thanks,

Mathieu

Mathieu Desnoyers (23):
  rseq: Introduce feature size and alignment ELF auxiliary vector
    entries
  rseq: Introduce extensible rseq ABI
  rseq: extend struct rseq with numa node id
  selftests/rseq: Use ELF auxiliary vector for extensible rseq
  selftests/rseq: Implement rseq numa node id field selftest
  lib: invert _find_next_bit source arguments
  lib: implement find_{first,next}_{zero,one}_and_zero_bit
  cpumask: implement cpumask_{first,next}_{zero,one}_and_zero
  sched: Introduce per memory space current virtual cpu id
  rseq: extend struct rseq with per memory space vcpu id
  selftests/rseq: Remove RSEQ_SKIP_FASTPATH code
  selftests/rseq: Implement rseq vm_vcpu_id field support
  selftests/rseq: x86: Template memory ordering and percpu access mode
  selftests/rseq: arm: Template memory ordering and percpu access mode
  selftests/rseq: arm64: Template memory ordering and percpu access mode
  selftests/rseq: mips: Template memory ordering and percpu access mode
  selftests/rseq: ppc: Template memory ordering and percpu access mode
  selftests/rseq: s390: Template memory ordering and percpu access mode
  selftests/rseq: riscv: Template memory ordering and percpu access mode
  selftests/rseq: basic percpu ops vm_vcpu_id test
  selftests/rseq: parametrized vm_vcpu_id test
  selftests/rseq: x86: Implement rseq_load_u32_u32
  selftests/rseq: Implement numa node id vs vm_vcpu_id invariant test

 fs/binfmt_elf.c                               |    5 +
 fs/exec.c                                     |    4 +
 include/linux/cpumask.h                       |   86 ++
 include/linux/find.h                          |  123 +-
 include/linux/mm.h                            |   25 +
 include/linux/mm_types.h                      |  111 ++
 include/linux/sched.h                         |    9 +
 include/trace/events/rseq.h                   |    4 +-
 include/uapi/linux/auxvec.h                   |    2 +
 include/uapi/linux/rseq.h                     |   22 +
 init/Kconfig                                  |    4 +
 kernel/fork.c                                 |   15 +-
 kernel/ptrace.c                               |    2 +-
 kernel/rseq.c                                 |   60 +-
 kernel/sched/core.c                           |   82 ++
 kernel/sched/deadline.c                       |    3 +
 kernel/sched/debug.c                          |   13 +
 kernel/sched/fair.c                           |    1 +
 kernel/sched/rt.c                             |    2 +
 kernel/sched/sched.h                          |  357 +++++
 kernel/sched/stats.c                          |   16 +-
 lib/find_bit.c                                |   17 +-
 tools/include/linux/find.h                    |    9 +-
 tools/lib/find_bit.c                          |   17 +-
 tools/testing/selftests/rseq/.gitignore       |    5 +
 tools/testing/selftests/rseq/Makefile         |   20 +-
 .../testing/selftests/rseq/basic_numa_test.c  |  117 ++
 .../selftests/rseq/basic_percpu_ops_test.c    |   46 +-
 tools/testing/selftests/rseq/basic_test.c     |    4 +
 tools/testing/selftests/rseq/compiler.h       |    6 +
 tools/testing/selftests/rseq/param_test.c     |  152 ++-
 tools/testing/selftests/rseq/rseq-abi.h       |   22 +
 tools/testing/selftests/rseq/rseq-arm-bits.h  |  505 +++++++
 tools/testing/selftests/rseq/rseq-arm.h       |  701 +---------
 .../testing/selftests/rseq/rseq-arm64-bits.h  |  392 ++++++
 tools/testing/selftests/rseq/rseq-arm64.h     |  520 +------
 .../testing/selftests/rseq/rseq-bits-reset.h  |   10 +
 .../selftests/rseq/rseq-bits-template.h       |   39 +
 tools/testing/selftests/rseq/rseq-mips-bits.h |  462 +++++++
 tools/testing/selftests/rseq/rseq-mips.h      |  646 +--------
 tools/testing/selftests/rseq/rseq-ppc-bits.h  |  454 +++++++
 tools/testing/selftests/rseq/rseq-ppc.h       |  617 +--------
 .../testing/selftests/rseq/rseq-riscv-bits.h  |  410 ++++++
 tools/testing/selftests/rseq/rseq-riscv.h     |  529 +-------
 tools/testing/selftests/rseq/rseq-s390-bits.h |  474 +++++++
 tools/testing/selftests/rseq/rseq-s390.h      |  495 +------
 tools/testing/selftests/rseq/rseq-skip.h      |   65 -
 tools/testing/selftests/rseq/rseq-x86-bits.h  | 1036 ++++++++++++++
 tools/testing/selftests/rseq/rseq-x86.h       | 1193 +----------------
 tools/testing/selftests/rseq/rseq.c           |   86 +-
 tools/testing/selftests/rseq/rseq.h           |  229 +++-
 .../testing/selftests/rseq/run_param_test.sh  |    5 +
 52 files changed, 5536 insertions(+), 4693 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c
 create mode 100644 tools/testing/selftests/rseq/rseq-arm-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-reset.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-template.h
 create mode 100644 tools/testing/selftests/rseq/rseq-mips-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-s390-bits.h
 delete mode 100644 tools/testing/selftests/rseq/rseq-skip.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-bits.h

-- 
2.17.1

