Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A714B491052
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbiAQSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:34:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:48606 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242623AbiAQSek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444480; x=1673980480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ANBupqvTqW8pdSkf1KOtoBqLuYb19uCmA+6nP/0uFTw=;
  b=D2zaIxFaLkmnaQbguBCwKLQcmnMumiqn1CQ2JGWegTIuQnRXY3uFybOk
   vJ8PIPmQqijyi3vUeQf0ED2TDbeZx7JDFyX3HZ5WGjEvWtKTqO1iplGQM
   4R7f9cjbmHpWCbdhmIln7XyW9nLAtCytNhKQgaSpBy9lGuiKXEzXjMnCd
   YQNX6TjFROhDQsq+4otQ/QGYjE7CLfaFhfqagosfo7an+7hFAMC3XtIEJ
   I3uu8KEYcVfry+eCqPvRkvr+W2nwdqL3/+cBiZMpPjVMyCsD4gtKKLPJW
   T6YBQkYfV9M41JyF7XAYuEaOsltZj8oHOCgNRTy7kkmJgA5TgJwtudV3z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224655962"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224655962"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:34:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434176"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:34:36 -0800
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v13 00/16] Introduce threaded trace streaming for basic perf record operation
Date:   Mon, 17 Jan 2022 21:34:20 +0300
Message-Id: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v13:
- fixed error handling in record__mmap_cpu_mask_alloc()
- removed redundant record__thread_mask_clear()
- added notes about evlist__ctlfd_update() to [v13 05/16]
- fixed build on systems w/o pthread_attr_setaffinity_np() and syscall.h
- fixed samples zeroing before process_buildids()
- added notes about valid parallel masks to the documentation and sources
- fixed masks releasing in record__init_thread_cpu_masks
- added and fixed some error messages

v12: https://lore.kernel.org/lkml/cover.1637675515.git.alexey.v.bayduraev@linux.intel.com/

Changes in v12:
- fixed nr_threads=1 cases
- fixed "Woken up %ld times" message
- removed unnecessary record__fini_thread_masks function
- moved bytes written/compressed statistics to struct record_thread
- moved all unnecessary debug messages to verbose=2 level
- renamed "socket" option to "package" for consistency with util/cputopo.h
- excluded single trace file reading patches

v11: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/

Changes in v11:
- removed python dependency on zstd (perf test 19)
- captured tags from Riccardo Mancini 

v10: https://lore.kernel.org/lkml/cover.1626072008.git.alexey.v.bayduraev@linux.intel.com/

Changes in v10:
- renamed fdarray__clone to fdarray__dup_entry_from
- captured Acked-by: tags by Namhyung Kim for 09/24

v9: https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/

Changes in v9:
- fixes in [v9 01/24]:
  - move 'nr_threads' to before 'thread_masks'
  - combined decl+assign into one line in record__thread_mask_alloc
  - releasing masks inplace in record__alloc_thread_masks
- split patch [v8 02/22] to [v9 02/24] and [v9 03/24]
- fixes in [v9 03/24]:
  - renamed 'struct thread_data' to 'struct record_thread'
  - moved nr_mmaps after ctlfd_pos
  - releasing resources inplace in record__thread_data_init_maps
  - initializing pipes by -1 value
  - added temporary gettid() wrapper
- split patch [v8 03/22] to [v9 04/24] and [v9 05/24] 
- removed upstreamed [v8 09/22]
- split [v8 10/22] to [v9 12/24] and [v9 13/24]
- moved --threads documentation to the related patches
- fixed output of written/compressed stats in [v9 10/24]
- split patch [v8 12/22] to [v9 15/24] and [v9 16/24]
- fixed order of error checking for decompressed events in [v9 16/24]
- merged patch [v8 21/22] with [v9 23/24] and [v9 24/24]
- moved patch [v8 22/22] to [v9 09/24]
- added max reader size constant in [v9 24/24]

v8: https://lore.kernel.org/lkml/cover.1625065643.git.alexey.v.bayduraev@linux.intel.com/

Changes in v8:
- captured Acked-by: tags by Namhyung Kim
- merged with origin/perf/core
- added patch 21/22 introducing READER_NODATA state
- added patch 22/22 fixing --max-size option

v7: https://lore.kernel.org/lkml/cover.1624350588.git.alexey.v.bayduraev@linux.intel.com/

Changes in v7:
- fixed possible crash after out_free_threads label
- added missing pthread_attr_destroy() call
- added check of correctness of user masks 
- fixed zsts_data finalization

v6: https://lore.kernel.org/lkml/cover.1622025774.git.alexey.v.bayduraev@linux.intel.com/

Changes in v6:
- fixed leaks and possible double free in record__thread_mask_alloc()
- fixed leaks in record__init_thread_user_masks()
- fixed final mmaps flushing for threads id > 0
- merged with origin/perf/core

v5: https://lore.kernel.org/lkml/cover.1619781188.git.alexey.v.bayduraev@linux.intel.com/

Changes in v5:
- fixed leaks in record__init_thread_masks_spec()
- fixed leaks after failed realloc
- replaced "%m" to strerror()
- added masks examples to the documentation
- captured Acked-by: tags by Andi Kleen
- do not allow --thread option for full_auxtrace mode 
- split patch 06/12 to 06/20 and 07/20
- split patch 08/12 to 09/20 and 10/20
- split patches 11/12 and 11/12 to 13/20-20/20

