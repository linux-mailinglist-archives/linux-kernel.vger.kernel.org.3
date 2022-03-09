Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F44D26AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiCIDiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiCIDiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:38:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49CF4A0BFA;
        Tue,  8 Mar 2022 19:37:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C831D1650;
        Tue,  8 Mar 2022 19:37:02 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.52.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C6643FA4D;
        Tue,  8 Mar 2022 19:36:56 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     james.clark@arm.com, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 0/8] perf: Expand perf_branch_entry
Date:   Wed,  9 Mar 2022 09:06:34 +0530
Message-Id: <20220309033642.144769-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This actually combines following patches and series into a single series.

- https://lore.kernel.org/all/1642998653-21377-12-git-send-email-anshuman.khandual@arm.com/
- https://lore.kernel.org/all/1643348653-24367-1-git-send-email-anshuman.khandual@arm.com/
- https://lore.kernel.org/all/1645681014-3346-1-git-send-email-anshuman.khandual@arm.com/

This series applies on v5.17-rc7

perf API

The series being applied

- Clean : tools/perf/check-headers.sh
- Clean : diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

Todo

- Update perf report tool to process PERF_BR_EXTEND_ABI (when available),
  then fetch and report branch types from perf_branch_entry.new_type field.

References

- BRBE captured branch record information

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers/BRBINF-n--EL1--Branch-Record-Buffer-Information-Register--n-?lang=en

- BRBE based perf branch stack implementation on arm64 platform

https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

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
  perf: Add irq and exception return branch types
  perf: Add system error and not in transaction branch types
  perf: Extend branch type classification
  perf: Capture branch privilege information
  perf/tools: Add irq and exception return branch types
  perf/tools: Add system error and not in transaction branch types
  perf/tools: Extend branch type classification
  perf/tools: Add branch privilege information request flag

 arch/x86/events/intel/lbr.c              |  6 ++---
 include/uapi/linux/perf_event.h          | 31 +++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h    | 31 +++++++++++++++++++++++-
 tools/perf/Documentation/perf-record.txt |  1 +
 tools/perf/util/branch.c                 |  7 +++++-
 tools/perf/util/parse-branch-options.c   |  1 +
 6 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.25.1

