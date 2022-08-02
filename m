Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA325877EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiHBHfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiHBHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:35:21 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A9307;
        Tue,  2 Aug 2022 00:35:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so11676293pgb.4;
        Tue, 02 Aug 2022 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=1Fhi/pC4xw3OPTvEKSAzkqvvM4dFeLSgYHZxK40S0/Q=;
        b=lAoYzTGSkC8SEsXta60yxrUe2IMIzfGd7Us5ZtbZYnGk7+b2Cxf4JfEDUhcMHF1GPl
         xktZiuHju3cS5EgAwbEo1ZmcYAXXqqDttlHHlX4jSFS8QmMGqF1UvF/s9/fb5TxURteW
         9YZkhlWISR8cjDpVfupIqAP+w2X5q6on1+QtOplW6TUDqdR0wwtMGf1muj8MTu5LJf8S
         rYHAtggwzTg0MIMSRO5/lIaaDjiw+lZlJGtJ+bAMMKc6tC/8HN8J32/CKFwfYlQdUCZ+
         185GW2LB6rqzu4MOBBtnQNaxc0U1Cf3a+Z59Bnk3oRNfvL3xTbpF1OD2OozNzjDjQ89+
         3NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=1Fhi/pC4xw3OPTvEKSAzkqvvM4dFeLSgYHZxK40S0/Q=;
        b=jeHPk0oR85kQXUg0bIjbsT8e6WfvmOB4Fdf7Ek/b8hhLkokEWSrz8F5Q/0fEjt2SqG
         pnu1lWym3Hg4Q4USpMOtndmx5rFZ5HeJ96rCiv6v4hiJSh13fQ130x809Z+uXdFBhnhO
         zFIR2P1AJlx1n39nvL65XOBrODxDhIBI+xBx2aL7u3REB7z5QQVBjW/267mEZsZp6tk9
         5ruGy3vzL241o4ayJ02nZoJ6KkmPFx8s2kKMqCOwEXX0EULA0AAsW/0WFH2zTNxyr/hY
         B9W4ZS4in9xQ3ew6i3PQPm7RorECgb1E9/DBPVQi6vguSh2jyXrZrv4tzrOCUihBPvb7
         tlhg==
X-Gm-Message-State: AJIora978+/46rp/dHMzvWyOhw4IoqPAD07fWTokVGTLEppGJrOySAUi
        9kZAUGyA3jZfO2KEiWs7aXw=
X-Google-Smtp-Source: AGRyM1snNTp6Oq00DrZzYYHLxQo+Ii74tmFr50PQS42tdricKjBI7IzM9gygLfu4el88Rh1yznMXlA==
X-Received: by 2002:a63:fd14:0:b0:41a:20e8:c1e2 with SMTP id d20-20020a63fd14000000b0041a20e8c1e2mr16086488pgh.286.1659425714175;
        Tue, 02 Aug 2022 00:35:14 -0700 (PDT)
Received: from balhae.roam.corp.google.com (rrcs-173-196-215-70.west.biz.rr.com. [173.196.215.70])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b0016be368fb30sm10802896pla.212.2022.08.02.00.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:35:13 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 1/3] perf lock: Introduce struct lock_contention
Date:   Tue,  2 Aug 2022 00:35:09 -0700
Message-Id: <20220802073511.299459-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_contention struct is to carry related fields together and to
minimize the change when we add new config options.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c             | 23 ++++++++++++++---------
 tools/perf/util/bpf_lock_contention.c |  9 ++++++---
 tools/perf/util/lock-contention.h     | 17 +++++++++++------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7897a33fec1b..eef778b7d33d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1594,7 +1594,10 @@ static int __cmd_contention(int argc, const char **argv)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
