Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BD5AA087
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiIAT5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiIAT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:57:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9431C88DC9;
        Thu,  1 Sep 2022 12:57:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so68161pjj.4;
        Thu, 01 Sep 2022 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=kvFx5eRHToWhr+zoZdy15KN5PCyIzU9FkGCgn6Qywlw=;
        b=k3aIm4k94+8LtVnSMLD+qCpPzO6aQ1eYS1zwxmyhHQmHUMuxUmnh4r/iOqKLmKAHvz
         7q8f+RGvlJHZmYGbvUsPIgMgVXIlY6YNX8R1jkwtQUb4hAz48cSU5UT9FlwDTg+Gjw43
         ETulasvfCCaGvyyEpxlHxmNlCJ5nYQBzR1z9NnR/tmZxE7N3uc+2QONhmED1zDGh8CIC
         +xBJo94e4UMi7Nz9n/ydZ6E4Far018dQTVN9ELmil3jyjQImSzEEJZfABO3oRDhXWbER
         67z8iJP2ilmYk6HBH3IjpiPzPU/gYcgAshpZ03KXPuJxd0UAqaFVcIKj5JbnmvgQD2Mf
         GMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=kvFx5eRHToWhr+zoZdy15KN5PCyIzU9FkGCgn6Qywlw=;
        b=kKa88Gt6A4KnU4LIHelrXFMA59ZK5VMTOTXFs+YYTGkvknjAJhuB1Iflvg7ikTGnds
         PVvJsWS7/jSkGup/mWxRSkVQTLfh7cMtsSR4amTi0HcOYp3Jty+xSe9/XDVkN2Y/xt8i
         4kf/3PHYVy47lzP6mmiDnKOvfbJrIQV/lkZhv1zKcWKB6proMKagznukHgYXBltDn6Mm
         SU1EAsEvbvk2Wu0hUzvvJJ14jKTMt/2LX47o2wbDb5ZVOHUXUpxj/kCTIqAKJLQEBrfR
         qboxwDY7vj+Dp/CjZVBEUmurLgRDtBTizAm5zSbVAa0/1wdAoNZctsLijY/eOgcX8vx+
         Yr3Q==
X-Gm-Message-State: ACgBeo3R7Yym1dqpw0lgvw2CoCTiFoqKSkwsTipqNVzrtpya7ucNlm4g
        JJaTV78P+kRN+cs3WzE331g=
X-Google-Smtp-Source: AA6agR7MouHglHLgzaQYQk0XFNtZ7l2HPuZQl9bOpjF/myE7hYshc5f1XiYOSX+oFlvs3EVhWa+sRw==
X-Received: by 2002:a17:90b:4a82:b0:1f5:5eaa:68a with SMTP id lp2-20020a17090b4a8200b001f55eaa068amr795635pjb.13.1662062265048;
        Thu, 01 Sep 2022 12:57:45 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:87ff:65c0:eb6a:d2b3])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fb23c28e9asm3728500pjz.2.2022.09.01.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:57:44 -0700 (PDT)
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
Date:   Thu,  1 Sep 2022 12:57:36 -0700
Message-Id: <20220901195739.668604-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901195739.668604-1-namhyung@kernel.org>
References: <20220901195739.668604-1-namhyung@kernel.org>
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

