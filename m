Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440134E48F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiCVWQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCVWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:16:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C62532FA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y10-20020a5b0d0a000000b00633b9765410so10357164ybp.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TxdZ21cRKx1mC32CcgEQhugvljfHb50lrDHH7QaILLM=;
        b=tZwlmrYGzE4Z+zPhbI/ri5f1jjdJqawtIPCItEhZk8ZKvfKM16fR0Mr6yfRks/DGOB
         sTWMzMLUkAG9JTAh1XOKgL88Vh7ZUyfQRFYDvL0CUR3lR+6Qud6RSy4veJzWzN8CoFbw
         N8pmujm1X5vu+1skhk5NXNZ/HbqDWQKVDrhQl3SfByrf0eGfTQ61Ro1vDDZCMGcFdK1M
         4WGGvSMvws0d3tcqKYoyNR/emwlTGApych6K5lnmp+y2c7zr5VhQajFJn4SuGnaQQjFP
         fqBQSea33HpAYJCqIR/JfdHUvV5x/FZeDmlDJgpzRV8oEpwQ0dLfyT6kYGcwADPnWIdz
         JRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TxdZ21cRKx1mC32CcgEQhugvljfHb50lrDHH7QaILLM=;
        b=dBaCI7D9aeImRt3E3VEq/2v4lMIjnWcvGnZeq2uJoULE+z2IoL8Bx1TomHcPxo3Uts
         i/uo8iLfHhbRkmR3UhymCC9mZiugMrcpuwz/f5TUPrXIqdrR56qPlSfRAxPFQyAYCpaZ
         HFQ9wFLlS5y5KUynxJpDV7NhHluWTkY8Gvr/NixnDQ8mHAjhD0nEhYeMyjzXwOkeiyzH
         Lghjmj68gSC3u1sbuUCKn7KXDXsjZPy/4uF1tCGmOs3HGBXgpbGJNwwTQGWh5QcwZ9kI
         GFAxTLdFFa3qjoIrhdUkilRebQfmYGhr2+ufXFVBrEvuP+eXGh3IYrhAiID2ol75qRVG
         z1GQ==
X-Gm-Message-State: AOAM531ybLHexR2leg8rNY76xhwpGvlRSk3kWaaAkTHIR93q/5QZQ7xP
        CQDtIBOpVlHiVs4KmWmk47UMte9lXxLmaRzAPhUPPBN3EvYNLZV0jYFtg3oTM3AnIFNRx9AiRjW
        lUzU6qgjqVPhq4a+4MT+rKR2DeWGkyuWxFoMv7vTPoym9Q2CkUAxl4clWNeDeAbiQxQ9uzve2
X-Google-Smtp-Source: ABdhPJxR4DapvbMCPnyl8o7Zd5KXnp6TR1sZFMGN7C35K6xY8SqgmwabPxw9QMMnKfbqme3XtSL2A9yMWFui
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a25:910b:0:b0:633:b85d:28c9 with SMTP id
 v11-20020a25910b000000b00633b85d28c9mr22526214ybl.610.1647987325255; Tue, 22
 Mar 2022 15:15:25 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:04 -0700
Message-Id: <20220322221517.2510440-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AMD Fam19h 16-deep branch sampling feature as described
in the AMD PPR Fam19h Model 01h Revision B1 section 2.1.13. This is a model
specific extension. It is not an architected AMD feature.

The Branch Sampling Feature (BRS) provides the statistical taken branch
information necessary to enable autoFDO-style optimization by compilers,
i.e., basic block execution counts.

BRS operates with a 16-deep saturating buffer in MSR registers. There is no
hardware branch type filtering. All control flow changes are captured. BRS
relies on specific programming of the core PMU of Fam19h.  In particular,
the following requirements must be met:
 - the sampling period be greater than 16 (BRS depth)
 - the sampling period must use fixed and not frequency mode

BRS interacts with the NMI interrupt as well. Because enabling BRS is
expensive, it is only activated after P event occurrences, where P is the
desired sampling period. At P occurrences of the event, the counter
overflows, the CPU catches the NMI interrupt, activates BRS for 16 branches
until it saturates, and then delivers the NMI to the kernel. Between the
overflow and the time BRS activates more branches may be executed skewing the
period. All along, the sampling event keeps counting. The skid may be
attenuated by reducing the sampling period by 16.

