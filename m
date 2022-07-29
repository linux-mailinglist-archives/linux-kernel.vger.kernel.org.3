Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116645855E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiG2UIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiG2UIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:08:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADE07CB51;
        Fri, 29 Jul 2022 13:08:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o3so5529277ple.5;
        Fri, 29 Jul 2022 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=ek+Ls/Nc1cCImKTTFp3CMyhusWpQs8VhRYTO+ff+y+4=;
        b=VGwDDVVWgD+Qs3NIGLdIQi05fC3drE9GxCopUDL2KFilHBA6Hf5PUFhx/ijHB+//ri
         i7iY3VjOtiT0gW6uvZI+g1nuW0jb2eHPfSXxAPjZnACQRCAnUwfJci5sblNeC5saM8xN
         hciKTpTWh63AKwFYfnwL0+1SdMwV1yNWPstS0+IvWvsw8eca4PPBm6V4EtewOxjzgw5g
         S91dtYJyeu888Hl+oZ+vYNJRtx9hR9A1kAAAe9uZ/OHjKzRefk1IHMbA/6L79OxWCtGs
         HyKW1MhnJHkg8w93hUIz4EHcXdedz9yCaakOym1IjjMzm3LTN6fO5lzshPG8D0u2LiOT
         VlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=ek+Ls/Nc1cCImKTTFp3CMyhusWpQs8VhRYTO+ff+y+4=;
        b=ruwpt54SlUBYTbn/smYursuTLBCikr7qOQbPgKXqsfudZk1WzJ+HMwiC8B3aNw6w73
         6cEpGH/Rh+dsMi01HIdHftFc3q3d14x5PirG7SB9WQ1X3dE6cZfOw+AMkfgl38uVM4ah
         TB3BLcYWdFEEp2CQvr7OmLHRNzG3xVTpgmBmpVHU6VxUNQ1n6yHJcmDmtgYn+cxJkUAt
         Ed8a4eOL2R7dcM9M0hKIQzpuRTDF5xa/quVGm8dXW6MwxS9eR+z3qNr1V/36KbuKzumU
         AzeC9WQNnX9nWzEWSNwundTrfNOgI9nfTr6iwUP7zLWJS+KblBKCwbruqx145fZlVv1v
         WIzQ==
X-Gm-Message-State: ACgBeo0kO8d1ZNcW2tUnE3vIujOEys1nN2WInehlZ6ru+5zOcJGLm9bF
        v7mX3khSdostXQyvVAUFbYxGrmSBhe4=
X-Google-Smtp-Source: AA6agR5roehGZYzs6TUhV5HbzfkapFS1wL6KKdunD5/pXZoBE1eR3xon8t6Qvk1Ot8I7eiXXnXPwiQ==
X-Received: by 2002:a17:90a:9dc7:b0:1f3:1a8:41a1 with SMTP id x7-20020a17090a9dc700b001f301a841a1mr5977098pjv.23.1659125280379;
        Fri, 29 Jul 2022 13:08:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:c01e:2ed5:25ca:3acb])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b0016be14a776asm3929823ple.286.2022.07.29.13.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:08:00 -0700 (PDT)
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
        Stephane Eranian <eranian@google.com>,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 1/3] perf lock: Pass machine pointer to is_lock_function()
Date:   Fri, 29 Jul 2022 13:07:54 -0700
Message-Id: <20220729200756.666106-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220729200756.666106-1-namhyung@kernel.org>
References: <20220729200756.666106-1-namhyung@kernel.org>
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

This is a preparation for later change to expose the function externally
so that it can be used without the implicit session data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 041801d8b6ac..10b854315b7a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -947,10 +947,9 @@ static int report_lock_release_event(struct evsel *evsel,
 	return 0;
 }
 
-static bool is_lock_function(u64 addr)
+static bool is_lock_function(struct machine *machine, u64 addr)
 {
 	if (!sched_text_start) {
-		struct machine *machine = &session->machines.host;
 		struct map *kmap;
 		struct symbol *sym;
 
@@ -1002,6 +1001,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 {
 	struct thread *thread;
 	struct callchain_cursor *cursor = &callchain_cursor;
+	struct machine *machine = &session->machines.host;
 	struct symbol *sym;
 	int skip = 0;
 	int ret;
@@ -1010,8 +1010,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 	if (show_thread_stats)
 		return -1;
 
-	thread = machine__findnew_thread(&session->machines.host,
-					 -1, sample->pid);
+	thread = machine__findnew_thread(machine, -1, sample->pid);
 	if (thread == NULL)
 		return -1;
 
@@ -1038,7 +1037,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 			goto next;
 
 		sym = node->ms.sym;
-		if (sym && !is_lock_function(node->ip)) {
+		if (sym && !is_lock_function(machine, node->ip)) {
 			struct map *map = node->ms.map;
 			u64 offset;
 
@@ -1060,13 +1059,13 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 {
 	struct callchain_cursor *cursor = &callchain_cursor;
+	struct machine *machine = &session->machines.host;
 	struct thread *thread;
 	u64 hash = 0;
 	int skip = 0;
 	int ret;
 
-	thread = machine__findnew_thread(&session->machines.host,
-					 -1, sample->pid);
+	thread = machine__findnew_thread(machine, -1, sample->pid);
 	if (thread == NULL)
 		return -1;
 
@@ -1091,7 +1090,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 		if (++skip <= CONTENTION_STACK_SKIP)
 			goto next;
 
-		if (node->ms.sym && is_lock_function(node->ip))
+		if (node->ms.sym && is_lock_function(machine, node->ip))
 			goto next;
 
 		hash ^= hash_long((unsigned long)node->ip, 64);
-- 
2.37.1.455.g008518b4e5-goog

