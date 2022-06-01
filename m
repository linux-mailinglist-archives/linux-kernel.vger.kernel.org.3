Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D23539DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350090AbiFAG7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350062AbiFAG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:58:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA028E3B;
        Tue, 31 May 2022 23:58:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so2117652pjm.2;
        Tue, 31 May 2022 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SvywXQR5u5eLQGrEXYtQtLKz9fPRbHwv8WFahECd0Ho=;
        b=hkDgB0dJd0jTool2E/W8gSNApqM2U1u6+6qzuJZYb9UrwhA6Zi8xafBaQRpUBaooU9
         Ez7RG9iNn8lQ82KuwwYhZ1d6gsofDIbQCbJkeZhXiNHmv5Zh02aSrjHQwwPDXUpEeEjM
         z1olgHARgw/jDezZCboiN8GY/hItvXKJ+iw/gac1kWET37FWoFFwgTjKuziov4Osf/89
         Ch8aOzfzisSLCGx2Xr/Zv2eaQ8mctpaTylw5q372TmyKCHShwBW/zX2S0Gwydnu01jmw
         MQGYPlPkGTmLMdvCKaCb/ufr8s3m7WrpTx6jaY40yaWJwda6riOb+nrapsHPrJtO/c6i
         3SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SvywXQR5u5eLQGrEXYtQtLKz9fPRbHwv8WFahECd0Ho=;
        b=LfljWEnry0324OSrPBGKa2pbQBrffadw/Cw+iF2nZxAlJYY23dPKhpvieysXjX2Dxr
         KG1WUGNyF2FD0tL5UgJV5Yj9wa1RBWTU1gQREe5f3PhVZK1aJxhUD8+3YsKNKj0fyI7H
         saDOF+FufxgxHiDbYMDnTHSCoK7K6RBeHRd8tDuY1VQRYu2KIViGJHrN3br2m4Zb5/2H
         Me1tInl2PwxmZBPjiXmhaa00JSTmQssnNKi7ejl6PAomnVmCZfUzuK8al7OX3Wvz7JJr
         1z3QiFSwQhdVVMLEHUoTH5d88d22U0aZvlptNjuqC7xK3YTTO4m7ldebgu08RLbteV9W
         xjoA==
X-Gm-Message-State: AOAM533obb4/sUmnYBU+plaPA2Lg42eYLDZMvAWgM+bVjI24e/y6XMuh
        Ss/3KbRp/K3t0Qg4tpK/6KA=
X-Google-Smtp-Source: ABdhPJyZB9sm5lrcSl295Dxrb8f0ukTuAPEaDSCKWRoknHi9p8ouSHE+ejWaWRXQ0EiwNuGrS6lYlw==
X-Received: by 2002:a17:903:1c8:b0:165:1395:dcb3 with SMTP id e8-20020a17090301c800b001651395dcb3mr1836834plh.76.1654066732590;
        Tue, 31 May 2022 23:58:52 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:82d7:adf7:b62d:6020])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a5a0a00b001cd4989febcsm3207271pjd.8.2022.05.31.23.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:58:52 -0700 (PDT)
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
Subject: [PATCH 3/5] perf lock: Handle lock contention tracepoints
Date:   Tue, 31 May 2022 23:58:44 -0700
Message-Id: <20220601065846.456965-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601065846.456965-1-namhyung@kernel.org>
References: <20220601065846.456965-1-namhyung@kernel.org>
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

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 125 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 3e3320b8cede..82cbf0f2e4cd 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -789,6 +789,124 @@ static int report_lock_release_event(struct evsel *evsel,
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
@@ -796,6 +914,8 @@ static struct trace_lock_handler report_lock_ops  = {
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
 	.release_event		= report_lock_release_event,
+	.contention_begin_event	= report_lock_contention_begin_event,
+	.contention_end_event	= report_lock_contention_end_event,
 };
 
 static struct trace_lock_handler *trace_handler;
@@ -1081,6 +1201,11 @@ static int __cmd_report(bool display_info)
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
2.36.1.255.ge46751e96f-goog

