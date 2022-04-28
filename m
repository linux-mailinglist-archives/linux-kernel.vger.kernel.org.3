Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE8512FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiD1Jsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347716AbiD1Je0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:34:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E6E84A3D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651138272; x=1682674272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sMHuRfJYF48PxF7l1NVb3pmhTJewegKzqeZOIYUQkr0=;
  b=iNbhBY+rXzb2MiPG2ecfzsZwUIztM6eTqDb22Gix7OmNgwrAyMcjvHnB
   xeMGFO9hvPIwiaklTIK0HmHBQhHqDaKzMhvHQviyS3+Vb6hwjgfCuJ11X
   ArOj9+WlDtmiFCbaiJd90QjTuBrubbZPL2lFHdvsYiBwzNfxZW9eynHwe
   WGjRIHByWcWAJdCjfKfWTFcVd4gUNs4vBXC2ErK6D6kQUSIw/RyqHp0Vf
   VTViXkcB59Fvf1Wpju+hSGQ8TLMcl9HUX5jjR8iGN7USeDN6C2MLbW+fd
   e7UkN4VPb+BYOHsncsNK6yK9tqL2Xh/jigzYFKs7mjN+fFFauPKCII9mf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="265070704"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="265070704"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="618048297"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2022 02:31:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf intel-pt: Fix timeless decoding with perf.data directory
Date:   Thu, 28 Apr 2022 12:31:09 +0300
Message-Id: <20220428093109.274641-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT does not capture data in separate directories, so do not
use separate directory processing because it doesn't work for
timeless decoding. It also looks like it doesn't support one_mmap
handling.

Example:

  Before:

    # perf record --kcore -a -e intel_pt/tsc=0/k sleep 0.1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 1.799 MB perf.data ]
    # perf script --itrace=bep | head
    #

  After:

    # perf script --itrace=bep | head
    perf 21073 [000]              psb:  psb offs: 0                       ffffffffaa68faf4 native_write_msr+0x4 ([kernel.kallsyms])
    perf 21073 [000]              cbr:  cbr: 45 freq: 4505 MHz (161%)     ffffffffaa68faf4 native_write_msr+0x4 ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:                 0 [unknown] ([unknown]) => ffffffffaa68faf6 native_write_msr+0x6 ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:  ffffffffaa68faf8 native_write_msr+0x8 ([kernel.kallsyms]) => ffffffffaa61aab0 pt_config_start+0x60 ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:  ffffffffaa61aabd pt_config_start+0x6d ([kernel.kallsyms]) => ffffffffaa61b8ad pt_event_start+0x27d ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:  ffffffffaa61b8bb pt_event_start+0x28b ([kernel.kallsyms]) => ffffffffaa61ba60 pt_event_add+0x40 ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:  ffffffffaa61ba76 pt_event_add+0x56 ([kernel.kallsyms]) => ffffffffaa880e86 event_sched_in+0xc6 ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:  ffffffffaa880e9b event_sched_in+0xdb ([kernel.kallsyms]) => ffffffffaa880ea5 event_sched_in+0xe5 ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:  ffffffffaa880eba event_sched_in+0xfa ([kernel.kallsyms]) => ffffffffaa880f96 event_sched_in+0x1d6 ([kernel.kallsyms])
    perf 21073 [000]          1       branches:k:  ffffffffaa880fc8 event_sched_in+0x208 ([kernel.kallsyms]) => ffffffffaa880ec0 event_sched_in+0x100 ([kernel.kallsyms])

Fixes: bb6be405c4a2a5 ("perf session: Load data directory files for analysis")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 45a30040ec8d..f9a320694b85 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2576,7 +2576,7 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_data__is_pipe(session->data))
 		return __perf_session__process_pipe_events(session);
 
-	if (perf_data__is_dir(session->data))
+	if (perf_data__is_dir(session->data) && session->data->dir.nr)
 		return __perf_session__process_dir_events(session);
 
 	return __perf_session__process_events(session);
-- 
2.25.1

