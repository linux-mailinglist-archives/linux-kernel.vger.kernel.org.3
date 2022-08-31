Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031B5A87E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiHaVET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiHaVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:04:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D65F3254;
        Wed, 31 Aug 2022 14:04:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jm11so15235106plb.13;
        Wed, 31 Aug 2022 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=grEQReBW7HRZNQTYFK9rMRzxQVvmokwjNE/r8n6HAfU=;
        b=HT/8j8Y9wYrNJczNbfE1CLE/nRKc+VOjIFwUKGiH9IPEYjFGpTC6IlaMbRy9PSwEAm
         Wnzz5AnlEnZ4ryxWZkTGrYQi5aH5bcYsu8S0a6ADTt4P/EfkdhlNaxeXk/SHz27De0uY
         7zljsC4kDc5YMvWfahY6L8HBPcFF8ROo3nciysBdBbD8Z1n6dti0yTrrj+lDLrzvFaY5
         5eoQvuH4RxD4jhL4LDVw7SpdN9+F1gUswN5iUrL+wEffKv6jsJMzW9y90Y4+8IB7/+h0
         gKyZEaWIYcO6MM5QmOVcqAh6igjekvlTJxFvOAQ6C8v55/S+g4lxhM6jadhQPi8xYgFK
         u/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=grEQReBW7HRZNQTYFK9rMRzxQVvmokwjNE/r8n6HAfU=;
        b=N+ShLXZQyJItruX+9LpzYxvgVtNomjMMtaKgexHPeBRKHUYSLvo/+hzmlnsoloO+ju
         XeXu1HHb2paGTotcDpiQu7gqaD/YItME0Zg63X0iluP4oFr5lvMEi/WPOFSs9U3HgHhn
         o3dX/m+Fc61naL/EInBQpDixpfjFnOtXPqbbQWPTcjWZgccQaetP4wfCLaHH+vVFOvnd
         EFKzJ4KHmgiv95P6iECo912SOGbSOrbTZXpa5OuW/71LNI/DKPuLwnZi9jPD8x1Y/PeK
         uzSJLvmLUfJRDj7aaY3zc5p9iFJXobAIX3NUPiHAFE9kVzKO8JBafBBpLGASHNsX4r6y
         x42w==
X-Gm-Message-State: ACgBeo3BIsUASfufESPcf8YkrHf+hKQZVYsSA4NgGscbNhbJUN5gWjQ+
        v5okLLN37K9bfYuaSN+vjTs=
X-Google-Smtp-Source: AA6agR6didWx6FR4VPORqHLoKZWL6BCcRl0sY6J7MZQPrDEn+JIXD5lOQ6NnQQxK55w+F+ZRnvGtSg==
X-Received: by 2002:a17:902:ef50:b0:170:9f15:b998 with SMTP id e16-20020a170902ef5000b001709f15b998mr27824548plx.102.1661979846713;
        Wed, 31 Aug 2022 14:04:06 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b0053ae6a3c51asm528931pfj.186.2022.08.31.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:04:05 -0700 (PDT)
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
Subject: [PATCH 4/5] perf hist: Add nr_lost_samples to hist_stats
Date:   Wed, 31 Aug 2022 14:03:51 -0700
Message-Id: <20220831210352.145753-5-namhyung@kernel.org>
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

This is a preparation to display accurate lost sample counts for
each evsel.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/events_stats.h | 1 +
 tools/perf/util/hist.c         | 5 +++++
 tools/perf/util/hist.h         | 1 +
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
index 040ab9d0a803..8fecc9fbaecc 100644
--- a/tools/perf/util/events_stats.h
+++ b/tools/perf/util/events_stats.h
@@ -47,6 +47,7 @@ struct hists_stats {
 	u64 total_non_filtered_period;
 	u32 nr_samples;
 	u32 nr_non_filtered_samples;
+	u32 nr_lost_samples;
 };
 
 void events_stats__inc(struct events_stats *stats, u32 type);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 698add038cec..8cab049f7119 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2335,6 +2335,11 @@ void hists__inc_nr_samples(struct hists *hists, bool filtered)
 		hists->stats.nr_non_filtered_samples++;
 }
 
+void hists__inc_nr_lost_samples(struct hists *hists, u32 lost)
+{
+	hists->stats.nr_lost_samples += lost;
+}
+
 static struct hist_entry *hists__add_dummy_entry(struct hists *hists,
 						 struct hist_entry *pair)
 {
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 508428b2c1b2..c7a7a3fa0b87 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -201,6 +201,7 @@ void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
 void hists__inc_nr_events(struct hists *hists);
 void hists__inc_nr_samples(struct hists *hists, bool filtered);
+void hists__inc_nr_lost_samples(struct hists *hists, u32 lost);
 
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
-- 
2.37.2.789.g6183377224-goog

