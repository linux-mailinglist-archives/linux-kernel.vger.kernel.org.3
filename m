Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD165B0A46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIGQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiIGQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:40:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279BC6D9D0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662568856; x=1694104856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FYZ2qqW7MXI7DSE7csPj3l+dRW2sOZlt3CuxuppJKP8=;
  b=DcDYpBJTtJTx+I1HxZKrCkheYr2MocAVcA8oNF4516jV0v0GYxFUDUMp
   810OkIuYiQ8JHJQzfKThMiGnI3QpBD36a+MFrPdp4I/D8Lx6XLtMEgE+S
   z1AaZGRlBFVzMIQa7jdcYqojFiLNOKKuGB/hD28oBpohex0fOZUYwJzaY
   sRB95MwXYIC7p9VJxw9yND17eyk1jVyEH2Rc6TbQ8/WEyrFdWhnEj7Hcs
   vplF+NFWcY8CShPdkxyl6JU1wTUI1EUT7YK5X/8v6JYoLOEvKXE4G64XF
   iRNo+SjcvHguw7b9Fn4jLouzRmeLugVTGUbveRzoQ+I9gsHRdO86xGCXM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="279957331"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="279957331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:25:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="610377837"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.58.27])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 09:25:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf record: Fix synthesis failure warnings
Date:   Wed,  7 Sep 2022 19:24:58 +0300
Message-Id: <20220907162458.72817-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some calls to synthesis functions set err < 0 but only warn about the
failure and continue.  However they do not set err back to zero, relying
on subsequent code to do that.

That changed with the introduction of option --synth. When --synth=no
subsequent functions that set err back to zero are not called.

Fix by setting err = 0 in those cases.

Example:

 Before:

   $ perf record --no-bpf-event --synth=all -o /tmp/huh uname
   Couldn't synthesize bpf events.
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.014 MB /tmp/huh (7 samples) ]
   $ perf record --no-bpf-event --synth=no -o /tmp/huh uname
   Couldn't synthesize bpf events.

 After:

   $ perf record --no-bpf-event --synth=no -o /tmp/huh uname
   Couldn't synthesize bpf events.
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.014 MB /tmp/huh (7 samples) ]

Fixes: 41b740b6e8a9 ("perf record: Add --synth option")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bce8c941d558..7713246a393f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1974,14 +1974,18 @@ static int record__synthesize(struct record *rec, bool tail)
 
 	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
-	if (err < 0)
+	if (err < 0) {
 		pr_warning("Couldn't synthesize bpf events.\n");
+		err = 0;
+	}
 
 	if (rec->opts.synth & PERF_SYNTH_CGROUP) {
 		err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
 						     machine);
-		if (err < 0)
+		if (err < 0) {
 			pr_warning("Couldn't synthesize cgroup events.\n");
+			err = 0;
+		}
 	}
 
 	if (rec->opts.nr_threads_synthesize > 1) {
-- 
2.25.1

