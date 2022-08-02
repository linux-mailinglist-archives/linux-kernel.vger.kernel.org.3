Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878235881D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiHBSZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiHBSZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:25:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA50014017;
        Tue,  2 Aug 2022 11:25:06 -0700 (PDT)
Received: from BRIANROB-L1.corp.microsoft.com (unknown [167.220.2.188])
        by linux.microsoft.com (Postfix) with ESMTPSA id 751EA20FF4ED;
        Tue,  2 Aug 2022 11:25:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 751EA20FF4ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659464706;
        bh=jCknuAZXcS7EQG+s0KtGkSDPS0LlyQP0yJ1frqbdv5s=;
        h=From:To:Cc:Subject:Date:From;
        b=i+fYMFLaNvJPNfflfVXOv8D1JbPvYuB4MXj9KKAemXPXyZxcM5olO83G0u+PBxg6o
         VXnsxBnVufDNFmvOrG/S87NmsaO4csmmSIcrlNaML46g9R29ARojZHmbgGRDl5MSrc
         IsmwenUDwAXkuhvGdbNPrZAXt/D9N1Yup3AurHyw=
From:   Brian Robbins <brianrob@linux.microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        brianrob@linux.microsoft.com
Subject: [PATCH] perf inject jit: Ignore memfd mmap events if jitdump present
Date:   Tue,  2 Aug 2022 11:25:02 -0700
Message-Id: <20220802182502.85562-1-brianrob@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Ignore /memfd: mappings so that jitted code contained in /memfd:
mappings is treated the same way as jitted code contained in //anon*
mappings.

Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>
---
 tools/perf/util/jitdump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index a23255773c60..335a3c61940b 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -845,8 +845,12 @@ jit_process(struct perf_session *session,
 	if (jit_detect(filename, pid, nsi)) {
 		nsinfo__put(nsi);
 
-		// Strip //anon* mmaps if we processed a jitdump for this pid
-		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
+		/*
+		 * Strip //anon* and /memfd:* mmaps if we processed a jitdump for this pid
+		 */
+		if (jit_has_pid(machine, pid) &&
+			((strncmp(filename, "//anon", 6) == 0) ||
+			 (strncmp(filename, "/memfd:", 7) == 0))
 			return 1;
 
 		return 0;
-- 
2.25.1