v4: https://lore.kernel.org/lkml/6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com/

Changes in v4:
- renamed 'comm' structure to 'pipes'
- moved thread fd/maps messages to verbose=2
- fixed leaks during allocation of thread_data structures
- fixed leaks during allocation of thread masks
- fixed possible fails when releasing thread masks

v3: https://lore.kernel.org/lkml/7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com/

Changes in v3:
- avoided skipped redundant patch 3/15
- applied "data file" and "data directory" terms allover the patch set
- captured Acked-by: tags by Namhyung Kim
- avoided braces where don't needed
- employed thread local variable for serial trace streaming 
- added specs for --thread option - core, socket, numa and user defined
- added parallel loading of data directory files similar to the prototype [1]

v2: https://lore.kernel.org/lkml/1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com/

Changes in v2:
- explicitly added credit tags to patches 6/15 and 15/15,
  additionally to cites [1], [2]
- updated description of 3/15 to explicitly mention the reason
  to open data directories in read access mode (e.g. for perf report)
- implemented fix for compilation error of 2/15
- explicitly elaborated on found issues to be resolved for
  threaded AUX trace capture

v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/

Patch set provides parallel threaded trace streaming mode for basic
perf record operation. Provided mode mitigates profiling data losses
and resolves scalability issues of serial and asynchronous (--aio)
trace streaming modes on multicore server systems. The design and
implementation are based on the prototype [1], [2].

Parallel threaded mode executes trace streaming threads that read kernel
data buffers and write captured data into several data files located at
data directory. Layout of trace streaming threads and their mapping to data
buffers to read can be configured using a value of --thread command line
option. Specification value provides masks separated by colon so the masks
define CPUs to be monitored by one thread and thread affinity mask is
separated by slash. <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
specifies parallel threads layout that consists of two threads with
corresponding assigned CPUs to be monitored. Specification value can be
a string e.g. "cpu", "core" or "socket" meaning creation of data streaming
thread for monitoring every CPU, whole core or socket. The option provided
with no or empty value defaults to "cpu" layout creating data streaming
thread for every CPU being monitored. Specification masks are filtered
by the mask provided via -C option.

Parallel streaming mode is compatible with Zstd compression/decompression
(--compression-level) and external control commands (--control). The mode
is not enabled for pipe mode. The mode is not enabled for AUX area tracing,
related and derived modes like --snapshot or --aux-sample. --switch-output-*
and --timestamp-filename options are not enabled for parallel streaming.
Initial intent to enable AUX area tracing faced the need to define some
optimal way to store index data in data directory. --switch-output-* and
--timestamp-filename use cases are not clear for data directories.
Asynchronous(--aio) trace streaming and affinity (--affinity) modes are
mutually exclusive to parallel streaming mode.

Basic analysis of data directories is provided in perf report mode.
Raw dump and aggregated reports are available for data directories,
still with no memory consumption optimizations.

Tested:

tools/perf/perf record -o prof.data --threads -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads= -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=cpu -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=core -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=socket -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=numa -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 2,5 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 3,4 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=core -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=numa -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 --compression-level=3 -- matrix.gcc.g.O3
tools/perf/perf record -o prof.data --threads -a
tools/perf/perf record -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
tools/perf/perf record --threads -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30

tools/perf/perf report -i prof.data
tools/perf/perf report -i prof.data --call-graph=callee
tools/perf/perf report -i prof.data --stdio --header
tools/perf/perf report -i prof.data -D --header

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Alexey Bayduraev (16):
  perf record: Introduce thread affinity and mmap masks
  tools lib: Introduce fdarray duplicate function
  perf record: Introduce thread specific data array
  perf record: Introduce function to propagate control commands
  perf record: Introduce thread local variable
  perf record: Stop threads in the end of trace streaming
  perf record: Start threads in the beginning of trace streaming
  perf record: Introduce data file at mmap buffer object
  perf record: Introduce bytes written stats
  perf record: Introduce compressor at mmap buffer object
  perf record: Introduce data transferred and compressed stats
  perf record: Introduce --threads command line option
  perf record: Extend --threads command line option
  perf record: Implement compatibility checks
  perf session: Load data directory files for analysis
  perf report: Output data file name in raw trace dump

 tools/lib/api/fd/array.c                 |   17 +
 tools/lib/api/fd/array.h                 |    1 +
 tools/perf/Documentation/perf-record.txt |   34 +
 tools/perf/builtin-inject.c              |    3 +-
 tools/perf/builtin-kvm.c                 |    2 +-
 tools/perf/builtin-record.c              | 1164 ++++++++++++++++++++--
 tools/perf/builtin-top.c                 |    2 +-
 tools/perf/builtin-trace.c               |    2 +-
 tools/perf/util/evlist.c                 |   16 +
 tools/perf/util/evlist.h                 |    1 +
 tools/perf/util/mmap.c                   |   10 +
 tools/perf/util/mmap.h                   |    3 +
 tools/perf/util/ordered-events.c         |    3 +-
 tools/perf/util/ordered-events.h         |    3 +-
 tools/perf/util/record.h                 |    2 +
 tools/perf/util/session.c                |  208 +++-
 tools/perf/util/session.h                |    3 +-
 tools/perf/util/tool.h                   |    3 +-
 18 files changed, 1373 insertions(+), 104 deletions(-)

-- 
2.19.0

