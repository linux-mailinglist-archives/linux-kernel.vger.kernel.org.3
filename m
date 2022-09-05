Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6064B5ACCE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiIEHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbiIEHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:34:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F996418
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363290; x=1693899290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4w7sVKCixAxZMfOcBEaT1AchX+0X7DJUZDSMgCrdM8=;
  b=REhktMIM8duDz4Ue0lu0toUCqJyyxzDdtr/Q0zndWK8mQ5wVw+gec93m
   z3GZPaU9wIDc6slSZVyev6rehmzc/2AUdSAz3I/RlT/ByRP9fI2y1da5H
   TMxBa5VVtfj3sTgeT9yxX6YjjMVfPVq8BDpm1dkCTzsQKhVcPrV9NTBVg
   Gbu3JA1voKsYqYrbI+PVe1XPexq4sGDnQ6opmy4VNp+hOp/JmXAPXS/fm
   RhX5YmRZBV9nrg5ECO1cFTyFH/QxM/v4FhApbMLUeCuj3B9LJYc285oO6
   YJm9mxLEAGW7r+PqPx6HSdEapVGW+zJ8yBKxiwPJ3vc0Pd2tqf7SDbL/r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="296332707"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="296332707"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609595395"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:34:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/6] perf intel-pt: Support itrace option flag d+e to log on error
Date:   Mon,  5 Sep 2022 10:34:23 +0300
Message-Id: <20220905073424.3971-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905073424.3971-1-adrian.hunter@intel.com>
References: <20220905073424.3971-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V2:

	Ensure log_buf is defined before use


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
index 5f5dfc8753f3..24684edc49f7 100644
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
 
@@ -18,18 +22,33 @@
 
 #define MAX_LOG_NAME 256
 
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
@@ -74,6 +93,77 @@ static void intel_pt_print_no_data(uint64_t pos, int indent)
 	fprintf(f, " ");
 }
 
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

