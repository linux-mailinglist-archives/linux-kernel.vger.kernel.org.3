Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC7479037
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhLQPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:45:32 -0500
Received: from foss.arm.com ([217.140.110.172]:59238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhLQPpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:45:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C720E1042;
        Fri, 17 Dec 2021 07:45:30 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEF3A3F774;
        Fri, 17 Dec 2021 07:45:28 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/6] perf tools/arm64: Fix missing leaf-function callers in ARM64 when using "--call-graph=fp"
Date:   Fri, 17 Dec 2021 15:45:14 +0000
Message-Id: <20211217154521.80603-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This cset applies on top of [1])

Call-graphs on ARM64 using the option "--call-grah fp" are missing the
callers of the leaf functions. See [PATCH 6/6] for a before and after
after example using this cset.

[1] https://lore.kernel.org/all/20211207180653.1147374-1-german.gomez@arm.com/

---
Changes since v4
  - [PATCH 4/6] Apply Mark Rutland's comments.
  - [PATCH 6/6] Rewrite commit log.

Changes since v3
  - Only record LR register instead of all registers in [PATCH 1/6].
  - Introduce [PATCH 5/6] to refactor the SAMPL_REG macro.
  - Fix compilation issues on different platforms.

Alexandre Truong (5):
  perf tools: record ARM64 LR register automatically
  perf tools: add a mechanism to inject stack frames
  perf tools: Refactor script__setup_sample_type()
  perf tools: enable dwarf_callchain_users on arm64
  perf tools: determine if LR is the return address

German Gomez (1):
  perf tools: Refactor SMPL_REG macro in perf_regs.h

 tools/perf/arch/arm64/util/machine.c          |  7 +++
 tools/perf/builtin-record.c                   |  8 +++
 tools/perf/builtin-report.c                   |  4 +-
 tools/perf/builtin-script.c                   | 13 +---
 tools/perf/util/Build                         |  1 +
 .../util/arm64-frame-pointer-unwind-support.c | 63 +++++++++++++++++++
 .../util/arm64-frame-pointer-unwind-support.h | 10 +++
 tools/perf/util/callchain.c                   | 14 ++++-
 tools/perf/util/callchain.h                   |  4 +-
 tools/perf/util/machine.c                     | 50 ++++++++++++++-
 tools/perf/util/machine.h                     |  1 +
 tools/perf/util/perf_regs.h                   |  7 ++-
 12 files changed, 162 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.c
 create mode 100644 tools/perf/util/arm64-frame-pointer-unwind-support.h

-- 
2.25.1

