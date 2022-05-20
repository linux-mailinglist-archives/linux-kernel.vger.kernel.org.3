Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7842F52ED0B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349816AbiETNYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiETNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:24:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824914A246
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653053064; x=1684589064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNKd/tsQRuan+vrDqCBtTMp3Z8UUt6bCZo0Wdm3XR2M=;
  b=D0kInXMiyn76FUHBwa+nPx95h+tZShTjkvxVrfM2GQiAontk0uqKSA45
   TXij0rtqDvK7gTGHUbpIQVlzmzlmwM34XNYmW0XyOdvRifaxTxQihGEPm
   y3+ARCJf8u4fZ0Phr1dj0gzaj/YOdbIoq/0epKs6fNg0OXhfnKEd6JBla
   ALRCRyAW4wV/fYpxcR0jqJS0zQshN+uQBonmmBcKThFHcIHLl/FAvfogs
   vRYTwMV7v4gHSymc74cG/FtLZYKTPtzci7fiOASvAsHRyGefNz7cz75m3
   J/uQgq12FWNf61u3w2C0JP95aJXBhNZYa2ZwrmeN7d9G4SlBig95v/Bcq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335661021"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335661021"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="715530816"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.38.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:24:22 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] perf inject: Keep some features sections from input file
Date:   Fri, 20 May 2022 16:24:02 +0300
Message-Id: <20220520132404.25853-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520132404.25853-1-adrian.hunter@intel.com>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf inject overwrites feature sections with information from the current
machine. It makes more sense to keep original information that describes
the machine or software when perf record was run.

Example: perf.data from "Desktop" injected on "nuc11"

 Before:

  $ perf script --header-only -i perf.data-from-desktop | head -15
  # ========
  # captured on    : Thu May 19 09:55:50 2022
  # header version : 1
  # data offset    : 1208
  # data size      : 837480
  # feat offset    : 838688
  # hostname : Desktop
  # os release : 5.13.0-41-generic
  # perf version : 5.18.rc5.gac837f7ca7ed
  # arch : x86_64
  # nrcpus online : 28
  # nrcpus avail : 28
  # cpudesc : Intel(R) Core(TM) i9-9940X CPU @ 3.30GHz
  # cpuid : GenuineIntel,6,85,4
  # total memory : 65548656 kB

  $ perf inject -i perf.data-from-desktop -o injected-perf.data

  $ perf script --header-only -i injected-perf.data | head -15
  # ========
  # captured on    : Fri May 20 15:06:55 2022
  # header version : 1
  # data offset    : 1208
  # data size      : 837480
  # feat offset    : 838688
  # hostname : nuc11
  # os release : 5.17.5-local
  # perf version : 5.18.rc5.g0f828fdeb9af
  # arch : x86_64
  # nrcpus online : 8
  # nrcpus avail : 8
  # cpudesc : 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
  # cpuid : GenuineIntel,6,140,1
  # total memory : 16012124 kB

 After:

  $ perf inject -i perf.data-from-desktop -o injected-perf.data

  $ perf script --header-only -i injected-perf.data | head -15
  # ========
  # captured on    : Fri May 20 15:08:54 2022
  # header version : 1
  # data offset    : 1208
  # data size      : 837480
  # feat offset    : 838688
  # hostname : Desktop
  # os release : 5.13.0-41-generic
  # perf version : 5.18.rc5.gac837f7ca7ed
  # arch : x86_64
  # nrcpus online : 28
  # nrcpus avail : 28
  # cpudesc : Intel(R) Core(TM) i9-9940X CPU @ 3.30GHz
  # cpuid : GenuineIntel,6,85,4
  # total memory : 65548656 kB

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 129 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.c    |   8 +++
 tools/perf/util/header.h    |   5 ++
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5b50a4abf95f..71b6eafe4c19 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -27,6 +27,8 @@
 #include "util/namespaces.h"
 #include "util/util.h"
 
