Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7652F743
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 03:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354219AbiEUBIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 21:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiEUBIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 21:08:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B81B1B12D6;
        Fri, 20 May 2022 18:08:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so9128725pju.1;
        Fri, 20 May 2022 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4mgoDrWxo42eBfft8ncnh+AJSzD9PYMfFpRcofRE/k=;
        b=ieYdMSDH4Oblqqadr2jCLwIDfWlQi+KtrJ9Gulsy4BYlS65lFaLpwEL5vK7v0xsx6m
         3eH1/u1umnsdABSlBhfKcTx/VD87YVwNua0vHwR7iCIuzr5S45TeTRJkAJqX8kdoKSLr
         G5iiLzX4SeXGtj+4VQiw+rNIbTrWLg5NRQ0LvTZ9avkD1QphPuV7oC8tEgu2GPp5u0X1
         o+a+Y2CdXVqKd6Rihepeg/vp5vPnck9y8XscX0NzdjRW3OfMvYLsNilapoCqEs7oCpFy
         wARgr8p7SpalTM98ZDYd4DaA/rIu3EV///+NL8HpHTLvk1iWwK9ly+Bjsm9k55EWuLdP
         PdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H4mgoDrWxo42eBfft8ncnh+AJSzD9PYMfFpRcofRE/k=;
        b=u4gEJ657Gn6vVmjFt2CXSHutl+NCAtwR5S0r59GBuRfbNB55dX7+ryhAOtHwx0Ff03
         RzY5RtO5pRYeQlVGIfo3tF4gZx6OrJvcKNalzQ8pFpFrzXv6LV4yLJ1jBlJTvjZOGXsN
         LlWPNS5aT5cwD6vx27iDBu9KdQ2c6krjq0nWqKYgNOiJBGj4KcM+Zyjv8hBiuwxe+A4j
         TXvDZldKA9fJTaLiVydeu+or3FCt5rwd8U6o4z1G+DNxmFrrx5Bo30aZYZVngAqD1bYt
         FvECPqvafNNdLmvBnQV8x343v9VGQaLRZR1FLe0u0nf1Zq5EnME5zeZJXO9aKoTaFTln
         1VRQ==
X-Gm-Message-State: AOAM531Hn6Shix/R28s/IfoGeyXCWZnFTUa7LNtcHUN760vzbbIZJ3+4
        Iuamx3pdUKRFhmYVhbw6j5/3MIciZYg=
X-Google-Smtp-Source: ABdhPJx2HFj/Hx2l24iuU8Xttqf6/UGDOaBAIgZIMOsoJyB0NosLB05rik0rcCC0kBWDOCAdXSBX7w==
X-Received: by 2002:a17:902:ebc8:b0:15f:417c:288b with SMTP id p8-20020a170902ebc800b0015f417c288bmr12477038plg.14.1653095293907;
        Fri, 20 May 2022 18:08:13 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:9d03:75a4:742c:9d77])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b0015e8d4eb2d1sm313025pln.283.2022.05.20.18.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 18:08:13 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf lock: Add -t/--thread option for report
Date:   Fri, 20 May 2022 18:08:11 -0700
Message-Id: <20220521010811.932703-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220521010811.932703-1-namhyung@kernel.org>
References: <20220521010811.932703-1-namhyung@kernel.org>
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

The -t option is to show per-thread lock stat like below:

  $ perf lock report -t -F acquired,contended,avg_wait

                Name   acquired  contended   avg wait (ns)

                perf     240569          9            5784
             swapper     106610         19             543
              :15789      17370          2           14538
        ContainerMgr       8981          6             874
               sleep       5275          1           11281
     ContainerThread       4416          4             944
     RootPressureThr       3215          5            1215
         rcu_preempt       2954          0               0
        ContainerMgr       2560          0               0
             unnamed       1873          0               0
     EventManager_De       1845          1             636
     futex-default-S       1609          0               0
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7ceb12e30719..b1200b7340a6 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -118,6 +118,7 @@ struct thread_stat {
 static struct rb_root		thread_stats;
 
 static bool combine_locks;
+static bool show_thread_stats;
 
 static struct thread_stat *thread_stat_find(u32 tid)
 {
@@ -542,6 +543,10 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 	int flag = evsel__intval(evsel, sample, "flags");
 
+	/* abuse ls->addr for tid */
+	if (show_thread_stats)
+		addr = sample->tid;
+
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
@@ -611,6 +616,9 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 
+	if (show_thread_stats)
+		addr = sample->tid;
+
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
@@ -670,6 +678,9 @@ static int report_lock_contended_event(struct evsel *evsel,
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 
+	if (show_thread_stats)
+		addr = sample->tid;
+
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
@@ -722,6 +733,9 @@ static int report_lock_release_event(struct evsel *evsel,
 	const char *name = evsel__strval(evsel, sample, "name");
 	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 
+	if (show_thread_stats)
+		addr = sample->tid;
+
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
@@ -848,7 +862,17 @@ static void print_result(void)
 
 		if (strlen(st->name) < 20) {
 			/* output raw name */
-			pr_info("%20s ", st->name);
+			const char *name = st->name;
+
+			if (show_thread_stats) {
+				struct thread *t;
+
+				/* st->addr contains tid of thread */
+				t = perf_session__findnew(session, st->addr);
+				name = thread__comm_str(t);
+			}
+
+			pr_info("%20s ", name);
 		} else {
 			strncpy(cut_name, st->name, 16);
 			cut_name[16] = '.';
@@ -1125,6 +1149,8 @@ int cmd_lock(int argc, const char **argv)
 	/* TODO: type */
 	OPT_BOOLEAN('c', "combine-locks", &combine_locks,
 		    "combine locks in the same class"),
+	OPT_BOOLEAN('t', "threads", &show_thread_stats,
+		    "show per-thread lock stats"),
 	OPT_PARENT(lock_options)
 	};
 
-- 
2.36.1.124.g0e6072fb45-goog

