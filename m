Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD334E250F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346695AbiCULNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbiCULNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:13:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A4E393DF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:11:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g20so17382530edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FuV81IIF3LymAR8I5LPuqTpPRTHr0t0Vaaga5EkxftA=;
        b=YYJ5wFQfu0abRvyvnmzS+Uev/nGmrlM6mRsGaVBROd65/9r0ZsKTTbcBgQSCQeqf4i
         +Us1oEZokigKRzKO18rtr2MCvwRrMLzXnhLamY4tGILGGoLFuCL/KDmOJebspuRPG9X6
         9WfzbVkeYbNtxp2yP85pL2MoAPVYkHtwhoCjleSA5/aJkqtLDf/ztx4hMSyF/HLZS7JF
         mm/RiwhDIK7lbnozGXFv1APCgxPtiAlxgD5mr3KsO8W57tz60yj2bbQW36Wu4J2vQJe0
         jCpfsOx3Zzjdt19y1oGUn5DLR5JrIxDOkjGlA+HW1NoSgQM0NTvHHpNLT8PYxRvVMZRa
         ZwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=FuV81IIF3LymAR8I5LPuqTpPRTHr0t0Vaaga5EkxftA=;
        b=AMN0NfrW7RlfDZkOzh/JhxxPoJvhkgVjEuMZFvlCRpXn3JQvZwhHDS5qCXMoE5EO5m
         Ws5WnGAv1z4p0fT0WbQy8CoY633AUHvVlK+pYf/2p18RYPRuLmD11j1CkBMHosOODF/a
         ONRZQ/go3IRauIi1MwJe5hx7COxnnRd+m7xJJyzVCwvvoEIGwkAx+Zf38KlDR1yUwGcH
         4pHWP53udVNp3Myuvq9EfVfduFfytiLAF4+eKNCVtY+fAJrjeYGM/uINpHg5czDSz5y6
         ef279ex74Tj/3J0vEi8PeVJshv5cvXGFn48fgAug7pYj4Yv7+yKra0mBquNggTzDEfl5
         /+jA==
X-Gm-Message-State: AOAM531EnUqxKpK62ndNry38OkAKZgHFxeVVxbZgzCC+vKLfUAtLozHj
        SPGsynrpVfj2USbbmKJH64g=
X-Google-Smtp-Source: ABdhPJw2dBqWZ05Xo/1TkAI1K+mz4mTHVGXt+jniV9oHndz9J1EwgJwMcnAaEN8gyZE5zA/Dskrdjw==
X-Received: by 2002:aa7:df99:0:b0:419:2823:4c23 with SMTP id b25-20020aa7df99000000b0041928234c23mr9152325edy.341.1647861107296;
        Mon, 21 Mar 2022 04:11:47 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906270800b006bbd3efa6b8sm6731985ejc.80.2022.03.21.04.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 04:11:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 21 Mar 2022 12:11:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.18
Message-ID: <YjhdcJB4FaLfsoyO@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-03-21

   # HEAD: cd27ccfc727e99352321c0c75012ab9c5a90321e jump_label: Refactor #ifdef of struct static_key

Changes in this cycle were:

 - bitops & cpumask:
    - Always inline various generic helpers, to improve code generation,
      but also for instrumentation, found by noinstr validation.
    - Add a x86-specific cpumask_clear_cpu() helper to improve code generation

 - atomics:
    - Fix atomic64_{read_acquire,set_release} fallbacks

 - lockdep:
    - Fix /proc/lockdep output loop iteration for classes
    - Fix /proc/lockdep potential access to invalid memory
    - minor cleanups
    - Add Mark Rutland as reviewer for atomic primitives

 - jump labels:
    - Clean up the code a bit

 - misc:
    - Add __sched annotations to percpu rwsem primitives
    - Enable RT_MUTEXES on PREEMPT_RT by default
    - Stray v8086_mode() inlining fix, result of noinstr objtool validation

 Thanks,

	Ingo

------------------>
Borislav Petkov (4):
      asm-generic/bitops: Always inline all bit manipulation helpers
      cpumask: Always inline helpers which use bit manipulation functions
      cpumask: Add a x86-specific cpumask_clear_cpu() helper
      x86/ptrace: Always inline v8086_mode() for instrumentation

Mark Rutland (2):
      MAINTAINERS: add myself as reviewer for atomics
      atomics: Fix atomic64_{read_acquire,set_release} fallbacks

Masahiro Yamada (2):
      jump_label: Avoid unneeded casts in STATIC_KEY_INIT_{TRUE,FALSE}
      jump_label: Refactor #ifdef of struct static_key

Minchan Kim (1):
      locking: Add missing __sched attributes

Sebastian Andrzej Siewior (2):
      locking/local_lock: Make the empty local_lock_*() function a macro.
      locking: Enable RT_MUTEXES by default on PREEMPT_RT.

Waiman Long (2):
      locking/lockdep: Avoid potential access of invalid memory in lock_class
      locking/lockdep: Iterate lock_classes directly when reading lockdep files

Xiu Jianfeng (1):
      lockdep: Use memset_startat() helper in reinit_class()


 MAINTAINERS                                        |  1 +
 arch/x86/include/asm/cpumask.h                     | 10 +++++
 arch/x86/include/asm/ptrace.h                      |  2 +-
 include/asm-generic/bitops/instrumented-atomic.h   | 12 ++---
 .../asm-generic/bitops/instrumented-non-atomic.h   | 16 +++----
 include/linux/atomic/atomic-arch-fallback.h        | 38 +++++++++++++---
 include/linux/cpumask.h                            | 18 ++++----
 include/linux/jump_label.h                         | 13 ++----
 include/linux/local_lock_internal.h                |  6 +--
 init/Kconfig                                       |  1 +
 kernel/locking/lockdep.c                           | 43 ++++++++++--------
 kernel/locking/lockdep_internals.h                 |  6 ++-
 kernel/locking/lockdep_proc.c                      | 51 ++++++++++++++++++----
 kernel/locking/percpu-rwsem.c                      |  5 ++-
 kernel/locking/rwsem.c                             |  2 +-
 scripts/atomic/fallbacks/read_acquire              | 11 ++++-
 scripts/atomic/fallbacks/set_release               |  7 ++-
 17 files changed, 168 insertions(+), 74 deletions(-)
