Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6815AA085
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiIAT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbiIAT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:57:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0399288DFF;
        Thu,  1 Sep 2022 12:57:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c66so8205761pfc.10;
        Thu, 01 Sep 2022 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=grEQReBW7HRZNQTYFK9rMRzxQVvmokwjNE/r8n6HAfU=;
        b=Ud8/YTkL7PDo59bRTaU97c94I/6HGENC8a9AWtjblbpbWu0DoEftQOIca7SuiQWA9C
         mbka+nTAR5GC6iW8kLsdCekajvLVVX127TnDSU9og9oWsDtyoIS/vxBCYVxvwFppxzNJ
         F3037Sn+fGZh5U9PffwQObzBTaSW8eOcsErpeQ7OlWqaeKS7Yvy8sybG3+bm+p+wQdjn
         ERakW+Ej50V7fRD6e4NgffiDrf22hozJiNc1puNGi44E6UwGg2Xydq1g7Q9nOfLlorQf
         byjxeBfVeek2YTreiUu8vRzxScFHyZaJ4/TfzF0jTkxPXgpMpW4NXiBmEq4mZaneUh/G
         g+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=grEQReBW7HRZNQTYFK9rMRzxQVvmokwjNE/r8n6HAfU=;
        b=1SMhU79qX5E5bzzKZkGYZVbQfGivWPL/tL73jEDcqqcQGDIn1zCYveMXNYcXEuYQ7B
         TaLp50AVOXGU32C1w2Ug+GyKN59U9kv4g36zRuT/PfI8Ui+DYQswYWsjJM7Mtwi2TCuf
         gmZoNz54z8hnMSkYni1/5lOVge0/qtCD2bA6JJ1FvP4gl+5HsStUFWoU/apc942lAC6F
         0U75VJJ0kgVLJEWC/hUB0u1u6Dcm4FcF+B9KbfP76Bz29EVLhSM1EI7qciwhFSWebYw0
         4tOLLTq2GhH2mQNgQIwl0BJqdZYkhgVB1dS+oz9GruD/I1yvCXzYlJsUhLZognZwpVQW
         6Wcg==
X-Gm-Message-State: ACgBeo2Wx6JKACfwBa/Th288ONZX7u8gzy7LoO/qGGSxKPBWHQ19ZRqC
        QxHYzqAYpmy+lEkTX6pplC6doStX3pw=
X-Google-Smtp-Source: AA6agR7K5WmOQl5JkJOjndV7oUwLpzHMbdCoTaayEntap+MuRSBe6VezIdFDsY0KxFIKx8zTjvDifw==
X-Received: by 2002:a65:5ac4:0:b0:41b:af7f:125 with SMTP id d4-20020a655ac4000000b0041baf7f0125mr27543201pgt.224.1662062268472;
        Thu, 01 Sep 2022 12:57:48 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:87ff:65c0:eb6a:d2b3])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fb23c28e9asm3728500pjz.2.2022.09.01.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:57:48 -0700 (PDT)
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
Date:   Thu,  1 Sep 2022 12:57:38 -0700
Message-Id: <20220901195739.668604-5-namhyung@kernel.org>
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

