Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9E5A954C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiIALBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiIALBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:01:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21011E81D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662030056; x=1693566056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtYK0BiDVziXnFNqLQQMzxTLP+0jwAiG2RMhkIE91Vo=;
  b=WQgNx6W8SBugKEbKH8mD7k2WvPL2HSOqzfhR6ouqT0tcl7ZWt6x0d65q
   Qw5sv7wvhqk8AKOF7lPRRkSwD94HPEjsRyWdO+YSMWCZOL7pAvU1ZX+SS
   TunCRA/MH6OkGvYPEUEO9J2drbVFlIzFceRSdr3BYVgM6GjLwLkBMWGHt
   8S79l7syJ3EZla+nxYgCtBumMp1BiQwToEZEKAGTYuF8EZNNG/TjDVtlv
   P5xI8j8n1BmF3k1W0GO8iyff3EE3l1KR/S6IMBNl1Me3iNdJevrm1nttD
   cwC90Tpe0DzCt4uKfor/1kP0T2LzMxLlaVD1m7fS9VnARLdWrtNJWPZxs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294424832"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="294424832"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673799696"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.13])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] perf intel-pt: Support itrace option flag d+e to log on error
Date:   Thu,  1 Sep 2022 14:00:32 +0300
Message-Id: <20220901110032.9226-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901110032.9226-1-adrian.hunter@intel.com>
References: <20220901110032.9226-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass d+e option and log size via intel_pt_log_enable(). Allocate a buffer
for log messages and provide intel_pt_log_dump_buf() to dump and reset the
buffer upon decoder errors.

Example:

 $ sudo perf record -e intel_pt// sleep 1
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.094 MB perf.data ]
 $ sudo perf config itrace.debug-log-buffer-size=300
 $ sudo perf script --itrace=ed+e+o | head -20
 Dumping debug log buffer (first line may be sliced)
                                         Other
           ffffffff96ca22f6:  48 89 e5                                        Other
           ffffffff96ca22f9:  65 48 8b 05 ff e0 38 69                         Other
           ffffffff96ca2301:  48 3d c0 a5 c1 98                               Other
           ffffffff96ca2307:  74 08                                           Jcc +8
           ffffffff96ca2311:  5d                                              Other
           ffffffff96ca2312:  c3                                              Ret
 ERROR: Bad RET compression (TNT=N) at 0xffffffff96ca2312
 End of debug log buffer dump
  instruction trace error type 1 time 15913.537143482 cpu 5 pid 36292 tid 36292 ip 0xffffffff96ca2312 code 6: Trace doesn't match instruction
 Dumping debug log buffer (first line may be sliced)
                                        Other
           ffffffff96ce7fe9:  f6 47 2e 20                                     Other
           ffffffff96ce7fed:  74 11                                           Jcc +17
           ffffffff96ce7fef:  48 8b 87 28 0a 00 00                            Other
           ffffffff96ce7ff6:  5d                                              Other
           ffffffff96ce7ff7:  48 8b 40 18                                     Other
           ffffffff96ce7ffb:  c3                                              Ret
 ERROR: Bad RET compression (TNT=N) at 0xffffffff96ce7ffb
 Warning:
 8 instruction trace errors

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt    |  5 +-
 .../perf/util/intel-pt-decoder/intel-pt-log.c | 94 ++++++++++++++++++-
 .../perf/util/intel-pt-decoder/intel-pt-log.h |  3 +-
 tools/perf/util/intel-pt.c                    | 20 +++-
 4 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index d5ddb968bcf4..92464a5d7eaf 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -989,10 +989,13 @@ must be preceded by either '+' or '-'. The flags support by Intel PT are:
 
 		-a	Suppress logging of perf events
 		+a	Log all perf events
+		+e	Output only on decoding errors (size configurable)
 		+o	Output to stdout instead of "intel_pt.log"
 
 By default, logged perf events are filtered by any specified time ranges, but
-flag +a overrides that.
+flag +a overrides that.  The +e flag can be useful for analyzing errors.  By
+default, the log size in that case is 16384 bytes, but can be altered by
+linkperf:perf-config[1] e.g. perf config itrace.debug-log-buffer-size=30000
 
 In addition, the period of the "instructions" event can be specified. e.g.
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
index 5f5dfc8753f3..ea96dcae187a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
@@ -5,12 +5,16 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <stdint.h>
 #include <inttypes.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <string.h>
 
+#include <linux/zalloc.h>
+#include <linux/kernel.h>
+
 #include "intel-pt-log.h"
 #include "intel-pt-insn-decoder.h"
 
@@ -21,15 +25,20 @@
 static FILE *f;
 static char log_name[MAX_LOG_NAME];
 bool intel_pt_enable_logging;
+static bool intel_pt_dump_log_on_error;
+static unsigned int intel_pt_log_on_error_size;
+static struct log_buf log_buf;
 
 void *intel_pt_log_fp(void)
 {
 	return f;
 }
 
-void intel_pt_log_enable(void)
+void intel_pt_log_enable(bool dump_log_on_error, unsigned int log_on_error_size)
 {
 	intel_pt_enable_logging = true;
+	intel_pt_dump_log_on_error = dump_log_on_error;
+	intel_pt_log_on_error_size = log_on_error_size;
 }
 
 void intel_pt_log_disable(void)
