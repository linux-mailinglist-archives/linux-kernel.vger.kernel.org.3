Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D1C5A87E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiHaVE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiHaVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:04:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB7F2C9D;
        Wed, 31 Aug 2022 14:04:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q3so12036349pjg.3;
        Wed, 31 Aug 2022 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=hAUVu7RE/ADqvMe9yAOUjVh/OtQCo3q1ijQHaDVsU6Y=;
        b=D6RhJ1V2uJFTfbqhN7M/toCoMcJ2HkLkImPNdiKohV8bW45oPKK9kiygAXl4oGvfYA
         7PvRCxNey7Q6Gnk9IA8M0j+VoHeBDtzZ23CgjqBLfPiPi6JBDIUkVuwwKvXft3le5VG+
         yA2jgsvmX3yp0zTJiuD2DkndXyuCVhgJ7cTrXm0OCxvUeYMLjEwL2kGSt6uUuFPschfI
         ZzdbJw8WbbIx7p0RNb4a0fz2RaOiFGtOyXfnMSMF2jhytZE7AmyI3kQv88zayt/vAhnD
         J2bFVdau2a6NgeUwgx31loANNycczvisyl5GDqIq4g8sGMgMlonhntRfFv5OPkpFajdu
         XcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=hAUVu7RE/ADqvMe9yAOUjVh/OtQCo3q1ijQHaDVsU6Y=;
        b=Q4LsoOyHwmSDfUo+maowjtrjBj1P98bXARNi6cZawgIuII5tLK8iiKunW/E5wsFEP0
         6o/HOQh0gnHI86xOPuqOln0mjredS3CAkcn2Q9+XOG8jzXwFuZNcC9nBGr2Vx5DV63gT
         AF+cdAyXqkOnsWYhxN+UPc3WZVezbEl9Iw3g66uSIBG0zK4oQG2X8bGY/KXJ0DV//xsI
         ifaMS6RluxpVy1Opw1a1JOzfkrrXt4W1/HDhEZTeElubYlyL2m0g6wjoJBTaCuh0WQqg
         RcZxRObwYKvH/El3CisbChmBjVv19V1GmYNmImCuIJcq1sGwtNCIYoCjNYPttyfb8z1I
         RtUQ==
X-Gm-Message-State: ACgBeo3KtjMLtiwQxn83KoTQvy2WLuX7R+GiuOnuaFv6q4WTIWlUPllG
        S2Zu9OOVFb5SJogGSGBqaFY=
X-Google-Smtp-Source: AA6agR4Lxz5AEf0C0bKsNycuDy2jJUh2paatG7b34QrHS0hpbQ2ALMBZ4uMc9h1nprPpjEAJWThKZg==
X-Received: by 2002:a17:90a:5988:b0:1fd:6a33:abf with SMTP id l8-20020a17090a598800b001fd6a330abfmr5036285pji.69.1661979848817;
        Wed, 31 Aug 2022 14:04:08 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b0053ae6a3c51asm528931pfj.186.2022.08.31.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:04:07 -0700 (PDT)
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
Date:   Wed, 31 Aug 2022 14:03:52 -0700
Message-Id: <20220831210352.145753-6-namhyung@kernel.org>
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
 tools/perf/util/hist.c      |  3 +++
 2 files changed, 20 insertions(+)

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
index 8cab049f7119..cc363ba20c73 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2689,6 +2689,9 @@ size_t evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp,
 		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
 		ret += fprintf(fp, "%16s events: %10d\n",
 			       "SAMPLE", hists->stats.nr_samples);
+		if (hists->stats.nr_lost_samples)
+			ret += fprintf(fp, "%16s events: %10d\n",
+				       "LOST_SAMPLES", hists->stats.nr_lost_samples);
 	}
 
 	return ret;
-- 
2.37.2.789.g6183377224-goog

