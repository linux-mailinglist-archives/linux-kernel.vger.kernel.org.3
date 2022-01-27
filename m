Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BC49D679
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiA0ABA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiA0AAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:00:55 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C049AC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:55 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f8so735961pgf.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBsnkhj9xj5fvZLZ8FdKBQCV6h1H9nMcr2W+mM1cviE=;
        b=Zu2AALlDUvbJFxm8rVmcaLkLx7IsmzL2b1DfrJ7q1GurSjUMj+aV0F2DmgXjCwV5xO
         hBu84csBIHM54lI4UzcZZAnP7Pg6FvQAHcZQI8+MpA80cOCNLj7eNiJidnBTlGDiJO3m
         AyvgHmR9wzCBYDkFCjWh7KFoL5PHd37f3ybHHjWQNgETApCKLagp0BNp9pJL1vzNfu6C
         yvFi0o1yw+wBPHAb0QvSHMi6oyp1n+WxzFJxcZjsezPHMeFikI8mNkEQIxXr3/BAzBKx
         ERft4kY9F9tRKZi25iccq5xjJGjfYgEGD9HSqbFYmoMdfkrgydKhtBpfqNNZUxqZVFeQ
         raPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mBsnkhj9xj5fvZLZ8FdKBQCV6h1H9nMcr2W+mM1cviE=;
        b=3O+sRKSjuYSVZK3mQNJePMc+nbWfGP0pRTW+rfRfqITtAnrZEvpqZ0NElCKk5HMWpY
         ruOA6Xa00uR7/XHbF/kK9KVjwVZV5/5eIkHtPLz3ed3rwI/cSNsXgJRnBv0NbNtX484R
         ieTjp2dvdrcWAbObaam7VmMwz38uTuy6M0oZjpB2iEja56HsRoCHMt5ButIC/o9yomqI
         QKnNFVhgtQs8KxM2xwlPzu25+4mV1kLEBhNInd7Ik+u2x/ciI7SguUlzQJqPP/+1RzMZ
         KclRdOfr22ok5TIEeEZREr5BsYlxavwMhAze5+qINduPhmeXQdgg32Ef4nJwfuFRHHRb
         R/Vw==
X-Gm-Message-State: AOAM530+yfwTtYzB5IWR3IKWlta0VQ7J28MhZ3M0EVSddZMTxIBTIc8Q
        dIDn15nVSb7Ce6CmVHZWTGM=
X-Google-Smtp-Source: ABdhPJwZEzj/Qr9LwWIIzdOx5TyIJwOnvQi3nqmx7OkVnNYTDhZydiJQg6RJcXGwQjVbGNX4cjJX5A==
X-Received: by 2002:a63:34b:: with SMTP id 72mr888870pgd.50.1643241655255;
        Wed, 26 Jan 2022 16:00:55 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e94:fba2:6768:ac75])
        by smtp.gmail.com with ESMTPSA id t24sm3545546pfg.92.2022.01.26.16.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:00:54 -0800 (PST)
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
Date:   Wed, 26 Jan 2022 16:00:45 -0800
Message-Id: <20220127000050.3011493-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127000050.3011493-1-namhyung@kernel.org>
References: <20220127000050.3011493-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hlist_head has a single entry so we can save some memory.

Acked-by: Jiri Olsa <jolsa@redhat.com>
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
2.35.0.rc0.227.g00780c9af4-goog

