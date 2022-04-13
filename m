Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31574FF263
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiDMIoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiDMInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:43:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3943BC39;
        Wed, 13 Apr 2022 01:40:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AB813D5;
        Wed, 13 Apr 2022 01:40:30 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.8.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 203933F5A1;
        Wed, 13 Apr 2022 01:40:29 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.com
Cc:     German.Gomez@arm.com, James Clark <james.clark@arm.com>,
        Luke Dare <Luke.Dare@arm.com>, Al Grant <al.grant@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: docs: Add man page entry for Arm SPE
Date:   Wed, 13 Apr 2022 09:40:21 +0100
Message-Id: <20220413084021.2556142-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
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

The SPE integration in Perf has quite a few usability quirks that
can't be found by just reading the reference manual. So document this
and at the same time add a summary of the feature that is also hard to
find elsewhere.

Co-authored-by: Luke Dare <Luke.Dare@arm.com>
Co-authored-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-arm-spe.txt | 218 ++++++++++++++++++++++
 tools/perf/Documentation/perf.txt         |   2 +-
 2 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/Documentation/perf-arm-spe.txt

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
new file mode 100644
index 000000000000..bf03222e9a68
--- /dev/null
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -0,0 +1,218 @@
+perf-arm-spe(1)
+================
+
+NAME
+----
+perf-arm-spe - Support for Arm Statistical Profiling Extension within Perf tools
+
+SYNOPSIS
+--------
+[verse]
+'perf record' -e arm_spe//
+
+DESCRIPTION
+-----------
+
+The SPE (Statistical Profiling Extension) feature provides accurate attribution of latencies and
+ events down to individual instructions. Rather than being interrupt-driven, it picks an
+instruction to sample and then captures data for it during execution. Data includes execution time
+in cycles. For loads and stores it also includes data address, cache miss events, and data origin.
+
+The sampling has 5 stages:
+
+  1. Choose an operation
+  2. Collect data about the operation
+  3. Optionally discard the record based on a filter
+  4. Write the record to memory
+  5. Interrupt when the buffer is full
+
+Choose an operation
+~~~~~~~~~~~~~~~~~~~
+
+This is chosen from a sample population, for SPE this is an IMPLEMENTATION DEFINED choice of all
+architectural instructions or all micro-ops. Sampling happens at a programmable interval. The
+architecture provides a mechanism for the SPE driver to infer the minimum interval at which it should
+sample. This minimum interval is used by the driver if no interval is specified. A pseudo-random
+perturbation is also added to the sampling interval by default.
+
+Collect data about the operation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Program counter, PMU events, timings and data addresses related to the operation are recorded.
+Sampling ensures there is only one sampled operation is in flight.
+
+Optionally discard the record based on a filter
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Based on programmable criteria, choose whether to keep the record or discard it. If the record is
+discarded then the flow stops here for this sample.
+
+Write the record to memory
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The record is appended to a memory buffer
+
+Interrupt when the buffer is full
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When the buffer fills, an interrupt is sent and the driver signals Perf to collect the records.
+Perf saves the raw data in the perf.data file.
+
+Opening the file
+----------------
+
+Up until this point no decoding of the SPE data was done by either the kernel or Perf. Only when the
+recorded file is opened with 'perf report' or 'perf script' does the decoding happen. When decoding
+the data, Perf generates "synthetic samples" as if these were generated at the time of the
+recording. These samples are the same as if normal sampling was done by Perf without using SPE,
+although they may have more attributes associated with them. For example a normal sample may have
+just the instruction pointer, but an SPE sample can have data addresses and latency attributes.
+
+Why Sampling?
+-------------
+
+ - Sampling, rather than tracing, cuts down the profiling problem to something more manageable for
+ hardware. Only one sampled operation is in flight at a time.
+
+ - Allows precise attribution data, including: Full PC of instruction, data virtual and physical
+ addresses.
+
+ - Allows correlation between an instruction and events, such as TLB and cache miss. (Data source
+ indicates which particular cache was hit, but the meaning is implementation defined because
+ different implementations can have different cache configurations.)
+
+However, SPE does not provide any call-graph information, and relies on statistical methods.
+
+Collisions
+----------
+
+When an operation is sampled while a previous sampled operation has not finished, a collision
+occurs. The new sample is dropped. Collisions affect the integrity of the data, so the sample rate
+should be set to avoid collisions.
+
+The 'sample_collision' PMU event can be used to determine the number of lost samples. Although this
+count is based on collisions _before_ filtering occurs. Therefore this can not be used as an exact
+number for samples dropped that would have made it through the filter, but can be a rough
+guide.
+
+The effect of microarchitectural sampling
+-----------------------------------------
+
+If an implementation samples micro-operations instead of instructions, the results of sampling must
+be weighted accordingly.
+
+For example, if a given instruction A is always converted into two micro-operations, A0 and A1, it
+becomes twice as likely to appear in the sample population.
+
+The coarse effect of conversions, and, if applicable, sampling of speculative operations, can be
+estimated from the 'sample_pop' and 'inst_retired' PMU events.
+
+Kernel Requirements
+-------------------
+
+The ARM_SPE_PMU config must be set to build as either a module or statically.
+
+Depending on CPU model, the kernel may need to be booted with page table isolation disabled
+(kpti=off). If KPTI needs to be disabled, this will fail with a console message "profiling buffer
+inaccessible. Try passing 'kpti=off' on the kernel command line".
+
+Capturing SPE with perf command-line tools
+------------------------------------------
+
+You can record a session with SPE samples:
+
+  perf record -e arm_spe// -- ./mybench
+
+The sample period is set from the -c option, and because the minimum interval is used by default
+it's recommended to set this to a higher value. The value is written to PMSIRR.INTERVAL.
+
+Config parameters
+~~~~~~~~~~~~~~~~~
+
+These are placed between the // in the event and comma separated. For example '-e
+arm_spe/load_filter=1,min_latency=10/'
+
+  branch_filter=1     - collect branches only (PMSFCR.B)
+  event_filter=<mask> - filter on specific events (PMSEVFR) - see bitfield description below
+  jitter=1            - use jitter to avoid resonance when sampling (PMSIRR.RND)
+  load_filter=1       - collect loads only (PMSFCR.LD)
+  min_latency=<n>     - collect only samples with this latency or higher* (PMSLATFR)
+  pa_enable=1         - collect physical address (as well as VA) of loads/stores (PMSCR.PA) - requires privilege
+  pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
+  store_filter=1      - collect stores only (PMSFCR.ST)
+  ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
+
++++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
+than only the execution latency.
+
+Only some events can be filtered on; these include:
+
+  bit 1     - instruction retired (i.e. omit speculative instructions)
+  bit 3     - L1D refill
+  bit 5     - TLB refill
+  bit 7     - mispredict
+  bit 11    - misaligned access
+
+So to sample just retired instructions:
+
+  perf record -e arm_spe/event_filter=2/ -- ./mybench
+
+or just mispredicted branches:
+
+  perf record -e arm_spe/event_filter=0x80/ -- ./mybench
+
+Viewing the data
+~~~~~~~~~~~~~~~~~
+
+By default perf report and perf script will assign samples to separate groups depending on the
+attributes/events of the SPE record. Because instructions can have multiple events associated with
+them, the samples in these groups are not necessarily unique. For example perf report shows these
+groups:
+
+  Available samples
+  0 arm_spe//
+  0 dummy:u
+  21 l1d-miss
+  897 l1d-access
+  5 llc-miss
+  7 llc-access
+  2 tlb-miss
+  1K tlb-access
+  36 branch-miss
+  0 remote-access
+  900 memory
+
+The arm_spe// and dummy:u events are implementation details and are expected to be empty.
+
+To get a full list of unique samples that are not sorted into groups, set the itrace option to
+generate 'instruction' samples. The period option is also taken into account, so set it to 1
+instruction unless you want to further downsample the already sampled SPE data:
+
+  perf report --itrace=i1i
+
+Memory access details are also stored on the samples and this can be viewed with:
+
+  perf report --mem-mode
+
+Common errors
+~~~~~~~~~~~~~
+
+ - "Cannot find PMU `arm_spe'. Missing kernel support?"
+
+   Module not built or loaded, KPTI not disabled (see above), or running on a VM
+
+ - "Arm SPE CONTEXT packets not found in the traces."
+
+   Root privilege is required to collect context packets. But these only increase the accuracy of
+   assigning PIDs to kernel samples. For userspace sampling this can be ignored.
+
+ - Excessively large perf.data file size
+
+   Increase sampling interval (see above)
+
+
+SEE ALSO
+--------
+
+linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1],
+linkperf:perf-inject[1]
diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 71ebdf8125de..ba3df49c169d 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -77,7 +77,7 @@ linkperf:perf-stat[1], linkperf:perf-top[1],
 linkperf:perf-record[1], linkperf:perf-report[1],
 linkperf:perf-list[1]
 
-linkperf:perf-annotate[1],linkperf:perf-archive[1],
+linkperf:perf-annotate[1],linkperf:perf-archive[1],linkperf:perf-arm-spe[1],
 linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
 linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
 linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
-- 
2.28.0