-	struct evlist *evlist = NULL;
+	struct lock_contention con = {
+		.target = &target,
+		.result = &lockhash_table[0],
+	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
@@ -1620,24 +1623,26 @@ static int __cmd_contention(int argc, const char **argv)
 		signal(SIGCHLD, sighandler);
 		signal(SIGTERM, sighandler);
 
-		evlist = evlist__new();
-		if (evlist == NULL) {
+		con.machine = &session->machines.host;
+
+		con.evlist = evlist__new();
+		if (con.evlist == NULL) {
 			err = -ENOMEM;
 			goto out_delete;
 		}
 
-		err = evlist__create_maps(evlist, &target);
+		err = evlist__create_maps(con.evlist, &target);
 		if (err < 0)
 			goto out_delete;
 
 		if (argc) {
-			err = evlist__prepare_workload(evlist, &target,
+			err = evlist__prepare_workload(con.evlist, &target,
 						       argv, false, NULL);
 			if (err < 0)
 				goto out_delete;
 		}
 
-		if (lock_contention_prepare(evlist, &target) < 0) {
+		if (lock_contention_prepare(&con) < 0) {
 			pr_err("lock contention BPF setup failed\n");
 			goto out_delete;
 		}
@@ -1672,13 +1677,13 @@ static int __cmd_contention(int argc, const char **argv)
 	if (use_bpf) {
 		lock_contention_start();
 		if (argc)
-			evlist__start_workload(evlist);
+			evlist__start_workload(con.evlist);
 
 		/* wait for signal */
 		pause();
 
 		lock_contention_stop();
-		lock_contention_read(&session->machines.host, &lockhash_table[0]);
+		lock_contention_read(&con);
 	} else {
 		err = perf_session__process_events(session);
 		if (err)
@@ -1691,7 +1696,7 @@ static int __cmd_contention(int argc, const char **argv)
 	print_contention_result();
 
 out_delete:
-	evlist__delete(evlist);
+	evlist__delete(con.evlist);
 	lock_contention_finish();
 	perf_session__delete(session);
 	return err;
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 16b7451b4b09..f5e2b4f19a72 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -27,10 +27,12 @@ struct lock_contention_data {
 	u32 flags;
 };
 
-int lock_contention_prepare(struct evlist *evlist, struct target *target)
+int lock_contention_prepare(struct lock_contention *con)
 {
 	int i, fd;
 	int ncpus = 1, ntasks = 1;
+	struct evlist *evlist = con->evlist;
+	struct target *target = con->target;
 
 	skel = lock_contention_bpf__open();
 	if (!skel) {
@@ -102,12 +104,13 @@ int lock_contention_stop(void)
 	return 0;
 }
 
-int lock_contention_read(struct machine *machine, struct hlist_head *head)
+int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack;
 	u32 prev_key, key;
 	struct lock_contention_data data;
 	struct lock_stat *st;
+	struct machine *machine = con->machine;
 	u64 stack_trace[CONTENTION_STACK_DEPTH];
 
 	fd = bpf_map__fd(skel->maps.lock_stat);
@@ -163,7 +166,7 @@ int lock_contention_read(struct machine *machine, struct hlist_head *head)
 			return -1;
 		}
 
-		hlist_add_head(&st->hash_entry, head);
+		hlist_add_head(&st->hash_entry, con->result);
 		prev_key = key;
 	}
 
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 092c84441f9f..a0df5308cca4 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -107,18 +107,24 @@ struct evlist;
 struct machine;
 struct target;
 
+struct lock_contention {
+	struct evlist *evlist;
+	struct target *target;
+	struct machine *machine;
+	struct hlist_head *result;
+};
+
 #ifdef HAVE_BPF_SKEL
 
-int lock_contention_prepare(struct evlist *evlist, struct target *target);
+int lock_contention_prepare(struct lock_contention *con);
 int lock_contention_start(void);
 int lock_contention_stop(void);
-int lock_contention_read(struct machine *machine, struct hlist_head *head);
+int lock_contention_read(struct lock_contention *con);
 int lock_contention_finish(void);
 
 #else  /* !HAVE_BPF_SKEL */
 
-static inline int lock_contention_prepare(struct evlist *evlist __maybe_unused,
-					  struct target *target __maybe_unused)
+static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
 {
 	return 0;
 }
@@ -127,8 +133,7 @@ static inline int lock_contention_start(void) { return 0; }
 static inline int lock_contention_stop(void) { return 0; }
 static inline int lock_contention_finish(void) { return 0; }
 
-static inline int lock_contention_read(struct machine *machine __maybe_unused,
-				       struct hlist_head *head __maybe_unused)
+static inline int lock_contention_read(struct lock_contention *con __maybe_unused)
 {
 	return 0;
 }
-- 
2.37.1.455.g008518b4e5-goog

