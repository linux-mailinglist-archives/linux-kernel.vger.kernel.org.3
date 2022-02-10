Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365044B08E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiBJIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:52:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiBJIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:52:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1ABC2A;
        Thu, 10 Feb 2022 00:52:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so8139683wrc.13;
        Thu, 10 Feb 2022 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/u3kTCTXAUlICGSNYbAWHqQvCCJLwNc1nISblF5DusI=;
        b=aH8Em/b4Z5PKPPXvyKGK0jM31ldxtfnQgj0TFX/o059vwj7zRuknKrNk9wsBxSGZ2z
         ceSiTwFdoWYjeAmV5TQWyQPAC3lZjwDsvd+hBLPr3yUSaBG4CkoAohAzqbqppwAJpIdX
         sCdcnemFGT6YAtNWplTo3Gfsg2f32Bv221qbe6JGT0VCj0KTqaqrpmYleVpMYu6lfb9f
         tQx6Od/ugg3YcMUVCQvRUOly6ZAAO0S/b95yuq4ByC3gvuWRRvQvouzREc2mWQeptJ8U
         sPH6Mto5Sjcep2ndfcGoGOM2RL0cE6zKfHr3r3vUjKZ5GZiEpsoMgsc0ZCmQPQTxplLa
         Xu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/u3kTCTXAUlICGSNYbAWHqQvCCJLwNc1nISblF5DusI=;
        b=xIYkWmJWoAfawZ8MHYLv5PegFYx9Pjf/D7xdJXqs3jtQRbCv5B6XmdHzbxH3FgS8tB
         Ce3eepPsi+LSAbXrcwgFgpxwvinnbdZKBp0RwHm4kSQicZrE0YuRb3AMREoDac1TvC12
         2CbedeKG+whLocgb5RCDJkgCE6KsskO4Wa5IGlM3HCLTcGppww7yolc3QMG8baEUS4qZ
         PzGXwIZSuzkgwQniJeUog+jzsc2w0VnCyFHYJscKkpaFU5i09jIrE01ihDYn2zga3t8O
         yrGFwKM0qlQVHsYwHcngIaMrxEMYNN1E0dh6ag5kckUkd05oWWRlewkoqLkiBPRlYPQz
         t83Q==
X-Gm-Message-State: AOAM531B6EaBk88Vgv0u+eEXpV1S89a/If7y5FyTGGmxtElatZ/ofTGt
        tG/ZHat6poQE02GhisWWaFg=
X-Google-Smtp-Source: ABdhPJxY7SDfatLjxXJSeqHiZarkXhnTWabuPGCJV1jX4QZTGhs2au01uPWxYexF+yIUJ8rQKcpJlQ==
X-Received: by 2002:a5d:5264:: with SMTP id l4mr5372844wrc.483.1644483147898;
        Thu, 10 Feb 2022 00:52:27 -0800 (PST)
Received: from oberon.com ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id n29sm856773wms.8.2022.02.10.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 00:52:27 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libperf: Add API for allocating new thread map
Date:   Thu, 10 Feb 2022 10:52:25 +0200
Message-Id: <20220210085225.551891-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing API perf_thread_map__new_dummy() allocates new thread map
for one thread. I couldn't find a way to reallocate the map with more
threads, or to allocate a new map for more than one thread. Having
multiple threads in a thread map is essential for some use cases.
That's why a new API is proposed, which allocates a new thread map
for given number of threads:
 perf_thread_map__new()

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/include/perf/threadmap.h  |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/lib/perf/tests/test-threadmap.c    | 27 ++++++++++++++++++++++++
 tools/lib/perf/threadmap.c               | 15 +++++++++----
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 32c5051c24eb..9cbd41c29bff 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -62,6 +62,7 @@ SYNOPSIS
   struct perf_thread_map;
 
   struct perf_thread_map *perf_thread_map__new_dummy(void);
+  struct perf_thread_map *perf_thread_map__new(int nr);
 
   void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
   char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
index a7c50de8d010..47d433416040 100644
--- a/tools/lib/perf/include/perf/threadmap.h
+++ b/tools/lib/perf/include/perf/threadmap.h
@@ -8,6 +8,7 @@
 struct perf_thread_map;
 
 LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
+LIBPERF_API struct perf_thread_map *perf_thread_map__new(int nr);
 
 LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
 LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 93696affda2e..240a2f087b70 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__empty;
 		perf_cpu_map__max;
 		perf_cpu_map__has;
+		perf_thread_map__new;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
index 5e2a0291e94c..3388bf36dfc0 100644
--- a/tools/lib/perf/tests/test-threadmap.c
+++ b/tools/lib/perf/tests/test-threadmap.c
@@ -11,9 +11,12 @@ static int libperf_print(enum libperf_print_level level,
 	return vfprintf(stderr, fmt, ap);
 }
 
+#define THREADS_NR	5
+
 int test_threadmap(int argc, char **argv)
 {
 	struct perf_thread_map *threads;
+	int i;
 
 	__T_START;
 
@@ -27,6 +30,30 @@ int test_threadmap(int argc, char **argv)
 	perf_thread_map__put(threads);
 	perf_thread_map__put(threads);
 
+	threads = perf_thread_map__new(THREADS_NR);
+	if (!threads)
+		tests_failed++;
+
+	if (perf_thread_map__nr(threads) != THREADS_NR)
+		tests_failed++;
+
+	for (i = 0; i < THREADS_NR; i++) {
+		if (perf_thread_map__pid(threads, i) != -1)
+			tests_failed++;
+	}
+
+	for (i = 1; i < THREADS_NR; i++)
+		perf_thread_map__set_pid(threads, i, i * 100);
+
+	if (perf_thread_map__pid(threads, 0) != -1)
+		tests_failed++;
+
+	for (i = 1; i < THREADS_NR; i++) {
+		if (perf_thread_map__pid(threads, i) != i * 100)
+			tests_failed++;
+	}
+	perf_thread_map__put(threads);
+
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
 }
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index e92c368b0a6c..843fe1070cc9 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -42,18 +42,25 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
 	return map->map[thread].comm;
 }
 
-struct perf_thread_map *perf_thread_map__new_dummy(void)
+struct perf_thread_map *perf_thread_map__new(int nr)
 {
-	struct perf_thread_map *threads = thread_map__alloc(1);
+	struct perf_thread_map *threads = thread_map__alloc(nr);
+	int i;
 
 	if (threads != NULL) {
-		perf_thread_map__set_pid(threads, 0, -1);
-		threads->nr = 1;
+		for (i = 0; i < nr; i++)
+			perf_thread_map__set_pid(threads, i, -1);
+		threads->nr = nr;
 		refcount_set(&threads->refcnt, 1);
 	}
 	return threads;
 }
 
+struct perf_thread_map *perf_thread_map__new_dummy(void)
+{
+	return perf_thread_map__new(1);
+}
+
 static void perf_thread_map__delete(struct perf_thread_map *threads)
 {
 	if (threads) {
-- 
2.34.1

