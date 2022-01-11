Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD348B068
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbiAKPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:08:18 -0500
Received: from foss.arm.com ([217.140.110.172]:47806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244575AbiAKPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:08:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 747411FB;
        Tue, 11 Jan 2022 07:08:16 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.36.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA3173F774;
        Tue, 11 Jan 2022 07:08:13 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com, irogers@google.com,
        ak@linux.intel.com
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH v2 0/5] topdown with metrics
Date:   Tue, 11 Jan 2022 15:07:44 +0000
Message-Id: <20220111150749.13365-1-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the ability for the --topdown option to use
metrics (defined in json files in the pmu-events directory) to describe
how to calculate and determine the output columns for topdown level 1.

For this to work, a number of metrics have to be defined for the
relevant processor with the MetricGroup name "TopDownL1".  perf will
arrange for the events defined in each metric to be collected, and each
metric will be displayed in the output, as if

  perf stat -M 'TopDownL1' --metric-only -- exampleapp

had been used.

Topdown was already implemented where certain kernel events are defined.
If these kernel events are defined, the new json metrics behaviour is
not used.  The json metrics approach is only used if the kernel events
are absent.

The last patch in the series disables the json metrics behaviour on x86.
This is because of concerns that due to SMT it's not straightforward to
express the various formulas as json for certain x86 cpus.  See

  https://lore.kernel.org/linux-perf-users/12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com/#t

Changes since v1:

Addition of code to detect whether topdown kernel events are available,
and if so use them.  Otherwise set up the json metrics.

Disable the use of json metrics on non-x86 architectures, for the reason
stated above.

 - Link to v1: 
   https://lore.kernel.org/linux-perf-users/20211214184240.24215-1-andrew.kilroy@arm.com/T/#m514a788bdc3613f057dbd5b6a339c762d37f8b85


Andrew Kilroy (5):
  perf stat: Implement --topdown with metrics
  perf stat: Topdown kernel events setup function
  perf stat: Topdown json metrics setup function
  perf stat: Detect if topdown kernel events supported
  perf stat: Ensure only topdown kernel events used on x86

 tools/perf/builtin-stat.c     | 257 +++++++++++++++++++++++++---------
 tools/perf/util/metricgroup.c |  12 ++
 tools/perf/util/metricgroup.h |   7 +
 tools/perf/util/topdown.c     |  10 ++
 tools/perf/util/topdown.h     |   1 +
 5 files changed, 223 insertions(+), 64 deletions(-)

-- 
2.17.1

