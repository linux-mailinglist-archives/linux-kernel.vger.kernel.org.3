Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E9472337
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhLMItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:49:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:36716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhLMItJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639385349; x=1670921349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uJvR+3wocgh7K/KUHw/FTDR4R4hadXS2KZeGyNEP4sE=;
  b=BD9EwaR0obhKEe7ByuxRWwMzY3YsAOJWwfIHjgNfW2LBAmMhR/59LOvC
   Wa915YbS6Ratm4XE13G7vdBOcGTBa+OwoToiAfurwlIytcp1zCUY2nEO+
   i4/KlE1XruCWfSv5oJJZtJbFwDn+ZyUHj3CSLNCKKfWvgE6mIvKcDfZgS
   TGxe2CMOV+9zRxVqRdxODrj1EBOXQfjfZebqi93EoX5koCuQOZfsdiTWG
   JrETFWPoEVqvK7v0hwgBG3WTz8xkE4hWyepGvJo87xG4K7FI6MSczkqcg
   Horpa7anevLqETdDBw0tETeq5xDdEXcHuEkYK7HdII+xv5+gM/aUP55ck
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="236219335"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="236219335"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 00:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="463308454"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2021 00:48:33 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/2] perf inject: Fix segfault due to perf_data__fd() without open
Date:   Mon, 13 Dec 2021 10:48:29 +0200
Message-Id: <20211213084829.114772-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213084829.114772-1-adrian.hunter@intel.com>
References: <20211213084829.114772-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed commit attempts to get the output file descriptor even if the
file was never opened e.g.

 $ perf record uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.002 MB perf.data (7 samples) ]
 $ perf inject -i perf.data --vm-time-correlation=dry-run
 Segmentation fault (core dumped)
 $ gdb --quiet perf
 Reading symbols from perf...
 (gdb) r inject -i perf.data --vm-time-correlation=dry-run
 Starting program: /home/ahunter/bin/perf inject -i perf.data --vm-time-correlation=dry-run
 [Thread debugging using libthread_db enabled]
 Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

 Program received signal SIGSEGV, Segmentation fault.
 __GI___fileno (fp=0x0) at fileno.c:35
 35      fileno.c: No such file or directory.
 (gdb) bt
 #0  __GI___fileno (fp=0x0) at fileno.c:35
 #1  0x00005621e48dd987 in perf_data__fd (data=0x7fff4c68bd08) at util/data.h:72
 #2  perf_data__fd (data=0x7fff4c68bd08) at util/data.h:69
 #3  cmd_inject (argc=<optimized out>, argv=0x7fff4c69c1f0) at builtin-inject.c:1017
 #4  0x00005621e4936783 in run_builtin (p=0x5621e4ee6878 <commands+600>, argc=4, argv=0x7fff4c69c1f0) at perf.c:313
 #5  0x00005621e4897d5c in handle_internal_command (argv=<optimized out>, argc=<optimized out>) at perf.c:365
 #6  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:409
 #7  main (argc=4, argv=0x7fff4c69c1f0) at perf.c:539
 (gdb)

Fixes: 0ae03893623d ("perf tools: Pass a fd to perf_file_header__read_pipe()")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index af70f1c72052..409b721666cb 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -755,12 +755,16 @@ static int parse_vm_time_correlation(const struct option *opt, const char *str,
 	return inject->itrace_synth_opts.vm_tm_corr_args ? 0 : -ENOMEM;
 }
 
+static int output_fd(struct perf_inject *inject)
+{
+	return inject->in_place_update ? -1 : perf_data__fd(&inject->output);
+}
+
 static int __cmd_inject(struct perf_inject *inject)
 {
 	int ret = -EINVAL;
 	struct perf_session *session = inject->session;
-	struct perf_data *data_out = &inject->output;
-	int fd = inject->in_place_update ? -1 : perf_data__fd(data_out);
+	int fd = output_fd(inject);
 	u64 output_data_offset;
 
 	signal(SIGINT, sig_handler);
@@ -1015,7 +1019,7 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	inject.session = __perf_session__new(&data, repipe,
-					     perf_data__fd(&inject.output),
+					     output_fd(&inject),
 					     &inject.tool);
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
-- 
2.25.1

