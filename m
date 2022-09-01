Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EED5AA088
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiIAT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiIAT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:57:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480DF883E0;
        Thu,  1 Sep 2022 12:57:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 199so18401445pfz.2;
        Thu, 01 Sep 2022 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=mjTaqq48hpPwmruEl0UppHlsTe3PLU+y+cRtBmXzLgw=;
        b=Q9BvpIsTAUlR4vleBxHM111zWZUao2bHBk/dFfA3I/Ln85EfXnWlRcr+F5GqSDKq/g
         glTwGNGj7Nd6bAJ6TciVMUOI81JcoXFCLTDeyTtj+gQtRfxq5Bh/NgZAIFjj+4Kax/Gh
         Q3j5qwyQeyGZpU8yk8Upkt6rFh7h0dlhWVontPylqeSJULa25ETQTqi2OhSsfMbr8Xf4
         Gweze+IYprZ7QeOjoIOuZOnxOwR8Jk10q0OCfP7KY6Wv9Ga8QTPYp05FZiIHfs16M5pP
         CDy/8LnUrj01tlPuF1OG+S0t6PUli9cgMBWLPAUpj3/r4bjaOZe/r5Zu+SYDeCDj9Ad9
         nC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=mjTaqq48hpPwmruEl0UppHlsTe3PLU+y+cRtBmXzLgw=;
        b=kgt3txRiNCtugMH5C6S3SAb/IlTivGWvxpynmcNcThX5CtjKswuLzpOPnUqyP4mE0c
         518hM4Ou69UXhq5TYW7NJJvdJcor0Z3sHC8a8A4Eb4s+f7UiCx9oW8CTvD61++gaZyzm
         Z83uNdaDgmUkRIEwAl17GW6Eo8I0NgmyafiOODmdPsHXUjKJyofWvR3SBkmUhnbmnbGr
         k/KuHgzVCdy6rr1qZ6y2SStGkDYRIEdBMDijVFnQspUjz/QMFXPrqO4vs3Siy54wFmga
         MvS73K6hbwzRPv3K16sMjpzu7NYlCvy6zVG3+5eW8xJAl5c5l89F8GD7cKJoreBGxz7s
         A0CA==
X-Gm-Message-State: ACgBeo2dZqAzHEl8Kt/vHGiHftdW1Jg0vRbcEJ2sz42pn0YPKd66GwO5
        Nd5lD0nZ/3PU4sba3W3SqvvaIozkjYU=
X-Google-Smtp-Source: AA6agR6mJ6IczlYW6XTzx+PD5S0EUh5sHFK+wb6qMA21+Fd+hGZLupu/Vz1jOm/JWxFvtHpqiMbpew==
X-Received: by 2002:a05:6a02:206:b0:427:93bb:9f99 with SMTP id bh6-20020a056a02020600b0042793bb9f99mr27174917pgb.542.1662062269660;
        Thu, 01 Sep 2022 12:57:49 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:87ff:65c0:eb6a:d2b3])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fb23c28e9asm3728500pjz.2.2022.09.01.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:57:49 -0700 (PDT)
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
Subject: [PATCH 5/5] perf report: Show per-event LOST SAMPLES stat
Date:   Thu,  1 Sep 2022 12:57:39 -0700
Message-Id: <20220901195739.668604-6-namhyung@kernel.org>
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

Display lost samples with --stat (if not zero):

  $ perf report --stat
    Aggregated stats:
             TOTAL events:         64
              COMM events:          2  ( 3.1%)
              EXIT events:          1  ( 1.6%)
            SAMPLE events:         26  (40.6%)
             MMAP2 events:          4  ( 6.2%)
      LOST_SAMPLES events:          1  ( 1.6%)
              ATTR events:          2  ( 3.1%)
    FINISHED_ROUND events:          1  ( 1.6%)
          ID_INDEX events:          1  ( 1.6%)
        THREAD_MAP events:          1  ( 1.6%)
           CPU_MAP events:          1  ( 1.6%)
      EVENT_UPDATE events:          2  ( 3.1%)
         TIME_CONV events:          1  ( 1.6%)
           FEATURE events:         20  (31.2%)
     FINISHED_INIT events:          1  ( 1.6%)
  cycles:uH stats:
            SAMPLE events:         14
      LOST_SAMPLES events:          1
  instructions:uH stats:
            SAMPLE events:         12

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 17 +++++++++++++++++
 tools/perf/util/hist.c      | 10 +++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91ed41cc7d88..8361890176c2 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -752,6 +752,22 @@ static int count_sample_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+static int count_lost_samples_event(struct perf_tool *tool,
+				    union perf_event *event,
+				    struct perf_sample *sample,
+				    struct machine *machine __maybe_unused)
+{
+	struct report *rep = container_of(tool, struct report, tool);
+	struct evsel *evsel;
+
+	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
+	if (evsel) {
+		hists__inc_nr_lost_samples(evsel__hists(evsel),
+					   event->lost_samples.lost);
+	}
+	return 0;
+}
+
 static int process_attr(struct perf_tool *tool __maybe_unused,
 			union perf_event *event,
 			struct evlist **pevlist);
@@ -761,6 +777,7 @@ static void stats_setup(struct report *rep)
 	memset(&rep->tool, 0, sizeof(rep->tool));
 	rep->tool.attr = process_attr;
 	rep->tool.sample = count_sample_event;
+	rep->tool.lost_samples = count_lost_samples_event;
 	rep->tool.no_warn = true;
 }
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8cab049f7119..06f5dbf213ad 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2683,12 +2683,16 @@ size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp,
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
-		if (skip_empty && !hists->stats.nr_samples)
+		if (skip_empty && !hists->stats.nr_samples && !hists->stats.nr_lost_samples)
 			continue;
 
 		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
-		ret += fprintf(fp, "%16s events: %10d\n",
-			       "SAMPLE", hists->stats.nr_samples);
+		if (hists->stats.nr_samples)
+			ret += fprintf(fp, "%16s events: %10d\n",
+				       "SAMPLE", hists->stats.nr_samples);
+		if (hists->stats.nr_lost_samples)
+			ret += fprintf(fp, "%16s events: %10d\n",
+				       "LOST_SAMPLES", hists->stats.nr_lost_samples);
 	}
 
 	return ret;
-- 
2.37.2.789.g6183377224-goog

