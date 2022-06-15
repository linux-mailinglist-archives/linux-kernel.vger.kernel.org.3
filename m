Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3454CEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356639AbiFOQc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356085AbiFOQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F22CC0;
        Wed, 15 Jun 2022 09:32:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z17so11904985pff.7;
        Wed, 15 Jun 2022 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SkyHaY2ESEPTAByhn+IX0xpGHJKHXbmPFnrcF1ASi0=;
        b=lCT+U+Qf8LYIoflC2zGpkmB3Y97bo/boDaQ3TaXkc1vxGNJ4MFUfER6NetrVzbt1BI
         v+Vjpt4hNGWomAMvhzBwmiFGJYwXezL/ZVMULKtUlTHzScprp4gYqVXmJYJBa5uATn1y
         2tTd7hHu2CfLilToJHN70ujht/yUt3+Cd5UGY7LyEpQ5/5+ytEf3ncoNSCdjfnbFSBAl
         PDN9lyyk55wH3UPuGMpR/dLPEbyj3nA9NvkDsKJnx/c3PLVtBxFI8SvyjOKTghxYHIb1
         XGwGdmi8ANsRSVgrsF608bqhtMeKuHNfst8McG26DdrMzIhVSbimDX2X+5yRFkt0ET+r
         Jj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8SkyHaY2ESEPTAByhn+IX0xpGHJKHXbmPFnrcF1ASi0=;
        b=HnIs1WnBzi21DH2OqXkmaFul73jfw8JYJfddWQW/Osus5r4n3WIfoPv1Oyx1dau9d4
         OpeRvELjaRl4Lx2DHND/9C0y3HDA+w7lOyooL0hIiuzg4vFX7BoevUnuzkzkiBPAERZR
         +CpXnb2fBcTtJCxa2aJg15gW2ixIlpTqdMe7/ckedJtqiZWwtgkRushbHs0bJuBUuZ1+
         4Z13vQscxxuljre0yAVgON4svdELjLFEVN8HGZh4YPSnpUi/O/xwz0fwBy2EM5d+eiR3
         FyF+zORovwgWypH61ESGYhz3UU6xz0mhuv0e8mOI/4bLq2qYy+eN1QXRTjEmDbNDaWrK
         MHtg==
X-Gm-Message-State: AJIora+dYntTZpcmylgXw9ZH91551mBJDuOaLiX+qdn6SCZTjFZ3Ci7/
        mJfijAhwhhSehcTJUaOu2KTY4Tet8bgrag==
X-Google-Smtp-Source: AGRyM1teZ2alxYJQMbnnnMcxDdFWU6Nu9XInUyvXwwU61qLTE/qb+sdNDlTpHDwP4a/CRvuBp3HAiQ==
X-Received: by 2002:a05:6a00:15c6:b0:51c:61bb:a62d with SMTP id o6-20020a056a0015c600b0051c61bba62dmr444558pfu.30.1655310752521;
        Wed, 15 Jun 2022 09:32:32 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:32 -0700 (PDT)
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 5/7] perf lock: Handle lock contention tracepoints
Date:   Wed, 15 Jun 2022 09:32:20 -0700
Message-Id: <20220615163222.1275500-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the lock contention events are used, there's no tracking of
acquire and release.  So the state machine is simplified to use
UNINITIALIZED -> CONTENDED -> ACQUIRED only.

Note that CONTENDED state is re-entrant since mutex locks can hit two
or more consecutive contention_begin events for optimistic spinning
and sleep.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 137 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 9e3b90cac505..546dad1963c8 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -483,6 +483,18 @@ static struct lock_stat *pop_from_result(void)
 	return container_of(node, struct lock_stat, rb);
 }
 
