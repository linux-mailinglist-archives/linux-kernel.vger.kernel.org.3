Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73857C392
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiGUEhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiGUEhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:37:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6554478DDE;
        Wed, 20 Jul 2022 21:37:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 72so622643pge.0;
        Wed, 20 Jul 2022 21:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/4XRRED8YKZQ7Xs4jvt7+uAqyncKJn/fVF0nQfTeZA=;
        b=iurPgdZ0+GIB8Z4hJC5ehu/0sGF6lCm/sJ6Vkp6rndQT96J93gyjgDo/T/4fvyd97v
         C+gkfmyhqvUc+jW7+ny/rwEUcLcI43s6+0lkvEVJT+4mXjwmKHWOHVKk9+PiL1Ag1WhG
         wP/fd6P26En5A9T4NxgkgM5tD5zn4aL1AWEb/RaUdbTmFJXKIJQw2KwXGXqyb/IQjqKm
         ILrEXCM49Khl6S3jGdrUNSnZe4g/oLBBhXrzco5DAQ2rIUxIHYsGnBDxW/lNhXK4BzNo
         iBPN+DIGIqS6Vv3AhH5/vBNSoAflFdsCpCvFNtozXLa88VCT2d+24FgqoLfrZtOWnW+4
         FIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=n/4XRRED8YKZQ7Xs4jvt7+uAqyncKJn/fVF0nQfTeZA=;
        b=jOok7DIWUlk7du89r83LkRq6JQAxmMCfeDvOibAoU25sQ59Yk3g9Ka3O4b8QBzUKSa
         r1BP9Tm3PAVvEa/pJSuxSEi9v8feUfNeFJTwYbjK4qAnJUU5+WzXs2BoxpOIu2At/di1
         1kdsMyyq55AFylDrXHBjOwCHlGzQLmizMbnJ1aMF/+3TBpkM1F//fXnhIIZMliboE7CD
         TQMs9WBJbIVV+mqbGVvMjP5u6a7vsWkmmx/jowlE/K7+lT0QYvJqc4fL0qwjCmcolRN5
         fuiQe1mJq4PBQcSh6b6iT7SYmAvBb83iBrsWMqCq3zOMY+VCs+zMlmfy4blkIt5NDAjA
         HlyA==
X-Gm-Message-State: AJIora9+ox0WNiE4e2Jw/33Jl35jsAUe+cKnSZUTVWVF+V47AfpXbvNC
        JWmOBxNX/YePoAXBy4KngCY=
X-Google-Smtp-Source: AGRyM1uB88GhGqYLgFUhRv95rNl4fIljsyNCwXIFX3fqjUjqtBAYTW0fkslhIBBJBZUDNgXv3j5udw==
X-Received: by 2002:a63:1b22:0:b0:411:9b47:f6bf with SMTP id b34-20020a631b22000000b004119b47f6bfmr36293434pgb.200.1658378219450;
        Wed, 20 Jul 2022 21:36:59 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:467:a1e4:c167:53fd:8047:7f62])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0016bea2a0a8dsm450824pla.91.2022.07.20.21.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:36:59 -0700 (PDT)
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
Subject: [PATCH 5/6] perf lock: Add -k and -F options to 'contention' subcommand
Date:   Wed, 20 Jul 2022 21:36:43 -0700
Message-Id: <20220721043644.153718-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721043644.153718-1-namhyung@kernel.org>
References: <20220721043644.153718-1-namhyung@kernel.org>
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

Like perf lock report, add -k/--key and -F/--field options to control
output formatting and sorting.  Note that it has slightly different
default options as some fields are not available and to optimize the
screen space.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt | 15 ++++++++
 tools/perf/builtin-lock.c              | 51 ++++++++++++++++++++------
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index da0bcbc676a3..ae78e04346bd 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -105,6 +105,21 @@ INFO OPTIONS
 --map::
 	dump map of lock instances (address:name table)
 
