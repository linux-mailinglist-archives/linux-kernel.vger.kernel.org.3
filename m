Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2058824A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiHBTKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiHBTKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:10:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548120F4A;
        Tue,  2 Aug 2022 12:10:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so14618398pjn.3;
        Tue, 02 Aug 2022 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=1Fhi/pC4xw3OPTvEKSAzkqvvM4dFeLSgYHZxK40S0/Q=;
        b=NYtgEeoaghrU8qVNeAfEHo+hiWygoLHGe//I9QBLPEGWow2BDRS8mlPg039Qwlm+6O
         rj/B+ErN+huUUT7qffmxSE5KswZ3t8EQhNEn74BB52bxZz0YeQDF/S9fuxp5OATuE/ZY
         rSZ90x3fx02nuHv8MUAA/dc90g1twsKvnCXcDj64bD2rsOYhKlxPdjjxoJCc/Ov4/AZX
         TyKgYKrXKmu3Z44yfagde8dmG8L7Mqemq0t9/qwyf7CGt30IclT7g9b6uaztpOfZbROU
         p2C+2CLNTKwvlPzvGzaIeHeB69cldZ0PdSJZ27BB5fFf2+IN5YmFQFeNY43FnWmaHXpU
         FvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=1Fhi/pC4xw3OPTvEKSAzkqvvM4dFeLSgYHZxK40S0/Q=;
        b=jWlfGyBQazDBoYkgAB6ePnGTqJYbteaVoWxdX3MrDqvSkHU98g4dJLNGOGORvMC+aK
         CFTVR0/t2/MfEZarCxvQzKCrWOsm2t5rSK2BsAlnPE/S4GI5QHHC6k8NQNHTD0mmxz9u
         FycNLdlHkADCtpc8mmZeYe+r02sj7TFPp5SaFdKVFq63KyulAUpWD2eO6QN+9ve5DhLj
         pBzxHlLmEQ5jg/Cxru0VVoUjugnRhr6UMHXgnRlcT8QuXR+zZg917S+Atk/cWOgJMwJZ
         L5KkiUCa0YWTjL8E3AoeyOYAJgp09KRVWLyKQjsFmSJkdAFCX+qcNe1gCZ/zPmWQIRBS
         Vyvg==
X-Gm-Message-State: ACgBeo3W74ttcWunFFtilLQOe6p6Kx3O8/ijR9g0obn/L1Qt2+rlDXwQ
        JSnpGzKYBnGHGhD7A/x46NE=
X-Google-Smtp-Source: AA6agR6c5d/eGDZnvXii4j134GP/53rWW/DvN9lfXS8jWY5N9Vn0RcwB4+wjZULSragax6pLfvCHmQ==
X-Received: by 2002:a17:90b:17ca:b0:1f2:df3d:593c with SMTP id me10-20020a17090b17ca00b001f2df3d593cmr921029pjb.205.1659467406115;
        Tue, 02 Aug 2022 12:10:06 -0700 (PDT)
Received: from balhae.roam.corp.google.com (rrcs-173-196-215-70.west.biz.rr.com. [173.196.215.70])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902714900b0016a091eb88esm46784plm.126.2022.08.02.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 12:10:05 -0700 (PDT)
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
Subject: [PATCH v2 1/3] perf lock: Introduce struct lock_contention
Date:   Tue,  2 Aug 2022 12:10:02 -0700
Message-Id: <20220802191004.347740-1-namhyung@kernel.org>
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

