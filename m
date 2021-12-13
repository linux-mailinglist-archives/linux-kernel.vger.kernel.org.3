Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A651472336
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhLMItN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:49:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:36721 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhLMItI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639385348; x=1670921348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/fm7KgSTJUGz1Lr4zzTByLeCp7RWMbVnkSRjq2PeLQ=;
  b=QbB5gGOgqhuygEDvKwviBBw34PqZngv0ZKrXOcQ8kbJ7o+zRVQZXpI+U
   8Yd/eYr9dVvSb/W+wPtSFkccO11ePmR7SA1WQPPU9ZCTvl4cJ5PFHQOjt
   K8qQqcw6lJq4U86xVz3MK9eZAOR6xWIpvRvdiV0gzSYgBCSYFPZPCiVvn
   AOSJi3HCwfCOQ85ZV1ePgL8/eLt0eEqB5yz8KeeecKN6PHC3mq2L7nDta
   z83tvAVvfdMG2cw+bQlya740pc3NY0d2m1o1cG/9RRZJ3KRkphPrDJAmt
   H/YhkPPhDqE4T9ZjNrR/GHiin5MoO02FcWN6JVFm4RNr1pWyCAw0g20N7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="236219323"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="236219323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 00:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="463308450"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2021 00:48:31 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/2] perf inject: Fix segfault due to close without open
Date:   Mon, 13 Dec 2021 10:48:28 +0200
Message-Id: <20211213084829.114772-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213084829.114772-1-adrian.hunter@intel.com>
References: <20211213084829.114772-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed commit attempts to close inject.output even if it was never
opened e.g.

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
 0x00007eff8afeef5b in _IO_new_fclose (fp=0x0) at iofclose.c:48
 48      iofclose.c: No such file or directory.
 (gdb) bt
 #0  0x00007eff8afeef5b in _IO_new_fclose (fp=0x0) at iofclose.c:48
 #1  0x0000557fc7b74f92 in perf_data__close (data=data@entry=0x7ffcdafa6578) at util/data.c:376
 #2  0x0000557fc7a6b807 in cmd_inject (argc=<optimized out>, argv=<optimized out>) at builtin-inject.c:1085
 #3  0x0000557fc7ac4783 in run_builtin (p=0x557fc8074878 <commands+600>, argc=4, argv=0x7ffcdafb6a60) at perf.c:313
 #4  0x0000557fc7a25d5c in handle_internal_command (argv=<optimized out>, argc=<optimized out>) at perf.c:365
 #5  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:409
 #6  main (argc=4, argv=0x7ffcdafb6a60) at perf.c:539
 (gdb)

Fixes: 02e6246f5364d ("perf inject: Close inject.output on exit")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index b9d6306cc14e..af70f1c72052 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1078,7 +1078,8 @@ int cmd_inject(int argc, const char **argv)
 	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
 out_close_output:
-	perf_data__close(&inject.output);
+	if (!inject.in_place_update)
+		perf_data__close(&inject.output);
 	free(inject.itrace_synth_opts.vm_tm_corr_args);
 	return ret;
 }
-- 
2.25.1

