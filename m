Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1697D59F2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 06:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiHXEik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 00:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXEih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:38:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B87DF5B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 21:38:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-336c3b72da5so267961657b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 21:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=3opLk4Oz93lm77lsPTBWHBXIaH3afs5uHa/1mKNusGU=;
        b=PctrHBniebv3hCjyLQ/5fSwmIVjcOOdCc30ReMbNTAzpDzM8H6J4TyM5Q9Y+PLbJ6e
         JWUBxLGHfwoQIKNTvAEekL2u6Wx8QQAqvhHl2PwJbBPgJx1riqGt1ef66Vfznfnp+k2b
         Q7+yynShR+LtUQYVLK+PSQ6PxEyMqS86bMY7fO4fgibOgamEGhRP6/Eq6DHcb1IxCJKR
         iqTPUdlgWFwrY6qGykUmbKC7WigW2cba9zOwlmz0b//n9X63AIsBf7kaRm3V3iq/r5XZ
         RfBdtIpRzMxE7KBYL54weUCMdD3IqBBoJ9DhPLMfNYz3EGPotmSbwRIL2nMVY23wpkXw
         462Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=3opLk4Oz93lm77lsPTBWHBXIaH3afs5uHa/1mKNusGU=;
        b=umaFRhBvVV+pxR/buG2I4GsIMd6u8JOU3rNRTwZbn/PWXU7viMPiTh2VErU7X9s64H
         Er389c6jnCU9KhHrHi7jICa4t+aRIOccHtVxG9pQEAyJN8YTyoLAqggLIE8RtYEC7/2D
         YH1EipcB+G1ftiVb+SF4QS9CZIeG2JcX8spnP57Pdr6RY6rsQhs1wblA3MYZv9x36AC6
         L0ShE/P8v3cvwHVclRhk0Oh29gUk2CwR1IIbDgsoflCe2eyvT8CUQGACmPGr2ZKIfK2E
         cOHtpSvXSbVwJW1fDBX5YOIoPmZCIAyjGGtfUT+YQ8esYx8cm8OGLJ/e2S7zO1WLDLVs
         8F7Q==
X-Gm-Message-State: ACgBeo3FE7zQemnMXW3aabI8Jus79kJoKw5TrDz3XYYFljr+tNEW+zvb
        C7lxCUzjqENqZlbnw1cvyxwCygHwA1Ad
X-Google-Smtp-Source: AA6agR4uUgDd/+U54aisjGd42CsqA7eYed/AKyUrKuesNWvHwO2T7cy58ZG7JxjlpX2p90jcd0327ukTJqjp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a25:4a06:0:b0:695:c6a0:c8e1 with SMTP id
 x6-20020a254a06000000b00695c6a0c8e1mr10110095yba.181.1661315914190; Tue, 23
 Aug 2022 21:38:34 -0700 (PDT)
Date:   Tue, 23 Aug 2022 21:38:25 -0700
Message-Id: <20220824043825.322827-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH] perf sched: Fix memory leaks in __cmd_record
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An array of strings is passed to cmd_record but not freed. As
cmd_record modifies the array, add another array as a copy that can be
mutated allowing the original array contents to all be freed.

Detected with -fsanitize=address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2f6cd1b8b662..59ba14d2321c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3355,7 +3355,8 @@ static bool schedstat_events_exposed(void)
 static int __cmd_record(int argc, const char **argv)
 {
 	unsigned int rec_argc, i, j;
-	const char **rec_argv;
+	char **rec_argv;
+	const char **rec_argv_copy;
 	const char * const record_args[] = {
 		"record",
 		"-a",
@@ -3384,6 +3385,7 @@ static int __cmd_record(int argc, const char **argv)
 		ARRAY_SIZE(schedstat_args) : 0;
 
 	struct tep_event *waking_event;
+	int ret;
 
 	/*
 	 * +2 for either "-e", "sched:sched_wakeup" or
@@ -3391,14 +3393,15 @@ static int __cmd_record(int argc, const char **argv)
 	 */
 	rec_argc = ARRAY_SIZE(record_args) + 2 + schedstat_argc + argc - 1;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	rec_argv_copy = calloc(rec_argc + 1, sizeof(char *));
 
-	if (rec_argv == NULL)
+	if (rec_argv == NULL || rec_argv_copy == NULL)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
 		rec_argv[i] = strdup(record_args[i]);
 
-	rec_argv[i++] = "-e";
+	rec_argv[i++] = strdup("-e");
 	waking_event = trace_event__tp_format("sched", "sched_waking");
 	if (!IS_ERR(waking_event))
 		rec_argv[i++] = strdup("sched:sched_waking");
@@ -3409,11 +3412,19 @@ static int __cmd_record(int argc, const char **argv)
 		rec_argv[i++] = strdup(schedstat_args[j]);
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = strdup(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_record(i, rec_argv);
+	memcpy(rec_argv_copy, rec_argv, sizeof(char*) * rec_argc);
+	ret = cmd_record(rec_argc, rec_argv_copy);
+
+	for (i = 0; i < rec_argc; i++)
+		free(rec_argv[i]);
+	free(rec_argv);
+	free(rec_argv_copy);
+
+	return ret;
 }
 
 int cmd_sched(int argc, const char **argv)
-- 
2.37.2.609.g9ff673ca1a-goog

