Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB358B255
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiHEWG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiHEWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:06:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AE9012633;
        Fri,  5 Aug 2022 15:06:50 -0700 (PDT)
Received: from BRIANROB-L1.corp.microsoft.com (unknown [167.220.2.188])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B69921004C2;
        Fri,  5 Aug 2022 15:06:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B69921004C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659737209;
        bh=/bvKYXvcNa1VqgjhFy5rDeM3s0yxjUJLpsBciRViLEA=;
        h=From:To:Cc:Subject:Date:From;
        b=puKQIFxtxDE07SIARfngERKQFwY75FFLc5eWTRGMke2ZeRd+HHE9jkMAROCIg7bUR
         wI/Gu9DX3IG/7luLlfvk4pGBEMb5qQ3MqJOHoMx3zj7fgh4INl88r+bF//0uRKDL5B
         86ib6QS0i1xaTt9cy3QJ1mVqlcs/YQT90xbUKtsA=
From:   Brian Robbins <brianrob@linux.microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf inject jit: Ignore memfd and anonymous mmap events if jitdump present
Date:   Fri,  5 Aug 2022 15:06:45 -0700
Message-Id: <20220805220645.95855-1-brianrob@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processes store jitted code in memfd mappings to avoid having rwx
mappings.  These processes map the code with a writeable mapping and a
read-execute mapping.  They write the code using the writeable mapping
and then unmap the writeable mapping.  All subsequent execution is
through the read-execute mapping.

perf inject --jit ignores //anon* mappings for each process where a
jitdump is present because it expects to inject mmap events for each
jitted code range, and said jitted code ranges will overlap with the
//anon* mappings.

Ignore /memfd: and [anon:* mappings so that jitted code contained in
/memfd: and [anon:* mappings is treated the same way as jitted code
contained in //anon* mappings.

Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>
---
 tools/perf/util/jitdump.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index a23255773c60..4e6632203704 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -845,8 +845,13 @@ jit_process(struct perf_session *session,
 	if (jit_detect(filename, pid, nsi)) {
 		nsinfo__put(nsi);
 
-		// Strip //anon* mmaps if we processed a jitdump for this pid
-		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
+		/*
+		 * Strip //anon*, [anon:* and /memfd:* mmaps if we processed a jitdump for this pid
+		 */
+		if (jit_has_pid(machine, pid) &&
+			((strncmp(filename, "//anon", 6) == 0) ||
+			 (strncmp(filename, "[anon:", 6) == 0) ||
+			 (strncmp(filename, "/memfd:", 7) == 0)))
 			return 1;
 
 		return 0;
-- 
2.25.1

