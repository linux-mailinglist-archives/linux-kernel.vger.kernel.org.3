Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6E584839
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiG1W2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiG1W2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:28:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3479ECC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so2567677ybu.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4CGZU2uXLK2PaSFFyA3tf8AhfXerOJKdJKDdzQ2mdzo=;
        b=rt9iHBCL7xMr3W3MRZIdaADzrku9O2jgBaSOcgOi/UTMnhZwax0EHSOb3oPQb8gbJQ
         Ii3vgw5sKkAvuMKgZ/WAShLFNn47fgl4EX7x5+bqLUDVOUUKewDd20tSAbatPnufhtz/
         828fNy5tRx8m06i/LCli1UI8z4lsOhzavOgzlBdRfHDY45+MCSXGTfOYnnPzZvKYu2R1
         ML6O7ihLQTVwmqqADtcNkpOkyapfSTOlniyV35y2L2+RkJwP3D7AmBF1PiM/ZusaJTpR
         0nn+uoX3hqKrL6xbBnYuchWF1KcHcpcSwS1Rg0nhzuQxqt7Lp3TkFlYl/sTB8997eces
         xNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4CGZU2uXLK2PaSFFyA3tf8AhfXerOJKdJKDdzQ2mdzo=;
        b=h0AqpRsa6T2L3zclDt7URmHhiDQIEt1gSh98fGiDrNncwmzGJV/KKyDN4hjO1/AuG4
         iWl1eUSS/WhLvMm7560nBIAO3EL4vRxJfhTYLwGQfgQx6Wx5FgMgi6j7+LEtQUmBfQqA
         2kGqU4QoWVgfoEk0g6wZseGqcV49igvO+q6+va3J8L5Zrs7rWfgpHMjFG0mzI+aFZiei
         R520yCi+gSUiSjcEJZP3C+QG3By/nEw+f6BtJ+qdgDDK+OoSU+pn8pblQOJzCw7XyG+f
         m2CvHhNf+xfXcZaHZAUaPaziA0j/EfR+dWWAm0CeNuPFCw7NmfqeGdw+PyrLfW82TZeV
         +0PQ==
X-Gm-Message-State: ACgBeo3VL969iwPi/iYEW4EoyiqA5iiqrjSWrvyiiqDrbjA4dKthxgeG
        +avG8AEEXFsIZwXrb1GSFZSDEbmIeSVO
X-Google-Smtp-Source: AA6agR4pWuBlW9OnSQ4efp0vs53qzV+bMc5K6Weiu7sE8G5p1bG9y2QvXnG2YyKhxfRMmVG2Lv0ZP2IYOUon
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a05:6902:124c:b0:66e:d96f:2661 with SMTP
 id t12-20020a056902124c00b0066ed96f2661mr625180ybu.499.1659047322277; Thu, 28
 Jul 2022 15:28:42 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:20 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-2-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 01/16] perf jevents: Simplify generation of C-string
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 83e0dcbeac9a..4a170f23bd67 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -204,7 +204,7 @@ class JsonEvent:
     """Representation of the event as a C struct initializer."""
 
     def attr_string(attr: str, value: str) -> str:
-      return '\t.%s = \"%s\",\n' % (attr, value)
+      return f'\t.{attr} = \"{value}\",\n'
 
     def str_if_present(self, attr: str) -> str:
       if not getattr(self, attr):
@@ -212,17 +212,11 @@ class JsonEvent:
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

