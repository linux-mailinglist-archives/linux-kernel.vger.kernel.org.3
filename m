Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479A55311FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiEWQR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiEWQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:17:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A7666BC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:17:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so16862108ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PCQH17jF4yaNt95ownveF3EeYN5ShcjQ8EacLUuPu7Q=;
        b=WMJecfnwXOWvirU9vw8U1e4rSbx8otVKr+DnbzNJxhlpIRARuz1o2twyOPZlzc/YWT
         QiwqiIrYAga4po26Hx5KAVWvOW8+Le3wLCUGiL2M8xzwODyX8w+0MIG/Rx+OD8KGKAk/
         yCFgSTGP4O+iwYr37oBFFm0D5NnPA6+ctOTbCovksijNhI37jSKrWqzD0IXjMX0hXSr6
         XemxkGkRbDMwULuHcEHVQHA+4kkxs0ISJfszANrJ+hZVVSEVdPifjumO57Anhzu4lG0V
         OBzZAQdjTl5IljJNskUKpywQoIL3zJ0eSO7GJpB87OZSt5btpY6txgZ0ws2biTUwJlX7
         HhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=PCQH17jF4yaNt95ownveF3EeYN5ShcjQ8EacLUuPu7Q=;
        b=ywGWRlTStNTxWKKFHAkUKne8MVYq+xRajUv/KQbSJpAQg9/hEIHcLteB417LDcRF21
         mDAqMoL0lqCzEwsnQzNG6/CuPVmNXUkovOayp8o4RO0gIXLDiBUxIx/uZ5TmMJqOzFBw
         FMLGrDT02EddeBL3zybdy+BYuE1D8sYTSogc8JVtYkJQsN+yB5DD8HIx/YS8jZuciSOB
         I48gcJvUjTIte2DXnE44oTYO8yzNwvQXxUmSE7HnHQe9Olhh5a13ZUIwoi5QzMZNB/1b
         fQhtqZhu4LQn/FIFew4G1YKKP07/x5o3D4DfYquW5a3KJ07GJnI2VZm/Fvb5HCnQhP6p
         AKPg==
X-Gm-Message-State: AOAM532PQDj0Ild5BAQrKakAl30XIjHErcQ0GITi1KXFkZ2StbLnyMW0
        cs1CplCOvOKppMaANUV4cN0=
X-Google-Smtp-Source: ABdhPJwptTyJfccR0i2aaf7qKQXymAvH8V9XrRvC+whQ5p4yRUwIiOo592EU70514OOtsS15K8y70g==
X-Received: by 2002:a17:907:7ea8:b0:6f5:941:cba9 with SMTP id qb40-20020a1709077ea800b006f50941cba9mr19689459ejc.213.1653322652035;
        Mon, 23 May 2022 09:17:32 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7d88c000000b0042aca5edba7sm8492562edq.57.2022.05.23.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:17:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 23 May 2022 18:17:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.19
Message-ID: <YouzmQ23tV62Ni+F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-05-23

   # HEAD: 8491d1bdf5de152f27fc941e2dcdc4e66c950542 sched/clock: Use try_cmpxchg64 in sched_clock_{local,remote}

Locking changes in this cycle were:

 - rwsem cleanups & optimizations/fixes:
    - Conditionally wake waiters in reader/writer slowpaths
    - Always try to wake waiters in out_nolock path

 - Add try_cmpxchg64() implementation, with arch optimizations - and use it to
   micro-optimize sched_clock_{local,remote}()

 - Various force-inlining fixes to address objdump instrumentation-check warnings

 - Add lock contention tracepoints:

    lock:contention_begin
    lock:contention_end

 - Misc smaller fixes & cleanups

 Thanks,

	Ingo

------------------>
Borislav Petkov (3):
      task_stack, x86/cea: Force-inline stack helpers
      x86/kvm/svm: Force-inline GHCB accessors
      x86/mm: Force-inline __phys_addr_nodebug()

Namhyung Kim (2):
      locking: Add lock contention tracepoints
      locking: Apply contention tracepoints in the slow path

Nick Desaulniers (1):
      lockdep: Fix -Wunused-parameter for _THIS_IP_

Peter Zijlstra (1):
      locking/mutex: Make contention tracepoints more consistent wrt adaptive spinning

Sebastian Andrzej Siewior (1):
      futex: Remove a PREEMPT_RT_FULL reference.

Thomas Gleixner (1):
      lockdep: Delete local_irq_enable_in_hardirq()

Uros Bizjak (3):
      locking/atomic: Add generic try_cmpxchg64 support
      locking/atomic/x86: Introduce arch_try_cmpxchg64
      sched/clock: Use try_cmpxchg64 in sched_clock_{local,remote}

Waiman Long (4):
      locking/rwsem: No need to check for handoff bit if wait queue empty
      locking/rwsem: Conditionally wake waiters in reader/writer slowpaths
      locking/rwsem: Always try to wake waiters in out_nolock path
      locking/qrwlock: Change "queue rwlock" to "queued rwlock"


 arch/arm64/kernel/entry-common.c            |   8 +-
 arch/x86/include/asm/cmpxchg_32.h           |  21 +++++
 arch/x86/include/asm/cmpxchg_64.h           |   6 ++
 arch/x86/include/asm/cpu_entry_area.h       |   2 +-
 arch/x86/include/asm/page_64.h              |   2 +-
 arch/x86/include/asm/svm.h                  |   8 +-
 include/asm-generic/qrwlock.h               |  28 +++---
 include/asm-generic/qrwlock_types.h         |   2 +-
 include/linux/atomic/atomic-arch-fallback.h |  72 ++++++++++++++-
 include/linux/atomic/atomic-instrumented.h  |  40 ++++++++-
 include/linux/interrupt.h                   |  18 ----
 include/linux/irqflags.h                    |   4 +-
 include/linux/kvm_host.h                    |   2 +-
 include/linux/sched/task_stack.h            |   2 +-
 include/trace/events/lock.h                 |  63 +++++++++++++-
 kernel/entry/common.c                       |   6 +-
 kernel/futex/pi.c                           |   2 +-
 kernel/locking/lockdep.c                    |  23 ++---
 kernel/locking/mutex.c                      |  18 +++-
 kernel/locking/percpu-rwsem.c               |   5 ++
 kernel/locking/qrwlock.c                    |  17 +++-
 kernel/locking/qspinlock.c                  |   5 ++
 kernel/locking/rtmutex.c                    |  11 +++
 kernel/locking/rwbase_rt.c                  |   7 ++
 kernel/locking/rwsem.c                      | 130 +++++++++++++++++-----------
 kernel/locking/semaphore.c                  |  15 +++-
 kernel/sched/clock.c                        |   4 +-
 kernel/sched/idle.c                         |   2 +-
 kernel/trace/trace_preemptirq.c             |   4 +-
 scripts/atomic/gen-atomic-fallback.sh       |  31 ++++---
 scripts/atomic/gen-atomic-instrumented.sh   |   2 +-
 31 files changed, 412 insertions(+), 148 deletions(-)
