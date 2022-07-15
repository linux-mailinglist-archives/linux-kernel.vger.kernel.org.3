Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3233575BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiGOGhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiGOGhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAA442AC8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m5-20020a2598c5000000b0066faab590c5so3303472ybo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I8mIXVo9Jr2k+tlsqaJg0nYaaYQybo0siO3CB03II98=;
        b=agKGOIE1vqPjt1tgqd8riMq+O+VFoi11uiX3rz3x8Jm+lIy4iadKYc3u30xQ+YSN5b
         PlepmeeZhyElM5S1c7iEPQA36JF5TderemYVFZqRAfi8zwefjKxI9QbyjsYdlnuAsBpY
         LrfjS9e8RGKVxPeUKva4IFt4BRv4lk2qxIUKBjo2hYJsur0cyVkISvNa1cMPSz4dNY6D
         AWbzJHUJ6553kNi39z2+D+lHExBkt4ycqqlGBP/3eKjW+0gqoL1n0aCkXrV6onAE1FVF
         Gwh1XqzEEoaBgYFcSWefu22J9nHLz6vZg74FF8ozFDtpJdOKy8hXyLsbw9Tq/hvaV2hA
         MD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I8mIXVo9Jr2k+tlsqaJg0nYaaYQybo0siO3CB03II98=;
        b=C90mesXTqtST17E25ZK/LamrYl75ZP32v2PmTGjzMib4Sr6RO2E4c/iaRDvd6O/usx
         jYuGgm8dKjTbgvetbgRBCNhMM2K6NRA2V8LUojVpqv7uBX4XsUsyODhT2BSq60M0ogCw
         3ICEmWL8nkoUMyEIXzuEWGqPh+BtAcuAqjtkYaMmJ9VtXcEmy8wPEwjsyLDfckTRgqv/
         oM9/QhARtyyVRdqSiupSPKjg9Qlr8HAcReHp2UX3pjWEiVmQHzRI0kBRFPKcwgw6awDA
         oFRK6z9j3Va5StLT7GH9rwhpuYzHmOjV7gFFxHHEXWFPp9CVdAgBfResYX34SaCg1edt
         4cbw==
X-Gm-Message-State: AJIora8gDhAx3Cwe2pmPRVsDGCC0pE+mmty+QbENxrzVJKtyvalEaBVt
        sPhWUHvPq3Rh04nF6XsnNyyLN4MCT9Ts
X-Google-Smtp-Source: AGRyM1vWw2+R3+LXTeD6M1RrxELOEjWl7BVzVgogGej1aWKtKZtiRk+SNJ4lUGbI/jz/nlU28rJ+WgAxmB9n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a25:730a:0:b0:66e:698b:37bd with SMTP id
 o10-20020a25730a000000b0066e698b37bdmr12397283ybc.485.1657867036179; Thu, 14
 Jul 2022 23:37:16 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:39 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-2-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 01/15] perf jevents: Simplify generation of C-string
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.37.0.170.g444d1eabd0-goog

