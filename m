Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73834847AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiADSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbiADSVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:21:00 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69E8C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:20:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 205so32959109pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OgD+1kWhVDFGsOMLPv8+TTwuz9ad9aYKJ0zjiXSkOw=;
        b=c1UJvf+1WNbPluWHI7jTeUsM9FNF2WuV8o1AU8v51YBuqXZaZHh6mktbGTpyHIBLG2
         Ju3R5gX5TqUbtZ0WjZLBpY2Nhb46wkT2Om377m17/Aooy9CWJfBgR9zhgVlMEuhqVZJo
         fvTPFoClTnVYpYXfQnvCO1+MNpHPlaTW09FTJ6Hgua34S6sqacUjYi/NAKWO3keerjWO
         eDsWIiO7VfMnMQ6QsljwQTMGYMMK1Drs1oMJPKrCyVWpoPsZEOgd6cWzNCu6FAk/MWO2
         OEhfGmamZ45nsQrTULyYIuJtlItkJVKbeiNbinr4b5cwQoaRcbnaBJd9a2bqPK/2Ko/t
         VryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/OgD+1kWhVDFGsOMLPv8+TTwuz9ad9aYKJ0zjiXSkOw=;
        b=PcaI2XuMH4/GgAhJNtIi0NTRii7vOm2k5NAzCsEKott66T6xlkZpeG4m+sKk/C0m1c
         /sPcx/Yht7smOzQunKqRUBE3fOF5p+cqE0oYZUtTiFBF7/ETWyqLV8yWfcFpxD7qbei2
         U4ZHUtJaVbGmtq4na7lIganju5hELNH/wMry+qfboLqmIAr7CYgJnFkeBD1Sizg5aD/c
         nIxf25mSMHcUYnaULrJeFreu2y1Bowc46MXacL+emJ077Bvrg8cApctMTMjJzkk5yVDf
         Sa8ZYd6ofp5h7DaHvpheGYv+9/iibidhUKwQtHDHKhD9SV3f0wtjkC0cytFy4iV+ehP4
         yQZA==
X-Gm-Message-State: AOAM530kfdUF8V+3QYBnZaoMh5Pjt8NqaS5CbAwHmzUxMJEcuKKBxHbQ
        OaWnHDb+UZPy4ffL3UVxlGE=
X-Google-Smtp-Source: ABdhPJz0bOUlSC1tglohlS2ZiCy+5vfa51TXk1QhKtfVGC2wFKwAJvYGbgMZK/JpSfwB80uy1SR0DQ==
X-Received: by 2002:aa7:9298:0:b0:4ba:7d3a:1742 with SMTP id j24-20020aa79298000000b004ba7d3a1742mr51519275pfa.62.1641320459321;
        Tue, 04 Jan 2022 10:20:59 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:4abf:2548:40ff:6d1])
        by smtp.gmail.com with ESMTPSA id g10sm10097684pfo.103.2022.01.04.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:20:58 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/6] perf lock: Convert lockhash_table to use hlist
Date:   Tue,  4 Jan 2022 10:20:49 -0800
Message-Id: <20220104182054.25009-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104182054.25009-1-namhyung@kernel.org>
References: <20220104182054.25009-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hlist_head has a single entry so we can save some memory.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d70131b7b1b1..43139166f02e 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -38,13 +38,13 @@ static struct perf_session *session;
 #define LOCKHASH_BITS		12
 #define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
 
-static struct list_head lockhash_table[LOCKHASH_SIZE];
+static struct hlist_head lockhash_table[LOCKHASH_SIZE];
 
 #define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
 #define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
 
 struct lock_stat {
-	struct list_head	hash_entry;
+	struct hlist_node	hash_entry;
 	struct rb_node		rb;		/* used for sorting */
 
 	/*
@@ -317,10 +317,10 @@ static struct lock_stat *pop_from_result(void)
 
 static struct lock_stat *lock_stat_findnew(void *addr, const char *name)
 {
-	struct list_head *entry = lockhashentry(addr);
+	struct hlist_head *entry = lockhashentry(addr);
 	struct lock_stat *ret, *new;
 
-	list_for_each_entry(ret, entry, hash_entry) {
+	hlist_for_each_entry(ret, entry, hash_entry) {
 		if (ret->addr == addr)
 			return ret;
 	}
@@ -339,7 +339,7 @@ static struct lock_stat *lock_stat_findnew(void *addr, const char *name)
 	strcpy(new->name, name);
 	new->wait_time_min = ULLONG_MAX;
 
-	list_add(&new->hash_entry, entry);
+	hlist_add_head(&new->hash_entry, entry);
 	return new;
 
 alloc_failed:
@@ -781,7 +781,7 @@ static void dump_map(void)
 
 	pr_info("Address of instance: name of class\n");
 	for (i = 0; i < LOCKHASH_SIZE; i++) {
-		list_for_each_entry(st, &lockhash_table[i], hash_entry) {
+		hlist_for_each_entry(st, &lockhash_table[i], hash_entry) {
 			pr_info(" %p: %s\n", st->addr, st->name);
 		}
 	}
@@ -838,7 +838,7 @@ static void sort_result(void)
 	struct lock_stat *st;
 
 	for (i = 0; i < LOCKHASH_SIZE; i++) {
-		list_for_each_entry(st, &lockhash_table[i], hash_entry) {
+		hlist_for_each_entry(st, &lockhash_table[i], hash_entry) {
 			insert_to_result(st, compare);
 		}
 	}
@@ -990,7 +990,7 @@ int cmd_lock(int argc, const char **argv)
 	int rc = 0;
 
 	for (i = 0; i < LOCKHASH_SIZE; i++)
-		INIT_LIST_HEAD(lockhash_table + i);
+		INIT_HLIST_HEAD(lockhash_table + i);
 
 	argc = parse_options_subcommand(argc, argv, lock_options, lock_subcommands,
 					lock_usage, PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.34.1.448.ga2b2bfdf31-goog

