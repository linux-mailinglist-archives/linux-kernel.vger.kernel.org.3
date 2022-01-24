Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AD449782C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbiAXEba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:31:30 -0500
Received: from foss.arm.com ([217.140.110.172]:47110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241400AbiAXEb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:31:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B720ED1;
        Sun, 23 Jan 2022 20:31:28 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15E983F73B;
        Sun, 23 Jan 2022 20:31:19 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [RFC V1 00/11] arm64/perf: Enable branch stack sampling
Date:   Mon, 24 Jan 2022 10:00:42 +0530
Message-Id: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables perf branch stack sampling support on arm64 platform
via a new arch feature called Branch Record Buffer Extension (BRBE). All
relevant register definitions could be accessed here.

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers

The last two patches extend the perf ABI to accommodate additional branch
information that can be captured in BRBE. This series applies on v5.17-rc1.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (11):
  perf: Consolidate branch sample filter helpers
  arm64/perf: Add register definitions for BRBE
  arm64/perf: Update struct arm_pmu for BRBE
  arm64/perf: Update struct pmu_hw_events for BRBE
  arm64/perf: Detect support for BRBE
  arm64/perf: Drive BRBE from perf event states
  arm64/perf: Add BRBE driver
  arm64/perf: Enable branch stack sampling
  perf: Add more generic branch types
  perf: Expand perf_branch_entry.type
  perf: Capture branch privilege information

 arch/arm64/include/asm/sysreg.h          | 216 ++++++++++++
 arch/arm64/kernel/perf_event.c           |  48 +++
 arch/x86/events/intel/lbr.c              |   4 +-
 drivers/perf/Kconfig                     |  11 +
 drivers/perf/Makefile                    |   1 +
 drivers/perf/arm_pmu.c                   |  65 +++-
 drivers/perf/arm_pmu_brbe.c              | 432 +++++++++++++++++++++++
 drivers/perf/arm_pmu_brbe.h              | 259 ++++++++++++++
 drivers/perf/arm_pmu_platform.c          |  34 ++
 include/linux/perf/arm_pmu.h             |  49 +++
 include/linux/perf_event.h               |  24 ++
 include/uapi/linux/perf_event.h          |  26 +-
 kernel/events/core.c                     |   9 +-
 tools/include/uapi/linux/perf_event.h    |  26 +-
 tools/perf/Documentation/perf-record.txt |   1 +
 tools/perf/util/branch.c                 |  13 +-
 tools/perf/util/parse-branch-options.c   |   1 +
 17 files changed, 1202 insertions(+), 17 deletions(-)
 create mode 100644 drivers/perf/arm_pmu_brbe.c
 create mode 100644 drivers/perf/arm_pmu_brbe.h

-- 
2.25.1

