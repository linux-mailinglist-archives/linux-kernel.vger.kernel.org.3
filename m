Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37755584CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiG2HoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiG2HoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D37B37E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j4-20020a5b0304000000b00676ba2ed7e9so323155ybp.23
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=envuPbzzq2H54VKr3RstW6kg8N0kUvXDq8KS/IJYJi4=;
        b=oRwQiy17hOjBg79amu8cXv0HG3YS23fNp9hgX4XS6A3pX3ZvRQVEU3+98y70aFyWbQ
         3knxj5i78Ot4CR/NK5LytuHU6ia5SqlDgp4WKLsoyqk2HV3YMNCadVKE0aGhmW9Klgsz
         WT7Ozg6cYj4AAr5pD4BASrxxeA36XGonvNb4Hq6IA7XLE2uhUtQ3xprXG+MOXXRn+uon
         wlxC8z6+D640QlNVWRHrAlCeZA0aw3W5TGUUL199sGO8Rg0Ew4PyTFReek2ogfesAZ0f
         /9zKy6CsSJDOe7vqxxRNl7IBxDDYepJJkVmm77pUlaYFiPC/hDLDPoT5Ub0jRQvocfZg
         uakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=envuPbzzq2H54VKr3RstW6kg8N0kUvXDq8KS/IJYJi4=;
        b=rR23rwr9rlE0uNcyNjw7k0ry+9MG54LsgrVqcOD8crcQm5UQsTHmpSzNgbDzNZZIUr
         2WBdT+5gcof/Sv98CqhySpE+mCYyQcW5vfgLgYG+pHfrtten5jppzL5gZRQhmljkc8wD
         AyQnHf9sT5Yqzo0a3Cbbdxhgd8dSdXI2gTJD6cl6l5ZJKKgOkWzOF00W8kUwhGd76xIh
         m0UNZ0cUCtikHjdMSbmaI/c3ycOrO9iGu/FvIMNyGtJtJzVw3anEjUXQWaKisD3V5KIy
         N/hqViMAbQzuYCx/C3pS1tM3DZ7az8lIezsXNhY+R2StZslcMTCLR9qlgNzVAncv38VN
         mwgA==
X-Gm-Message-State: ACgBeo3pjd/yKwVEyEDUnuOkTJrcS5qTYah+YIqJcgA3VfcMPZKVb0Q2
        8GqEC2HDYM8R7FneePiepbzjpNTYFCCa
X-Google-Smtp-Source: AA6agR4cBEhcuit+eTvxeDSrr/fqU2sZZsNPKXEiBrGn3UWxvMJCZdiwO7Liknsg7sbmU0z0rRHmeY40o8Kh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a25:c1c6:0:b0:66f:5acc:7fb8 with SMTP id
 r189-20020a25c1c6000000b0066f5acc7fb8mr1570670ybf.634.1659080647103; Fri, 29
 Jul 2022 00:44:07 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:36 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-3-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 02/17] perf jevents: Simplify generation of C-string
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous implementation wanted variable order and '(null)' string output
to match the C implementation. The '(null)' string output was a
quirk/bug and so there is no need to carry it forward.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 5b72048d50da..cdfa4e0e7557 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -203,7 +203,7 @@ class JsonEvent:
     """Representation of the event as a C struct initializer."""
 
     def attr_string(attr: str, value: str) -> str:
-      return '\t.%s = \"%s\",\n' % (attr, value)
+      return f'\t.{attr} = \"{value}\",\n'
 
     def str_if_present(self, attr: str) -> str:
       if not getattr(self, attr):
@@ -211,17 +211,11 @@ class JsonEvent:
       return attr_string(attr, getattr(self, attr))
 
     s = '{\n'
-    for attr in ['name', 'event']:
-      s += str_if_present(self, attr)
-    if self.desc is not None:
-      s += attr_string('desc', self.desc)
-    else:
-      s += attr_string('desc', '(null)')
-    s += str_if_present(self, 'compat')
     s += f'\t.topic = "{topic_local}",\n'
     for attr in [
-        'long_desc', 'pmu', 'unit', 'perpkg', 'aggr_mode', 'metric_expr',
-        'metric_name', 'metric_group', 'deprecated', 'metric_constraint'
+        'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
+        'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
+        'name', 'perpkg', 'pmu', 'unit'
     ]:
       s += str_if_present(self, attr)
     s += '},\n'
-- 
2.37.1.455.g008518b4e5-goog