+CONTENTION OPTIONS
+--------------
+
+-k::
+--key=<value>::
+	Sorting key. Possible values: contended, wait_total (default),
+	wait_max, wait_min, avg_wait.
+
+-F::
+--field=<value>::
+	Output fields. By default it shows all but the wait_min fields
+	and users can customize that using this.  Possible values:
+	contended, wait_total, wait_max, wait_min, avg_wait.
+
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 64f635273660..ad3b191db2e7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -362,7 +362,7 @@ static const char		*output_fields;
 
 #define DEF_KEY_LOCK(name, header, fn_suffix, len)			\
 	{ #name, header, len, lock_stat_key_ ## fn_suffix, lock_stat_key_print_ ## fn_suffix, {} }
-struct lock_key keys[] = {
+static struct lock_key report_keys[] = {
 	DEF_KEY_LOCK(acquired, "acquired", nr_acquired, 10),
 	DEF_KEY_LOCK(contended, "contended", nr_contended, 10),
 	DEF_KEY_LOCK(avg_wait, "avg wait", avg_wait_time, 12),
@@ -374,9 +374,24 @@ struct lock_key keys[] = {
 	{ }
 };
 
-static int select_key(void)
+static struct lock_key contention_keys[] = {
+	DEF_KEY_LOCK(contended, "contended", nr_contended, 10),
+	DEF_KEY_LOCK(wait_total, "total wait", wait_time_total, 12),
+	DEF_KEY_LOCK(wait_max, "max wait", wait_time_max, 12),
+	DEF_KEY_LOCK(wait_min, "min wait", wait_time_min, 12),
+	DEF_KEY_LOCK(avg_wait, "avg wait", avg_wait_time, 12),
+
+	/* extra comparisons much complicated should be here */
+	{ }
+};
+
+static int select_key(bool contention)
 {
 	int i;
+	struct lock_key *keys = report_keys;
+
+	if (contention)
+		keys = contention_keys;
 
 	for (i = 0; keys[i].name; i++) {
 		if (!strcmp(keys[i].name, sort_key)) {
@@ -394,9 +409,13 @@ static int select_key(void)
 	return -1;
 }
 
-static int add_output_field(struct list_head *head, char *name)
+static int add_output_field(bool contention, char *name)
 {
 	int i;
+	struct lock_key *keys = report_keys;
+
+	if (contention)
+		keys = contention_keys;
 
 	for (i = 0; keys[i].name; i++) {
 		if (strcmp(keys[i].name, name))
@@ -404,7 +423,7 @@ static int add_output_field(struct list_head *head, char *name)
 
 		/* prevent double link */
 		if (list_empty(&keys[i].list))
-			list_add_tail(&keys[i].list, head);
+			list_add_tail(&keys[i].list, &lock_keys);
 
 		return 0;
 	}
@@ -413,10 +432,14 @@ static int add_output_field(struct list_head *head, char *name)
 	return -1;
 }
 
-static int setup_output_field(const char *str)
+static int setup_output_field(bool contention, const char *str)
 {
 	char *tok, *tmp, *orig;
 	int i, ret = 0;
+	struct lock_key *keys = report_keys;
+
+	if (contention)
+		keys = contention_keys;
 
 	/* no output field given: use all of them */
 	if (str == NULL) {
@@ -433,7 +456,7 @@ static int setup_output_field(const char *str)
 		return -ENOMEM;
 
 	while ((tok = strsep(&tmp, ",")) != NULL){
-		ret = add_output_field(&lock_keys, tok);
+		ret = add_output_field(contention, tok);
 		if (ret < 0)
 			break;
 	}
@@ -1609,10 +1632,10 @@ static int __cmd_report(bool display_info)
 		goto out_delete;
 	}
 
-	if (setup_output_field(output_fields))
+	if (setup_output_field(false, output_fields))
 		goto out_delete;
 
-	if (select_key())
+	if (select_key(false))
 		goto out_delete;
 
 	if (show_thread_stats)
@@ -1674,11 +1697,10 @@ static int __cmd_contention(void)
 		goto out_delete;
 	}
 
-	if (setup_output_field("contended,wait_total,wait_max,avg_wait"))
+	if (setup_output_field(true, output_fields))
 		goto out_delete;
 
-	sort_key = "wait_total";
-	if (select_key())
+	if (select_key(true))
 		goto out_delete;
 
 	aggr_mode = LOCK_AGGR_CALLER;
@@ -1817,6 +1839,10 @@ int cmd_lock(int argc, const char **argv)
 	};
 
 	const struct option contention_options[] = {
+	OPT_STRING('k', "key", &sort_key, "wait_total",
+		    "key for sorting (contended / wait_total / wait_max / wait_min / avg_wait)"),
+	OPT_STRING('F', "field", &output_fields, "contended,wait_total,wait_max,avg_wait",
+		    "output fields (contended / wait_total / wait_max / wait_min / avg_wait)"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -1876,6 +1902,9 @@ int cmd_lock(int argc, const char **argv)
 		rc = __cmd_report(true);
 	} else if (strlen(argv[0]) > 2 && strstarts("contention", argv[0])) {
 		trace_handler = &contention_lock_ops;
+		sort_key = "wait_total";
+		output_fields = "contended,wait_total,wait_max,avg_wait";
+
 		if (argc) {
 			argc = parse_options(argc, argv, contention_options,
 					     contention_usage, 0);
-- 
2.37.0.170.g444d1eabd0-goog

