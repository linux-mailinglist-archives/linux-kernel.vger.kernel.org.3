Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86F46C255
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbhLGSKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:10:47 -0500
Received: from foss.arm.com ([217.140.110.172]:37990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhLGSKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:10:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3A9111FB;
        Tue,  7 Dec 2021 10:07:15 -0800 (PST)
Received: from e127744.cambridge.arm.com (e127744.cambridge.arm.com [10.1.37.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D95D3F73B;
        Tue,  7 Dec 2021 10:07:12 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] Support register names of all architectures
Date:   Tue,  7 Dec 2021 18:06:49 +0000
Message-Id: <20211207180653.1147374-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changeset applies some corrections to the way system
registers are processed and presented when reading perf.data files using
the various perf tools.

The commit message from [3/3] shows how register names aren't correctly
presented when performing x-arch analysis of perf.data files (recording
in one arch, then reading the file from a different arch).

  - [PATCH 1/3] Fixes a potential out-of-bounds access when reading the
    values of the registers in the perf.data file.
  - [PATCH 2/3] Fixes an issue of ARM and ARM64 registers having the
    same enum name.
  - [PATCH 3/3] Refactors the function "perf_reg_name" declared in the
   "tools/perf/util/perf_regs.h" header, in order to support every arch.

Thanks,
German

--
Changes since v1

  - Added "Reported-by" tags.
  - Removed [PATCH 2/4] because it's not needed (suggested by Athira
    Rajeev).
  - Removed [PATCH 3/4] which created additional header files with the
    register names of every arch.
  - Introduced [PATCH 2/3] to deal with ARM and ARM64 registers having the
    same enum name across "/tools/perf/".
  - Reworked the refactor of "perf_reg_name" function (now implemented in
    perf_regs.c, rather than in the header file) in [PATCH 3/3].

German Gomez (3):
  perf tools: Prevent out-of-bounds access to registers
  perf tools: Rename perf_event_arm_regs for ARM64 registers
  perf tools: Support register names from all archs

 tools/perf/arch/arm/include/perf_regs.h       |  42 --
 tools/perf/arch/arm64/include/perf_regs.h     |  78 +-
 tools/perf/arch/csky/include/perf_regs.h      |  82 ---
 tools/perf/arch/mips/include/perf_regs.h      |  69 --
 tools/perf/arch/powerpc/include/perf_regs.h   |  66 --
 tools/perf/arch/riscv/include/perf_regs.h     |  74 --
 tools/perf/arch/s390/include/perf_regs.h      |  78 --
 tools/perf/arch/x86/include/perf_regs.h       |  82 ---
 tools/perf/builtin-script.c                   |  18 +-
 tools/perf/util/event.h                       |   5 +-
 tools/perf/util/libunwind/arm64.c             |   2 +
 tools/perf/util/perf_regs.c                   | 671 +++++++++++++++++-
 tools/perf/util/perf_regs.h                   |  10 +-
 .../scripting-engines/trace-event-python.c    |  10 +-
 tools/perf/util/session.c                     |  25 +-
 15 files changed, 709 insertions(+), 603 deletions(-)

-- 
2.25.1

