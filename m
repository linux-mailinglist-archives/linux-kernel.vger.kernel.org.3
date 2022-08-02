Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459E658824B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiHBTKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiHBTKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:10:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC2DF83;
        Tue,  2 Aug 2022 12:10:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 23so13149290pgc.8;
        Tue, 02 Aug 2022 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=AU/NK4sczZ9WBGCny09p1A4QZ7QZbKBY17yl9uMT0Wc=;
        b=G0clEsX8yjrXT41d168oxHbcgDoduj2mrZXWIr/ezU2Uw104C/BGu6jX5rU1oaD5WH
         f3K2nK8aYxCwMfkqcuWAbyfVvhIk3pbNkfF85wvn4uFHwv75ECgaEIi+iuUJySTLv0Gi
         t/TFW53uAH1v15otgjT2kDALhLbIvd5sdF6pWzqS2G2nDGKjAwUgZB7hNwRoq+bcrD03
         hshDixlCW/viu7DgeBOL3bgZLiJwOfh+1OQAsUNsqcVx4r2BB/9283Ckxv8TwXGXda9V
         AY/EPql8Cyg3TFHCKl5U/qpPssxChJzowt9eDcn/xGoXqOv/xLhCwrOGjVLcH7BYnvAH
         8IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=AU/NK4sczZ9WBGCny09p1A4QZ7QZbKBY17yl9uMT0Wc=;
        b=RKXo9dvRICd8zrsJ+tGKW1YO1ZTRNzx82Ru502aUe6IjEHe1PjM+7Gabajtl6dmhbZ
         UTqGVyOdvqysN9M9xZX/IQ1zn/JyfxanKPOztyrqH6wnGtv+i6Bzi4sb8mIyVYihL87c
         HKpLysz+7znUG7u4RjOo2wqonrK1loy4ky6Q8DdHht70q7hy00oGuisHvV6nr66e7wqA
         /vWOYrD9eDLdyAihGdaDKpQCCBxU+D5z830JlvP0qD04xxPmnWOfiEWNYOx4MUAG7d7+
         o0gd7wmOBf0pk6agnEKXsTDghlt7zNOEQk2yX5Kv8gfr4e+57Ea5ePzTuwK5XKYmDngI
         TINw==
X-Gm-Message-State: AJIora+CBBWthyLmTFq40PXtqSXbPYGjSg3h5eIJQpdQpsTT3u2M0hd7
        DMm+41xymSG+O/eiewIidgUlyPhYi2c=
X-Google-Smtp-Source: AGRyM1uck509vbqJIG7bJzlzeyVfYWKuihMocljc186ss3F8gOxDUJKMAma3y+tCjEXSyamLn4MPVQ==
X-Received: by 2002:a63:d94a:0:b0:412:6e04:dc26 with SMTP id e10-20020a63d94a000000b004126e04dc26mr18344516pgj.539.1659467407404;
        Tue, 02 Aug 2022 12:10:07 -0700 (PDT)
Received: from balhae.roam.corp.google.com (rrcs-173-196-215-70.west.biz.rr.com. [173.196.215.70])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902714900b0016a091eb88esm46784plm.126.2022.08.02.12.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 12:10:07 -0700 (PDT)
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
Subject: [PATCH v2 2/3] perf lock: Add --map-nr-entries option
Date:   Tue,  2 Aug 2022 12:10:03 -0700
Message-Id: <20220802191004.347740-2-namhyung@kernel.org>
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

The --map-nr-entries option is to control number of max entries in the
perf lock contention BPF maps.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  3 +++
 tools/perf/builtin-lock.c              | 23 ++++++++++++++++++++++-
 tools/perf/util/bpf_lock_contention.c  |  3 +++
 tools/perf/util/lock-contention.h      |  1 +
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 7949d2e6891b..193c5d8b8db9 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -145,6 +145,9 @@ CONTENTION OPTIONS
 --tid=::
         Record events on existing thread ID (comma separated list).
 
+--map-nr-entries::
+	Maximum number of BPF map entries (default: 10240).
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index eef778b7d33d..4c70cd1b9006 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -55,6 +55,7 @@ static struct rb_root		thread_stats;
 static bool combine_locks;
 static bool show_thread_stats;
 static bool use_bpf;
+static unsigned long bpf_map_entries = 10240;
 
 static enum {
 	LOCK_AGGR_ADDR,
@@ -1597,6 +1598,7 @@ static int __cmd_contention(int argc, const char **argv)
 	struct lock_contention con = {
 		.target = &target,
 		.result = &lockhash_table[0],
+		.map_nr_entries = bpf_map_entries,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -1786,6 +1788,24 @@ static int __cmd_record(int argc, const char **argv)
 	return ret;
 }
 
+static int parse_map_entry(const struct option *opt, const char *str,
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
+	OPT_CALLBACK(0, "map-nr-entries", &bpf_map_entries, "num",
+		     "Max number of BPF map entries", parse_map_entry),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index f5e2b4f19a72..0556cf4469ff 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -40,6 +40,9 @@ int lock_contention_prepare(struct lock_contention *con)
 		return -1;
 	}
 
+	bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
+	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
+
 	if (target__has_cpu(target))
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
 	if (target__has_task(target))
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index a0df5308cca4..8de8550f5ef8 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -112,6 +112,7 @@ struct lock_contention {
 	struct target *target;
 	struct machine *machine;
 	struct hlist_head *result;
+	unsigned long map_nr_entries;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.37.1.455.g008518b4e5-goog

