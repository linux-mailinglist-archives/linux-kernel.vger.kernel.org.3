Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D18446445A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbhLABFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLABFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:43 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:22 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id a23-20020a62bd17000000b004a3f6892612so13910490pff.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ftLvCa60UkwC9DQwxxLdLczMKYf7Pc65DXe7HZubEc0=;
        b=erFqij04vkgsvwXcdk06wAHmHIPQLWFwu9AFbvXVzi/PSAgQZnxYm0doNWXX5pxH4R
         Q5ozKx2NtQlWYzPS4o0xzfvEN/XWZAvoFgZWNQ38u0tnkH4SWFKbIIdE5tILyCjAutIE
         MBNsHmlwmMyR7Mb6WD+ADBv+iahkxamBRU3hBAGIdNo6IQA0IojPlTO1e0Siu5Zk9Iik
         QLBTG8bKUMVUCS0TTXm5YHWK2sx4w/Jgzj8wEaw2XlSwXuU1K/7V1aOxOIhP+2tq/9XC
         n2Y9/nxpsZPflSqmAPsZCzfh4jFVBmrq6cFd1Swx/d7HG/I/JkXxmz7YXNYhkhL631X1
         fD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ftLvCa60UkwC9DQwxxLdLczMKYf7Pc65DXe7HZubEc0=;
        b=0GUHi2MqeLVSuQeWNQVLu4HNrVPJV63vVPkXOZth2YKG0rBGWnmw81hDhi1Vft9VIr
         RAz7NF3dgV2kf1XU3ZMobFiH+Vhhl5H3MXApGXj+62dQ7mtbm+2IT5pIGNxJ0GH4AoYG
         b1TeLOwHSfnjbEvtr6Od3z06/hq105xcU6d8ua0GMv6EWcuAR+MeTJeeCTtvaNu7J2T7
         kIABc4PqFkUDjif7d3hn1tP+oyV3pcb03183IPE576zcKBc8XECfba+EnDDN25lUtXsr
         eoTAOP1fcv7+lN5O+8d43O4KUDS8ajs2NouxzugU5JA0i92nH7vOrY3hJOuVwVBe6HWY
         eiDg==
X-Gm-Message-State: AOAM53002HCPmX2IGKThXZwoY4H/YUp7HxOt85MZjTwhEKRmhBL5yn9L
        4BGkjmvrlJ7lq84DeVqfa+rnuo+frArrLSNxxrE0jwTeU1hd2NOIGeB/fNe2QA4bUw4moLE1NUP
        v4W+bmqv2511mURONT7srayD29xh0hnOMzT9o2zF0s/taoab6y5gB083s/vkDTrpHXfF4EzJf
X-Google-Smtp-Source: ABdhPJx2mxuYgSv8w/uV+PI675aRhXpIpFt1V/iqoB4zJjJyGqKzxcMl22/tGODmmlGbRkRQyXa/0B0xAlSY
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a17:90a:d3c3:: with SMTP id
 d3mr3172424pjw.209.1638320542054; Tue, 30 Nov 2021 17:02:22 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:04 -0800
Message-Id: <20211201010217.886919-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the AMD Fam19h 16-deep branch sampling
feature as described in the AMD PPR Fam19h Model 01h Revision B1 section
2.1.13. This is a model specific extension. It is not an architected AMD
feature.

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

Kim Phillips (1):
  perf tools: improve IBS error handling

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
  perf tools: add branch-brs as a new event
  perf tools: improve error handling of AMD Branch Sampling
  perf report: add addr_from/addr_to sort dimensions

 arch/x86/events/Kconfig            |   8 +
 arch/x86/events/amd/Makefile       |   1 +
 arch/x86/events/amd/brs.c          | 363 +++++++++++++++++++++++++++++
 arch/x86/events/amd/core.c         | 217 ++++++++++++++++-
 arch/x86/events/core.c             |  17 +-
 arch/x86/events/intel/lbr.c        |  36 ++-
 arch/x86/events/perf_event.h       | 143 ++++++++++--
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   4 +
 arch/x86/include/asm/perf_event.h  |  21 ++
 drivers/acpi/acpi_pad.c            |   6 +
 drivers/acpi/processor_idle.c      |   5 +
 include/linux/perf_event.h         |  22 ++
 tools/perf/util/evsel.c            |  56 +++++
 tools/perf/util/hist.c             |   2 +
 tools/perf/util/hist.h             |   2 +
 tools/perf/util/parse-events.l     |   1 +
 tools/perf/util/sort.c             | 128 ++++++++++
 tools/perf/util/sort.h             |   2 +
 19 files changed, 995 insertions(+), 40 deletions(-)
 create mode 100644 arch/x86/events/amd/brs.c

-- 
2.34.0.rc2.393.gf8c9666880-goog

