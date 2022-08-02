Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8345877EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiHBHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiHBHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:35:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D9BB3;
        Tue,  2 Aug 2022 00:35:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w7so12670745ply.12;
        Tue, 02 Aug 2022 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=vAzhrMBx41KR5/QG49vw9E4uZBLDwRnUFTHGl01xlEo=;
        b=RVoX+oNvi3wLv+gFmrUDMvRnRcajnaVlHF1+LRCCNEafSkBuFdDkheCPjeQwkvD8AX
         rP+QLJAZ1hk+Mc1FPVvig3j7oyiCX+mXCD1kxvT2hVI4lWu+emV8pbDHBvRH8jAjBoa5
         XJqrv21XW10YxTxfZNS5lP3nnCqbtFFBdbT5vjtAzAR4jLcaqg0Fxf7DmVoidqa9WzSs
         OwbcuZzI4aho5iu5UCTicihTnlKTI+W8u2GmOldE0dE0h0JIYmUO7IQwV2O54cCXFzCk
         jeeJgGcaCm2rJwyCaqFj8wS+BkRVVKzp0sOOwSQYCBECc3XYM0bV4CP8D1YZygo6rT21
         VNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=vAzhrMBx41KR5/QG49vw9E4uZBLDwRnUFTHGl01xlEo=;
        b=xEvF8xCIbYJIZf1iaW9VH3ROC5CdeUuUvoQl9fjm/+iCCPbVYOtNQ3RdnNgprTC6lk
         oeVv1/Ge5NIbHjATnY5tjASfQ3z+J3IP+80JP11o/7H2nUJU2oZLfjvbFoiWZt2vzCxB
         gJpVdrr/QOKyIPbvk5TvkDq3DWwSaFWTMOGmNWVA/HiIPhhIpgvanq1SWOKMjd3yeyzC
         qZzbepcrWEctM6AfpJYWbA7keg9p5y2NE2fW83gBiF5fqCzjgs/QCZX2UKDnCqUoJrPQ
         O7qIHv7yX15Bwrh21rUHR8fhvKwR0Byb1o0fABUW7o+rl0CMuDU43fYuynbpwBFQ8Qnp
         k0jQ==
X-Gm-Message-State: ACgBeo0SZ+a5sbYRcnqv9elxrNqcEhyViuP+I94xwBoVuxDwZSvAjW1U
        v1qPJGq9nT9ajPAjkdY1XSw=
X-Google-Smtp-Source: AA6agR4JLhNrB9e/Ypel7vrYIOsBmhaYjmC00U2EzNV4RpDycq71/0jAM90ukDYzPVPibMaGtF9G7A==
X-Received: by 2002:a17:903:230e:b0:16f:784:ea3f with SMTP id d14-20020a170903230e00b0016f0784ea3fmr1155785plh.160.1659425715684;
        Tue, 02 Aug 2022 00:35:15 -0700 (PDT)
Received: from balhae.roam.corp.google.com (rrcs-173-196-215-70.west.biz.rr.com. [173.196.215.70])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b0016be368fb30sm10802896pla.212.2022.08.02.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 00:35:15 -0700 (PDT)
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
Subject: [PATCH 2/3] perf lock: Add -m/--map-length option
Date:   Tue,  2 Aug 2022 00:35:10 -0700
Message-Id: <20220802073511.299459-2-namhyung@kernel.org>
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

The -m/--map-length option is to control number of max entries in the
perf lock contention BPF maps.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  4 ++++
 tools/perf/builtin-lock.c              | 23 ++++++++++++++++++++++-
 tools/perf/util/bpf_lock_contention.c  |  3 +++
 tools/perf/util/lock-contention.h      |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 7949d2e6891b..2101644785e0 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -145,6 +145,10 @@ CONTENTION OPTIONS
 --tid=::
         Record events on existing thread ID (comma separated list).
 
+-m::
+--map-length::
+	Maximum number of BPF map entries (default: 10240).
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index eef778b7d33d..e32fdcd497e0 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -55,6 +55,7 @@ static struct rb_root		thread_stats;
 static bool combine_locks;
 static bool show_thread_stats;
 static bool use_bpf;
+static unsigned long bpf_map_len = 10240;
 
 static enum {
 	LOCK_AGGR_ADDR,
@@ -1597,6 +1598,7 @@ static int __cmd_contention(int argc, const char **argv)
 	struct lock_contention con = {
 		.target = &target,
 		.result = &lockhash_table[0],
+		.map_len = bpf_map_len,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -1786,6 +1788,24 @@ static int __cmd_record(int argc, const char **argv)
 	return ret;
 }
 
+static int parse_map_length(const struct option *opt, const char *str,
+			    int unset __maybe_unused)
+{
+	unsigned long *len = (unsigned long *)opt->value;
+	unsigned long val;
+	char *endptr;
+
+	errno = 0;
+	val = strtoul(str, &endptr, 0);
+	if (*endptr != '\0' || errno != 0) {
+		pr_err("invalid BPF map length: %s\n", str);
+		return -1;
+	}
+
+	*len = val;
+	return 0;
+}
+
 int cmd_lock(int argc, const char **argv)
 {
 	const struct option lock_options[] = {
@@ -1835,9 +1855,10 @@ int cmd_lock(int argc, const char **argv)
 		    "List of cpus to monitor"),
 	OPT_STRING('p', "pid", &target.pid, "pid",
 		   "Trace on existing process id"),
-	/* TODO: Add short option -t after -t/--tracer can be removed. */
 	OPT_STRING(0, "tid", &target.tid, "tid",
 		   "Trace on existing thread id (exclusive to --pid)"),
+	OPT_CALLBACK('m', "map-length", &bpf_map_len, "len",
+		     "Max number of BPF map entries", parse_map_length),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index f5e2b4f19a72..26128e5bb659 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -40,6 +40,9 @@ int lock_contention_prepare(struct lock_contention *con)
 		return -1;
 	}
 
+	bpf_map__set_max_entries(skel->maps.stacks, con->map_len);
+	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_len);
+
 	if (target__has_cpu(target))
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
 	if (target__has_task(target))
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index a0df5308cca4..b09fd6eb978a 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -112,6 +112,7 @@ struct lock_contention {
 	struct target *target;
 	struct machine *machine;
 	struct hlist_head *result;
+	unsigned long map_len;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.37.1.455.g008518b4e5-goog

