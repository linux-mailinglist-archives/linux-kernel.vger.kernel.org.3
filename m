Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7520B4A6725
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiBAVjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:39:21 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46935 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiBAVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:39:20 -0500
Received: by mail-ot1-f50.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso9445613otv.13;
        Tue, 01 Feb 2022 13:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CeauCX3KKYXQgJfgtEO1x40f/OGRoNcTeAllHgSNFA=;
        b=ohwaP4t94vdm2WD7azEQ9ht3i2Dcn9ixzaihoetlgpB/9hJZL+dSOcakqSqdhtJj+9
         P6Da0/t5SxIIhm01JLUmauw3z788D3gWOYUEfMHXZuRwxXyLFDCn9/CywAK0iR4+zMGy
         e1mQDwff9VQKAOzhQvrmpw9kW/GBKL84IZKwghnRDH0atIIWTQ5PHxvoZ6otA0SYSCvh
         yuMldMcUGCbeV/r1UpeDwbKQY9m7Ky+KBDkRTc3W46esAy9Rt5iVH1pmLmpGdKcdFoiG
         A9N391a67Eiu/y6FLuwAiIRmxHXUbkKG9KbZtWQIeFJxXYKB1yh0FvqwVEZCuNd73CJm
         MFzA==
X-Gm-Message-State: AOAM530lGfoeeWW8FI0E+CWrgHzR3OTndTY0RYDmLAIfZTV3fPy5kyzL
        ukEdxAwTO17kxxkkSWr74g==
X-Google-Smtp-Source: ABdhPJw5svoe0oy61D+R6mAPdcxjyth+fO1q8ohAhwUUNfmHTxBFlzp+pxqN/TparTAnbB1u3lLUeQ==
X-Received: by 2002:a9d:450c:: with SMTP id w12mr13037609ote.217.1643751559613;
        Tue, 01 Feb 2022 13:39:19 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id p5sm11258872oou.39.2022.02.01.13.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:39:18 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libperf: Fix 32-bit build for tests uint64_t printf
Date:   Tue,  1 Feb 2022 15:39:03 -0600
Message-Id: <20220201213903.699656-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a7f3713f6bf2 ("libperf tests: Add test_stat_multiplexing test")
added printf's of 64-bit ints using %lu which doesn't work on 32-bit
builds:

tests/test-evlist.c:529:29: error: format ‘%lu’ expects argument of type \
  ‘long unsigned int’, but argument 4 has type ‘uint64_t’ {aka ‘long long unsigned int’} [-Werror=format=]

Use PRIu64 instead which works on both 32-bit and 64-bit systems.

Fixes: a7f3713f6bf2 ("libperf tests: Add test_stat_multiplexing test")
Cc: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/lib/perf/tests/test-evlist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index b3479dfa9a1c..fa854c83b7e7 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
+#include <inttypes.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdarg.h>
@@ -526,12 +527,12 @@ static int test_stat_multiplexing(void)
 
 	min = counts[0].val;
 	for (i = 0; i < EVENT_NUM; i++) {
-		__T_VERBOSE("Event %2d -- Raw count = %lu, run = %lu, enable = %lu\n",
+		__T_VERBOSE("Event %2d -- Raw count = %" PRIu64 ", run = %" PRIu64 ", enable = %" PRIu64 "\n",
 			    i, counts[i].val, counts[i].run, counts[i].ena);
 
 		perf_counts_values__scale(&counts[i], true, &scaled);
 		if (scaled == 1) {
-			__T_VERBOSE("\t Scaled count = %lu (%.2lf%%, %lu/%lu)\n",
+			__T_VERBOSE("\t Scaled count = %" PRIu64 " (%.2lf%%, %" PRIu64 "/%" PRIu64 ")\n",
 				    counts[i].val,
 				    (double)counts[i].run / (double)counts[i].ena * 100.0,
 				    counts[i].run, counts[i].ena);
-- 
2.32.0

