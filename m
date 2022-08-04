Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD958A325
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbiHDWSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbiHDWS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1226E2F8
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:18:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 137-20020a250b8f000000b0067a5a14d730so600026ybl.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=N++Mrhq6kQeFrF8RmnJUsnk+16Uv6ufZYhZg1IA0uDA=;
        b=TXD73nrJU+7eARBRcGR55uk4+DwtVJBAQxSiOVKpyhrRZ5RO7RndxUr8lO+mmzD4T2
         BrmRQ3He1TQzRs029LnPWblE5dDPet7+BdRpqE++iRb8WKUkWedWWxDuC9LNd6CK/9Ls
         XQzmnEiLmYEUmR6zXQxllkqPR7bc6ihVYbrExoW3EK5EzMwEL61px4MxFO9qSKyoPdeB
         vQYyXhVQEiRbh4P7lnLmVwTfQLwukDO+GiT0AcC+Usl7ncPvlPu6IuVxZQjwhoVd7KXU
         439AEoMLzX8I1tlwlwoC3jRIbz6ON9tce+YmPNEV4jmtBaGSTw0iXPfg1Pr7xiY5YobC
         HIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=N++Mrhq6kQeFrF8RmnJUsnk+16Uv6ufZYhZg1IA0uDA=;
        b=x9K7bN0TXdWNdtHcB1iC8D4qylrEnHyVGnqdy2GSuWZfZLDTzX81n8QGG0ry1Tlokj
         Ag4qdEr9ut8m4qrASsWBQlIM7eRhMr1XuUBGV28Jw19mS5+diXe1e8kWdrYU7y6+ioGE
         0bMnYLU+oWJi6DIL/gwMmjnYTAwZa3+kN+lxR8k2nQEC8QdfYfYU19d3G9GqpbDeuqWO
         tWY8orl/dutKTqNOsgSC6jp5uM/AQ3dgNLLFKvyYp2VUROK+6+2egGQMFz8wgOPZrLQY
         yzVzJVe75DcyDt1fHND6/qW35C/766pfKa5C8pjfD5c5QTmK6LPnhJWPBEka5rGhr85z
         9nbQ==
X-Gm-Message-State: ACgBeo05RSVafmR+Y6zTyxX/Gfx2bHKtRj5978mMfolLUB161TiKwX7A
        4Z2lCBLLORzNnaPgJIHZ5jd0A4xj8O32
X-Google-Smtp-Source: AA6agR6l2OkctpCBldtJSDt5KcZmeFaj7z6S97AUd0CAOBSyjbZU2NHKqPh/zAmXOFewOm+ciB+zYLxT+Eka
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:9b48:0:b0:67a:6ad0:f078 with SMTP id
 u8-20020a259b48000000b0067a6ad0f078mr3169103ybo.536.1659651508142; Thu, 04
 Aug 2022 15:18:28 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:01 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-3-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 02/17] perf jevents: Simplify generation of C-string
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
2.37.1.559.g78731f0fdb-goog

