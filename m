Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DFA5877EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiHBHfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiHBHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:35:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A16DA9;
        Tue,  2 Aug 2022 00:35:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e132so11675823pgc.5;
        Tue, 02 Aug 2022 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=IBAUG/bpyaU3jSgEVIxzzw7oGbIuCDdRdzuZfuiuEAw=;
        b=Jp9o7eugy/hHZDd7bXj/4H+3k/axx1aahcm1LXz1kXeJH/cFOPUP+y2Suac9P3wU6u
         QdmlUnbzjoqSnLMsmz2cqiIXAdUZy35CmDFP+stgkuJxBDSA9Wjmd/hQCdAn5b9QkSgM
         X229t+rX4VFgc8b4x3xvSPfLk0YEPW3cGsqN6M5gSirsizW+IRkDENgmirZstDMha7rw
         9m/wOJ+5Dk+6CUska7yR0sOUZI6bT11BgBRbP9JXFJO7xgEfPmrE8okECzfrh70ZfGtb
         pLDObnWl5vN/fYxvGty/Z345tyCOCi9hAczFG8avJPwLT40sR+WnOz7V6PL5gSE2UI1V
         NnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=IBAUG/bpyaU3jSgEVIxzzw7oGbIuCDdRdzuZfuiuEAw=;
        b=v53Quqi8//xELTRJsi1wXfI9xQJQESyCxubBrHNhK5ZoNvgGznQawlclI6Hcp5tG6A
         qaTkhVrC7i34COE89tnH5aDpsqVuHTSrMkcRxH9FnTr9Bh8ib9Wr7lL/gsBSUr8uNaZ5
         CWVitRtM0SJIDuY7ylRAdxvcpsn+6DqNPQaucsSyGtrKtQUybF5poTmD9knrcd9k5Umn
         ntKLSRmeYW+QAdIpzfLOSlPvpSAOaVHX+tmzG8u/KbP25/zI2W2ctTX8ZCvHJJwq7jbh
         N3dgMfC3l7FRi0boDvCr8pbzGm0+YbeIOzpJwababwxGqmCdejnw2F9OPEkEcESKtSQE
         wptA==
X-Gm-Message-State: ACgBeo3O2mkcBuit0LQXHOacQFgyI0uTaIf2B2GuvE4m39rNR4sL+ecV
        QgT5qEXGJnWwjgRHFREW02g=
X-Google-Smtp-Source: AA6agR54oRROMzJT8jLOonCUny0A47nV7r5P0gVpqM1pSG8Ju6rTq1/SMHOt3qMD1xUPomB0Nzrgsg==
X-Received: by 2002:a65:5383:0:b0:41c:1148:5d6b with SMTP id x3-20020a655383000000b0041c11485d6bmr6826856pgq.24.1659425717280;
        Tue, 02 Aug 2022 00:35:17 -0700 (PDT)
Received: from balhae.roam.corp.google.com (rrcs-173-196-215-70.west.biz.rr.com. [173.196.215.70])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b0016be368fb30sm10802896pla.212.2022.08.02.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:35:16 -0700 (PDT)
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
Subject: [PATCH 3/3] perf lock: Print lost entries at the end
Date:   Tue,  2 Aug 2022 00:35:11 -0700
Message-Id: <20220802073511.299459-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220802073511.299459-1-namhyung@kernel.org>
References: <20220802073511.299459-1-namhyung@kernel.org>
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

Like the normal perf lock report output, it'd print bad stats at the end
if exists or -v option is passed.  Currently it uses BROKEN_CONTENDED
stat for the lost count (due to full stack maps).

  $ sudo perf lock con -a -b -m 128 sleep 5
  ...
  === output for debug===

  bad: 43, total: 14903
  bad rate: 0.29 %
  histogram of events caused bad sequence
      acquire: 0
     acquired: 0
    contended: 43
      release: 0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                      | 8 +++++++-
 tools/perf/util/bpf_lock_contention.c          | 6 ++++--
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 9 +++++++--
 tools/perf/util/lock-contention.h              | 1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e32fdcd497e0..8065f0268e55 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1471,8 +1471,11 @@ static void print_contention_result(void)
 		pr_info("  %10s   %s\n\n", "type", "caller");
 
 	bad = total = 0;
+	if (use_bpf)
+		bad = bad_hist[BROKEN_CONTENDED];
+
 	while ((st = pop_from_result())) {
-		total++;
+		total += use_bpf ? st->nr_contended : 1;
 		if (st->broken)
 			bad++;
 
@@ -1686,6 +1689,9 @@ static int __cmd_contention(int argc, const char **argv)
 
 		lock_contention_stop();
 		lock_contention_read(&con);
+
+		/* abuse bad hist stats for lost entries */
+		bad_hist[BROKEN_CONTENDED] = con.lost;
 	} else {
 		err = perf_session__process_events(session);
 		if (err)
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 26128e5bb659..65f51cc25236 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -16,7 +16,7 @@ static struct lock_contention_bpf *skel;
 
 /* should be same as bpf_skel/lock_contention.bpf.c */
 struct lock_contention_key {
-	u32 stack_id;
+	s32 stack_id;
 };
 
 struct lock_contention_data {
@@ -110,7 +110,7 @@ int lock_contention_stop(void)
 int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack;
-	u32 prev_key, key;
+	s32 prev_key, key;
 	struct lock_contention_data data;
 	struct lock_stat *st;
 	struct machine *machine = con->machine;
@@ -119,6 +119,8 @@ int lock_contention_read(struct lock_contention *con)
 	fd = bpf_map__fd(skel->maps.lock_stat);
 	stack = bpf_map__fd(skel->maps.stacks);
 
+	con->lost = skel->bss->lost;
+
 	prev_key = 0;
 	while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
 		struct map *kmap;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 67d46533e518..9e8b94eb6320 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -12,7 +12,7 @@
 #define MAX_ENTRIES  10240
 
 struct contention_key {
-	__u32 stack_id;
+	__s32 stack_id;
 };
 
 struct contention_data {
@@ -27,7 +27,7 @@ struct tstamp_data {
 	__u64 timestamp;
 	__u64 lock;
 	__u32 flags;
-	__u32 stack_id;
+	__s32 stack_id;
 };
 
 /* callstack storage  */
@@ -73,6 +73,9 @@ int enabled;
 int has_cpu;
 int has_task;
 
+/* error stat */
+unsigned long lost;
+
 static inline int can_record(void)
 {
 	if (has_cpu) {
@@ -116,6 +119,8 @@ int contention_begin(u64 *ctx)
 	pelem->flags = (__u32)ctx[1];
 	pelem->stack_id = bpf_get_stackid(ctx, &stacks, BPF_F_FAST_STACK_CMP);
 
+	if (pelem->stack_id < 0)
+		lost++;
 	return 0;
 }
 
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index b09fd6eb978a..d9fc5f076567 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -113,6 +113,7 @@ struct lock_contention {
 	struct machine *machine;
 	struct hlist_head *result;
 	unsigned long map_len;
+	unsigned long lost;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.37.1.455.g008518b4e5-goog

