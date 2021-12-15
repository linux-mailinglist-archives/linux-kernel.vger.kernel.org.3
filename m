Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0BF475930
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbhLOMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:55:27 -0500
Received: from foss.arm.com ([217.140.110.172]:51274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242692AbhLOMzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:55:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF472D6E;
        Wed, 15 Dec 2021 04:55:08 -0800 (PST)
Received: from e126387.extremechicken.org (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48B23F774;
        Wed, 15 Dec 2021 04:55:07 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: [PATCH 12/12] perf test: Add docs for coresight and related tests
Date:   Wed, 15 Dec 2021 12:54:09 +0000
Message-Id: <20211215125409.61488-12-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
References: <20211215125409.61488-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This adds documentation about the coresight specific tests as part of
perf test

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 MAINTAINERS                                |   1 +
 tools/perf/Documentation/arm-coresight.txt | 140 +++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 tools/perf/Documentation/arm-coresight.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index c2d7db515c70..a6e31d32f1ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1789,6 +1789,7 @@ F:	Documentation/trace/coresight/*
 F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
 F:	include/linux/coresight*
+F:	tools/perf/Documentation/arm-coresight.txt
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
new file mode 100644
index 000000000000..3a9e6c573c58
--- /dev/null
+++ b/tools/perf/Documentation/arm-coresight.txt
@@ -0,0 +1,140 @@
+Arm Coresight Support
+=====================
+
+Coresight is a feature of some Arm based processors that allows for
+debugging. One of the things it can do is trace every instruction
+executed and remotely expose that information in a hardware compressed
+stream. Perf is able to locally access that stream and store it to the
+output perf data files. This stream can then be later decoded to give the
+instructions that were traced for debugging or profiling purposes. You
+can log such data with a perf record command like:
+
+    perf record -e cs_etm//u testbinary
+
+This would run some test binary (testbinary) until it exits and record
+a perf.data trace file. That file would have AUX sections if coresight
+is working correctly. You can dump the content of this file as
+readable text with a command like:
+
+    perf report --stdio --dump -i perf.data
+
+You should find some sections of this file have AUX data blocks like:
+
+    0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
+
+    . ... CoreSight ETM Trace data: size 73168 bytes
+            Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
+              Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
+              Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
+              Idx:26; ID:10;  I_TRACE_ON : Trace On.
+              Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
+              Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
+              Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
+              Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
+              Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
+              ...
+
+If you see these above, then your system is tracing coresight data
+correctly.
+
+To compile perf with coresight support in the perf directory do
+
+    make CORESIGHT=1
+
+This will compile the perf tool with coresight support as well as
+build some small test binaries for perf test. This requires you also
+be compiling for 64bit Arm (ARM64/aarch64). The tools run as part of
+perf coresight tracing are in tests/shell/tools/coresight.
+
+You will also want coresight support enabled in your kernel config.
+Ensure it is enabled with:
+
+    CONFIG_CORESIGHT=y
+
+There are various other coresight options you probably also want
+enabled like:
+
+    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
+    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
+    CONFIG_CORESIGHT_CATU=y
+    CONFIG_CORESIGHT_SINK_TPIU=y
+    CONFIG_CORESIGHT_SINK_ETBV10=y
+    CONFIG_CORESIGHT_SOURCE_ETM4X=y
+    CONFIG_CORESIGHT_STM=y
+    CONFIG_CORESIGHT_CPU_DEBUG=y
+    CONFIG_CORESIGHT_CTI=y
+    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
+
+Please refer to the kernel configuration help for more information.
+
+Perf test - Verify kernel and userspace perf coresight work
+===========================================================
+
+When you run perf test, it will do a lot of self tests. Some of those
+tests will cover Coresight (only if enabled and on ARM64). You
+generally would run perf test from the tools/perf directory in the
+kernel tree. Some tests will check some internal perf support like:
+
+    Check Arm CoreSight trace data recording and synthesized samples
+
+Some others will actually use perf record and some test binaries that
+are in tests/shell/tools/coresight and will collect traces to ensure a
+minimum level of functionality is met. The scripts that launch these
+tests are in tests/shell. These will all look like:
+
+    Coresight / Memcpy 1M 25 Threads
+    Coresight / Unroll Loop Thread 2
+    ...
+
+These perf record tests will not run if the tool binaries do not exist
+in tests/shell/tools/coresight/*/ and will be skipped. If you do not
+have coresight support in hardware then either do not build perf with
+coresight support or remove these binaries in order to not have these
+tests fail and have them skip instead.
+
+These tests will log historical results in the current working
+directory (e.g. tools/perf) and will be named stats-*.csv like:
+
+    stats-asm_pure_loop-out.csv
+    stats-bubble_sort-random.csv
+    ...
+
+These statistic files log some aspects of the AUX data sections in
+the perf data output counting some numbers of certain encodings (a
+good way to know that it's working in a very simple way). One problem
+with coresight is that given a large enough amount of data needing to
+be logged, some of it can be lost due to the processor not waking up
+in time to read out all the data from buffers etc.. You will notice
+that the amount of data collected can vary a lot per run of perf test.
+If you wish to see how this changes over time, simply run perf test
+multiple times and all these csv files will have more and more data
+appended to it that you can later examine, graph and otherwise use to
+figure out if things have become worse or better.
+
+Be aware that amny of these tests take quite a while to run, specifically
+in processing the perf data file and dumping contents to then examine what
+is inside.
+
+You can change where these csv logs are stored by setting the
+PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
+test like:
+
+    export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
+    perf test
+
+They will also store resulting perf output data in the current
+directory for later inspection like:
+
+    perf-memcpy-1m.data
+    perf-thread_loop-2th.data
+    ...
+
+You can alter where the perf data files are stored by setting the
+PERF_TEST_CORESIGHT_DATADIR environment variable such as:
+
+    PERF_TEST_CORESIGHT_DATADIR=/var/tmp
+    perf test
+
+You may wish to set these above environment variables if you which to
+keep the output of tests outside of the current working directory for
+longer term storage and examination.
-- 
2.32.0

