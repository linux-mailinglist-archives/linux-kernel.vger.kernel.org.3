Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20CA59FDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiHXO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiHXO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:57:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683286C0A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:57:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-335420c7bfeso295796317b3.16
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=JJOIl+EDVjVvhR9Jq1qiOL01/r6+w00u23P6bw2VtMs=;
        b=cHhsa+jPUGGQ+zGim31Z7luEFiBNoI/X65ETXMUdPiUWbMPtIe96ZvxWUykdAFWtV1
         Tspe4tsu/gj0Homw9TXFiY3MPZMg+MffTKAfkYcToYvszS8aih8jQpeaEbHF+e7XJM7c
         1mvofPmhabcRCIpIteCEUruivzSLaFYFDovcPtDizJUiSoxfDxqAy+gatnXhElNuc20i
         yQZDZDsA3CyGuL/z2OKLj76fYsnqkwr/oIIZF59MBFKUDgdoKrddCeChD96XAFaVuGYd
         5YVmqwNDP3NclMLV54Pl7WrfrJFZASk4VWPHoAkz3RPMz+lhjmsNZZiZ3GiQPbVOr5Ty
         sYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=JJOIl+EDVjVvhR9Jq1qiOL01/r6+w00u23P6bw2VtMs=;
        b=YajLfhNVS6wO3Kt4uWR7zjqFf1mR0mwHRSHjc1c8OyBbwMYXA3kEiGOOIWtd2Cwv9p
         jd1iiDCPdhMRnGC5iY6tle5Y644FaKJv0tvBac4KrsjFAEnW9mOdmgljbeWKKNZijLOP
         dEnXxErpGjMNDzo16DEMuyLnnMUJPT7fUqUhu1rbY+knAl9JcH+PdFpBrjbLz5g0dfHT
         PFv7Z5876+Pm3n1iDBnvyn+kAqeUE/ZnB+6ibYjAi9mUh/Gj5JRQT/mhBgl9oHywfJW9
         6SdEUqPk9XelyWZUlLE5o9uzPoh70nnqhd0oVnJajsZLeP1h0mYwDITnyhiRPoKqzD81
         TPyQ==
X-Gm-Message-State: ACgBeo07RKjBxKNqUhea/q8S+SCRo0sSMNNskACEsMY3l1Vg5efc/gUp
        qEARWOkiANaNo7FmEuz3/cvhUYedX9Go
X-Google-Smtp-Source: AA6agR6UZyaqUGsHp0NBvF+c02VZlNBHz1zPqI70WE8GaQASuxfbdgbFXOl/by68XCkWkq5IDBQbCg7nAGI3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a25:5842:0:b0:695:6207:507d with SMTP id
 m63-20020a255842000000b006956207507dmr23358575ybb.219.1661353063358; Wed, 24
 Aug 2022 07:57:43 -0700 (PDT)
Date:   Wed, 24 Aug 2022 07:57:33 -0700
Message-Id: <20220824145733.409005-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2] perf sched: Fix memory leaks in __cmd_record
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 tools/perf/builtin-sched.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2f6cd1b8b662..a5cf243c337f 100644
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
@@ -3391,14 +3393,18 @@ static int __cmd_record(int argc, const char **argv)
 	 */
 	rec_argc = ARRAY_SIZE(record_args) + 2 + schedstat_argc + argc - 1;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
-
 	if (rec_argv == NULL)
 		return -ENOMEM;
+	rec_argv_copy = calloc(rec_argc + 1, sizeof(char *));
+	if (rec_argv_copy == NULL) {
+		free(rec_argv);
+		return -ENOMEM;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
 		rec_argv[i] = strdup(record_args[i]);
 
-	rec_argv[i++] = "-e";
+	rec_argv[i++] = strdup("-e");
 	waking_event = trace_event__tp_format("sched", "sched_waking");
 	if (!IS_ERR(waking_event))
 		rec_argv[i++] = strdup("sched:sched_waking");
@@ -3409,11 +3415,19 @@ static int __cmd_record(int argc, const char **argv)
 		rec_argv[i++] = strdup(schedstat_args[j]);
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = strdup(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_record(i, rec_argv);
+	memcpy(rec_argv_copy, rec_argv, sizeof(char *) * rec_argc);
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

