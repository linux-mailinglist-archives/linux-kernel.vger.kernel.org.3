Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5050D464DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349331AbhLAMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:37:22 -0500
Received: from foss.arm.com ([217.140.110.172]:35896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243419AbhLAMhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:37:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E9971477;
        Wed,  1 Dec 2021 04:34:00 -0800 (PST)
Received: from e127744.cambridge.arm.com (e127744.cambridge.arm.com [10.1.32.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB1BC3F694;
        Wed,  1 Dec 2021 04:33:56 -0800 (PST)
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
Subject: [PATCH v1 0/4] Support register names from all architectures
Date:   Wed,  1 Dec 2021 12:33:28 +0000
Message-Id: <20211201123334.679131-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changeset applies some corrections to the way system
registers are processed and presented when reading perf.data files using
the various perf tools.

The commit message from [4/4] shows how register names aren't correctly
presented when performing x-arch analysis of perf.data files (i.e.
recording in one arch, then reading the file from a different arch).

Please let me know if there are any concerns with this approach, or if
any improvements can be made for subsequent re-rolls of the changeset.

  - [PATCH 1/4] Fixes a potential out-of-bounds access when reading the
    values of the registers in the perf.data file.
  - [PATCH 2/4] Modifies one of the callbacks in "struct scripting_ops"
    so that the python version can obtain the correct register names.
  - [PATCH 3/4] Adds header files with the register indices and names
    from all architectures, which are used by the next patch.
  - [PATCH 4/4] Refactors the function "perf_reg_name" so that it can
    support registers from all architectures, not just the local one.

Thanks,
German

German Gomez (4):
  perf tools: Prevent out-of-bounds access to registers
  perf script: Add "struct machine" parameter to process_event callback
  perf tools: Crete header files with register names
  perf tools: Support register names from all architectures

 tools/perf/arch/arm/include/perf_regs.h       |  42 --------
 tools/perf/arch/arm64/include/perf_regs.h     |  76 -------------
 tools/perf/arch/csky/include/perf_regs.h      |  82 --------------
 tools/perf/arch/mips/include/perf_regs.h      |  69 ------------
 tools/perf/arch/powerpc/include/perf_regs.h   |  66 ------------
 tools/perf/arch/riscv/include/perf_regs.h     |  74 -------------
 tools/perf/arch/s390/include/perf_regs.h      |  78 --------------
 tools/perf/arch/x86/include/perf_regs.h       |  82 --------------
 tools/perf/builtin-script.c                   |  26 ++---
 tools/perf/util/event.h                       |   5 +-
 tools/perf/util/perf_regs.c                   |   3 +
 tools/perf/util/perf_regs.h                   |  33 +++++-
 tools/perf/util/perf_regs_arm.h               |  57 ++++++++++
 tools/perf/util/perf_regs_arm64.h             |  83 ++++++++++++++
 tools/perf/util/perf_regs_csky.h              | 101 ++++++++++++++++++
 tools/perf/util/perf_regs_mips.h              |  76 +++++++++++++
 tools/perf/util/perf_regs_powerpc.h           |  74 +++++++++++++
 tools/perf/util/perf_regs_riscv.h             |  81 ++++++++++++++
 tools/perf/util/perf_regs_s390.h              |  85 +++++++++++++++
 tools/perf/util/perf_regs_x86.h               |  87 +++++++++++++++
 .../util/scripting-engines/trace-event-perl.c |   3 +-
 .../scripting-engines/trace-event-python.c    |  33 +++---
 tools/perf/util/session.c                     |  25 ++---
 tools/perf/util/trace-event-scripting.c       |   3 +-
 tools/perf/util/trace-event.h                 |   3 +-
 25 files changed, 733 insertions(+), 614 deletions(-)
 create mode 100644 tools/perf/util/perf_regs_arm.h
 create mode 100644 tools/perf/util/perf_regs_arm64.h
 create mode 100644 tools/perf/util/perf_regs_csky.h
 create mode 100644 tools/perf/util/perf_regs_mips.h
 create mode 100644 tools/perf/util/perf_regs_powerpc.h
 create mode 100644 tools/perf/util/perf_regs_riscv.h
 create mode 100644 tools/perf/util/perf_regs_s390.h
 create mode 100644 tools/perf/util/perf_regs_x86.h

-- 
2.25.1

