Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283DB4700C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbhLJMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:41:09 -0500
Received: from foss.arm.com ([217.140.110.172]:41444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhLJMlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:41:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3222B;
        Fri, 10 Dec 2021 04:37:29 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.35.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D341F3F5A1;
        Fri, 10 Dec 2021 04:37:26 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] perf vendor events: Arm Neoverse N2
Date:   Fri, 10 Dec 2021 12:37:03 +0000
Message-Id: <20211210123706.7490-1-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the ability for perf to recognise the Arm
Neoverse N2 core and what counters are available.

The first patch adds the new counters to the common and microarch json
file (because they can also exist in other ArmV8 and ArmV9 cpus) Files
are also added to pmu-events/arch/arm64/arm/neoverse-n2 so that 'perf list'
categorises the counters.

The second patch renames armv8-common-and-microarch.json and
armv8-recommended.json, removing the armv8 prefix to reflect that
they can include counters for armv9.

Changes in v2:
 - Addition of a cover letter
 - Small changes in commit messages
 - Omission of a patch reformatting whitespace that was
   applied by Arnaldo

Previous version:
  https://lore.kernel.org/lkml/20211203123525.31127-1-andrew.kilroy@arm.com/

Andrew Kilroy (2):
  perf vendor events: For the Arm Neoverse N2
  perf vendor events: Rename arm64 arch std event files

 .../arch/arm64/arm/neoverse-n2/branch.json    |   8 +
 .../arch/arm64/arm/neoverse-n2/bus.json       |  20 ++
 .../arch/arm64/arm/neoverse-n2/cache.json     | 155 ++++++++++++++
 .../arch/arm64/arm/neoverse-n2/exception.json |  47 +++++
 .../arm64/arm/neoverse-n2/instruction.json    | 143 +++++++++++++
 .../arch/arm64/arm/neoverse-n2/memory.json    |  38 ++++
 .../arch/arm64/arm/neoverse-n2/other.json     |   5 +
 .../arch/arm64/arm/neoverse-n2/pipeline.json  |  23 ++
 .../arch/arm64/arm/neoverse-n2/spe.json       |  14 ++
 .../arch/arm64/arm/neoverse-n2/trace.json     |  29 +++
 ...croarch.json => common-and-microarch.json} | 198 ++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 ...rmv8-recommended.json => recommended.json} |   0
 13 files changed, 681 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json
 rename tools/perf/pmu-events/arch/arm64/{armv8-common-and-microarch.json => common-and-microarch.json} (76%)
 rename tools/perf/pmu-events/arch/arm64/{armv8-recommended.json => recommended.json} (100%)

-- 
2.17.1

