Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EDF531736
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiEWQsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiEWQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:48:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4FD61294;
        Mon, 23 May 2022 09:48:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c10so19918210edr.2;
        Mon, 23 May 2022 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Unoh6++mD5ubFFMqdb6CNOYfw22NYZiGhtE26Pq8f2c=;
        b=DGs9ycE0eagXUg7ksCA83kMtfw2S/VbJRaBViO7ug1R+3FUgZXXSAnbL58a6m7ClJM
         XzIwGfgrmLLf0KeeDgFfWhkYy22AchMTldIOSHA4mbOQ7WCDc+24Hp6mHWH42ST1Odvp
         VCnkLykyCsPD7t+Jz3BrmUnoFjEp4Branti5AvLPZxWUdRmIFBRh5Ofp9xfjFIN0uKKc
         xMTUCq/CAjjEb96C2azXS17cbaxLE6XZyz7KWJDGJ/8ycc5AIev9I2TbM0dbLRX3k6bY
         skZeYcHvQJH56gozsV/q2aJKjLLPQ8Ok5FGU12OV0lzkavuZUqDld263fSPUaAs7pzhL
         /qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Unoh6++mD5ubFFMqdb6CNOYfw22NYZiGhtE26Pq8f2c=;
        b=S+egu2KtdLg4e9pjbgB2OQ0ej60yIGcx08KrhccatJ5wNLrIQkMlnwgnJEcMyzawtt
         FE6F56aS0y0VUwf4SJOIzt4YzMlq1g7UvN4K5isPPx561USwHEe7aWCgx2ioVimjPwYQ
         neL4HCOR6vVM8Xim5RC/0c763FMG3dmI5IcGvBtz1CIOiusPsQO+2Ys+Pyzg7FxWYoun
         ooE3Lbj5cyD7KcPsYMtbViJMCFc70K4pT/pLfU+u2YNPKyWOTnvOdSh1CxVATDsqjgEe
         5IXMcXbWmTEd98tL+fd45cEmgUAt7IaFqrZXvZOon/w/R9vn1Uq4zGn9y8hbt1oaSOXx
         2P7A==
X-Gm-Message-State: AOAM530TfU7imjRfLIqp/LEX9UyB/txxwo2eNmIHDI8wteu/6ZBSUDHH
        nrwmFr2PyBNZRoAOctDoyVI=
X-Google-Smtp-Source: ABdhPJxzyhFZQ3r+urq+nFrlcMJZj2LjSSJcqiEB54+VOVcqXFOdQtd/Yvs8UIh6jXAPtRV1D572gQ==
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id q1-20020aa7cc01000000b0042a402bb983mr24744174edt.257.1653324490528;
        Mon, 23 May 2022 09:48:10 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7cb45000000b0042aa7e0f892sm8577847edt.15.2022.05.23.09.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:48:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 23 May 2022 18:48:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] perf events changes for v5.19
Message-ID: <You6yGPUttvBcg8s@gmail.com>
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

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-05-23

   # HEAD: bae19fdd7e9e759580ac4693d2df3bc23ab415d7 perf/x86/amd/core: Fix reloading events for SVM

Perf events changes for this cycle were:

Platform PMU changes:
=====================

 - x86/intel:
    - Add new Intel Alder Lake and Raptor Lake support

 - x86/amd:
    - AMD Zen4 IBS extensions support
    - Add AMD PerfMonV2 support
    - Add AMD Fam19h Branch Sampling support