+#include <internal/lib.h>
+
 #include <linux/err.h>
 #include <subcmd/parse-options.h>
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
@@ -55,6 +57,7 @@ struct perf_inject {
 	struct list_head	samples;
 	struct itrace_synth_opts itrace_synth_opts;
 	char			event_copy[PERF_SAMPLE_MAX_SIZE];
+	struct perf_file_section secs[HEADER_FEAT_BITS];
 };
 
 struct event_entry {
@@ -763,6 +766,120 @@ static int parse_vm_time_correlation(const struct option *opt, const char *str,
 	return inject->itrace_synth_opts.vm_tm_corr_args ? 0 : -ENOMEM;
 }
 
+static int save_section_info_cb(struct perf_file_section *section,
+				struct perf_header *ph __maybe_unused,
+				int feat, int fd __maybe_unused, void *data)
+{
+	struct perf_inject *inject = data;
+
+	inject->secs[feat] = *section;
+	return 0;
+}
+
+static int save_section_info(struct perf_inject *inject)
+{
+	struct perf_header *header = &inject->session->header;
+	int fd = perf_data__fd(inject->session->data);
+
+	return perf_header__process_sections(header, fd, inject, save_section_info_cb);
+}
+
+static bool keep_feat(int feat)
+{
+	switch (feat) {
+	/* Keep original information that describes the machine or software */
+	case HEADER_TRACING_DATA:
+	case HEADER_HOSTNAME:
+	case HEADER_OSRELEASE:
+	case HEADER_VERSION:
+	case HEADER_ARCH:
+	case HEADER_NRCPUS:
+	case HEADER_CPUDESC:
+	case HEADER_CPUID:
+	case HEADER_TOTAL_MEM:
+	case HEADER_CPU_TOPOLOGY:
+	case HEADER_NUMA_TOPOLOGY:
+	case HEADER_PMU_MAPPINGS:
+	case HEADER_CACHE:
+	case HEADER_MEM_TOPOLOGY:
+	case HEADER_CLOCKID:
+	case HEADER_BPF_PROG_INFO:
+	case HEADER_BPF_BTF:
+	case HEADER_CPU_PMU_CAPS:
+	case HEADER_CLOCK_DATA:
+	case HEADER_HYBRID_TOPOLOGY:
+	case HEADER_HYBRID_CPU_PMU_CAPS:
+		return true;
+	/* Information that can be updated */
+	case HEADER_BUILD_ID:
+	case HEADER_CMDLINE:
+	case HEADER_EVENT_DESC:
+	case HEADER_BRANCH_STACK:
+	case HEADER_GROUP_DESC:
+	case HEADER_AUXTRACE:
+	case HEADER_STAT:
+	case HEADER_SAMPLE_TIME:
+	case HEADER_DIR_FORMAT:
+	case HEADER_COMPRESSED:
+	default:
+		return false;
+	};
+}
+
+static int read_file(int fd, u64 offs, void *buf, size_t sz)
+{
+	ssize_t ret = preadn(fd, buf, sz, offs);
+
+	if (ret < 0)
+		return -errno;
+	if ((size_t)ret != sz)
+		return -EINVAL;
+	return 0;
+}
+
+static int feat_copy(struct perf_inject *inject, int feat, struct feat_writer *fw)
+{
+	int fd = perf_data__fd(inject->session->data);
+	u64 offs = inject->secs[feat].offset;
+	size_t sz = inject->secs[feat].size;
+	void *buf = malloc(sz);
+	int ret;
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = read_file(fd, offs, buf, sz);
+	if (ret)
+		goto out_free;
+
+	ret = fw->write(fw, buf, sz);
+out_free:
+	free(buf);
+	return ret;
+}
+
+struct inject_fc {
+	struct feat_copier fc;
+	struct perf_inject *inject;
+};
+
+static int feat_copy_cb(struct feat_copier *fc, int feat, struct feat_writer *fw)
+{
+	struct inject_fc *inj_fc = container_of(fc, struct inject_fc, fc);
+	struct perf_inject *inject = inj_fc->inject;
+	int ret;
+
+	if (!inject->secs[feat].offset ||
+	    !keep_feat(feat))
+		return 0;
+
+	ret = feat_copy(inject, feat, fw);
+	if (ret < 0)
+		return ret;
+
+	return 1; /* Feature section copied */
+}
+
 static int output_fd(struct perf_inject *inject)
 {
 	return inject->in_place_update ? -1 : perf_data__fd(&inject->output);
@@ -848,6 +965,11 @@ static int __cmd_inject(struct perf_inject *inject)
 		return ret;
 
 	if (!inject->is_pipe && !inject->in_place_update) {
+		struct inject_fc inj_fc = {
+			.fc.copy = feat_copy_cb,
+			.inject = inject,
+		};
+
 		if (inject->build_ids)
 			perf_header__set_feat(&session->header,
 					      HEADER_BUILD_ID);
@@ -872,7 +994,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
-		perf_session__write_header(session, session->evlist, fd, true);
+		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc);
 	}
 
 	return ret;
@@ -1037,6 +1159,11 @@ int cmd_inject(int argc, const char **argv)
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
+	/* Save original section info before feature bits change */
+	ret = save_section_info(&inject);
+	if (ret)
+		goto out_delete;
+
 	if (!data.is_pipe && inject.output.is_pipe) {
 		ret = perf_header__write_pipe(perf_data__fd(&inject.output));
 		if (ret < 0) {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b0c57a130d1e..53332da100e8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3686,6 +3686,14 @@ int perf_session__write_header(struct perf_session *session,
 	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
 }
 
+int perf_session__inject_header(struct perf_session *session,
+				struct evlist *evlist,
+				int fd,
+				struct feat_copier *fc)
+{
+	return perf_session__do_write_header(session, evlist, fd, true, fc);
+}
+
 static int perf_header__getbuffer64(struct perf_header *header,
 				    int fd, void *buf, size_t size)
 {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index e76ab02d5541..08563c1f1bff 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -131,6 +131,11 @@ struct feat_copier {
 	int (*copy)(struct feat_copier *fc, int feat, struct feat_writer *fw);
 };
 
+int perf_session__inject_header(struct perf_session *session,
+				struct evlist *evlist,
+				int fd,
+				struct feat_copier *fc);
+
 void perf_header__set_feat(struct perf_header *header, int feat);
 void perf_header__clear_feat(struct perf_header *header, int feat);
 bool perf_header__has_feat(const struct perf_header *header, int feat);
-- 
2.25.1

