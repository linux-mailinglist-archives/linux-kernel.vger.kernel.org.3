Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0254847AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiADSVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiADSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:21:01 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF59C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:21:01 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id x194so10201668pgx.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYq5HaT8fh+HA5zuj+et2czeHhoMoR0tY8OEaaIg5MI=;
        b=F8wUQUCjJemjck11oIO14hEdefVCIdTZ2lXCjc1Qvha/r4mFP/DP8O+9G3zro09DLv
         M0/Qx0/iLj2m5P8J8uzwbGT7U5v2ukgJJyWyAC+pFReRfl0smE4RRkpQQc6PMCa8FKOD
         g6OHlWZqZbCb9PCL5fFU+mnyXO8x3GuzC8/Omy0MJKExwBkheAhbZKJG6WGiquDNzQfE
         ZqnrSOIkMOwxsy1Ix2Nv+SdWEFgEopoR2ovawIf/snTF3wZ1kP3L478+BuTfBfiJFl65
         ms3Y3Xhp8adsH4AYpkVEiwTpY5frydWPP7ZS5GLztllbmp9JPPUoHq/gI4kVfMzg+SIx
         cwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VYq5HaT8fh+HA5zuj+et2czeHhoMoR0tY8OEaaIg5MI=;
        b=oG+XnAh6ok5xJLAZJzIWui+dQJztHs0tsW0/Aux3J5jQP/4xhr4MNiewHbmvoYvpIP
         iP0uOu60FeQFS6BXtD663oCm7BmhFQOOFz5j7q/35nA0i8w7O8a0PnB7fblezr+70X14
         417KgPZdFAYq+bvT+A2z6GLrYjHZriyo8O9+ZdOuBSnqSRLBVqt+boht3iYm29MeIwAR
         Ev8cTtMEFSFSXBiIDtr7u5kHrI3T26Y6az0f1SrPZsYrg1ZQpwT5b01EMD6BOVnet6Dg
         3Ww5zWNxcjzxypkbuKN8Sn183HH/HTsTXnUGGYvpykosppsuZZsABfhkTWA7fy5b26DI
         gzog==
X-Gm-Message-State: AOAM533Yqoy5MMb6B5yAaVkB+miBGlDsKkT+rVw5l+nfXCXJlZC/0pgI
        AvlYwfU0AMnO78WqyUvpjaA=
X-Google-Smtp-Source: ABdhPJz+vw6o44p1+lP4OPQhSszRz3b4lElAvTGnwnlHjUUWZInpW+xTt6N+2rbcH2bvhEiRi2iUyg==
X-Received: by 2002:a05:6a00:1386:b0:4ba:b454:70bc with SMTP id t6-20020a056a00138600b004bab45470bcmr51639379pfg.19.1641320460625;
        Tue, 04 Jan 2022 10:21:00 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:4abf:2548:40ff:6d1])
        by smtp.gmail.com with ESMTPSA id g10sm10097684pfo.103.2022.01.04.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:21:00 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/6] perf lock: Change type of lock_stat->addr to u64
Date:   Tue,  4 Jan 2022 10:20:50 -0800
Message-Id: <20220104182054.25009-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104182054.25009-1-namhyung@kernel.org>
References: <20220104182054.25009-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As evsel__intval() returns u64, we can just use it as is.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 43139166f02e..c4b5c3d71ae3 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -47,12 +47,7 @@ struct lock_stat {
 	struct hlist_node	hash_entry;
 	struct rb_node		rb;		/* used for sorting */
 
-	/*
-	 * FIXME: evsel__intval() returns u64,
-	 * so address of lockdep_map should be treated as 64bit.
-	 * Is there more better solution?
-	 */
-	void			*addr;		/* address of lockdep_map, used as ID */
+	u64			addr;		/* address of lockdep_map, used as ID */
 	char			*name;		/* for strcpy(), we cannot use const */
 
 	unsigned int		nr_acquire;
@@ -106,7 +101,7 @@ struct lock_seq_stat {
 	struct list_head        list;
 	int			state;
 	u64			prev_event_time;
-	void                    *addr;
+	u64                     addr;
 
 	int                     read_count;
 };
@@ -315,7 +310,7 @@ static struct lock_stat *pop_from_result(void)
 	return container_of(node, struct lock_stat, rb);
 }
 
-static struct lock_stat *lock_stat_findnew(void *addr, const char *name)
+static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
 {
 	struct hlist_head *entry = lockhashentry(addr);
 	struct lock_stat *ret, *new;
@@ -361,7 +356,7 @@ struct trace_lock_handler {
 			     struct perf_sample *sample);
 };
 
-static struct lock_seq_stat *get_seq(struct thread_stat *ts, void *addr)
+static struct lock_seq_stat *get_seq(struct thread_stat *ts, u64 addr)
 {
 	struct lock_seq_stat *seq;
 
@@ -400,16 +395,13 @@ enum acquire_flags {
 static int report_lock_acquire_event(struct evsel *evsel,
 				     struct perf_sample *sample)
 {
-	void *addr;
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	const char *name = evsel__strval(evsel, sample, "name");
-	u64 tmp	 = evsel__intval(evsel, sample, "lockdep_addr");
+	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 	int flag = evsel__intval(evsel, sample, "flags");
 
-	memcpy(&addr, &tmp, sizeof(void *));
-
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
 		return -ENOMEM;
@@ -472,15 +464,12 @@ static int report_lock_acquire_event(struct evsel *evsel,
 static int report_lock_acquired_event(struct evsel *evsel,
 				      struct perf_sample *sample)
 {
-	void *addr;
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	u64 contended_term;
 	const char *name = evsel__strval(evsel, sample, "name");
-	u64 tmp = evsel__intval(evsel, sample, "lockdep_addr");
-
-	memcpy(&addr, &tmp, sizeof(void *));
+	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
@@ -535,14 +524,11 @@ static int report_lock_acquired_event(struct evsel *evsel,
 static int report_lock_contended_event(struct evsel *evsel,
 				       struct perf_sample *sample)
 {
-	void *addr;
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	const char *name = evsel__strval(evsel, sample, "name");
-	u64 tmp = evsel__intval(evsel, sample, "lockdep_addr");
-
-	memcpy(&addr, &tmp, sizeof(void *));
+	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
@@ -590,14 +576,11 @@ static int report_lock_contended_event(struct evsel *evsel,
 static int report_lock_release_event(struct evsel *evsel,
 				     struct perf_sample *sample)
 {
-	void *addr;
 	struct lock_stat *ls;
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	const char *name = evsel__strval(evsel, sample, "name");
-	u64 tmp = evsel__intval(evsel, sample, "lockdep_addr");
-
-	memcpy(&addr, &tmp, sizeof(void *));
+	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
 
 	ls = lock_stat_findnew(addr, name);
 	if (!ls)
@@ -782,7 +765,7 @@ static void dump_map(void)
 	pr_info("Address of instance: name of class\n");
 	for (i = 0; i < LOCKHASH_SIZE; i++) {
 		hlist_for_each_entry(st, &lockhash_table[i], hash_entry) {
-			pr_info(" %p: %s\n", st->addr, st->name);
+			pr_info(" %#llx: %s\n", (unsigned long long)st->addr, st->name);
 		}
 	}
 }
-- 
2.34.1.448.ga2b2bfdf31-goog