Generic changes:
================

 - signal: Deliver SIGTRAP on perf event asynchronously if blocked

   Perf instrumentation can be driven via SIGTRAP, but this causes a problem
   when SIGTRAP is blocked by a task & terminate the task.

   Allow user-space to request these signals asynchronously (after they get
   unblocked) & also give the information to the signal handler when this
   happens:

     " To give user space the ability to clearly distinguish synchronous from
       asynchronous signals, introduce siginfo_t::si_perf_flags and
       TRAP_PERF_FLAG_ASYNC (opted for flags in case more binary information is
       required in future).

       The resolution to the problem is then to (a) no longer force the signal
       (avoiding the terminations), but (b) tell user space via si_perf_flags
       if the signal was synchronous or not, so that such signals can be
       handled differently (e.g. let user space decide to ignore or consider
       the data imprecise). "

 - Unify/standardize the /sys/devices/cpu/events/* output format.

 - Misc fixes & cleanups.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      perf/x86/amd: Run AMD BRS code only on supported hw

Kan Liang (5):
      perf/x86: Add new Alder Lake and Raptor Lake support
      perf/x86/msr: Add new Alder Lake and Raptor Lake support
      perf/x86/cstate: Add new Alder Lake and Raptor Lake support
      perf/x86/uncore: Clean up uncore_pci_ids[]
      perf/x86/uncore: Add new Alder Lake and Raptor Lake support

Marco Elver (1):
      signal: Deliver SIGTRAP on perf event asynchronously if blocked

Peter Zijlstra (1):
      perf/x86/amd: Fix AMD BRS period adjustment

Ravi Bangoria (6):
      perf/amd/ibs: Use interrupt regs ip for stack unwinding
      perf/amd/ibs: Cascade pmu init functions' return value
      perf/amd/ibs: Use ->is_visible callback for dynamic attributes
      perf/amd/ibs: Add support for L3 miss filtering
      perf/amd/ibs: Advertise zen4_ibs_extensions as pmu capability attribute
      perf/ibs: Fix comment

Sandipan Das (7):
      x86/cpufeatures: Add PerfMonV2 feature bit
      x86/msr: Add PerfCntrGlobal* registers
      perf/x86/amd/core: Detect PerfMonV2 support
      perf/x86/amd/core: Detect available counters
      perf/x86/amd/core: Add PerfMonV2 counter control
      perf/x86/amd/core: Add PerfMonV2 overflow handling
      perf/x86/amd/core: Fix reloading events for SVM

Stephane Eranian (9):
      perf/core: Add perf_clear_branch_entry_bitfields() helper
      x86/cpufeatures: Add AMD Fam19h Branch Sampling feature
      perf/x86/amd: Add AMD Fam19h Branch Sampling support
      perf/x86/amd: Add branch-brs helper event for Fam19h BRS
      perf/x86/amd: Enable branch sampling priv level filtering
      perf/x86/amd: Add AMD branch sampling period adjustment
      perf/x86/amd: Make Zen3 branch sampling opt-in
      ACPI: Add perf low power callback
      perf/x86/amd: Add idle hooks for branch sampling

Yang Jihong (1):
      perf/x86: Unify format of events sysfs show

Zucheng Zheng (1):
      perf/x86/amd: Remove unused variable 'hwc'


 arch/arm/kernel/signal.c             |   1 +
 arch/arm64/kernel/signal.c           |   1 +
 arch/arm64/kernel/signal32.c         |   1 +
 arch/m68k/kernel/signal.c            |   1 +
 arch/sparc/kernel/signal32.c         |   1 +
 arch/sparc/kernel/signal_64.c        |   1 +
 arch/x86/events/Kconfig              |   8 +
 arch/x86/events/amd/Makefile         |   1 +
 arch/x86/events/amd/brs.c            | 367 +++++++++++++++++++++++++
 arch/x86/events/amd/core.c           | 505 +++++++++++++++++++++++++++++++++--
 arch/x86/events/amd/ibs.c            | 209 ++++++++++++---
 arch/x86/events/core.c               |  12 +-
 arch/x86/events/intel/core.c         |   2 +
 arch/x86/events/intel/cstate.c       |   2 +
 arch/x86/events/intel/lbr.c          |  36 ++-
 arch/x86/events/intel/uncore.c       |   2 +
 arch/x86/events/intel/uncore_snb.c   | 454 ++++++++++---------------------
 arch/x86/events/msr.c                |   2 +
 arch/x86/events/perf_event.h         | 125 +++++++--
 arch/x86/include/asm/amd-ibs.h       |   2 +-
 arch/x86/include/asm/cpufeatures.h   |   3 +-
 arch/x86/include/asm/msr-index.h     |   9 +
 arch/x86/include/asm/perf_event.h    |  43 +++
 arch/x86/kernel/cpu/scattered.c      |   1 +
 arch/x86/kernel/signal_compat.c      |   2 +
 drivers/acpi/acpi_pad.c              |   7 +
 drivers/acpi/processor_idle.c        |   5 +
 include/linux/compat.h               |   1 +
 include/linux/perf_event.h           |  22 ++
 include/linux/sched/signal.h         |   2 +-
 include/uapi/asm-generic/siginfo.h   |   7 +
 kernel/events/core.c                 |   4 +-
 kernel/signal.c                      |  18 +-
 tools/arch/x86/include/asm/amd-ibs.h |   2 +-
 34 files changed, 1445 insertions(+), 414 deletions(-)
 create mode 100644 arch/x86/events/amd/brs.c
