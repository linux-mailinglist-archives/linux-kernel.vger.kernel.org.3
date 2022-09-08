Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894DC5B29B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIHWzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiIHWzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:55:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283D546D92;
        Thu,  8 Sep 2022 15:54:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so3692376pja.4;
        Thu, 08 Sep 2022 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=yE7asha12oJsClX0486fIbY+2Edin8Oonu/08W/7mO8=;
        b=CB9vVS7z4+/o8MAGSCW+yJLd6RtJMem+QqxTC3yBjfHrjlmi7vmvaktB0nM5COE5aV
         t6v0OFtjfe0i42iOY1mFVHZUWc73r07Kzdoq0cDlpo6WdwGquGaqJtXjiCtRX7dh232z
         qgfLA/KmIC0kAuaE73PUM8dRKtbYG3yw5hf+L9HhmtqL+ev/QNvEAI42qH35lDCze4zA
         3FwN9hpqPON/QK6qtDvTI1XSKSRrUubdKV7fd0IdeMMXyWam9kkdRD8ZUMnV43qjRGrK
         s7MLcwisVm8H1mCie+55X7vVZtAHVjunAdGW8mePexWjyWSqnhLf3LF9ggxj3uWaEAu+
         dkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=yE7asha12oJsClX0486fIbY+2Edin8Oonu/08W/7mO8=;
        b=FXDqWdQl5bRZktvQoxPBvS7pLGJrodcqwFo1F+w3mj1rVO8fI4lmfTClP8JUrLBFw8
         kaVrvYT2DOKtenq8DhMA4nJSXi+U0KabmKCrpKmNYYUx9J2JRZ3Lbq/1vMaWvGz9iX+n
         3gf4In+iNAX0xQcWZ507SIcAkaE1mwFOfADtjt5oxy2Z4sBDjKek+5rp4oWJeUSYnj8z
         3QpkJt5lCK7Z46XlMqIWHecCzoFRXge40V6N+Z5P10s+iEdClOyYRXOSt7d0xRk/yGMs
         Tyj1mGkpR5BLA6xWkBpyG+aq9Ul8QNzLp5lT1PcjbscBQHTDI5HuSYKEkBIBULYNlppA
         b1Sw==
X-Gm-Message-State: ACgBeo0LFb+aOjTBCsu1taK8Tv1YFrApW4pCu4WOgMlMzWNQONnc33IY
        n4DZJGjjWtYv3iVKkDZxwsA=
X-Google-Smtp-Source: AA6agR73UH55jDdKQhuSB9N7O3ScSi2cCP4wOvanQgCyw9jjYsRB4I6hR9EZLuf3URAsrGrTktQDcA==
X-Received: by 2002:a17:90b:2807:b0:1fd:ea9f:5a89 with SMTP id qb7-20020a17090b280700b001fdea9f5a89mr6538755pjb.52.1662677691865;
        Thu, 08 Sep 2022 15:54:51 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0017440342b5bsm38752plp.206.2022.09.08.15.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:54:51 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf sched: Factor out destroy_tasks()
Date:   Thu,  8 Sep 2022 15:54:48 -0700
Message-Id: <20220908225448.4105056-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

Add destroy_tasks() as a counterpart of create_tasks() and put the
thread safety notations there.  After join, it destroys semaphores too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index a92610eac4bf..f93737eef07b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -690,6 +690,27 @@ static void create_tasks(struct perf_sched *sched)
 	}
 }
 
+static void destroy_tasks(struct perf_sched *sched)
+	UNLOCK_FUNCTION(sched->start_work_mutex)
+	UNLOCK_FUNCTION(sched->work_done_wait_mutex)
+{
+	struct task_desc *task;
+	unsigned long i;
+	int err;
+
+	mutex_unlock(&sched->start_work_mutex);
+	mutex_unlock(&sched->work_done_wait_mutex);
+	/* Get rid of threads so they won't be upset by mutex destrunction */
+	for (i = 0; i < sched->nr_tasks; i++) {
+		task = sched->tasks[i];
+		err = pthread_join(task->thread, NULL);
+		BUG_ON(err);
+		sem_destroy(&task->sleep_sem);
+		sem_destroy(&task->ready_for_work);
+		sem_destroy(&task->work_done_sem);
+	}
+}
+
 static void wait_for_tasks(struct perf_sched *sched)
 	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
 	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
@@ -3324,8 +3345,7 @@ static int perf_sched__replay(struct perf_sched *sched)
 		run_one_test(sched);
 
 	sched->thread_funcs_exit = true;
-	mutex_unlock(&sched->start_work_mutex);
-	mutex_unlock(&sched->work_done_wait_mutex);
+	destroy_tasks(sched);
 	return 0;
 }
 
-- 
2.37.2.789.g6183377224-goog