@@ -74,6 +83,87 @@ static void intel_pt_print_no_data(uint64_t pos, int indent)
 	fprintf(f, " ");
 }
 
+#define DFLT_BUF_SZ	(16 * 1024)
+
+struct log_buf {
+	char			*buf;
+	size_t			buf_sz;
+	size_t			head;
+	bool			wrapped;
+	FILE			*backend;
+};
+
+static ssize_t log_buf__write(void *cookie, const char *buf, size_t size)
+{
+	struct log_buf *b = cookie;
+	size_t sz = size;
+
+	if (!b->buf)
+		return size;
+
+	while (sz) {
+		size_t space = b->buf_sz - b->head;
+		size_t n = min(space, sz);
+
+		memcpy(b->buf + b->head, buf, n);
+		sz -= n;
+		buf += n;
+		b->head += n;
+		if (sz && b->head >= b->buf_sz) {
+			b->head = 0;
+			b->wrapped = true;
+		}
+	}
+	return size;
+}
+
+static int log_buf__close(void *cookie)
+{
+	struct log_buf *b = cookie;
+
+	zfree(&b->buf);
+	return 0;
+}
+
+static FILE *log_buf__open(struct log_buf *b, FILE *backend, unsigned int sz)
+{
+	cookie_io_functions_t fns = {
+		.write = log_buf__write,
+		.close = log_buf__close,
+	};
+	FILE *file;
+
+	memset(b, 0, sizeof(*b));
+	b->buf_sz = sz;
+	b->buf = malloc(b->buf_sz);
+	b->backend = backend;
+	file = fopencookie(b, "a", fns);
+	if (!file)
+		zfree(&b->buf);
+	return file;
+}
+
+static void log_buf__dump(struct log_buf *b)
+{
+	if (!b->buf)
+		return;
+
+	fflush(f);
+	fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");
+	if (b->wrapped)
+		fwrite(b->buf + b->head, b->buf_sz - b->head, 1, b->backend);
+	fwrite(b->buf, b->head, 1, b->backend);
+	fprintf(b->backend, "End of debug log buffer dump\n");
+
+	b->head = 0;
+	b->wrapped = false;
+}
+
+void intel_pt_log_dump_buf(void)
+{
+	log_buf__dump(&log_buf);
+}
+
 static int intel_pt_log_open(void)
 {
 	if (!intel_pt_enable_logging)
@@ -86,6 +176,8 @@ static int intel_pt_log_open(void)
 		f = fopen(log_name, "w+");
 	else
 		f = stdout;
+	if (f && intel_pt_dump_log_on_error)
+		f = log_buf__open(&log_buf, f, intel_pt_log_on_error_size);
 	if (!f) {
 		intel_pt_enable_logging = false;
 		return -1;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.h b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
index d900aab24b21..354d7d23fc81 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
@@ -14,9 +14,10 @@
 struct intel_pt_pkt;
 
 void *intel_pt_log_fp(void);
-void intel_pt_log_enable(void);
+void intel_pt_log_enable(bool dump_log_on_error, unsigned int log_on_error_size);
 void intel_pt_log_disable(void);
 void intel_pt_log_set_name(const char *name);
+void intel_pt_log_dump_buf(void);
 
 void __intel_pt_log_packet(const struct intel_pt_pkt *packet, int pkt_len,
 			   uint64_t pos, const unsigned char *buf);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index c01ff8001501..b34cb3dec1aa 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2419,6 +2419,8 @@ static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 				pid_t pid, pid_t tid, u64 ip, u64 timestamp,
 				pid_t machine_pid, int vcpu)
 {
+	bool dump_log_on_error = pt->synth_opts.log_plus_flags & AUXTRACE_LOG_FLG_ON_ERROR;
+	bool log_on_stdout = pt->synth_opts.log_plus_flags & AUXTRACE_LOG_FLG_USE_STDOUT;
 	union perf_event event;
 	char msg[MAX_AUXTRACE_ERROR_MSG];
 	int err;
@@ -2438,6 +2440,16 @@ static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 				   code, cpu, pid, tid, ip, msg, timestamp,
 				   machine_pid, vcpu);
 
+	if (intel_pt_enable_logging && !log_on_stdout) {
+		FILE *fp = intel_pt_log_fp();
+
+		if (fp)
+			perf_event__fprintf_auxtrace_error(&event, fp);
+	}
+
+	if (code != INTEL_PT_ERR_LOST && dump_log_on_error)
+		intel_pt_log_dump_buf();
+
 	err = perf_session__deliver_synth_event(pt->session, &event, NULL);
 	if (err)
 		pr_err("Intel Processor Trace: failed to deliver error event, error %d\n",
@@ -4272,8 +4284,12 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 	}
 
-	if (pt->synth_opts.log)
-		intel_pt_log_enable();
+	if (pt->synth_opts.log) {
+		bool log_on_error = pt->synth_opts.log_plus_flags & AUXTRACE_LOG_FLG_ON_ERROR;
+		unsigned int log_on_error_size = pt->synth_opts.log_on_error_size;
+
+		intel_pt_log_enable(log_on_error, log_on_error_size);
+	}
 
 	/* Maximum non-turbo ratio is TSC freq / 100 MHz */
 	if (pt->tc.time_mult) {
-- 
2.25.1