BRS is integrated into perf_events seamlessly via the same
PERF_RECORD_BRANCH_STACK sample format. BRS generates branch
perf_branch_entry records in the sampling buffer. There is no prediction or
latency information supported. The branches are stored in reverse order of
execution.  The most recent branch is the first entry in each record.

Because BRS must be stopped when a CPU goes into low power mode, the series
includes patches to add callbacks on ACPI low power entry and exit which is
used on AMD processors.

Given that there is no privilege filterting with BRS, the kernel implements
filtering on privlege level.

This version adds a few simple modifications to perf record and report.
1. add the branch-brs event as a builtin such as it can used directly:
   perf record -e branch-brs ...
2. improve error handling for AMD IBS and is contributed by Kim Phillips.
3. use the better error handling to improve error handling for BRS.
4. add two new sort dimensions to help display the branch sampling
   information. Because there is no latency information associated with the
   branch sampling feature perf report would collapse all samples within a
   function into a single histogram entry. This is expected because the
   default sort mode for PERF_SAMPLE_BRANCH_STACK is symbol_from/symbol_to.
   This propagates to the annotation.

For more detailed view of the branch samples, the new sort dimensions
addr_from,addr_to can be used instead as follows:

$ perf report --sort=overhead,comm,dso,addr_from,addr_to 
# Overhead  Command    Shared Object     Source Address   Target Address
# ........  .......... ..............  ..............     ..............
#
     4.21%  test_prg   test_prg       [.] test_threa+0x3c [.] test_threa+0x4
     4.14%  test_prg   test_prg       [.] test_threa+0x3e [.] test_threa+0x2
     4.10%  test_prg   test_prg       [.] test_threa+0x4  [.] test_threa+0x3a
     4.07%  test_prg   test_prg       [.] test_threa+0x2  [.] test_threa+0x3c

Versus the default output:

$ perf report 
# Overhead  Command   Source Shared Object Source Symbol    Target Symbol      Basic Block Cycles
# ........  ......... .................... ................ .................  ..................
#
    99.52%  test_prg  test_prg             [.] test_thread  [.] test_thread    -                 

BRS can be used with any sampling event. However, it is recommended to use
the RETIRED_BRANCH event because it matches what the BRS captures. For
convenience, a pseudo event matching the branches captured by BRS is
exported by the kernel (branch-brs):

$ perf record -b -e cpu/branch-brs/ -c 1000037 test

$ perf report -D
56531696056126 0x193c000 [0x1a8]: PERF_RECORD_SAMPLE(IP, 0x2): 18122/18230: 0x401d24 period: 1000037 addr: 0
... branch stack: nr:16
.....  0: 0000000000401d24 -> 0000000000401d5a 0 cycles      0
.....  1: 0000000000401d5c -> 0000000000401d24 0 cycles      0
.....  2: 0000000000401d22 -> 0000000000401d5c 0 cycles      0
.....  3: 0000000000401d5e -> 0000000000401d22 0 cycles      0
.....  4: 0000000000401d20 -> 0000000000401d5e 0 cycles      0
.....  5: 0000000000401d3e -> 0000000000401d20 0 cycles      0
.....  6: 0000000000401d42 -> 0000000000401d3e 0 cycles      0
.....  7: 0000000000401d3c -> 0000000000401d42 0 cycles      0
.....  8: 0000000000401d44 -> 0000000000401d3c 0 cycles      0
.....  9: 0000000000401d3a -> 0000000000401d44 0 cycles      0
..... 10: 0000000000401d46 -> 0000000000401d3a 0 cycles      0
..... 11: 0000000000401d38 -> 0000000000401d46 0 cycles      0
..... 12: 0000000000401d48 -> 0000000000401d38 0 cycles      0
..... 13: 0000000000401d36 -> 0000000000401d48 0 cycles      0
..... 14: 0000000000401d4a -> 0000000000401d36 0 cycles      0
..... 15: 0000000000401d34 -> 0000000000401d4a 0 cycles      0
 ... thread: test:18230
 ...... dso: test

