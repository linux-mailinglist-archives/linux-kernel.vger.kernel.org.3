Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E422F57C38B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGUEg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiGUEgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:36:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC461D98;
        Wed, 20 Jul 2022 21:36:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y9so664122pff.12;
        Wed, 20 Jul 2022 21:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=px593lhrI3ohQi/d5ZOfxWI2P2og7GTsgTAQATVwjH8=;
        b=gJ9fKqucSaZTY5SR3tghXWgT1FaxQx9M/SZtokIzPRzPrEXAuLkjtnE70sOO53Wuyu
         8Lot0nfmHnYv6rioiQ6fXtuBNf7cOh/SBznCRiXv4jCPPOd0Wzg852xKoH3272JNxt+l
         EFWjh+8k8uNGHcuaSZyRpIrdipMmgqKte8c66c6roTVazHP9INlZ3mWPvXn2a9qcnuZI
         /lqZ10JQy45aDHrSoIhj/O0he8x2Jm5BLSpYvehHtwvPwKW1xE+xkqcwJfLdsxYs4W59
         +mQ5rgG05bK2g+wu/3zlJibe22Cr1Y8BlMhBiEytgaKgzjIgwbWQ0qiI+TK3nyQDd8XJ
         Nf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=px593lhrI3ohQi/d5ZOfxWI2P2og7GTsgTAQATVwjH8=;
        b=g/aZFl1nC/nmxfNY0EKcsigR9BE3fmoiwqC1BJIBLJt/ad/0L2Zu2bSAbzfTasEqun
         iA4+257SREcFE8Z2ASOSe4o9aBoCbq68LF9gdClq82jG2xGnl/rUXHc+WRYVDidCNQ2S
         QwgtmRfbGgfnrkxNLqoj1fSWu9caRAWho6bRVhA7BtrgD10jTnMwsuRLGX4POAcDOaxE
         JIwbPi7c8lmjRBqGNfBGO2ujJ5p0VVzdfx94oeHKD/OxZrqwFee4Vm1mPTHS6RAHMKjm
         MXJeDsb1HTGG3ztUh7kA7AkYia7t6Ju1DMUw5wrhX4dLjSUqa55X9DL/zM4a0cYHRcfs
         dPOw==
X-Gm-Message-State: AJIora/uCkBot80KTwCbJxf/8bBeINTI3C6qkf27joYFAUXQXEZvw/vi
        E57VRnqngcU4YO7O8UIza7k=
X-Google-Smtp-Source: AGRyM1tik97f09/xLZHzhieB7Yo6QdNETV2SCAO29QFgG443YHzKwdAE0PKW/M+gYyM9o/a+ouFd2Q==
X-Received: by 2002:a63:85c3:0:b0:419:ec94:198e with SMTP id u186-20020a6385c3000000b00419ec94198emr25167140pgd.569.1658378211823;
        Wed, 20 Jul 2022 21:36:51 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:467:a1e4:c167:53fd:8047:7f62])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0016bea2a0a8dsm450824pla.91.2022.07.20.21.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:36:51 -0700 (PDT)
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
Subject: [PATCH 2/6] perf lock: Add flags field in the lock_stat
Date:   Wed, 20 Jul 2022 21:36:40 -0700
Message-Id: <20220721043644.153718-3-namhyung@kernel.org>
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
2.37.0.170.g444d1eabd0-goog

