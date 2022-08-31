Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADB5A87DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiHaVEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiHaVEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:04:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D4CEE4B0;
        Wed, 31 Aug 2022 14:04:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v5so9043019plo.9;
        Wed, 31 Aug 2022 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=kvFx5eRHToWhr+zoZdy15KN5PCyIzU9FkGCgn6Qywlw=;
        b=qf7oCb+6U7wyK/WXVyWqIxvfPRJk2TiE5FhIE3SZABQYyTMxEmRbOFfLRJhW2mZcWG
         ha9i4oq2n/7dTIjos6v31kIR/SUn0Ip1yNXSkp5rueSw4+Rwga55OWOhL32sVQ9zH3n7
         m+8WKr9Hq2UFAurZiCm097u98D2LEvw1AbD3NVvWT9SsBoxG/gO/qDdZ2HOE90JMSDIW
         U+fS78v7jT0N/Wv5+8PJQOMmN1U1WzRfGSkmJMnDyVyhM5RYEES2MPHDGZ/K55EHlwek
         F5/arKUAeDz0BGt0wPESQex1qE13+nTC7FGfuG/rEgYpUC5HEbethojfvrXoZEOVWqwu
         YEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=kvFx5eRHToWhr+zoZdy15KN5PCyIzU9FkGCgn6Qywlw=;
        b=vsKrKssllShHrHnCCsEYaFnRzIJknVV/ccKXi9hqsrKT3sf8oDS+m8JQWP1oYFeMws
         D4itvYvsBApV20VoMdCmquYVYPS+Rbe40rqDblkG2ypBw4ArTu2lBdybR4hFr0/r7Vfg
         v7zz2nNtTf4NC0kLyDoohyxmrK7UctcRnkVEzITH2PKsj1rii4brIXpfC7gciAfdHmSq
         mPdJ4SrZPaKz5dSeHPBjKcT3B+WoOkhXaKoT2BW2rO7QUcGZQSB07jBsI4JqYxPU0vY0
         Nf3uoB4Se2eh56S3jrr9F1NxPKdMuu2mDd3xkeztX5l2gqcnLG4qMPTsq2PiGXye7546
         PC+A==
X-Gm-Message-State: ACgBeo1QHHQLuNHhlsq8HfmJD9NeFp0KT0NVJct4He/3FswY6Av5RpRj
        HzOwldujuQNJAX5CLWBuYdw=
X-Google-Smtp-Source: AA6agR4oX6FhX+PN2QqK5aBgnFtb+zcamRp4j012AaFeHV+nP6WS/DMyOaKCIuCLkzPtrGu8PHMd6A==
X-Received: by 2002:a17:90b:3e8b:b0:1f5:2a52:9148 with SMTP id rj11-20020a17090b3e8b00b001f52a529148mr4991608pjb.175.1661979841010;
        Wed, 31 Aug 2022 14:04:01 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b0053ae6a3c51asm528931pfj.186.2022.08.31.14.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:03:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/5] perf record: Set PERF_FORMAT_LOST by default
Date:   Wed, 31 Aug 2022 14:03:49 -0700
Message-Id: <20220831210352.145753-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220831210352.145753-1-namhyung@kernel.org>
References: <20220831210352.145753-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we want to see the number of lost samples in the perf report, set the
LOST format when it configs evsel.  On old kernels, it'd fallback to
disable it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 10 +++++++++-
 tools/perf/util/evsel.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e1bc76ece117..5776bfa70f11 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1161,6 +1161,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->sample_id_all = perf_missing_features.sample_id_all ? 0 : 1;
 	attr->inherit	    = !opts->no_inherit;
 	attr->write_backward = opts->overwrite ? 1 : 0;
+	attr->read_format   = PERF_FORMAT_LOST;
 
 	evsel__set_sample_bit(evsel, IP);
 	evsel__set_sample_bit(evsel, TID);
@@ -1856,6 +1857,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.read_lost)
+		evsel->core.attr.read_format &= ~PERF_FORMAT_LOST;
 	if (perf_missing_features.weight_struct) {
 		evsel__set_sample_bit(evsel, WEIGHT);
 		evsel__reset_sample_bit(evsel, WEIGHT_STRUCT);
@@ -1907,7 +1910,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.weight_struct &&
+	if (!perf_missing_features.read_lost &&
+	    (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
+		perf_missing_features.read_lost = true;
+		pr_debug2("switching off PERF_FORMAT_LOST support\n");
+		return true;
+	} else if (!perf_missing_features.weight_struct &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
 		perf_missing_features.weight_struct = true;
 		pr_debug2("switching off weight struct support\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d927713b513e..989865e16aad 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -188,6 +188,7 @@ struct perf_missing_features {
 	bool data_page_size;
 	bool code_page_size;
 	bool weight_struct;
+	bool read_lost;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.37.2.789.g6183377224-goog

