Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A858824C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiHBTK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiHBTKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:10:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A620F4A;
        Tue,  2 Aug 2022 12:10:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f28so6166496pfk.1;
        Tue, 02 Aug 2022 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=MLy9uiV2j16NyBVxlJPKV+jKtLHavhBa6pWohSeh6os=;
        b=ShCsTJf2+0P3xD4d8ud/cbA9lr5kh2yG7cW54WlT8KrzNjbKQec4YCITeurqQYB4HW
         ZrcQWS9yQiYKYUrr6oLqogoA8aN8OedTJvPhQFNF/CmoosmKL9RJ5BusBl5Kk2wyAtqd
         PPb185lCiQdRsNZaE8I224U6mJV016iQs+S7Kl/ed5/kbVxeqp0MicEGwExTjm+cEUkQ
         AA7Bo6nqFnPE7hrRN5yvuJD736OZwoRVWpNYpZ/Bh9IfrM6nhsq2yi1BJ72nnxoKrq02
         g1lG6ATC0n/9JIdGpMe6ujFfCx0ht2qCDCKXqz1EQIdubHZQ7r6nQLtqFIMFKaAGgmNv
         b+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=MLy9uiV2j16NyBVxlJPKV+jKtLHavhBa6pWohSeh6os=;
        b=PQ/5FeYsRx2KsgVa+TQ3Tk2/JgNuQiX2XufCVnCUwTZb1VdHdl/fBrhVOx3fAozGLI
         b2c6/IqxMNZCH6lJnZyQCTaVTk8psWuKwiqA5FwpKBKtvPpveb7gU6Fx43Mg3f6kp+f0
         /qkGmGPs/wnHu3PZl/j5Bygdwqh6oT5/9EXaCDLnBV0L8W+tLdoAZ/gP6yxWrhPrFjw9
         XTA2T34L5Ezb5F+M3IFqgrTDT/PgMi++ZqnrTAQQIJCO+sM3+T4Gv+lrLKSc+ocswOpg
         urhm+sng+AdESnDT5ikCAgbAbj9yN79fxTfl4WBGo4vJ+N5KOfV+CEuivfEMOBqtFYCp
         pnrQ==
X-Gm-Message-State: AJIora/UXzUsTZoq+J3CNpiSS9XN2zKIKqYAlEdU3eQJe6NKcxWZW/01
        3psfboHFlAvWwe9GCNdCL4U=
X-Google-Smtp-Source: AGRyM1s7B8cxyl2zSkMDOxy0j6UCon8/IPJ30z+fB+uCpzbR0hyeLO0p1ITQf6m8A6lLU4NXF00ydA==
X-Received: by 2002:a63:4711:0:b0:415:ff46:ba5 with SMTP id u17-20020a634711000000b00415ff460ba5mr18476317pga.133.1659467408589;
        Tue, 02 Aug 2022 12:10:08 -0700 (PDT)
Received: from balhae.roam.corp.google.com (rrcs-173-196-215-70.west.biz.rr.com. [173.196.215.70])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902714900b0016a091eb88esm46784plm.126.2022.08.02.12.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 12:10:08 -0700 (PDT)
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
Subject: [PATCH v2 3/3] perf lock: Print the number of lost entries for BPF
Date:   Tue,  2 Aug 2022 12:10:04 -0700
Message-Id: <20220802191004.347740-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220802191004.347740-1-namhyung@kernel.org>
References: <20220802191004.347740-1-namhyung@kernel.org>
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

Like the normal perf lock contention output, it'd print the number of
lost entries for BPF if exists or -v option is passed.  Currently it
uses BROKEN_CONTENDED stat for the lost count (due to full stack maps).

  $ sudo perf lock con -a -b --map-nr-entries 128 sleep 5
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
index 4c70cd1b9006..a8550f06cbfc 100644
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
index 0556cf4469ff..c591a66733ef 100644
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
index 8de8550f5ef8..2146efc33396 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -113,6 +113,7 @@ struct lock_contention {
 	struct machine *machine;
 	struct hlist_head *result;
 	unsigned long map_nr_entries;
+	unsigned long lost;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.37.1.455.g008518b4e5-goog

