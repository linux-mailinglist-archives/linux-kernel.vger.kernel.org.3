Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77B2496A16
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiAVE6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiAVE6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:58:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B83C061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k189-20020a25c6c6000000b0061274ece35eso23233449ybf.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aNuBZ0ZpaoD1AkR8uBb0XNwqugpn9QfU7CzwmAlFWuQ=;
        b=mPEzAeW9MHKoUIiyXGvyAwu+QOQwXqXUloUWAzzKa2I/Tk/zDk6UtdakN5ozYpJNO8
         4Orfoc8RkiJjMfB/tiwxo2UV6heXCmAHQIpK+23ucKA+0XmAiV3Mv0Oh8etQyfBfOBBW
         vzRO1roT/tY2uFITgmZbmNMJFUVLqNtVPfgb9BCo3YnBYXfAt9mvKbrHknZwklmu5E7K
         qN1EpvfvxIymXukW4t+XVg+k4tk1JijGohqcZsidP1J8TS+X/nhvsQDm69Gi9oN87gYT
         hBM7+531+CmosJxG7mWrQPRVqfxGfZpP7DEgfpIyNbV8h7kig4SUdZdRhMWMxQGgGvAp
         WQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aNuBZ0ZpaoD1AkR8uBb0XNwqugpn9QfU7CzwmAlFWuQ=;
        b=31t7Nt9ED8QN3FGQUJmRkutblBkOw9/PcmZnBqQRQDfKLJs5DIGI53AeyOtbmFqDZw
         pPTOX9WtmosmryHwzUJZN0r0vdliqFQdkO7EbkDxpM16t+S7WRC7qfJuREx7lsrvoA2I
         GavSwtbsjeRi/r3SX5Qv4JSlGCqIhOz/OxC9Kx9L62OgxO+SOBdCgU9Jssd4lqzYfObH
         qHdv2OYED24NNDHeqMxt7bXgrgcoETjjAluEsVCH/tnM6s+Ij9SNwLVIoP5u7vAoka5r
         DvKEgQCbiUrjSxYaA5WXLLGjTZ8yHnnZrFL8HNKjWP/VioZFxJQNMHySV29j8HU91Y2g
         0ezw==
X-Gm-Message-State: AOAM532eWyZFFU7QKIysbDA8KNYttZRw0FR4AZGcHjvHSfUGLGpMp1eb
        pvcL6rONLfcTFnjObk5SFfFndIjferuG
X-Google-Smtp-Source: ABdhPJw1NzzeJ/QJ8gyxsnNeWJvtCDed/vCdUahcTcTwM0lyHcDWrTca5XzdzlaqbcpcK1zMRjP2VEPJH1Ty
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6125:f911:aa9a:59ee])
 (user=irogers job=sendgmr) by 2002:a25:9c45:: with SMTP id
 x5mr10714898ybo.91.1642827500208; Fri, 21 Jan 2022 20:58:20 -0800 (PST)
Date:   Fri, 21 Jan 2022 20:58:09 -0800
In-Reply-To: <20220122045811.3402706-1-irogers@google.com>
Message-Id: <20220122045811.3402706-2-irogers@google.com>
Mime-Version: 1.0
References: <20220122045811.3402706-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 1/3] perf python: Fix cpu_map__item building
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value should be built as an integer.
Switch some uses of perf_cpu_map to use the library API.

Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f3e5131f183c..52d8995cfd73 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -638,17 +638,17 @@ static Py_ssize_t pyrf_cpu_map__length(PyObject *obj)
 {
 	struct pyrf_cpu_map *pcpus = (void *)obj;
 
-	return pcpus->cpus->nr;
+	return perf_cpu_map__nr(pcpus->cpus);
 }
 
 static PyObject *pyrf_cpu_map__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_cpu_map *pcpus = (void *)obj;
 
-	if (i >= pcpus->cpus->nr)
+	if (i >= perf_cpu_map__nr(pcpus->cpus))
 		return NULL;
 
-	return Py_BuildValue("i", pcpus->cpus->map[i]);
+	return Py_BuildValue("i", perf_cpu_map__cpu(pcpus->cpus, i).cpu);
 }
 
 static PySequenceMethods pyrf_cpu_map__sequence_methods = {
-- 
2.35.0.rc0.227.g00780c9af4-goog

