Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C424749D67A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiA0ABD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiA0AA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:00:57 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7943C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q75so746486pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iF12oDk33SC89FmUfUCUurczF3RBfapGcpp1SGxX/Hk=;
        b=a0ZX2Rb3/IavQpCZKwTz9ZIRWiMM8EG9Ysfo1NpkLOEH3UeXigGX184ypCwQgD/I3t
         hWNA92Mn5T8zus2U4ZYsrVVSr882V4FMC54i8w0B2Q5RAaczdi7AK5hOYiHeQqEl7GhI
         e+dVmJImbnE5Mb394Kg8ujyuPl2Osq2jFHQ2Vpj8wlOy5HQGzQ1CiQFHjvZokzAXpbeS
         147mEakUnyLptcZ0205EeOIfWauMbIa08GSUc2P+4FHdh6hAPaGlzOCFK1NmYPv1EKNc
         rEiym+889tB3aoS60F4YGHdZ/8ToY5BBTV+uROfhefEqmMnfUM0TY/k40/4Mj499Rf4s
         ZI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iF12oDk33SC89FmUfUCUurczF3RBfapGcpp1SGxX/Hk=;
        b=LuI3FbnTRibNxdbK3rFFE9pHVi24VM3QAEtH4jaO8sNRxwW+SJlJR3PVgTMPnzgFsv
         TEX2hcJL+hDgD3/8zsTfHkBaKZ2p4UFHif3296iQDTMRcUo272BB9VUkyuMswG+3PBLw
         U4OlX9fTsVopDXboAHLszPdZJ2zU17fdWRmeoecUR/7Klhw9ob8xIl0DlTEQHSwhz62r
         4yk+u1fnE27Ns4iC9E3hqLmbpy3KrpjIOemPZR6ochnxMnzwUzIaYL/FcNtNWQJiqIwb
         QZtdNDHK5YafzBAVEuPS3LdM/Otk3nIaN72Z23m8dGvwIi3gyF/Tl3EKXE+zFGLAaQtq
         l4sA==
X-Gm-Message-State: AOAM532vTCDMqi+q/UX6N3y+GzRrfcFEaDll/UMfpiwgCkTohj7Nm4Zj
        DQf2XrNCB4a3h3odiOa0kQk=
X-Google-Smtp-Source: ABdhPJyI9TKIB3V/1va1WsxgTtlH0KVNXn6avGS7oC/Wc6dGTnBlrHISvM/u6P4dnqMW4u1VkHYK0g==
X-Received: by 2002:a05:6a02:20c:: with SMTP id bh12mr924892pgb.308.1643241657043;
        Wed, 26 Jan 2022 16:00:57 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e94:fba2:6768:ac75])
        by smtp.gmail.com with ESMTPSA id t24sm3545546pfg.92.2022.01.26.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:00:56 -0800 (PST)
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
Date:   Wed, 26 Jan 2022 16:00:46 -0800
Message-Id: <20220127000050.3011493-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127000050.3011493-1-namhyung@kernel.org>
References: <20220127000050.3011493-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As evsel__intval() returns u64, we can just use it as is.

Acked-by: Jiri Olsa <jolsa@redhat.com>
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
2.35.0.rc0.227.g00780c9af4-goog

