Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0547A580407
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiGYSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiGYSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:31:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BDC1F603;
        Mon, 25 Jul 2022 11:31:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d3so3308151pls.4;
        Mon, 25 Jul 2022 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JEJHCLbm9FaoQqQc3eYhH6ECpaTcGd/ZHTn5iTyFnE=;
        b=QxQ2mw6eAwh/HwShZr7aNJe8815zquepBSuCxSvmLwAY3A4t1M3gNVPMoUz+ftfGwy
         tD1U+Br9F29yQrOZVUp2BF6lqNVFDYWOKjD8YaoZv6cPIL9YhIURqy9yKV6yZK6HEDw+
         7T80zZgEVB2K/xW/RixITGAaS1zr1qbvdvvNWpskpDQivkE/BmrK08xFslaorhLoPh2B
         NBduWMIUyZTh1zz86FHIV943Lu4P3shUCVsq5hIfYCzzVb08eJfp7m4Blmk4DITzWmRI
         SC0CH30qGHKU88VhZ35BjuGgQ1y6l5pQgMn4+GMagyYazaq3wOUz1Zg7SqmghjQbmRUc
         IGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8JEJHCLbm9FaoQqQc3eYhH6ECpaTcGd/ZHTn5iTyFnE=;
        b=cSWQQlQmBV151taQ3ZdZjtRkujFrU4/pYgEhvLeDInkHluI1TG7LLgdyUIOgOIi5iO
         ND3Bc2VAn5qALNVvfGKnmDDjQq4oYeVpIF0ON6QAToYy35DSKqKILZrDqJByKcqnWsTJ
         R+9CHLq3QedQ64A3+6rBPBltN34pVVBNmavKihxP0LndU96PHD5ffxANjpRWq+60ITDM
         ixPVtkUFwHjoZkAUWoNc35KFwP6zym7QgCjHNo4rU1waNfWEAs6euyz1AQzM83TUgRyq
         LUqcGXSHlxZ6ACjzkLeqR/YYYwswLpugTDc3S3V5YTRYp9SSMRyzb540TYVUVNsMFzp9
         cv9w==
X-Gm-Message-State: AJIora9PiJd+6etAtgHGIBuZ9i2epMIIBV2KXG//rbXWzCYVIaDBIahQ
        a16X16gR7lpCMiqcqRpBNF0=
X-Google-Smtp-Source: AGRyM1uRqKPKR1yNB/cQKqza6gj0fWAzLCl4qBI5fzjdU2/Mf5K0J2RoaYH29+HM/MqhzvOVxd6DAQ==
X-Received: by 2002:a17:902:a586:b0:16b:e787:53f8 with SMTP id az6-20020a170902a58600b0016be78753f8mr13392534plb.163.1658773894352;
        Mon, 25 Jul 2022 11:31:34 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:2c4d:e9cd:d086:4d46])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016be9d498d0sm9740556plh.211.2022.07.25.11.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:31:33 -0700 (PDT)
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
Subject: [PATCH 5/5] perf lock: Support -t option for 'contention' subcommand
Date:   Mon, 25 Jul 2022 11:31:24 -0700
Message-Id: <20220725183124.368304-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220725183124.368304-1-namhyung@kernel.org>
References: <20220725183124.368304-1-namhyung@kernel.org>
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

Like perf lock report, it can report lock contention stat of each task.

  $ perf lock contention -t
   contended   total wait     max wait     avg wait          pid   comm

           5    945.20 us    902.08 us    189.04 us       316167   EventManager_De
          33     98.17 us      6.78 us      2.97 us       766063   kworker/0:1-get
           7     92.47 us     61.26 us     13.21 us       316170   EventManager_De
          14     76.31 us     12.87 us      5.45 us        12949   timedcall
          24     76.15 us     12.27 us      3.17 us       767992   sched-pipe
          15     75.62 us     11.93 us      5.04 us        15127   switchto-defaul
          24     71.84 us      5.59 us      2.99 us       629168   kworker/u513:2-
          17     67.41 us      7.94 us      3.96 us        13504   coroner-
           1     59.56 us     59.56 us     59.56 us       316165   EventManager_De
          14     56.21 us      6.89 us      4.01 us            0   swapper

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  4 ++++
 tools/perf/builtin-lock.c              | 22 ++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index ae78e04346bd..8f4e34f924d5 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -119,6 +119,10 @@ CONTENTION OPTIONS
 	and users can customize that using this.  Possible values:
 	contended, wait_total, wait_max, wait_min, avg_wait.
 
+-t::
+--threads::
+	Show per-thread lock contention stat
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index ad3b191db2e7..041801d8b6ac 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1560,7 +1560,10 @@ static void print_contention_result(void)
 	list_for_each_entry(key, &lock_keys, list)
 		pr_info("%*s ", key->len, key->header);
 
-	pr_info("  %10s   %s\n\n", "type", "caller");
+	if (show_thread_stats)
+		pr_info("  %10s   %s\n\n", "pid", "comm");
+	else
+		pr_info("  %10s   %s\n\n", "type", "caller");
 
 	bad = total = 0;
 	while ((st = pop_from_result())) {
@@ -1573,6 +1576,16 @@ static void print_contention_result(void)
 			pr_info(" ");
 		}
 
+		if (show_thread_stats) {
+			struct thread *t;
+			int pid = st->addr;
+
+			/* st->addr contains tid of thread */
+			t = perf_session__findnew(session, pid);
+			pr_info("  %10d   %s\n", pid, thread__comm_str(t));
+			continue;
+		}
+
 		pr_info("  %10s   %s\n", get_type_str(st), st->name);
 	}
 
@@ -1703,7 +1716,10 @@ static int __cmd_contention(void)
 	if (select_key(true))
 		goto out_delete;
 
-	aggr_mode = LOCK_AGGR_CALLER;
+	if (show_thread_stats)
+		aggr_mode = LOCK_AGGR_TASK;
+	else
+		aggr_mode = LOCK_AGGR_CALLER;
 
 	err = perf_session__process_events(session);
 	if (err)
@@ -1843,6 +1859,8 @@ int cmd_lock(int argc, const char **argv)
 		    "key for sorting (contended / wait_total / wait_max / wait_min / avg_wait)"),
 	OPT_STRING('F', "field", &output_fields, "contended,wait_total,wait_max,avg_wait",
 		    "output fields (contended / wait_total / wait_max / wait_min / avg_wait)"),
+	OPT_BOOLEAN('t', "threads", &show_thread_stats,
+		    "show per-thread lock stats"),
 	OPT_PARENT(lock_options)
 	};
 
-- 
2.37.1.359.gd136c6c3e2-goog

