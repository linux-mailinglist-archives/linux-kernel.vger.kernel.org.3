Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0643E48D4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiAMJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:11:06 -0500
Received: from foss.arm.com ([217.140.110.172]:41348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbiAMJLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:11:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53FC6D;
        Thu, 13 Jan 2022 01:11:04 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.35.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 367ED3F766;
        Thu, 13 Jan 2022 01:11:02 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        mike.leach@linaro.org
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/6] coresight: Add config flag to enable branch broadcast
Date:   Thu, 13 Jan 2022 09:10:49 +0000
Message-Id: <20220113091056.1297982-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows enabling branch broadcast for Perf hosted sessions (the option
is currently only available for the sysfs interface). Hopefully this could
be useful for testing the decode in perf, for example does a determinisitic
run with branch broadcast enabled look the same as with it disabled? It
could also be used for scenarios like OpenJ9's support for JIT code:

  java -Xjit:perfTool hello.java

Currently this is not working and you get the usual errors of a missing
DSO, but branch broadcast would have to be enabled anyway before working
through this next issue:

  CS ETM Trace: Debug data not found for address 0xffff7b94b058 in /tmp/perf-29360.map

Address range support in Perf for branch broadcast has also not been added
here, but could be added later.

The documentation has been refactored slightly to allow updates to be made
that link the Perf format arguments with the existing documentation.

For Suzuki's comment, I will do it as a separate change that converts all
the other hard coded values to a more consistent sysreg.h style:

  nit: While at this, please could you change the hard coded value
  to ETM4_CFG_BIT_RETSTK ? 

Changes since v1:

  * Added Leo's reviewed by on patch 3
  * Fix bracket styling
  * Add documentation

Applies on top of coresight/next efa56eddf5d5c. But this docs fix is also
required to get the links to work:
  https://marc.info/?l=linux-doc&m=164139331923986&w=2

Also available at: https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-branch-broadcast-v2

James Clark (6):
  coresight: Add config flag to enable branch broadcast
  coresight: Fail to open with return stacks if they are unavailable
  perf cs-etm: Update deduction of TRCCONFIGR register for branch
    broadcast
  Documentation: coresight: Turn numbered subsections into real
    subsections
  Documentation: coresight: Link config options to existing
    documentation
  Documentation: coresight: Expand branch broadcast documentation

 .../coresight/coresight-etm4x-reference.rst   | 14 ++++-
 Documentation/trace/coresight/coresight.rst   | 56 +++++++++++++++++--
 .../hwtracing/coresight/coresight-etm-perf.c  |  2 +
 .../coresight/coresight-etm4x-core.c          | 23 ++++++--
 include/linux/coresight-pmu.h                 |  2 +
 tools/include/linux/coresight-pmu.h           |  2 +
 tools/perf/arch/arm/util/cs-etm.c             |  3 +
 7 files changed, 92 insertions(+), 10 deletions(-)

-- 
2.28.0

