Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FAF54435F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiFIF5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbiFIF5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:57:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4862CE27;
        Wed,  8 Jun 2022 22:57:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c196so20228028pfb.1;
        Wed, 08 Jun 2022 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DB/q3LbGIH2sCkq4UxdF4IbkyINeo0jgyAU9j8AQqfQ=;
        b=DN99daR+lbGinfbUQ65qKxXxZGv/ebltW69xe2onBUFEHDBLnYsDOHYDojWvFIZ9Os
         0pm7zmbKdMDquwyQ5y2JStPl8B81tZEZrOya+paoQTSVe1/EUBCbSa26j0MQFZyY7XcV
         4KdYgrM5T+n8KJ24abNKQoix5vPdVRsY1qo2Ak03pxvhL/RfCDAUVWYnA2gw80E0XjYf
         9iIJ8TrXYUR2TPy60o/Rmj6AMkt0bqOvlln5r21SdJZX5Q/ZJsv8tgX9cyZrhrWFOfCW
         PXgU/SnRygM61KCR9FH+y/jXHVfUdr6xNSGy3sBzth/35FUdrW/FELhsW9x/qjMl8coa
         JvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DB/q3LbGIH2sCkq4UxdF4IbkyINeo0jgyAU9j8AQqfQ=;
        b=FbzAD345mjmMoct6fsfAJqusoAvoZb/NeRBcgB8nevJO+Z3t6I10WyfHsTE+g/skce
         Nm4fIMHXhssOyROb2lIpbAaWjMosW0p3jbDy6wBjLD/r44WXKgTomYNu6P3xChoBVwTf
         AafAL6J5oTe7sgEcMuAvpAYfNLeIDMbfQ5lbF9k3W5IIa5s4G+dCOIu+yp+g0OVQTGRK
         e99sNRl3KIiR959QMy9RAam/46L5FnopIkKr/h34NqDRQ9n1vzUu7IzExRp2JkTTU3H7
         v3/+KCICuyYHu2tWX21ghThyN+eMPvlyVyhhvikqy7IIYCfve/h13KBGh8OcEsU9XJm/
         bQkg==
X-Gm-Message-State: AOAM530qzhFcCz8jQRpAX7q8sJ1+EA5BqzgDiqXidLP0TNx9yKP20m1S
        EXIELKIeeeKoYqupU9w5sUK56J0qTJOeHA==
X-Google-Smtp-Source: ABdhPJyvKKEye6Vw5jfKi/ukcUK1IGHuku+ZkMT7WpwZQaQ/1hpTg4JAuHjsys3/OkO0ZWgmzSkzXw==
X-Received: by 2002:a05:6a00:b8c:b0:51c:2d3d:4595 with SMTP id g12-20020a056a000b8c00b0051c2d3d4595mr15346276pfj.80.1654754219742;
        Wed, 08 Jun 2022 22:56:59 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:2c32:ceaf:ea06:c5de])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm9502413plk.275.2022.06.08.22.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:56:59 -0700 (PDT)
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
Date:   Wed,  8 Jun 2022 22:56:50 -0700
Message-Id: <20220609055652.938821-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609055652.938821-1-namhyung@kernel.org>
References: <20220609055652.938821-1-namhyung@kernel.org>
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
 tools/perf/builtin-lock.c | 125 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7df182a8443b..a677ad9507c3 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -825,6 +825,124 @@ static int report_lock_release_event(struct evsel *evsel,
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
@@ -832,6 +950,8 @@ static struct trace_lock_handler report_lock_ops  = {
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
 	.release_event		= report_lock_release_event,
+	.contention_begin_event	= report_lock_contention_begin_event,
+	.contention_end_event	= report_lock_contention_end_event,
 };
 
 static struct trace_lock_handler *trace_handler;
@@ -1124,6 +1244,11 @@ static int __cmd_report(bool display_info)
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

