Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F49580406
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiGYSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiGYSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:31:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFA13D1F;
        Mon, 25 Jul 2022 11:31:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i3so6736327pld.0;
        Mon, 25 Jul 2022 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJYJFms8GJpoY0OsECigVFmxIO0a1eBqs63dgVV6oQI=;
        b=Savny8eH0HAoWNR41FqlGH3WJxiPWLvX9C4tSNIHowJEW1UOcqAQqQsAdONsh/XHyL
         AtSvsSMw08QdCJGQEgipQxgT0zhlZSQvTnU2X8xyPFcCQLMaXyzledr/qBlIvGA94XfP
         FYZo7a399KHpHPawyyfbGRbFgNoWB/rkesEY6FqXgwmEjBOdLCFm75umMMSMFISN5+i5
         35VsLQagFpmpfLLCHslOmRJPY6FQtfss9Aayd1TlSzxGRFsnQe9YYB6EWDLrBxwuAdot
         7ayfkzfjT8wDfczDXVM7QUGW08IIhkLB5RJbGyAyAR2y31vpMOa27/KA2THTsgGYRKvo
         FH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WJYJFms8GJpoY0OsECigVFmxIO0a1eBqs63dgVV6oQI=;
        b=bu4EwqM3qlg2U7zmyPnPE4OoxKm94uav7lJMks4fqlBH9WyZI10WsUnG6Z+W1XEOhA
         0yJb89EpdwLFMCtg+AjMZwbKz181+B4e7WtOmF0JJxW0GikzBNpOz085lH4JtvccYkl8
         iHH04vYQNUxhJ4geiDDTTqr8tpcF/SCa+A89VQ08fpakXaeZoWQ1IFrAzKlYAdA7wUtB
         RS/b6wDDJl3bIVu2242Gamyt/Ts+Uut0/Gk2p/1S/viHrQz7BxgzFDE2eHsLzC5sWU0v
         JEvKhU/MYZ47ye5YFyeDhlANw2+iOAxokPIngeEa6EROaiIZGbo9uM2agAF3iXjeTl5n
         ybjw==
X-Gm-Message-State: AJIora+WWNb+ycunuKRTA3cua6ulbbJWubSDJorDKUUQUSNHi/Ee6UZu
        zdNFv9tcniZsLG0neCwPxAw=
X-Google-Smtp-Source: AGRyM1uQ1MeT9G1WgldetqwfozEQ2/iwiKqZWawbw2zIlFP4oRgA8w1WSZOcGZLipgyg0jjQvaQtgg==
X-Received: by 2002:a17:902:b70a:b0:16c:f62c:43aa with SMTP id d10-20020a170902b70a00b0016cf62c43aamr13464144pls.8.1658773888482;
        Mon, 25 Jul 2022 11:31:28 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:2c4d:e9cd:d086:4d46])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016be9d498d0sm9740556plh.211.2022.07.25.11.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:31:28 -0700 (PDT)
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
Subject: [PATCH 1/5] perf lock: Add flags field in the lock_stat
Date:   Mon, 25 Jul 2022 11:31:20 -0700
Message-Id: <20220725183124.368304-2-namhyung@kernel.org>
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

For lock contention tracepoint analysis, it needs to keep the flags.
As nr_readlock and nr_trylock fields are not used for it, let's make
it a union.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 0aae88fdf93a..1de459198b99 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -59,7 +59,10 @@ struct lock_stat {
 	unsigned int		nr_contended;
 	unsigned int		nr_release;
 
-	unsigned int		nr_readlock;
+	union {
+		unsigned int	nr_readlock;
+		unsigned int	flags;
+	};
 	unsigned int		nr_trylock;
 
 	/* these times are in nano sec. */
@@ -516,7 +519,7 @@ static struct lock_stat *lock_stat_find(u64 addr)
 	return NULL;
 }
 
-static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
+static struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
 {
 	struct hlist_head *entry = lockhashentry(addr);
 	struct lock_stat *ret, *new;
@@ -531,13 +534,13 @@ static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
 		goto alloc_failed;
 
 	new->addr = addr;
-	new->name = zalloc(sizeof(char) * strlen(name) + 1);
+	new->name = strdup(name);
 	if (!new->name) {
 		free(new);
 		goto alloc_failed;
 	}
 
-	strcpy(new->name, name);
+	new->flags = flags;
 	new->wait_time_min = ULLONG_MAX;
 
 	hlist_add_head(&new->hash_entry, entry);
@@ -624,7 +627,7 @@ static int report_lock_acquire_event(struct evsel *evsel,
 	if (show_thread_stats)
 		addr = sample->tid;
 
-	ls = lock_stat_findnew(addr, name);
+	ls = lock_stat_findnew(addr, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -696,7 +699,7 @@ static int report_lock_acquired_event(struct evsel *evsel,
 	if (show_thread_stats)
 		addr = sample->tid;
 
-	ls = lock_stat_findnew(addr, name);
+	ls = lock_stat_findnew(addr, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -758,7 +761,7 @@ static int report_lock_contended_event(struct evsel *evsel,
 	if (show_thread_stats)
 		addr = sample->tid;
 
-	ls = lock_stat_findnew(addr, name);
+	ls = lock_stat_findnew(addr, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -813,7 +816,7 @@ static int report_lock_release_event(struct evsel *evsel,
 	if (show_thread_stats)
 		addr = sample->tid;
 
-	ls = lock_stat_findnew(addr, name);
+	ls = lock_stat_findnew(addr, name, 0);
 	if (!ls)
 		return -ENOMEM;
 
@@ -985,11 +988,12 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	if (!ls) {
 		char buf[128];
 		const char *caller = buf;
+		unsigned int flags = evsel__intval(evsel, sample, "flags");
 
 		if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
 			caller = "Unknown";
 
-		ls = lock_stat_findnew(addr, caller);
+		ls = lock_stat_findnew(addr, caller, flags);
 		if (!ls)
 			return -ENOMEM;
 	}
-- 
2.37.1.359.gd136c6c3e2-goog