+static struct lock_stat *lock_stat_find(u64 addr)
+{
+	struct hlist_head *entry = lockhashentry(addr);
+	struct lock_stat *ret;
+
+	hlist_for_each_entry(ret, entry, hash_entry) {
+		if (ret->addr == addr)
+			return ret;
+	}
+	return NULL;
+}
+
 static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
 {
 	struct hlist_head *entry = lockhashentry(addr);
@@ -827,6 +839,124 @@ static int report_lock_release_event(struct evsel *evsel,
 	return 0;
 }
 
+static int report_lock_contention_begin_event(struct evsel *evsel,
+					      struct perf_sample *sample)
+{
+	struct lock_stat *ls;
+	struct thread_stat *ts;
+	struct lock_seq_stat *seq;
+	u64 addr = evsel__intval(evsel, sample, "lock_addr");
+
+	if (show_thread_stats)
+		addr = sample->tid;
+
+	ls = lock_stat_findnew(addr, "No name");
+	if (!ls)
+		return -ENOMEM;
+
+	ts = thread_stat_findnew(sample->tid);
+	if (!ts)
+		return -ENOMEM;
+
+	seq = get_seq(ts, addr);
+	if (!seq)
+		return -ENOMEM;
+
+	switch (seq->state) {
+	case SEQ_STATE_UNINITIALIZED:
+	case SEQ_STATE_ACQUIRED:
+		break;
+	case SEQ_STATE_CONTENDED:
+		/*
+		 * It can have nested contention begin with mutex spinning,
+		 * then we would use the original contention begin event and
+		 * ignore the second one.
+		 */
+		goto end;
+	case SEQ_STATE_ACQUIRING:
+	case SEQ_STATE_READ_ACQUIRED:
+	case SEQ_STATE_RELEASED:
+		/* broken lock sequence */
+		if (!ls->broken) {
+			ls->broken = 1;
+			bad_hist[BROKEN_CONTENDED]++;
+		}
+		list_del_init(&seq->list);
+		free(seq);
+		goto end;
+	default:
+		BUG_ON("Unknown state of lock sequence found!\n");
+		break;
+	}
+
+	if (seq->state != SEQ_STATE_CONTENDED) {
+		seq->state = SEQ_STATE_CONTENDED;
+		seq->prev_event_time = sample->time;
+		ls->nr_contended++;
+	}
+end:
+	return 0;
+}
+
+static int report_lock_contention_end_event(struct evsel *evsel,
+					    struct perf_sample *sample)
+{
+	struct lock_stat *ls;
+	struct thread_stat *ts;
+	struct lock_seq_stat *seq;
+	u64 contended_term;
+	u64 addr = evsel__intval(evsel, sample, "lock_addr");
+
+	if (show_thread_stats)
+		addr = sample->tid;
+
+	ls = lock_stat_find(addr);
+	if (!ls)
+		return 0;
+
+	ts = thread_stat_find(sample->tid);
+	if (!ts)
+		return 0;
+
+	seq = get_seq(ts, addr);
+	if (!seq)
+		return -ENOMEM;
+
+	switch (seq->state) {
+	case SEQ_STATE_UNINITIALIZED:
+		goto end;
+	case SEQ_STATE_CONTENDED:
+		contended_term = sample->time - seq->prev_event_time;
+		ls->wait_time_total += contended_term;
+		if (contended_term < ls->wait_time_min)
+			ls->wait_time_min = contended_term;
+		if (ls->wait_time_max < contended_term)
+			ls->wait_time_max = contended_term;
+		break;
+	case SEQ_STATE_ACQUIRING:
+	case SEQ_STATE_ACQUIRED:
+	case SEQ_STATE_READ_ACQUIRED:
+	case SEQ_STATE_RELEASED:
+		/* broken lock sequence */
+		if (!ls->broken) {
+			ls->broken = 1;
+			bad_hist[BROKEN_ACQUIRED]++;
+		}
+		list_del_init(&seq->list);
+		free(seq);
+		goto end;
+	default:
+		BUG_ON("Unknown state of lock sequence found!\n");
+		break;
+	}
+
+	seq->state = SEQ_STATE_ACQUIRED;
+	ls->nr_acquired++;
+	ls->avg_wait_time = ls->wait_time_total/ls->nr_acquired;
+end:
+	return 0;
+}
+
 /* lock oriented handlers */
 /* TODO: handlers for CPU oriented, thread oriented */
 static struct trace_lock_handler report_lock_ops  = {
@@ -834,6 +964,8 @@ static struct trace_lock_handler report_lock_ops  = {
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
 	.release_event		= report_lock_release_event,
+	.contention_begin_event	= report_lock_contention_begin_event,
+	.contention_end_event	= report_lock_contention_end_event,
 };
 
 static struct trace_lock_handler *trace_handler;
@@ -1126,6 +1258,11 @@ static int __cmd_report(bool display_info)
 		goto out_delete;
 	}
 
+	if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
+		pr_err("Initializing perf session tracepoint handlers failed\n");
+		goto out_delete;
+	}
+
 	if (setup_output_field(output_fields))
 		goto out_delete;
 
-- 
2.36.1.476.g0c4daa206d-goog