Special thanks to Kim Phillips @ AMD for the testing, reviews and
contributions.

V2 makes the following changes:
  - the low power callback code has be reworked completly. It is not
    impacting the generic perf_events code anymore. This is all handled
    via x86 code and only for ACPI low power driver which seems to be the
    default on AMD. The change in acpi_pad.c and processor_idle.c has no
    impact on non x86 architectures, on Intel x86 or AMD without BRS, a
    jump label is used to void the code unless necessary
  - BRS is an opt-in compile time option for the kernel
  - branch_stack bit clearing helper is introduced
  - As for the fact that BRS holds the NMI and that it may conflict with
    other sampling events and introduced skid, this is not really a problem
    because AMD PMI skid is already very large prompting special handling in
    amd_pmu_wait_on_overflow(), so adding a few cycles while the CPU executes
    at most 16 taken branches is not a problem.


V3 makes the following changes:
   - simplifies the handling of BRS enable/disable to mimic the Intel LBR code
     path more closely. That removes some callbacks in generic x86 code
   - add config option to compile BRS as an opt-in (off by default)
   - updated perf tool error reporting patch updates by Kim Phillips

V4 makes the following changes:
   - rebase to latest tip.git (commit 6f5ac142e5df)
   - integrate Kim Phillips latest perf tool error handling patches


V5 makes the following changes:
   - rebased to 5.17-rc1
   - integrated feedback from PeterZ about AMD perf_events callbacks
   - fix cpufeature macros name X86_FEATURE_BRS
   - integrated all perf tool error handling from kim Phillips

V6 makes the following changes:
   - rebase to 5.17-rc3
   - fix the typo in the Kconfig for BRS opt-in
   - reword all changelogs to be more aligned with standard

V7 makes the following changes:
   - rebased to 5.17-rc8
   - Restrict BRS to be used only with RETIRED_TAKEN_BRANCH event in order to
     avoid adding more skid to other events in case that are monitored
     concurrently
   - fixed bugs in the perf tool enhanced error handling for IBS and BRS

Kim Phillips (1):
  perf tools: Improve IBS error handling

Stephane Eranian (12):
  perf/core: add perf_clear_branch_entry_bitfields() helper
  x86/cpufeatures: add AMD Fam19h Branch Sampling feature
  perf/x86/amd: add AMD Fam19h Branch Sampling support
  perf/x86/amd: add branch-brs helper event for Fam19h BRS
  perf/x86/amd: enable branch sampling priv level filtering
  perf/x86/amd: add AMD branch sampling period adjustment
  perf/x86/amd: make Zen3 branch sampling opt-in
  ACPI: add perf low power callback
  perf/x86/amd: add idle hooks for branch sampling
  perf tools: fix NULL point in evsel__env()
  perf tools: Improve error handling of AMD Branch Sampling
  perf report: add addr_from/addr_to sort dimensions

 arch/x86/events/Kconfig            |   8 +
 arch/x86/events/amd/Makefile       |   1 +
 arch/x86/events/amd/brs.c          | 363 +++++++++++++++++++++++++++++
 arch/x86/events/amd/core.c         | 252 +++++++++++++++++++-
 arch/x86/events/core.c             |  17 +-
 arch/x86/events/intel/lbr.c        |  36 ++-
 arch/x86/events/perf_event.h       | 143 ++++++++++--
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   4 +
 arch/x86/include/asm/perf_event.h  |  21 ++
 drivers/acpi/acpi_pad.c            |   6 +
 drivers/acpi/processor_idle.c      |   5 +
 include/linux/perf_event.h         |  22 ++
 tools/perf/util/evsel.c            |  48 +++-
 tools/perf/util/hist.c             |   2 +
 tools/perf/util/hist.h             |   2 +
 tools/perf/util/sort.c             | 128 ++++++++++
 tools/perf/util/sort.h             |   2 +
 18 files changed, 1020 insertions(+), 41 deletions(-)
 create mode 100644 arch/x86/events/amd/brs.c

-- 
2.35.1.894.gb6a874cedc-goog

