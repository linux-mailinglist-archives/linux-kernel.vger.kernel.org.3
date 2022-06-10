Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB0545AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbiFJDvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiFJDvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:51:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F20AE38A280;
        Thu,  9 Jun 2022 20:51:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B48B1063;
        Thu,  9 Jun 2022 20:51:15 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0CF93F766;
        Thu,  9 Jun 2022 20:51:09 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, acme@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 0/8] perf: Expand perf_branch_entry
Date:   Fri, 10 Jun 2022 09:20:53 +0530
Message-Id: <20220610035101.424112-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branch Record Buffer Extension (BRBE) implementation on arm64 captures more
branch type classification which cannot be accommodated in the current perf
branch record format via perf_branch_entry.type element (4 bit field). Also
it captures privilege information which does not have a corresponding slot
in perf_branch_entry. This series expands struct perf_branch_entry, to meet
both these requirements without breaking the existing user space ABI for
perf tools.

All architecture specific branch types added via perf_branch_entry.new_type
field in [PATCH 3/4] will be used in BRBE implementation on arm64 platform
later on with the following map.

#ifdef CONFIG_ARM64
#define PERF_BR_FIQ		PERF_BR_NEW_ARCH_1
#define PERF_BR_DEBUG_HALT	PERF_BR_NEW_ARCH_2
#define PERF_BR_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
#define PERF_BR_DEBUG_INST	PERF_BR_NEW_ARCH_4
#define PERF_BR_DEBUG_DATA	PERF_BR_NEW_ARCH_5
#endif

This series applies on v5.19-rc1

perf API

The series being applied

- Clean : tools/perf/check-headers.sh
- Clean : diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

References

- BRBE captured branch record information

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers/BRBINF-n--EL1--Branch-Record-Buffer-Information-Register--n-?lang=en

- BRBE based perf branch stack implementation on arm64 platform

https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

Changes in V6:

- Process PERF_BR_EXTEND_ABI in perf tools and fetch from perf_branch_entry.new_type
- Modified the commit message for [PATCH 1/8]

Changes in V5:

https://lore.kernel.org/linux-arm-kernel/20220404045046.634522-1-anshuman.khandual@arm.com/

- Dropped patches [PATCH 1/10] and [PATCH 6/10] related to PERF_BR_[RET|IRQ] - merged
  via the commit cedd3614e5d9c809 ("perf: Add irq and exception return branch types")

- Rebased series on v5.18-rc1

Changes in V4:

https://lore.kernel.org/all/20220315053516.431515-1-anshuman.khandual@arm.com/

- Modified the struct branch_flags as required
- Dropped CONFIG_ARM64 from perf header file to avoid build problem
- Renamed PERF_BR_NEW_<BRANCH_TYPE> as PERF_BR_ARM64_<BRANCH_TYPE>

Changes in V3:

https://lore.kernel.org/all/20220314055857.125421-1-anshuman.khandual@arm.com/

- Fixed small typo s/privillege/privilege in include/uapi/linux/perf_event.h
- Added PRIV_SHIFT in __p_branch_sample_type()
- Added arm64 platform override of the new arch specific branch types
- Renamed s/PERF_BR_XXX/PERF_BR_PRIV_XXX/ for privilege level branch types
- Added PERF_BR_PRIV_UNKNOWN as the starting value
- Expanded perf_branch_entry.priv into a 3 bits field 

Changes in V2:

https://lore.kernel.org/all/20220309033642.144769-1-anshuman.khandual@arm.com/

Cc: Robin Murphy <robin.murphy@arm.com> 
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (8):
  perf: Add system error and not in transaction branch types
  perf: Extend branch type classification
  perf: Capture branch privilege information
  perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
  perf/tools: Add system error and not in transaction branch types
  perf/tools: Extend branch type classification
  perf/tools: Add branch privilege information request flag
  perf/tools: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform

 arch/x86/events/intel/lbr.c               |  2 +-
 include/uapi/linux/perf_event.h           | 36 +++++++++++-
 tools/include/uapi/linux/perf_event.h     | 36 +++++++++++-
 tools/perf/Documentation/perf-record.txt  |  1 +
 tools/perf/builtin-script.c               |  2 +-
 tools/perf/util/branch.c                  | 69 ++++++++++++++++++++++-
 tools/perf/util/branch.h                  |  7 ++-
 tools/perf/util/parse-branch-options.c    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/session.c                 |  2 +-
 10 files changed, 149 insertions(+), 9 deletions(-)

-- 
2.25.1

